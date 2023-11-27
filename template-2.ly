\version "2.24.3"
\score {
  <<
    \new Staff = "right" \with {
      midiInstrument = "acoustic grand"
      %\remove Time_signature_engraver
    } \right
  >>

  \layout { }
  \midi {
    \tempo 4=100
  }
}
