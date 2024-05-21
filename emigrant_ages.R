library(readxl)
library(dplyr)

# Load the dataset
file_path <- '/Users/efeakyurt/Desktop/ML_R_Project/immigrants_emigrants_age_group_and_sex.xlsx'
data <- read_excel(file_path, skip = 4) # Skip first four rows directly

# Renaming the columns for easier access
colnames(data) <- c('Year', 'Age Group', 'Total Population', 'Immigrants Total', 'Immigrants Male', 
                    'Immigrants Female', 'Unknown Column', 'Emigrants Total', 'Emigrants Male', 'Emigrants Female')

# Dropping the 'Unknown Column' as it appears to be empty
data_cleaned <- data %>% select(-`Unknown Column`)

# Converting 'Year' to character for later operations
data_cleaned$Year <- as.character(data_cleaned$Year)

# Fill missing 'Year' values by propagating the last valid observation forward
data_cleaned <- data_cleaned %>% tidyr::fill(Year, .direction = "down")

# Modify 'Age Group' to include the year, format it as requested
data_cleaned$`Age Group` <- paste(data_cleaned$`Age Group`, "(", data_cleaned$Year, ")", sep = "")

# Selecting the relevant columns as per the requirements
final_data <- data_cleaned %>% select(Year, `Age Group`, `Emigrants Total`, `Emigrants Male`, `Emigrants Female`)

# Print first few rows of the final data
head(final_data)
view(final_data)
