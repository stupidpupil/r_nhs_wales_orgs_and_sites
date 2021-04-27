# NHS Wales Organisations and Sites for R

![R-CMD-check](https://github.com/stupidpupil/r_nhs_wales_orgs_and_sites/actions/workflows/check-release.yaml/badge.svg)

This package is not intended as a replacement for the WRDS, but to provide consistent human-readable names and abbreviations for major secondary care sites and organisations in NHS Wales. It doesn't track site opening and closing and isn't expected to work for all sites with an assigned WRDS site code.

## Example

```R

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

## Abbr, ShortName, Name, FullName

*Abbr* is guaranteed to be 5 characters or shorter, and aims to be 3 characters or shorter for big sites and health boards. 

*Abbr* deliberately omits "U" as a suffix for University Health Boards, to improve discrimination (on the basis of length and word-shape).

*ShortName* aims to be 10 characters or shorter, but has no guarantees.

*Name* will not mention the site or organisation type (e.g. "Ysbyty", "NHS Trust"), but *FullName* will.


## Site Aliases
Some hospital sites are split into multiple 'locations' with different location codes. Some examples would be the Dental Hospital on the UHW site, and the mental health Ablett Unit on the Glan Clwyd site.

`add_fields_based_on_site_code` has three modes of behaviour for these additional location codes, controlled using the `aliases` argument.

The table below shows the effect of these different modes for the example site code `7A1F9`:


| aliases  | Example SiteName         |
|----------|--------------------------|
| collapse | Glan Clwyd               |
| expand   | Glan Clwyd (Ablett Unit) |
| ignore   | NA                       |


The `aliases` argument only affects the *SiteName* and *SiteFullName* fields.
