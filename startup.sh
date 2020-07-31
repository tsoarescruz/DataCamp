#!/bin/bash

docker run -it -p 8888:8888 datacamp /bin/bash -c "/opt/conda/bin/conda install jupyter pandas -y --quiet && /opt/conda/bin/jupyter notebook --notebook-dir=/opt/notebooks/ --ip='0.0.0.0' --port=8888 --no-browser --allow-root" -v ./notebooks/:/opt/notebooks/