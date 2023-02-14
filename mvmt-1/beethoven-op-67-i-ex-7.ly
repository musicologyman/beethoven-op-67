\version "2.24.0"
\include "../template-1.ly"

#(set! paper-alist (cons '("my size" . (cons (* 3 in) (* 1.25 in))) paper-alist))

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
  \time 2/4

}

right = \relative c''' {
  \global
  \setAnalysisBracket #blue
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/2)
  \set Timing.beatStructure = #'(2)
  << { r8 ^\markup \italic { right side up } g g f es2 s2 } \\
     { s2 r8 _\markup \italic {upside down } es, es f g2 } >>
  
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
    \tempo 2=80
  }
}
