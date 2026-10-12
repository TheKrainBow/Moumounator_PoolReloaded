# Helpers for multi-check tests.
# Usage: test_begin <ex number> <title> <number of checks>
#        check <description> <command...>   (✓ if the command succeeds)
#        test_end
# Failed checks are described in outputs/exNN/report.txt

source scripts/print.sh
source scripts/allowed.sh

test_begin ()
{
	DAY_NUMBER=$1
	NUMBER_OF_TESTS=$3
	NUMBER_OF_SUCCESS=0
	OUTPUT_PATH="outputs/ex$1"
	USER_DIR="$(cd "$PATH_TO_POOL" && pwd)/ex$1"
	ROOT_DIR="$(pwd)"
	print_exercice_name $1 "$2" $3
	rm -rf "$OUTPUT_PATH"
	mkdir -p "$OUTPUT_PATH/work"
	OUTPUT_PATH="$ROOT_DIR/$OUTPUT_PATH"
	WORK="$OUTPUT_PATH/work"
	REPORT="$OUTPUT_PATH/report.txt"
}

check ()
{
	local DESC="$1"
	shift
	if "$@" >> "$OUTPUT_PATH/check.log" 2>&1; then
		printf "\033[32;1;1m✓ \033[0m"
		NUMBER_OF_SUCCESS=$(($NUMBER_OF_SUCCESS + 1))
	else
		printf "\033[31;1;1m✗ \033[0m"
		printf "KO: %s\n" "$DESC" >> "$REPORT"
	fi
}

# same_output <expected file> <actual file>: diff saved in report on failure
same_output ()
{
	if cmp -s "$1" "$2"; then
		return 0
	fi
	printf "%s\n" "--- expected (cat -e) ---" >> "$REPORT"
	cat -e "$1" | head -20 >> "$REPORT"
	printf "%s\n" "--- got (cat -e) ---" >> "$REPORT"
	cat -e "$2" | head -20 >> "$REPORT"
	return 1
}

test_end ()
{
	cd "$ROOT_DIR"
	print_result $NUMBER_OF_TESTS
	if [ $NUMBER_OF_SUCCESS -eq $NUMBER_OF_TESTS ] && [ $RM_ON_SUCCESS -ne 0 ]; then
		rm -rf "$OUTPUT_PATH"
	fi
	TOTAL_SUCCESS=$((${TOTAL_SUCCESS:-0} + $NUMBER_OF_SUCCESS))
	TOTAL_TESTS=$((${TOTAL_TESTS:-0} + $NUMBER_OF_TESTS))
}

# run_program <expected file> <binary> <args...>: compares stdout, stderr must be empty
run_program ()
{
	local EXPECTED="$1" BIN="$2"
	shift 2
	[ -x "$BIN" ] || return 1
	"$BIN" "$@" > "$OUTPUT_PATH/user.txt" 2> "$OUTPUT_PATH/user_errors.txt"
	if ! same_output "$EXPECTED" "$OUTPUT_PATH/user.txt"; then
		printf "args:" >> "$REPORT"; printf " [%s]" "$@" >> "$REPORT"; echo >> "$REPORT"
		return 1
	fi
	if [ -s "$OUTPUT_PATH/user_errors.txt" ]; then
		cat "$OUTPUT_PATH/user_errors.txt" >> "$REPORT"
		return 1
	fi
}

# allowed_functions <source.c>: uses tests/exNN/allowed_functions
allowed_functions ()
{
	check_allowed_functions "$1" $(cat "$ROOT_DIR/tests/ex$DAY_NUMBER/allowed_functions") >> "$REPORT"
}
