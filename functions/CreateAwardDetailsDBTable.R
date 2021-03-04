# very simple function to create the "award details" table for the database

# function take the following inputs:

#      + dataframe - a data frame which should contain data from one of the 
#                     one of the PPP source data .csv files


# function produces the following outputs:

#     + awards - a data frame containing a subset of fields in the supplied
#                 input data frame




#create the "entity details" table
create.pppaward.details.DBtable <- function(ppp.data){
  award.details.fields <- c("LoanNumber","LoanStatus","LoanStatusDate","Term",
                            "SBAGuarantyPercentage","ServicingLenderLocationID","ServicingLenderName",
                            "ServicingLenderAddress","ServicingLenderCity","ServicingLenderState",
                            "ServicingLenderZip","RuralUrbanIndicator","HubzoneIndicator",
                            "LMIIndicator","ProjectCity","ProjectState","ProjectZip",
                            "ProjectCountyName","CD","UTILITIES_PROCEED","PAYROLL_PROCEED",
                            "MORTGAGE_INTEREST_PROCEED","RENT_PROCEED","REFINANCE_EIDL_PROCEED",
                            "HEALTH_CARE_PROCEED","DEBT_INTEREST_PROCEED","OriginatingLenderLocationID",
                            "OriginatingLender","OriginatingLenderCity","OriginatingLenderState")
  
  award.details <- ppp.data %>% select_(.dots=award.details.fields)
  
  return(award.details)
}


create.eidlaward.details.DBtable <- function(eidl.data){
  award.details.fields <- c("ACTIONTYPE","ASSISTANCETYPE","RECORDTYPE","AWARDMODIFICATIONAMENDMENTNUM",
                            "URI","CORRECTIONLATEDELETEIND","SAI_NUM","AWARDEEORRECIPIENTLEGALENTITYNAMEANDDOINGBUSINESSAS",
                            "AWARDEEORRECIPIENTUNIQUEIDENTIFIER","FUNDINGAGENCYCD","FUNDINGSUBTIERAGENCYCD",
                            "FUNDINGOFFICECD","AWARDINGAGENCYCD","AWARDINGSUBTIERAGENCYCD","AWARDINGOFFICECD",
                            "CFDA_NUM","PRIMPLACEOFPERFORMANCECD","PRIMPLACEOFPERFORMANCECOUNTRYCD",
                            "PRIMPLACEOFPERFORMANCEZIP.4","PRIMPLACEOFPERFORMANCEFOREIGNLOCATIONDESC",
                            "PRIMPLACEOFPERFORMANCECONGRESSIONALDISTRICT","AWARDDESC","PERIODOFPERFORMANCESTARTDATE",
                            "PERIODOFPERFORMANCECURRENTENDDATE","FACEVALUEOFDIRECTLOANORLOANGUARANTEE",
                            "ORIGINALLOANSUBSIDYCOST","BUSINESSFUNDSINDICATOR","eidlAwardID")
  award.details <- eidl.data %>% select_(.dots=award.details.fields)
  
}
