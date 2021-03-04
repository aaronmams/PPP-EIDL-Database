# clean text fields is a function that standardizes the names and addresses
#  of businesses in our source data...

# note: we could probably make this a lot more general but this will work 
#    for now


library(stringr)
library(dplyr)

stand.text.fields <- function(dataframe){

  
  # use str_trim() to remove leading and trailing whitespace from character columns
  dataframe <- dataframe %>% mutate_if(is.character,str_trim)
  
  
    # use mutate_if to convert all string coluns to all caps
  dataframe <- dataframe %>% mutate_if(is.character,str_to_upper) 
  
  
#    dataframe <- dataframe %>%
#               mutate(BorrowerName=trimws(toupper(BorrowerName)),
#                      BorrowerAddress=trimws(toupper(BorrowerAddress)),
#                      BorrowerCity=trimws(toupper(BorrowerCity)),
#                      BorrowerState=trimws(toupper(BorrowerState)),
#                      FranchiseName=trimws(toupper(FranchiseName)),
#                      ServicingLenderName=trimws(toupper(ServicingLenderName)),
#                      ServicingLenderAddress=trimws(toupper(ServicingLenderAddress)),
#                      ServicingLenderCity=trimws(toupper(ServicingLenderCity)),
#                      ServicingLenderState=trimws(toupper(ServicingLenderState)),
#                      ProjectCity=trimws(toupper(ProjectCity)),
#                      ProjectCountyName=trimws(toupper(ProjectCountyName)),
#                      ProjectState=trimws(toupper(ProjectState)),
#                      OriginatingLender=trimws(toupper(OriginatingLender)),
#                      OriginatingLenderCity=trimws(toupper(OriginatingLenderCity)),
#                      OriginatingLenderState=trimws(toupper(OriginatingLenderState))
#               )

   return(dataframe)  
}