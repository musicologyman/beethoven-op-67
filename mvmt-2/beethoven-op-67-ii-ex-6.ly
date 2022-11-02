\version "2.22.0"
\include "../../template-1.ly"

#(set! paper-alist (cons '("my size" . (cons (* 7 in) (* 1.5 in))) paper-alist))

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
  \set Timing.beatStructure = 1,1,1
  \once \override TextScript.X-offset = #2.5
  \once \override TextScript.padding = #1
  es32 \p _\markup \italic { dolce } ^\markup \italic { violas and cellos } 
    (g aes bes)
  c (bes aes g aes bes aes g aes bes c aes)
  f (g f e f a bes a bes c des c)
  des (c des c bes des aes! des g, des' f, des')
  e, (g a b c g a b c g c bes)
  a (c f, c' bes des f, des' bes des aes! des)
  g, (bes es, bes' aes c es, c' aes c es, c')
  g \pp (es' bes es g, es' bes es g, es' bes es)
  c8 s16 \bar " "
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
