\version "2.22.0"
\include "../template-1.ly"

#(set! paper-alist (cons '("my size" . (cons (* 1.5 in) (* 1.2 in))) paper-alist))

%#(set-global-staff-size 11)

\paper {
  #(set-paper-size "my size" )
}


\layout {
  \context {
  }
}

global = {
  \key c \minor
  \time 4/4
}

excerpt = \relative c'' {
  \global
   \override Script #'outside-staff-priority = #300
   \once \override NoteColumn #'extra-offset = #'(200.0 . 0)
   g4
   \once \override NoteHead #'color = #(rgb-color 0 0 1)
   \once \override Stem #'color = #(rgb-color 0 0 1)
   \once \override TextScript #'color = #(rgb-color 0 0 1)
   \once \override TextScript #'rotation = #'(45 0 0)
   \once \override TextScript #'Y-offset = #9
   \once \override TextScript #'X-offset = #-3
   f
   ^\markup \center-column \italic { "skip" "this pitch" }
   es

}


\score {
  <<
    \new Staff \with {
      \remove Time_signature_engraver
      midiInstrument = "acoustic grand"
    } \excerpt
  >>

  \layout { }
  \midi {
    \tempo 2=80
  }
}
