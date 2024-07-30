#import calc

#let font-size = 11pt
#let lead = 13pt

/* This calculates the number of lines that fit on a page, ensuring that
bottom floating figures line up with the last line on the page.
You could have Typst calculate all of this, but unfortunately
it cuts off the result 2 digits after the decimal. */
#context {
  let smaller-edge = calc.min(page.width, page.height)
  let y = calc.floor((page.height - (2 * smaller-edge * 2.5 / 21)) / lead)
  [Set `margin-y` to $ (page.height - #y dot.c #lead) / 2
  approx #((page.height - y * lead)/2) . $
  Typst is not accurate enough, please calculate it yourself.]
}
#let margin-y = 76.445pt

#set page(
  margin: (y: margin-y),
)
#set par(
  leading: 0pt,
  first-line-indent: lead,
  justify: true,
  // spacing: 0pt // Uncomment this property or set it in your main source file
                  // ONLY if you’re on the web app or the main branch.
                  // Don’t if you’re using the release version.
)
#set text(
  top-edge: lead,
  size: font-size
)

#set block(spacing: 0pt)
#show quote.where(block: true): set block(spacing: lead)

/* Wrapper function.
Measures the size of its argument, calculates the appropriate spacing,
and applies it using the `pad` function. */
#let a(it) = context[#layout(size => [
  #let (height,) = measure(
    block(width: size.width, it),
  )
  #let pos = here().position().y
  #let padding = lead
  #while height > padding {
    padding += lead
  }
  #if pos == margin-y [
    #pad(bottom: (padding + lead - height), it)
  ] else [
    #pad(y: (padding - height + (2 * lead)) / 2, it)
  ]
])]

/* Floats don’t work correctly when using `layout`, so we calculate
the height of these another way. They don’t need a wrapper function,
we’re directly applying the spacing via show rules. */
#let float-adjustment(it) = context {
  let body-size = measure(it.body).height

  /* Unfortunately we can’t accurately measure images wider than the text column,
  so we need to tell the user to manually set the figure body’s width. */
  if it.kind == image {
    layout(size => {
      let container-width = size.width

      let body-width = measure(it.body).width
      assert(
        body-width <= container-width,
        message: str("Set the image's width to <=" + str(container-width/1pt) + "pt.")
      )
    })
  }
  assert(it.caption != none, message: "Please add a caption to your figure.")
  let caption-size = measure(it.caption).height
  let height = body-size + figure.gap.to-absolute() + caption-size

  let padding = lead
  while height > padding {
    padding += lead
  }
  set place(clearance: padding - height + lead)

  it
}

#show figure.where(placement: top): float-adjustment
#show figure.where(placement: bottom): float-adjustment
#show figure.where(placement: auto): float-adjustment
