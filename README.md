# Vim Config

Vim configuration files.

## Included plugins

### Autocompletion

- [Conquer of completion](https://github.com/neoclide/coc.nvim)

### Color schemes

- [Base16 color scheme](https://github.com/chriskempson/base16-vim)

### File checkers

- [Syntastic](https://github.com/vim-syntastic/syntastic)

### Additional file type support

- [Dotenv](https://github.com/tpope/vim-dotenv)

### Code navigation

- [FZF](https://github.com/junegunn/fzf.vim)
- [Unimpaired](https://github.com/tpope/vim-unimpaired)
- [Vinegar](https://github.com/tpope/vim-vinegar)

### Snippets

- [Ultisnips](https://github.com/SirVer/ultisnips)
- [Honza's snippet collection](https://github.com/honza/vim-snippets)

### Utilities

- [Case convert](https://github.com/chiedo/vim-case-convert)
- [Commentary](https://github.com/tpope/vim-commentary)
- [Lightline](https://github.com/itchyny/lightline.vim)
- [Obsession](https://github.com/tpope/vim-obsession)
- [Surround](https://github.com/tpope/vim-surround)

### Version control

- [Fugitive](https://github.com/tpope/vim-fugitive)
- [Git gutter](https://github.com/airblade/vim-gitgutter)

## Installation

Clone this repo in your home directory:

```
$ git clone --recursive https://github.com/rukbotto/vim-config.git ~/.vim
```

Install Conquer of Completion extensions from within vim:

```
:CocInstall coc-marketplace coc-json coc-tsserver coc-eslint
```

## Usage

Link `vimrc` file to your home directory:

```
$ ln -svf ~/.vim/vimrc ~/.vimrc
```

Link `gvimrc` file to your home directory:

```
$ ln -svf ~/.vim/gvimrc ~/.gvimrc
```

Create a `.local.vimrc` file so you can, for example, setup the color scheme or add spelling settings:

```
$ touch ~/.local.vimrc
$ vim ~/.local.vimrc
```
