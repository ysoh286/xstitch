#' Generate a cross-stitch pattern chart
#' Supply an image and turn it into a cross stitch chart.
#' Currently assumes full stitches.
#' @param imgpath the path of the image to be processed
#' @param height height of chart to be produced by squares (default is 100)
#' @param num number of colours to be used (default is NULL)
#' @param select.col provide a vector of coloured strings (DMC numbers/code)
#' @import graphics
#' @importFrom grDevices col2rgb rgb dev.list dev.new
#' @importFrom stats kmeans
#' @export
chart <- function(imgpath, height = 100, num = NULL, select.col = NULL) {
  img <- magick::image_read(imgpath)

  if (!is.null(height)) {
    img <- magick::image_scale(img, paste0("x", height))
  }

  img <- magick::image_background(img, "white")
  vppm <- magick::image_convert(img, format = "png")
  magick::image_write(vppm, path = "img.png")
  imginfo <- png::readPNG("img.png")

  # remove file
  file.remove("img.png")

  # width and height
  w <- dim(imginfo)[2]
  h <- dim(imginfo)[1]

  if (w * h > 100000) {
    warning("The number of squares to be rendered is over 100,000.
            This may take a while...")
  }

  # get rgb of pix map
  if (dim(imginfo)[3] == 3) {
    r <- round(imginfo[,,1] * 255)
    g <- round(imginfo[,,2] * 255)
    b <- round(imginfo[,,3] * 255)
  } else {
     # convert rgba to rgb (from http://marcodiiga.github.io/rgba-to-rgb-conversion)
     # assume background colour is black:
    alpha <- imginfo[,,4]
    r <- round(alpha * imginfo[,,1] * 255)
    g <- round(alpha * imginfo[,,2] * 255)
    b <- round(alpha * imginfo[,,3] * 255)
  }

  dim(r) <- NULL
  dim(g) <- NULL
  dim(b) <- NULL

  if (!is.null(select.col)) {
    index <- match(as.character(select.col), DMCchart[,1])
    reducedChart <- DMCchart[index, ]
  } else {
    reducedChart <- DMCchart
  }

  dd <- calcColor(reducedChart, r, g, b, num)

  plotXMap(dd, w, h)

  chart <- list(colorMap = dd$cols, uniqueColors = dd$uni,
                width = w, height = h, numCount = num)
  invisible(chart)

}
