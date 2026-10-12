source scripts/check.sh

test_begin $1 display_file 11

cp -r "$USER_DIR/." "$WORK/" 2> /dev/null
cd "$WORK"
BIN="$WORK/ft_display_file"

# expect_error <message> <args...>: message on stderr, nothing on stdout
expect_error ()
{
	local MESSAGE="$1"
	shift
	[ -x "$BIN" ] || return 1
	"$BIN" "$@" > "$OUTPUT_PATH/user.txt" 2> "$OUTPUT_PATH/user_errors.txt"
	printf "%s\n" "$MESSAGE" > "$OUTPUT_PATH/answer_errors.txt"
	: > "$OUTPUT_PATH/answer.txt"
	same_output "$OUTPUT_PATH/answer_errors.txt" "$OUTPUT_PATH/user_errors.txt" &&
		same_output "$OUTPUT_PATH/answer.txt" "$OUTPUT_PATH/user.txt"
}

# display <file>: output must be exactly the file content
display ()
{
	run_program "$1" "$BIN" "$1"
}

# Only close, open, read, write (+ what the libc start code needs)
allowed_functions ()
{
	[ -x "$BIN" ] || return 1
	nm -u "$BIN" | awk '{print $2}' | sed 's/@.*//' \
		| grep -vxE "open|read|write|close|__libc_start_main|__cxa_finalize|__stack_chk_fail|__gmon_start__|_ITM_.*" \
		> "$OUTPUT_PATH/forbidden.txt"
	if [ -s "$OUTPUT_PATH/forbidden.txt" ]; then
		printf "forbidden functions: %s\n" "$(tr '\n' ' ' < "$OUTPUT_PATH/forbidden.txt")" >> "$REPORT"
		return 1
	fi
}

printf "Hello, world!\nSecond line\n" > "$OUTPUT_PATH/small.txt"
: > "$OUTPUT_PATH/empty.txt"
printf "no newline at the end" > "$OUTPUT_PATH/no_nl.txt"
seq 1 50000 > "$OUTPUT_PATH/big.txt"
head -c 20000 /dev/urandom > "$OUTPUT_PATH/binary.bin"

check "make builds ft_display_file" eval 'make > /dev/null && test -x ft_display_file'
check "only open/read/write/close used" allowed_functions
check "small file" display "$OUTPUT_PATH/small.txt"
check "empty file" display "$OUTPUT_PATH/empty.txt"
check "file without trailing newline" display "$OUTPUT_PATH/no_nl.txt"
check "big file (bigger than any buffer)" display "$OUTPUT_PATH/big.txt"
check "binary file (with \\0 bytes)" display "$OUTPUT_PATH/binary.bin"
check "no argument -> File name missing." expect_error "File name missing."
check "2 arguments -> Too many arguments." expect_error "Too many arguments." "$OUTPUT_PATH/small.txt" "$OUTPUT_PATH/small.txt"
check "missing file -> Cannot read file." expect_error "Cannot read file." "$OUTPUT_PATH/does_not_exist"
check "make clean / fclean" eval 'make clean > /dev/null && [ -z "$(find . -name "*.o")" ] && make fclean > /dev/null && test ! -e ft_display_file'

test_end
