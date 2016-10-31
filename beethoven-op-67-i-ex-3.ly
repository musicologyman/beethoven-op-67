\include "../template-1.ly"

\paper {
  indent = 0\mm
  line-width = 110\mm
  oddHeaderMarkup = ""
  evenHeaderMarkup = ""
  oddFooterMarkup = ""
  evenFooterMarkup = ""
}

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
     { \once \override TextScript.transparent = ##t
       s2 ^\markup {squirrels} s2 r8 es [es es] c2 } \\
     { s2 bes8\rest \stemUp aes [aes aes] \stemDown g2 ~ g2 } \\
     { \once \override TextScript.transparent = ##t
       \stemUp bes8\rest _\markup {squirrels} g \p [g g] \stemDown \tieDown es2 ~  es2 es2 }
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
    \tempo 2=100
  }
}
