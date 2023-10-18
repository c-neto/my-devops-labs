# nginx-adapter-websocket-uri


NGINX Adapter WebSocket URI.


```shell
├── nginx-watch.sh
├── README.md
├── docker-compose.yaml
├── nginx
│   ├── config
│   │   ├── conf.d          # Directory/Volume shared with container
│   │   │   └── debug.conf  # Server "ws://nginx:8081/ws/<ENDPOINT>" >>> "ws://ws-server:8888/<ENDPOINT>"
│   │   └── nginx.conf      # Main Configuration Server File NGINX 
│   ├── logs
│   │   └── *.log
│   └── nginx-watch.sh      # Script for watch /etc/nginx detected changes and restart NGINX daemon
│
├── ws-client
│   ├── Dockerfile          
│   ├── logs                
│   │   └── ws-client.log   # Log Process 
│   ├── requirements.txt    
│   └── run.py              # Script send messages in loop to NGINX proxy. "ws://nginx:8081/ws/endpoint-1", "ws://nginx:8081/ws/endpoint-2".
│
└── ws-server
    ├── Dockerfile          
    ├── logs                
    │   └── ws-server.log   # Log Process 
    ├── requirements.txt    
    └── run.py              # Script Web-Socket server. "ws://ws-server:8888/endpoint-1", "ws://ws-server:8888/endpoint-2".
```


## How to run:

```shell
$ docker-compose up --build
```


## Output

```shell
Recreating ws-server ... done
Recreating nginx     ... done
Recreating ws-client ... done

Attaching to ws-server, nginx, ws-client

ws-client    | 2020-05-18T00:33:14.963121+0000 - Message Sended: Carlos Neto 0 | Server: ws://nginx:8081/ws/endpoint-1
nginx        | "GET /ws/endpoint-1 HTTP/1.1"
ws-server    | 2020-05-18T00:33:14.963551+0000 - Endpoint 1 - Received: Carlos Neto 0

ws-client    | 2020-05-18T00:33:15.971240+0000 - Message Sended: Carlos Neto 0 | Server: ws://nginx:8081/ws/endpoint-2
nginx        | "GET /ws/endpoint-2 HTTP/1.1"
ws-server    | 2020-05-18T00:33:15.972207+0000 - Endpoint 2 - Received: Carlos Neto 0

ws-client    | 2020-05-18T00:33:16.979967+0000 - Message Sended: Carlos Neto 1 | Server: ws://nginx:8081/ws/endpoint-1
nginx        | "GET /ws/endpoint-1 HTTP/1.1"
ws-server    | 2020-05-18T00:33:16.980827+0000 - Endpoint 1 - Received: Carlos Neto 1

ws-client    | 2020-05-18T00:33:17.986631+0000 - Message Sended: Carlos Neto 1 | Server: ws://nginx:8081/ws/endpoint-2
nginx        | "GET /ws/endpoint-2 HTTP/1.1"
ws-server    | 2020-05-18T00:33:17.987268+0000 - Endpoint 2 - Received: Carlos Neto 1

...

```
