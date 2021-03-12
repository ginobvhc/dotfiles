#!/usr/bin/env bash
set -euo pipefail


mbsync  -c ~/.config/mu4e/.mbsyncrc -aV 
mu init
mu index

rm ~/Maildir/trash/cur/*
