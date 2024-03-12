#include <stdio.h>
#include <limits.h>

int	ft_sqrt(int nb);

int main(void) {
	printf("ft_sqrt(%d) = %d\n", INT_MAX, ft_sqrt(INT_MAX));
	return (0);
}