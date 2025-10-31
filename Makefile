.PHONY: all homebrew zshrc antigen brew-install git vimrc aws clean help whiptail starship-config

# Variables
HOME_DIR := $(HOME)
BASH_DIR := $(HOME)/.bash
CONFIGS_DIR := $(BASH_DIR)/configs
SETUP_DIR := $(BASH_DIR)/setup

# Default target - runs all setup steps in the same order as setup.sh
all: homebrew zshrc antigen brew-install git vimrc aws
	@echo "✅ Complete setup finished!"

# Install Homebrew (foundational dependency)
homebrew:
	@echo "🍺 Setting up Homebrew..."
	@if ! command -v brew &> /dev/null; then \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	else \
		echo "Homebrew already installed"; \
	fi

# Install whiptail (needed for interactive setup scripts)
whiptail: homebrew
	@echo "📦 Installing whiptail..."
	@if ! hash whiptail 2>/dev/null; then \
		brew install newt; \
	else \
		echo "whiptail already available"; \
	fi

# Setup zsh configuration
zshrc: whiptail
	@echo "🐚 Setting up zshrc..."
	@if command -v whiptail &> /dev/null; then \
		bash $(SETUP_DIR)/zshrc.sh; \
	else \
		echo "Linking .zshrc without prompt..."; \
		[ -e $(HOME_DIR)/.zshrc ] && rm -f $(HOME_DIR)/.zshrc; \
		ln -nsf $(CONFIGS_DIR)/.zshrc $(HOME_DIR)/.zshrc; \
	fi

# Install and configure Antigen
antigen: zshrc whiptail
	@echo "🔌 Setting up Antigen..."
	@if command -v whiptail &> /dev/null; then \
		bash $(SETUP_DIR)/antigen.sh; \
	else \
		echo "Downloading Antigen without prompt..."; \
		curl -L git.io/antigen > $(CONFIGS_DIR)/antigen.zsh; \
	fi

# Install brew packages (interactive selection)
brew-install: homebrew whiptail
	@echo "📦 Installing brew packages..."
	@bash $(SETUP_DIR)/brew_install.sh

# Alternative: Install all brew packages without interaction
brew-install-all: homebrew
	@echo "📦 Installing all brew packages..."
	@bash $(SETUP_DIR)/brew_installable.sh
	@brew install $$(grep -v '^#' $(SETUP_DIR)/brew_installable.sh | grep -o '"[^"]*"' | tr -d '"' | tr '\n' ' ')
	@brew cleanup
	@brew doctor

# Setup starship configuration (called automatically if starship is installed)
starship-config:
	@echo "🚀 Setting up Starship configuration..."
	@if command -v starship &> /dev/null; then \
		mkdir -p $(HOME_DIR)/.config; \
		ln -nsf $(CONFIGS_DIR)/starship.toml $(HOME_DIR)/.config/starship.toml; \
		echo "Starship config linked"; \
	else \
		echo "Starship not installed, skipping config"; \
	fi

# Configure Git
git: homebrew whiptail
	@echo "🔧 Setting up Git configuration..."
	@if command -v whiptail &> /dev/null; then \
		bash $(SETUP_DIR)/git.sh; \
	else \
		echo "Setting up git with default configuration..."; \
		git config --global core.excludesfile $(CONFIGS_DIR)/.gitignore.global; \
		git config --global core.hooksPath $(BASH_DIR)/githooks; \
		git config --global user.name "Nathan Stanley"; \
		git config --global push.default current; \
		git config --global push.autoSetupRemote true; \
		git config --global pull.rebase false; \
		git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"; \
		git config --global color.ui true; \
		git config --global alias.unstage "restore --staged"; \
		git config --global alias.uncommit "reset HEAD^"; \
	fi

# Setup Vim configuration
vimrc: whiptail
	@echo "📝 Setting up Vim configuration..."
	@if command -v whiptail &> /dev/null; then \
		bash $(SETUP_DIR)/vimrc.sh; \
	else \
		echo "Linking .vimrc without prompt..."; \
		[ -e $(HOME_DIR)/.vimrc ] && rm -f $(HOME_DIR)/.vimrc; \
		ln -nsf $(CONFIGS_DIR)/.vimrc $(HOME_DIR)/.vimrc; \
	fi

# Setup AWS configuration
aws: brew-install whiptail
	@echo "☁️  Setting up AWS configuration..."
	@bash $(SETUP_DIR)/aws.sh

# Individual component installation (non-interactive)
install-homebrew: homebrew

