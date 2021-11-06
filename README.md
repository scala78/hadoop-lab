*__Disclaimer:__* *This article describes research activities carried out as part of a personal initiative project. The created docker images are intended for the development of customizing pipelines for personal purposes and in no case should they be used in a production environment*

# Hadoop Lab - a lab for working with Apache Hadoop
## *Components*
+ Deployment using Docker compose
+ Services
    + HDFS (3.3.1)
        + [+] Name Node
        + [+] Data Node
    + YARN (3.3.1)
        + [+] Resource Manager
        + [+] Node Manager (2 or more)
        + [+] History Service
    + SPARK (3.1.2, Scala 2.12)
        + [+] SPARK History Service
        + [-] SPARK Shuffle Service on Yarn
    + HUE
        + [+] HUE service
    + LIVY (0.8.0-SNAPSHOT, Spark 3.0, Scala 2.12)
        + [+] Livy Service, not fully tested 
    + Edge Node 
        + [+] SSH Service
        + [+] Spark submit
    + Proxy Http/Https Node 
        + [+] Squid proxy
+ Configuration
     the configurations are located according to the CONFIG variable, by default this is the directory `./configs`


## *Usage*
### Build Docker image
`make build`
### Run Docker compose services
`make  run`
### Clearing all artifacts
`make clean`

## *Edge node*
### Connectivity
   + Port *9922*, protocol *SSH*
   + User *hadoop*, password *hadoop*

### Test spark submit
   `spark-submit --deploy-mode client --class org.apache.spark.examples.SparkPi $SPARK_HOME/examples/jars/spark-examples_2.12-3.1.2.jar 10`
### Test hadoop
   `hadoop fs -ls  /`

## *Hadoop Http(s) Proxy (SQUID)*
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
 + [livynode](http://livynode:8998)
 + [huenode](http://huenode:8888) or docker node port 38888

*[This project is based on the developments of the big-data-europe project](https://github.com/big-data-europe/docker-hadoop)*
