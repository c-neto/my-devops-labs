setup:
	virtualenv venv 
	venv/bin/pip install -r requirements.txt
	venv/bin/docker-compose up -d

config:
	cd ansible; ansible-playbook playbook.yml
