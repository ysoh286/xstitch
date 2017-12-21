#' Generate a cross-stitch pattern chart
#' Supply an image and turn it into a cross stitch chart.
#' Currently assumes full stitches.
#' @param imgpath the path of the image to be processed
#' @param height height of chart to be produced by squares (default is 100)
#' @param num number of colours to be used (default is NULL)
#' @param col.pal a colour palette (via viridis)
#' @import graphics
#' @importFrom grDevices col2rgb rgb
#' @importFrom stats kmeans
#' @export
chart <- function(imgpath, height = 100, num = NULL, col.pal = NULL) {
  img <- magick::image_read(imgpath)

  if (!is.null(height)) {
    img <- magick::image_scale(img, paste0("x", height))
  }

  # TODO: fix for svg and reading error appears
  # add a border around image
  #img <- magick::image_border(img, "#ffffff", "1x1")
  #img <- magick::image_frame(img)
  # a possible condition for large images with too many pixels?
  vppm <- magick::image_convert(img, format = "ppm")
  magick::image_write(vppm, path = "vppm.ppm")
  imginfo <- pixmap::read.pnm("vppm.ppm", cellres = 1)

  # remove file
  file.remove("vppm.ppm")

  # width and height
  w <- imginfo@size[2]
  h <- imginfo@size[1]

  # get rgb of pix map
  r <- imginfo@red * 255
  g <- imginfo@green * 255
  b <- imginfo@blue * 255

  dim(r) <- NULL
  dim(g) <- NULL
  dim(b) <- NULL

  if (!is.null(col.pal)) {
    restrictChart <- viridis_match(col.pal, DMCchart)
    dd <- calcColor(restrictChart, r, g, b, num)
  } else {
    dd <- calcColor(DMCchart, r, g, b, num)
  }

  plotXMap(dd, w, h)

  chart <- list(colorMap = dd$cols, uniqueColors = dd$uni,
                width = w, height = h, numCount = num)
  invisible(chart)

}
