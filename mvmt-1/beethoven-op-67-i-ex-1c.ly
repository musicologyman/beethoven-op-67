\version "2.24.0"

#(use-modules (guile-user))

\header {
  tagline = ##f
}

#(set! paper-alist (cons '("my size" . (cons (* 1.5 in) (* 1.2 in))) paper-alist))

%#(set-global-staff-size 11)

\paper {
  #(set-paper-size "my size" )
}


\layout {
  \context {
  }
}

global = {
  \key c \minor
  \time 4/4
}

%skipNoteColor = #(rgb-color 0.9 0.9 0.9)

excerpt = \relative c'' {
  \global
   \override Script.outside-staff-priority = #300
   \once \override NoteColumn.extra-offset = #'(200.0 . 0)
   g4
   \once \override NoteHead.color = #skipNoteColor
   \once \override Stem.color = #skipNoteColor
   \once \override TextScript.color = #skipNoteColor
   \once \override TextScript.rotation = #'(45 0 0)
   \once \override TextScript.Y-offset = #9
   \once \override TextScript.self-alignment-X = #0
   f
   ^\markup \center-column \italic { "skip" "this pitch" }
   es

}


\score {
  <<
    \new Staff \with {
      \remove Time_signature_engraver
      midiInstrument = "acoustic grand"
    } \excerpt
  >>

  \layout { }

}
