DAY_NUMBER=$1
NUMBER_OF_TESTS=1

OUTPUT_PATH="outputs/ex04"

source scripts/print.sh

print_exercice_name MAC.sh 1

if test -d "$OUTPUT_PATH"; then
	rm $OUTPUT_PATH
fi
mkdir "$OUTPUT_PATH"

source tests/ex04/MAC.sh > $OUTPUT_PATH/answer.txt
source $PATH_TO_POOL/ex04/MAC.sh > $OUTPUT_PATH/user.txt 2> $OUTPUT_PATH/user_errors.txt
diff $OUTPUT_PATH/answer.txt $OUTPUT_PATH/user.txt > /dev/null
if [ $? -eq 1 ] || [ -s "user_errors.txt" ]; then
	printf "\033[31;1;1m✗ \033[0m"
else
	printf "\033[32;1;1m✓ \033[0m"
	NUMBER_OF_SUCCESS=1
	if [ $RM_ON_SUCCESS -ne 0 ]; then
		rm -r $OUTPUT_PATH
	fi
fi

if [ $NUMBER_OF_SUCCESS == $NUMBER_OF_TESTS ]; then
	print_result 1 1 1
else
	print_result 1 1 0
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