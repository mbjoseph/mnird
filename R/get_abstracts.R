#' Get abstracts for papers in a .bib file
#'
#' By default abstracts are acquired via crossref and the fulltext package
#' under the hood (it may make sense to change this in the future...)
#'
#' @return A data frame with one row per DOI, and a column containing abstract
#' text (if available).
#'
#' @param bibfile Path to a .bib file (character vector)
#' @export
#' @md

get_abstracts <- function(bibfile) {
  dois <- bib2df::bib2df(bibfile)$DOI

  # Suppress false positive warnings about Unknown or uninitialized columns
  suppressWarnings(
    abstract_query <- fulltext::ft_abstract(dois, from = "crossref",
                                            verbose = FALSE)
    )

  abstracts <- lapply(abstract_query$crossref, `[[`, "abstract")
  clean_abstracts <- lapply(abstracts, function(x) {
    ifelse(is.null(x), NA, x)
  })

  tibble::tibble(doi = dois, abstract = unlist(clean_abstracts))
}
