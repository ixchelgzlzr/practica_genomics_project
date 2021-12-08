###################################
#Function to calculate GC content #
###################################

# As output gives an histogram of gc content AND a table for GC content


#Function to calculate GC content
#As output gives an histogram of gc content AND a 
reads_gc_content <- function(reads){
  
  gc_content <- vector(length= length(reads)) #create empty vector
  
  #for loop to calculate GC content per read
  
  for (i in 1:length(reads)) {
    gc_content[i] = GC(as.vector(reads[[i]]))
  }
  
  #adding gc_content per read
  
  #transform sequences to strings
  seq <- vector(length=length(reads))
  for (i in 1:length(reads)){
    seq[i] = c2s(reads[[i]])
  }
  
  #extract sequences names
  names <- vector(length = length(reads))
  for (i in 1:length(reads)){
    names[i] = names(reads)[[i]]
  }
  
 
  #combine the names, sequences and gc content in a dataframe
  df <- data.frame(names, seq, gc_content)
  
  #histogram
  h <- hist(gc_content, breaks = 20)
  plot(h)
  return(df)
}
