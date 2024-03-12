#include <stdio.h>

int	ft_iterative_factorial(int nb);

int main(void) {
	for (int i = -5; i < 8 ; i++) printf("ft_iterative_factorial(%d) = %d\n", i, ft_iterative_factorial(i));
	return (0);
}