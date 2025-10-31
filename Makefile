.PHONY: all homebrew zshrc antigen brew-install-packages git vimrc aws clean help starship-config

HOME_DIR := $(HOME)
BASH_DIR := $(HOME)/.bash
CONFIGS_DIR := $(BASH_DIR)/configs
BREW_PACKAGES := alfred eza iterm2 google-chrome rectangle spotify monitorcontrol \
				 tlrc diff-so-fancy bat fzf volta lastpass-cli lazydocker lazygit \
				 slack htop session-manager-plugin terraform jq macmediakeyforwarder \
				 pyenv starship font-hack-nerd-font ack maccy

all: homebrew zshrc antigen brew-install-packages git vimrc aws starship-config clean
	@echo "✅ Complete setup finished!"

homebrew:
	@echo "🍺 Setting up Homebrew..."
	@if ! command -v brew &> /dev/null; then \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	else \
		echo "Homebrew already installed"; \
	fi

zshrc:
	@echo "🐚 Setting up zshrc..."
	@[ -e $(HOME_DIR)/.zshrc ] && rm -f $(HOME_DIR)/.zshrc
	@ln -nsf $(CONFIGS_DIR)/.zshrc $(HOME_DIR)/.zshrc
	@echo "✅ .zshrc linked"

antigen:
	@echo "🔌 Setting up Antigen..."
	@curl -L git.io/antigen > $(CONFIGS_DIR)/antigen.zsh
	@echo "✅ Antigen downloaded"

brew-install-packages: homebrew
	@echo "📦 Installing all brew packages..."
	@brew install $(BREW_PACKAGES)
	@brew cleanup
	@brew doctor
	@echo "✅ Brew packages installed"

starship-config:
	@echo "🚀 Setting up Starship configuration..."
	@if command -v starship &> /dev/null; then \
		mkdir -p $(HOME_DIR)/.config; \
		ln -nsf $(CONFIGS_DIR)/starship.toml $(HOME_DIR)/.config/starship.toml; \
		echo "Starship config linked"; \
	else \
		echo "Starship not installed, skipping config"; \
	fi

git:
	@echo "🔧 Setting up Git configuration..."
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

vimrc:
	@echo "📝 Setting up Vim configuration..."
	@[ -e $(HOME_DIR)/.vimrc ] && rm -f $(HOME_DIR)/.vimrc
	@ln -nsf $(CONFIGS_DIR)/.vimrc $(HOME_DIR)/.vimrc
	@echo "✅ .vimrc linked"

aws: brew-install-packages
	@echo "☁️  Setting up AWS CLI..."
	@if ! command -v aws &> /dev/null; then \
		echo "Installing AWS CLI..."; \
		curl -s "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"; \
		sudo installer -pkg AWSCLIV2.pkg -target /; \
		rm -f AWSCLIV2.pkg; \
		echo "✅ AWS CLI installed"; \
	else \
		echo "AWS CLI already installed"; \
	fi

clean:
	@echo "🧹 Cleaning up temporary files..."
	@rm -rf /tmp/setup-*
	@rm -f AWSCLIV2.pkg

help:
	@echo "🛠  Available Make targets:"
	@echo ""
	@echo "Main targets:"
	@echo "  all                      - Run complete setup"
	@echo ""
	@echo "Individual components:"
	@echo "  homebrew                 - Install Homebrew"
	@echo "  zshrc                    - Setup zsh configuration"
	@echo "  antigen                  - Install Antigen zsh plugin manager"
	@echo "  brew-install-packages    - Install all brew packages"
	@echo "  git                      - Configure Git"
	@echo "  vimrc                    - Setup Vim configuration"
	@echo "  aws                      - Install AWS CLI"
	@echo "  starship-config          - Setup Starship prompt configuration"
	@echo ""
	@echo "Utility:"
	@echo "  status                   - Check installation status"
	@echo "  clean                    - Clean up temporary files"
	@echo "  help                     - Show this help message"

status:
	@echo "🔍 Checking installation status..."
	@echo -n "Homebrew: "; if command -v brew &> /dev/null; then echo "✅ Installed"; else echo "❌ Not installed"; fi
	@echo -n "Zsh config: "; if [ -L $(HOME_DIR)/.zshrc ]; then echo "✅ Linked"; else echo "❌ Not linked"; fi
	@echo -n "Antigen: "; if [ -f $(CONFIGS_DIR)/antigen.zsh ]; then echo "✅ Available"; else echo "❌ Not downloaded"; fi
	@echo -n "Vim config: "; if [ -L $(HOME_DIR)/.vimrc ]; then echo "✅ Linked"; else echo "❌ Not linked"; fi
	@echo -n "Git configured: "; if git config --global user.name &> /dev/null; then echo "✅ Configured"; else echo "❌ Not configured"; fi
	@echo -n "Starship: "; if command -v starship &> /dev/null; then echo "✅ Installed"; else echo "❌ Not installed"; fi
	@echo -n "AWS CLI: "; if command -v aws &> /dev/null; then echo "✅ Installed"; else echo "❌ Not installed"; fi
