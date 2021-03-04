# script that we will .gitignore that establishes connection to the GCP Database 

library(DBI)
library(odbc)
library(RODBC)

cn <- dbConnect(drv      = RMySQL::MySQL(), 
                username = "root", 
                password = "nmfsswfsc", 
                host     = "35.230.120.237", 
                port     = 3306, 
                dbname   = "SBALoans")

