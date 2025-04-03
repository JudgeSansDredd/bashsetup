#!/usr/bin/env bash

source $HOME/.bash/setup/whiptail.sh

if (whiptail --yesno "Configure git on this machine?" --title "Git Config" $BOX_HEIGHT $BOX_WIDTH); then
    # Get git author email
    GIT_AUTHOR_EMAIL=$(whiptail --inputbox "What is the email address you would like used for git?" --nocancel $BOX_HEIGHT $BOX_WIDTH $GIT_AUTHOR_EMAIL --title "Git Author Email" 3>&1 1>&2 2>&3)

    # Configure git
    git config --global core.excludesfile $HOME/.bash/configs/.gitignore.global
    git config --global core.hooksPath $HOME/.bash/githooks
    git config --global user.name "Nathan Stanley"
    git config --global user.email $GIT_AUTHOR_EMAIL
    git config --global push.default current
    git config --global push.autoSetupRemote true
    git config --global pull.rebase false
    git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
    git config --global color.ui true
    git config --global color.diff-highlight.oldNormal    "red bold"
    git config --global color.diff-highlight.oldHighlight "red bold 52"
    git config --global color.diff-highlight.newNormal    "green bold"
    git config --global color.diff-highlight.newHighlight "green bold 22"
    git config --global color.diff.meta       "11"
    git config --global color.diff.frag       "magenta bold"
    git config --global color.diff.commit     "yellow bold"
    git config --global color.diff.old        "red bold"
    git config --global color.diff.new        "green bold"
    git config --global color.diff.whitespace "red reverse"
    git config --global alias.unstage "restore --staged"
    git config --global alias.uncommit "reset HEAD^"
    git config --global alias.ignore "update-index --skip-worktree"
    git config --global alias.unignore "update-index --no-skip-worktree"
    git config --global alias.stale "branch --all --sort=-committerdate --format=\"%(align:25)%(refname:short)%(end)%09%(committerdate:relative)\""
fi
