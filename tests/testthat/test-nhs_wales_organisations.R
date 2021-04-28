test_that("No organisation has a Abbr longer than 5 characters", {
  expect_equal(nhs_wales_organisations %>% filter(str_length(Abbr) > 5) %>% nrow(), 0)
})

test_that("No organisation has a ShortName or Name that mentions 'Health Board'", {
  expect_equal(nhs_wales_organisations %>% filter(ShortName %>% str_detect('\\bHealth Board\\b')) %>% nrow(), 0)
  expect_equal(nhs_wales_organisations %>% filter(Name %>% str_detect('\\bHealth Board\\b')) %>% nrow(), 0)
})

test_that("No organisation has a FullName that doesn't mention either 'Health Board' or 'Trust", {
  orgs_other_than_unknown <- nhs_wales_organisations %>% filter(Code != 'XXX')
  expect_true(orgs_other_than_unknown %>% pull(FullName) %>% 
    str_detect('\\b(Health Board|Trust)\\b') %>% all())
})


test_that("All organisations have a unique Code, Abbr, Name, ShortName, Name and FullName", {
  count_of_orgs <- nhs_wales_organisations %>% nrow()

  expect_equal(nhs_wales_organisations %>% pull(Code) %>% n_distinct(), count_of_orgs)
  expect_equal(nhs_wales_organisations %>% pull(Abbr) %>% n_distinct(), count_of_orgs)
  expect_equal(nhs_wales_organisations %>% pull(Name) %>% n_distinct(), count_of_orgs)
  expect_equal(nhs_wales_organisations %>% pull(ShortName) %>% n_distinct(), count_of_orgs)
  expect_equal(nhs_wales_organisations %>% pull(Name) %>% n_distinct(), count_of_orgs)
  expect_equal(nhs_wales_organisations %>% pull(FullName) %>% n_distinct(), count_of_orgs)
})
