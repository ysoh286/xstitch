# Plot colours to generate a cross-stitch pattern chart
# Internal function for creating the actual plot/chart to graphics device
# @param cc colour list from colour matching
# @param w width of the plot/chart
# @param h height of the plot/chart
# @import graphics
plotXMap <- function(cc, w, h) {
  if (is.null(dev.list())) {
    dev.new(width = 11, height = 11 * (h/w))
  }
  old.par <- par(oma = par("oma"), las = par("las"), mar = par("mar"))
  # plot map with colours in grid formation
  plot.new()
  par(las = 1, oma = c(0.5, 0.5, 0.5, 10), mar = c(3, 3, 3, 0))
  # use layouts to put legend on the side of plot
  plot(0, 0, xaxs = "i", yaxs = "i", xlim = c(1, w), ylim = c(1, h),
      axes = FALSE, xlab = "", ylab = "", type = "n")

  set <- matrix(cc$uni, ncol = 3)
  dd <- cc$cols
  colid <- cc$colid

  # try rect
  rect(rep(w:1, each = h) - 1, rep(1:h, w) - 1, rep(w:1, each = h), rep(1:h, w),
       col = rev(rgb(dd[,1], dd[,2], dd[,3])), border = NA, asp = 1)
  # for each unit square
  abline(h = 1:h, col = "lightgray", lwd = 0.25)
  abline(v = 1:w, col = "lightgray", lwd = 0.25)
  # for every 10 squares
  abline(h = seq(0, h, by = 10), col = "black", lwd = 1)
  abline(v = seq(0, w, by = 10), col = "black", lwd = 1)
  axis(3, at = seq(0, w, by = 10), cex.axis = 0.5)
  axis(2, at = seq(0, h, by = 10), cex.axis = 0.5)
  box()
  # add a legend
  legend(w + 5, h + 10, paste(1:nrow(set), set[,1], set[,2], sep = " - "),
         border = NA, pch = 15, title = "DMC chart", col = set[,3],
         cex = 0.5, pt.cex = 1, xpd = NA)
  text(rep(w:1, each = h) - 0.5, rep(1:h, w) - 0.5, labels = rev(colid),
         cex = 0.2, col = "white")

  par(old.par)
}
