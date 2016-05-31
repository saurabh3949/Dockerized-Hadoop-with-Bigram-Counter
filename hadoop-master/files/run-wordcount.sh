#!/bin/bash

# create input directory on HDFS
hadoop fs -mkdir -p input

# put input files to HDFS
hdfs dfs -put mobydick.txt input

# compile WordCount files
mkdir WordCount
javac -classpath `yarn classpath` -d WordCount Bigram/*
jar -cvf WordCount.jar -C WordCount/ .

# run wordcount
hadoop jar WordCount.jar Bigram.BigramCount -input input -output output

# print the input files
# echo -e "\ninput file1.txt:"
# hdfs dfs -cat input/file1.txt
#
# echo -e "\ninput file2.txt:"
# hdfs dfs -cat input/file2.txt

# print the output of wordcount
# echo -e "\nwordcount output:"
figlet output
hdfs dfs -cat output/part-r-00000 > output.txt && python produceOutput.py
