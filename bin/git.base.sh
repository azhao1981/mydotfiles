#!/bin/bash

function git_current_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/"
}