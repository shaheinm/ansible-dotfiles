# Dotfiles - Ansible Style

Reproducible, Linux-first development environment configuration managed with Ansible.

## Overview

This repository is the **single source of truth** for my development environment. Designed for Linux with macOS support for work machines.

**Core (all platforms):**
- **Neovim** - Modern Lua-based configuration with native LSP (Neovim 0.11+)
- **Zsh** - Clean shell config with modern CLI tools (eza, bat, zoxide)
- **Git** - Aliases, colors, diff-so-fancy, lazygit
- **Starship** - Minimal cross-shell prompt
- **SSH** - Client configuration with sensible defaults
- **ondir** - Centralized per-directory environment management (~/.ondirrc)
- **Languages** - Python, Go, Node.js via asdf

**Linux:**
- **Sway** - i3-compatible tiling WM (Wayland)
- **Packages** - Native package managers (apt, dnf, pacman)

**macOS (work machine support):**
- **Aerospace** - i3-like tiling WM (matches Sway keybindings)
- **Packages** - Homebrew
- **macOS defaults** - Keyboard, Dock, Finder preferences

## Quick Start

### Prerequisites

**Linux:**
- Ansible (`sudo dnf install ansible` / `sudo pacman -S ansible` / `sudo apt install ansible`)
- Git

**macOS (work machines):**
- Homebrew (`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`)
- Ansible (`brew install ansible`)

### Run the Playbook

```bash
# Clone the repo
git clone https://github.com/yourusername/ansible-dotfiles.git ~/dev/ansible-dotfiles
cd ~/dev/ansible-dotfiles

# Run everything (you'll be prompted for Python/Go/Node versions)
ansible-playbook -i hosts playbook.yml

# Run without packages (preserves existing Homebrew)
ansible-playbook -i hosts playbook.yml --skip-tags "packages,kube,node"

# Run specific roles only
ansible-playbook -i hosts playbook.yml --tags "nvim"
ansible-playbook -i hosts playbook.yml --tags "zsh,starship"
ansible-playbook -i hosts playbook.yml --tags "git"

# Run with work-specific packages (on work machines)
ansible-playbook -i hosts playbook.yml --tags "packages,packages-work"

# Skip prompts by passing variables directly
ansible-playbook -i hosts playbook.yml -e "python_version=3.12.3 golang_version=1.23.2 nodejs_version=20"

# Skip language installation entirely
ansible-playbook -i hosts playbook.yml -e "python_version=skip golang_version=skip nodejs_version=skip"
```

### Interactive Prompts

When running the playbook, you'll be prompted for language versions:

```
Python version to install (e.g., 3.12.3, latest, or 'skip' to skip) [latest]: 
Go version to install (e.g., 1.23.2, latest, or 'skip' to skip) [latest]: 
Node.js version to install (e.g., 20.10.0, latest, or 'skip' to skip) [latest]: 
```

Press Enter to accept defaults, enter a specific version, or type `skip`.

## Repository Structure

```
ansible-dotfiles/
├── playbook.yml              # Main playbook (with version prompts)
├── hosts                     # Inventory (localhost)
├── group_vars/
│   └── local                 # Variables (name, email, paths)
├── roles/
│   ├── packages/             # Package installation (Homebrew/apt/dnf)
│   ├── git/                  # Git configuration + aliases
│   ├── ssh/                  # SSH client configuration
│   ├── zsh/                  # Zsh configuration
│   ├── bash/                 # Bash configuration (tagged: never)
│   ├── starship/             # Starship prompt
│   ├── nvim/                 # Neovim configuration (native LSP)
│   ├── lazygit/              # Lazygit TUI configuration
│   ├── ripgrep/              # Ripgrep configuration
│   ├── sway/                 # Sway tiling WM (Linux/Wayland)
│   ├── macos/                # macOS system defaults
│   ├── aerospace/            # i3-like tiling WM (macOS)
│   ├── kube/                 # Kubernetes + Podman/minikube
│   └── node/                 # NVM setup (legacy, tagged: never)
└── README.md
```

## What Gets Installed

### Symlinks Created

