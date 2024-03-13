DAY_NUMBER=$1
NUMBER_OF_TESTS=1

OUTPUT_PATH="outputs/ex$1"

source scripts/print.sh

print_exercice_name $1 find_sh.sh 1

if test -d "$OUTPUT_PATH"; then
	rm $OUTPUT_PATH
fi
mkdir "$OUTPUT_PATH"

for path in "${OUTPUT_PATH}/user" "${OUTPUT_PATH}/answer"; do
	mkdir $path
	touch $path/test1.sh $path/test2sh $path/test.ssh $path/test.shh $path/.sh $path/test3.sh.sh
	mkdir $path/subdir
	path=$path/subdir
	touch $path/test1.sh $path/test2sh $path/test.ssh $path/test.shh $path/.sh $path/test3.sh.sh
	mkdir $path/subdir
	path=$path/subdir
	touch $path/test1.sh $path/test2sh $path/test.ssh $path/test.shh $path/.sh $path/test3.sh.sh
done

cd ${OUTPUT_PATH}/answer
source ../../../tests/ex$1/find_sh.sh > ../answer.txt
cd ../user
source ../../../$PATH_TO_POOL/ex$1/find_sh.sh > ../user.txt 2> ../user_errors.txt
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