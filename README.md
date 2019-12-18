
<!-- README.md is generated from README.Rmd. Please edit that file -->

# trimmer <img src="man/figures/hex_trimmer.png" align="right" height=140/>

[![Travis-CI Build
Status](https://travis-ci.org/smaakage85/trimmer.svg?branch=master)](https://travis-ci.org/smaakage85/trimmer)
[![CRAN\_Release\_Badge](http://www.r-pkg.org/badges/version-ago/trimmer)](https://CRAN.R-project.org/package=trimmer)
[![CRAN\_Download\_Badge](http://cranlogs.r-pkg.org/badges/trimmer)](https://CRAN.R-project.org/package=trimmer)

`trimmer` is a lightweight toolkit to trim a (potentially big) R object
without breaking the results of a given function call, where the
(trimmed) R object is given as argument.

The `trim` function is the bread and butter of `trimmer`. It seeks to
reduce the size of an R object by recursively removing elements from the
object one-by-one. It does so in a ‘greedy’ fashion - it constantly
tries to remove the element that uses the most memory.

The trimming process is constrained by a reference function call. The
trimming procedure will not allow elements to be removed from the
object, that will cause results from the function call to diverge from
the original results of the function call.

## Installation

Install the development version of `trimmer` with:

``` r
remotes::install_github("smaakage85/trimmer")
```

Or install the version released on CRAN:

``` r
install.packages("trimmer")
```

## Workflow Example

Get ready by loading the package.

``` r
library(trimmer)
```

Train a model on the famous `mtcars` data set.

``` r
# load training data.
trn <- datasets::mtcars

# estimate model.
mdl <- lm(mpg ~ ., data = trn)
```

I want to trim the model object `mdl` as possible without affecting the
predictions, computed with function `predict()`, for the resulting
model.

The trimming is then simply conducted by invoking:

``` r
mdl_trim <- trim(obj = mdl,
                 obj_arg_name = "object",
                 fun = predict,
                 newdata = trn)
#> * Initial object size: 22.22 kB
#> Begin trimming object.
#> ~ Trying to remove element [[c('model')]], element size = 14.05 kB
#> v Element removed.
#> * Object size after removal: 18.19 kB [v4.03 kB]
#> ~ Trying to remove element [[c('qr')]], element size = 7.79 kB
#> x Element could not be removed.
#> ~ Trying to remove element [[c('terms')]], element size = 7.63 kB
#> x Element could not be removed.
#> ~ Trying to remove element [[c('qr','qr')]], element size = 6.66 kB
#> v Element removed.
#> * Object size after removal: 14.95 kB [v7.27 kB]
#> ~ Trying to remove element [[c('residuals')]], element size = 2.86 kB
#> v Element removed.
#> * Object size after removal: 14.53 kB [v7.7 kB]
#> ~ Trying to remove element [[c('fitted.values')]], element size = 2.86 kB
#> v Element removed.
#> * Object size after removal: 11.66 kB [v10.56 kB]
#> ~ Trying to remove element [[c('effects')]], element size = 1.4 kB
#> v Element removed.
#> * Object size after removal: 10.76 kB [v11.46 kB]
#> ~ Trying to remove element [[c('coefficients')]], element size = 1.09 kB
#> x Element could not be removed.
#> ~ Trying to remove element [[c('call')]], element size = 728 B
#> v Element removed.
#> * Object size after removal: 10.09 kB [v12.14 kB]
#> ~ Trying to remove element [[c('xlevels')]], element size = 208 B
#> v Element removed.
#> * Object size after removal: 9.85 kB [v12.38 kB]
#> ~ Trying to remove element [[c('qr','qraux')]], element size = 176 B
#> v Element removed.
#> * Object size after removal: 9.62 kB [v12.61 kB]
#> ~ Trying to remove element [[c('assign')]], element size = 96 B
#> v Element removed.
#> * Object size after removal: 9.46 kB [v12.76 kB]
#> ~ Trying to remove element [[c('qr','pivot')]], element size = 96 B
#> x Element could not be removed.
#> ~ Trying to remove element [[c('rank')]], element size = 56 B
#> x Element could not be removed.
#> ~ Trying to remove element [[c('df.residual')]], element size = 56 B
#> v Element removed.
#> * Object size after removal: 9.31 kB [v12.91 kB]
#> ~ Trying to remove element [[c('qr','tol')]], element size = 56 B
#> v Element removed.
#> * Object size after removal: 9.17 kB [v13.06 kB]
#> Trimming completed.
```

And that’s it\!

Note, that I provide the `trim` function with the extra argument
`newdata`, that is passed to the function call with `fun`. This means,
that the trimming is constrained by, that the results of ‘fun’
(=`predict`) *MUST* be exactly the same on these data before and after
the trimming.

The trimmed model object now measures 9.17 kB. The original object
measured 22.22 kB.

For more information about how to use `trimmer`, please take a look at
the vignette:

``` r
vignettes("trimmer")
```

## Contact

I hope, that you will find `trimmer` useful.

Please direct any questions and feedbacks to
[me](mailto:lars_kjeldgaard@hotmail.com)\!

If you want to contribute, open a
[PR](https://github.com/smaakage85/trimmer/pulls).

If you encounter a bug or want to suggest an enhancement, please [open
an issue](https://github.com/smaakage85/trimmer/issues).

Best, smaakagen
