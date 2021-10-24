DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
#current_branch := $(shell git rev-parse --abbrev-ref HEAD)
current_branch := master

build:
	docker build -t scala78/hadoop-base:$(current_branch) ./base
	docker build -t scala78/hadoop-namenode:$(current_branch) ./namenode
	docker build -t scala78/hadoop-datanode:$(current_branch) ./datanode
	docker build -t scala78/hadoop-resourcemanager:$(current_branch) ./resourcemanager
	docker build -t scala78/hadoop-nodemanager:$(current_branch) ./nodemanager
	docker build -t scala78/hadoop-historyserver:$(current_branch) ./historyserver
	docker build -t scala78/hadoop-edgenode:$(current_branch) ./edgenode
	docker build -t scala78/hadoop-sparkhistoryserver:$(current_branch) ./sparkhistoryserver
	#docker build -t scala78/hadoop-submit:$(current_branch) ./submit

run:
	docker-compose up

clear:
	docker rmi -f scala78/hadoop-sparkhistoryserver:$(current_branch)
	docker rmi -f scala78/hadoop-edgenode:$(current_branch)
	docker rmi -f scala78/hadoop-historyserver:$(current_branch)
	docker rmi -f scala78/hadoop-nodemanager:$(current_branch)
	docker rmi -f scala78/hadoop-resourcemanager:$(current_branch)
	docker rmi -f scala78/hadoop-datanode:$(current_branch)
	docker rmi -f scala78/hadoop-namenode:$(current_branch)
	docker rmi -f scala78/hadoop-base:$(current_branch)
	
	