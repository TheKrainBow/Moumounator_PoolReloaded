source scripts/check.sh

test_begin $1 ft_print_params 6

compile ()
{
	cc -Wall -Wextra -Werror -fsanitize=address -g "$USER_DIR/ft_print_params.c" scripts/ft_putchar.c -o "$WORK/a.out"
}
check "compiles with -Wall -Wextra -Werror (+ our ft_putchar.c)" compile

params ()
{
	if [ $# -eq 0 ]; then
		: > "$OUTPUT_PATH/answer.txt"
	else
		printf "%s\n" "$@" > "$OUTPUT_PATH/answer.txt"
	fi
	run_program "$OUTPUT_PATH/answer.txt" "$WORK/a.out" "$@"
}
check "only allowed functions, ft_putchar only declared" allowed_functions "$USER_DIR/ft_print_params.c"
check "subject example" params test1 test2 test3
check "no argument" params
check "single argument" params 42
check "spaces, empty string and special chars" params "hello world" "" "-n" "\\t%s"

test_end
