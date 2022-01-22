FROM ubuntu:latest

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

#Set environment noninteractive and timezone
RUN export DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#Install libs
RUN apt-get update --fix-missing && apt-get install -y python3-pip wget bzip2 ca-certificates \
    build-essential libssl-dev apt-utils curl 

#Install Anaconda
RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

# Upgrade pip and install pyzmq
RUN pip3 install --upgrade pip && pip install pandas
RUN pip3 install jupyter_contrib_nbextensions
RUN pip3 install --upgrade --force-reinstall pyzmq --use-feature=2020-resolver

#Install Jupyter Lab, Dash, plotly and
RUN conda install -c conda-forge jupyter-dash jupyterlab notebook voila dash-renderer \
    dash dash-html-components dash-core-components plotly

#Create notebooks directory and copy files them
RUN mkdir /opt/notebooks/
ADD ./notebooks /opt/notebooks/

# Mkdir
RUN mkdir -p /home/app/

# Workdir
WORKDIR /opt/notebooks/

# Create user and group
RUN groupadd --gid 9999 app && \
    useradd --uid 9999 --gid app app && \
    chown -R app:app /home/app

RUN export PATH=/home/app/anaconda/bin:$PATH

EXPOSE 80 8888 8001

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash"]
