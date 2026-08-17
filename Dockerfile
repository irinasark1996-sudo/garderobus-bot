FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends unzip git \
    && rm -rf /var/lib/apt/lists/*

COPY garderobus_app_v032.zip /tmp/garderobus_app.zip

RUN unzip /tmp/garderobus_app.zip -d /app \
    && rm /tmp/garderobus_app.zip \
    && pip install --no-cache-dir -r requirements.txt

RUN mkdir -p /app/storage/media /app/storage/garments /app/storage/profiles

EXPOSE 8000

CMD ["sh", "-c", "exec uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-8000}"]
