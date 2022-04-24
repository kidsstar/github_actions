#!/usr/bin/env bash

set -eux

function git_add() {
  local path=$1
  if [ -f "$path" ]; then
    git add "$path"
  fi
}

function is_git_stage_changes() {
  if [ "$(git status -s -uno | grep -c -v '^ ')" -eq 0 ];then
    echo 0
  else
    echo 1
  fi
}
