context("tests")

test_that("general error checks", {
  expect_error(chart("redsquare.png", num = 4),
               "Number exceeds maximum number of colours")
})

test_that("general map selection", {
  expect_equal(as.vector(chart("redsquare.png")$uniqueColors),
  c("606", "Orange-red-BRIGHT", "#f70f00"))
  expect_equal(chart("Rlogo.png", height = 30)$height,
               30)
  expect_equal(chart("Rlogo.png")$height, 100)
})
