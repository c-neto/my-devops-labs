from flask import Flask, request
import logging
import sys

app = Flask(__name__)

_log = logging.getLogger('werkzeug')
_log.setLevel(logging.ERROR)

@app.route('/logs', methods=['POST'])
def receive_logs():
    log_batch = request.get_json()
    logs_raw = [log['log'] for log in log_batch]
    print(logs_raw)
    return logs_raw, 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
