############################
# Make reads matches plots #
############################

#install.packages("taxize")
#install.packages("usethis")
#install.packages("myTAI")
#install.packages("rentrez")

library(taxize)
library(usethis)
library(myTAI)
library(rentrez)
library(ggplot2)


# Read all the files

files <- list.files("data/blast/selected")
l <- list(letters[1:7])
dirs <- paste0("data/blast/selected/", files)

# use a loop to read files into an ugly list

for (i in 1:length(dirs)){
  l[[i]] <- read.csv(file = dirs[i], header = T)
}

# Merge ugly list into a single data.frame
matches <- do.call("rbind", l)

# Get rid of empty rows
matches <- matches %>% filter(is.na(Taxid) == F) #Now the data frame is pretty

# Taxa counts per GC content

taxa_per_gc <- matches %>% group_by(GC_content, Scientific.Name) %>% summarize(count=n())

write.csv(taxa_per_gc, "output/taxa_per_gc.csv")

# separate by high and low
highGC <- taxa_per_gc %>% filter(GC_content == "high") %>% arrange(desc(count))
lowGC <- taxa_per_gc %>% filter(GC_content == "low") %>% arrange(desc(count))

# Ugly barplot
par(mfrow=c(2,1))
barplot(highGC$count, names.arg = highGC$Scientific.Name, las=2, cex.names = 0.5)
barplot(lowGC$count, names.arg = lowGC$Scientific.Name, las=2, cex.names = 0.5)


# pie plot high GC
plot_high <- ggplot(highGC, aes(x="", y=count, fill=Scientific.Name)) +
geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) + labs(title = "Microbiome composition") +
  theme_void() +
  theme(plot.title = element_text(hjust = 0.5))   


# pie plot low GC
plot_low <- ggplot(lowGC, aes(x="", y=count, fill=Scientific.Name)) +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) + labs(title = "Matches of reads with low GC content") +
  theme_void()


# Function to add small legends
addSmallLegend <- function(myPlot, pointSize = 0.5, textSize = 3, spaceLegend = 0.1) {
  myPlot +
    guides(shape = guide_legend(override.aes = list(size = pointSize)),
           color = guide_legend(override.aes = list(size = pointSize))) +
    theme(legend.title = element_text(size = textSize), 
          legend.text  = element_text(size = textSize),
          legend.key.size = unit(spaceLegend, "lines"))
}

#plots with small legends
addSmallLegend(plot_low, pointSize = 1, textSize = 7, spaceLegend = 1)

#Microbiome plot
addSmallLegend(plot_high, pointSize = 0.8, textSize = 7, spaceLegend = 1)






# get taxonomic data

taxonomy <- vector("list",length = nrow(taxa_per_gc))
taxa <- as.vector(taxa_per_gc$Scientific.Name)

for (i in 1:nrow(taxa_per_gc)){
  taxonomy[[i]] <- myTAI::taxonomy(organism = taxa[i], 
                                   db = "ncbi", 
                                   output = "classification")
}

# try to extract taxonomic data

taxonomy_subset <- lapply(taxonomy, '[', 1)
sp.names <- taxa_per_gc$Scientific.Name
 # add species name to each list
names(taxonomy_subset) <- sp.names

a <- do.call(cbind, taxonomy)

ranks <- c('phylum', 'class', 'order', 'family')

tax_subset <- lapply(taxonomy, filter, rank == 'phylum')
  

