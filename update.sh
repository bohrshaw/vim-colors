#!/bin/bash

# Bundles: flazz/vim-colorschemes chriskempson/base16-vim daylerees/colour-schemes/vim
repos="robertmeta/nofrils junegunn/seoul256.vim w0ng/vim-hybrid reedes/vim-colors-pencil freeo/vim-kalisi altercation/vim-colors-solarized romainl/flattened twerth/ir_black whatyouhide/vim-gotham mhinz/vim-janah romainl/apprentice nanotech/jellybeans.vim zeis/vim-kolor jnurmine/zenburn sjl/badwolf goatslacker/mango.vim sk1418/last256 rking/vim-detailed lokaltog/vim-distinguished tomasr/molokai sickill/vim-monokai tpope/vim-vividchalk vim-scripts/twilight nlknguyen/papercolor-theme google/vim-colorscheme-primary endel/vim-github-colorscheme jonathanfilip/vim-lucius noahfrederick/vim-hemisu morhetz/gruvbox sts10/vim-mustard vim-scripts/fu fxn/vim-monochrome mswift42/vim-themes baskerville/bubblegum ehartc/spink"

cd ./upstreams

for repo in $repos; do
  dir=${repo#*/}
  if [[ -d $dir ]]; then
    [[ ! $1 =~ n ]] && git -C $dir pull
  else
    git clone --depth=1 https://github.com/$repo
  fi &
done
wait

shopt -s extglob globstar nullglob

for dir in *; do
  cd $dir >/dev/null
  for f in **/*.vim doc/*.txt; do
    d=../../${f%/*}; [[ -d $d ]] || mkdir -p $d
    [[ $f -nt ../../$f || ! -e ../../$f ]] && cp -f $f $d
  done
  cd - >/dev/null
done
