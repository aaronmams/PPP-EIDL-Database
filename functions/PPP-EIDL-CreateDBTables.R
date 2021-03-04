###############################################################################
# Script to read-in all the .csv files from the 02-01-21 Paycheck Protection Program Data
#   directory and teh 12-0120-EIDL Advance Data directory and prepare the data for upload to DB

# We will organize the source data into multiple tables with the following fields in each table:

# ppp_awards - 
#     + loan number (LoanNumber)
#     + date approved (DateApproved)
#     + SBA office   (SBAOfficeCode)
#     + processing method  (ProcessingMethod)
#     + borrower name      (BorrowerName)
#     + borrower ID (a field I create: pppBorrowerID)   
#     + initial approval amount    (InitialApprovalAmount)
#     + current approval amount    (CurrentApprovalAmount)
#     + jobs reported               (JobsReported)


# eidl_awards - 
#     + loan date (ACTIONDATE)
#     + unique borrower ID (FAIN)
#     + borrower name   (BorrowerName)
#     + derived unique borrower ID  (eidlBorrowerID)
#     + funding amount      (FEDERALACTIONOBLIGATION)
#     + non-federal funding amount (NONFEDERALFUNDINGAMOUNT)   
#     + award ID    (eidlAwardID)

# ppp_entity details - 
#     + borrower name  (BorrowerName)
#     + borrower ID    (pppBorrowerID)
#     + borrower address (BorrowerAddress)
#     + borrower city    (BorrowerCity)
#     + borrower zip    (BorrowerZip)
#     + borrower state  (BorrowerState)
#     + franchise name  (FranchiseName)
#     + NAICS code      (NAICSCode)
#     + race/ethnicity   (RaceEthnicity)
#     + business type    (BusinessType)
#     + gender           (Gender)
#     + veteran          (Veteran)
#     + non profit       (NonProfit)


# eidl_entity details - 
#     + borrower name  (BorrowerName)
#     + borrower ID    (eidlBorrowerID)
#     + borrower address line 1 (BorrowerAddress)
#     + borrower address line 2 (LEGALENTITYADDRLINE2)
#     + borrower address line 3 (LEGALENTITYADDRLINE3)
#     + borrower city    (BorrowerCity)
#     + borrower zip    (LEGALENTITYZIP5)
#     + borrower zip last 4 (LEGALENTITYZIPLAST4)
#     + borrower state  (LEGALENTITYSTATECD)
#     + borrower country  (LEGALENTITYCOUNTRYCD)
#     + borrower city (foreign)      (LEGALENTITYFOREIGNCITYNAME)
#     + borrower province (foreign)   (LEGALENTITYFOREIGNPROVINCENAME)
#     + borrower postal code    (LEGALENTITYFOREIGNPOSTALCD)
#     + borrower congressional district           (LEGALENTITYCONGRESSIONALDISTRICT)
#     + business type          (BUSINESSTYPE)


# ppp_award details - 
#     + loan number  (LoanNumber)
#     + loan status date   (LoanStatusDate)
#     + loan status        (LoanStatus)
#     + term               (Term)
#     + SBA guaranty percentage    (SBAGuarantyPercentage)
#     + servicing lender location ID  (ServicingLenderLocationID)
#     + servicing lender name         (ServicingLenderName)
#     + servicing lender address      (ServicingLenderAddress)
#     + servicing lender city         (ServicingLenderCity)
#     + servicing lender state        (ServicingLenderState)
#     + servicing lender zip          (ServicingLenderZip)
#     + rural/urban indicator         (RuralUrbanIndicator)
#     + hub zone indicator            (HubzoneIndicator)
#     + LMI indicator                 (LMIIndicator)
#     + project city                  (ProjectCity)
#     + project state                 (ProjectState)
#     + project zip                   (ProjectZip)
#     + project county name           (ProjectCountyName)
#     + CD                            (CD)
#     + utilities proceed              (UTILITIES_PROCEED)
#     + payroll proceed                (PAYROLL_PROCEED)
#     + mortgage interest proceed      (MORTGAGE_INTEREST_PROCEED)
#     + rent proceed                   (RENT_PROCEED)
#     + refinance EIDL proceed         (REFINANCE_EIDL_PROCEED)
#     + health care proceed            (HEALTH_CARE_PROCEED)
#     + debt interest proceed           (DEBT_INTEREST_PROCEED)
#     + originating lender location ID   (OriginatingLenderLocationID)
#     + originating lender               (OriginatingLender)
#     + originating lender city          (OriginatingLenderCity)
#     + originating lender state         (OriginatingLenderState)
#     + 


