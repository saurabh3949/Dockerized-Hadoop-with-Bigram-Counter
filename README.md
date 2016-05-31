Dockerized Hadoop cluster and BigramCounter
------

##1. Project Introduction

This project is based on [kiwenlau/hadoop-cluster-docker](https://github.com/kiwenlau/hadoop-cluster-docker) project, however, we've reconstructed it to run a BigramCounter after creating the cluster and to computer some bigram statistics.

Docker Images required/built:
```
Image Name
kiwenlau/serf-dnsmasq
kiwenlau/hadoop-base
kiwenlau/hadoop-slave
saurabh/hadoop-master
```

##2. Images description

In this project, we use 4 docker images: **serf-dnsmasq**, **hadoop-base**, **hadoop-master** and **hadoop-slave**.

#####serf-dnsmasq

Based on ubuntu:15.04. [serf](https://www.serfdom.io/) and [dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html) are installed for providing DNS service for the Hadoop Cluster.

#####hadoop-base

Based on serf-dnsmasq, openjdk, openssh-server, vim and Hadoop 2.3.0 are installed.

#####hadoop-master

Based on hadoop-base. This is reconfigured to spawn 4 worker nodes and run the bigram counter.

#####hadoop-slave

Based on hadoop-base. Configure the Hadoop slave node.

Following picture shows the image architecture of my project:

![alt text](https://github.com/saurabh3949/Dockerized-Hadoop-with-Bigram-Counter/raw/master/image architecture.jpg "Image Architecture")

##3. Usage

#####Clone the REPOSITORY and run:
```
bash start.sh
```

##4. Input Text file
The master node uses a reduced version of [mobydick.txt](http://algs4.cs.princeton.edu/63suffix/mobydick.txt) (in hadoop-master/files directory) by default. You can replace the contents of this file to run the analysis on a different input.

##5. Output
The script generates the following output with reduced [mobydick.txt](http://algs4.cs.princeton.edu/63suffix/mobydick.txt):
```
             _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|


Total number of bigrams: 554

Most common bigram: ('of the', 5)

Top 10 bigrams:
('of the', 5)
('in the', 4)
('I find', 2)
('What do', 2)
('city of', 2)
('find myself', 2)
('in my', 2)
('is a', 2)
('to get', 2)
('American desert,', 1)

No. of bigrams required to add up to 10% of all bigrams: 42

```

##6. Contributors
- Saurabh Gupta, sag043@ucsd.edu, PID: A53091070
- Siddhartha Agarwal, siagarwa@eng.ucsd.edu, PID: A53105684
