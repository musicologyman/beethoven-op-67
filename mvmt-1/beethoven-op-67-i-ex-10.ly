\version "2.24.0"
\include "../template-1.ly"

#(set! paper-alist (cons '("my size" . (cons (* 3 in) (* 2 in))) paper-alist))

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
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/2)
  \set Timing.beatStructure = #'(2)

}

right = \relative c'' {
  \global
  \setAnalysisBracket #blue
  << { s2 * 4 ^\markup \italic violins } \\
     { 
       \slurUp
       \once \override TextScript.X-offset = #2
       \once \override TextScript.extra-offset = #'(0 . -1.0)
       bes4 \p _\markup \italic {dolce} (es d es f c) c (bes) } >>
  
}

left = \relative c {
  \clef bass
  \global
  R2 * 2
  r8 bes \p ^\markup \italic { cello and bass } bes bes es4 r
}

\score { 
  <<
    \new Staff = "right" \with {
      midiInstrument = "acoustic grand"
    } \right
    \new Staff = "left" \with {
      midiInstrument = "acoustic grand"
    } \left
  >>

  \layout { }
  \midi {
    \tempo 2=70
  }
}
