# syntax=docker/dockerfile:1

######################### Stage 1: Builder #########################
FROM nvidia/cuda:12.1.1-devel-ubuntu22.04 AS builder

ARG USERNAME=appuser
ARG USER_UID=1000
ARG USER_GID=1000

# 1) System dependencies (curl re‑added)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      wget curl python3 python3-pip git build-essential cmake lsb-release \
      software-properties-common gnupg coreutils procps && \
    rm -rf /var/lib/apt/lists/*

# 2) LLVM 19 / clang 18 (official script)
RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh 19 && \
    rm llvm.sh

# 3) Miniconda install
RUN curl -sL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh && \
    bash miniconda.sh -b -p /opt/conda && \
    rm miniconda.sh
ENV PATH=/opt/conda/bin:$PATH

# 4) Conda env create + auto‑activate line
RUN conda init bash && \
    conda create -n bitnet-cpp python=3.9 -y && \
    echo "source /opt/conda/etc/profile.d/conda.sh\nconda activate bitnet-cpp" >> /root/.bashrc && \
    conda clean --all -y

# 5) Clone BitNet source
RUN git clone --recurse-submodules https://github.com/microsoft/BitNet.git /BitNet
WORKDIR /BitNet

# 6) Python deps inside env
RUN . /opt/conda/etc/profile.d/conda.sh && \
    conda activate bitnet-cpp && \
    pip install --no-cache-dir torch --index-url https://download.pytorch.org/whl/cu121 && \
    pip install --no-cache-dir transformers accelerate sentencepiece ninja huggingface-hub && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir -r 3rdparty/llama.cpp/requirements/requirements-convert_legacy_llama.txt

# 7) Download model weights
RUN . /opt/conda/etc/profile.d/conda.sh && \
    conda activate bitnet-cpp && \
    mkdir -p models/BitNet-b1.58-2B-4T && \
    huggingface-cli download microsoft/BitNet-b1.58-2B-4T-gguf --local-dir models/BitNet-b1.58-2B-4T

# 8) Compile (setup_env)
RUN . /opt/conda/etc/profile.d/conda.sh && \
    conda activate bitnet-cpp && \
    python setup_env.py -md models/BitNet-b1.58-2B-4T -q i2_s

######################### Stage 2: Runtime #########################
FROM nvidia/cuda:12.1.1-runtime-ubuntu22.04 AS runtime

ARG USERNAME=appuser
ARG USER_UID=1000
ARG USER_GID=1000

# 1) Minimal packages needed for inference
# Only install libgomp1 for OpenMP support; cmake was only needed at build time
RUN apt-get update && \
    apt-get install -y --no-install-recommends libgomp1 nano less && \
    rm -rf /var/lib/apt/lists/*

# 2) Recreate non‑root user
RUN groupadd -g ${USER_GID} ${USERNAME} && \
    useradd -m -u ${USER_UID} -g ${USER_GID} -s /bin/bash ${USERNAME}

# 3) Copy env & code (owned by user)
COPY --from=builder --chown=${USERNAME}:${USERNAME} /opt/conda /opt/conda
COPY --from=builder --chown=${USERNAME}:${USERNAME} /BitNet    /BitNet

# 4) Auto‑activate env for user shells
RUN echo "source /opt/conda/etc/profile.d/conda.sh" >> /home/${USERNAME}/.bashrc && \
    echo "conda activate bitnet-cpp" >> /home/${USERNAME}/.bashrc && \
    echo 'echo "Try running: python run_inference.py -m models/BitNet-b1.58-2B-4T/ggml-model-i2_s.gguf -p \"You are a helpful assistant\" -c 256 -t 4 -cnv"' >> /home/${USERNAME}/.bashrc

# 5) Environment vars
ENV PATH=/opt/conda/bin:/opt/conda/envs/bitnet-cpp/bin:$PATH
ENV LD_LIBRARY_PATH=/BitNet/build:$LD_LIBRARY_PATH

USER ${USERNAME}
WORKDIR /BitNet

VOLUME /BitNet/models
EXPOSE 8000

CMD ["bash", "--login"]
