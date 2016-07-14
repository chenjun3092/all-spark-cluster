NAME="spark-master"
HOST_IP=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
docker stop $NAME
docker rm $NAME
#-p 4040:4040 -p 6066:6066 -p 7077:7077 -p 8080:8080
docker run --name $NAME -d -t --net=host --pid=host -u 0 -p 1-65535:1-65535 --expose=1-65535 -e SPARK_MASTER_IP=$HOST_IP jupyter/all-spark-notebook /bin/bash
docker exec -d $NAME /usr/local/spark/sbin/start-master.sh
docker exec -d $NAME tail -n 1000 -F /usr/local/spark/logs/*.out

echo "The spark ui can be seen in a web browser at: http://"$HOST_IP":8080"
echo "run the worker on each worker node via..."
echo "bash start-worker.sh spark://"$HOST_IP":7077"

#HOST_IP=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
#export SPARK_LOCAL_IP=$HOST_IP
#export SPARK_MASTER_IP=$HOST_IP
#/usr/share/spark/spark-1.6.0-bin-hadoop2.4/sbin/start-master.sh

