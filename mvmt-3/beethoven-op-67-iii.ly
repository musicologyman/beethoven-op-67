\version "2.24.3"

\header {
  tagline = ##f
}

#(set-global-staff-size 15)

global = {
  \key c \minor
  \time 3/4
  \partial 4
}

exampleI = \relative c {
  \clef bass
  \global
  g4 \pp ^\markup \italic { cellos and basses }
  (c es g
  c2 es4
  d2 fis,4)
  g2.
  \clef treble
  g'2 \pp ^\markup \italic violins (b4
  c2 d4)
  f2-. ^\markup \italic "poco ritard." (es4-.)
  d2. \fermata
}

\book {
  \bookOutputName "beethoven_5th_3rd_mvmt_ex_01"
  \paper {
    #(set-paper-size '(cons (* 5 in) (* 1 in)))
    indent = 0
  }
  \score {
    <<
      \new Staff \exampleI
    >>
    \layout { }
    \midi {
      \tempo 2.=80
    }
  }
}

exampleII = \relative c'' {
  \global
  \partial 2.
  g4 \ff ^\markup \italic horns g g
  g2.
  g4 g g
  g2.
  g4 g g
  g2.
  bes4 (aes) g-.
  f2.
}

\book {
  \bookOutputName "beethoven_5th_3rd_mvmt_ex_02"
  \paper {
    #(set-paper-size '(cons (* 4 in) (* 1.00 in)))
    indent = 0
  }
  \score {
    <<
      \new Staff \with { \remove Time_signature_engraver} \exampleII
    >>
    \layout { }
    \midi {
      \tempo 2.=80
    }
  }
}

exampleIII = \relative c {
  \clef bass
  \global
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
  \set Timing.beatStructure = #'(3)
  c4 \f ^\markup \italic { cellos and basses }
  b8 c d g, a b
  c b c d e f
  g2 f4
  e c a'
  f d b' \break
  \overrideProperty Score.NonMusicalPaperColumn.line-break-system-details
  #'((Y-offset . 20))
  g e
  <<
    {
      c'
      a d c
      b g e
      fis d fis
      g e gis
      a f! a
      b g
    }
    \new Staff \with {
      alignAboveContext = #"exampleIII"
    } {
      \textMark \markup \with-color #red 
        \bold \column { \line { TO-DO: Adjust so that clef }
                        \line { does not force extra spacing }
                        \line { in the staff below } }
      \clef bass
      \set Timing.beamExceptions = #'()
      \set Timing.baseMoment = #(ly:make-moment 1/4)
      \set Timing.beatStructure = #'(3)
      \time 3/4
      \partial 4
      \once \override TextScript.padding = #2.0
      a4 \f ^\markup \italic { violas and bassoons }
      fis8 g a d, e fis
      g fis g a b cis
      d2 c!4
      b g e'
      c a f'!
      d b
    }
  >>
}

\book {
  \bookOutputName "beethoven_5th_3rd_mvmt_ex_03"
  \paper {
    #(set-paper-size '(cons (* 6 in) (* 3 in)))
    indent = 0
  }
  \score {
    <<
      \new Staff = "exampleIII" \exampleIII
    >>
    \layout {
      \context {
        \Score
        \remove Timing_translator
      }
      \context {
        \Staff
        \remove Time_signature_engraver
        \consists Timing_translator
      }
    }
    \midi {
      \tempo 2.=80
    }
  }
}
