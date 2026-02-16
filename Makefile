HOME_DIR := $(HOME)
BASH_DIR := $(HOME)/.bash
CONFIGS_DIR := $(BASH_DIR)/configs
BREW_PACKAGES := alfred eza iterm2 google-chrome rectangle spotify monitorcontrol visual-studio-code \
				 tlrc diff-so-fancy bat fzf volta lastpass-cli lazydocker lazygit \
				 slack htop session-manager-plugin terraform jq macmediakeyforwarder \
				 pyenv starship font-hack-nerd-font ack maccy k9s rancher jenv copilot-cli \
				 kubeseal helm openclaw

.PHONY: all
all:
	@echo "🛠  Available Make targets:"
	@echo ""
	@echo "Main targets:"
	@echo "  setup                    - Run complete setup"
	@echo ""
	@echo "Individual components:"
	@echo "  homebrew                 - Install Homebrew"
	@echo "  zshrc                    - Setup zsh configuration"
	@echo "  antigen                  - Install Antigen zsh plugin manager"
	@echo "  brew-install-packages    - Install all brew packages"
	@echo "  volta-install-packages   - Install all Volta packages"
	@echo "  git-config               - Configure Git"
	@echo "  vimrc                    - Setup Vim configuration"
	@echo "  aws                      - Install AWS CLI"
	@echo "  starship-config          - Setup Starship prompt configuration"
	@echo "  make-kube-dir            - Create .kube directory"
	@echo "  install-ktx              - Install ktx plugin"
	@echo ""
	@echo "Configuration:"
	@echo "  set-machine-type         - Set machine type (personal/work)"
	@echo ""
	@echo "Utility:"
	@echo "  status                   - Check installation status"
	@echo "  clean                    - Clean up temporary files"

.PHONY: setup
setup: homebrew zshrc antigen brew-install-packages volta-install-packages git-config vimrc aws starship-config make-kube-dir install-ktx clean
	@echo "✅ Complete setup finished!"

.PHONY: homebrew
homebrew:
	@echo "🍺 Setting up Homebrew..."
	@if ! command -v brew &> /dev/null; then \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	else \
		echo "Homebrew already installed"; \
	fi

.PHONY: zshrc
zshrc:
	@echo "🐚 Setting up zshrc..."
	@rm -f $(HOME_DIR)/.zshrc
	@ln -nsf $(CONFIGS_DIR)/.zshrc $(HOME_DIR)/.zshrc
	@echo "✅ .zshrc linked"

.PHONY: antigen
antigen:
	@echo "🔌 Setting up Antigen..."
	@curl -L git.io/antigen > $(CONFIGS_DIR)/antigen.zsh
	@echo "✅ Antigen downloaded"

.PHONY: brew-install-packages
brew-install-packages: homebrew
	@echo "📦 Installing all brew packages..."
	@for package in $(BREW_PACKAGES); do \
		if brew list $$package &> /dev/null; then \
			echo "⏭️  $$package already installed"; \
		else \
			echo "📥 Installing $$package..."; \
			brew install $$package; \
		fi; \
	done
	@brew cleanup
	@echo "✅ Brew packages installed"

.PHONY: starship-config
starship-config:
	@echo "🚀 Setting up Starship configuration..."
	@if command -v starship &> /dev/null; then \
		mkdir -p $(HOME_DIR)/.config; \
		ln -nsf $(CONFIGS_DIR)/starship.toml $(HOME_DIR)/.config/starship.toml; \
		echo "Starship config linked"; \
	else \
		echo "Starship not installed, skipping config"; \
	fi

.PHONY: git-config
git-config:
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
	@git config --global alias.noop "commit --allow-empty -m 'No-op commit'"
	@git config --global alias.tree "log --graph --abbrev-commit --decorate --all"
	@echo "✅ Git configured"

.PHONY: vimrc
vimrc:
	@echo "📝 Setting up Vim configuration..."
	@rm -f $(HOME_DIR)/.vimrc
	@ln -nsf $(CONFIGS_DIR)/.vimrc $(HOME_DIR)/.vimrc
	@echo "✅ .vimrc linked"

.PHONY: aws
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

