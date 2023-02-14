\version "2.24.0"
\include "../template-1.ly"

#(set! paper-alist (cons '("my size" . (cons (* 2 in) (* 1 in))) paper-alist))

%#(set-global-staff-size 11)

\paper {
  #(set-paper-size "my size" )
}


\layout {
  \context {
    \Voice \with {
     \consists Horizontal_bracket_engraver
    }
  }
}

setBracket = #(define-music-function
               (direction color thickness)
               (integer? color? number?)
               #{
                 \override HorizontalBracket.bracket-flare = #'( 0 . 0 )
                 \override HorizontalBracket.color = #color
                 \override HorizontalBracket.direction = #direction
                 \override HorizontalBracket.thickness = #thickness
               #})

global = {
  \key c \minor
  \time 2/4
}

excerpt = \relative c'' {
  \global
   \setBracket #UP #blue #3.0
   \override Script.outside-staff-priority = #300
   r8 g \ff [g
     \once \override TextScript.color = #blue
     g\startGroup ^\markup \italic "skip" ]
   es2 \stopGroup

}


\score {
  <<
    \new Staff \with {
      midiInstrument = "acoustic grand"
    } \excerpt
  >>

  \layout { }
  \midi {
    \tempo 2=80
  }
}
