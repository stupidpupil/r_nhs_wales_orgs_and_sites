test_that("7A4BV will produce Abbr, FullName, FullNameWelsh and OrgCode as expected", {

  example <- tibble(
    SiteCode = c("7A4BV")
  ) %>% add_fields_based_on_site_code(fields = c('SiteAbbr', 'SiteFullName', 'SiteFullNameWelsh', 'SiteOrgCode'))

  expect_equal(example$SiteAbbr, 'UHW')
  expect_equal(example$SiteFullName, 'University Hospital of Wales')
  expect_equal(example$SiteFullNameWelsh, 'Ysbyty Athrofaol Cymru')
  expect_equal(example$SiteOrgCode, '7A4')
  expect_equal(length(names(example)), 5)

})

test_that("7A4BV will produce Abbr, FullName and OrgCode as expected even if I omit 'Site' when specifying fields", {

  example <- tibble(
    SiteCode = c("7A4BV")
  ) %>% add_fields_based_on_site_code(fields = c('Abbr', 'FullName', 'OrgCode'))

  expect_equal(example$SiteAbbr, 'UHW')
  expect_equal(example$SiteFullName, 'University Hospital of Wales')
  expect_equal(example$SiteOrgCode, '7A4')
  expect_equal(length(names(example)), 4)

})

test_that("7A4BV will produce Abbr, FullName and OrgCode as expected with a prefix", {

  example <- tibble(
    AdmissionSiteCode = c("7A4BV")
  ) %>% add_fields_based_on_site_code(prefix = 'Admission', fields = c('SiteAbbr', 'SiteFullName', 'SiteOrgCode'))

  expect_equal(example$AdmissionSiteAbbr, 'UHW')
  expect_equal(example$AdmissionSiteFullName, 'University Hospital of Wales')
  expect_equal(example$AdmissionSiteOrgCode, '7A4')
  expect_equal(length(names(example)), 4)

})

test_that("7A4BV will produce Abbr, FullName and OrgCode as expected even if it has to overwrite some fields", {

  example <- tibble(
    SiteCode = c("7A4BV"),
    SiteAbbr = c("Not Correct"),
    SiteFullName = c("Not Correct")
  ) %>% add_fields_based_on_site_code(fields = c('SiteAbbr', 'SiteFullName', 'SiteOrgCode'))

  expect_equal(example$SiteAbbr, 'UHW')
  expect_equal(example$SiteFullName, 'University Hospital of Wales')
  expect_equal(example$SiteOrgCode, '7A4')
  expect_equal(length(names(example)), 4)

})

test_that("7A4BV will produce Name, ShortName and SiteIsBig as expected", {

  example <- tibble(
    SiteCode = c("7A4BV"),
  ) %>% add_fields_based_on_site_code(fields = c('SiteName', 'SiteShortName', 'SiteIsBig'))

  expect_equal(example$SiteName, 'UHW')
  expect_equal(example$SiteShortName, 'UHW')
  expect_equal(example$SiteIsBig, TRUE)
  expect_equal(length(names(example)), 4)

})

test_that("7A3B7 will produce Abbr, FullName and OrgCode (as CTM) as expected", {

  example <- tibble(
    SiteCode = c("7A3B7")
  ) %>% add_fields_based_on_site_code(fields = c('SiteAbbr', 'SiteFullName', 'SiteOrgCode'))

  expect_equal(example$SiteAbbr, 'PoW')
  expect_equal(example$SiteFullName, 'Princess of Wales Hospital')
  expect_equal(example$SiteOrgCode, '7A5')

})

test_that("7A4FA will produce Abbr, FullName and OrgCode as expected (and as if it were 7A4C1)", {

  example <- tibble(
    SiteCode = c("7A4FA")
  ) %>% add_fields_based_on_site_code(fields = c('SiteAbbr', 'SiteFullName', 'SiteOrgCode'))

  expect_equal(example$SiteAbbr, 'UHL')
  expect_equal(example$SiteFullName, 'University Hospital Llandough')
  expect_equal(example$SiteOrgCode, '7A4')

})

test_that("7A4FA will produce Abbr, FullName (with a qualifier) and OrgCode as expected if prefix is set to expand", {
  
  example <- tibble(
    SiteCode = c("7A4FA")
  ) %>% add_fields_based_on_site_code(fields = c('SiteAbbr', 'SiteFullName', 'SiteOrgCode'), aliases = 'expand')

  expect_equal(example$SiteAbbr, 'UHL')
  expect_equal(example$SiteFullName, 'University Hospital Llandough (Hafan y Coed)')
  expect_equal(example$SiteOrgCode, '7A4')

})

test_that("E9E8P will produce Abbr, Name and OrgCode as expected (and as if it were 7A2AG)", {

  example <- tibble(
    SiteCode = c("E9E8P")
  ) %>% add_fields_based_on_site_code(fields = c('SiteAbbr', 'SiteName', 'SiteOrgCode'))

  expect_equal(example$SiteAbbr, 'GGH')
  expect_equal(example$SiteName, 'Glangwili')
  expect_equal(example$SiteOrgCode, '7A2')

})

test_that("7A5ZZ will produce Abbr, FullName and OrgCode as expected", {
  
  example <- tibble(
    SiteCode = c("7A5ZZ")
  ) %>% add_fields_based_on_site_code(fields = c('SiteAbbr', 'SiteFullName', 'SiteOrgCode'))

  expect_equal(example$SiteAbbr, 'Other')
  expect_equal(example$SiteFullName, 'Other Site')
  expect_equal(example$SiteOrgCode, '7A5')

})


test_that("7A5ZZ will produce Abbr, FullName and OrgCode as expected with a prefix", {
  
  example <- tibble(
    AdmissionSiteCode = c("7A5ZZ")
  ) %>% add_fields_based_on_site_code(prefix = 'Admission', fields = c('SiteAbbr', 'SiteFullName', 'SiteOrgCode'))

  expect_equal(example$AdmissionSiteAbbr, 'Other')
  expect_equal(example$AdmissionSiteFullName, 'Other Site')
  expect_equal(example$AdmissionSiteOrgCode, '7A5')

})

