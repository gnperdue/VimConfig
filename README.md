Right now this is more of a "log of how I set this up" rather than a 
proper "readme" for users who check this module out to play with.

First, we need to get a copy of pathogen.vim. It is included here from

* https://github.com/tpope/vim-pathogen

In this case, I have simply copied commit 

* 1270dceb1fe0ca35f8b292c7b41b45b42c5a0cc1

into vim/autoload and manually created vim/bundle. Then, go to vim/bundle
and begin adding submodules. Go to the top level:

* git submodule add git://github.com/gnperdue/vim2hs.git vim/bundle/vim2hs

Add some other submodules. Go to the top level:

* git submodule add git://github.com/tpope/vim-commentary.git vim/bundle/vim-commentary

Follow the pattern. Add:

* git submodule add git://github.com/scrooloose/syntastic.git vim/bundle/syntastic

Add more:

* git submodule add git://github.com/lukerandall/haskellmode-vim.git vim/bundle/haskellmode-vim
* git submodule add git://github.com/godlygeek/tabular.git vim/bundle/tabular
* git submodule add git://github.com/jelera/vim-javascript-syntax.git vim/bundle/vim-javascript-syntax
* git submodule add git://github.com/wookiehangover/jshint.vim.git vim/bundle/jshint
* git submodule add git://github.com/pbrisbin/html-template-syntax.git vim/bundle/html-template-syntax
* git submodule add git://github.com/ujihisa/neco-ghc.git vim/bundle/neco-ghc
* git submodule add git://github.com/jimenezrick/vimerl.git vim/bundle/vimerl
* git submodule add git://github.com/honza/vim-snippets.git vim/bundle/vim-snippets
* git submodule add git://github.com/garbas/vim-snipmate.git vim/bundle/vim-snipmate
* git submodule add git://github.com/tomtom/tlib_vim.git vim/bundle/tlib_vim
* git submodule add git://github.com/MarcWeber/vim-addon-mw-utils.git vim/bundle/vim-addon-mw-utils
* git submodule add git://github.com/leshill/vim-json.git vim/bundle/vim-json
* git submodule add git://github.com/tpope/vim-markdown.git vim/bundle/vim-markdown

Note, when checking this module out, the submodules will initially be empty (the 
directories will be present, but they will hold no content). To fill them, go to the 
top level:

* git submodule init
* git submodule update

Attempt to change a submodule url: First, clean out the submodule. Then, edit the .gitmodules
file to use the new url. Then run `git submodule sync`. Then run `git submodule init`. 
Then, run `git submodule sync`. But, `git remote -v` still points to the old submodule...

