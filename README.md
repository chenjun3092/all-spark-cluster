all-spark-cluster
------------------
dockerized spark cluster based on the [jupyter/all-spark-notebook](https://github.com/jupyter/docker-stacks/tree/master/all-spark-notebook) image

This set of scripts is a bare-bones example of how to spin up a working [spark](http://spark.apache.org/) [standalone cluster](http://spark.apache.org/docs/latest/spark-standalone.html) in [docker](https://www.docker.com/).

Assuming you have at least 3 ubuntu machines on the same network, seting up a production cluster is as easy as:

1. get-docker.sh on each machine
2. start-master.sh on your master node
3. start-worker.sh spark://[master-ip]:7077 on each worker node
4. start-client.sh on the client node. *Note: A distributed cluster will not talk to a virtual client*


### The following blocks of code give an example of how to run a virtual cluster locally for testing.

## start master
```bash
docker-machine create -d virtualbox master
eval $(docker-machine env master)
master_ip=$(docker-machine ip master)
bash start-master.sh $master_ip
```

## start worker
```bash
docker-machine create -d virtualbox worker
eval $(docker-machine env worker)
bash start-worker.sh "spark://"$master_ip":7077" $(docker-machine ip worker)
```

## start client
```bash
docker-machine create -d virtualbox client
eval $(docker-machine env client)
bash start-client.sh $(docker-machine ip client)
```