| Source | Destination |
|--------|-------------|
| `roles/zsh/files/zshrc.link` | `~/.zshrc` |
| `roles/starship/files/starship.toml` | `~/.config/starship.toml` |
| `roles/nvim/files/init.lua` | `~/.config/nvim/init.lua` |
| `roles/nvim/files/lua/` | `~/.config/nvim/lua/` |
| `roles/git/files/gitignore_global.link` | `~/.gitignore_global` |
| `roles/git/templates/gitconfig.j2` | `~/.gitconfig` (templated) |
| `roles/ssh/templates/config.j2` | `~/.ssh/config` (templated) |
| `roles/lazygit/files/config.yml` | `~/.config/lazygit/config.yml` |
| `roles/ripgrep/files/ripgreprc` | `~/.ripgreprc` |
| `roles/sway/files/config` | `~/.config/sway/config` |
| `roles/aerospace/files/aerospace.toml` | `~/.aerospace.toml` |

### Neovim Plugins (~32 total)

**Core:**
- lazy.nvim (plugin manager)
- mason.nvim (LSP server installer)
- Native `vim.lsp.config` (Neovim 0.11+ - no lspconfig needed)
- nvim-cmp + LuaSnip (completion & snippets)
- nvim-treesitter (syntax highlighting)
- telescope.nvim (fuzzy finder)
- neo-tree.nvim (file tree)

**Formatting/Linting:**
- conform.nvim (formatting - black, prettier, stylua, etc.)
- nvim-lint (diagnostics - shellcheck, cppcheck)

**UI:**
- heirline.nvim (statusline)
- oxocarbon.nvim (theme)
- gitsigns.nvim (git signs)
- trouble.nvim (diagnostics list)
- fidget.nvim (LSP progress)

**Editing:**
- nvim-surround
- Comment.nvim
- nvim-autopairs

### LSP Servers (Native vim.lsp.config)

| Server | Language | Root Markers |
|--------|----------|--------------|
| pyright | Python | pyproject.toml, setup.py, requirements.txt |
| rust_analyzer | Rust | Cargo.toml |
| gopls | Go | go.mod, go.work |
| eslint | JavaScript/TypeScript | .eslintrc, package.json |
| clangd | C/C++ | compile_commands.json, .clangd |
| bashls | Bash/Shell | .git |
| yamlls | YAML | - |
| jsonls | JSON | - |

### Packages

**macOS Core (Homebrew):**
- Core tools: neovim, git, fzf, ripgrep, fd, jq, yq, htop, wget, curl, tree, coreutils
- Modern CLI: bat (better cat), eza (better ls), zoxide (smarter cd), ondir
- Terminal: starship, zsh-syntax-highlighting, zsh-autosuggestions
- Git tools: lazygit, diff-so-fancy, git-delta
- Version manager: asdf
- Formatters: black, isort, stylua, prettier, shfmt, clang-format
- Linters: shellcheck, cppcheck
- Fonts: font-hack-nerd-font

**macOS System (macos role):**
- Keyboard: Fast key repeat, disable press-and-hold for accents
- Dock: Auto-hide, no recent apps, minimize to app icon
- Finder: Show hidden files, extensions, path bar, status bar
- Screenshots: Save to Downloads, PNG format, no shadow
- Misc: Disable auto-correct, smart quotes, smart dashes

**Sway (tiling WM - Linux):**
- Wayland compositor with i3-compatible config
- Alt + hjkl for focus, Alt + Shift + hjkl for move
- Alt + 1-9 for workspaces
- Alt + f for fullscreen
- Includes waybar, wofi, swaylock, alacritty

**Aerospace (tiling WM - macOS):**
- i3/Sway-like tiling window manager for macOS
- Keybindings match Sway for consistency across platforms

**macOS Work-specific** (run with `--tags packages-work`):
- Kubernetes: kubectl, kubectx, helm
- Cloud: awscli, fastly, cfn-lint, ansible
- Backend: postgresql@14, rabbitmq

**Containers (kube role):**
- Podman (preferred over Docker - rootless, daemonless)
- minikube (uses Podman driver)

**Languages via asdf:**
- Python (prompted, default: latest)
- Go (prompted, default: latest)
- Node.js (prompted, default: latest)

**Linux (primary platform):**
- Native package managers (apt, dnf, pacman) - no Homebrew
- Modern CLI tools: bat, eza, zoxide, ondir, delta
- asdf via git clone for language management
- Sway tiling WM (Wayland)
- Formatters/linters installed via pip, npm, and GitHub releases
- Nerd Fonts installed to ~/.local/share/fonts

**Supported Linux Distributions:**
- Fedora/RHEL (dnf)
- Arch Linux (pacman)
- Debian/Ubuntu (apt)

