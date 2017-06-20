\include "../../template-1.ly"

#(set! paper-alist (cons '("my size" . (cons (* 7 in) (* 2 in))) paper-alist))

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

right = \relative c'' {
  \global
  \setAnalysisBracket #blue
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/2)
  \set Timing.beatStructure = #'(2)
  \partial 4.
  <<
     {
     \override TextScript.outside-staff-priority = #1000
     s4. ^\markup \italic "(sounds an octave higher than written)" }
     \\
     {
     \colorNotes #(rgb-color 0 0.6 0)
     {
       \greenText
       \once \override TextScript.X-offset = #-8.0
         g8 \p _\markup \italic {violins} g a
       bes4 s
       s8 fis a bes
       c4 s4
       s8 fis,8 a bes
       c4 s4
       s8 g bes c
       d4 s }
       s8 \blackText g, _\markup \italic "cresc." bes c
     }
     \\
     \colorNotes #(rgb-color 0 0 0.8)
      { s4.
       s8 \blueText g ^\markup \italic "woodwinds" a bes
       c4 s
       s8 fis, a bes
       c4 s
       s8 a bes c
       d4 s
       s8 g, bes c
       d4 s
     }
     >>
     d8 bes c d
     es \f es es es
     es es es es
     es4 r


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
