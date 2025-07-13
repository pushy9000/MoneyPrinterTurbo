FROM python:3.11-slim-bullseye

WORKDIR /MoneyPrinterTurbo

RUN apt-get update && apt-get install -y --no-install-recommends \
    git imagemagick ffmpeg supervisor && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8080 8501

CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
