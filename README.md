# Dotfiles - Ansible Style

Reproducible development environment configuration managed with Ansible.

## Overview

This repository is the **single source of truth** for my development environment. It manages:

- **Neovim** - Modern Lua-based configuration with native LSP (Neovim 0.11+)
- **Zsh** - Clean shell config with Starship prompt
- **Git** - Aliases, colors, diff-so-fancy
- **Starship** - Minimal cross-shell prompt
- **Packages** - Homebrew (macOS) / apt/dnf (Linux)
- **Languages** - Python, Go, Node.js via asdf

## Quick Start

### Prerequisites

- Ansible installed (`brew install ansible` or `pip install ansible`)
- Git
- For macOS: Homebrew (`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`)

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
│   ├── git/                  # Git configuration
│   │   ├── tasks/main.yml
│   │   ├── templates/gitconfig.j2
│   │   └── files/
│   ├── nvim/                 # Neovim configuration
│   │   ├── tasks/main.yml
│   │   └── files/
│   │       ├── init.lua
│   │       └── lua/
│   │           ├── user/     # Core settings
│   │           ├── lsp/      # Native LSP config (vim.lsp.config)
│   │           ├── plugins/  # Plugin configs
│   │           └── specs/    # Plugin specifications
│   ├── zsh/                  # Zsh configuration
│   │   ├── tasks/main.yml
│   │   └── files/zshrc.link
│   ├── starship/             # Starship prompt
│   │   ├── tasks/main.yml
│   │   └── files/starship.toml
│   ├── packages/             # Package installation
│   │   └── tasks/
│   │       ├── main.yml
│   │       ├── macos.yml       # Core packages
│   │       ├── macos-work.yml  # Work-specific packages
│   │       └── linux.yml
│   ├── node/                 # Node.js/NVM setup (legacy)
│   └── kube/                 # Kubernetes tools
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
- Terminal: starship, zsh-syntax-highlighting, zsh-autosuggestions, ondir
- Git tools: lazygit, diff-so-fancy
- Version manager: asdf
- Formatters: black, isort, stylua, prettier, shfmt, clang-format
- Linters: shellcheck, cppcheck
- Fonts: font-hack-nerd-font

**macOS Work-specific** (run with `--tags packages-work`):
- Kubernetes: kubectl, kubectx, helm
- Cloud: awscli, fastly, cfn-lint, ansible
- Backend: postgresql@14, rabbitmq

**Languages via asdf:**
- Python (prompted, default: latest)
- Go (prompted, default: latest)
- Node.js (prompted, default: latest)

**Linux:**
- Same core packages via apt/dnf
- Starship and lazygit installed via curl scripts

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

### macOS

- Uses Homebrew for packages
- asdf installed via Homebrew: `source $(brew --prefix asdf)/libexec/asdf.sh`

### Linux (Debian/Ubuntu)

- Uses apt for packages
- asdf installed via git clone: `source ~/.asdf/asdf.sh`
- Starship installed via curl script

### Linux (Fedora/RHEL)

- Uses dnf for packages
- Same as Debian otherwise

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
- Cleaner, faster neovim config (58 → 32 plugins)
- Starship prompt (replaced Powerlevel10k + Oh My Zsh)
- Single version manager (asdf replaces nvm, pyenv, gimme)
- Interactive language version prompts
