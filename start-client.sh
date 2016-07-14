

NAME="all-spark-notebook"
#PORT=$1
HOST_IP=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
docker stop $NAME
docker rm $NAME

#RUN WITH THE jupyter/all-spark-notebook image
#-v `pwd`:/home/$NAME -w /home/$NAME
docker run --name $NAME -d -t --net=host -p 1-65535:1-65535 -e SPARK_LOCAL_IP=$HOST_IP  jupyter/all-spark-notebook

echo "checkout http://"$HOST_IP":8888"
