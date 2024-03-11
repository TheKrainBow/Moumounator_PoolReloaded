
RM_ON_SUCCESS=1

if [ -n "$(ls -A outputs/)" ]; then
	rm -rf outputs/*
fi
TOTAL_SUCCESS=0
TOTAL_TESTS=0

if [ -z "$1" ]; then
	echo "No exercice number specified. Starting all tests:"
	for DAY_NUMBER in $(find tests/ -mindepth 1 -type d | sed "s/.*\/ex//")
	do
		source scripts/start_day.sh $DAY_NUMBER
	done
else
	source scripts/start_day.sh $(printf '%02d\n' $(echo $1 | sed "s/ex//"))
fi

if [ $TOTAL_SUCCESS == $TOTAL_TESTS ]; then
	printf "\n\033[32;1;1m╭───────────────────────────────╮\n"
	printf "│\033[0m %02d/%02d tests                   \033[32;1;1m│\n" $TOTAL_SUCCESS $TOTAL_TESTS
	printf "│\033[0m Everything is good for me! :) \033[32;1;1m│\n"
	printf "╰───────────────────────────────╯\033[0m\n"
else
	printf "\n\033[31;1;1m╭───────────────────────────────╮\n"
	printf "│\033[0m %02d/%02d tests                   \033[31;1;1m│\n" $TOTAL_SUCCESS $TOTAL_TESTS
	printf "│\033[0m Check outputs for details :(  \033[31;1;1m│\n"
	printf "╰───────────────────────────────╯\033[0m\n"
fi