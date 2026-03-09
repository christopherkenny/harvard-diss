
#let ch-header(ttl, lbl) = {
  v(5em)
  set par(leading: 0.65em, justify: false)
  align(right)[
    #text(
      rgb("A51C30"),
      weight: "bold",
      size: 3em,
      hyphenate: false,
    )[#ttl #label(lbl)]]
  linebreak()
}

#let to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(to-string).join("")
  } else if content.has("body") {
    to-string(content.body)
  } else if content == [ ] {
    " "
  }
}


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
  linestretch: 1,
  linkcolor: "#800000",
  copyright: none,
  dissertation-advisor: none,
  degree-subject: none,
  previous-work: none,
  thanks: none,
  dedication: none,
  epigraph: none,
  epigraph-author: none,
  list-of-figures: none,
  list-of-tables: none,
  blinded: false,
  doc,
) = {

  if type(date) == content {
    date = to-string(date)
    date = str(date).split("-").map(int)
    date = datetime(year: date.at(0), month: date.at(1), day: date.at(2))
  }
  set page(
    paper: paper,
    margin: margin,
    numbering: "i",
  )

  show heading.where(level: 1): it => [
    #counter(figure.where(kind: "quarto-float-fig")).update(0)
    #counter(figure.where(kind: "quarto-float-tbl")).update(0)

    #pagebreak(weak: true)
    #set text(rgb("A51C30"), weight: "bold", size: 2em, hyphenate: false)
    #set par(leading: 0.65em, justify: false)
    #set align(right)
    #if it.numbering != none {
      text(counter(heading).display(it.numbering), size: 3em)
    } else {
      v(3em)
    }
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

  show link: this => {
    if type(this.dest) != label {
      text(this, fill: rgb(linkcolor.replace("\\#", "#")))
    } else {
      text(this, fill: rgb("#0000CC"))
    }
  }

  show ref: this => {
    text(this, fill: rgb("#640872"))
  }

  show cite.where(form: "prose"): this => {
    text(this, fill: rgb("#640872"))
  }

  // handle fig setup
  show figure.caption: it => {
    v(-1em)
    align(left)[
      #block(inset: 1em)[
        #text(weight: "bold")[
          #it.supplement
          #context it.counter.display(it.numbering)
        ]
        #it.separator
        #it.body
      ]
    ]
  }


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

      #if authors != none and not blinded {
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
  } else if blinded {
    page(
      [
        #set align(left + horizon)
        #set par(leading: 0.65em)
        © #date.display("[year]") #sym.dash.em
        \[BLINDED\]<copyright> \
        All rights reserved.
      ],
      numbering: none,
    )
  } else {
    page(
      [
        #set align(left + horizon)
        #set par(leading: 0.65em)
        © #date.display("[year]") #sym.dash.em
        #authors.first().name.<copyright> \
        All rights reserved.
      ],
      numbering: none,
    )
  }

  if abstract != none {

    if not blinded {
      place(
        dy: -3em,
        [
          Dissertation advisor: #dissertation-advisor
          #h(1fr)
          #authors.first().name
        ]
      )
    }

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
          "prev-work",
          "thanks",
          "dedication",
          "epigraph",
          "list-fig",
          "list-tab",
        )
        let custom_text = (
          "Title Page",
          "Copyright",
          "Abstract",
          "Table of Contents",
          "Citations to Previous Work",
          "Acknowledgements",
          "Dedication",
          "Epigraph",
          "List of Figures",
          "List of Tables",
        )

        // Front matter
        for i in array.range(custom_labels.len()) {
          let lbl = label(custom_labels.at(i))
          if (query(lbl).len() == 0) {
            continue
          }

          let loc = locate(lbl)
          let num = numbering("i", loc.page())

          link(
            loc,
            [#smallcaps(custom_text.at(i)) #box(width: 1fr, repeat[.]) #num \ ],
          )
        }

        // Main content: level 1 + level 2
        let entries = query(
          heading.where(level: 1, outlined: true).or(
            heading.where(level: 2, outlined: true),
          ),
        )

        let prev_chapter_num = -1

        for entry in entries {
          let loc = entry.location()
          let level = entry.level
          let page_num = numbering(
            loc.page-numbering(),
            ..counter(page).at(loc),
          )

          let entry_number = if entry.numbering != none {
            numbering(entry.numbering, ..counter(heading).at(loc))
          } else {
            none
          }

          let indent = if level == 2 {
            h(1.5em)
          } else {
            none
          }

          let label = if level == 1 {
            if entry_number != none {
              str(entry_number) + "   " + smallcaps(entry.body)
            } else {
              smallcaps(entry.body)
            }
          } else {
            if entry_number != none {
              str(entry_number) + "   " + entry.body
            } else {
              entry.body
            }
          }

          link(
            loc,
            indent + [#label #box(width: 1fr, repeat[.]) #page_num \ ],
          )
        }
      }
    ]

    pagebreak()
  }

  // FRONTMATTER ----
  // citations to previous work
  if previous-work != none and not blinded {
    ch-header("Citations to Previous Work", "prev-work")
    previous-work
    pagebreak()
  }
  // acknowledgements "thanks"
  if thanks != none and not blinded {
    ch-header("Acknowledgements", "thanks")
    thanks
    pagebreak()
  }

  // list of figures
  if list-of-figures != none and list-of-figures {
    ch-header("List of Figures", "list-fig")

    show outline.entry: it => link(
      it.element.location(),
      it.indented(
        it.prefix(),
        [
          #to-string(it.element.caption.body).split(".").first()
          #box(width: 1fr, repeat(".", gap: 0.15em))
          #it.page()
        ],
      ),
    )

    outline(
      title: none,
      target: figure.where(kind: "quarto-float-fig"),
    )

    pagebreak()
  }

  // list of tables
  if list-of-tables != none and list-of-tables {
    ch-header("List of Tables", "list-tab")

    show outline.entry: it => link(
      it.element.location(),
      it.indented(
        it.prefix(),
        [
          #to-string(it.element.caption.body).split(".").first()
          #box(width: 1fr, repeat(".", gap: 0.15em))
          #it.page()
        ],
      ),
    )

    outline(
      title: none,
      target: figure.where(kind: "quarto-float-tbl"),
    )

    pagebreak()
  }

  // glossary
  // epigraph
  if epigraph != none {
    ch-header("Epigraph", "epigraph")

    show text: emph
    align(
      right,
      block(
        align(left)[
          #epigraph
        ],
      ),
    )
    align(right)[--- #epigraph-author]

    pagebreak()
  }

  // dedication
  if dedication != none and not blinded {
    ch-header("Dedication", "dedication")

    show text: emph
    dedication

    pagebreak()
  }


  // The rest of the doc

  set par(
    justify: true,
    first-line-indent: 1em,
    leading: linestretch * 0.65em,
  )

  set page(numbering: "1")
  counter(page).update(1)

  set figure(numbering: (..num) => {
    let n_head = counter(heading).get().first()
    let number_head = query(
      selector(heading).before(here())
    ).last().numbering
    numbering(number_head, n_head) + "-" + str(num.pos().first())
  })

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }

  // BACKMATTER ----
}

#let appendix(body) = {
  set heading(
    numbering: "A.1.1",
    supplement: [Appendix],
  )
  set figure(
    // numbering: (..nums) => {
    //   "A" + numbering("1", ..nums.pos())
    // },
    supplement: [Appendix Figure],
  )
  counter(heading).update(0)
  counter(figure.where(kind: "quarto-float-fig")).update(0)
  counter(figure.where(kind: "quarto-float-tbl")).update(0)

  body
}

#set table(
  inset: 6pt,
  stroke: none,
)
