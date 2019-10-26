test_that("get_document_terms returns a TermDocumentMatrix", {
  abstract_df <- system.file("extdata",
                             "neon-biodiversity-instrumentation-ml.bib",
                             package = "mnird") %>%
    get_abstracts()
  dtm <- get_document_terms(abstract_df)
  expect_s3_class(dtm, "DocumentTermMatrix")
})
