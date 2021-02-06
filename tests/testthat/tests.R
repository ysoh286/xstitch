context("tests")

test_that("general error checks", {
  expect_error(chart("redsquare.png", num = 4),
               "Number exceeds maximum number of colours")
})


test_that("general map selection", {
  img <- "redsquare.png"
  rLogo <- "Rlogo.png"
  expect_equal(as.vector(chart(img)$uniqueColors),
  c("606", "Orange-red-BRIGHT", "#f70f00"))
  expect_equal(chart(rLogo, height = 30)$height,
               30)
  expect_equal(chart(rLogo)$height, 100)
})


test_that("grayscale pictures work", {
  img <- "greyscaledog.jpg"
  expect_equal(chart(img)$height, 100)
})

test_that("restrict number of colours used", {
  img <- "greyscaledog.jpg"
  actual <- chart(img, 100, 5)
  actualColourLength <- nrow(actual$uniqueColors)
  expect_equal(actualColourLength, 5)
})
