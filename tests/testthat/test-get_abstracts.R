test_that("Abstracts are returned, given a bibfile", {
  test_bibfile <- system.file("extdata",
                              "neon-biodiversity-instrumentation-ml.bib",
                              package = "mnird")
  abstracts <- get_abstracts(test_bibfile)
  expect_s3_class(abstracts, "tbl_df")
})
