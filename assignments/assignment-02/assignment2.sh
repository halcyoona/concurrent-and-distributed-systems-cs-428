#!/bin/bash
echo "Enter your Name"
read NAME
echo "Enter Your Roll #"
read ROLL
NOPROC=$(cat /proc/cpuinfo | grep 'model name' | awk 'END {print NR}')
PROC=$(uname -p)
MEM=$(cat /proc/meminfo | head -n 1 | awk '{print $2/1024/1024}')
UNAME=$(uname -sr)
echo "Name:             $NAME ($ROLL)"
echo "Processor Specs:  $PROC ($NOPROC)"
echo "Memory:           $MEM GB"
echo "Operating System: $UNAME"
echo -e "N\tOutput 1\tOutput 2\tOutput 3\tOutput 4\tOutput 5\tAverage"
echo "set term postscript eps enhanced" > GNUPLOT
echo "set output '$ROLL.eps'" >> GNUPLOT
echo "set xlabel 'Size'" >> GNUPLOT
echo "set ylabel 'Time'" >> GNUPLOT
echo "set title '$NAME ($ROLL)'" >> GNUPLOT
echo "plot 'FILE' using 1:7 title 'Average' with lines lt 1 lw 3, 'FILE' using 1:2 title 'Run 1' with lines lt 2 lw 1, 'FILE' using 1:3 title 'Run 2' with lines lt 3 lw 1, 'FILE' using 1:4 title 'Run 3' with lines lt 4 lw 1, 'FILE' using 1:5 title 'Run 4' with lines lt 5 lw 1, 'FILE' using 1:6 title 'Run 5' with lines lt 6 lw 1" >> GNUPLOT
rm -f FILE
for i in {100..4000..100}; do
	gcc $1 -fopenmp -DSIZE=$i
	OUTPUT1="$((./a.out > /dev/null) 2>&1 | awk '{print $2}')"
	OUTPUT2="$((./a.out > /dev/null) 2>&1 | awk '{print $2}')"
	OUTPUT3="$((./a.out > /dev/null) 2>&1 | awk '{print $2}')"
	OUTPUT4="$((./a.out > /dev/null) 2>&1 | awk '{print $2}')"
	OUTPUT5="$((./a.out > /dev/null) 2>&1 | awk '{print $2}')"
	AVERAGE="$(echo $OUTPUT1 $OUTPUT2 $OUTPUT3 $OUTPUT4 $OUTPUT5 | awk '{print($1+$2+$3+$4+$5)/5}'  )"
	echo -e "$i\t$OUTPUT1\t$OUTPUT2\t$OUTPUT3\t$OUTPUT4\t$OUTPUT5\t$AVERAGE" | tee -a FILE
done
gnuplot GNUPLOT
