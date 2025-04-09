FROM python:3.9-slim

ENV PYTHONUNBUFFERED=1
WORKDIR /app
COPY app.py /app
RUN pip install flask

CMD ["python", "app.py"]
