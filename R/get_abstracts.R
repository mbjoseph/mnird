#' Get abstracts for papers matching search terms
#'
#' @return A tibble with one row per publication matching search terms, with
#' abstracts in one column.
#'
#' @param terms A character vector of search terms to use on Web of Science.
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @export
#' @md

get_abstracts <- function(terms) {
  sid <- rwos::wos_authenticate()
  terms %>%
    lapply(FUN = wosr::pull_wos, sid = sid) %>%
    lapply(function(x) tibble::as_tibble(x$publication)) %>%
    dplyr::bind_rows(.id = "term_idx") %>%
    dplyr::mutate(term_idx = readr::parse_number(.data$term_idx),
                  search_term = terms[.data$term_idx])
}
