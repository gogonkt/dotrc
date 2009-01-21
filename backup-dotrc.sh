#!/bin/bash

#script for backup dotrc file had changed
cp ~/.zshrc .

git add .
git commit -e
