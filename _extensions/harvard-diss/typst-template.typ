
#let article(
  title: none,
  authors: none,
  date: datetime.today(),
  abstract: none,
  abstract-title: none,
  cols: 1,
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: (),
  fontsize: 11pt,
  sectionnumbering: none,
  toc: true,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  copyright: none,
  dissertation-advisor: none,
  degree-subject: none,
  thanks: none,
  dedication: none,
  epigraph: none,
  epigraph-author: none,
  list-of-figures: none,
  list-of-tables: none,
  doc,
) = {
  set page(
    paper: paper,
    margin: margin,
    numbering: "i",
  )

  show heading.where(level: 1): it => [
    #pagebreak(weak: true)
    #set text(rgb("A51C30"), weight: "bold", size: 2em, hyphenate: false)
    #set align(right)
    #text(counter(heading).display(it.numbering), size: 3em)
    #linebreak()
    #smallcaps(it.body)
  ]

  set par(justify: true)

  set text(
    lang: lang,
    region: region,
    font: font,
    size: fontsize,
  )

  set heading(numbering: sectionnumbering)

  page(
    [
      #set align(center)

      #if title != none {
        set par(justify: false)
        align(center)[#block(inset: 1em)[
            #text(
              rgb("A51C30"),
              weight: "bold",
              size: 3em,
              hyphenate: false,
            )[#title #label("title")]
          ]]
      }

      #v(4fr)

      #if authors != none {
        upper("A dissertation presented")
        linebreak()
        upper("by")
        linebreak()
        upper(authors.first().name)
        linebreak()
        upper("to")
        linebreak()
        smallcaps(authors.first().department)

        v(2em)

        upper([
          In partial fulfillment of the requirements \
          for the degree of \
        ])
        smallcaps("Doctor of Philosophy")
        linebreak()
        upper("in the subject of")
        linebreak()
        upper(degree-subject)

        v(2em)

        smallcaps(authors.first().university)
        linebreak()
        smallcaps(authors.first().location)
        linebreak()
      }

      #if date != none {
        date.display("[month repr:long] [year]")
      }

      #v(1fr)
    ],
    numbering: none,
  )

  if copyright != none {
    page(
      [
        #set align(left + horizon)
        #set par(leading: 0.65em)
        #copyright<copyright>
      ],
      numbering: none,
    )
  }

  if abstract != none {
    set page(header: [
      Dissertation advisor: #dissertation-advisor
      #h(1fr)
      #authors.first().name
    ])

    set par(justify: false)
    align(center)[
      #text(
        rgb("A51C30"),
        weight: "bold",
        size: 1.75em,
        hyphenate: false,
      )[#title]
    ]

    align(center)[
      #block(inset: 1em)[
        #smallcaps(
          text(
            weight: "semibold",
            size: 1.25em,
          )[#abstract-title #label("abstract")],
        )
      ]
    ]

    align(left)[
      #set par(
        first-line-indent: 1em,
        leading: 2 * 0.65em,
      )
      // typst > 0.13, remove the #h()
      #h(1em) #abstract
    ]
  }
  set page(header: none)
  pagebreak()

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }

    block(above: 1em, below: 2em)[
      #set par(leading: 2 * 0.65em)
      #v(5em)
      #align(right)[#text(
          rgb("A51C30"),
          weight: "bold",
          size: 3em,
          hyphenate: false,
        )[#toc_title #label("toc")]]

      #context {
        let custom_labels = (
          "title",
          "copyright",
          "abstract",
          "toc",
          "thanks",
          "dedication",
          "epigraph",
          "list-fig",
          "list-tab"
        )
        let custom_text = (
          "Title Page",
          "Copyright",
          "Abstract",
          "Table of Contents",
          "Acknowledgements",
          "Dedication",
          "Epigraph",
          "List of Figures",
          "List of Tables"
        )

        for i in array.range(custom_labels.len()) {
          let lbl = label(custom_labels.at(i))

          // if a label isn't used, skip it.
          // allows pieces to be missing (e.g. no abstract yet)
          if (query(lbl).len() == 0) {
            continue
          }

          let loc = locate(lbl)
          // in typst > 0.13, this should be simplified
          let num = numbering("i", loc.page())
          [#smallcaps(custom_text.at(i)) #box(width: 1fr, repeat[.]) #num \ ]
        }

        let chapters = query(
          heading.where(
            level: 1,
            outlined: true,
          ),
        )

        for chapter in chapters {
          let loc = chapter.location()
          let num = numbering(
            loc.page-numbering(),
            ..counter(page).at(loc),
          )
          [#smallcaps(chapter.body) #box(width: 1fr, repeat[.]) #num \ ]
        }
      }
    ]

    pagebreak()
  }

  // FRONTMATTER ----
  // citations to previous work
  // acknowledgements "thanks"
  if thanks != none {
    v(5em)
    align(right)[
      #text(
        rgb("A51C30"),
        weight: "bold",
        size: 3em,
        hyphenate: false,
      )[Acknowledgements #label("thanks")]]
    linebreak()
    thanks
    pagebreak()
  }

  // list of figures
  if list-of-figures != none and list-of-figures {
    align(right)[
      #text(
        rgb("A51C30"),
        weight: "bold",
        size: 3em,
        hyphenate: false,
      )[List of Figures #label("list-fig")]]
    linebreak()

    outline(
      title: none,
      target: figure.where(kind: "quarto-float-fig"),
    )

    pagebreak()
  }

  // list of tables
    if list-of-tables != none and list-of-tables {
    align(right)[
      #text(
        rgb("A51C30"),
        weight: "bold",
        size: 3em,
        hyphenate: false,
      )[List of Tables #label("list-tab")]]
    linebreak()

    outline(
      title: none,
      target: figure.where(kind: "quarto-float-tbl"),
    )

    pagebreak()
  }

  // glossary
  // epigraph
  if epigraph != none {
    v(5em)
    align(right)[
      #text(
        rgb("A51C30"),
        weight: "bold",
        size: 3em,
        hyphenate: false,
      )[Epigraph #label("epigraph")]]
    linebreak()
    show text: emph
    align(right, block(align(left)[
      #epigraph
    ]))
    align(right)[--- #epigraph-author]
    pagebreak()
  }

  // dedication
  if dedication != none {
    v(5em)
    align(right)[
      #text(
        rgb("A51C30"),
        weight: "bold",
        size: 3em,
        hyphenate: false,
      )[Dedication #label("dedication")]]
    linebreak()
    show text: emph
    dedication
    pagebreak()
  }


  // The rest of the doc
  set page(numbering: "1")
  counter(page).update(1)

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }

  // BACKMATTER ----
}

#set table(
  inset: 6pt,
  stroke: none,
)
