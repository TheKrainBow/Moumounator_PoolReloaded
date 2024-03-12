#define TESTED_STRING_A ""
#define TESTED_STRING_B "012345"

#include <stdio.h>

int ft_strcmp(char *s1,  char *s2);

int main(void) {
	int		diff = ft_strcmp(TESTED_STRING_A, TESTED_STRING_B);
	if (diff < 0)
		printf("ft_strcmp(\"%s\", \"%s\") returned negative value\n", TESTED_STRING_A, TESTED_STRING_B);
	else if (diff > 0)
		printf("ft_strcmp(\"%s\", \"%s\") returned positive value\n", TESTED_STRING_A, TESTED_STRING_B);
	else
		printf("ft_strcmp(\"%s\", \"%s\") returned 0\n", TESTED_STRING_A, TESTED_STRING_B);
	return (0);
}