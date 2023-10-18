import sys
import asyncio
import websockets
from time import sleep
from loguru import logger


logger.remove()
logger.add('/var/log/ws-client.log', level="TRACE",  format='{time} - {message}')
logger.add(sys.stderr, level="TRACE", format='{time} - {message}')


URI_LAYOUT = "ws://nginx:8081/ws/endpoint-{number}"


async def hello():
    count = 0

    while True:

        for number_endpoint in range(1, 3):
            uri = URI_LAYOUT.format(number=number_endpoint)
            message = 'Carlos Neto {0}'.format(count)

            try:
                async with websockets.connect(uri) as websocket:
                    logger.info('Message Sended: {0} | Server: {1}'.format(message, uri))
                    await websocket.send(message)
            except Exception as e:
                logger.trace(e)

            sleep(1)

        count += 1

asyncio.get_event_loop().run_until_complete(hello())
