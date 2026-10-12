source scripts/check.sh

test_begin $1 ft_point.h 2

cat > "$WORK/main.c" << 'END'
#include "ft_point.h"
#include "ft_point.h"

void	set_point(t_point *point)
{
	point->x = 42;
	point->y = 21;
}

int	main(void)
{
	t_point	point;

	set_point(&point);
	return (0);
}
END
check "subject main compiles (header included twice)" cc -Wall -Wextra -Werror -I "$USER_DIR" "$WORK/main.c" -o "$WORK/a.out"

cat > "$WORK/main2.c" << 'END'
#include <stdio.h>
#include "ft_point.h"

int	main(void)
{
	t_point	point;

	point.x = -2147483648;
	point.y = 2147483647;
	printf("%d %d\n", point.x, point.y);
	return (0);
}
END
printf "%s\n" "-2147483648 2147483647" > "$OUTPUT_PATH/answer.txt"
fields_are_int ()
{
	cc -Wall -Wextra -Werror -I "$USER_DIR" "$WORK/main2.c" -o "$WORK/b.out" && run_program "$OUTPUT_PATH/answer.txt" "$WORK/b.out"
}
check "x and y are ints" fields_are_int

test_end
