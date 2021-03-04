
# function to write R data frames to our database.

# function is very simple: 

# -- establishes connection to the GCP Database
# -- writes R data frames to DB tables

source(here("functions/GCP-SBA-connect.R"))


ppp_eidlDBWrite <- function(){
  
# just testing out the DB write table with these large data
t <- Sys.time()
#dbWriteTable(cn,"ppp_awards",awards.table[1:100000,],overwrite=F,append=T)
dbWriteTable(cn, "ppp_awards",ppp.awards.table[1:500000,],overwrite=T)
Sys.time() - t

t <- Sys.time()
dbWriteTable(cn,"eidl_awards",eidl.awards.table[1:500000,],overwrite=F,append=T)
Sys.time() - t

dbWriteTable(cn,"eidl_entity_details",eidl.entity.details.table[1:500000,],overwrite=F,append=T)
}