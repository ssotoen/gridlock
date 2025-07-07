// typst c docs/gridlock-manual.typ --font-path docs/fonts --root ./ --pdf-standard a-2b

#let typst-toml = toml("/typst.toml")
#let project-version = typst-toml.package.version
#let project-authors = typst-toml.package.authors.at(0)
#show "[version-placeholder]": project-version

#let doc-title = "The gridlock package"

#import "/src/gridlock.typ": *
#import "@preview/tidy:0.4.3"

#set page(
  numbering: "1",

  footer: context {
    let current-page = counter(page).get().first()

    if current-page > 1 {
      align(center, text(9pt, numbering("1", current-page)))
    }
  }
)

#set text(
  font: "Reforma 1918",
  stylistic-set: (4, 5), // long-tail Q in roman (4) and italic (5)
)

#show math.equation: set text(
  stylistic-set: none,
  weight: "regular",
)

#set par(
  justify: true
)

#set document(
  title: doc-title,
  description: "Manual for the Typst package “gridlock” (Version\u{00a0}" + project-version + ")",
  author: project-authors,
  date: datetime(
    year:   datetime.today().year(),
    month:  datetime.today().month(),
    day:    datetime.today().day(),
    hour:   1,
    minute: 0,
    second: 0,
  ),
)

#show raw.where(block: true): block.with(
  width: 100%,
  fill: gray.lighten(85%),
  inset: 3mm,
  radius: 1.5mm,
)

#show footnote.entry: it => {
  let loc = it.note.location()
  numbering(
    "1.",
    ..counter(footnote).at(loc)
  )
  it.note.body
}

#show outline:set text(number-type: "lining")

#page[
  #set align(center)

  #v(1fr)
  #text(28pt, weight: "bold", doc-title)

  #text(16pt)[Grid typesetting in Typst]

  #v(3.5em)
  Version #project-version #h(3em) #datetime.today().display()

  #project-authors

  #v(3em)
  #link("https://github.com/ssotoen/gridlock")[github.com/ssotoen/gridlock]

  #v(2fr)
  #block(width: 33%)[#outline(
    indent: 1em,
    depth: 2,
  )]

  #v(3em)
]

#set page(
  header: text(9pt, style: "italic")[The gridlock package #h(1fr) v#project-version]
)

#let pageref = ref.with(form: "page")

= About

gridlock provides a way to do grid typesetting in Typst.
It does this by setting a line height for running text and using this as an invisible grid.
Blocks that don’t fit into a line, like headings and figures, are aligned so that the running text after them sits on the grid again.
Check out the examples on #pageref(<example>) and #pageref(<example-lines>).

= Quick start

```typ
#import "@preview/gridlock:[version-placeholder]": *

#show: gridlock.with(
  paper: "a4",
  margin: (y: 76.444pt),
  font-size: 11pt,
  line-height: 13pt
)

#lock[= This is a heading]

#lorem(30)

#figure(
  placement: auto,
  caption: [a caption],
  rect()
)

#lorem(30)
```

The ```typc gridlock()``` function sets up the base line height that for the grid.
The parameters shown in the example are the default values.
If you’re happy with them, you don’t need to pass anything to the function: just do ```typ #show: gridlock.with()```. \
If you want to change the line height, make sure to set the margin so that the text area is an exact multiple of the new line height.

Now you can use the ```typc lock()``` function to align any block to the text grid, like the heading shown in the example.
Some elements---like the floating figure in the example above---are aligned automatically and do *not* need to be used with ```typc lock()```.
You can find a complete list in the function’s description in the next chapter.

= Functions

#tidy.show-module(
  tidy.parse-module(read("/src/gridlock.typ")),
  first-heading-level: 1,
  sort-functions: it => {
    (
      "gridlock": 11,
      "lock": 12,
      "float-adjustment": 13
    ).at(it.name, default: 99)
  }
)

#pagebreak(to: "even")

#show: gridlock.with(
  font-size: 11pt,
  line-height: 13pt,
)

#set page(columns: 2)

#lock[= Example] <example>
#include "example-text.typ"

#set page(
  background: stack(
    for n in range(53) {
      v(13pt)
      line(stroke: 0.1pt, length: 453.56pt)
    },
  )
)

#lock[= Example with grid lines] <example-lines>
#include "example-text.typ"
