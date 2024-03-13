lines=$(find . -maxdepth 3 -wholename "./tests/ex$1/test_shell.sh" | wc -l)
if [ $lines -eq 1 ]; then
	source tests/ex$1/test_shell.sh
	return
fi
lines=$(find . -maxdepth 3 -wholename "./tests/ex$1/*.o" | wc -l)
if [ $lines -eq 1 ]; then
	source scripts/test_c_function.sh $1
	return
fi
printf "Testing ex$1                        : NA [ No tests turned in ]\n"