## read data
ge_imports <- read_csv(paste0(here::here(), "/data/ge_imports.csv"))
ge_exports <- read_csv(paste0(here::here(), "/data/ge_exports.csv"))

## rename columns
ge_imports <- ge_imports %>%  rename(imports_usd = amount_usd)
ge_exports <- ge_exports %>%  rename(exports_usd = amount_usd)

## join data
ge_trade <- ge_imports %>% 
  full_join(ge_exports)

## save data
readr::write_csv(ge_trade, paste0(here::here(),"/data/ge_trade"))