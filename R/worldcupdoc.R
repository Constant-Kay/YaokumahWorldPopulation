#' Scrape and Clean FIFA World Cup Attendance Data
#'
#' This function reads the HTML content of the FIFA World Cup Wikipedia page,
#' extracts the attendance data from a specific table, cleans and formats the
#' data, and then stores it in a data frame.
#'
#' @return A data frame containing FIFA World Cup attendance data.
#'
#' @details
#' The function uses the rvest package to scrape the FIFA World Cup Wikipedia
#' page and extract attendance data from a specific table. The data is then
#' cleaned and formatted, and unnecessary rows are removed. The resulting data
#' frame is stored in the `Attendance` object.
#'
#'
#' Run this example only in interactive mode
#' url <- read_html("https://en.wikipedia.org/wiki/FIFA_World_Cup")
#'
#'
#'
#'
#'  @examples
#'  Example usage of the dataset
#'
#' head(World_Cup)
#'
#'  Additional information visit wikipedia website
"World_Cup"
