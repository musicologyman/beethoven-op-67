\version "2.24.0"

\include "../../lilypond-page-sizes/paper-sizes.ily"

\header {
  tagline = ##f 
}

\paper {
  #(set-paper-size "size 5-1")
  indent = 0 \in
}


piuF = \markup { \normal-text \italic "più" \dynamic f } 
piuFDynamic  = #(make-dynamic-script piuF)


closing = \relative g'' {
   \key c \major
   \time 4/4
   g2. \f fis4 |
   e d d d |
   g2. \mf fis4 |
   e d d d |
   c'2. \sf b4 |
   a aes \piuFDynamic aes aes |
   \once \override TextScript.Y-offset = #-0.5
   \stopStaff s32 -\markup \italic "etc."
}

\score {
   \new Staff \closing
   \layout {
     \context {
       \Staff
       \remove Time_signature_engraver
     }
   }
}