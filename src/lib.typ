/// This function deals with the floating figures in your document.
/// You don’t need to call it manually.
///
/// Unfortunately we can’t use ```typc layout()``` here since that messes with the floating.
/// This means that figures wider than the line width are measured before they are shrunk down to fit,
/// which results in inaccurate measurements.
/// To solve this problem, the compiler will remind you to manually set the width of these figures.
///
/// -> content
#let float-adjustment(
  /// The figure.
  /// -> content
  it
) = context {
  let body-size = measure(it.body).height

  if it.kind == image {
    layout(size => {
      let container-width = size.width
      let body-width = measure(it.body).width

      if body-width > container-width {
        // TODO: v0.12 might introduce a warning function. could be more appropriate
        panic("Make sure none of your figures are wider than " + str(container-width/1pt) + "pt.")
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
