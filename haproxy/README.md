# haproxy-proxy-load-balancer

Ambiente Docker construído para explorar as funcionalidades de Proxy e Load Balancer da solução [HAProxy](http://www.haproxy.org/).

## Execução

Provisionar o ambiente:

```bash
docker-compose up -d 
```

Forçar a releitura do arquivo de configuração do container com HAProxy:

```bash
docker kill -s HUP haproxy
```
