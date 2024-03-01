.PHONY: help
help:
	@echo "Usage:\n  make [initial] [os] [apps] [github] [vim] [dein] [rust] [all]"


.PHONY: all
all:
	@Make initial
	@Make os
	@Make github
	@Make apps

.PHONY: initial
initial:
	@echo 'Install Rosetta 2'
	@softwareupdate --install-rosetta
	@echo 'Install Homebrew'
	@curl -O https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
	@/bin/bash install.sh
	@rm ./install.sh
	@echo 'Initial github configs'
	@echo '' > ~/.gitconfig
	@rm -rf ./git
	@git config --global user.name 'Koji Kiriake'
	@git config --global user.email 'kiriake@gmail.com'
	@echo '[ghq]\n  root = ~/git' >> ~/.gitconfig
	@cat ~/.gitconfig
	@echo 'eval "$$(/opt/homebrew/bin/brew shellenv)"' > ~/.zprofile
	$('eval "$$(/opt/homebrew/bin/brew shellenv)"')
	@Make dein

.PHONY: os
os:
	@defaults write com.apple.dock orientation right
	@defaults write com.apple.dock autohide -bool true
	@defaults write com.apple.dock persistent-apps -array
	@defaults write com.apple.dock magnification -bool true
	@defaults write com.apple.finder AppleShowAllFiles YES
	@killall Dock
	@killall Finder
	@killall SystemUIServer

.PHONY: apps
apps:
	@echo 'Install brew, cask, asdf, rust lang and mas apps'
	@brew update
	@brew bundle
	@make asdf
	@make rust

.PHONY: github
github:
	@ghq get https://github.com/mbadolato/iTerm2-Color-Schemes.git
	@ghq get https://github.com/kiriake/dotfiles.git
	@sudo ln -sf ~/git/github.com/kiriake/dotfiles/zshrc ~/.zshrc
	@sudo ln -sf ~/git/github.com/kiriake/dotfiles/zshrc.mine ~/.zshrc.mine
	@sudo ln -sf ~/git/github.com/kiriake/dotfiles/vimrc ~/.vimrc
	@sudo ln -sf ~/git/github.com/kiriake/dotfiles/deinrc ~/.deinrc
	@sudo ln -sf ~/git/github.com/kiriake/dotfiles/tmux.conf ~/.tmux.conf
	
.PHONY: asdf
asdf:
	@asdf plugin add aws-sam-cli
	@asdf plugin add awscli
	@asdf plugin add python
	@asdf plugin add terraform

.PHONY: dein
dein:
	@curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/Shougo/dein-installer.vim/master/installer.sh | sh
	@rm -rf ./none/

.PHONY: rust
rust:
	@curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

