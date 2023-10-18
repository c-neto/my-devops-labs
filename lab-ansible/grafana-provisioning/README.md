# ansible-configure-grafana

Ansible Playbook criado para provisionar, através da API do Grafana, organizações, datasources e dashboards de maneira automática. 

## Estrutura de Arquivos

```bash
.
├── dashboards
│   ├── files                           # Diretório destinado da criação dos dashboards.json, com base nos "templates" com o uso do "vars" específico
│   │   └── ...
│   ├── tasks                   
│   │   └── ...
│   ├── templates                       # Variáveis específicas, que serão utilizadas nos templates de criação de dashboards
│   │   └── ...
│   └── vars                            # Variáveis específicas, que serão utilizadas nos templates de criação de dashboards
│       ├── igarata.yml
│       ├── jacarei.yml
│       └── sao-jose-dos-campos.yml     
├── datasources                         # Role: criação de organizações
│   ├── files                           # Arquivos de provisionamento de datasource
│   │   ├── igarata
│   │   │   └── ...                     
│   │   ├── jacarei
│   │   │   └── ...
│   │   └── sao-jose-dos-campos
│   │       └── ...
│   └── tasks
│       └── main.yml
├── organizations                       # Role: criação de organizações
│   └── tasks
│       └── ...
└── playbook.yml                        # Playbook principal
```

## Testes

Para testar o provisionamento, excutar:

```bash
git clone https://github.com/augustoliks/ansible-configure-grafana
cd ansible-configure-grafana
make setup
make config
```
