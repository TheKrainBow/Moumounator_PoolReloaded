DAY_NUMBER=$1
NUMBER_OF_TESTS=1
NUMBER_OF_SUCCESS=0

OUTPUT_PATH="outputs/ex02"

source scripts/print.sh

print_exercice_name clean.sh 1

if test -d "$OUTPUT_PATH"; then
	rm $OUTPUT_PATH
fi
mkdir "$OUTPUT_PATH"

for path in "${OUTPUT_PATH}/user" "${OUTPUT_PATH}/answer"; do
	mkdir $path
	touch $path/test1 $path/test2# $path/#test3# $path/#tes#4 $path/t#es5# $path/#test6~ $path/~test7#
	mkdir $path/subdir
	path=$path/subdir
	touch $path/test1 $path/test2# $path/#test3# $path/#tes#4 $path/t#es5# $path/#test6~ $path/~test7#
	mkdir $path/subdir
	path=$path/subdir
	touch $path/test1 $path/test2# $path/#test3# $path/#tes#4 $path/t#es5# $path/#test6~ $path/~test7#
done

cd ${OUTPUT_PATH}/answer
source ../../../tests/ex02/clean
find . > ../answer.txt
cd ../user
source ../../../$PATH_TO_POOL/ex02/clean 2> ../user_errors.txt
find . > ../user.txt
cd ../
diff answer.txt user.txt > /dev/null
if [ $? -eq 1 ] || [ -s "user_errors.txt" ]; then
	printf "\033[31;1;1m✗ \033[0m"
else
	printf "\033[32;1;1m✓ \033[0m"
	cd ../..
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