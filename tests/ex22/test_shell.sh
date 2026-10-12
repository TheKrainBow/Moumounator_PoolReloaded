source scripts/check.sh

test_begin $1 ft_abs.h 3

cat > "$WORK/main.c" << 'END'
#include <stdio.h>
#include "ft_abs.h"
#include "ft_abs.h"

int	main(void)
{
	int	x = -7;

	printf("%d %d %d\n", ABS(-42), ABS(42), ABS(0));
	printf("%d %d\n", ABS(x), ABS(-x));
	printf("%d %d\n", ABS(2 - 5), ABS(-2 - 3));
	printf("%d %d\n", ABS(-3) * 2, -ABS(-4));
	printf("%d\n", 10 - ABS(-3));
	printf("%d\n", ABS(x) + ABS(1 - 2));
	return (0);
}
END
printf "42 42 0\n7 7\n3 5\n6 -4\n7\n8\n" > "$OUTPUT_PATH/answer.txt"

compile ()
{
	cc -Wall -Wextra -Werror -I "$USER_DIR" "$WORK/main.c" -o "$WORK/a.out"
}
check "compiles (header included twice)" compile
check "values and operator precedence" run_program "$OUTPUT_PATH/answer.txt" "$WORK/a.out"
check "macro is named ABS" grep -q "define[[:space:]]*ABS(" "$USER_DIR/ft_abs.h"

test_end
