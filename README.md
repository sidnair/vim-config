Installation
------------

To install, run

    git clone git://github.com/sidnair/vim-config.git ~/.vim
    cd ~/.vim
    make install

Follow the instructions for installing YouCompleteMe and tern\_for\_vim in each
plugin's README.

To update the repository, run

    make update

Notes
------------
- vimrc is commented; reading it is the best way to get a sense of what's added.
  In particular, the "Keybindings" sections might be useful.
- The line `set gdefault` makes search and replace global by default. This means
  that adding `/g` only replace the first instance on a line.
- For YCM, I had to run `./install.sh --clang-completer --system-libclang`
  because of some issues with Arch. See
  https://github.com/Valloric/YouCompleteMe/issues/538 and
  https://github.com/Valloric/YouCompleteMe/issues/870#issuecomment-57724690
- If you see weird symbols in your status line, you need a special font to
  render some unicode symbols. You can disable this by removing the line
    `let g:airline_powerline_fonts = 1`
  from the vimrc. [vim-airline](https://github.com/bling/vim-airline) Has
  instructions for updating the font if you want to symbols.

  You can install all the fonts from https://github.com/powerline/fonts.

  On my Linux box, I ran `fc-match monospace` to find which font I was using in
  my terminal, moved the relevant font from
  [here](https://github.com/Lokaltog/powerline-fonts) to ~/.fonts, ran `fc-cache
  -v ~/.fonts` to update the font cache, and updated my KDE settings to use it.

  On OS X, I set the font in iTerm to the patched version of Deja Vu.

.mine files
------------

vimrc.mine and gvimrc.mine contain system-specific settings or other settings
that should not be part of a general configuration. Thus, they are not tracked
in the repo. They are included in your vimrc automatically. I have included some
examples of what this might look like.

Compatability
------------

Should work on Linux and Mac OS X. Untested on Windows.


nvim
------------

1) Install neovim (e.g. `brew install neovim`)

2) Create `~/.config/nvim/init.vim` with:

```
set runtimepath^ = ~/.vim runtimepath+ = ~/.vim/after
let &packpath    = &runtimepath
source ~/.vimrc
```

3) `pip install neovim` for Python support
