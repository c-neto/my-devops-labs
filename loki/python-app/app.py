from loguru import logger
from time import sleep


logger.remove()
logger.add('/logs/python-app.log', level="TRACE", serialize=True)


while True:
    logger.trace("logging trace")
    sleep(1)

    logger.debug("logging debug")
    sleep(1)

    logger.info("logging info")
    sleep(1)

    logger.warning("logging warning")
    sleep(1)

    logger.success('logging success')
    sleep(1)

    logger.error("logging error")
    sleep(1)

    try:
        x = 1/0
    except Exception as e:
        logger.exception(str(e))
        sleep(1)
