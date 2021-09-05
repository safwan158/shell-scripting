#!/bin/bash

a=10

b=xyz

c=true

echo Value of a = $a
echo Value of b = ${b}

DATE=$(date +%F)
echo WELCOME, Today date is $DATE

a1=200

echo Val of ABC = ${ABC}

a2=300
b2=(100 abc 300 xyz)

echo ${b2[0]}
echo ${b2[1]}

declare -A new=( [class]=Devops [trainer]=John [timing]=6AMPST )

echo ${new[class]}
echo ${new[trainer]}
echo ${new[timing]}