# very simple function to create the "entity details" table for the database

# function take the following inputs:

#      + dataframe - a data frame which should contain data from one of the 
#                     one of the PPP source data .csv files


# function produces the following outputs:

#     + awards - a data frame containing a subset of fields in the supplied
#                 input data frame




#create the "entity details" table
create.pppentity.details.DBtable <- function(ppp.data){
  
entity.details.fields <- c("BorrowerName","pppBorrowerID","BorrowerAddress","
                           BorrowerCity","BorrowerState","BorrowerZip",
                           "FranchiseName","NAICSCode","RaceEthnicity",
                           "BusinessType","Gender","Veteran","NonProfit")
entity.details <- ppp.data %>% select_(.dots=entity.details.fields)

# we don't want replication in the entity details...so make sure each entry is 
#   unique
entity.details <- entity.details %>% group_by(pppBorrowerID) %>% 
                   filter(row_number()==1)

return(entity.details)
}


create.eidlentity.details.DBtable <- function(eidl.data){
  
  entity.details.fields <- c("BorrowerName","eidlBorrowerID","BorrowerAddress","
                           BorrowerCity","LEGALENTITYADDRLINE2","LEGALENTITYADDRLINE3",
                             "LEGALENTITYSTATECD","LEGALENTITYZIP5","LEGALENTITYZIPLAST4",
                             "LEGALENTITYCOUNTRYCD","LEGALENTITYFOREIGNCITYNAME",
                             "LEGALENTITYFOREIGNPROVINCENAME","LEGALENTITYFOREIGNPOSTALCD",
                             "LEGALENTITYCONGRESSIONALDISTRICT","BUSINESSTYPES")
                             
                             
  entity.details <- eidl.data %>% select_(.dots=entity.details.fields)
  
  # we don't want replication in the entity details...so make sure each entry is 
  #   unique
  entity.details <- entity.details %>% group_by(eidlBorrowerID) %>% 
    filter(row_number()==1)
  
  return(entity.details)
}