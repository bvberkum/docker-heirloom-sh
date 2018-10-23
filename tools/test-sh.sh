#!/bin/sh
set -e

. ~/bin/bash.lib.sh
bash_lib_load
#bash_sh_autotest "$SHELL"

echo "$heirloom_sh_bi_cmds $heirloom_sh_bin_cmds" |
    tr ' ' '\n' |
    grep -Ev '^\s*(#.*|\s*)$' |
while read cmd
do

  type "$cmd" || true

done
