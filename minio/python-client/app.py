import minio
from os import getenv
from loguru import logger
import urllib3
import base64
from time import sleep


IMAGE_PATH = 'file.jpg'
BUCKET_TARGET = 'testes-upload'


minio_client = minio.Minio(
    'server-minio:9000', 
    access_key=getenv('MINIO_ACCESS_KEY', 'adminadmin'),
    secret_key=getenv('MINIO_SECRET_KEY', 'adminadmin'), 
    secure=False
)

logger.info('Criando um bucket de testes denominado: {}'.format(BUCKET_TARGET))
try:
    minio_client.make_bucket(BUCKET_TARGET)
    logger.success('Bucket criado com sucesso: {}'.format(BUCKET_TARGET))
except minio.error.BucketAlreadyOwnedByYou as e:
    logger.warning('Bucket já existente | Bucket: {}'.format(BUCKET_TARGET))
except Exception as e:
    logger.trace(e)
    raise Exception

logger.info('Listando os buckets presentes no Object-Storage')
try:
    buckets = minio_client.list_buckets()
except:
    logger.error('Nao foi possivel listar os buckets')
    raise Exception

logger.info('Buckets presentes')
for bucket in buckets:
    logger.info('Nome: {} | Criado em: {}'.format(bucket.name, bucket.creation_date))

count = 0
while True:
    remote_filename = 'image-{}'.format(count)
    logger.info('Iniciando upload | Nome Local do Arquivo {} | Nome do Arquivo Remoto {}'.format(
        IMAGE_PATH,
        remote_filename
    ))
    try:
        minio_client.fput_object(BUCKET_TARGET, remote_filename, IMAGE_PATH)
        logger.success('Upload feito com sucesso | Bucket {} | Nome do Arquivo Remoto {}'.format(BUCKET_TARGET, remote_filename))
    except:
        logger.error('Erro no upload do arquivo')
    count += 1
    sleep(3)
