\version "2.22.0"
\include "../../template-1.ly"

#(set! paper-alist (cons '("my size" . (cons (* 2 in) (* .75 in))) paper-alist))

%#(set-global-staff-size 11)


\layout {
  \context {
    \Staff
    \remove "Time_signature_engraver"
    \remove "Collision_engraver"
  }
}

global = {
  \key c \minor
  \time 2/4

}

right = \relative c'' {
  \global
  \setAnalysisBracket #blue
  <<
     \colorNotes #(rgb-color 1 0 1)
     { \override TextScript.transparent = ##t
       s2 ^\markup {squirrels} _\markup {squirrels}  s2 r8 es [es es] c2 s2 * 2
       r8 f ^\markup {X} [f f] d2 } \\
     \colorNotes #blue
     { s2 bes8\rest \stemUp aes [aes aes] \stemDown g2 s
       s bes8\rest \stemUp aes [aes aes] \stemDown g2 s } \\
     \colorNotes #(rgb-color 1 0 0)
     { \stemDown bes8\rest g \p [g g] es2 s2 * 2
       bes'8\rest g [g g] d2 s2 * 2}

  >>
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
