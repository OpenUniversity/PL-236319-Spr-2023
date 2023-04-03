#!/bin/bash

hw2="https://raw.githubusercontent.com/AdiHarif/236319-Spr-2023/master/HW/Homework2/"
hw3="https://raw.githubusercontent.com/AdiHarif/236319-Spr-2023/master/HW/Homework3/"
hw4="https://raw.githubusercontent.com/AdiHarif/236319-Spr-2023/master/HW/Homework4/"

tmpdir="selfcheck_tmp"
test_files=("q1" "q2" "q3")
required_files=("hw4_q1.sml" "hw4_q2.sml" "hw4_q3.sml" "dry.pdf")

if [ -z "$2" ]; then
	echo "Usage: ./"$( basename "$0" )" <your submission zip file> <directory with previous solutions>"
	exit
fi

if [ ! -f "$1" ]; then
	echo "Submission zip file not found!"
	exit
fi

if [ ! -d "$2" ]; then
	echo "Directory with previous solutions not found!"
	exit
fi

rm -rf "$tmpdir" &> /dev/null
if [ -d "$tmpdir" ]
	then
		echo "Cannot clear tmp directory. Please delete '$tmpdir' manually and try again"
		exit
fi
mkdir "$tmpdir" &> /dev/null

yes | apt install zip &> /dev/null

unzip "$1" -d "$tmpdir" &> /dev/null
if [[ $? != 0 ]]; then
	echo "Unable to unzip submission file!"
	exit
fi

cd "$tmpdir"
for f in "${required_files[@]}"
do
	if [ ! -f  $f ]; then
		echo "File $f not found!"
		exit
	fi
done

if [ $( ls | wc -l ) != ${#required_files[@]} ]; then
	echo "There are too many files in the submission"
	exit
fi

cp ../$2/* .  &> /dev/null

wget "${hw3}hw3_q1_def.sml" "${hw3}hw3_q2_def.sml" &> /dev/null
if [ ! -f "hw3_q1_def.sml" ] || [ ! -f "hw3_q2_def.sml" ]; then
	echo "Unable to download def files from previous homeworks!"
	exit
fi

for test in "${test_files[@]}"
do
	wget "$hw4$test.in" "$hw4$test.expected" "${hw4}hw3_${test}_def.sml" &> /dev/null
	sleep 3
	if [ ! -f "$test.in" ] || [ ! -f "$test.expected" ] || [ ! -f "hw4_${test}_def.sml" ]; then
		echo "Unable to download test $test!"
		exit
	fi
	sml hw4_$test.sml < $test.in &> $test.rawout
	sed '1,/===TEST START===/d' $test.rawout > $test.out
	diff $test.out $test.expected
	if [[ $? != 0 ]]; then
		echo "Failed test $test!"
		exit
	fi
done

cd - &> /dev/null
rm -rf "$tmpdir"

echo "Ok to submit :)"
exit
