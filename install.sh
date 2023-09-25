# Run me with sudo

set -x

#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")


sudo apt-get install -y \
    curl \
    cmake \
    exuberant-ctags \
    git \
    gcc\
    fonts-powerline \
    libncurses-dev \
    python3-dev \
    python3-pip \
    tmux \
    xclip \
    zsh \
    ;

sudo yum install -y https://centos7.iuscommunity.org/ius-release.rpm
sudo yum update -y
sudo yum install -y python36u python36u-libs python36u-devel python36u-pip

sudo yum install -y \
    curl \
    cmake \
    ctags \
    git \
    git-annex \
    gcc-c++ \
    ncurses-devel \
    python-devel \
    python-pip \
    tmux \
    termcap-devel \
    vim-gtk3 \
    zsh \
    ;

git clone https://github.com/vim/vim.git --depth 1

cd vim/src && ./configure \
  --disable-nls \
  --enable-cscope \
  --enable-gui=no \
  --enable-multibyte  \
  --enable-python3interp \
  --enable-rubyinterp \
  --with-features=huge  \
  --with-tlib=ncurses \
  --without-x

sudo rm /usr/local/bin/vim
make && sudo make install


mkdir -p  ~/.vim/bundle

sudo pip install cheat;

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended"

rm -rf ~/.vim/bundle/Vundle.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim --depth 1
vim +PluginInstall +qall

cd ~/.vim/bundle/youcompleteme && python ./install.py --clang-completer
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

cd $SCRIPT_DIR
ls -d .[a-z]* | grep -v .git | xargs -I{} ln -sf $SCRIPT_DIR/{} ~/{}

cd ~
sudo chsh -s "$(command -v zsh)" "${USER}"
