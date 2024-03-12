#define MIN 0
#define MAX 1000

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

void	ft_foreach(int *tab, int length, void (*f)(int));

void ft_putchar(char c)
{
	write(1, &c, 1);
}

void ft_putnbr(int nb)
{
	nb *= 2;
	if (nb >= 10)
		ft_putnbr(nb / 10);
	ft_putchar(nb % 10 + '0');
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
	ft_foreach(array, MAX - MIN, &ft_putnbr);
	free(array);
	return (0);
}