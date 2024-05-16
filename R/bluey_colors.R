# main bluey colors
bluey_colors <- function(...) {
  b_colors <- c(
    "dark_blue" = "#30598a",
    "light_blue" = "#72bfed",
    "tan" = "#e4dcbd",
    "light_orange" = "#f1b873",
    "dark_orange" = "#e27a37"
  )

  cols <- c(...)

  if (is.null(cols)) {
    return(b_colors)
  } else {
    return(b_colors[cols])
  }
}

# defining the palette
#' @rdname bluey_colors
#' @export
bluey_palette <- function(...) {
  bluey_colors(...)
}

# helper to generate a palette for discrete scales
palette_gen <- function(direction = 1) {
  function(n) {
    if (n > length(bluey_colors())) {
      warning("Not enough colors in this palette")
    } else {
      all_colors <- unname(bluey_palette())

      all_colors <- if (direction >= 0) all_colors else rev(all_colors)

      return(all_colors[1:n])
    }
  }
}

#' Bluey Colors
#' 
#' @description
#' ggplot2 fill and color scales derived from Bluey
#' 
#' - `scale_color_bluey()` and `scale_fill_bluey()` provide discrete fill functions
#' 
#' @param direction If greater than or equal to 0, it will return the standard direction; otherwise it will reverse the direction of the palette
#' @param ... Additional arguments passed to ggplot2 scale functions
#' 
#' @name bluey_colors
#' 
#' @export
#' 
#' @examples
#' library(ggplot2)
#' tmp <- data.frame(x = rnorm(100), y = rnorm(100), z = rep(c("a", "b", "c", "d"), 25))
#' ggplot(tmp, aes(x, y, color = z)) +
#' geom_point() +
#' scale_color_bluey()
scale_color_bluey <- function(direction = 1, ...) {
  ggplot2::discrete_scale(
    aesthetics = "color",
    scale_name = "bluey",
    palette = palette_gen(direction),
    ...
  )
}

#' @rdname bluey_colors
#' @export 
scale_fill_bluey <- function(direction = 1, ...) {
  ggplot2::discrete_scale(
    aesthetics = "fill",
    scale_name = "bluey",
    palette = palette_gen(direction),
    ...
  )
}