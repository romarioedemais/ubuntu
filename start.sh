#!/usr/bin/env bash
# start.sh - inicia JupyterLab acessível sem token (Binder expõe)
set -e
# Garantir diretório home e permissões
mkdir -p /home/jovyan/work
cd /home/jovyan/work

# Iniciar JupyterLab aberto na porta 8888, sem token e aceitando conexões externas
exec jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token='' --NotebookApp.password=''
