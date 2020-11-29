## code to prepare `corp_code` dataset goes here

corp_code <- readr::read_csv("./data-raw/corp_code.csv", col_types ="cccd")
colnames(corp_code) <- c('corp_code', 'corp_name', 'stock_name', 'modified_at')
library(dplyr)
corp_code <- corp_code %>%
  mutate(modified_at = lubridate::ymd(modified_at))

usethis::use_data(corp_code, overwrite = TRUE)

