# This file contains all common variables, functions, colors... setup and
# dependencies within this project. All other files should reference this file.

# Packages and dependencies -----------------------------------------------

# Load required packages and install them if they are not available.
require(dplyr)
require(tidyr)



# Data import -------------------------------------------------------------

# Import Data file.
data1 = read.csv("data/Murcia_c_inmobiliarios.csv",
                 na.strings = c("", "-", "--", "NA"))
data2 = read.csv("data/Andalucia_c_inmobiliarios.csv",
                 na.strings = c("", "-", "--", "NA"))


# Combining data sets -----------------------------------------------------

data = rbind(data1, data2)

# Data manipulation -------------------------------------------------------

# Split latitude and latitude column into separate variables.
data = data %>%
  filter(complete.cases(Latitud..Longitud.)) %>%
  separate(Latitud..Longitud.,c("Latitud","Longitud"), ",")


# Export file again -------------------------------------------------------

write.csv(data, file = "data/data_clean.csv", na = "")
