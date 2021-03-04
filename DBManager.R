##############################################################################
##############################################################################
##############################################################################
# Primary Script to Initialize our Cloud Database to Warehouse PPP & EIDL Data

rm(list=ls())
library(here)

# reads in source data from .csv files, cleans it, organizes into multiple 
#   R data frames
source(here('functions/PPP-EIDL-CreateDBTables.R'))

# function to write the R data frames to MySQL Database Tables
source(here('functions/PPP-EIDL-DBWrite.R'))
ppp_eidlDBWrite()

