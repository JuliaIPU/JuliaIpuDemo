# syntax=docker/dockerfile:1

FROM graphcore/pytorch-jupyter:2.5.1-ubuntu-20.04-20220715

# Install g++
ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get update -y && apt-get install -y g++

# Install Julia
RUN wget -O - https://julialang-s3.julialang.org/bin/linux/x64/1.9/julia-1.9.1-linux-x86_64.tar.gz | tar -xzvf - -C /usr/local --strip-components=1

# Install WebIO integration
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade webio_jupyter_extension

# Instantiate Julia project
ENV CXX="g++"
RUN mkdir -p /root/.julia/environments/v1.9
COPY Project.toml  /root/.julia/environments/v1.9/Project.toml
COPY Manifest.toml /root/.julia/environments/v1.9/Manifest.toml
RUN julia -e 'using Pkg; Pkg.instantiate()'
