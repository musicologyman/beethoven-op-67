\include "../template-1.ly"

#(set! paper-alist (cons '("my size" . (cons (* 6 in) (* 1 in))) paper-alist))

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
}

right = \relative c' {
  \global
  \setAnalysisBracket #(rgb-color 0 0 0.6)
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/8)
  \set Timing.beatStructure = #'(3)
  \partial 8.
  aes'16 \p ^\markup \italic {violins} (c es)
  es (des) c8. [c16]
  c \cresc (bes) aes8. [aes16]
  g4 \f \tuplet 3/2 {g16 \startGroup (aes bes) }
  aes8 \p \stopGroup r \tuplet 3/2 {g'16 \< \startGroup ^\markup \italic "flute" (aes bes)}
  aes8 \! \> \stopGroup r8
    \once \override TextScript.outside-staff-priority = #1000
    \tuplet 3/2  { g,16 \f \startGroup ^\markup \italic "violins" ([aes bes]) }
    
  \override NoteColumn.ignore-collision = ##t
  <<
    aes16 \stopGroup s16 s4
    \new Voice \with {
         \consists "Horizontal_bracket_engraver"
         \override HorizontalBracket.color = #(rgb-color 0 0 0.6)
         \override HorizontalBracket.thickness = #3.0
         \override HorizontalBracket.bracket-flare = #'(0.0 . 0.0)
         \override HorizontalBracket.padding = #1.0
         \override HorizontalBracket.outside-staff-priority = #300
         } { aes16 \startGroup r aes \p r aes r aes8 \stopGroup}
  >>
  \oneVoice 

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
    \tempo 8=100
  }
}