install-zsh-config:
	@echo "🐚 Installing zsh config (non-interactive)..."
	@[ -e $(HOME_DIR)/.zshrc ] && rm -f $(HOME_DIR)/.zshrc
	@ln -nsf $(CONFIGS_DIR)/.zshrc $(HOME_DIR)/.zshrc
	@echo "✅ .zshrc linked"

install-antigen:
	@echo "🔌 Installing Antigen (non-interactive)..."
	@curl -L git.io/antigen > $(CONFIGS_DIR)/antigen.zsh
	@echo "✅ Antigen downloaded"

install-vim-config:
	@echo "📝 Installing Vim config (non-interactive)..."
	@[ -e $(HOME_DIR)/.vimrc ] && rm -f $(HOME_DIR)/.vimrc
	@ln -nsf $(CONFIGS_DIR)/.vimrc $(HOME_DIR)/.vimrc
	@echo "✅ .vimrc linked"

install-git-config:
	@echo "🔧 Installing Git config (non-interactive)..."
	@git config --global core.excludesfile $(CONFIGS_DIR)/.gitignore.global
	@git config --global core.hooksPath $(BASH_DIR)/githooks
	@git config --global user.name "Nathan Stanley"
	@git config --global push.default current
	@git config --global push.autoSetupRemote true
	@git config --global pull.rebase false
	@git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
	@git config --global color.ui true
	@git config --global alias.unstage "restore --staged"
	@git config --global alias.uncommit "reset HEAD^"
	@echo "✅ Git configured"

# Non-interactive setup (skips whiptail prompts)
setup-noninteractive: homebrew install-zsh-config install-antigen brew-install-all install-vim-config install-git-config starship-config
	@echo "✅ Non-interactive setup complete!"

# Clean up any temporary files
clean:
	@echo "🧹 Cleaning up temporary files..."
	@rm -rf /tmp/setup-*
	@rm -f AWSCLIV2.pkg

# Show help
help:
	@echo "🛠  Available Make targets:"
	@echo ""
	@echo "Main targets:"
	@echo "  all                    - Run complete interactive setup (same as setup.sh)"
	@echo "  setup-noninteractive   - Run complete setup without prompts"
	@echo ""
	@echo "Individual components:"
	@echo "  homebrew              - Install Homebrew"
	@echo "  whiptail              - Install whiptail (for interactive prompts)"
	@echo "  zshrc                 - Setup zsh configuration (interactive)"
	@echo "  antigen               - Install Antigen zsh plugin manager (interactive)"
	@echo "  brew-install          - Install brew packages (interactive selection)"
	@echo "  brew-install-all      - Install all brew packages (non-interactive)"
	@echo "  git                   - Configure Git (interactive)"
	@echo "  vimrc                 - Setup Vim configuration (interactive)"
	@echo "  aws                   - Install AWS CLI"
	@echo "  starship-config       - Setup Starship prompt configuration"
	@echo ""
	@echo "Non-interactive installs:"
	@echo "  install-homebrew      - Install Homebrew"
	@echo "  install-zsh-config    - Link zsh config without prompts"
	@echo "  install-antigen       - Download Antigen without prompts"
	@echo "  install-vim-config    - Link vim config without prompts"
	@echo "  install-git-config    - Setup git config without prompts"
	@echo ""
	@echo "Utility:"
	@echo "  clean                 - Clean up temporary files"
	@echo "  help                  - Show this help message"

# Quick status check
status:
	@echo "🔍 Checking installation status..."
	@echo -n "Homebrew: "; if command -v brew &> /dev/null; then echo "✅ Installed"; else echo "❌ Not installed"; fi
	@echo -n "Zsh config: "; if [ -L $(HOME_DIR)/.zshrc ]; then echo "✅ Linked"; else echo "❌ Not linked"; fi
	@echo -n "Antigen: "; if [ -f $(CONFIGS_DIR)/antigen.zsh ]; then echo "✅ Available"; else echo "❌ Not downloaded"; fi
	@echo -n "Vim config: "; if [ -L $(HOME_DIR)/.vimrc ]; then echo "✅ Linked"; else echo "❌ Not linked"; fi
	@echo -n "Git configured: "; if git config --global user.name &> /dev/null; then echo "✅ Configured"; else echo "❌ Not configured"; fi
	@echo -n "Starship: "; if command -v starship &> /dev/null; then echo "✅ Installed"; else echo "❌ Not installed"; fi
	@echo -n "AWS CLI: "; if command -v aws &> /dev/null; then echo "✅ Installed"; else echo "❌ Not installed"; fi
