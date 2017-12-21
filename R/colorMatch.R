# Color matching
# Internal function for calculating closest colours matched from image to
# DMC chart.
# @param df DMC chart data frame
# @param r red of image
# @param g green of image
# @param b blue of image
# @param num number of colours to be restricted to
calcColor <- function(df, r, g, b, num = NULL) {
  m <- t(col2rgb(df[,'bgcolor']))
  dd <- calcDistance(m, r, g, b)

  ## reduce number of colours used
  if (!is.null(num)) {
    if (num > sum(!duplicated(dd))) {
      stop(paste("Number exceeds maximum number of colours. Please pick
      a number lower than", sum(!duplicated(dd))), call. = FALSE)
    }
    k <- kmeans(dd, centers = num)
    dd <- k$centers[k$cluster, ]
    # reassign rgb and recalculate distances...
    r <- dd[,1]
    g <- dd[,2]
    b <- dd[,3]
    dd <- calcDistance(m, r, g, b)
  }

  # get unique colours used:
  if (is.null(dim(dd))) {
    c <- matrix(dd, ncol = 3)
  } else {
    c <- dd[!duplicated(dd), ]
    if (is.null(dim(c))) {
      c <- matrix(c, ncol = 3)
    }
  }

  # match up:
  mcol <- paste(m[,1], m[,2], m[,3], sep = ",")
  ccol <- paste(c[,1], c[,2], c[,3], sep = ",")
  ind <- match(ccol, mcol)
  set <- df[ind, ]

  # store colours:
  colList <- list(cols = dd/255, uni = set)
  return(colList)

}

# colour palette matching
# used for selection of colours
# not very good at the moment... 
viridis_match <- function(pal, df) {
  t <- switch(pal,
              magma = "A",
              inferno = "B",
              plasma = "C",
              viridis = "D")
  ind <- which(viridis::viridis.map[,"opt"] == t)
  map <- viridis::viridis.map[ind, ]
  r <- map[,1] * 255
  g <- map[,2] * 255
  b <- map[,3] * 255

  m <- t(col2rgb(df[,'bgcolor']))
  dd <- calcDistance(m, r, g, b)
  c <- dd[!duplicated(dd), ]
  mcol <- paste(m[,1], m[,2], m[,3], sep = ",")
  ccol <- paste(c[,1], c[,2], c[,3], sep = ",")
  ind <- match(ccol, mcol)
  colPalette <- df[ind, ]
  return(colPalette)

}

calcDistance <- function(m, r, g, b) {
  ## run a Euclidean distance match between colours:
  rcol <- m[,1]
  gcol <- m[,2]
  bcol <- m[,3]

  # closest colours to DMC?
  # using Euclidean distance
  dr <- outer(r, rcol, FUN = "-")
  dg <- outer(g, gcol, "-")
  db <- outer(b, bcol, "-")

  #calculate distance + find which has minimum:
  d <- sqrt((dr)^2 + (dg)^2 + (db)^2)
  mind <- apply(d, 1, "which.min")
  dd <- data.frame(m[mind, ])
  return(dd)
}
