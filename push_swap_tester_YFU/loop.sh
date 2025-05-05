ROOT=..
TIME_LIMIT=2.0

RED="\e[31m"
GREEN="\e[32m"
NOCOLOR="\e[0m"

if [ $# -lt 2 ]
then
	printf "${RED}Error : not enough arguments${NOCOLOR}\n"
	printf "Usage : bash loop.sh <stack size> <loop times>\n"
	exit 1
fi

make -C ./files/
g++ -O3 ./files/main.cpp -o ./files/better_random_test_cases

mkdir -p trace_loop

for ((i=1;i<=$2;i++));
do
	./files/better_random_test_cases $@ > ./trace_loop/test_case_$i.txt
done

make -C $ROOT/
make clean -C $ROOT/

clear

if [[ -f "$ROOT/push_swap" ]]
then
	printf "${GREEN}push_swap compilation ok${NOCOLOR}\n\n"
else
	printf "${RED}push_swap compilation ko${NOCOLOR}\nCheck if the variable ROOT in loop.sh is correct\n"
	exit 1
fi

declare -i total=0
declare -i count=0
declare -i max=0
declare -i min=1000000000

FLAG="${GREEN}OK${NOCOLOR}"
LEAKFLAG="${GREEN}NO LEAKS${NOCOLOR}"

for ((i=1;i<=$2;i++));
do
	printf "$i	"

	# Store moves in a temp variable, not saved to file
	MOVES=$($ROOT/push_swap $(cat ./trace_loop/test_case_$i.txt))
	echo "$MOVES" | head -c 1 >/dev/null # Ensure MOVES is read so $? is accurate

	# Timeout simulation
	(echo "$MOVES" > temp_output_$i.txt) & pid=$!
	(sleep $TIME_LIMIT && kill -HUP $pid) 2>/dev/null & watcher=$!
	if wait $pid 2>/dev/null; then
		TLEFLAG=0
	else
		TLEFLAG=1
	fi

	if [[ "$TLEFLAG" = "0" ]];
	then
		valgrind --leak-check=full --error-exitcode=1 --quiet --log-file=valgrind_out.txt $ROOT/push_swap $(cat ./trace_loop/test_case_$i.txt) > /dev/null
		if [[ $? -eq 0 ]]; then
			TEMPLEAK="${GREEN}NO LEAKS${NOCOLOR}"
		else
			TEMPLEAK="${RED}LEAKS${NOCOLOR}"
			LEAKFLAG="${RED}LEAKS${NOCOLOR}"
		fi
		printf "$TEMPLEAK	"
	else
		printf "		"
	fi

	printf "instructions amount : "
	count=$(echo "$MOVES" | wc -l)
	printf "$count "
	total=$((total + count))

	if [ $count -gt $max ]; then
		max=$count
		max_tag=$i
	fi
	if [ $count -lt $min ]; then
		min=$count
		min_tag=$i
	fi

	printf "	checker result : "
	if [[ "$TLEFLAG" = "1" ]]; then
		printf "${RED}TLE${NOCOLOR}\n"
		FLAG="${RED}KO${NOCOLOR}"
	else
		echo "$MOVES" | ./files/checker $(cat ./trace_loop/test_case_$i.txt) > temp_result
		temp=$(cat temp_result)
		if [[ "$temp" = "OK" ]]; then
			printf "${GREEN}OK${NOCOLOR}\n"
		else
			printf "${RED}KO${NOCOLOR}\n"
			FLAG="${RED}KO${NOCOLOR}"
		fi
	fi
done

rm -f temp_result valgrind_out.txt temp_output_*.txt

average=$((total / $2))
printf "\n"
printf "stack size 		$1\n"
printf "loop time		$2\n"
printf "test result		$FLAG\n"
printf "total instructions	$total\n"
printf "maximum instructions	$max (test case $max_tag)\n"
printf "minimum instructions	$min (test case $min_tag)\n"
printf "average instructions	$average\n"
printf "memory			$LEAKFLAG\n"
echo "Test cases are in trace_loop"
rm ./files/better_random_test_cases

