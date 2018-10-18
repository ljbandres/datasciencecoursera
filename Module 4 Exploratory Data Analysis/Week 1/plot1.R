library(dplyr)

data <- read.csv2(file = './data_wrangled.csv',
                  header = TRUE,
                  stringsAsFactors = FALSE)
data<-data %>%
  select(-X) %>%
  mutate(Date = ymd_hms(Date),
         Global_active_power = as.numeric(Global_active_power),
         Global_reactive_power = as.numeric(Global_reactive_power),
         Voltage = as.numeric(Voltage),
         Global_intensity = as.numeric(Global_intensity),
         Sub_metering_1 = as.numeric(Sub_metering_1),
         Sub_metering_2 = as.numeric(Sub_metering_2),
         Sub_metering_3 = as.numeric(Sub_metering_3))

png(filename = './plot1.png',
    width = 480, height = 480)

with(data,
     hist(Global_active_power,
     breaks = 12,
     main ='Global Active Power',
     col = 'red',
     xlab = 'Global Active Power (kilowatts)')
)

dev.off()
