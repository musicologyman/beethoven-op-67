\version "2.24.0"
\\include "../template-1.ly"

#(set! paper-alist (cons '("my size" . (cons (* 5 in) (* 1 in))) paper-alist))

#(set-global-staff-size 15)

\paper {
  #(set-paper-size "my size" )
}

\layout {
  \context {
    \Staff

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
  \partial 4
}

right = \relative c {
  \clef bass
  \global
  \setAnalysisBracket #blue
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
  \set Timing.beatStructure = #'(3)
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
    \tempo 2.=80
  }
}
