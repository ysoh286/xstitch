## xstitch: A package for creating cross-stitch charts

### WHAT
A package that creates a cross-stitch chart for you. All you have to do is supply an image!
Partly inspired by privefl's [pixelart](https://github.com/privefl/pixelart) shiny app.

### TO GET

To install:

```{r}
devtools::install_github('ysoh286/xstitch')
```

### TO USE

Simply provide a path to an image.

```{r}
library(xstitch)
chart(imgpath, height = 100)
```

You can also specify the number of squares you'd like to use by height through the `height` argument (by default this is 100).
Note that the smaller the height number, the less number of colours and more 'pixelated' it becomes. Cannot take in SVG format.

Don't want to use 30+ colours of string?
You can restrict the number of colours used by using the `num` argument.
