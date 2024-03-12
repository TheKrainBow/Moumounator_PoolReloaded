#include <stdio.h>

int	ft_recursive_factorial(int nb);

int main(void) {
	for (int i = -5; i < 8 ; i++) printf("ft_recursive_factorial(%d) = %d\n", i, ft_recursive_factorial(i));
	return (0);
}