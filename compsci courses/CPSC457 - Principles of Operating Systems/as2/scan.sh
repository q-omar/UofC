# /**********************************************
#  * Last Name:   Qureshi
#  * First Name:  Omar
#  * Student ID:  10086638
#  * Course:      CPSC 457
#  * Tutorial:    T04
#  * Assignment:  2
#  * Question:    Q1
#  *
#  * File name: scan.sh
#  *********************************************/

#!/bin/bash
#Hint: overall solution form: find <params> | sort <params> | head <params> | awk <params>'
find . -type f -name "*.$1" -printf "%s %p\n" | sort -nr | head -$2 | awk '{ x += $1 ; print $2 " " $1 } END { print "Total size: " x }'
