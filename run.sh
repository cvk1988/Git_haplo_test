#!/bin/sh
set -u
#
# Checking args
#
source ./config.sh

if [[ ! -d "$OUT_DIR" ]]; then
    echo "$OUT_DIR does not exist. The folder was created."
    mkdir $OUT_DIR
fi 
#
# Job submission
# 
ARGS="-q $QUEUE -W group_list=$GROUP -M $MAIL_USER -m $MAIL_TYPE"

#
# Bowtie2
#
Prog="Bowtie2_filter_cotton"
export STDERR_DIR="$SCRIPT_DIR/err/$Prog"
export STDOUT_DIR="$SCRIPT_DIR/out/$Prog"

init_dir "$STDERR_DIR" "$STDOUT_DIR"
export BOWOUT="$OUT_DIR/bowtie2/unused_reads"
init_dir $BOWOUT

echo "launching $SCRIPT_DIR/run_bowtie2.sh as a job."

JOB_ID=`qsub $ARGS -v WORKER_DIR,OUT_DIR,STDERR_DIR,STDOUT_DIR -N run_calculator -e "$STDERR_DIR" -o "$STDOUT_DIR" $SCRIPT_DIR/run_bowtie2.sh`

if [ "${JOB_ID}x" != "x" ]; then
        echo Job: \"$JOB_ID\"
        PREV_JOB_ID=$JOB_ID
else
        echo Problem submitting job. Job terminated.
        exit 1
fi

