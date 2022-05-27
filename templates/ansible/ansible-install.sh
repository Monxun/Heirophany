#!/usr/bin/env bash


if ! [ -x "$(command -v ansible)" ]; then
  echo 'Status: ansible not installed...'
  sleep 3s
  apt-get update
  apt-get install software-properties-common
  apt-add-repository ppa:ansible/ansible
  sudo apt-get update
  apt-get install ansible
  echo 'Status: ansible installed successfully!'
fi

