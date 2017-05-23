#loading csv to dataframe
salescsv <- read.csv("refine_original.csv")
sales <- tbl_df(salescsv)

#Cleaning the company variable

company_clean <- function(x,y) {
  for (i in 1:length(y)){
    if (stringdist(x,y[i]) < 4)
      y[i] = x
    }
  return(y)
}

sales$company = company_clean("phillips",sales$company)
sales$company = company_clean("akzo",sales$company)
sales$company = company_clean("van houten",sales$company)
sales$company = company_clean("unilever",sales$company)

sales$company