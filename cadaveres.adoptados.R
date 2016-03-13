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

ss$n_ws # Number of worksheets.
ss_ws = 1:ss$n_ws

# Load all worksheets and store them in data frames.
for (i in seq_along(ss_ws)) {
  data_temp = paste("data", i, sep = "")
  assign(data_temp, gs_read(ss, ws = ss_ws[i], range = cell_cols(1:76)))
}

# Combine all worksheets into a single data frame.
data_raw = rbind(data1, data2, data3, data4, data5, data6, data7,
                 data8, data9, data10, data11, data12, data13, data14, data15,
                 data16, data17, data18, data19)

# Store the file for offline edits.
write.csv(data_raw, file = "data/input/cadaveres.adoptados_raw.csv",
          na = c("", "-","---","------", NA))

# Cleanup: deleting unusued temporary dataframes.
remove(data1, data2, data3, data4, data5, data6, data7,
       data8, data9, data10, data11, data12, data13, data14, data15,
       data16, data17, data18, data19)

# Data manipulation -------------------------------------------------------

# Filtering out unusable rows and split latitude and latitude column into
# separate variables.
data = data_raw %>%
  filter(complete.cases(nombre_promocional)) %>%
  filter(complete.cases(latitud_longitud)) %>%
  separate(latitud_longitud,c("latitud","longitud"), ",") %>%
  # Turn - characters into NA characters.
  replace("-", NA)

# Adding new information for future classification on the website.

data$corpse_category = "Adoptado"
data$superficie_terreno = as.numeric(data$superficie_terreno) / 10000
data$superficie_terreno_units = "area_hectares"
data$superficie_construida_units = "area_square_meters"

# Export file again -------------------------------------------------------

write.csv(data, file = "data/cadaveres.adoptados.csv", na = c("", "-","---","------", NA))


# Some statistics ---------------------------------------------------------

# Count padres_adoptivos' unique values

padres_adoptivos = data %>%
  select(padre_adoptivo) %>%
  filter(complete.cases(padre_adoptivo)) %>%
  gather(variable, value) %>%
  # Split multiple values in separate observations.
  mutate(value = strsplit(as.character(value), ", ")) %>%
  unnest(value) %>%
  group_by(value) %>%
  summarise(Total = n()) %>%
  arrange(desc(Total))

# Count superficie_terreno
superficie_terreno_n = data %>%
  select(superficie_terreno) %>%
  filter(complete.cases(superficie_terreno)) %>%
  summarise(Total = n())

# Count superficie_construida
superficie_construida_n = data %>%
  select(superficie_construida) %>%
  filter(complete.cases(superficie_construida)) %>%
  summarise(Total = n())