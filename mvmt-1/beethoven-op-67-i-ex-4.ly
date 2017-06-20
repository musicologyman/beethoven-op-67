\include "../../template-1.ly"

#(set! paper-alist (cons '("my size" . (cons (* 6.5 in) (* 2.5 in))) paper-alist))

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
  <<
    \colorNotes #(rgb-color 0 0.6 0)
    { \override TextScript.transparent = ##t
      bes,8\rest ^\markup {squirrels} g' g
      \revert TextScript.transparent
      \once \override TextScript.rotation = #'(45 0 0)
      \once \override TextScript.color = #(rgb-color 0 0.6 0)
      \once \override TextScript.Y-offset = #12
      \once \override TextScript.X-offset = #-1
      \circle f ^\markup { \center-column { \italic { "fill in" "the pitch!" } } }
      es2
      (d8) g g f
      es2
      (d8)
    } \\
    \colorNotes #(rgb-color 0 0 0.6)
    { s2
      r8 es, es
      \once \override TextScript.rotation = #'(-45 0 0)
      \once \override TextScript.color = #(rgb-color 0 0 0.6)
      \once \override TextScript.Y-offset = #-7
      \once \override TextScript.X-offset = #-1
        \circle f _\markup { \center-column { \italic { "fill in" "the pitch!" } } }
      g2 ~
      g8 es [es f]
      g }
  >>
  \override TextScript.transparent = ##t
  g'8 \f [g f]
  es4 r
  c r
  g'2 \fermata
  \stopStaff
  s2
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
