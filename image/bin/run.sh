#!/bin/bash

set -o errexit
set -o nounset
set -o xtrace

PREFIX='assembly'
TASK=$1
TMP=$(mktemp -d)
LIBS=${TMP}/libraries.txt
yaml2json < ${INPUT} | jq --raw-output --from-file /usr/local/share/a5_library_file.jq > ${LIBS}

cd $TMP

CMD=$(fetch_task_from_taskfile.sh $TASKFILE $TASK)
eval ${CMD}


# Destination scaffold or contigs file (only "contigs" produced for --metagenome)
ASSEMBLY=${TMP}/assembly.final.scaffolds.fasta
if [ ! -f ${ASSEMBLY} ]; then
  ASSEMBLY=${TMP}/assembly.contigs.fasta
fi
cp ${ASSEMBLY} ${OUTPUT}/contigs.fa


cat << EOF > ${OUTPUT}/biobox.yaml
version: 0.9.0
arguments:
  - fasta:
    - id: contigs_1
      value: contigs.fa
      type: contigs
EOF
