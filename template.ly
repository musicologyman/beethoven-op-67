\version "2.22.0"
\include "template-1.ly"

#(set-global-staff-size 15)


#(set! paper-alist (cons '("my size" . (cons (* 7 in) (* 3 in))) paper-alist))

\paper {
  #(set-paper-size "my size" )
}

\layout {
  \context {
    \Staff
    \remove "Time_signature_engraver"
  }
}

global = {
  \key a \major
  \time 4/4
}

right = \relative c''' {
  \global
  \setAnalysisBracket
  % insert music here
}


\include "template-2.ly"
