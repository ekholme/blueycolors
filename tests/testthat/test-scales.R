test_that("bluey_colors list is structured correctly", {
    expect_true(is.list(bluey_colors))
    expect_named(bluey_colors, c("bluey", "chilli", "heeler", "socks"))
    expect_true(all(sapply(bluey_colors, is.character)))
    expect_true(all(grepl("^#[0-9a-fA-F]{6}$", unlist(bluey_colors))))
})

test_that("bluey_palette works as expected", {
    # Returns full palette by default
    expect_equal(bluey_palette("bluey"), bluey_colors$bluey)

    # Returns correct number of colors when n is specified
    expect_length(bluey_palette("chilli", 3), 3)
    expect_equal(bluey_palette("chilli", 3), bluey_colors$chilli[1:3])

    # Returns full palette when n is NULL
    expect_length(bluey_palette("heeler", n = NULL), 5)

    # Throws error for invalid option
    expect_error(
        bluey_palette("bingo"),
        "is.null(option) || option %in% names(bluey_colors) is not TRUE"
    )

    # Throws error when n is too large
    expect_error(
        bluey_palette("socks", n = 10),
        "Not enough colors in palette socks"
    )
})

test_that("palette generators work correctly", {
    # Discrete palette generator
    pal_fun_d <- palette_gen(direction = 1, option = "heeler")
    expect_true(is.function(pal_fun_d))
    expect_equal(pal_fun_d(3), bluey_colors$heeler[1:3])

    # Discrete palette generator with reversed direction
    pal_fun_d_rev <- palette_gen(direction = -1, option = "heeler")
    expect_equal(pal_fun_d_rev(3), rev(bluey_colors$heeler[1:3]))

    # Continuous palette generator
    pal_fun_c <- palette_gen_c(direction = 1, option = "bluey")
    expect_true(is.function(pal_fun_c))
    # Check if it produces a vector of hex colors
    expect_true(all(grepl("^#[0-9a-fA-F]{6}$", pal_fun_c(5))))
    expect_length(pal_fun_c(10), 10)

    # Continuous palette generator with reversed direction
    pal_fun_c_rev <- palette_gen_c(direction = -1, option = "bluey")
    # The colors should be different from the forward direction
    expect_false(identical(pal_fun_c(5), pal_fun_c_rev(5)))
})


test_that("ggplot2 discrete scales are created correctly", {
    # Color scale
    s_color <- scale_color_bluey()
    expect_s3_class(s_color, "ScaleDiscrete")
    expect_equal(s_color$aesthetics, "colour")

    # Fill scale
    s_fill <- scale_fill_bluey(option = "chilli", direction = -1)
    expect_s3_class(s_fill, "ScaleDiscrete")
    expect_equal(s_fill$aesthetics, "fill")
    expect_equal(s_fill$palette(3), rev(bluey_palette("chilli", 3)))
})

test_that("ggplot2 continuous scales are created correctly", {
    # Color scale
    s_color_c <- scale_color_bluey_c()
    expect_s3_class(s_color_c, "ScaleContinuous")
    expect_equal(s_color_c$aesthetics, "colour")

    # Fill scale
    s_fill_c <- scale_fill_bluey_c(option = "socks", direction = -1)
    expect_s3_class(s_fill_c, "ScaleContinuous")
    expect_equal(s_fill_c$aesthetics, "fill")
})
