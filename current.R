library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)



main <- function(){
  rows_to_read_ua <- c(6,10,14,18,22,26,30,34,38,42,46,50,54,58,62,66,70,74,78)
  col_names_all <- c("Year", "Quarter", "Population15_24", "Labour Force", "Employment", "Unemployment", "Not in Labour Force", "LB Participation Rate", "Employment Rate", "Unemployment Rate", rep("ExtraCol", 22))  
  unemploymentAge_data <- read_excel("/Users/efeakyurt/Desktop/ML_R_Project/unemployment_ages.xls", col_names = col_names_all)
  unemploymentData <- read_excel("/Users/efeakyurt/Desktop/ML_R_Project/unemployment.xls", skip = 6, col_names = c("Year","Count","Percentage"))
  priceIndex <- read_excel("/Users/efeakyurt/Desktop/ML_R_Project/inflation.xls", skip = 4, col_names = c("Year","January","February","March","April","May","June","July","August","September","October","November","December"))
  
  unemploymentData <- unemploymentData |>
    slice(0:8)
  unemploymentData[8,1] = "2021"
  
  priceIndex <- priceIndex |>
    slice(12:19)|>
    mutate(across(2:last_col(), as.numeric))|>
    mutate(Total = rowSums(across(January:December)), .before = January)
  
  rows_to_read <- c(6,10,14,18,22,26,30,34,38,42,46,50,54,58,62,66,70,74,78)
  unemploymentAge_data <- unemploymentAge_data %>%
    slice(rows_to_read) %>%
    select(c("Year", "Population15_24", "Labour Force", "Employment", "Unemployment", "Not in Labour Force", "LB Participation Rate", "Employment Rate", "Unemployment Rate")) %>%
    arrange(-row_number())
  
  View(priceIndex)
  View(unemploymentData)
  View(unemploymentAge_data)

}
main()

