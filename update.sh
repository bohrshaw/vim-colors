#!/bin/bash

cd ./upstreams || exit 1

repos="junegunn/seoul256.vim w0ng/vim-hybrid reedes/vim-colors-pencil freeo/vim-kalisi altercation/vim-colors-solarized twerth/ir_black romainl/apprentice nanotech/jellybeans.vim zeis/vim-kolor jnurmine/zenburn sjl/badwolf goatslacker/mango.vim sk1418/last256 rking/vim-detailed lokaltog/vim-distinguished tomasr/molokai sickill/vim-monokai tpope/vim-vividchalk vim-scripts/twilight nlknguyen/papercolor-theme google/vim-colorscheme-primary endel/vim-github-colorscheme jonathanfilip/vim-lucius noahfrederick/vim-hemisu morhetz/gruvbox"

for repo in $repos; do
  dir=${repo#*/}
  (
  if [[ -d $dir ]]; then
    [[ ! $1 =~ n ]] && cd ./$dir && git pull
  else
    git clone --depth=1 https://github.com/$repo && cd ./$dir || exit 1
  fi
  for f in **/*.vim doc/*.txt; do
    d=../../${f%/*}; [[ -d $d ]] || mkdir -p $d
    [[ $f -nt ../../$f ]] && cp -f $f $d
  done
  ) &
done
wait
