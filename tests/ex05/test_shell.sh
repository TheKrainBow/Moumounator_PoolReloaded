DAY_NUMBER=$1
NUMBER_OF_TESTS=1
NUMBER_OF_SUCCESS=0

OUTPUT_PATH="outputs/ex$1"

source scripts/print.sh

print_exercice_name $1 MaRViN 1

if test -d "$OUTPUT_PATH"; then
	rm -rf "$OUTPUT_PATH"
fi
mkdir "$OUTPUT_PATH"

FILE_NAME="\"\\?\$*'MaRViN'*\$?\\\""
USER_FILE="$PATH_TO_POOL/ex$1/$FILE_NAME"

printf "42" > "$OUTPUT_PATH/answer.txt"
if test -f "$USER_FILE"; then
	cat "$USER_FILE" > "$OUTPUT_PATH/user.txt"
else
	printf "file %s not found in ex%s/\n" "$FILE_NAME" "$1" > "$OUTPUT_PATH/user_errors.txt"
	ls -a "$PATH_TO_POOL/ex$1" >> "$OUTPUT_PATH/user_errors.txt" 2>&1
	touch "$OUTPUT_PATH/user.txt"
fi
cmp -s "$OUTPUT_PATH/answer.txt" "$OUTPUT_PATH/user.txt"
if [ $? -ne 0 ] || [ -s "$OUTPUT_PATH/user_errors.txt" ]; then
	printf "\033[31;1;1m✗ \033[0m"
else
	printf "\033[32;1;1m✓ \033[0m"
	NUMBER_OF_SUCCESS=1
	if [ $RM_ON_SUCCESS -ne 0 ]; then
		rm -rf $OUTPUT_PATH
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
