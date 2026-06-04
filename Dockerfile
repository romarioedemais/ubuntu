FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Instala só os pacotes do Ubuntu que você realmente precisa (excluí vim, nano, git, curl porque Binder já traz Python + conda)
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Cria ambiente Python limpo
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /home/jovyan
USER jovyan
CMD ["/bin/bash"]
