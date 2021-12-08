###############
# 
#################

# Load libraries
library(seqinr)
library(dplyr)
library(seqRFLP)
library(stringr)

# read fasta files
filenames <- list.files("data/fasta")
paths <- paste0("data/fasta/", filenames)
object_names <- filenames %>% str_remove("sample_") %>% str_remove("_R1.fasta")

data <- lapply(paths, seqinr::read.fasta)
names(data) = object_names

#load function
source("GC_cont_function.R")

#Get GC content databases
gc <- lapply(data, reads_gc_content)

##################### Now let's work individualy with each sample
#load function
source("filter_per_GC.R")

#########
# IG005 #
#########

  #see the plot for IG005
reads_gc_content(data$IG005)

  #modes at 0.45 and 0.65
lowGC_IG005 <- filter_per_gc(gc$IG005, gc_content, 0.3, 0.5)
highGC_IG005 <- filter_per_gc(gc$IG005,gc_content, 0.65, 0.8)

  #export the files
dataframe2fas(lowGC_IG005[1:2], file = "output/low_IG005.fasta")
dataframe2fas(highGC_IG005[1:2], file = "output/high_IG005.fasta")


#########
# IG006 #
#########

#see the plot for IG006
reads_gc_content(data$IG006)

#modes at 0.5 and 0.7
lowGC_IG006 <- filter_per_gc(gc$IG006, gc_content, 0.35, 0.52)
highGC_IG006 <- filter_per_gc(gc$IG006,gc_content, 0.7, 0.85)

#export the files
dataframe2fas(lowGC_IG006[1:2], file = "output/low_IG006.fasta")
dataframe2fas(highGC_IG006[1:2], file = "output/high_IG006.fasta")


#########
# IG007 #
#########

#see the plot for IG007
reads_gc_content(data$IG007)

#modes at 0.5 and 0.7
lowGC_IG007 <- filter_per_gc(gc$IG007, gc_content, 0.35, 0.52)
highGC_IG007 <- filter_per_gc(gc$IG007,gc_content, 0.65, 0.85)

#export the files
dataframe2fas(lowGC_IG007[1:2], file = "output/low_IG007.fasta")
dataframe2fas(highGC_IG007[1:2], file = "output/high_IG007.fasta")

#########
# IG008 #
#########

#see the plot for IG008
reads_gc_content(data$IG008)

#the two modes are less clear here, will use the same modes as in the previous one
#modes at 0.5 and 0.7
lowGC_IG008 <- filter_per_gc(gc$IG008, gc_content, 0.35, 0.52)
highGC_IG008 <- filter_per_gc(gc$IG008,gc_content, 0.65, 0.85)

#export the files
dataframe2fas(lowGC_IG008[1:2], file = "output/low_IG008.fasta")
dataframe2fas(highGC_IG008[1:2], file = "output/high_IG008.fasta")


##### GC CONTENT PLOT
par(mfrow=c(2,2))
hist(gc$IG005$gc_content, breaks = 20, col = "cyan3", main = "IG005", xlab = "Proportion of GC content")
hist(gc$IG006$gc_content, breaks = 20, col = "cyan3", main = "IG006", xlab = "Proportion of GC content")
hist(gc$IG007$gc_content, breaks = 20, col = "cyan3", main = "IG007", xlab = "Proportion of GC content")
hist(gc$IG008$gc_content, breaks = 20, col = "cyan3", main = "IG008", xlab = "Proportion of GC content")
