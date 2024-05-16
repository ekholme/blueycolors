#' Available Bluey Color Palettes
#' 
#' Use \code{\link{bluey_palette}} to extract palettes of the desired length
#' @export
bluey_colors <- list(
  bluey = c("#d2ebff", "#88cafc", "#404066", "#2b2c41", "#edcc6f"),
  chilli = c("#fffad8", "#ffd08d", "#ffb070", "#9c5e33", "#46362a"),
  heeler = c("#30598a", "#72bfed", "#e4dcbd", "#f1b873", "#e27a37"),
  socks = c("#8f9fd8", "#201a3f", "#a97d45", "#c3cae1", "#3e2b0b")
)

#' Bluey Color Palette Constructor
#' 
#' @description Extract a color palette of the desired length
#' 
#' @param option The name of the color palette to use. Current options are 'bluey', 'chilli', 'heeler', and 'socks'
#' @param n The number of colors to return. Currently, all scales are limited to 5 colors
#' 
#' @name bluey_palette
#' 
#' @export
bluey_palette <- function(option = "bluey", n = NULL) {
  stopifnot(is.null(option) || option %in% names(bluey_colors))

  pal <- bluey_colors[[option]]

  if (is.null(n)) {
    return(pal)
  }   

  if (n > length(pal)) {
    stop(paste0("Not enough colors in palette ", option))
  }

  return(pal[1:n]) 
} 

# helper to generate a palette for discrete scales
palette_gen <- function(direction = 1, option = "bluey") {
  stopifnot(is.numeric(direction))

  function(n) {
    pal <- bluey_palette(option, n)

    if (direction >= 0) pal else rev(pal)

  }
}

#helper to generate palette for continuous scales
palette_gen_c <- function(direction = 1, option = "bluey", ...) {
  stopifnot(is.numeric(direction))

  pal <- bluey_palette(option)[c(1, 2)]

  pal <- if (direction >= 0) pal else rev(pal)

  colorRampPalette(pal, ...)
}

#' Bluey ggplot 2 color scales
#' 
#' @description
#' ggplot2 fill and color scales derived from Bluey characters
#' 
#' - `scale_color_bluey()` and `scale_fill_bluey()` provide discrete fill functions
#' - `scale_color_bluey_c()` and `scale_fill_bluey_c()` provide continuous fill functions`
#' 
#' @param option The name of the color palette to use. See \code{\link{bluey_palette}} for available options
#' @param direction If greater than or equal to 0, it will return the standard direction; otherwise it will reverse the direction of the palette
#' @param ... Additional arguments passed to ggplot2 scale functions
#' 
#' @name bluey_ggplot2_scales
#' 
#' @export
#' 
#' @examples
#' library(ggplot2)
#' tmp <- data.frame(x = rnorm(100), y = rnorm(100), z = rep(c("a", "b", "c", "d"), 25))
#' 
#' # using a discrete scale
#' ggplot(tmp, aes(x, y, color = z)) +
#' geom_point() +
#' scale_color_bluey()
#' 
#' # changing the palette used when creating a discrete scale
#' ggplot(tmp, aes(x, y, color = z)) +
#' geom_point() +
#' scale_color_bluey(option = "socks")
#' 
#' 
scale_color_bluey <- function(option = "bluey", direction = 1, ...) {
  ggplot2::discrete_scale(
    aesthetics = "color",
    scale_name = option,
    palette = palette_gen(direction, option = option),
    ...
  )
}

#' @rdname bluey_ggplot2_scales
#' @export 
scale_fill_bluey <- function(option = "bluey", direction = 1, ...) {
  ggplot2::discrete_scale(
    aesthetics = "fill",
    scale_name = option,
    palette = palette_gen(direction, option = option),
    ...
  )
}

#' @rdname bluey_ggplot2_scales
#' @export
scale_color_bluey_c <- function(option = "bluey", direction = 1, ...) {
  pal <- palette_gen_c(direction = direction, option = option)

  ggplot2::scale_color_gradient(colors = pal(256), ...)
}

#' @rdname bluey_ggplot2_scales
#' @export
scale_fill_bluey_c <- function(option = "bluey", direction = 1, ...) {
  pal <- palette_gen_c(direction = direction, option = option)

  ggplot2::scale_fill_gradient(colors = pal(256), ...)

}