test_that("7A4 will produce Abbr, Name, FullName and OrgFullNameWelsh as expected", {

  example <- tibble(
    OrgCode = c("7A4")
  ) %>% add_fields_based_on_org_code(fields = c('OrgAbbr', 'OrgName', 'OrgFullName', 'OrgFullNameWelsh'))

  expect_equal(example$OrgAbbr, 'CV')
  expect_equal(example$OrgName, 'Cardiff & Vale')
  expect_equal(example$OrgFullName, 'Cardiff & Vale University Health Board')
  expect_equal(example$OrgFullNameWelsh, "Bwrdd Iechyd Prifysgol Caerdydd a'r Fro")

  expect_equal(length(names(example)), 5)
})

test_that("7A4 will produce Abbr, Name and FullName as expected even if I omit 'Org' when specifying fields", {

  example <- tibble(
    OrgCode = c("7A4")
  ) %>% add_fields_based_on_org_code(fields = c('Abbr', 'Name', 'FullName'))

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



test_that("UKN will produce Abbr, Name, FullName and FullNameWelsh as expected", {

  example <- tibble(
    OrgCode = c("UKN")
  ) %>% add_fields_based_on_org_code(fields = c('OrgAbbr', 'OrgName', 'OrgFullName', 'OrgFullNameWelsh'))

  expect_equal(example$OrgAbbr, 'Other')
  expect_equal(example$OrgName, 'Other Organisation')
  expect_equal(example$OrgFullName, 'Other Organisation')
  expect_equal(example$OrgFullNameWelsh, 'Sefydliad Eraill')
  expect_equal(length(names(example)), 5)

})
