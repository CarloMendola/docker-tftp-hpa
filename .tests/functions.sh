#!/bin/bash

info() {
  echo "[INFO] $@"
}

run_statement() {
  echo "[RUN] $@"
  "$@"
}

err() {
  echo "[ERROR] $@" >&2
  exit 1
}