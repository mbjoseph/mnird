test_that("get_document_terms returns a TermDocumentMatrix", {
  test_bibfile <- system.file("extdata",
                              "neon-biodiversity-instrumentation-ml.bib",
                              package = "mnird")
  vcr::use_cassette("abstracts", {
    abstract_df <- get_abstracts(test_bibfile)
  })
  dtm <- get_document_terms(abstract_df)
  expect_s3_class(dtm, "DocumentTermMatrix")
})
