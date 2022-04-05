test_that("validation works", {

  # path_app
  expect_error(
    run_dash_app("foo"),
    class = "rscloud_dash_py_error_file_not_found"
  )

  # venv
  tmpfile <- withr::local_tempfile()
  fs::file_create(tmpfile)
  expect_error(
    run_dash_app(path_app = tmpfile, venv = "foo"),
    class = "rscloud_dash_py_error_venv_not_found"
  )
})
