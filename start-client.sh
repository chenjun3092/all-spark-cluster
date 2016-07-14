

NAME='all-spark-notebook'
PORT=$1
HOST_IP=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
docker stop $NAME
docker rm $NAME

#RUN WITH THE jupyter/all-spark-notebook image
docker run --name $NAME'-notebook' -d -t --net=host -p 8888:8888 -e SPARK_LOCAL_IP=$HOST_IP -v `pwd`:/home/$NAME -w /home/$NAME jupyter/all-spark-notebook