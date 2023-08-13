.PHONY: help
help:
	@echo "Usage:\n  make [brew] [apps] [github] [vim] [all]"


.PHONY: all
all:
	# @echo "Usage:\n  make [initial] [apps] [github] [vim]"
	@Make initial
	@Make apps
	@Make github
	@Make vim

.PHONY: initial
initial:
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

.PHONY: apps
apps:
	@echo 'Install brew, cask, and mas apps'
	@brew bundle

.PHONY: github
github:
	@ghq get https://github.com/mbadolato/iTerm2-Color-Schemes.git
	@ghq get https://github.com/kiriake/dotfiles.git
	@sudo ln -s ~/git/github.com/kiriake/dotfiles/zshrc ~/.zshrc
	@sudo ln -s ~/git/github.com/kiriake/dotfiles/vimrc ~/.vimrc
	@sudo ln -s ~/git/github.com/kiriake/dotfiles/deinrc ~/.deinrc
	@sudo ln -s ~/git/github.com/kiriake/dotfiles/tmux.conf ~/.tmux.conf
	
.PHONY: vim
vim:
	@curl -O https://raw.githubusercontent.com/Shougo/dein-installer.vim/master/installer.sh
	@/bin/sh ./installer.sh
	@rm ./installer.sh
