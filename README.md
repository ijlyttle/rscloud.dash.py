
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rscloud.dash.py

<!-- badges: start -->

[![R-CMD-check](https://github.com/ijlyttle/rscloud.dash.py/workflows/R-CMD-check/badge.svg)](https://github.com/ijlyttle/rscloud.dash.py/actions)
<!-- badges: end -->

The goal of rscloud.dash.py is to provide some helper functions to
launch Python Dash apps from RStudio Cloud.

## Installation

You can install the development version of rscloud.dash.py like so:

``` r
devtools::install_github("ijlyttle/rscloud.dash.py")
```

## Example

If you are developing a Python Dash app using RStudio Cloud, you can
launch it with:

``` r
library("rscloud.dash.py")

run_dash_app("dash.py", venv = "./venv")
```

This will open your local browser to the Dash App, but **you will have
to reload** the page after a few seconds, because the browser is
launched *before* the Dash app is launched. It has to be in this order
because the launching the app consumes the R session. I know there has
to be a clever way to get around this, but `¯\_(ツ)_/¯`.
