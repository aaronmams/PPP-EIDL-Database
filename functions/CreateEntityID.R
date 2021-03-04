
# very simple function to create a unique "entity ID" based on the 
# fields BorrowerName and BorrowerAddress. 

# The assumption is that is 2 observations in the data frame have the same values
#   for "BorrowerName" and "BorrowerAddress" they are the same entity
library(dplyr)

create.ppp.entityID <- function(ppp.data){
  
  # select identifying columns and filter for unique entries only
  ppp.entities <- ppp.data %>% select(BorrowerName,BorrowerAddress,BorrowerCity) %>%
                      group_by(BorrowerName,BorrowerAddress,BorrowerCity) %>%
                      filter(row_number()==1) %>%
                      ungroup() %>%
                      arrange(BorrowerName,BorrowerAddress) %>%
                      mutate(pppBorrowerID=row_number())
  
  ppp.data <- ppp.data %>% left_join(ppp.entities,by=c('BorrowerName','BorrowerAddress','BorrowerCity'))
  
  return(ppp.data)
}
 

create.eidl.entityID <- function(eidl.data){
  #for eidl data the FAIN field is a unique business identifier
  eidl.data <- eidl.data %>% mutate(eidlBorrowerID=FAIN)

return(eidl.data)  
}
