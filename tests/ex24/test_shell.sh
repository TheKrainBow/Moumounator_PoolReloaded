source scripts/check.sh

test_begin $1 Makefile 9

# Fake libft: only the 5 mandatory functions, bodies don't matter here
mkdir -p "$WORK/srcs" "$WORK/includes"
printf "#ifndef FT_H\n# define FT_H\n\nvoid\tft_putchar(char c);\nvoid\tft_putstr(char *str);\nint\t\tft_strcmp(char *s1, char *s2);\nint\t\tft_strlen(char *str);\nvoid\tft_swap(int *a, int *b);\n\n#endif\n" > "$WORK/includes/ft.h"
printf '#include "ft.h"\nvoid ft_putchar(char c) { (void)c; }\n' > "$WORK/srcs/ft_putchar.c"
printf '#include "ft.h"\nvoid ft_putstr(char *str) { (void)str; }\n' > "$WORK/srcs/ft_putstr.c"
printf '#include "ft.h"\nint ft_strcmp(char *s1, char *s2) { (void)s1; (void)s2; return (0); }\n' > "$WORK/srcs/ft_strcmp.c"
printf '#include "ft.h"\nint ft_strlen(char *str) { (void)str; return (0); }\n' > "$WORK/srcs/ft_strlen.c"
printf '#include "ft.h"\nvoid ft_swap(int *a, int *b) { (void)a; (void)b; }\n' > "$WORK/srcs/ft_swap.c"
cp "$USER_DIR/Makefile" "$WORK/Makefile" 2> /dev/null
cd "$WORK"

no_objects ()
{
	[ -z "$(find . -name '*.o')" ]
}

lib_has_all ()
{
	[ -f libft.a ] || return 1
	ar t libft.a | sort > "$OUTPUT_PATH/user.txt"
	printf "ft_putchar.o\nft_putstr.o\nft_strcmp.o\nft_strlen.o\nft_swap.o\n" > "$OUTPUT_PATH/answer.txt"
	same_output "$OUTPUT_PATH/answer.txt" "$OUTPUT_PATH/user.txt"
}

make_all ()
{
	make all > /dev/null && lib_has_all
}

relink ()
{
	test -f libft.a || return 1
	touch "$OUTPUT_PATH/marker"
	sleep 1
	make > /dev/null 2>&1
	[ -z "$(find . -newer "$OUTPUT_PATH/marker" -type f)" ]
}

# make -n -B prints every compile command, even the silent (@) ones
flags ()
{
	make -n -B 2>&1 | grep -E "(^|[ /])(cc|gcc|clang) " > "$OUTPUT_PATH/compile_commands.txt"
	[ -s "$OUTPUT_PATH/compile_commands.txt" ] || return 1
	! grep -v -- "-Wall" "$OUTPUT_PATH/compile_commands.txt" | grep -q . &&
	! grep -v -- "-Wextra" "$OUTPUT_PATH/compile_commands.txt" | grep -q . &&
	! grep -v -- "-Werror" "$OUTPUT_PATH/compile_commands.txt" | grep -q .
}

no_wildcard ()
{
	test -f Makefile && ! grep -v "^#" Makefile | grep -qE "\*|wildcard"
}

check "Makefile exists" test -f Makefile
check "make (default rule) builds libft.a with the 5 functions" eval 'make > /dev/null && lib_has_all'
check "make all" make_all
check "no relink on second make" relink
check "make clean removes .o, keeps libft.a" eval 'make clean > /dev/null && no_objects && test -f libft.a'
check "make fclean removes libft.a" eval 'make fclean > /dev/null && no_objects && test ! -f libft.a'
check "make re rebuilds libft.a" eval 'make re > /dev/null && lib_has_all'
check "compiles with -Wall -Wextra -Werror" flags
check "no wildcard (sources listed explicitly)" no_wildcard

make fclean > /dev/null 2>&1
test_end
