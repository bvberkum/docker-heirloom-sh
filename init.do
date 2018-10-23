#!/bin/sh

. ./.env.sh

# Init
test -e ./heirloom-sh || {
  test -e /src/$heirloom_git && {
    ln -s /src/$heirloom_git
  } || {
    git clone http://$heirloom_git
  }
}
