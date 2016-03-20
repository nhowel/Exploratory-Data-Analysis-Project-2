#This plot attempts to answer the question: 
#Of the four types of sources indicated by the type 
#(point, nonpoint, onroad, nonroad) variable, which of these four 
#sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008? Use the ggplot2 
#plotting system to make a plot answer this question.

library(dplyr)
library(ggplot2)

#read files from working directory
setwd("C:/Users/natehow/Coursera/Course4")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

emissionsDF <- tbl_df(NEI)

#filter by Baltimore City (fips ==24510) and group by year and type.
baltimoreemissions <- filter(emissionsDF,fips == "24510")
byyeartype <- group_by(baltimoreemissions,type,year)
yeartotals <- summarize(byyeartype,"totalPM2.5"=sum(Emissions))

#construct plot
png("plot3.png",width = 480,height = 480)
a <- ggplot(yeartotals,aes(x = year,y = totalPM2.5))
a <- a + geom_point() + facet_wrap(~type) + ylim(0,3000)
a <- a + geom_point(color="blue",size = 2) + facet_wrap(~type)
a <- a + geom_smooth(method = "lm",color = "red", se = FALSE)
a <- a + labs(title = "PM2.5 Emissions by Type in Baltimore City",
      x = "Year",y = "TotalPM2.5 Emissions (tons)")
print(a)
dev.off()