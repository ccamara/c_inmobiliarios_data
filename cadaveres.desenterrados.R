# This script downloads and cleans data to be imported in cadáveres
# inmobiliarios' database.


# Packages and dependencies -----------------------------------------------

# Load required packages and install them if they are not available.
require(googlesheets)
suppressMessages(require(dplyr))
require(tidyr)

# Data import -------------------------------------------------------------

# Loading 'Clon de cadáveres desenterrados' spreadsheet using its key.
ss = gs_key("1cV4K6ZihxRAzwlae1Pp6kIlW-o9JpmIDRpy98cQQk6I")


# Nación rotonda cleanup and manipulations --------------------------------

data_nacion_rotonda = ss %>%
  gs_read(ws = 1, range = cell_cols(2:86)) %>%
  filter(complete.cases(latitud_longitud)) %>%
  separate(latitud_longitud,c("latitud","longitud"), ",")

# Adding new information for future classification on the website.

data_nacion_rotonda$corpse_category = "Desenterrado"

write.csv(data_nacion_rotonda,
          file = "data/cadaveres.desenterrados.nacion-rotonda.csv",
          na = "")
