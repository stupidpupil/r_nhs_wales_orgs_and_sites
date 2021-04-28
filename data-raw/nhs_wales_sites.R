nhs_wales_sites <- readr::read_csv("data-raw/nhs_wales_sites.csv")
usethis::use_data(nhs_wales_sites, overwrite = TRUE)