# eidl_award details - 
#     + award ID - (eidlAwardID)
#     + action type  (ACTIONTYPE)
#     + assistance type   (ASSISTANCETYPE)
#     + record type        (RECORDTYPE)
#     + award modification               (AWARDMODIFICATIONAMENDMENTNUM)
#     + uri    (URI)
#     + correction  (CORRECTIONLATEDELETEIND)
#     + SAI NUM         (SAI_NUM)
#     + borrower name      (AWARDEEORRECIPIENTLEGALENTITYNAMEANDDOINGBUSINESSAS)
#     + borrower identifier         (AWARDEEORRECIPIENTUNIQUEIDENTIFIER)
#     + funding agency        (FUNDINGAGENCYCD)
#     + funding sub tier agency code          (FUNDINGSUBTIERAGENCYCODE)
#     + funding office code         (FUNDINGOFFICECD)
#     + awarding agency code            (AWARDINGAGENCYCD)
#     + awarding sub tier agency code                 (AWARDINGSUBTIERAGENCYCD)
#     + awarding office code                  (AWARDINGOFFICECD)
#     + CFDA NUM                 (CFDA_NUM)
#     + primary place of performance                   (PRIMARYPLACEOFPERFORMANCECD)
#     + primary place of performance country                   (PRIMARYPLACEOFPERFORMANCECOUNTRYCD)
#     + primary place of performance zip 4                   (PRIMARYPLACEOFPERFORMANCEZIP.4)
#     + primary place of performance foreign locations        (PRIMARYPLACEOFPERFORMANCEFOREIGNLOCATIONDESC)
#     + primary place of performance congressional district   (PRIMARYPLACEOFPERFORMANCECONGRESSIONALDISTRICT)
#     + award description           (AWARDDESC)
#     + period of performance start date                            (PERIODOFPERFORMANCESTATEDATE)
#     + period of performance current date              (PERIODOFPERFORMANCECURRENTDATE)
#     + loan value                (FACEVALUEOFDIRECTLOANORGUARANTEE)
#     + loan subsidy cost      (ORIGINALLOANSUBSIDYCOST)
#     + business funds indicator                   (BUSINESSFUNDSINDICATOR)

# Table Relationships Are As Follows:

# ppp_awards joins to ppp_awards_detials by the field "LoanNumber"
#
# ppp_awards joins to ppp_entity_details  by the field "BorrowerID"
#
# eidl_awards joins to eidl_awards_details by the field "eidlAwardID"
#
# eidl_awards joins to eidl_entity_details by the field "BorrowerID"
############################################################################################
############################################################################################

rm(list=ls())
library(here)
source(here("functions/PPPSourceDataRead.R"))
source(here("functions/EIDLSourceDataRead.R"))
source(here("functions/StandTextFields.R"))
source(here("functions/CreateEntityID.R"))
source(here("functions/CreateAwardsDBTable.R"))
source(here("functions/CreateEntityDetailsDBTable.R"))
source(here("functions/CreateAwardDetailsDBTable.R"))


ppp.df <- ppp.data.read()
eidl.df <- eidl.data.read()


# clean the text fields in source data (trim all leading and trailing whitespace + standardize values to all-caps)
ppp.df <- stand.text.fields(dataframe=ppp.df)
eidl.df <- stand.text.fields(dataframe=eidl.df)

#rename columns in EIDL to make them compatable with PPP column names
eidl.df <- eidl.df %>% mutate(BorrowerName=AWARDEEORRECIPIENTLEGALENTITYNAMEANDDOINGBUSINESSAS,
                              BorrowerAddress=LEGALENTITYADDRLINE1,
                              BorrowerCity=LEGALENTITYCITYNAME)

#fix the borrower names in the EIDL Data.
eidl.df <- eidl.df %>% mutate(BorrowerName=trimws(str_replace(BorrowerName,"DBA.*","")))

# create a unique "entity ID"
t <- Sys.time()
ppp.df <- create.ppp.entityID(ppp.data=ppp.df)
eidl.df <- create.eidl.entityID(eidl.data=eidl.df)
Sys.time() - t

# create an "award ID" for the eidl data...the field FAIN looks like a unique business/borrower
#   identifier. If we pair this with a date we can create a unique award or loan ID
eidl.df <- eidl.df %>% mutate(eidlAwardID=paste(eidlBorrowerID,"_",ACTIONDATE,sep=""))

#create the "ppp_awards" table
ppp.awards.table <- create.pppawards.DBtable(ppp.data=ppp.df)
eidl.awards.table <- create.eidlawards.DBtable(eidl.data=eidl.df)

# create the "entity details" table
ppp.entity.details.table <- create.pppentity.details.DBtable(ppp.data=ppp.df)
eidl.entity.details.table <- create.eidlentity.details.DBtable(eidl.data=eidl.df)
  
#create "award details" table
pppaward.details.table <- create.pppaward.details.DBtable(ppp.data=ppp.df)
eidlaward.details.table <- create.eidlaward.details.DBtable(eidl.data=eidl.df)


