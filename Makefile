DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
HADOOP_VERSION := 3.3.1
SPARK_VERSION := 3.2.0
SPARK_HADOOP_VERSION := 3.2

current_branch := $(shell git rev-parse --abbrev-ref HEAD)
#current_branch := master

build:
	docker build -t scala78/hadoop-base:$(current_branch) --build-arg VERSION=$(current_branch) --build-arg HADOOP_VERSION=$(HADOOP_VERSION) --build-arg SPARK_VERSION=$(SPARK_VERSION) --build-arg SPARK_HADOOP_VERSION=$(SPARK_HADOOP_VERSION) ./base
	docker build -t scala78/hadoop-namenode:$(current_branch) --build-arg VERSION=$(current_branch) ./namenode
	docker build -t scala78/hadoop-datanode:$(current_branch) --build-arg VERSION=$(current_branch) ./datanode
	docker build -t scala78/hadoop-resourcemanager:$(current_branch) --build-arg VERSION=$(current_branch) ./resourcemanager
	docker build -t scala78/hadoop-nodemanager:$(current_branch) --build-arg VERSION=$(current_branch) ./nodemanager
	docker build -t scala78/hadoop-historyserver:$(current_branch) --build-arg VERSION=$(current_branch) ./historyserver
	docker build -t scala78/hadoop-edgenode:$(current_branch) --build-arg VERSION=$(current_branch) ./edgenode
	docker build -t scala78/hadoop-sparkhistoryserver:$(current_branch) --build-arg VERSION=$(current_branch) ./sparkhistoryserver
	docker build -t scala78/hadoop-livynode:$(current_branch) --build-arg VERSION=$(current_branch) ./livynode
	#docker build -t scala78/hadoop-submit:$(current_branch) --build-arg VERSION=$(current_branch) ./submit
	echo VERSION=$(current_branch) >.env
run:
	docker-compose up

clean:
	docker rmi -f scala78/hadoop-livynode:$(current_branch)
	docker rmi -f scala78/hadoop-sparkhistoryserver:$(current_branch)
	docker rmi -f scala78/hadoop-edgenode:$(current_branch)
	docker rmi -f scala78/hadoop-historyserver:$(current_branch)
	docker rmi -f scala78/hadoop-nodemanager:$(current_branch)
	docker rmi -f scala78/hadoop-resourcemanager:$(current_branch)
	docker rmi -f scala78/hadoop-datanode:$(current_branch)
	docker rmi -f scala78/hadoop-namenode:$(current_branch)
	docker rmi -f scala78/hadoop-base:$(current_branch)
	rm .env
	
	