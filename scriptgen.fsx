open System
open System.IO

let formatter = 
    sprintf "lilypond --png -dresolution=1200 -danti-alias-factor=1 -e '(define skipNoteColor (rgb-color %0.1f %0.1f %0.1f))' --output=./png-temp/beethoven-op-67-i-ex-1c-%02d beethoven-op-67-i-ex-1c.ly"
    

// seq { 0.4 .. 0.05 .. 1.0 }
// |> Seq.map (fun f -> formatter 0. 0. f (int (f * 10.0)))
// |> (fun s -> File.WriteAllLines("skip-notes.sh", s))

let colors1 = 
    seq { 0.4 .. 0.05 .. 1.0 }
    |> Seq.map (fun f -> (0.33*f, 0.67*f, f))

let r1, g1 = 0.33, 0.67
let ri, gi = 1. - r1, 1. - g1
let ir, ig = ri / 10., gi / 10.

let colors2 = 
    seq { 0.0 .. 1.0 .. 10.0 }
    |> Seq.map (fun x -> (r1 + x * ir, g1 + x * ig, 1.0))

colors1 
|> Seq.append colors2
|> Seq.mapi (fun i (r, g, b) -> formatter r g b i)
|> (fun s -> File.WriteAllLines("skip-notes.sh", s))
