<div align="center" style="
    background: linear-gradient(90deg,rgba(93, 189, 230, 0.85),rgb(157, 30, 138)); /* Gradient Background */
    padding: 10px;
    border-radius: 30px; /* Rounded Corners */
    margin-bottom: 15px; /* Spacing below the title */
">
  <h1 style="
    font-family: 'Arial Black', sans-serif; /* Modern Font */
    font-size: 3em;
    color: white;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5); /* Text Shadow */
    margin: 0; /* Remove default margins */
    display: inline-block; /* Keep it on one line if possible */
  ">
    <span style="
      font-size: 1.2em; /* Adjust icon size */
      margin-right: 10px; /* Spacing between icon and text */
      vertical-align: middle; /* Align icon vertically */
    ">
      📦
    </span>
    Container Store
    <span style="
      font-size: 1.2em; /* Adjust icon size */
      margin-left: 10px; /* Spacing between icon and text */
      vertical-align: middle; /* Align icon vertically */
    ">
      📦
    </span>
  </h1>
</div>
<div align="center">
  <img src="https://www.shiplilly.com/wp-content/uploads/2016/01/ocean-shipping-containers.jpg" alt="Container Store Logo" width="200"/>
  <p style="font-size: 1.2em; color: rgb(211, 161, 204)">Centralized Dev Container Configurations</p>
</div>

---

<div align="center">
  <a href="https://code.visualstudio.com/docs/remote/containers" target="_blank" rel="noopener noreferrer">
    <img src="https://img.shields.io/badge/VS_Code-Dev_Containers-blue?style=for-the-badge&logo=visual-studio-code" alt="VS Code Dev Containers"/>
  </a>
  <a href="https://www.docker.com/" target="_blank" rel="noopener noreferrer">
    <img src="https://img.shields.io/badge/Docker-Enabled-blue?style=for-the-badge&logo=docker" alt="Docker Enabled"/>
  </a>
  <a href="https://learn.microsoft.com/en-us/windows/wsl/" target="_blank" rel="noopener noreferrer">
    <img src="https://img.shields.io/badge/WSL2-Compatible-blue?style=for-the-badge&logo=windows" alt="WSL2 Compatible"/>
  </a>
</div>

---

## Overview

Container Store is your central hub for professional-grade development container configurations, designed to streamline your workflow and elevate your development environment. Leveraging VS Code Dev Containers, Docker, and WSL2, it provides reproducible and isolated environments for projects like **SmartDev** and **Wisp**.

**Key Objectives:**

* ✨ **Streamlined Workflow:** Achieve consistent, version-controlled dev container configurations.
* 📂 **Multi-Project Management:** Centrally store and manage configurations for diverse projects (e.g., SmartDev, Wisp).
* 🛠️ **Modern Tooling:** Utilize Alpine Linux, Zsh, Oh My Zsh, Powerlevel10k, Starship, and uv for a cutting-edge development experience.
* 🤝 **VS Code and Git Integration:** Seamlessly open, rebuild, and maintain containers with VS Code and Git.

---

## 📂 Project Structure

```
container-store/
├── 📂 bit_net/            # Microsoft LLM in a 9GB image. We're inferencing on low-tier CPUs now.
│   └── 📄 Dockerfile
├── 📂 smart_dev/          # A Nvidia GPU configured data science container
│   └── 📂 .devcontainer/
│       ├── 📄 docker-compose.yml
│       ├── 📄 Dockerfile
│       ├── 📄 devcontainer.json
│       └── 📄 requirements.txt
└── 📂 wisp/               # Compact, powerful, and visually stunning Alpine-based image with zsh configs
    └── 📂 .devcontainer/
        ├── 📄 Dockerfile
        ├── 📄 devcontainer.json
        └── 📄 requirements.txt
```

* **.devcontainer Folder:** Encapsulates the `Dockerfile` and `devcontainer.json` files that define the container's development environment.
* **requirements.txt:** Specifies Python package dependencies for installation within the container's virtual environment.

---

## ✨ Features

* **Alpine Linux Base Image:** 🏔️ Minimal container footprint with essential development tools.
* **Custom Zsh Setup:**
    * Oh My Zsh with the Powerlevel10k theme. 🎨
    * Plugins: `zsh-syntax-highlighting`, `zsh-autosuggestions`, and more for enhanced shell functionality. 🚀
* **Starship Prompt:** 🌟 Fast, customizable, and minimal prompt for an informative and efficient terminal experience.
* **uv Virtual Environment Management:** 🐍 Automatic virtual environment creation and dependency installation from `requirements.txt`.
* **Nerd Fonts:** 🤓 Installs the Source Code Pro Nerd Font (SauceCodePro Nerd Font) for enhanced glyph rendering in the terminal.

---

## ⚙️ Prerequisites

* **OS:** Windows 10/11 with WSL2 enabled. 🪟
* **Tooling:** docker-cli (configured for WSL2). 🐳
* **IDE:** Visual Studio Code with the following extensions:
    * Remote - WSL 🔌
    * Dev Containers 📦
    * Docker 🐋
* **Version Control:** Git (for repository cloning and management). 🌳

---

## Getting Started

1.  **Clone the Repository:**

    ```bash
    git clone [https://github.com/cmlpolymath/container-store.git](https://github.com/cmlpolymath/container-store.git)
    cd container-store/wisp
    ```

2.  **Open in VS Code:**

    * Open VS Code.
    * Use the Command Palette: **"Reopen in Container"**
    * This action will:
        * Build the container from the `.devcontainer` configuration.
        * Create a uv virtual environment and install dependencies from `requirements.txt` (if present).
        * Launch Zsh with the Powerlevel10k theme and Starship prompt.

3.  **Container Usage:**

    * Your development environment is now ready for use. 🚀
    * Code, dependencies, and terminal settings are all pre-configured within the container.

---

## 🔨 Building and Rebuilding

**PowerShell (or WSL):**

```powershell
wsl bash -c "sudo service docker start && devcontainer up --workspace-folder /home/<your-user>/container_store/wisp && code --remote dev-container+$(wslpath -w /home/<your-user>/container_store/wisp)"
```

>   💡 **Tip:** Replace `<your-user>` with your actual username. Use the `--build-no-cache` flag to force a complete rebuild, bypassing any cached layers.

---

## 🤝 Contributing

Contributions are welcome!

1.  🍴 **Fork** the repository.
2.  🌿 Create a **branch**.
3.  ✅ **Commit** changes with clear and descriptive messages.
4.  🚀 Open a **Pull Request**.

---

## 📜 License

[MIT License](LICENSE)

---

## 📞 Contact

For issues or suggestions, please use the [GitHub Issue Tracker](https://github.com/cmlpolymath/container-store/issues).

---

*Thank you for visiting. Please come again!* 👋

