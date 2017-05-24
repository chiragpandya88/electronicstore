#loading csv to dataframe
salescsv <- read.csv("refine_original.csv")
sales <- tbl_df(salescsv)

#Cleaning the company variable

company_clean <- function(x,y) {
  for (i in 1:length(y)){
    if (stringdist(x,y[i]) < 5)
      y[i] = x
    }
  return(y)
}

sales$company = company_clean("philips",sales$company)
sales$company = company_clean("akzo",sales$company)
sales$company = company_clean("van houten",sales$company)
sales$company = company_clean("unilever",sales$company)

#Seperating Product code and product number
sales <- separate(sales,"Product.code...number",into = c("product_code","product_number"),sep="-")

#Adding product category
sales <-mutate(sales,product_cat = ifelse(product_code == "p","smartphone",ifelse(product_code == "x","laptop",ifelse(product_code == "v","tv","tablet"))))

#Making the address column
sales <- mutate(sales,full_address=paste(address,city,country,sep = ","))

#Creating Dummy Variables
sales <- mutate(sales,company_philips = as.numeric((company == "philips")))
sales <- mutate(sales,company_akzo = as.numeric((company == "akzo")))
sales <- mutate(sales,company_van = as.numeric((company == "van houten")))
sales <- mutate(sales,company_unilever = as.numeric((company == "unilever")))
sales <- mutate(sales,product_smartphone = as.numeric((product_code == "p")))
sales <- mutate(sales,product_tv = as.numeric((product_code == "v")))
sales <- mutate(sales,product_laptop = as.numeric((product_code == "x")))
sales <- mutate(sales,product_tablet = as.numeric((product_code == "q")))

#Writing the csv file
write.csv(sales,file = "refine_clean.csv")

View(sales)
