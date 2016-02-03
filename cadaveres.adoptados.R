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

ss_ws = c(1:ss$n_ws) # Number of worksheets.

# Load all worksheets and store them in data frames.
for (i in seq_along(1:ss$n_ws)) {
  data_temp = paste("data", i, sep = "")
  assign(data_temp, gs_read(ss, ws = ss_ws[i], range = cell_cols(1:86)))
}

# Combine all worksheets into a single data frame.
data = rbind(data1, data2, data3, data4, data5, data6, data7,
             data8, data9, data10, data11, data12, data13, data14, data15,
             data16, data17, data18, data19)

# Data manipulation -------------------------------------------------------

# Filtering out unusable rows and split latitude and latitude column into
# separate variables.
data = data %>%
  filter(complete.cases(nombre_promocional)) %>%
  filter(complete.cases(latitud_longitud)) %>%
  separate(latitud_longitud,c("latitud","longitud"), ",") %>%
  # Turn - characters into NA characters.
  replace("-",NA)

# Export file again -------------------------------------------------------

write.csv(data, file = "data/cadaveres.adoptados.csv", na = c("", "-", NA))
