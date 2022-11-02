\version "2.22.0"
\include "../../template-1.ly"

#(set! paper-alist (cons '("my size" . (cons (* 3.8 in) (* .8 in))) paper-alist))

#(set-global-staff-size 15)

\paper {
  #(set-paper-size "my size" )
}

\layout {
  \context {
    \Staff
    \remove "Time_signature_engraver"
  }
}

global = {
  \key aes \major
  \time 3/8
}

right = \relative c' {
  \global
  \setAnalysisBracket #(rgb-color 0 0 0.6)
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/8)
  \set Timing.beatStructure = #'(3)
  \partial 8.
  aes'16 \p ^\markup \italic {violins} (c es)
  es (des) c8. [c16]
  c \cresc (bes) aes8. [aes16]
  g4 \f \tuplet 3/2 {g16 (aes bes) }
  aes8 \p 
}

\score {
  <<
    \new Staff = "right" \with {
      midiInstrument = "acoustic grand"
      %\remove Time_signature_engraver
      instrumentName = " "
    } \right
  >>

  \layout { }
  \midi {
    \tempo 8=100
  }
}
