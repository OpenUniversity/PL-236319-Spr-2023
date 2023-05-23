#!/bin/bash

testsurl="https://raw.githubusercontent.com/AdiHarif/236319-Spr-2023/master/HW/Homework3/"

tmpdir="selfcheck_tmp"
test_files=("q1" "q2")
required_files=("hw3_q1.sml" "hw3_q2.sml" "dry.pdf")

if [ -z "$1" ]; then
	echo "Usage: ./"$( basename "$0" )" <your submission zip file>"
	exit
fi

if [ ! -f "$1" ]; then
	echo "Submission zip file not found!"
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

for test in "${test_files[@]}"
do
	wget "$testsurl$test.in" "$testsurl$test.expected" "${testsurl}hw3_${test}_def.sml" &> /dev/null
	if [ ! -f "$test.in" ] || [ ! -f "$test.expected" ] || [ ! -f "hw3_${test}_def.sml" ]; then
		echo "Unable to download test $test!"
		exit
	fi
	sml hw3_$test.sml < $test.in &> $test.rawout
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
