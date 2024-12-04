FROM python:3.9-slim

# Встановлення базових інструментів
RUN apt-get update && apt-get install -y \
    curl \
    librdkafka-dev \
    openjdk-17-jdk \
    && apt-get clean

# Встановлення залежностей Python (якщо є requirements.txt)
# RUN pip install --no-cache-dir -r requirements.txt

# Додавання додаткових бібліотек для Spark і Kafka
ENV PYSPARK_SUBMIT_ARGS="--packages org.apache.spark:spark-streaming-kafka-0-10_2.12:3.5.1,org.apache.spark:spark-sql-kafka-0-10_2.12:3.5.1 pyspark-shell"

# Копіювання коду в контейнер
WORKDIR /app
COPY . .

# Запуск скрипту Python для Kafka і Spark
CMD ["python", "spark_streaming_kafka_alerts.py"]
