test_that("get_document_terms returns a TermDocumentMatrix", {
  skip_on_travis()
  abstract_df <- get_abstracts(terms = c(
    "deep-learning AND biodiversity AND camera-trap"
    ))
  clean_df <- clean_abstracts(abstract_df)
  dtm <- get_document_terms(clean_df)
  expect_s3_class(dtm, "DocumentTermMatrix")
})
