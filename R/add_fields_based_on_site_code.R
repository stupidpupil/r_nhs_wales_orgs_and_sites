add_fields_based_on_site_code <- function(
  in_data, prefix = "",
  fields = c("SiteName", "SiteOrgCode"),
  aliases = "collapse" # collapse, expand, ignore
  ){

  fields <- ifelse(str_detect(fields, "^Site"), fields, paste0('Site', fields))

  simple_fields = # Fields that don't need processing to produce
    c("SiteShortName", "SiteName", "SiteFullName", "SiteFullNameWelsh", "SiteAbbr", "SiteIsBig", "SiteOrgCode", "SitePostcode")

  names(nhs_wales_sites) <- paste0("Site", names(nhs_wales_sites))

  if(aliases != "ignore"){

    nhs_wales_site_aliases <- nhs_wales_site_aliases %>%
      left_join(nhs_wales_sites %>% rename(AliasTo = SiteCode), by="AliasTo")

    if(aliases == "expand"){
      nhs_wales_site_aliases <- nhs_wales_site_aliases %>% mutate(
        SiteName = paste0(SiteName, " (", AliasDescription, ")"),
        SiteFullName = paste0(SiteFullName, " (", AliasDescription, ")"),
      )
    }

    nhs_wales_sites <- nhs_wales_sites %>% rbind(
      nhs_wales_site_aliases %>% select(-c(AliasTo, AliasToName, AliasDescription))
    )
  }

  s <- nhs_wales_sites %>% select(all_of(c('SiteCode', fields)))
  fallback <- s %>% filter(SiteCode == 'XXXXX') %>% mutate(SiteOrgCode = NA_character_)

  names(s) <- paste0(prefix, names(s))
  names(fallback) <- paste0(prefix, names(fallback))
    
  ret <- in_data %>% 
    select(-any_of(paste0(prefix, fields))) %>% 
    left_join(s, by=paste0(prefix, "SiteCode")) %>% 
    replace_na(fallback)

  if("SiteOrgCode" %in% fields){

    site_org_code_field <- paste0(prefix, 'SiteOrgCode') %>% sym()
    site_code_field <- paste0(prefix, 'SiteCode') %>% sym()

    ret <- ret %>% mutate(!!site_org_code_field := ifelse(is.na(!!site_org_code_field), str_sub(!!site_code_field, 1, 3), !!site_org_code_field))
  }

  return(ret)
}