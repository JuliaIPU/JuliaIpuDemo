# syntax=docker/dockerfile:1

FROM graphcore/poplar:2.5.1-ubuntu-20.04-20220629

# Install python and g++
RUN /bin/sh -c 'export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y wget python3 python3-pip g++ git \
    && apt-get --purge autoremove -y \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/*'

# Install Python dependencies
RUN python3 -m pip install --upgrade --no-cache-dir pip
RUN python3 -m pip install --upgrade --no-cache-dir jupyter==1.0.0 jupyterlab==4.0.2 webio_jupyter_extension==0.1.0
RUN rm -rf /root/.cache

# Install Julia
RUN wget -O - https://julialang-s3.julialang.org/bin/linux/x64/1.9/julia-1.9.1-linux-x86_64.tar.gz | tar -xzvf - -C /usr/local --strip-components=1

# Instantiate Julia project
ENV CXX="g++"
RUN mkdir -p /root/.julia/environments/v1.9
COPY Project.toml  /root/.julia/environments/v1.9/Project.toml
COPY Manifest.toml /root/.julia/environments/v1.9/Manifest.toml
RUN julia -e 'using Pkg; Pkg.instantiate()'
