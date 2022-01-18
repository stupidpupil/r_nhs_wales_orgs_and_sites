library(magrittr)
library(dplyr)
library(stringr)

nhs_wales_sites <- readr::read_csv("data-raw/nhs_wales_sites.csv") %>%
  mutate(
    OrgCode = case_when(
      !is.na(OrgCodeOverride) ~ OrgCodeOverride,
      TRUE ~ str_sub(Code, 1, 3)
    ),

    FullNameWelsh = case_when(
      !is.na(FullNameWelsh) ~ FullNameWelsh,
      TRUE ~ FullName
    )

  )

usethis::use_data(nhs_wales_sites, overwrite = TRUE)
