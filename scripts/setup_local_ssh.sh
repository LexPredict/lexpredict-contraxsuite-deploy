#!/usr/bin/env bash
# Generate new SSH key for local usage
ssh-keygen -f ~/.ssh/id_rsa

# Add server keys to users known hosts
ssh-keyscan -H localhost >> ~/.ssh/known_hosts

# Allow user to ssh to itself
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# Confirm local ssh without prompt
ssh localhost "whoami && hostname"
