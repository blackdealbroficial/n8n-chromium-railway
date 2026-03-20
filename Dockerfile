FROM n8nio/n8n:latest

USER root

# Atualiza pacotes Alpine e instala Chromium + dependências
RUN apk update && apk add --no-cache \
    chromium \
    chromium-chromedriver \
    nss \
    freetype \
    freetype-dev \
    harfbuzz \
    ca-certificates \
    ttf-freefont

# Cria diretório .n8n e dá permissão total ao usuário node (corrige EACCES)
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n && \
    chmod -R 777 /home/node/.n8n

# Variáveis para Puppeteer usar o Chromium instalado
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

USER node
