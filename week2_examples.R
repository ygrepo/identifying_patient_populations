# bigrquery::bq_deauth()

#unlink('~/.R/gargle/gargle-oauth',recursive = T)

# Remove all variables from environment
#rm(list = ls())
# Clear console
#cat("\014")

library(tidyverse)
library(magrittr)
library(bigrquery)
library(caret)
con <- DBI::dbConnect(drv = bigquery(), project = "learnclinicaldatascience")

## getStats(df, predicted, reference)
getStats <- function(df, ...){
  df %>%
    select_(.dots = lazyeval::lazy_dots(...)) %>%
    mutate_all(funs(factor(., levels = c(1,0)))) %>% 
    table() %>% 
    confusionMatrix()
}

patient_data <- tbl(con, "course3_data.hypertension_goldstandard")