### Starship Prompt

Minimal two-line prompt showing:
- Directory (truncated to repo root)
- Git branch and status
- Language versions (Python, Go, Rust, Node.js) when in project
- AWS profile/region
- Prompt character (green on success, red on error)

## Configuration

### Variables (group_vars/local)

```yaml
dotfiles_home: "{{ ansible_env.HOME }}/dev/ansible-dotfiles"
config_home: "{{ ansible_env.HOME }}/.config"

full_name: Your Name
username: yourusername
git_email: your.email@example.com
git_signing_key: ~/.ssh/id_ed25519.pub  # Optional
```

### Machine-Specific Overrides

The zshrc sources these files if they exist:
- `~/.zshrc.local` - Machine-specific zsh config
- `~/.kuberc` - Kubernetes contexts
- `~/.aliases` - Personal aliases

## Platform Differences

### Linux (Fedora/RHEL)

- Uses dnf for packages (most tools available natively)
- asdf installed via git clone: `source ~/.asdf/asdf.sh`
- Sway for tiling WM

### Linux (Arch)

- Uses pacman for packages (all tools available natively)
- asdf via git clone
- Sway for tiling WM

### Linux (Debian/Ubuntu)

- Uses apt for packages
- Some tools installed via GitHub releases (eza, zoxide, delta, stylua, shfmt)
- asdf installed via git clone: `source ~/.asdf/asdf.sh`
- Starship and lazygit installed via curl scripts
- Sway for tiling WM

### macOS (work machine)

- Uses Homebrew for packages
- asdf installed via Homebrew: `source $(brew --prefix asdf)/libexec/asdf.sh`
- Aerospace for tiling WM (same keybindings as Sway)

## Post-Installation

After running the playbook:

1. **Open a new terminal** to load zshrc and Starship prompt

2. **Open Neovim** and run:
   ```vim
   :Lazy sync
   :TSInstall all
   :Mason
   ```

3. **Verify asdf languages:**
   ```bash
   asdf current
   python --version
   go version
   node --version
   ```

4. **Configure ondir** (optional - edit ~/.ondirrc for per-directory environments)

5. **Set up tiling WM:**
   - Linux: Log out and select Sway from your display manager, or run `sway` from TTY
   - macOS: Grant Aerospace permissions in System Settings > Privacy & Security > Accessibility

6. **Set up Podman** (if using kube role):
   ```bash
   # macOS only - initialize Podman machine
   podman machine init
   podman machine start
   
   # Start minikube with Podman
   minikube start --driver=podman
   ```

7. **Log out and back in** for macOS defaults to take effect

## Troubleshooting

### Neovim errors on startup

1. Clear plugin cache: `rm -rf ~/.local/share/nvim/lazy`
2. Re-run `:Lazy sync`

### LSP not attaching

1. Check server is installed: `:Mason`
2. Check LSP status: `:lua print(vim.inspect(vim.lsp.get_clients()))`
3. Ensure you're in a project with correct root markers

### Starship not showing

1. Ensure starship is installed: `which starship`
2. Check `~/.config/starship.toml` exists
3. Open a new terminal

### Old dotfiles interfering

If you see errors referencing `~/.dotfiles`:
```bash
mv ~/.dotfiles ~/.dotfiles.bak
```

### asdf not finding languages

Ensure correct sourcing in zshrc:
```bash
# macOS (Homebrew)
source $(brew --prefix asdf)/libexec/asdf.sh

# Linux (git clone)
source ~/.asdf/asdf.sh
```

## Updating

To update the configuration:

1. Edit files in `~/dev/ansible-dotfiles/roles/*/files/`
2. Changes are immediately reflected (symlinks)
3. For template changes (gitconfig), re-run the playbook

## History

This repo replaces the previous `~/.dotfiles` approach with:
- Ansible for reproducibility across machines
- Native Neovim 0.11+ LSP (no lspconfig deprecation warnings)
- Cleaner, faster neovim config (58 → ~30 plugins)
- Starship prompt (replaced Powerlevel10k + Oh My Zsh)
- Modern CLI tools: eza, bat, zoxide (better ls, cat, cd)
- Consistent tiling WM: Sway (Linux) / Aerospace (macOS) with matching keybindings
- Single version manager (asdf replaces nvm, pyenv, gimme)
- Podman preferred over Docker (rootless, daemonless)
- Interactive language version prompts
