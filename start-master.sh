#!/bin/bash

NAME="spark-master"
HOST_IP=$1
if [ "$HOST_IP" == "" ]; then
	HOST_IP=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
fi

echo "MASTER IP: "$HOST_IP

docker stop $NAME
docker rm $NAME
__image="jupyter/all-spark-notebook"
__path_to_spark="/usr/local/spark"


docker run \
	--name $NAME \
	-d -t \
	--net=host \
	-u 0 \
	-p 4040:4040 -p 6066:6066 -p 7077:7077 -p 8080:8080 \
	-e SPARK_MASTER_IP=$HOST_IP \
	-v $(pwd)/conf/spark-env.sh:$__path_to_spark/conf/spark-env.sh \
	$__image /bin/bash
docker exec -d $NAME $__path_to_spark/sbin/start-master.sh

echo "The spark ui can be seen in a web browser at: http://"$HOST_IP":8080"
echo "run the worker on each worker node via..."
echo "bash start-worker.sh spark://"$HOST_IP":7077"
