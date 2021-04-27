test_that("Chaining with a few site codes works", {
  an_example_tibble <- tibble(
    AdmissionSiteCode = c("7A4BV", "7A3B7", "7A4FA")
  ) %>% 
  add_fields_based_on_site_code(
    prefix = "Admission", 
    fields = c("SiteAbbr", "SiteName", "SiteFullName", "SiteOrgCode")
  ) %>%
  add_fields_based_on_org_code(
    prefix = "AdmissionSite",
    fields = c("OrgName")
  )

  expect_equal(an_example_tibble$AdmissionSiteAbbr, c('UHW', 'PoW', 'UHL'))
  expect_equal(an_example_tibble$AdmissionSiteOrgName, c('Cardiff & Vale', 'Cwm Taf Morgannwg', 'Cardiff & Vale'))

})
