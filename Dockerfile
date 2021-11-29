FROM golang:latest

# install pagkages
RUN apt-get update                                                      && \
    apt-get install -y ncurses-dev libtolua-dev exuberant-ctags gdb git    \
        python3 python3-dev                                             && \
    ln -s /usr/include/lua5.2/ /usr/include/lua                         && \
    ln -s /usr/lib/x86_64-linux-gnu/liblua5.2.so /usr/lib/liblua.so     && \
# cleanup
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    pip3 install --upgrade pip && \
    pip3 install cmake


# build and install vim
RUN cd /tmp                                                             && \
    git clone --depth 1 https://github.com/vim/vim.git                  && \
    cd vim                                                              && \
    ./configure --with-features=huge --enable-luainterp                    \
        --enable-gui=no --without-x --prefix=/usr                          \
        --enable-luainterp=yes --enable-mzschemeinterp                     \
        --enable-perlinterp=yes --enable-python3interp=yes                 \
        --enable-tclinterp=yes --enable-rubyinterp=yes --enable-cscope     \
        --enable-terminal --enable-autoservername --enable-multibyte       \
        --enable-xim --enable-fontset --with-python3-command=python3    && \
    make -j4 VIMRUNTIMEDIR=/usr/share/vim/vim82                         && \
    make install                                                        && \
# cleanup
    rm -rf /tmp/* /var/tmp/*

# get go tools
RUN go env -w GO111MODULE=on                                            && \
    go install golang.org/x/tools/gopls@latest                          && \
    go install golang.org/x/tools/cmd/godoc                             && \
    go install github.com/nsf/gocode                                    && \
    go install golang.org/x/tools/cmd/goimports                         && \
    go install golang.org/x/tools/cmd/guru                              && \
    go install github.com/golangci/golangci-lint/cmd/golangci-lint      && \
    go install github.com/davidrjenni/reftools/cmd/fillstruct           && \
    go install github.com/rogpeppe/godef                                && \
    go install golang.org/x/tools/cmd/gorename                          && \
    go install golang.org/x/lint/golint                                 && \
    go install github.com/kisielk/errcheck                              && \
    go install github.com/jstemmer/gotags                               && \
    go install github.com/tools/godep                                   && \
    go install github.com/go-delve/delve/cmd/dlv                        && \
    mv /go/bin/* /usr/local/go/bin                                      && \
# cleanup
    rm -rf /go/src/* /go/pkg

# add dev user and dotfiles
RUN git clone https://github.com/Hookey/dotfiles.git /home/dev          && \
    rm -rf /home/dev/.git                                               && \
    adduser dev --disabled-password --gecos ""                          && \
    echo "ALL            ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers     && \
    chown -R dev:dev /home/dev /go

USER dev
ENV HOME /home/dev

# install vim plugins
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs                       \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    vim +PlugInstall +qall

# complete vim-go, ycm
RUN vim -c GoInstallBinaries -c 'qa!'
RUN cd ~/.vim/plugged/YouCompleteMe                                     && \
    ./install.py --clangd-completer
