FROM nvidia/cuda:11.8.0-devel-ubuntu20.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y bash \
                   wget \
                   build-essential \
                   git \
                   git-lfs \
                   curl \
                   ca-certificates \
                   libsndfile1-dev \
                   python3.8 \
                   python3-pip \
                   python3.8-venv && \
    rm -rf /var/lib/apt/lists

RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y

RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN python3 -m pip install --no-cache-dir --upgrade pip

# Install miniconda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py310_23.3.1-0-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh

# Set the conda environment
ENV PATH /opt/conda/bin:$PATH
RUN conda update -n base -c defaults conda

# Create a new conda environment with Python 3.10.6
RUN conda create -n myenv python=3.10.6

# Activate the conda environment
RUN echo "source activate myenv" > ~/.bashrc
ENV PATH /opt/conda/envs/myenv/bin:$PATH




# RUN bash webui.sh -f --skip-torch-cuda-test

# COPY . /app
WORKDIR /app
RUN wget https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh
# RUN git config --global --add safe.directory /app

# ENTRYPOINT python demo_web.py