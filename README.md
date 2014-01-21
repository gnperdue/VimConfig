Initial Set-up
--------------

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
If I push those changes and then re-check out the enitre VimConfig module, the remote 
repository is correct. But this is sort of a painful way to swap a submodule.

Dealing with Changes to Submodules
----------------------------------

Example: I updated vim2hs. When checking `git status` in the vim2hs repository there is a 
detached HEAD, as expected. Therefore, I created a new branch with:

    git checkout -b work`date -u +%s`

This branch was committed. Note, in order to push this commit to the remote server 
for the first time, we have to change the remote url. The first time (after a 
`git submodule init` and `git submodule update`) we will get an error when trying to
push like:

    $ git push origin work1385047577
    fatal: remote error: 
      You can't push to git://github.com/blah.blah
      Use https://github.com/blah.blah

We fix this with:

    git remote set-url origin https://github.com/blah.blah

(Just use the URL Git tells you to use.) Then we can run:

    git push origin work1385047577

Now, the top-level repository, VimConfig, needs to point at 
that new commit for the submodule. This turns out to be very easy. `git status` in the 
supermodule reveals a change at `vim/bundle/vim2hs` - all that needs to be done is this
needs to have `git add vim/bundle/vim2hs` and then `git commit` to change the pointer
to the correct commit in the submodule.

As we keep making changes to submodules, we keep committing in the submodule first,
and then running `add` and `commit` in the supermodule to keep the pointers correct.

Other Usage Notes
-----------------

Syntastic:

* Add the file `.syntastic_cpp_config` to the GENIE project directory.
* Add lines like `-I/path/to/include/dirs` to get syntastic to find esoteric headers.

