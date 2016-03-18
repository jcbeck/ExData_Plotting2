# Load required libraries
library(plyr)
library(ggplot2)
library(data.table)

# Set working directory
setwd("~/exdata-data-NEI_data")

# Read RDS data for PM2.5 Emissions Data
NEI <- readRDS("summarySCC_PM25.rds")
# Read RDS data for Source Classification Code Table
SCC <- readRDS("Source_Classification_Code.rds")
# Sum of all emissions grouped by individual years
aggregatedata<-with (NEI,aggregate(NEI[,'Emissions'],by=list(year), sum, na.rm=TRUE))
# Change the col names for aggregared data to be more specific
names(aggregatedata) <- c('Year', 'totalemission')
# Open the graphic device to plot the data
png(filename='plot1.png', width=480, height=480, units='px')
# Plot the aggregated data of total emissions from PM2.5 for all the years
plot(aggregatedata, type="l", xlab="Year", ylab="Total PM2.5 Emissions From All Sources BTW '99-'08", 
     col="dark red", xaxt="n", main="Total Emissions In Tons")
# Plot the x-axis that contains the year
axis(1, at=as.integer(aggregatedata$Year), las=1)
# Shut the graphic device
dev.off()