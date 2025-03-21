# Use Alpine Linux as the base image
ARG BASE_IMAGE=alpine:latest
FROM ${BASE_IMAGE}

# Install essential packages:
RUN apk update && apk add --no-cache \
    python3 \
    py3-pip \
    curl \
    docker-cli \
    build-base \
    python3-dev \
    musl-dev \
    linux-headers \
    git \
    zsh \
    zsh-syntax-highlighting \
    zsh-autosuggestions \
    ca-certificates \
    fontconfig \
    unzip

# Create a non-root user 'vscode' with zsh as the default shell
# (the user's home will be /home/vscode.)
RUN adduser -D -s /bin/zsh vscode

# Set working directory for the vscode user
# Using /workspaces/wisp is beneficial because VS Code typically mounts the workspace there.
WORKDIR /workspaces/wisp

# Copy the requirements.txt
COPY requirements.txt ./

# Switch to non-root user
USER vscode

# Install uv, oh-my-zsh, and Starship:
# - uv is installed and places its binaries in $HOME/.local/bin
# - Oh My Zsh is cloned into ~/.oh-my-zsh
# - Starship is installed to $HOME/.local/bin to avoid needing sudo.
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh && \
    curl -fsSL https://starship.rs/install.sh | sh -s -- -y --bin-dir "$HOME/.local/bin"

# Add uv to PATH
ENV PATH="/home/vscode/.local/bin:$PATH"

# Clone required zsh plugins and Powerlevel10k theme into $ZSH_CUSTOM (defaulting to ~/.oh-my-zsh/custom)
RUN git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install Source Code Pro Nerd Font:
# Downloads the zip file from the Nerd Fonts repository, extracts it into ~/.local/share/fonts,
# removes the zip, and rebuilds the font cache.
RUN mkdir -p ~/.local/share/fonts && \
    curl -fLo ~/.local/share/fonts/SourceCodePro.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/SourceCodePro.zip && \
    unzip -o ~/.local/share/fonts/SourceCodePro.zip -d ~/.local/share/fonts/ && \
    rm ~/.local/share/fonts/SourceCodePro.zip && \
    fc-cache -fv

# Configure zsh (.zshrc):
# - Set up Oh My Zsh with Powerlevel10k as the theme
# - Use plugins: git, zsh-autosuggestions, zsh-syntax-highlighting, docker
# - Source the Oh My Zsh script and the plugin scripts (assuming they are in /usr/share/zsh/plugins)
# - Initialize Starship prompt and set your desired prompt format.
RUN echo 'export ZSH="$HOME/.oh-my-zsh"' > ~/.zshrc && \
    echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc && \
    echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting docker lol copydir copyfile dirhistory)' >> ~/.zshrc && \
    echo 'source $ZSH/oh-my-zsh.sh' >> ~/.zshrc && \
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc && \
    echo 'PROMPT="%n@$(hostname) %~ "' >> ~/.zshrc

# Set default command to start zsh as a login shell (to read .zshrc)
CMD ["zsh", "-l"]