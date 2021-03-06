% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/launch.R
\name{run_dash_app}
\alias{run_dash_app}
\title{Run Python Dash app}
\usage{
run_dash_app(path_app, venv = NULL, action = c("browse", "view"))
}
\arguments{
\item{path_app}{\code{character}, path to Python file containing the Dash app.}

\item{venv}{\code{character} or \code{NULL}, path to Python virtual environment.
If \code{NULL}, uses \code{python} on system path.}

\item{action}{\code{character} or \code{NULL}, action to invoke to before launching
app. If \code{NULL}, no action. You will have to "refresh" your browser/viewer
after a few seconds.}
}
\value{
Invisible \code{path_app}, called for side effects.
}
\description{
Helper to run Python Dash app on RStudio Cloud.
}
\examples{
\dontrun{
  # not run because this function invokes side-effects
  run_dash_app("app,py", venv = "./venv")
}
}
