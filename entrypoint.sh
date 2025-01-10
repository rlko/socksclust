#!/bin/sh

if [ -z "${SSH_USER}" ] || [ -z "${SSH_HOST}" ]; then
  echo "SSH_USER and SSH_HOST must be set!"
  exit 1
fi

if [ -f "${SSH_KEY_PATH}" ]; then
  echo "Using SSH key for authentication."
  AUTH_METHOD="ssh -i ${SSH_KEY_PATH}"
elif [ -n "${SSH_PASSWORD}" ]; then
  echo "Using SSH password for authentication."
  export SSHPASS="${SSH_PASSWORD}"
  AUTH_METHOD="sshpass -e ssh -o PasswordAuthentication=yes"
else
  echo "No SSH key or password found! Please provide one."
  exit 1
fi

${AUTH_METHOD} -p ${SSH_PORT} -D 0.0.0.0:${SOCKS_PORT} -N ${SSH_USER}@${SSH_HOST} -o StrictHostKeyChecking=no

