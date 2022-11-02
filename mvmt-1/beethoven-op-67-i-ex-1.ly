\version "2.22.0"
\include "../template-1.ly"

#(set! paper-alist (cons '("my size" . (cons (* 2 in) (* .75 in))) paper-alist))

%#(set-global-staff-size 11)


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
  \once \override TextScript.transparent = ##t
  r8 ^\markup {X} _\markup {X} g \ff [g g] | es2 \fermata
  \stopStaff
  \s2
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
