\include "../../template-1.ly"

#(set! paper-alist (cons '("my size" . (cons (* 7 in) (* 1 in))) paper-alist))

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
  \key aes \major
  \time 3/8
  \partial 8
}

right = \relative c {
  \clef bass
  \global
  \setAnalysisBracket #blue
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/8)
  \set Timing.beatStructure = #'(3)
  \once \override TextScript.X-offset = #2.5
  \once \override TextScript.padding = #1
  es16 \p _\markup \italic { dolce } ^\markup \italic { violas and cellos } (aes
  c bes aes g aes c)
  f, (a bes a bes c)
  des (c bes des g, bes)
  e, (g c g c bes)
  a (f bes c des bes)
  g (es \grace bes' aes! g aes c)
  d \f (es f es d es)
  c8 \p
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
    \tempo 8=110
  }
}
