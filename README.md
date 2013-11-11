Right now this is more of a "log of how I set this up" rather than a 
proper "readme" for users who check this module out to play with.

First, we need to get a copy of pathogen.vim. It is included here from

  https://github.com/tpope/vim-pathogen

In this case, I have simply copied commit 

  1270dceb1fe0ca35f8b292c7b41b45b42c5a0cc1

into vim/autoload and manually created vim/bundle. Then, go to vim/bundle
and begin adding submodules. Go to the top level:

  git submodule add git://github.com/gnperdue/vim2hs.git vim/bundle/vim2hs

Add some other submodules. Go to the top level:

  git submodule add git://github.com/tpope/vim-commentary.git vim/bundle/vim-commentary

Follow the pattern. Add:

  git submodule add git://github.com/scrooloose/syntastic.git vim/bundle/syntastic

Note, when checking this module out, the submodules will initially be empty (the 
directories will be present, but they will hold no content). To fill them, go to the 
top level:

  git submodule init
  git submodule update



