# This script downloads and cleans data to be imported in cadáveres
# inmobiliarios' database.


# Packages and dependencies -----------------------------------------------

# Load required packages and install them if they are not available.
require(googlesheets)
suppressMessages(require(dplyr))
require(tidyr)


# Ruinas modernas ---------------------------------------------------------

# Data import

# Loading 'Clon de cadáveres desenterrados' spreadsheet using its key.
ss = gs_key("1cV4K6ZihxRAzwlae1Pp6kIlW-o9JpmIDRpy98cQQk6I")


# Cleanup and manipulations

data_ruinas_modernas = ss %>%
  gs_read(ws = 1, range = cell_cols(2:86)) %>%
  filter(complete.cases(latitud_longitud)) %>%
  separate(latitud_longitud,c("latitud","longitud"), ",")

# Adding new information for future classification on the website.

data_ruinas_modernas$corpse_category = "Desenterrado"

write.csv(data_ruinas_modernas,
          file = "data/cadaveres.desenterrados.ruinas_modernas.csv",
          na = "")


# Nación rotonda ----------------------------------------------------------

data_nacion_rotonda = read.csv(
  'data/input/BBDD cadáveres inmobiliarios Nación Rotonda.csv')

# Cleanup and manipulations
data_nacion_rotonda$Location = gsub('<Point><coordinates>|</coordinates></Point>',
                                    '',
                                    data_nacion_rotonda$Location)

data_nacion_rotonda$Location = gsub(',0.0',
                                    '',
                                    data_nacion_rotonda$Location)

data_nacion_rotonda = data_nacion_rotonda %>%
  rename(nombre_promocional = Name) %>%
  rename(enlace_web = Haz.Click.Aquí) %>%
  filter(complete.cases(nombre_promocional)) %>%
  separate(Location,c('longitud','latitud'), ",")

# Adding new information for future classification on the website.

data_nacion_rotonda$corpse_category = "Desenterrado"

write.csv(data_nacion_rotonda,
          file = "data/cadaveres.desenterrados.nacion_rotonda.csv",
          na = "")

