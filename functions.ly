\version "2.24.3"

\header {
  tagline = ##f
}

\layout {
  indent = 0 \in
  \context {
    \Score \remove "Bar_number_engraver"
  }
  \context {
    \Staff \RemoveEmptyStaves
  }
  \context {
    \Voice
    \consists "Horizontal_bracket_engraver"
  }
}

colorNotes = #(define-music-function
               (color notes)
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
                 (notes)
                 (ly:music?)
                 #{
                   \colorNotes #red #notes
                 #})

setAnalysisBracket = #(define-music-function
                       (color)
                       (color?)
                       #{
                          \override HorizontalBracket.direction = #UP
                          \override HorizontalBracket.color = #color
                          \override HorizontalBracket.thickness = #3.0
                          \override HorizontalBracket.bracket-flare = #'(0.0 . 0.0)
                          \override HorizontalBracket.padding = #1.0
                       #})

setAnalysisBracketDown = #(define-music-function
                       (color)
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
