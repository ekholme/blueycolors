#test that palettes return the correct number of colors
test_that("palettes return the correct number of colors", {
  expect_length(bluey_palette(n = 1), 1)
  expect_length(bluey_palette(n = 2), 2)
  expect_length(bluey_palette(option = "socks", n = 3), 3)
})

#test that palettes error if requesting too many colors
test_that("palettes error if requested too many colors", {
  expect_error(bluey_palette(n = 6))
})
