#!/bin/sh
set -e


docker__list_sh() # IMG...
{
  test -n "$*" || set -- alpine:3.8 debian:9-slim ubuntu:18.04 base/archlinux:2018.10.01
  for img in "$@"
  do echo "$img";
    docker run --rm -i "$img" \
      sh -c 'ls -la /bin/*sh /usr/bin/*sh /usr/local/bin/*sh' || true
  done
}

docker__test_sh() # SH
{
  test -n "$2" || set -- "$1" "heirloom-sh"
  docker run --rm \
     --entrypoint ["$1"] \
     -v $(realpath $HOME/bin):/root/bin \
     -v $(realpath build/test-sh.sh):/test-sh.sh \
     -i "$2" '/test-sh.sh'
}

docker_bash() { docker__test_sh "bash" "debian:9-slim"; }
docker_bash_sh() { docker__test_sh "sh" "debian:9-slim"; }
docker_rbash() { docker__test_sh "rbash" "debian:9-slim"; }

# Ubuntu has an dash/sh
docker_dash() { docker__test_sh "dash" "ubuntu:18.04"; }
docker_dash_sh() { docker__test_sh "sh" "ubuntu:18.04"; }

# Alpine's shell is a bb-sh; comes with /bin/{sh,ash} -> /bin/busybox
docker_bb_sh() { docker__test_sh "sh" "alpine:3.8"; }
docker_bb_ash() { docker__test_sh "ash" "alpine:3.8"; }

docker_ksh() { docker__test_sh "ksh" "bvberkum/heirloom-sh"; }
docker_zsh() { docker__test_sh "zsh" "bvberkum/heirloom-sh"; }
docker_jsh() { docker__test_sh "jsh" "bvberkum/heirloom-sh"; }
docker_heirloom_sh() { docker__test_sh "sh" "bvberkum/heirloom-sh"; }

every()
{
  docker_bash &&
  docker_bash_sh &&
  docker_rbash &&
  docker_dash &&
  docker_dash_sh &&
  docker_bb_sh &&
  docker_bb_ash &&
  docker_ksh &&
  docker_zsh &&
  docker_heirloom_sh
}

build()
{
  docker__test_sh "sh" "heirloom-sh" &&
  docker__test_sh "jsh" "heirloom-sh" &&
  docker__test_sh "bash" "heirloom-sh" &&
  docker__test_sh "rbash" "heirloom-sh" &&
  docker__test_sh "ksh" "heirloom-sh" &&
  docker__test_sh "zsh" "heirloom-sh"
}

all()
{
  build
}

"$@"
