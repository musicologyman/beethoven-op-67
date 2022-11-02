\version "2.22.0"
\include "../../template-1.ly"

#(set! paper-alist (cons '("my size" . (cons (* 4 in) (* .75 in))) paper-alist))

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
  \key c \minor
  \time 3/4
}

right = \relative c'' {
  \global
  \setAnalysisBracket #blue
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
  \set Timing.beatStructure = #'(3)
  g \ff ^\markup \italic horns g g
  g2.
  g4 g g
  g2.
  g4 g g
  g2.
  bes4 (aes) g-.
  f2.
}

\score {
  <<
    \new Staff = "right" \with {
      midiInstrument = "acoustic grand"
      instrumentName = " "
    } \right
  >>

  \layout { }
  \midi {
    \tempo 2.=92
  }
}
