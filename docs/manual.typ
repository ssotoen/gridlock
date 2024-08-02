#import "@local/gridlock:0.1.0": *

#set page(
  numbering: "1",

  footer: locate(loc => {
    let current-page = counter(page).at(loc).at(0)

  if current-page > 1 {
    align(center, numbering("1", current-page))
  }
  })
)

#set text(font: "Reforma 1918")

#let typst-toml = toml("../typst.toml")
#let project-version = typst-toml.package.version
#let project-authors = typst-toml.package.authors.at(0)

#set document(
  title: "Manual for the Typst package “gridlock” (Version " + project-version + ")",
  author: project-authors,
)

#page[
  #set align(center)

  #v(1fr)
  #text(28pt, weight: "bold")[The gridlock package]

  #text(16pt)[Grid typesetting in Typst]

  #v(4em)
    Version #project-version #h(3em) #datetime.today().display()

  #project-authors

  #v(4em)
  #link("https://github.com/ssotoen/gridlock")[github.com/ssotoen/gridlock]

  #v(2fr)
  #block(width: 30%)[#outline(
    indent: 1em,
    depth: 2,
  )]

  #v(3em)
]

#show: gridlock.with(
  font-size: 11pt,
  line-height: 13pt
)

#page(
  columns: 2,
  background: stack(
    dir: ttb,
    let n = 0,
    while n < 53 {
    line(stroke: 0.1pt, length: 453.56pt)
    v(13pt)
    n += 1
    },
  )
)[
#lock[= Example]
#set heading(outlined: false)

Hello, here is some text without a meaning.
This text should show what a printed text will look like at this place.
If you read this text, you will get no information.
Really?
Is there no information?
Is there a difference between this text and some nonsense like “Huardest gefburn”?
Kjift—not at all!
A blind text like this gives you information about the selected font, how the letters are written, and an impression of the look.
This text should contain all letters of the alphabet and it should be written in the original language.
There is no need for special content, but the length of the words should match the language.

This is the second paragraph.
Hello, here is some text without a meaning.
This text should show what a printed text will look like at this place.
If you read this text, you will get no information.
Really?

#lock[== This is a long heading spanning multiple lines]

Is there no information?
Is there a difference between this text and some nonsense like “Huardest gefburn”?
Kjift—not at all!
A blind text like this gives you information about the selected font, how the letters are written, and an impression of the look.
This text should contain all letters of the alphabet and it should be written in the original language.
There is no need for special content, but the length of the words should match the language.
#footnote[
  And here we have a footnote.
  Hello, here is some text without a meaning.
  This text should show what a printed text will look like at this place.
  If you read this text, you will get no information.
]

#quote(block: true)[
This is a block quote.
And after the second paragraph follows the third paragraph.
]
Hello, here is some text without a meaning.
This text should show what a printed text will look like at this place.
If you read this text, you will get no information.
Really?
Is there no information?
Is there a difference between this text and some nonsense like “Huardest gefburn”?
Kjift—not at all!
A blind text like this gives you information about the selected font, how the letters are written, and an impression of the look.
This text should contain all letters of the alphabet and it should be written in the original language.
There is no need for special content, but the length of the words should match the language.

#lock[$ x = (-b ± sqrt(b^2 - 4 a c))/(2a) $]

#h(13pt)After this fourth paragraph, we start a new paragraph sequence.
Hello, here is some text without a meaning.
This text should show what a printed text will look like at this place.
If you read this text, you will get no information.

- A bulleted list
  + Indented
- Really?

Is there no information?
Is there a difference between this text and some nonsense like “Huardest gefburn”?
Kjift—not at all!
A blind text like this gives you information about the selected font, how the letters are written, and an impression of the look.
This text should contain all letters of the alphabet and it should be written in the original language.
There is no need for special content, but the length of the words should match the language.

#figure(
  placement: top,
  caption: [_The Great Wave off Kanagawa_ #box[by Katsushika Hokusai]],
  image("assets/Tsunami_by_hokusai_19th_century.jpg", width: 217pt)
)

Hello, here is some text without a meaning.
This text should show what a printed text will look like at this place.
If you read this text, you will get no information.
Really?
Is there no information?
Is there a difference between this text and some nonsense like “Huardest gefburn”?
Kjift—not at all!
A blind text like this gives you information about the selected font, how the letters are written, and an impression of the look.
This text should contain all letters of the alphabet and it should be written in the original language.
There is no need for special content, but the length of the words should match the language.
There is no need for special content, but the length of the words should match the language.
There is no need for special content, but the length of the words should match the language.

Hello, here is some text without a meaning.
This text should show what a printed text will look like at this place.
If you read this text, you will get no information.
Really?
Is there no information?
Is there a difference between this text and some nonsense like “Huardest gefburn”?
Kjift—not at all!
A blind text like this gives you information about the selected font, how the letters are written, and an impression of the look.
This text should contain all letters of the alphabet and it should be written in the original language.
There is no need for special content, but the length of the words should match the language.
]
