require(plyr)

# Load data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Set names of variables
names(NEI) <- tolower(names(NEI))
names(SCC) <- tolower(names(SCC))

# Show SCC data with Ecological Inference sectors
levels(SCC$ei.sector)

# Look for anything starting with "Mobile - On-Road", 
# and ending in "Vehicles" (1,138)
q5.scc <- SCC[grep("^Mobile - On-Road .* Vehicles$", SCC$ei.sector), ]

# Remove unnecessary factor levels
q5.scc$scc <- factor(q5.scc$scc)

# Summarize all emissions for filtered SCCs in Baltimore on an annual basis
q5 <- ddply(NEI[NEI$scc %in% q5.scc$scc & NEI$fips == "24510", ], ~ year, 
            summarize, 
            total.emissions = sum(emissions))

# Create base plot
png(filename = "plot5.png")
plot(q5, type = "b", 
     main = "Baltimore: Sum of Emissions From\nMotor Vehicle Sources Per Year")
dev.off()