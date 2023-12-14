library(testthat)
library(YaokumahWorldPopulation)
library(tidyverse)

# Define a test case

test_that("CountryPopulation does not throw an error for a valid country", {
  expect_no_error(YaokumahWorldPopulation::CountryPopulation("Ghana"))
})


test_that("CountryPopulation throws an error for non-existent country", {
    expect_error(YaokumahWorldPopulation::CountryPopulation("Tema"))
})

