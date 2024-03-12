#define TESTED_STRING ""

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *ft_strdup(char *str);

int main(void) {
	char	*str = ft_strdup(TESTED_STRING);
	printf("ft_strdup(\"%s\") = %s\n", TESTED_STRING, str);
	printf("str[0] = %d\n", str[0]);
	free(str);
	return (0);
}