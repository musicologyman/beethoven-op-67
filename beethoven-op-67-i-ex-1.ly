\include "../template-1.ly"

\paper {
  indent = 0\mm
  line-width = 110\mm
  oddHeaderMarkup = ""
  evenHeaderMarkup = ""
  oddFooterMarkup = ""
  evenFooterMarkup = ""
}

%#(set-global-staff-size 15)

%{
#(set! paper-alist (cons '("my size" . (cons (* 7 in) (* 3 in))) paper-alist))

\paper {
  #(set-paper-size "my size" )
}
%}

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
  r8 g \ff [g g] | es2 \fermata
}


\include "../template-2.ly"
