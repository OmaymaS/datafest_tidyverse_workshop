library(here)
library(tidyverse)
library(readxl)


## read data
data_imports <- read_xlsx(path = paste0(here::here(), "/data-raw/Import Country 1995-2018_eng.xlsx"),
                          sheet = "1995-2017-months_copy")

## replace column names with years ---------------------------------------------
cnames_from4 <- names(data_imports) %>% tail(-3)  ## exclude first 3 columns

## function to replace colun names
set_year <- function(x){
  
  for(i in 2:length(x))
    if(grepl("X", x[i]))
      x[i] <- paste(x[i-1])
    return(x)
}

cnames_from4_mod <- set_year(k) %>% 
  imap_chr( ~ paste0(.x,"-", .y))

names(data_imports)[4:length(names(data_imports))] <- cnames_from4_mod


## modify data
data_imports_mod <- data_imports %>% 
  gather(year, value, -Code, -Region, -Countries) %>% 
  filter(value != "Total") %>% 
  separate(year, c("year", "month_proxy")) %>% 
  group_by(year)

## find group indecies 
## NOTE: FAILED in mutate
data_imports_mod$gp_idx <-  group_indices(data_imports_mod)-1


data_imports_mod <- data_imports_mod %>% 
  mutate(month = as.integer(month_proxy)-(13*gp_idx)) %>% 
  filter(!is.na(Countries))


