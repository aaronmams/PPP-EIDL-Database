# very simple function to read EIDL source data from the collection of .csv files
library(here)

eidl.data.read <- function(){
  
  eidl1 <- read.csv(here('source-data/12-01-20 EIDL Advance Data/01 EIDL Advance through 111520.csv'),
                    stringsAsFactors = F)
  eidl2 <- read.csv(here('source-data/12-01-20 EIDL Advance Data/02 EIDL Advance through 111520.csv'),
                    stringsAsFactors = F)
  eidl3 <- read.csv(here('source-data/12-01-20 EIDL Advance Data/03 EIDL Advance through 111520.csv'),
                    stringsAsFactors = F)
  eidl4 <- read.csv(here('source-data/12-01-20 EIDL Advance Data/04 EIDL Advance through 111520.csv'),
                    stringsAsFactors = F)
  eidl5 <- read.csv(here('source-data/12-01-20 EIDL Advance Data/05 EIDL Advance through 111520.csv'),
                    stringsAsFactors = F)
  eidl6 <- read.csv(here('source-data/12-01-20 EIDL Advance Data/06 EIDL Advance through 111520.csv'),
                    stringsAsFactors = F)
  
  eidl.df <- rbind(eidl1,eidl2,eidl3,eidl4,eidl5,eidl6)
  
  
return(eidl.df)  
}