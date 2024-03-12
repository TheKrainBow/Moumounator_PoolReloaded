#define TESTED_STRING "Bien jouer, tu sais allouer!"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *ft_strdup(char *str);

int main(void) {
	char	*str = ft_strdup(TESTED_STRING);
	printf("ft_strdup(\"%s\") = %s\n", TESTED_STRING, str);
	free(str);
	return (0);
}