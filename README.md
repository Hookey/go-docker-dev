# go-vim Docker image
This Docker image adds [Go](https://golang.org/) tools and the following vim plugins to the [official Go image](https://registry.hub.docker.com/_/golang/):

* [vim-go](https://github.com/fatih/vim-go)
* [tagbar](https://github.com/majutsushi/tagbar)
* [NERD Tree](https://github.com/scrooloose/nerdtree)
* [vim-airline](https://github.com/bling/vim-airline)
* [fugitive.vim](https://github.com/tpope/vim-fugitive)
* [NERD Tree tabs](https://github.com/jistr/vim-nerdtree-tabs)
* [undotree](https://github.com/mbbill/undotree)
* [vim-easymotion](https://github.com/Lokaltog/vim-easymotion)
* [NERD Commenter](https://github.com/scrooloose/nerdcommenter)
* [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)
* [ultisnips](https://github.com/SirVer/ultisnips)
* [vim-snippets](https://github.com/honza/vim-snippets)
* [delimitMate](https://github.com/Raimondi/delimitMate)
* [nerdtree-git-plugin](https://github.com/Xuyuanp/nerdtree-git-plugin)
* [vim-autoformat](https://github.com/Chiel92/vim-autoformat)
* [ctrlp.vim](https://github.com/kien/ctrlp.vim)
* [molokai](https://github.com/tomasr/molokai)
* [vim-osc52](https://github.com/fcpg/vim-osc52)

## Usage

Run this image from within your go workspace. You can than edit your project using `vim`, and usual go commands: `go build`, `go run`, etc. 

```
docker build . --file Dockerfile --tag go-ide
cd your/go/workspace
docker run --rm -tiv `pwd`:/go go-ide
```

## Limitations

This image lacks [gdb](https://golang.org/doc/gdb) support. If anyone has managed to get it working on this image, please let me know (breakpoints are not working for me).
