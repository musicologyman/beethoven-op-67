# coding: utf-8
from pathlib import Paht
from pathlib import Path
lilypond_files = sorted(Path.cwd().glob("*.ly"))
lilypond_files
def fix_include(p: Path):
    with p.open() as fp:
        lines = [line.rstrip() for line in fp]
    lines[1] = r'\include "../template-1.ly"'
    with p.open(mode='w') as fp:
        for line in lines:
            print(line, file=fp)
            
get_ipython().run_line_magic('whos', '')
import shutil
lilypond_files
shutil.copy(lilypond_files[0], "test.ly")
head -n 2 test.ly | tail -1
get_ipython().system(' head -n 2 test.ly | tail -1')
get_ipython().run_line_magic('whos', '')
fix_include('test.ly')
fix_include(Path('test.ly'))
get_ipython().system(' head -n 2 test.ly | tail -1')
get_ipython().system('rm test.ly')
for p in lilypond_files:
    fix_include(p)
    
