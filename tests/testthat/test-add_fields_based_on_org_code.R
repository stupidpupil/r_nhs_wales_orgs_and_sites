test_that("7A4 will produce Abbr, Name and FullName as expected", {

  example <- tibble(
    OrgCode = c("7A4")
  ) %>% add_fields_based_on_org_code(fields = c('OrgAbbr', 'OrgName', 'OrgFullName'))

  expect_equal(example$OrgAbbr, 'CV')
  expect_equal(example$OrgName, 'Cardiff & Vale')
  expect_equal(example$OrgFullName, 'Cardiff & Vale University Health Board')
  expect_equal(length(names(example)), 4)

})


test_that("7A4 will produce Abbr, Name and FullName as expected with prefix", {

  example <- tibble(
    AdmissionSiteOrgCode = c("7A4")
  ) %>% add_fields_based_on_org_code(prefix='AdmissionSite', fields = c('OrgAbbr', 'OrgName', 'OrgFullName'))

  expect_equal(example$AdmissionSiteOrgAbbr, 'CV')
  expect_equal(example$AdmissionSiteOrgName, 'Cardiff & Vale')
  expect_equal(example$AdmissionSiteOrgFullName, 'Cardiff & Vale University Health Board')
  expect_equal(length(names(example)), 4)

})
