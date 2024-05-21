library(readxl)
library(dplyr)


file_path <- '/Users/efeakyurt/Desktop/ML_R_Project/immigrants_emigrants_age_group_and_sex.xlsx'
data <- read_excel(file_path, skip = 4) 


colnames(data) <- c('Year', 'Age Group', 'Total Population', 'Immigrants Total', 'Immigrants Male', 
                    'Immigrants Female', 'Unknown Column', 'Emigrants Total', 'Emigrants Male', 'Emigrants Female')


data_cleaned <- data %>% select(-`Unknown Column`)  #There was an 'Unknown Column' in the data, so I am droping it


data_cleaned$Year <- as.character(data_cleaned$Year)


data_cleaned <- data_cleaned %>% tidyr::fill(Year, .direction = "down") # Filling the relevant 'Year' values for each age group


data_cleaned$`Age Group` <- paste(data_cleaned$`Age Group`, "(", data_cleaned$Year, ")", sep = "")


final_data <- data_cleaned %>% select(Year, `Age Group`, `Emigrants Total`, `Emigrants Male`, `Emigrants Female`) #Then I have selected the columns I need


head(final_data)
view(final_data)
