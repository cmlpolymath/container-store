
# Container Store


Container Store is a GitHub repository that centralizes professional-grade development container configurations for multiple projects. It uses [VS Code Dev Containers](https://code.visualstudio.com/docs/remote/containers), Docker, and WSL2 to provide a reproducible and isolated development environment for projects like **SmartDev** and **Wisp**.

---

## Overview

Container Store is designed to:
- **Streamline your development workflow** by providing consistent, version-controlled dev container configurations.
- **Facilitate multi-project management** by storing configurations for different containers (e.g., SmartDev, Wisp) in one repository.
- **Leverage modern tooling:** Use Alpine Linux as a lightweight base image, along with Zsh, Oh My Zsh, Powerlevel10k, Starship, and uv for virtual environment management.
- **Integrate with VS Code and Git:** Easily open, rebuild, and update your containers from VS Code and maintain your configurations with Git.

---

## Project Structure

The repository is organized as follows:

```
container-store/
├── smart_dev/          # Dev container configuration for SmartDev project
│   └── .devcontainer/
│       ├── Dockerfile
│       ├── devcontainer.json
│       └── requirements.txt
└── wisp/               # Dev container configuration for Wisp project
    └── .devcontainer/
        ├── Dockerfile
        ├── devcontainer.json
        └── requirements.txt
```

- **.devcontainer Folder:** Contains the Dockerfile and devcontainer.json that define the container’s environment.
- **requirements.txt:** Lists the Python dependencies to be installed in the container’s virtual environment.

---

## Features

- **Lightweight Alpine Linux Base Image:** Keeps container size minimal while providing essential tools.
- **Custom Zsh Setup:**  
  - Uses Oh My Zsh with the Powerlevel10k theme.  
  - Includes useful plugins like `zsh-syntax-highlighting`, `zsh-autosuggestions`, and more.
- **Starship Prompt Integration:** Provides a fast, customizable, and minimal prompt.
- **uv Virtual Environment Management:**  
  - Automatically creates a virtual environment in your workspace.  
  - Installs dependencies from requirements.txt (if present).
- **Nerd Fonts Installation:**  
  - Installs the Source Code Pro Nerd Font (renamed as SauceCodeProNerdFont) to support enhanced glyphs in your terminal.

---

## Prerequisites

- **Windows 10/11** with WSL2 enabled
- **Docker Desktop** configured for WSL2
- **Visual Studio Code** with the following extensions:
  - Remote - WSL
  - Dev Containers
  - Docker
- **Git** (to clone and push changes to the repository)

---

## Getting Started

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/cmlpolymath/container-store.git
   cd container-store/wisp
   ```

2. **Open in VS Code:**

   Open VS Code, then choose **"Reopen in Container"** from the Command Palette. This will:
   - Build the container using the configuration in the `.devcontainer` folder.
   - Create a uv virtual environment and install dependencies from `requirements.txt` (if present).
   - Launch a terminal with your custom Zsh prompt, complete with Powerlevel10k and Starship.

3. **Using the Container:**

   Your development environment is now isolated and reproducible. Use it as you normally would—your code, dependencies, and terminal settings are all defined in these configurations.

---

##  Building and Rebuilding the Container

You can rebuild your dev container by running the following command in PowerShell (or WSL):

```powershell
wsl bash -c "sudo service docker start && devcontainer up --workspace-folder /home/<your-user>/container_store/wisp && code --remote dev-container+$(wslpath -w /home/<your-user>/container_store/wisp)"
```

> **Tip:** Replace `<your-user>` with your actual username. Use the `--build-no-cache` flag if you want to force a rebuild.

---

## Contributing

Contributions are welcome! If you have ideas or improvements for the container configurations:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Commit your changes with clear messages.
4. Open a pull request detailing your changes.

---

## License

[MIT License](LICENSE)

---

## Contact

For questions, suggestions, or issues, please open an issue on [GitHub](https://github.com/cmlpolymath/container-store/issues).

---

*Happy coding and enjoy your perfectly reproducible development containers!*

---