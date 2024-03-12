#define MIN 0
#define MAX 10

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

void	ft_foreach(int *tab, int length, void (*f)(int));

void ft_putchar(int c)
{
	write(1, &c, 1);
}

int	*ft_range(int min, int max)
{
	int	*dest;
	int	i;

	if (min >= max)
		return (NULL);
	dest = malloc(sizeof(int) * (max - min));
	if (!dest)
		return (NULL);
	i = 0;
	while (min + i < max)
	{
		dest[i] = min + i;
		i++;
	}
	return (dest);
}

int main(void) {
	int	*array = ft_range(MIN, MAX);
	if (array == NULL)
	{
		printf("ft_range returned NULL\n");
		return (0);
	}
	ft_foreach(array, MAX - MIN, &ft_putchar);
	free(array);
	return (0);
}