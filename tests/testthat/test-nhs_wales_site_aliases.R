test_that("All site aliases map to an existing site", {
  expect_true(all(nhs_wales_site_aliases$AliasTo %in% nhs_wales_sites$Code))
})
