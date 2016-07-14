NAME="spark-worker"
MASTER=$1
HOST_IP=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
echo "HOST_IP: "$HOST_IP
docker stop $NAME
docker rm $NAME
#--add-host sjc04p1jupap02:10.178.0.40
#--add-host relds-jshiverick-01:10.32.10.86
#-p 6066:6066 -p 8080:8080 -p 7077:7077 -p 8888:8888 -p 8081:8081 -p 4040:4040 -p 7001-7006:7001-7006
docker run --name $NAME -d -t  --net=host -u 0 -p 1-65535:1-65535  --expose=1-65535 -e SPARK_LOCAL_IP=$HOST_IP jupyter/all-spark-notebook /bin/bash
docker exec -d $NAME /usr/local/spark/sbin/start-slave.sh $MASTER
#docker exec -d $NAME /bin/bash tail -F /usr/local/spark/logs/*.out
#docker run --name $NAME -i -t --net=host -v `pwd`:/home/$NAME  -p 1-65535:1-65535  --expose=1-65535 -e SPARK_LOCAL_IP=$HOST_IP mconley/spark:v1 /bin/bash
#docker exec -d $NAME /usr/share/spark/spark-1.6.0-bin-hadoop2.4/sbin/start-slave.sh $MASTER

#HOST_IP=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
#export SPARK_LOCAL_IP=$HOST_IP
#/usr/share/spark/spark-1.6.0-bin-hadoop2.4/sbin/start-slave.sh $MASTER
