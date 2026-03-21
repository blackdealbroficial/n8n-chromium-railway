FROM ghcr.io/puppeteer/puppeteer:22.12.1

USER root

# ✅ Corrige chave GPG do Google Chrome (erro que estava travando)
RUN apt-get update && apt-get install -y curl gnupg && \
    curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update

# Instala ferramentas de compilação (para isolated-vm do n8n)
RUN apt-get install -y python3 make g++ && apt-get clean

# Instala n8n
RUN npm install -g n8n

# Corrige permissões (evita EACCES)
RUN mkdir -p /home/pptruser/.n8n && \
    chown -R pptruser:pptruser /home/pptruser/.n8n && \
    chmod -R 777 /home/pptruser/.n8n

ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678

USER pptruser
