# very simple function to create the "awards" table for the database

# function take the following inputs:

#      + dataframe - a data frame which should contain data from one of the 
#                     one of the PPP source data .csv files


# function produces the following outputs:

#     + awards - a data frame containing a subset of fields in the supplied
#                 input data frame



create.pppawards.DBtable <- function(ppp.data){
  
award.fields <- c('LoanNumber','DateApproved','SBAOfficeCode','ProcessingMethod','BorrowerName',
                  'pppBorrowerID','InitialApprovalAmount','CurrentApprovalAmount','JobsReported')
awards <- ppp.data %>% select_(.dots=award.fields)
return(awards)
}


create.eidlawards.DBtable <- function(eidl.data){
  award.fields <- c('ACTIONDATE','FAIN','BorrowerName','eidlBorrowerID','FEDERALACTIONOBLIGATION',
                    'NONFEDERALFUNDINGAMOUNT','eidlAwardID')
  awards <- eidl.data %>% select_(.dots=award.fields)
}

