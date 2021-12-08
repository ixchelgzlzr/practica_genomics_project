####################
# Function to filter per gc content
#######################


filter_per_gc <- function(reads, gc_content = gc_content, min = min, max = max){
  subset = as.data.frame(reads) %>% filter(between(gc_content, min, max))
  return(subset)
}

