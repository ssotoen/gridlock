/// Floats don’t work correctly when using `layout`, so we calculate
/// the height of these another way. They don’t need a wrapper function,
/// we’re directly applying the spacing via show rules.
#let float-adjustment(it) = context {
  let body-size = measure(it.body).height

  // Unfortunately we can’t accurately measure images wider than the text column,
  // so we need to tell the user to manually set the figure body’s width.
  if it.kind == image {
    layout(size => {
      let container-width = size.width
      let body-width = measure(it.body).width

      if body-width > container-width {
        panic("Make sure none your figures are wider than " + str(container-width/1pt) + "pt.")
      }
    })
  }

  let caption-size = measure(it.caption).height
  let height = body-size

  if it.caption != none {
    height = body-size + figure.gap.to-absolute() + caption-size
  }

  let line-height = text.top-edge

  let padding = line-height
  while height > padding {
    padding += line-height
  }
  set place(clearance: padding - height + line-height)

  it
  h(line-height)
}

/* This calculates the number of lines that fit on a page, ensuring that
bottom floating figures line up with the last line on the page.
You could have Typst calculate all of this, but unfortunately
it cuts off the result 2 digits after the decimal. */
// #context {
//   let smaller-edge = calc.min(page.width, page.height)
//   let y = calc.floor((page.height - (2 * smaller-edge * 2.5 / 21)) / lead)
//   [Set `margin-y` to $ (page.height - #y dot.c #lead) / 2
//   approx #((page.height - y * lead)/2) . $
//   Typst is not accurate enough, please calculate it yourself.]
// }

#let gridlock(
  paper: "a4",
  margin: (y: 76.445pt),
  font-size: 11pt,
  line-height: 13pt,

  body,
) = {
  set page(
    paper: paper,
    margin: margin,
  )
  set text(
    size: font-size,
    top-edge: line-height
  )

  set par(
    leading: 0pt,
    first-line-indent: line-height,
    justify: true,
    // spacing: 0pt // Uncomment this property or set it in your main source file
                    // ONLY if you’re on the web app or the main branch.
                    // Don’t if you’re using the release version.
  )

  set text(
    top-edge: line-height,
    size: font-size
  )

  set block(spacing: 0pt)
  show quote.where(block: true): set block(spacing: line-height)

  show heading: set text(top-edge: 1.2em)
  show footnote.entry: set text(top-edge: 0.8em)

  show figure.where(placement: top): float-adjustment
  show figure.where(placement: bottom): float-adjustment
  show figure.where(placement: auto): float-adjustment

  body
}

/// Wrapper function.
/// Measures the size of its argument, calculates the appropriate spacing,
/// and applies it using the `pad` function.
#let lock(it) = context[#layout(size => [
  #let (height,) = measure( block(width: size.width, it), )
  #let line-height = text.top-edge
  #let padding = line-height

  #while height > padding {
    padding += line-height
  }

  #let pos = here().position().y
  #if pos == page.margin.top [
    #pad(bottom: (padding + line-height - height), it)
  ] else [
    #pad(y: (padding - height + (2 * line-height)) / 2, it)
  ]
])]
