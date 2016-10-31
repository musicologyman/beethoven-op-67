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
  }
}

global = {
  \key c \minor
  \time 2/4

}

right = \relative c'' {
  \global
  \setAnalysisBracket #blue
  \override HorizontalBracket.padding = #2.0
  r8 g8 \startGroup \ff [g g] | es2 \fermata \stopGroup
  r8 f \startGroup [f f] | d2 \stopGroup ~ d2 \fermata
}


\include "../template-2.ly"
