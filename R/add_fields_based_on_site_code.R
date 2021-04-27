add_fields_based_on_org_code <- function(
  in_data, prefix = "",
  fields = c("OrgName")
  ){

  names(nhs_wales_organisations) <- paste0("Org", names(nhs_wales_organisations))

  simple_fields = # Fields that don't need processing to produce
    c("OrgShortName", "OrgName", "OrgFullName", "OrgAbbr")

  fields_from_join <- intersect(fields, simple_fields)

  s <- nhs_wales_organisations %>% select(all_of(c('OrgCode', fields)))

  names(s) <- paste0(prefix, names(s))
  
  fields_to_remove = intersect(colnames(in_data), paste0(prefix, fields))
  
  in_data %>% select(-all_of(fields_to_remove)) %>% left_join(s, by=paste0(prefix, "OrgCode"))
}


add_fields_based_on_site_code <- function(
  in_data, prefix = "",
  fields = c("SiteName", "SiteOrgCode"),
  aliases = "collapse" # collapse, expand, ignore
  ){
  
  simple_fields = # Fields that don't need processing to produce
    c("SiteShortName", "SiteName", "SiteFullName", "SiteAbbr", "SiteIsBig", "SiteOrgCode", "SitePostcode")

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

  if("SiteOrgCode" %in% fields){ # TODO: Fix make this work for missing sites

    nhs_wales_sites <- nhs_wales_sites %>% mutate(
      SiteOrgCode = case_when(
        !is.na(SiteOrgCodeOverride) ~ SiteOrgCodeOverride,
        TRUE ~ str_sub(SiteCode, 1, 3)
      )
    )
  }
  
  s <- nhs_wales_sites %>% select(all_of(c('SiteCode', fields)))
  
  names(s) <- paste0(prefix, names(s))
  
  fields_to_remove = intersect(colnames(in_data), paste0(prefix, fields))
  
  in_data %>% select(-all_of(fields_to_remove)) %>% left_join(s, by=paste0(prefix, "SiteCode"))
}