.PHONY: volta-install-packages
volta-install-packages: brew-install-packages
	@echo "⚡ Installing Volta packages..."
	@volta install openclaw@latest
	@echo "✅ Volta packages installed"

.PHONY: make-kube-dir
make-kube-dir:
	@echo "📁 Creating .kube directory..."
	@mkdir -p $(HOME_DIR)/.kube
	@echo "✅ .kube directory created"

.PHONY: install-ktx
install-ktx: make-kube-dir homebrew
	@echo "📥 Installing ktx plugin..."
	@brew tap peledies/formulae
	@brew install ktx
	@echo "✅ ktx plugin installed"; \

.PHONY: clean
clean:
	@echo "🧹 Cleaning up temporary files..."
	@rm -rf /tmp/setup-*
	@rm -f AWSCLIV2.pkg

.PHONY: bash-custom
bash-custom:
	@if [ ! -f $(BASH_DIR)/bash_source/bash_custom ]; then \
		echo "📝 Creating bash_custom file..."; \
		echo "# Machine Type: Set to 'personal' or 'work'" > $(BASH_DIR)/bash_source/bash_custom; \
		echo "# This file is not tracked by git, so it's safe to customize per machine" >> $(BASH_DIR)/bash_source/bash_custom; \
		echo "export MACHINE_TYPE=\"personal\"" >> $(BASH_DIR)/bash_source/bash_custom; \
		echo "✅ bash_custom created with default MACHINE_TYPE=personal"; \
	fi

.PHONY: set-machine-type
set-machine-type: bash-custom
	@echo "⚙️  Setting machine type..."
	@echo "Choose machine type:"
	@echo "  1) personal"
	@echo "  2) work"
	@read -p "Enter choice [1-2]: " choice; \
	if [ "$$choice" = "1" ]; then \
		machine_type="personal"; \
	elif [ "$$choice" = "2" ]; then \
		machine_type="work"; \
	else \
		echo "❌ Invalid choice. Please enter 1 or 2."; \
		exit 1; \
	fi; \
	if grep -q "export MACHINE_TYPE=" $(BASH_DIR)/bash_source/bash_custom; then \
		sed -i '' "s/export MACHINE_TYPE=.*/export MACHINE_TYPE=\"$$machine_type\"/" $(BASH_DIR)/bash_source/bash_custom; \
	else \
		echo "" >> $(BASH_DIR)/bash_source/bash_custom; \
		echo "# Machine Type: Set to 'personal' or 'work'" >> $(BASH_DIR)/bash_source/bash_custom; \
		echo "export MACHINE_TYPE=\"$$machine_type\"" >> $(BASH_DIR)/bash_source/bash_custom; \
	fi; \
	echo "✅ Machine type set to: $$machine_type"; \
	echo "💡 Reload your shell with: source ~/.zshrc"

.PHONY: status
status:
	@echo "🔍 Checking installation status..."
	@echo -n "Homebrew: "; if command -v brew &> /dev/null; then echo "✅ Installed"; else echo "❌ Not installed"; fi
	@echo -n "Zsh config: "; if [ -L $(HOME_DIR)/.zshrc ]; then echo "✅ Linked"; else echo "❌ Not linked"; fi
	@echo -n "Antigen: "; if [ -f $(CONFIGS_DIR)/antigen.zsh ]; then echo "✅ Available"; else echo "❌ Not downloaded"; fi
	@echo -n "Vim config: "; if [ -L $(HOME_DIR)/.vimrc ]; then echo "✅ Linked"; else echo "❌ Not linked"; fi
	@echo -n "Git configured: "; if git config --global user.name &> /dev/null; then echo "✅ Configured"; else echo "❌ Not configured"; fi
	@echo -n "Starship: "; if command -v starship &> /dev/null; then echo "✅ Installed"; else echo "❌ Not installed"; fi
	@echo -n "AWS CLI: "; if command -v aws &> /dev/null; then echo "✅ Installed"; else echo "❌ Not installed"; fi
	@echo -n "Machine type: "; if grep -q "export MACHINE_TYPE=" $(BASH_DIR)/bash_source/bash_custom; then grep "export MACHINE_TYPE=" $(BASH_DIR)/bash_source/bash_custom | sed 's/export MACHINE_TYPE=//;s/\"//g'; else echo "❌ Not set"; fi
