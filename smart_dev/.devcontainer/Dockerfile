# Use NVIDIA CUDA runtime base image
ARG BASE_IMAGE=nvidia/cuda:12.8.0-runtime-ubuntu24.04
FROM ${BASE_IMAGE}

# Set non-interactive mode for apt and locale settings
ENV DEBIAN_FRONTEND=noninteractive

# Update apt and install essential system packages (as root)
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget curl git build-essential ca-certificates libssl-dev libffi-dev \
    python3 python3-pip locales sudo gnupg2 software-properties-common \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Generate locale and set environment variables
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Create non-root user 'vscode' with passwordless sudo
RUN useradd -m -s /bin/bash vscode && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the vscode user for personal installations
USER vscode
WORKDIR /home/vscode

##############################
# Install Anaconda (as vscode)
##############################
# Install Anaconda into the user's home directory (e.g. /home/vscode/conda)
ENV CONDA_DIR=/home/vscode/conda
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-x86_64.sh -O /tmp/anaconda.sh && \
    bash /tmp/anaconda.sh -b -p $CONDA_DIR && \
    rm /tmp/anaconda.sh

# Add Anaconda to PATH
ENV PATH=$CONDA_DIR/bin:$PATH

# (Optional) Update conda itself
# RUN conda update -n base -c defaults conda -y

##############################
# Install uv via pip (in the conda environment)
##############################
RUN pip install uv

##############################
# Install Rust using rustup (as vscode)
##############################
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable && \
    echo 'export PATH="/home/vscode/.cargo/bin:$PATH"' >> /home/vscode/.bashrc && \
    echo 'source /home/vscode/.cargo/env' >> /home/vscode/.bashrc
# Verify Rust installation (optional)
RUN /home/vscode/.cargo/bin/rustc --version && /home/vscode/.cargo/bin/cargo --version

##############################
# Install Python packages (e.g. PyTorch) using uv pip
##############################
# Set index URL for PyTorch packages
ENV PYTORCH_INDEX_URL="https://download.pytorch.org/whl/cu121"
RUN uv pip install --system torch==2.5.1 torchvision==0.20.1 torchaudio==2.5.1 --index-url $PYTORCH_INDEX_URL

##############################
# Switch to root to install R (system-wide)
##############################
USER root
RUN apt-get update && apt-get install -y --no-install-recommends r-base && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

##############################
# Final adjustments and ensure PATH is correct
##############################
# Switch back to vscode for interactive usage
USER vscode
WORKDIR /home/vscode
# Ensure PATH includes Anaconda, Rust, and uv locations
ENV PATH="/home/vscode/.cargo/bin:$CONDA_DIR/bin:$PATH"

# (Optional) Healthcheck – adjust as needed
HEALTHCHECK --interval=10m --timeout=3s CMD curl -f http://localhost:8080 || exit 1

# Set default CMD or ENTRYPOINT as needed
# CMD ["bash"]
