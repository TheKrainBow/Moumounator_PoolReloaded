# check_allowed_functions <source.c> [allowed functions...]
# Fails (and says why on stdout) if the file calls a function the subject
# doesn't allow, or defines ft_putchar when ft_putchar is an allowed function:
# the moulinette compiles with its own ft_putchar.c, so it must only be declared.
check_allowed_functions ()
{
	local SRC="$1" OBJ FORBIDDEN DEFINED
	shift
	OBJ=$(mktemp --suffix=.o)
	if ! cc -c "$SRC" -o "$OBJ" 2> /dev/null; then
		rm -f "$OBJ"
		echo "$SRC does not compile"
		return 1
	fi
	FORBIDDEN=$(nm -u "$OBJ" | awk '{print $2}' | grep -vxE "__stack_chk_fail|_GLOBAL_OFFSET_TABLE_" | grep -vxF -f <(printf "%s\n" "$@"))
	DEFINED=""
	if printf "%s\n" "$@" | grep -qx ft_putchar; then
		DEFINED=$(nm --defined-only "$OBJ" | awk '$3 == "ft_putchar"')
	fi
	rm -f "$OBJ"
	if [ -n "$FORBIDDEN" ]; then
		echo "forbidden functions: $(echo $FORBIDDEN) (allowed: ${*:-none})"
	fi
	if [ -n "$DEFINED" ]; then
		echo "ft_putchar is defined in your file: only declare it (void ft_putchar(char c);), the moulinette compiles with its own ft_putchar.c"
	fi
	[ -z "$FORBIDDEN$DEFINED" ]
}
