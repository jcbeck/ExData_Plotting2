require(plyr)

# Load data
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# Set names of variables
names(NEI) <- tolower(names(NEI))
names(SCC) <- tolower(names(SCC))

# Show SCC data with Ecological Inference sectors
levels(SCC$ei.sector)

# Look for anything starting with fuel combustion ("Fuel Comb")
# and anything ending in 'Coal'.
q4.scc <- SCC[grep("^Fuel Comb .* Coal$", SCC$ei.sector), ]

# Remove unnecessary factor levels
q4.scc$scc <- factor(q4.scc$scc)

# Summarize for filtered SCCs all emissions on an annual basis
q4 <- ddply(NEI[NEI$scc %in% q4.scc$scc, ], ~ year, summarize, 
            "Total PM2.5 Emissions In Tons" = sum(emissions))

# Create base plot
png(filename = "plot4.png")
plot(q4, type = "b", 
     main = "Total Emissions From Coal Combustion-Related Sources")

#Shutdown the device
dev.off()