\version "2.22.0"
\include "../template-1.ly"

#(set! paper-alist (cons '("my size" . (cons (* 6 in) (* .9 in))) paper-alist))

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
  bes2 \ff ~
  bes8 c-. bes-. aes!-.
  aes (g) f-. es-.
  es (d) c-. d-.
  f (es) bes-. g-.
  d' (c) aes-. f-.
  c' (bes) f-. d-.
  bes \stopStaff
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
