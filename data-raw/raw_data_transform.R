## capture args from command line
args <-  commandArgs(trailingOnly=TRUE)

## EXAMPLE in project home directory:
## Rscript ./data-raw/raw_data_transform.R "data-raw/Export Country_1995-2018_eng.xlsx" "data/ge_exports.csv"
## Rscript ./data-raw/raw_data_transform.R "data-raw/Import Country 1995-2018_eng.xlsx" "data/ge_imports.csv"

## load libraries --------------------------------------------------------------
library(here)
library(tidyverse)
library(readxl)

## read raw data ---------------------------------------------------------------
data_raw <- read_xlsx(path = paste0(here::here(), "/", args[1]),
                          sheet = "1995-2017-months_copy")


# data_imports <- read_xlsx(path = paste0(here::here(), "/data-raw/Import Country 1995-2018_eng.xlsx"),
#                           sheet = "1995-2017-months_copy")


# data_exports <- read_xlsx(path = paste0(here::here(), "/data-raw/Export Country_1995-2018_eng.xlsx"),
#                           sheet = "1995-2017-months_copy")


## replace column names with years ---------------------------------------------

## FUNCTION to replace column names#############################################
set_year <- function(x){
  
  for(i in 1:length(x))
    if(grepl("X_", x[i]))
      x[i] <- paste(x[i-1])
    return(x)
}

## exclude first 3 columns
cnames_from4 <- names(data_raw) %>% tail(-3)  

## set the colum name according to the previous
cnames_from4_mod <- set_year(cnames_from4) %>% 
  imap_chr( ~ paste0(.x,"-", .y))

## update column names
names(data_raw)[4:length(names(data_raw))] <- cnames_from4_mod

## modify data -----------------------------------------------------------------
data_raw_mod <- data_raw %>% 
  gather(year, amount_usd, -Code, -Region, -Countries) %>% 
  # filter(amount_usd != "Total") %>%   
  separate(year, c("year", "month_proxy")) %>% 
  filter((as.integer(month_proxy) %% 13) != 0)

## add group indecies corresponding to each year
## NOTE: FAILED in mutate
# data_raw_mod$gp_idx <-  group_indices(data_raw_mod)-1
data_raw_mod$gp_idx <- data_raw_mod %>% 
  group_by(year) %>% 
  group_indices()-1

## add month according to formula based on month_proxy and group index
## NOTE: THIS IS SPECIFIC TO THE STRUCTURE OF THE RAW DATA USED HERE
data_raw_mod <- data_raw_mod %>% 
  mutate(month = as.integer(month_proxy)-(13*gp_idx)) %>% 
  mutate(month_name = month.abb[month]) %>% 
  filter(!is.na(Countries))

## prepare the final dataframe to save -----------------------------------------
ge_imports <- data_raw_mod %>% 
  rename_all(funs(tolower(.))) %>% 
  mutate(amount_usd = as.double(amount_usd)) %>% 
  select(code, region, country = countries, year, month = month_name, amount_usd)

head(ge_imports)
## save dataframe --------------------------------------------------------------

## create data dir if it does not exist
if(!dir.exists(paste0(here::here(), "/data")))
  dir.create(paste0(here::here(), "/data"))

write_csv(ge_imports, paste0(here::here(), "/", args[2])) 