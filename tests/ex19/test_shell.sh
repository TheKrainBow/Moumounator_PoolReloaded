source scripts/check.sh

test_begin $1 ft_sort_params 7

compile ()
{
	cc -Wall -Wextra -Werror -fsanitize=address -g "$USER_DIR/ft_sort_params.c" scripts/ft_putchar.c -o "$WORK/a.out"
}
check "compiles with -Wall -Wextra -Werror (+ our ft_putchar.c)" compile

sorted ()
{
	if [ $# -eq 0 ]; then
		: > "$OUTPUT_PATH/answer.txt"
	else
		printf "%s\n" "$@" | LC_ALL=C sort > "$OUTPUT_PATH/answer.txt"
	fi
	run_program "$OUTPUT_PATH/answer.txt" "$WORK/a.out" "$@"
}
check "only allowed functions, ft_putchar only declared" allowed_functions "$USER_DIR/ft_sort_params.c"
check "already sorted" sorted a b c
check "reverse order" sorted test3 test2 test1
check "no argument" sorted
check "ascii order (case, digits, prefixes, duplicates)" sorted b B a A 10 9 abc ab abc "" "~" " "
check "many arguments" sorted $(seq 50 -1 1)

test_end
