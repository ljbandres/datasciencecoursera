library(data.table)
library(dplyr)
library(lubridate)

download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
              './data.zip',
              curl=TRUE)

files <- unzip('./data.zip')

data <- fread(paste0('./',files[1]))

data <- data %>%
  mutate(Date = dmy_hms(paste(Date,Time,sep=' '))) %>%
  filter(Date >= ymd("2007-02-01") & 
         Date < ymd("2007-02-03")) %>%
  select(-Time)

write.csv2(data,'./data_wrangled.csv')

