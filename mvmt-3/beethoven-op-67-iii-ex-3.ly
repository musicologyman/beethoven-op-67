\version "2.24.0"
\include "../template-1.ly"

#(set! paper-alist (cons '("my size" . (cons (* 6 in) (* 3 in))) paper-alist))

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

circle =
  \once \override NoteHead.stencil = #(lambda (grob)
                                      (let* ((note (ly:note-head::print grob))
                                             (combo-stencil (ly:stencil-add
                                                             note
                                                             (circle-stencil note 0.1 0.8))))
                                        (ly:make-stencil (ly:stencil-expr combo-stencil)
                                          (ly:stencil-extent note X)
                                          (ly:stencil-extent note Y))))

global = {
  \key c \major
  \time 3/4
  \partial 4
}

right = \relative c {
  \clef bass
  \global
  \setAnalysisBracket #blue
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
  << { c'
       a d c
       b g e
       fis d fis
       g e gis
       a f! a
       b g }
     \new Staff \with {
       alignAboveContext = #"right"
     }{
      \clef bass
      \once \override TextScript.padding = #2.0
      a4 \f ^\markup \italic { violas and bassoons }
      fis8 g a d, e fis
      g fis g a b cis
      d2 c!4
      b g e'
      c a f'!
      d b
  } >>
}

\score {
  \new StaffGroup
  <<
    \new Staff = "right" \with {
      midiInstrument = "acoustic grand"
      instrumentName = " "
    } \right
  >>

  \layout { }
  \midi {
    \tempo 2.=80
  }
}
