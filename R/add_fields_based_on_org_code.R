add_fields_based_on_org_code <- function(
  in_data, prefix = "",
  fields = c("OrgName")
  ){

  names(nhs_wales_organisations) <- paste0("Org", names(nhs_wales_organisations))

  simple_fields = # Fields that don't need processing to produce
    c("OrgShortName", "OrgName", "OrgFullName", "OrgAbbr")

  fields_from_join <- intersect(fields, simple_fields)

  s <- nhs_wales_organisations %>% select(all_of(c('OrgCode', fields)))
  fallback <- s %>% filter(OrgCode == 'XXX') %>% mutate(SiteOrgCode = NA_character_)

  names(s) <- paste0(prefix, names(s))
  names(fallback) <- paste0(prefix, names(fallback))

  in_data %>% 
    select(-any_of(paste0(prefix, fields))) %>% 
    left_join(s, by=paste0(prefix, "OrgCode")) %>%
    replace_na(fallback)
}
