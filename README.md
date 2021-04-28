# NHS Wales Organisations and Sites for R

![R-CMD-check](https://github.com/stupidpupil/r_nhs_wales_orgs_and_sites/actions/workflows/check-release.yaml/badge.svg)

This package is intended to provide a choice of consistent human-readable names and abbreviations for major secondary care sites and organisations in NHS Wales. 

It is not intended as any kind of replacement for reference data services, like the [NHS Digital ODS API](https://digital.nhs.uk/services/organisation-data-service/guidance-for-developers/how-to-obtain-organisation-data-via-the-ods-api-suite) or those provided by WRDS.


## Features and Antifeatures

- Provides a choice of *Abbr* (Abbreviation), *ShortName*, *Name*, *FullName* and *FullNameWelsh* fields
- Covers roughly the 50 biggest hospitals in NHS Wales as of 2021
- Does not cover all active sites in NHS Wales
- Assigns the Princess of Wales and Glanrhyd Hospitals to Cwm Taf Morgannwg
- Optionally collapses distinctions between certain 'sites' in the same geographical location (see [Site Aliases](#site-aliases))

## Example

```R

devtools::install_github("stupidpupil/r_nhs_wales_orgs_and_sites")
library(NHSWalesOrgsAndSites)

an_example_tibble <- tibble(
  AdmissionSiteCode = c("7A4C1")
)

print(an_example_tibble)

# A tibble: 1 x 1
#   AdmissionSiteCode
#   <chr>
# 1 7A4C1

an_example_tibble <- an_example_tibble %>% 
  add_fields_based_on_site_code(
    prefix = "Admission", 
    fields = c("SiteAbbr", "SiteName", "SiteFullName", "SiteOrgCode")
  ) %>%
  add_fields_based_on_org_code(
  	prefix = "AdmissionSite",
  	fields = c("OrgName")
  )

print(an_example_tibble)

# A tibble: 1 x 6
#   AdmissionSiteCode AdmissionSiteAbbr AdmissionSiteName AdmissionSiteFullName         AdmissionSiteOrgCode AdmissionSiteOrgName
#   <chr>             <chr>             <chr>             <chr>                         <chr>                <chr>               
# 1 7A4C1             UHL               Llandough         University Hospital Llandough 7A4                  Cardiff & Vale      

```

## Abbr, ShortName, Name, FullName, FullNameWelsh

*Abbr* is guaranteed to be 5 characters or shorter, and aims to be 3 characters or shorter for big sites and health boards. 

*Abbr* deliberately omits "U" as a suffix for University Health Boards, to improve discrimination (on the basis of length and word-shape).

*ShortName* is guaranteed to be 15 characters or shorter, and aims to be 10 characters or shorter for almost all sites.

*Name* will not mention the site or organisation type (e.g. "Ysbyty", "NHS Trust"), but *FullName* and *FullNameWelsh* will.

None of these will ever start with "The".


## Site Aliases
Some hospital sites are split into multiple 'locations' with different location codes. Some examples would be the Dental Hospital on the UHW site, and the mental health Ablett Unit on the Glan Clwyd site.

`add_fields_based_on_site_code` has three modes of behaviour for these additional location codes, controlled using the `aliases` argument.

The table below shows the effect of these different modes for the example site code `7A1F9`:


| aliases  | Example SiteName         |
|----------|--------------------------|
| collapse | Glan Clwyd               |
| expand   | Glan Clwyd (Ablett)      |
| ignore   | Other Site               |


The `aliases` argument only affects the *SiteName*, *SiteFullName* and *SiteFullNameWelsh* fields. The default is `collapse`.
