#!/usr/bin/env bash

# Make sure we have pulled in and updated any submodules
git submodule init
git submodule update

# What directories should be installable by all users including the root
base=(
    bash
)

# Folders that should, or only need to be installed for the local user
useronly=(
    i3
    vim
    git
)

# Run the stow command for the passed in directory ($2) in location $1
stowit() {
	usr=$1
	app=$2
	# -v verbose
	# -R recursive
	# -t target
	stow -v -R -t ${usr} ${app}
}

echo ""
echo "Stowing apps for user: ${whoami}"

# Install apps available to local users and root
for app in ${base[@]}; do
	stowit "${HOME}" $app
done

# Install only user space folders
for app in ${useronly[@]}; do
	if [[ ! "$(whoami)" = *"root"* ]]; then
		stowit "${HOME}" $app
	fi
done

echo ""
echo "#### ALL DONE"
