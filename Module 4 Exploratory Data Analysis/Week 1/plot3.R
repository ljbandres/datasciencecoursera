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

png(filename = './plot3.png',
    width = 480, height = 480)

with(data,
     plot(Date,Sub_metering_1,
          lty = 'solid',
          pch ='',
          xlab = '',
          ylab = 'Energy sub metering')
)

lines(data$Date,data$Sub_metering_1,
      col='black')
lines(data$Date,data$Sub_metering_2,
      col='red')
lines(data$Date,data$Sub_metering_3,
      col='blue')

legend("topright",
       legend = c('Sub_metering_1',
                  'Sub_metering_2',
                  'Sub_metering_3'),
       col = c('black','red','blue'),
       lty = 'solid',
       cex = 0.8
       )
dev.off()

