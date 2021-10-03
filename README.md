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
    + HUE [-]
    + LIVY [-]

## Usage
### Build Docker image 
`make build`
### Run Docker compose services
`make  run`
### Clearing all artifacts
`make clean`


**[This project is based on the developments of the big-data-europe project](https://github.com/big-data-europe/docker-hadoop)**