#' Generate Population Trends Graph for a Specific Country
#'
#' This function takes a country name and generates a population trends graph
#' over the years from 1950 to 2020 using the WorldPopulation data.
#'
#' @param country_name A character string specifying the country for which the
#'                     population trends graph should be generated.
#' @param title An optional parameter specifying the title of the graph. If not
#'              provided, a default title will be used.
#'
#' @return A ggplot object representing the population trends graph for the
#'         specified country.
#'
#' @details
#' The function filters the WorldPopulation data for the specified country,
#' pivots the data to long format, and creates a ggplot object with a point plot
#' showing the population trends over the years.
#'
#' @import dplyr
#' @import ggplot2
#' @import tidyr
#' @examples
#' # Example usage of the dataset
#'
#' head(WorldPopulation)
#'
#' CountryPopulation("Ghana")
#'
#' # Additional examples go here (WorldPopulation Site)
CountryPopulation <- function(country_name,title = NULL) {
  if (!country_name %in% WorldPopulation$Country_Name) {
    stop(paste("Country", country_name, "does not exist in the WorldPopulation data."))
  }

  country_data <- WorldPopulation %>%
    filter(`Country_Name` == country_name) %>%
    pivot_longer(
      `1950`:`2020`,
      names_to  = 'Years',
      values_to = 'Populations') %>%
    mutate(Year = as.integer(Years),
           Population = as.numeric(Populations)) %>% select(Country_Name,Year,Population) %>% data.frame()

  # Create ggplot object
  country_plot <- ggplot(country_data, aes(x = Year, y = Population)) +
    geom_point(size = 1) +
    labs(title = ifelse(is.null(title), paste("Population Trends for", country_name), title),
         x = "Year",
         y = "Population") +
    theme_minimal()

  return(country_plot)
}
