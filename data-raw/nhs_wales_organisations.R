library(magrittr)
library(dplyr)
library(stringr)

nhs_wales_organisations <- readr::read_csv("data-raw/nhs_wales_organisations.csv")
usethis::use_data(nhs_wales_organisations, overwrite = TRUE)
