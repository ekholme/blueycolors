# Bluey Color Palette Constructor

Extract a color palette of the desired length (maximum of length 5)

## Usage

``` r
bluey_palette(option = "bluey", n = NULL)
```

## Arguments

- option:

  The name of the color palette to use. Current options are 'bluey',
  'chilli', 'heeler', and 'socks'

- n:

  The number of colors to return. Currently, all scales are limited to 5
  colors

## Value

a character vector of hex codes for the requested palette

## Examples

``` r
bluey_palette("heeler")
#> [1] "#30598a" "#72bfed" "#e4dcbd" "#f1b873" "#e27a37"
bluey_palette("socks", n = 5)
#> [1] "#8f9fd8" "#201a3f" "#a97d45" "#c3cae1" "#3e2b0b"
```
