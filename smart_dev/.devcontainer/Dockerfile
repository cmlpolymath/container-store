# syntax=docker/dockerfile:1

# ---------------- Stage 1: Builder ----------------
ARG BASE_IMAGE=nvidia/cuda:12.8.0-runtime-ubuntu24.04
FROM ${BASE_IMAGE} AS builder

ENV DEBIAN_FRONTEND=noninteractive

# 1. Minimal tools for installer downloads
RUN apt-get update && apt-get install -y --no-install-recommends \
      curl wget ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

#EXTENSION: build-time tool installs go here

# 2. Install Miniconda
ENV CONDA_DIR=/opt/conda
RUN curl -sSLo /tmp/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-py312_25.3.1-1-Linux-x86_64.sh && \
    bash /tmp/miniconda.sh -b -p $CONDA_DIR && \
    rm /tmp/miniconda.sh && \
    $CONDA_DIR/bin/conda clean -y --all

ENV PATH="$CONDA_DIR/bin:$PATH"

# 3. Install uv, then PyTorch, then clean up
ENV PYTORCH_INDEX_URL="https://download.pytorch.org/whl/cu121"
RUN pip install --no-cache-dir uv && \
    uv pip install --system torch==2.5.1 torchvision==0.20.1 torchaudio==2.5.1 --index-url $PYTORCH_INDEX_URL && \
    uv cache clean && \
    pip uninstall -y uv --no-input --root-user-action=ignore && \
    conda install -y --quiet pytorch::faiss-gpu && \
    conda clean -y --all

#EXTENSION: add other Conda packages here

# ---------------- Stage 2: Final (Runtime) ----------------
FROM ${BASE_IMAGE} AS final

# Declare build args immediately after FROM
ARG USERNAME=vscode
ARG USER_UID=1000

ENV DEBIAN_FRONTEND=noninteractive

# 1. Runtime OS packages
RUN apt-get update && apt-get install -y --no-install-recommends \
      wget curl git ca-certificates locales sudo \
      build-essential libssl-dev libffi-dev less nano \
      python3 python3-pip gnupg2 software-properties-common \
      r-base && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# 3. Find user/group 1000 and rename it to 'vscode', then configure
RUN groupmod -n ${USERNAME} $(getent group ${USER_UID} | cut -d: -f1) && \
    usermod -l ${USERNAME} -d /home/${USERNAME} -m $(getent passwd ${USER_UID} | cut -d: -f1) && \
    usermod -aG sudo ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} && \
    chmod 440 /etc/sudoers.d/${USERNAME} && \
    mkdir -p /workspaces && chown ${USERNAME}:${USERNAME} /workspaces
    
# 4. Import Conda from builder
COPY --from=builder --chown=${USERNAME}:${USERNAME} /opt/conda /opt/conda
ENV PATH="/opt/conda/bin:/home/${USERNAME}/.local/bin:${PATH}"

# 5. Switch to vscode for user-level installs
USER ${USERNAME}
WORKDIR /home/${USERNAME}

#5.1 Customize bash prompt to be "user@smart_dev" with color
RUN sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/' ~/.bashrc && \
    echo 'export PS1="\[\033[01;32m\]\u@smart_dev\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ "' >> ~/.bashrc

    # 6. Install Rust as vscode user
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable && \
    echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc && \
    echo 'source $HOME/.cargo/env'    >> ~/.bashrc

# 7. Verify Rust install
RUN ~/.cargo/bin/rustc --version && ~/.cargo/bin/cargo --version

# 8. Install Astral uv CLI
RUN curl -sSL https://astral.sh/uv/install.sh -o uv-installer.sh && \
    sh uv-installer.sh && \
    rm uv-installer.sh

# 9. Optional healthcheck
HEALTHCHECK --interval=10m --timeout=3s CMD curl -f http://localhost:8080 || exit 1
