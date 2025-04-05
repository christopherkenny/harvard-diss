
#show: doc => article(
$if(title)$
  title: [$title$],
$endif$
$if(by-author)$
  authors: (
$for(by-author)$
$if(it.name.literal)$
    ( name: [$it.name.literal$],
      last: [$it.name.family$],
    $for(it.affiliations/first)$
    department: $if(it.department)$[$it.department$]$else$none$endif$,
    university: $if(it.name)$[$it.name$]$else$none$endif$,
    location: [$if(it.city)$$it.city$$if(it.country)$, $endif$$endif$$if(it.country)$$it.country$$endif$],
    $endfor$
    $if(it.email)$
      email: [$it.email$],
    $endif$
    $if(it.orcid)$
      orcid: "$it.orcid$"
    $endif$
      ),
$endif$
$endfor$
    ),
$endif$
$if(date)$
  date: [$date$],
$endif$
$if(lang)$
  lang: "$lang$",
$endif$
$if(region)$
  region: "$region$",
$endif$
$if(abstract)$
  abstract: [$abstract$],
  abstract-title: "$labels.abstract$",
$endif$
$if(margin)$
  margin: ($for(margin/pairs)$$margin.key$: $margin.value$,$endfor$),
$endif$
$if(papersize)$
  paper: "$papersize$",
$endif$
$if(mainfont)$
  font: ("$mainfont$",),
$endif$
$if(fontsize)$
  fontsize: $fontsize$,
$endif$
$if(section-numbering)$
  sectionnumbering: "$section-numbering$",
$endif$
$if(toc)$
  toc: $toc$,
$endif$
$if(toc-title)$
  toc_title: [$toc-title$],
$endif$
$if(toc-indent)$
  toc_indent: $toc-indent$,
$endif$
  toc_depth: $toc-depth$,
  cols: $if(columns)$$columns$$else$1$endif$,
$if(copyright-text)$
  copyright: "$copyright-text$",
$endif$
$if(dissertation-advisor)$
  dissertation-advisor: "$dissertation-advisor$",
$endif$
$if(degree-subject)$
  degree-subject: "$degree-subject$",
$endif$
$if(thanks)$
  thanks: [$thanks$],
$endif$
$if(dedication)$
  dedication: [$dedication$],
$endif$
$if(epigraph)$
  epigraph: [$epigraph$],
$endif$
$if(epigraph-author)$
  epigraph-author: [$epigraph-author$],
$endif$
$if(list-figures)$
  list-of-figures: $list-figures$,
$endif$
$if(list-tables)$
  list-of-tables: $list-tables$,
$endif$
  doc,
)
