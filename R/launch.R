local_url <- function() {
  "http://127.0.0.1:8050"
}

translate_url <- function(absolute) {
  rstudioapi::translateLocalUrl(local_url(), absolute = absolute)
}

#' Run Python Dash app
#'
#' Helper to run Python Dash app on RStudio Cloud.
#'
#' @param path_app `character`, path to Python file containing the Dash app.
#' @param venv `character` or `NULL`, path to Python virtual environment.
#'   If `NULL`, uses `python` on system path.
#' @param action `character` or `NULL`, action to invoke to before launching
#'   app. If `NULL`, no action. You will have to "refresh" your browser/viewer
#'   after a few seconds.
#'
#' @return Invisible `path_app`, called for side effects.
#'
#' @examples \dontrun{
#'   # not run because this function invokes side-effects
#'   run_dash_app("app,py", venv = "./venv")
#' }
#' @export
#'
run_dash_app <- function(path_app, venv = NULL, action = c("browse", "view")) {

  # validate arguments
  if (!fs::file_exists(path_app)) {
    cli::cli_abort(
      c(
        "Must supply path to existing file:",
        "x" = "File `{path_app}` not found."
      ),
      class = "rscloud_dash_py_error_file_not_found",
      path_app = path_app
    )
  }

  command <- "python"
  if (!is.null(venv)) {
    command <- glue::glue("{venv}/bin/python")
    if (!fs::file_exists(command)) {
      cli::cli_abort(
        c(
          "Virtual environment not valid:",
          "i" = "`venv` specified as `{venv}`.",
          "x" = "File `{command}` not found."
        ),
        class = "rscloud_dash_py_error_venv_not_found",
        command = command
      )
    }
  }

  action <- match.arg(action)

  # get URLs
  trans_path <- glue::glue("/{translate_url(FALSE)}")
  trans_url <- translate_url(TRUE)

  # invoke action
  if (identical(action, "browse")) {
    utils::browseURL(trans_url)
  }

  if (identical(action, "view")) {
    rstudioapi::viewer(trans_url)
  }

  # launch app
  withr::local_envvar(
    # there is some weird interference going on between Dash and RStudio Cloud
    #  - setting DASH_REQUESTS_PATHNAME_PREFIX gets <script> paths to work out.
    #  - setting DASH_PROXY lets Dash print the working URL to the console.
    list(
      DASH_REQUESTS_PATHNAME_PREFIX = trans_path,
      DASH_PROXY = glue::glue("{local_url()}{trans_path}::{trans_url}")
    )
  )

  system2("python", args = path_app)

  invisible(path_app)
}
