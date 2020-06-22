test_that("Abstracts are returned", {
  skip_on_travis()
  abstracts <- get_abstracts("deep learning AND biodiversity AND camera trap")
  expect_s3_class(abstracts, "tbl_df")
})
