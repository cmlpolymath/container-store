# syntax=docker/dockerfile:1

# 1. Start from the neutral NVIDIA base image. This is our single stage.
FROM nvidia/cuda:12.1.1-base-ubuntu22.04

# 2. Set up environment variables and shell
ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

# 3. Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
      curl wget git sudo locales unzip fontconfig r-base less nano gnupg2\
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# 4. Install Miniconda
ENV CONDA_DIR=/opt/conda
RUN curl -sSLo /tmp/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash /tmp/miniconda.sh -b -p $CONDA_DIR && \
    rm /tmp/miniconda.sh
ENV PATH="$CONDA_DIR/bin:$PATH"

# 5. Create the unified Conda environment from the YAML file
# This is the most critical step. It builds the entire environment in one go.
COPY .devcontainer/environment.yml /tmp/environment.yml
RUN conda env create -f /tmp/environment.yml && \
    conda clean -y --all && \
    rm /tmp/environment.yml

# 6. Configure the shell to use this environment by default
# This ensures any new shell session automatically activates the environment.
ENV CONDA_DEFAULT_ENV=ml-unified
ENV CONDA_PREFIX=/opt/conda/envs/ml-unified
ENV PATH="$CONDA_PREFIX/bin:$PATH"

# 7. Create a non-root user 'vscode'
ARG USERNAME=vscode
ARG USER_UID=1000
RUN useradd --uid ${USER_UID} --gid 100 -m ${USERNAME} --shell /bin/bash && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} && \
    chmod 440 /etc/sudoers.d/${USERNAME}

# --- User-specific installations ---
USER ${USERNAME}
WORKDIR /home/${USERNAME}

# 8. Install user-specific tools (Starship, Nerd Fonts, Rust, uv)
RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes && \
    echo 'eval "$(starship init bash)"' >> ~/.bashrc

RUN mkdir -p ~/.local/share/fonts && \
    cd ~/.local/share/fonts && \
    curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip && \
    unzip FiraCode.zip && rm FiraCode.zip && fc-cache -fv

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable && \
    echo 'source "$HOME/.cargo/env"' >> ~/.bashrc

RUN curl -sSL https://astral.sh/uv/install.sh | sh

# 9. Set the final working directory for the container
WORKDIR /workspaces/smart_dev