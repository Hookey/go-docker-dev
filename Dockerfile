FROM golang:latest
MAINTAINER Michele Bertasi

# install pagkages
RUN apt-get update                                                      && \
    apt-get install -y ncurses-dev libtolua-dev exuberant-ctags gdb git    \
        python3 python3-dev cmake                                       && \
    ln -s /usr/include/lua5.2/ /usr/include/lua                         && \
    ln -s /usr/lib/x86_64-linux-gnu/liblua5.2.so /usr/lib/liblua.so     && \
# cleanup
    apt-get clean && rm -rf /var/lib/apt/lists/*

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
    go get golang.org/x/tools/gopls@latest                              && \
    go get golang.org/x/tools/cmd/godoc                                 && \
    go get github.com/nsf/gocode                                        && \
    go get golang.org/x/tools/cmd/goimports                             && \
    go get github.com/rogpeppe/godef                                    && \
    go get golang.org/x/tools/cmd/gorename                              && \
    go get golang.org/x/lint/golint                                     && \
    go get github.com/kisielk/errcheck                                  && \
    go get github.com/jstemmer/gotags                                   && \
    go get github.com/tools/godep                                       && \
    go get github.com/go-delve/delve/cmd/dlv                            && \
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
    vim +PlugInstall +qall                                              && \ 
    vim -c GoInstallBinaries -c 'qa!'                                   && \ 
    cd ~/.vim/plugged/YouCompleteMe                                     && \
    ./install.py --clangd-completer

