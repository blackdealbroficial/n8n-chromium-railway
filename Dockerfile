FROM n8nio/n8n:latest

USER root

# Atualiza pacotes Debian e instala Chromium + dependências
RUN apt-get update && apt-get install -y \
    chromium \
    chromium-driver \
    libnss3 \
    libfontconfig1 \
    libfreetype6 \
    libharfbuzz0b \
    ca-certificates \
    fonts-freefont \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Cria diretório .n8n e dá permissão total ao usuário node (corrige EACCES crash)
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n && \
    chmod -R 777 /home/node/.n8n

# Variáveis para Puppeteer usar o Chromium instalado
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

USER node
