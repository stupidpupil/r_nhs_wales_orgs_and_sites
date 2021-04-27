nhs_wales_site_aliases <- readxl::read_xlsx("data-raw/sites_and_orgs.xlsx", sheet="SiteAliases")
usethis::use_data(nhs_wales_site_aliases, overwrite = TRUE)
