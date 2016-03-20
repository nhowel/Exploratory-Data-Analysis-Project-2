#This plot attempts to answer the question: 
#Compare emissions from motor vehicle sources in Baltimore City with emissions from 
#motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

library(dplyr)
library(ggplot2)

#read files from working directory
setwd("C:/Users/natehow/Coursera/Course4")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

emissionsDF <- tbl_df(NEI)

#create city table
citynames <- c("Baltimore","Los Angeles")
fips <- c("24510","06037")
cities <- data.frame(citynames,fips)

#filter by type == ONROAD and Baltimore (fips == 24510) or LA (fips == 06037).
vehicleemissions <- filter(emissionsDF,type == "ON-ROAD")
cityemissions <- filter(vehicleemissions, fips == "06037" | fips == "24510")
withcitynames <- merge(cityemissions,cities,by = "fips")
byyear <- group_by(withcitynames,year,citynames)
yeartotals <- summarize(byyear,"totalPM2.5"=sum(Emissions))

#Contruct plot
png("plot6.png",width = 480,height = 480)
a <- ggplot(yeartotals,aes(x = year,y = totalPM2.5))
a <- a + geom_point(color="blue",size = 4) + facet_wrap(~citynames)
a <- a + geom_smooth(method = "lm",color = "red", se = FALSE, size = 2)
a <- a + labs(title = "PM2.5 Emissions from Motor Vehicles in Baltimore and Los Angeles",
              x = "Year",y = "Vehicle PM2.5 Emissions (tons)")
print(a)
dev.off()