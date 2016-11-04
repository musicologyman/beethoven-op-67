\include "../template-1.ly"

#(set! paper-alist (cons '("my size" . (cons (* 3.5 in) (* .75 in))) paper-alist))

%#(set-global-staff-size 11)

\paper {
  #(set-paper-size "my size" )
}

\layout {
  \context {
    \Staff
    \remove "Time_signature_engraver"
  }
}

colorNotes = #(define-music-function
               (parser location color notes)
               (color? ly:music?)
               #{
                  \override NoteHead #'color = #color
                  \override Stem #'color = #color
                  \override Beam #'color = #color
                  \override BarLine #'color = #color
                  \override Script #'color = #color
                  \override Tie #'color = #color
                  #notes
                  \revert NoteHead #'color
                  \revert Stem #'color
                  \revert Beam #'color
                  \revert BarLine #'color
                  \revert Script #'color
                  \revert Tie #'color
               #})

global = {
  \key c \minor
  \time 2/4
}

excerpt = \relative c'' {
  \global
  \once \override TextScript.transparent = ##t
  \colorNotes #(rgb-color 1.0 0 0.0) {
    r8 ^\markup {X} _\markup {Y} g8 \ff [g g] | es2 \fermata
  }
  \colorNotes #(rgb-color 1.0 0.0 1.0) {
    r8 f [f f] | d2 ~ d2 \fermata
  }

}

\score {
  <<
    \new Staff \with {
      midiInstrument = "acoustic grand"
      %\remove Time_signature_engraver
      instrumentName = " "
    } \excerpt
  >>

  \layout { }
  \midi {
    \tempo 2=80
  }
}
