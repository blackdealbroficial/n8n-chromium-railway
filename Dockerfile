# Usamos a versão 22 (Bookworm) que é a exigida pelo n8n 2.20+
FROM node:22-bookworm

# Instala as dependências de sistema necessárias para o Chromium e bibliotecas gráficas
RUN apt-get update && apt-get install -y \
    chromium \
    fonts-ipafont-gothic \
    fonts-wqy-zenhei \
    fonts-thai-tlwg \
    fonts-kacst \
    fonts-freefont-ttf \
    libxss1 \
    build-essential \
    python3 \
    make \
    g++ \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Configura as variáveis de ambiente para o n8n reconhecer o Chromium
ENV CHROME_BIN=/usr/bin/chromium
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# Instala o n8n globalmente (o --unsafe-perm ajuda com módulos nativos como o isolated-vm)
RUN npm install -g n8n@latest --unsafe-perm

# Define a porta padrão
EXPOSE 5678

# Comando para iniciar
CMD ["n8n", "start"]
