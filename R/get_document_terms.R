#' Get a document term matrix from a set of abstracts (or other text)
#'
#' This function takes a tibble as input with a document identifier column, and
#' another column containing document text, and outputs a document-term
#' matrix that can be used for downstream analysis.
#'
#' @param abstracts A data.frame containing a column with DOIs, and another
#' column with abstract text (as a character vector).
#'
#' @return An object of class `tm::DocumentTermMatrix`.
#'
#' @export
#' @md
#' @importFrom magrittr %>%
#' @importFrom rlang .data

get_document_terms <- function(abstracts) {
  abstracts %>%
    dplyr::filter(!is.na(.data$abstract)) %>%
    dplyr::group_by(.data$doi) %>%
    dplyr::summarize(word = stringr::str_split(.data$abstract, " ")) %>%
    tidyr::unnest(.data$word) %>%
    dplyr::mutate(word = tolower(.data$word)) %>%
    dplyr::anti_join(tidytext::stop_words) %>%
    dplyr::group_by(.data$doi) %>%
    dplyr::count(.data$word) %>%
    dplyr::arrange(-.data$n) %>%
    tidytext::cast_dtm(.data$doi, .data$word, .data$n)
}
