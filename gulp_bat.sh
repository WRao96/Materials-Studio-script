#!/usr/bin/bash

rename .txt .gin *.txt # modify the xxx.txt to xxx.gin, which is the input file of gulp
for file in $(ls ./)
do
	if [ "${file#*.}" = "gin" ];then
		./RunGULP.sh ${file:0:3}
	fi
done
