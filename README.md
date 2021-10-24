*__Disclaimer:__* *This article describes research activities carried out as part of a personal initiative project. The created docker images are intended for the development of customizing pipelines for personal purposes and in no case should they be used in a production environment*

# Hadoop Lab - a lab for working with Apache Hadoop
## Components
+ Deployment using Docker compose
+ Services
    + HDFS
        + [+] Name Node
        + [+] Data Node
    + YARN
        + [+] Resource Manager
        + [+] Node Manager (2 or more) &amp
        + [+] History Service
    + SPARK
        + [-] SPARK History Service
        + [-] SPARK Shuffle Service on Yarn
    + HUE
        +[-] HUE service
    + LIVY
        +[-] Livy Service
    + Edge Node 
        +[+] SSH Service
        +[+] Spark submit
    + Proxy Http/Https Node 
        +[+] Squid proxy

## Usage
### Build Docker image 
`make build`
### Run Docker compose services
`make  run`
### Clearing all artifacts
`make clean`

## Edge node
### Port 
Port 9922, protocol SSH
### Test spark submit
`spark-submit --deploy-mode client --class org.apache.spark.examples.SparkPi $SPARK_HOME/examples/jars/spark-examples_2.12-3.1.2.jar 10`
### Test hadoop
`hadoop fs -ls  /`

## Hadoop Http(s) Proxy (SQUID)
### Port proxy
Port 3128, protocol http, https 
### Services URL
+ [resourcemanager](http://resourcemanager:8088)
+ [namenode](http://namenode:9870)
+ [datanode](http://datanode:9864)
+ [nodemanager01](http://nodemanager01:8042)
+ [nodemanager02](http://nodemanager02:8042)
+ [historyserver](http://historyserver:8188)
+ [sparkhistoryserver](http://sparkhistoryserver:18080)

**[This project is based on the developments of the big-data-europe project](https://github.com/big-data-europe/docker-hadoop)**
