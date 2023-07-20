# Demo of running Julia code on the IPU

This repository contains sample Jupyter notebooks that you can use to run code written in the [Julia programming language](https://julialang.org/) on the Intelligence Processing Unit (IPU) by Graphcore, using the package [`IPUToolkit.jl`](https://github.com/JuliaIPU/IPUToolkit.jl).
If you find this interesting, please consider starring the `IPUToolkit.jl` repository to show appreciation for the effort.

## Running the notebooks on Paperspace

[Paperspace](https://www.paperspace.com/) is a cloud computing service which offers [IPU compute time](https://www.paperspace.com/graphcore).
The free plan includes unlimited number of 6-hour sessions on the IPU, perfect for trying it out.

To get started, click the button below:

[![Run on Gradient](https://assets.paperspace.io/img/gradient-badge.svg)](https://console.paperspace.com/github/JuliaIPU/JuliaIpuDemo?container=mosegiordano/julia-ipu-demo:v1.1.0&machine=Free-IPU-POD4)

<details><summary>Manual start on Paperspace</summary>

After [signing in Paperspace](https://console.paperspace.com/login) (you can also log in with your GitHub or Google account, without creating a new Paperspace one), create a new project, and then create a new IPU notebook:

![Set up IPU notebook on Paperspace](./figures/paperspace.png)

1. Choose a notebook with an IPU tag, for example "Hugging Face Transformers on IPU"
2. Make sure to select an IPU machine
   You can choose between a free machine which shuts down automatically after at most 6 hours, or other paid for machines with longer sessions
3. Switch on the advanced options
4. Insert `https://github.com/JuliaIPU/JuliaIpuDemo` as workspace
5. Insert `mosegiordano/julia-ipu-demo` as container
6. Leave `/notebooks/setup.sh` as startup command

When the sessions begins, you can open and run the notebooks from the file explorer.
If you prefer, you can also start JupyterLab from the corresponding button in the sidebar on the left.
All dependencies of these notebooks are already installed in the suggested Docker container, so you should be able to run them straight away.

</details>