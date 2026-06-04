# Use Ubuntu 24.04
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Atualizar e instalar dependências básicas, Python, pip e nodejs (para jupyterlab extensions se quiser)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates curl wget git build-essential tzdata \
    python3 python3-venv python3-pip python3-setuptools \
    nodejs npm && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Criar ambiente Python isolado (opcional)
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:${PATH}"

# Atualizar pip e instalar JupyterLab
RUN pip install --upgrade pip setuptools wheel
COPY requirements.txt /tmp/requirements.txt
RUN if [ -s /tmp/requirements.txt ]; then pip install -r /tmp/requirements.txt; else pip install jupyterlab; fi && \
    rm -f /tmp/requirements.txt

# Copiar script de inicialização
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Diretório de trabalho
WORKDIR /home/jovyan

# Expor porta do Jupyter
EXPOSE 8888

# Comando padrão para Binder (start.sh iniciará jupyter)
CMD ["/usr/local/bin/start.sh"]
