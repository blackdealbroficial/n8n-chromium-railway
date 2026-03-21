FROM ghcr.io/puppeteer/puppeteer:22.12.1

USER root

# Instala ferramentas de compilação para módulos nativos do n8n
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    && apt-get clean

# Instala n8n
RUN npm install -g n8n

# Corrige permissões para evitar EACCES
RUN mkdir -p /home/pptruser/.n8n && \
    chown -R pptruser:pptruser /home/pptruser/.n8n && \
    chmod -R 777 /home/pptruser/.n8n

ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678

USER pptruser
