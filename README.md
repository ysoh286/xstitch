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

---

### DEV NOTES / Memory joggers

Re-read Wickham's R packages book online for a memory jog.

Quickstart:

Be in directory + run `devtools::load_all()` and run the functions with change to test.

To run tests:

- Write tests in the `testthat` folder in `tests.R`. Add test images in the same folder
- Run the tests by running `devtools::tests()`

**Ideas**

- Speed improvements: `text.default` when plotting / rendering chart is really slow - found by profiling using `Rprof()` & `summaryRprof()`. Ideally find a way to NOT do this (a case of using random colours / patterns in the squares?)

To run a quick profile test

```
Rprof() ## run
chart(img)
Rprof(NULL)
summaryRprof()
```

- Methods of finding the closest colours (currently using Euclidean distance / kmeans) for improvement
- Get it onto CRAN? (but will need a memory jog on building R packages, since it's been 3++ years since this was developed)
- Accomodate for SVG images (to research on)
