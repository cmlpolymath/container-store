# Use Alpine as the base image (lightweight and suitable for Python + Zsh)
FROM alpine:latest

# Install packages:
# - python3 and py3-pip for Python development
# - build-base, python3-dev, musl-dev, linux-headers for compiling Python packages
# - zsh, git, curl, and sudo for shell and utilities
# - zsh-theme-powerlevel10k, zsh-syntax-highlighting, zsh-autosuggestions for Zsh configuration
# - docker-cli, tzdata for Docker commands and time settings
# - starship and uv for prompt and dependency management
# - font-source-code-pro-nerd for the SauceCodePro Nerd Font
RUN apk update && apk add --no-cache \
    python3 py3-pip build-base \
    zsh git curl sudo zsh-theme-powerlevel10k \
    linux-headers docker-cli musl-dev tzdata \
    zsh-autosuggestions zsh-syntax-highlighting starship uv font-source-code-pro-nerd && \
    # Remove all TTF files that do NOT contain "Mono" in their filename.
    find /usr/share/fonts -type f -iname "*.ttf" ! -iname "*Mono*.ttf" -delete && \
    # Refresh font cache so Nerd Fonts are recognized
    fc-cache -fv

# Create a non-root user (vscode) with Zsh as the default shell.
# (Using 1000:1000 for compatibility with host setups)
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000
RUN addgroup -g ${USER_GID} -S ${USERNAME} && \
    adduser -S -u ${USER_UID} -G ${USERNAME} -s /bin/zsh ${USERNAME}

# Give vscode user write permissions to the workspace
USER root
RUN mkdir -p /workspaces/wisp && chown -R ${USERNAME}:${USERNAME} /workspaces/wisp
USER ${USERNAME}

# Copy requirements.txt from the build context (requirements.txt is located in the parent folder)
COPY requirements.txt /workspaces/wisp/


# Set the ZSH environment variable
ENV ZSH="/home/${USERNAME}/.oh-my-zsh"

# Install Oh My Zsh (unattended, without autostart) for the vscode user.
# Then adjust the configuration:
RUN RUNZSH=no KEEP_ZSHRC=yes sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \

    # Use a different delimiter in sed to avoid escaping issues
    sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' /home/${USERNAME}/.zshrc && \
    # Symlink Powerlevel10k theme from its installed location to the custom themes folder
    mkdir -p "/home/${USERNAME}/.oh-my-zsh/custom/themes" && \
    ln -s "/usr/share/zsh/plugins/powerlevel10k" "/home/${USERNAME}/.oh-my-zsh/custom/themes/powerlevel10k" && \
    # Initialize Starship for Zsh (making the starship command available)
    echo 'eval "$(starship init zsh)"' >> /home/${USERNAME}/.zshrc && \
    # Append custom plugin list and prompt configuration
    echo 'source $ZSH/oh-my-zsh.sh' >> /home/${USERNAME}/.zshrc && \
    echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting docker lol copypath copyfile dirhistory web-search)' >> /home/${USERNAME}/.zshrc && \
    echo 'PROMPT="%n@$(hostname) %~ "' >> /home/${USERNAME}/.zshrc && \
    # Create directory so container_store is accessible when binding later
    mkdir -p /home/${USERNAME}/container_store

# Set the working directory for the project (this is where VS Code will mount the workspace)
WORKDIR /workspaces/wisp

# Use Zsh for subsequent RUN commands if needed
SHELL ["/bin/zsh", "-c"]

# Set default command to launch Zsh as a login shell (ensuring .zshrc is loaded)
CMD ["zsh", "-l"]
