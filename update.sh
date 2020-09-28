#!/bin/bash

# Bundles: flazz/vim-colorschemes chriskempson/base16-vim daylerees/colour-schemes/vim
repos="
altercation/vim-colors-solarized
baskerville/bubblegum
dracula/vim
ehartc/spink
endel/vim-github-colorscheme
freeo/vim-kalisi
fxn/vim-monochrome
goatslacker/mango.vim
google/vim-colorscheme-primary
jnurmine/zenburn
jonathanfilip/vim-lucius
joshdick/onedark.vim
junegunn/seoul256.vim
lifepillar/vim-solarized8
lokaltog/vim-distinguished
mhartington/oceanic-next
mhinz/vim-janah
morhetz/gruvbox
mswift42/vim-themes
nanotech/jellybeans.vim
nlknguyen/papercolor-theme
sainnhe/edge
noahfrederick/vim-hemisu
rakr/vim-one
reedes/vim-colors-pencil
rking/vim-detailed
robertmeta/nofrils
romainl/apprentice
romainl/flattened
sickill/vim-monokai
sjl/badwolf
sk1418/last256
sts10/vim-mustard
tomasr/molokai
tpope/vim-vividchalk
trevordmiller/nova-vim
twerth/ir_black
vim-scripts/fu
vim-scripts/twilight
w0ng/vim-hybrid
whatyouhide/vim-gotham
zeis/vim-kolor
"

cd ./upstreams

for repo in $repos; do
  dir=${repo#*/}
  if [[ -d $dir ]]; then
    [[ ! $1 =~ n ]] && git -C $dir pull
  else
    git clone --depth=1 https://github.com/$repo
  fi &
  while (( $(jobs | wc -l) > 12 )); do
    wait $!
  done
done
wait

shopt -s extglob globstar nullglob

for dir in *; do
  cd $dir >/dev/null
  for f in {colors,autoload}/*.vim doc/*.txt; do
    d=../../${f%/*}; [[ -d $d ]] || mkdir -p $d
    [[ $f -nt ../../$f || ! -e ../../$f ]] && cp -f $f $d
  done
  cd - >/dev/null
done
