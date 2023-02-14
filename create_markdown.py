import functools
import regex
import subprocess

from argparse import ArgumentParser
from pathlib import Path


def read_lines(p: Path):
    with p.open() as fp:
        return [line.rstrip() for line in fp]

def fix_include(p: Path):
    lines = read_lines(p)
    include_line = lines[1]
    if not regex.search(r'\\include "(../)+template-1.ly"', include_line):
        print(f'The second line of {p} does not include template-1.ly')
        return
    lines[1] = r'\\include "../template-1.ly"'
    with p.open(mode='w') as fp:
        for line in lines:
            print(line, file=fp)

def get_markdown_filename_from_parent_dir():
    return f'{Path.cwd()}.md'

def setup():
    parser = ArgumentParser()
    parser.add_argument('-t', '--title', default='Untitled')
    return parser.parse_args()

@functools.singledispatch
def convert_file(filename: str):
    cp = subprocess.run(['convert-ly', '-c', '-e', filename], 
                        capture_output=True,
                        encoding='utf-8')
    if cp.returncode != 0:
        print(f'convert-ly on {filename} failed with errors:')
        print(cp.stdout)
    else:
        print(f'converted {filename} successfully')

@convert_file.register
def _(p: Path):
    return convert_file(str(p))

@functools.singledispatch
def run_lilypond(filename: str):
    cp = subprocess.run(['lilypond', '--png', '-dresolution 300', filename])
    if cp.returncode != 0:
        print(f'lilypond "{filename}" failed with errors:')
        print(cp.stdout)
    else:
        print(f'lilypond "{filename}" ran successfully')

@run_lilypond.register
def _(p: Path):
    return run_lilypond(str(p))

def move_outputs(p: Path):
    png_file = p.with_suffix('.png')
    png_file.rename('images'/png_file)
    midi_file = p.with_suffix('.midi')
    midi_file.rename('images'/midi_file)

def main():
    args = setup()
    markdown_title = args.title
        
    lilypond_files = sorted(Path.cwd().glob("*.ly"))

    Path(Path.cwd() / 'images').mkdir(exist_ok=True)
    Path(Path.cwd() / 'midi').mkdir(exist_ok=True)

    for p in lilypond_files:
        fix_include(p)
        convert_file(p)
        run_lilypond(p)
        move_outputs(p)

    files = sorted(p for p in Path('./images/').iterdir() 
                   if p.is_file() and p.suffix=='.png')

    output_filename = get_markdown_filename_from_parent_dir()
    with open(output_filename, mode='w') as fp:
        printf = functools.partial(print, file=fp)
        printf("# {markdown_title}")
        for p in files:
            m = regex.search(r'ex-.+(?=\.png)', p.name)
            if m:
                title = m[0]
                printf()
                printf(f'## {title}')
                printf(f'![{p}]({p})')
            else:
                print(f'unable to match {p.name}')

if __name__ == '__main__':
    main()
