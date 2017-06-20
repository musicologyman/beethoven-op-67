\include "../../template-1.ly"

#(set! paper-alist (cons '("my size" . (cons (* 6 in) (* 1.5 in))) paper-alist))

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
  \partial 8
}

excerpt = \relative c {
  \clef bass
  \global
  \setAnalysisBracket #(rgb-color 0 0 0.6)
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/8)
  \set Timing.beatStructure = #'(3)

  <<
    {
      es16. ^\markup \italic { violas and cellos } \p _\markup \italic dolce (aes32)
      c8 -. [c16. (bes32 aes16. c32) ]
      f,8 ~ f16. ([a32 bes16. c32])
      des16. (c32 bes16. des32 g,16. bes32)
      e,16. ([g32]) c8 ~ c16. s32
      \bar " "
    }
    \new Staff \with {
      \remove Clef_engraver
      \remove Staff_performer } {
      \stopStaff
      \repeat unfold 2 {
        s8
        \once \override TextScript.Y-offset = #-6.0
        c _\markup { \center-column \italic { "Three short notes" "and a long note"} } c c
        c4 }
    }
  >>
}

\score {
  <<
    \new Staff = "excerpt" \with {
      midiInstrument = "acoustic grand"
      \remove Time_signature_engraver
      instrumentName = " "
    } \excerpt
  >>

  \layout { }
  \midi {
    \tempo 8=100
  }
}
