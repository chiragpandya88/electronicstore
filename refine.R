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

#Seperating Product code and product number
sales <- separate(sales,"Product.code...number",into = c("product_code","product_number"),sep="-")

#Adding product category
sales <-mutate(sales,product_cat = ifelse(sales$product_code == "p","smartphone",ifelse(sales$product_code == "x","laptop",ifelse(sales$product_code == "v","tv","tablet"))))
sales


