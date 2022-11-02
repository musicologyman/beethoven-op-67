\version "2.22.0"
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
 
  es16. \p _\markup \italic { dolce } ^\markup \italic { violas and cellos } (aes32)
  c8-. c16. (bes32 aes16. c32)
  f,8 ~ f16. [(a32 bes16. c32)]
  des16. (c32 bes16. des32 g,16. bes32)
  e,16. (g32) c8 ~ [(c16. bes32)]
  a16. (f32) bes8. [(des16)]
  g,16. (es32) aes!8 [aes16. (c32)]
  es4. \f
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
    \tempo 2=80
  }
}
