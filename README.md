# all-spark-cluster
dockerized spark cluster based on the (jupyter/all-spark-notebook)[https://github.com/jupyter/docker-stacks/tree/master/all-spark-notebook] image



# Start Master
```bash
docker-machine create -d virtualbox master
docker-machine start master
eval $(docker-machine env master)
master_ip=$(docker-machine ip master)
bash start-master.sh $master_ip
```

# Start Worker
```bash
docker-machine create -d virtualbox worker
docker-machine start worker
eval $(docker-machine env worker)
bash start-worker.sh "spark://"$master_ip":7077" $(docker-machine ip worker)
```

# Start Client
```bash
docker-machine create -d virtualbox client
docker-machine start client
eval $(docker-machine env client)
bash start-client.sh $(docker-machine ip client)
```
