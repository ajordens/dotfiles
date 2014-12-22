#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git remote add upstream git@github.com:mathiasbynens/dotfiles.git;
#git fetch upstream;
#git merge upstream/master;
#git pull origin master;
git update

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "brew.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
    --exclude "fonts" \
		-avh --no-perms . ~;
	rsync --exclude ".DS_Store" -av --no-perms fonts/ ~/Library/Fonts/
	source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
