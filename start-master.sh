NAME="spark-master"
HOST_IP=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
docker stop $NAME
docker rm $NAME
__image="jupyter/all-spark-notebook"

max_cores_per_user=$1
if [ "$max_cores_per_user" == "" ]; then
    max_cores_per_user="1000000000"
fi

docker run \
	--name $NAME \
	-d -t \
	--net=host \
	-u 0 \
	-p 4040:4040 -p 6066:6066 -p 7077:7077 -p 8080:8080 \
	--expose=1-65535 \
	-e SPARK_MASTER_IP=$HOST_IP \
	-e SPARK_MASTER_OPTS="-Dspark.deploy.defaultCores="$max_cores_per_user \
	$__image /bin/bash
docker exec -d $NAME /usr/local/spark/sbin/start-master.sh
docker exec -d $NAME tail -n 1000 -F /usr/local/spark/logs/*.out

echo "The spark ui can be seen in a web browser at: http://"$HOST_IP":8080"
echo "run the worker on each worker node via..."
echo "bash start-worker.sh spark://"$HOST_IP":7077"


