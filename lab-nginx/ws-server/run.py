import tornado.web
import tornado.httpserver
import tornado.ioloop
import tornado.websocket
import tornado.options
from loguru import logger
import sys


logger.remove()
logger.add('/var/log/ws-server.log', level="TRACE",  format='{time} - {message}')
logger.add(sys.stderr, level="TRACE", format='{time} - {message}')


LISTEN_PORT = 8888
LISTEN_ADDRESS = '0.0.0.0'


class Endpoint1(tornado.websocket.WebSocketHandler):
    def initialize(self):
        self.channel = None

    def open(self):
        pass

    def on_message(self, message):
        logger.info('Endpoint 1 - Received: ' + message)

    def on_close(self):
        pass

    def check_origin(self, origin):
        logger.info('Request From: ' + origin)
        return True


class Endpoint2(tornado.websocket.WebSocketHandler):
    def initialize(self):
        self.channel = None

    def open(self):
        pass

    def on_message(self, message):
        logger.info('Endpoint 2 - Received: ' + message)

    def on_close(self):
        pass

    def check_origin(self, origin):
        logger.info('Request From: ' + origin)
        return True


def main():
    # Create tornado application and supply URL routes
    app = tornado.web.Application([
        ('/endpoint-1', Endpoint1),
        ('/endpoint-2', Endpoint2),
    ])

    # Setup HTTP Server
    http_server = tornado.httpserver.HTTPServer(app)
    http_server.listen(LISTEN_PORT, LISTEN_ADDRESS)

    # Start IO/Event loop
    tornado.ioloop.IOLoop.instance().start()


if __name__ == '__main__':
    main()
