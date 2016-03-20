#This plot attempts to answer the question: 
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all 
#sources for each of the years 1999, 2002, 2005, and 2008.

library(dplyr)

#read files from working directory
setwd("C:/Users/natehow/Coursera/Course4")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Add all emissions by year
emissionsDF <- tbl_df(NEI)
byyear <- group_by(emissionsDF,year)
yeartotals <- summarize(byyear,"totalPM2.5"=sum(Emissions))
png("plot1.png",width = 480,height = 480)
with(yeartotals,plot(x = year,y = totalPM2.5, main = "Total PM2.5 Emissions in the U.S.",
                     xlab = "Year",ylab = "Total Emissions (Tons)"))
with(yeartotals,abline(lm(totalPM2.5~year),col = "red",lwd = 2))
dev.off()
