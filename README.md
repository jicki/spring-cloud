# spring-cloud

## 初始化 init

```
sh init.sh
```

## 修改 IP

```
docker-compose.yaml

修改相关 127.0.0.1  IP 

```


# eureka-cluster

> JVM "-Xms512m", "-Xmx1024m", "-XX:PermSize=256m", "-XX:MaxPermSize=512m"

## 单机配置 docker-compose

```
  eureka-1:
    image: jicki/eureka-cluster
    hostname: eureka-1
    container_name: eureka-1
    restart: always
    environment:
    - EUREKA_SERVER_LIST=http://eureka-1:8761/eureka/
    ports:
    - 8762:8761
```

## docker swarm 集群

```
version: '3'
services:
  eureka-1:
    image: jicki/eureka-cluster
    networks:
      springcloud-overlay:
        aliases:
          - eureka-cluster
    restart: always
    environment:
    - EUREKA_SERVER_LIST=http://eureka-2:8761/eureka/,http://eureka-3:8761/eureka/
    ports:
    - 8761:8761
  eureka-2:
    image: jicki/eureka-cluster
    networks:
      springcloud-overlay:
        aliases:
          - eureka-cluster
    restart: always
    environment:
    - EUREKA_SERVER_LIST=http://eureka-1:8761/eureka/,http://eureka-3:8761/eureka/
  eureka-3:
    image: jicki/eureka-cluster
    networks:
      springcloud-overlay:
        aliases:
          - eureka-cluster
    restart: always
    environment:
    - EUREKA_SERVER_LIST=http://eureka-1:8761/eureka/,http://eureka-2:8761/eureka/

networks:
  springcloud-overlay:
    external:
      name: springcloud-overlay


```



## kubernetes statefulset

```
apiVersion: apps/v1beta1
kind: StatefulSet
metadata:
  name: eureka
spec:
  serviceName: "eureka-cluster"
  replicas: 3
  template:
    metadata:
      labels:
        app: eureka
    spec:
      terminationGracePeriodSeconds: 10
      containers:
        - name: eureka-cluster
          image: jicki/eureka-cluster
          env:
            - name: EUREKA_SERVER_LIST
              value: "http://eureka-0:8761/eureka/,http://eureka-1:8761/eureka/,http://eureka-2:8761/eureka/"
          ports:
            - containerPort: 8761
---

apiVersion: v1
kind: Service
metadata:
  name: eureka-cluster
spec:
  ports:
  - port: 8761
  clusterIP: None
  selector:
    app: eureka

```
