\version "2.24.0"
\include "../template-1.ly"

#(set! paper-alist (cons '("my size" . (cons (* 4 in) (* 1 in))) paper-alist))

%#(set-global-staff-size 11)
\paper {
  #(set-paper-size "my size")
  indent = 0 \in
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
  \override HorizontalBracket.to-barline = ##t
  r8 g8 \startGroup \ff [g g] | es2 \fermata \stopGroup
  r8 f \startGroup [f f] | d2 ~ d2 \fermata \stopGroup 
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
