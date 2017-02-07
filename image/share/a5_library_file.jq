.arguments[] | select(has("fastq")) | .fastq | map("[LIB]\nshuf=\(.value)") | join("\n")
