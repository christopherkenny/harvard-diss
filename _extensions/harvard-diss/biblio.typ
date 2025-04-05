$if(citations)$
$if(csl)$

#set bibliography(style: "$csl$")
$elseif(bibliographystyle)$

#set bibliography(
  style: "$bibliographystyle$"
)
$endif$
$if(bibliography)$

#set bibliography(
  title: "$biblio-title$"
)

#bibliography($for(bibliography)$"$bibliography$"$sep$,$endfor$)
$endif$
$endif$
