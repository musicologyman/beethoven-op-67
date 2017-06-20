\version "2.18.2"

\header {
  % Remove default LilyPond tagline
  tagline = ##f
  %ragged-right = ##t
  %ragged-last = ##t
}



\layout {
  indent = 0 \in
  \context {
    \Score \remove "Bar_number_engraver"
  }
}

\layout {
  \context {
    \Staff \RemoveEmptyStaves
  }
}

global = {
  \key a \major
  \time 4/4
}

\layout {
  \context {
    \Voice
    \consists "Horizontal_bracket_engraver"
  }
}

colorNotes = #(define-music-function
               (parser location color notes)
                 (color? ly:music?)
                 #{
                   \override NoteHead.color = #color
                   \override Stem.color = #color
                   \override Beam.color = #color
                   \override Dots.color = #color
                   \override Slur.color = #color
                   \override Tie.color = #color
                   \override Accidental.color = #color
                   \override Rest.color = #color
                   #notes
                   \revert NoteHead.color
                   \revert Stem.color
                   \revert Beam.color
                   \revert Dots.color
                   \revert Slur.color
                   \revert Tie.color
                   \revert Accidental.color
                   \revert Rest.color
                 #})

turnNotesRed = #(define-music-function
                 (parser location notes)
                 (ly:music?)
                 #{
                   \colorNotes #red #notes
                 #})

setAnalysisBracket = #(define-music-function
                       (parser location color)
                       (color?)
                       #{
                          \override HorizontalBracket.direction = #UP
                          \override HorizontalBracket.color = #color
                          \override HorizontalBracket.thickness = #3.0
                          \override HorizontalBracket.bracket-flare = #'(0.0 . 0.0)
                          \override HorizontalBracket.padding = #1.0
                       #})

setAnalysisBracketDown = #(define-music-function
                       (parser location color)
                       (color?)
                       #{
                          \override HorizontalBracket.direction = #DOWN
                          \override HorizontalBracket.color = #color
                          \override HorizontalBracket.thickness = #3.0
                          \override HorizontalBracket.bracket-flare = #'(0.0 . 0.0)
                          \override HorizontalBracket.padding = #1.0
                          \override HorizontalBracket.outside-staff-priority = #1000
                       #})

blueText = \override TextScript.color = #(rgb-color 0 0 0.8)
greenText = \override TextScript.color = #(rgb-color 0 0.6 0)
blackText = \override TextScript.color = #(rgb-color 0 0 0)
