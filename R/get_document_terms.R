#' Get a document term matrix from a set of abstracts (or other text)
#'
#' This function takes a tibble as input with tokenized text, e.g., as
#' created by the `clean_abstracts` function, and generates a document
#' term matrix using word stems.
#'
#' @param abstracts A data.frame containing a column with unique identifiers in
#' a column named "ut", and another called "word_stem".
#'
#' @return An object of class `DocumentTermMatrix`.
#'
#' @md
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export
get_document_terms <- function(abstracts) {
  abstracts %>%
    dplyr::group_by(.data$ut) %>%
    dplyr::count(.data$word_stem) %>%
    dplyr::arrange(-.data$n) %>%
    tidytext::cast_dtm(.data$ut, .data$word_stem, .data$n)
}


#' Clean abstract text
#'
#' This function takes a tibble as input with a document identifier column, and
#' another column containing document text, and outputs a tokenized clean
#' data.frame with word stems.
#'
#' @param abstracts A data.frame containing a column with unique identifiers in
#' a column named "ut", and another
#' column with abstract text (as a character vector).
#'
#' @return A data.frame.
#'
#' @md
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export
clean_abstracts <- function(abstracts) {

  stopwords <- tidytext::get_stopwords()

  abstracts %>%
    dplyr::filter(!is.na(.data$abstract)) %>%
    tidytext::unnest_tokens("word", "abstract") %>%
    dplyr::mutate(word = gsub('[[:digit:]]+', '', .data$word),
                  word = gsub('[[:punct:]]+', '', .data$word),
                  word = trimws(.data$word)) %>%
    dplyr::filter(nchar(.data$word) > 1) %>%
    dplyr::anti_join(stopwords) %>%
    dplyr::mutate(word_stem = SnowballC::wordStem(.data$word))
}
