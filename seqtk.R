# Use seqtk to sample 500 reads
#make it a loop
for file in *.fastq
do
	seqtk sample -s100 $file 500 > "sample_${file}"
done



#convert fastq to fasta
#make it a loop

for file in sample_*.fastq
do
	seqtk seq -a $file > "fasta/${file%fastq}fasta"
done