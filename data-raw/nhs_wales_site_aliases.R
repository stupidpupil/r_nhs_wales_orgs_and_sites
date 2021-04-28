nhs_wales_site_aliases <- readr::read_csv("data-raw/nhs_wales_site_aliases.csv") %>%
  mutate(
    AliasDescriptionWelsh = case_when(
      !is.na(AliasDescriptionWelsh) ~ AliasDescriptionWelsh,
      TRUE ~ AliasDescription
    )
  )



usethis::use_data(nhs_wales_site_aliases, overwrite = TRUE)
