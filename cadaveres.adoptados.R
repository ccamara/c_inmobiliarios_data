# This script cleans and manipulates data from this google drive spreadsheet:
# https://docs.google.com/spreadsheets/d/1nX0ZQK8I3lg2BO1i0bNsHi6-gGD0OorBNMzoz0o1VsU


# Packages and dependencies -----------------------------------------------

# Load required packages and install them if they are not available.
require(googlesheets)
suppressMessages(require(dplyr))
require(tidyr)

# Data import -------------------------------------------------------------

# Loading 'Clon de Adopta un cadáver' spreadsheet using its key.
ss = gs_key("1PvvaBcSyQP_0SYo2epQcPAU47rA--E_6KSCdMKSQKcg")

data_andalucia = ss %>%
  gs_read(ws = 1, range = cell_cols(1:86))

data_aragon = ss %>%
  gs_read(ws = 2, range = cell_cols(1:86))


# Combining all sheets in a single data frame -----------------------------

data = rbind(data_andalucia,
             data_aragon)

# Data manipulation -------------------------------------------------------

# Filter wrong format columns.

# Split latitude and latitude column into separate variables.
data = data %>%
  filter(complete.cases(latitud_longitud)) %>%
  separate(latitud_longitud,c("latitud","longitud"), ",")


# Export file again -------------------------------------------------------

write.csv(data, file = "data/cadaveres.adoptados.csv", na = "")
