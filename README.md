## Objective/Objetivo

They files are a study for learning to use the Pandas and data analysis libraries,
plotting data: NuPy, Pandas, matplotlib and etc.

Estes arquivos são para estudo do uso do Pandas e bibliotecas de análise de dados e visualizações:
NuPy, Pandas, matplotlib and etc.

## Install Jupyter Official/Install Oficial do Jupyter

https://jupyter.org/install

## Install Docker Official/Install Oficial do Docker

https://docs.docker.com/install/linux/docker-ce/ubuntu/

## Running Dockerfile/Execução do Dockerfile

```bash
docker build .
```
## Command to start the container with Jupyter/Comando para iniciar o container com o Jupyter:

```bash
docker run -i -t -p 8888:8888 9a6672b5a5a2 /bin/bash -c "/opt/conda/bin/conda install jupyter -y --quiet && /opt/conda/bin/jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --port=8888 --no-browser --allow-root"
```

Replace the address hash before port: 8888 by localhost/Substituir o hash do endereço antes da porta :8888 por localhost:

In/De:
```bash
http://f4f5e4b9a0b1:8888/?token=7f61b6560d654775efc1fa44ad8d5d6f6096395c08ca56e1&token=7f61b6560d654775efc1fa44ad8d5d6f6096395c08ca56e1
```

For/Para:
```bash
http://localhost:8888/?token=7f61b6560d654775efc1fa44ad8d5d6f6096395c08ca56e1&token=7f61b6560d654775efc1fa44ad8d5d6f6096395c08ca56e1
```
