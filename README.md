
<!-- README.md is generated from README.Rmd. Please edit that file -->

# daTrimmer

`daTrimmer` is a lightweight toolkit to trim a (potentially big) R
object without breaking the results of a given function call, where the
(trimmed) R object is given as argument.

The `trim` function is the bread and butter of `daTrimmer`. It seeks to
reduce the size of an R object by recursively removing elements from the
object one-by-one. It does so in a ‘greedy’ fashion - it constantly
tries to remove the element that uses the most memory.

The trimming process is constrained by a reference function call. The
trimming procedure will not allow elements to be removed from the
object, that will cause results from the function call to diverge from
the original results of the function call.

## Installation

`daTrimmer` can be installed with `install.packages('daTrimmer')`.

## Workflow Example

Get ready by loading the package.

``` r
library(daTrimmer)
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
#> ● Initial object size: 22.22 kB
#> Begin trimming object.
#> … Trying to remove element [[c(12)]], element size = 14.05 kB
#> ✔ Element removed.
#> ● Object size after removal: 18.19 kB [↓4.03 kB]
#> … Trying to remove element [[c(7)]], element size = 7.79 kB
#> ✖ Element could not be removed without breaking results.
#> … Trying to remove element [[c(11)]], element size = 7.63 kB
#> ✖ Element could not be removed without breaking results.
#> … Trying to remove element [[c(7,1)]], element size = 6.66 kB
#> ✔ Element removed.
#> ● Object size after removal: 14.95 kB [↓7.27 kB]
#> … Trying to remove element [[c(2)]], element size = 2.86 kB
#> ✔ Element removed.
#> ● Object size after removal: 14.53 kB [↓7.7 kB]
#> … Trying to remove element [[c(4)]], element size = 2.86 kB
#> ✔ Element removed.
#> ● Object size after removal: 11.66 kB [↓10.56 kB]
#> … Trying to remove element [[c(2)]], element size = 1.4 kB
#> ✔ Element removed.
#> ● Object size after removal: 10.76 kB [↓11.46 kB]
#> … Trying to remove element [[c(1)]], element size = 1.09 kB
#> ✖ Element could not be removed without breaking results.
#> … Trying to remove element [[c(7)]], element size = 728 B
#> ✔ Element removed.
#> ● Object size after removal: 10.09 kB [↓12.14 kB]
#> … Trying to remove element [[c(6)]], element size = 208 B
#> ✔ Element removed.
#> ● Object size after removal: 9.85 kB [↓12.38 kB]
#> … Trying to remove element [[c(4,1)]], element size = 176 B
#> ✔ Element removed.
#> ● Object size after removal: 9.62 kB [↓12.61 kB]
#> … Trying to remove element [[c(3)]], element size = 96 B
#> ✔ Element removed.
#> ● Object size after removal: 9.46 kB [↓12.76 kB]
#> … Trying to remove element [[c(3,1)]], element size = 96 B
#> ✖ Element could not be removed without breaking results.
#> … Trying to remove element [[c(2)]], element size = 56 B
#> ✖ Element could not be removed without breaking results.
#> … Trying to remove element [[c(4)]], element size = 56 B
#> ✔ Element removed.
#> ● Object size after removal: 9.31 kB [↓12.91 kB]
#> … Trying to remove element [[c(3,2)]], element size = 56 B
#> ✔ Element removed.
#> ● Object size after removal: 9.17 kB [↓13.06 kB]
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

For more information about how to use `daTrimmer`, please take a look at
the vignette:

``` r
vignettes("daTrimmer")
```

Enjoy `daTrimmer`\! :)
