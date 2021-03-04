# simple function to read the different PPP .csv files and aggregate them into a 
# single data frame


library(here)

ppp.data.read <- function(){
  

  # very important that character/string values are read-in as such and not converted to factors
  public150plus <- read.csv(here("source-data/02-01-21 Paycheck Protection Program Data/public_150k_plus.csv"),
                            stringsAsFactors = F)
  public_up_to_150k_1 <- read.csv(here("source-data/02-01-21 Paycheck Protection Program Data/public_up_to_150k_1.csv"),
                                  stringsAsFactors = F)
  public_up_to_150k_2 <- read.csv(here("source-data/02-01-21 Paycheck Protection Program Data/public_up_to_150k_2.csv"),
                                  stringsAsFactors = F)
  public_up_to_150k_3<- read.csv(here("source-data/02-01-21 Paycheck Protection Program Data/public_up_to_150k_3.csv"),
                                 stringsAsFactors = F)
  public_up_to_150k_4 <- read.csv(here("source-data/02-01-21 Paycheck Protection Program Data/public_up_to_150k_4.csv"),
                                  stringsAsFactors = F)
  public_up_to_150k_5 <- read.csv(here("source-data/02-01-21 Paycheck Protection Program Data/public_up_to_150k_5.csv"),
                                  stringsAsFactors = F)
  public_up_to_150k_6 <- read.csv(here("source-data/02-01-21 Paycheck Protection Program Data/public_up_to_150k_6.csv"),
                                  stringsAsFactors = F)
  
  
  ppp.df <- rbind(public150plus,
                  public_up_to_150k_1,
                  public_up_to_150k_2,
                  public_up_to_150k_3,
                  public_up_to_150k_4,
                  public_up_to_150k_5,
                  public_up_to_150k_6)
  
return(ppp.df)  
}