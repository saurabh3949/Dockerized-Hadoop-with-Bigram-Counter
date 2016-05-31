#!/bin/bash
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

docker pull kiwenlau/serf-dnsmasq:0.1.0
docker pull kiwenlau/hadoop-base:0.1.0
docker pull kiwenlau/hadoop-slave:0.1.0

tag="0.1.0"

# Build hadoop-master
cd hadoop-master
docker rmi saurabh/hadoop-master:$tag
docker build -t saurabh/hadoop-master:$tag .
cd ..

# run N total nodes
# the defaut node number is 5 (1 master + 4 slaves)
N=5

# delete old master container and start new master container
docker rm -f master &> /dev/null
echo "start master container..."
docker run -d -t --dns 127.0.0.1 -P --name master -h master.kiwenlau.com -w /root saurabh/hadoop-master:0.1.0 &> /dev/null
echo "Master container on! Now sleeping for sometime....."
sleep 2
# get the IP address of master container
FIRST_IP=$(docker inspect --format="{{.NetworkSettings.IPAddress}}" master)

# delete old slave containers and start new slave containers
i=1
while [ $i -lt $N ]
do
    docker rm -f slave$i &> /dev/null
    echo "start slave$i container..."
    docker run -d -t --dns 127.0.0.1 -P --name slave$i -h slave$i.kiwenlau.com -e JOIN_IP=$FIRST_IP kiwenlau/hadoop-slave:0.1.0 &> /dev/null
    i=$(( $i + 1 ))
done


# create a new Bash session in the master container
docker exec -t master bash init.sh
# Clean up all docker processes
echo "Cleaning all docker processes!"
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
# docker exec -it master bash
