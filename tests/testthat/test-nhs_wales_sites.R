test_that("No site has a Abbr longer than 5 characters", {
  expect_equal(nhs_wales_sites %>% filter(str_length(Abbr) > 5) %>% nrow(), 0)
})


test_that("No site has a ShortName, Name or FullName that mentions 'The'", {
  expect_equal(nhs_wales_sites %>% filter(ShortName %>% str_detect('\\bThe\\b')) %>% nrow(), 0)
  expect_equal(nhs_wales_sites %>% filter(Name %>% str_detect('\\bThe\\b')) %>% nrow(), 0)
  expect_equal(nhs_wales_sites %>% filter(FullName %>% str_detect('\\bThe\\b')) %>% nrow(), 0)
})


test_that("No site has a ShortName or Name that mentions 'Hospital'", {
  expect_equal(nhs_wales_sites %>% filter(ShortName %>% str_detect('\\bHospital\\b')) %>% nrow(), 0)
  expect_equal(nhs_wales_sites %>% filter(Name %>% str_detect('\\bHospital\\b')) %>% nrow(), 0)
})


test_that("No site has a ShortName or Name that mentions 'Ysbyty'", {
  expect_equal(nhs_wales_sites %>% filter(ShortName %>% str_detect('\\bYsbyty\\b')) %>% nrow(), 0)
  expect_equal(nhs_wales_sites %>% filter(Name %>% str_detect('\\bYsbyty\\b')) %>% nrow(), 0)
})


test_that("All sites have a unique Code, Abbr, Name, ShortName, Name and FullName", {
  count_of_sites <- nhs_wales_sites %>% nrow()

  expect_equal(nhs_wales_sites %>% pull(Code) %>% n_distinct(), count_of_sites)
  expect_equal(nhs_wales_sites %>% pull(Abbr) %>% n_distinct(), count_of_sites)
  expect_equal(nhs_wales_sites %>% pull(Name) %>% n_distinct(), count_of_sites)
  expect_equal(nhs_wales_sites %>% pull(ShortName) %>% n_distinct(), count_of_sites)
  expect_equal(nhs_wales_sites %>% pull(Name) %>% n_distinct(), count_of_sites)
  expect_equal(nhs_wales_sites %>% pull(FullName) %>% n_distinct(), count_of_sites)
})
