#!/bin/bash

#read -p "Enter you name: " name

#echo "Your Name = ${name}"
# Special Variables around inputs are $0-$n, $*. $@, $#

echo Script Name = $0
echo First Argument = $1
echo Second Argument = $2

echo All Arguments = $*
echo All Arguments = $@

echo Number of the Arguments = $#

echo "is this testing"