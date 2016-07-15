#!/bin/bash

NAME="spark-worker"
MASTER=$1
if [ "$MASTER" == "" ]; then
	echo "Please provide a master... "
	echo "$0 spark://<master_ip>:7077"
	exit 1
fi

HOST_IP=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
echo "WORKER_IP: "$HOST_IP
docker stop $NAME
docker rm $NAME
__image="jupyter/all-spark-notebook"
__path_to_spark="/usr/local/spark"


docker run \
	 --name $NAME \
	 -d -t \
	 --net=host \
	 -u 0 \
	 -p 6066:6066 -p 8080:8080 -p 7077:7077 -p 8888:8888 -p 8081:8081 -p 4040:4040 -p 7001-7006:7001-7006  \
	 -e SPARK_LOCAL_IP=$HOST_IP \
	 -v $(pwd)/conf/spark-env.sh:$__path_to_spark/conf/spark-env.sh \
	 $__image /bin/bash
docker exec -d $NAME $__path_to_spark/sbin/start-slave.sh $MASTER

