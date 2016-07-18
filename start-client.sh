#!/bin/bash

NAME="spark-client"
__image="jupyter/all-spark-notebook"


HOST_IP=$1
if [ "$HOST_IP" == "" ]; then
	HOST_IP=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
fi
docker stop $NAME
docker rm $NAME


#run the container
docker run --name $NAME -d -t --net=host -p 8888:8888 -e SPARK_LOCAL_IP=$HOST_IP  $__image

echo "Your jupyter-notebook is running at: http://"$HOST_IP":8888"
