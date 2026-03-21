FROM node:20-bookworm

USER root

# Instala Chromium do Debian + ferramentas de compilação (python/make/g++)
RUN apt-get update && apt-get install -y \
    chromium \
    chromium-driver \
    python3 \
    make \
    g++ \
    ca-certificates \
    fonts-liberation \
    && rm -rf /var/lib/apt/lists/*

# Instala n8n globalmente
RUN npm install -g n8n

# Cria diretório de configuração com permissões corretas (evita EACCES)
RUN mkdir -p /root/.n8n && chmod -R 777 /root/.n8n

ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678

CMD ["n8n", "start"]
