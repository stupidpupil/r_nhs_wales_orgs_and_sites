test_that("7A4BV will produce Abbr, FullName and OrgCode as expected", {

  example <- tibble(
    SiteCode = c("7A4BV")
  ) %>% add_fields_based_on_site_code(fields = c('SiteAbbr', 'SiteFullName', 'SiteOrgCode'))

  expect_equal(example$SiteAbbr, 'UHW')
  expect_equal(example$SiteFullName, 'University Hospital of Wales')
  expect_equal(example$SiteOrgCode, '7A4')

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



