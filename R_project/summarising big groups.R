#######################################
# Summarising the reads of big groups #
#######################################

install.packages('hrbrthemes')
library(viridis)
library(hrbrthemes)


# Read db
d <- read.csv('data/taxa_per_gc_tax.csv')

# Order by Group
d1 <- d %>% group_by(GC_content, Group) %>% summarise(count=n())

# Export
write.csv(d1, 'output/big_groups.csv')

# Read with 0 values added
d2 <- read.csv('data/big_groups.csv', header = T)  

#plotting by taxonomic groups
ggplot(d2, aes(fill=GC_content, y=count, x=Group)) + 
  geom_bar(position="stack", stat="identity") +
  scale_fill_viridis(discrete = T) +
  theme_light() +
  theme(axis.text.x = element_text(angle = 30, vjust = 0.5, hjust=1)) +
  xlab("") +
  ylab("Number of reads matched by BLAST")



#plot by GC content groups
ggplot(d2, aes(fill=Group, y=count, x=GC_content)) + 
  geom_bar(position="stack", stat="identity") +
  scale_fill_viridis(discrete = T) +
  ggtitle("Taxonomic identity of Illumina reads from an Asterella californica field sample") +
  theme_light() +
  xlab("Reads GC content") +
  ylab("Number of reads matched by BLAST")
