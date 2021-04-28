nhs_wales_sites <- readr::read_csv("data-raw/nhs_wales_sites.csv") %>%
  mutate(
    OrgCode = case_when(
      !is.na(OrgCodeOverride) ~ OrgCodeOverride,
      TRUE ~ str_sub(Code, 1, 3)
    )
  )

usethis::use_data(nhs_wales_sites, overwrite = TRUE)
