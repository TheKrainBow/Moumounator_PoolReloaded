DAY_NUMBER=$1

source scripts/print.sh
source scripts/allowed.sh

if ! test -d "tests/ex$DAY_NUMBER"; then
	printf "No tests for ex$DAY_NUMBER\n"
	return
fi

if ! test -d "outputs/ex$DAY_NUMBER/"; then
	mkdir "outputs/ex$DAY_NUMBER/"
fi

FILE_NAME=$(find tests/ex$DAY_NUMBER/ -mindepth 1 -maxdepth 1 -type f -name "*.o" | sed "s/.*\///" | sed "s/\.o/.c/")
EXERCICE_TITLE=$(echo $FILE_NAME | sed "s/\.c//")
TEST_LIST=$(find tests/ex$DAY_NUMBER/ -mindepth 1 -maxdepth 1 -type f -name "*.c" | sed "s/.*\/test//" | sed "s/_.*//" | sort)
NUMBER_OF_CHECKS=$(find tests/ex$DAY_NUMBER/ -mindepth 1 -type f -name "*.c" | sed "s/.*\/test//" | sed "s/_.*//" | wc -l)
if test -f tests/ex$DAY_NUMBER/allowed_functions; then
	NUMBER_OF_CHECKS=$(($NUMBER_OF_CHECKS + 1))
fi
print_exercice_name $DAY_NUMBER $EXERCICE_TITLE $NUMBER_OF_CHECKS

NUMBER_OF_SUCCESS=0
NUMBER_OF_TESTS=0

if test -f tests/ex$DAY_NUMBER/allowed_functions; then
	NUMBER_OF_TESTS=1
	if check_allowed_functions $PATH_TO_POOL/ex$DAY_NUMBER/$FILE_NAME $(cat tests/ex$DAY_NUMBER/allowed_functions) > outputs/ex$DAY_NUMBER/allowed_functions.txt; then
		printf "\033[32;1;1m✓ \033[0m"
		NUMBER_OF_SUCCESS=1
		rm outputs/ex$DAY_NUMBER/allowed_functions.txt
	else
		printf "\033[31;1;1m✗ \033[0m"
	fi
fi

for TEST_NUMBER in $TEST_LIST
do
	OUTPUT_PATH="outputs/ex$DAY_NUMBER/test${TEST_NUMBER}"
	if ! test -d $OUTPUT_PATH; then
		mkdir $OUTPUT_PATH
	fi
	cc -Wall -Wextra -Werror -fsanitize=address -g ./tests/ex$DAY_NUMBER/*.o ./tests/ex$DAY_NUMBER/test${TEST_NUMBER}_*.c -lm -o $OUTPUT_PATH/answer.ex$DAY_NUMBER.test${TEST_NUMBER}.out
	if [ $? -ne 0 ]; then
		continue
	fi
	cc -Wall -Wextra -Werror -fsanitize=address -g $PATH_TO_POOL/ex$DAY_NUMBER/$FILE_NAME ./scripts/ft_putchar.c ./tests/ex$DAY_NUMBER/test${TEST_NUMBER}_*.c -o $OUTPUT_PATH/user.ex$DAY_NUMBER.test${TEST_NUMBER}.out 2> $OUTPUT_PATH/user.compilation_error.out
	if [ $? -ne 0 ]; then
		printf "\033[31;1;1m✗ \033[0m"
		rm ./$OUTPUT_PATH/answer.ex$DAY_NUMBER.test${TEST_NUMBER}.out
		cp ./tests/ex$DAY_NUMBER/test${TEST_NUMBER}_*.c $OUTPUT_PATH/main.c
		NUMBER_OF_TESTS=$(($NUMBER_OF_TESTS + 1))
		continue
	else
		rm $OUTPUT_PATH/user.compilation_error.out
	fi
	./$OUTPUT_PATH/answer.ex$DAY_NUMBER.test${TEST_NUMBER}.out > $OUTPUT_PATH/answer.txt
	timeout 3 ./$OUTPUT_PATH/user.ex$DAY_NUMBER.test${TEST_NUMBER}.out > $OUTPUT_PATH/user.txt 2> $OUTPUT_PATH/user_errors.txt
	if [ $? -eq 124 ]; then
		printf "Timed out after 3 secondes!" > $OUTPUT_PATH/user_errors.txt
	fi
	rm ./$OUTPUT_PATH/answer.ex$DAY_NUMBER.test${TEST_NUMBER}.out ./$OUTPUT_PATH/user.ex$DAY_NUMBER.test${TEST_NUMBER}.out
	diff $OUTPUT_PATH/answer.txt $OUTPUT_PATH/user.txt > /dev/null
	if [ $? -eq 1 ] || [ -s "$OUTPUT_PATH/user_errors.txt" ]; then
		printf "\033[31;1;1m✗ \033[0m"
		cp ./tests/ex$DAY_NUMBER/test${TEST_NUMBER}_*.c $OUTPUT_PATH/main.c
	else
		printf "\033[32;1;1m✓ \033[0m"
		NUMBER_OF_SUCCESS=$(($NUMBER_OF_SUCCESS + 1))
		if [ $RM_ON_SUCCESS -ne 0 ]; then
			rm -r $OUTPUT_PATH
		fi
	fi
	NUMBER_OF_TESTS=$(($NUMBER_OF_TESTS + 1))
done
print_result $NUMBER_OF_CHECKS

if [ -z "$(ls -A outputs/ex$DAY_NUMBER/)" ]; then
	rm -rf outputs/ex$DAY_NUMBER/
fi

if [ -z "$TOTAL_SUCCESS" ]; then
	TOTAL_SUCCESS=$NUMBER_OF_SUCCESS
else
	TOTAL_SUCCESS=$(($TOTAL_SUCCESS + $NUMBER_OF_SUCCESS))
fi

if [ -z "$TOTAL_TESTS" ]; then
	TOTAL_TESTS=$NUMBER_OF_TESTS
else
	TOTAL_TESTS=$(($TOTAL_TESTS + $NUMBER_OF_TESTS))
fi