
# Packages and dependencies -----------------------------------------------

# Load required packages and install them if they are not available.
require(dplyr)
require(tidyr)

# Data import -------------------------------------------------------------

# Import Data file.
data = read.csv("http://cadaveresinmobiliarios.org/db/cadaveres.inmobiliarios.csv",
                 na.strings = c("", "-", "--", "NA"))

# Data manipulation -------------------------------------------------------

# Split latitude and latitude column into separate variables.
data = data %>%
  filter(complete.cases(Latitud..Longitud.)) %>%
  separate(Latitud..Longitud.,c("Latitud","Longitud"), ",")


# Export file again -------------------------------------------------------

write.csv(data, file = "data/data_clean.csv", na = "")
