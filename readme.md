# Clone this repository

> Important: This **MUST** be cloned into $HOME/.bash

    git clone git@github.com:JudgeSansDredd/bashsetup.git $HOME$/.bash

# Run setup

    make

# Set up the computer

- Get git
  - This will likely install xcode command line tools
- Make an SSH key
  - `ssh-keygen -t rsa -b 4096`
- Put the SSH key onto Github
  - `cat ~/.ssh/id_rsa.pub | pbcopy`
- Clone this repo to the $HOME/.bash directory
  - `git clone git@github.com:JudgeSansDredd/bashsetup.git .bash`
- Run the makefile
  - `cd ~/.bash && make`
- Back up your ssh key to lastpass
