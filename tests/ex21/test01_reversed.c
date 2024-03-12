#define MIN 10
#define MAX 0

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int *ft_range(int min, int max);

int main(void) {
	int	*array = ft_range(MIN, MAX);
	if (array == NULL)
	{
		printf("ft_range returned NULL!\n");
		return (0);
	}
	for (int i = 0; i < abs(MAX - MIN); i++)
		printf("array[%d] = %d\n", i, array[i]);
	free(array);
	return (0);
}