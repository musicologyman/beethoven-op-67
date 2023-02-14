\version "2.24.0"
\include "../template-1.ly"

#(set! paper-alist (cons '("my size" . (cons (* 4 in) (* 1.5 in))) paper-alist))

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

excerpt = \relative c' {
  \global
  \setAnalysisBracket #(rgb-color 0 0 0.6)
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/8)
  \set Timing.beatStructure = #'(3)

  <<
    {
      es16. ^\markup \italic clarinet _\markup \italic dolce (g32)
      aes8 aes (bes
      c4)  aes16. (bes32)
      c8  c (des
      es4)  }
    \new Staff \with {
      \remove Clef_engraver
      \remove Staff_performer } {
      \stopStaff
      \repeat unfold 2 {
        s8
        \once \override TextScript.Y-offset = #-6.0
        \override NoteHead.transparent = ##t
        \override Stem.transparent = ##t
        \override Beam.transparent = ##t
        \override TextScript.transparent = ##t
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
