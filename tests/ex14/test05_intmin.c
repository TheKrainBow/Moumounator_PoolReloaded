#include <stdio.h>
#include <limits.h>

int	ft_sqrt(int nb);

int main(void) {
	printf("ft_sqrt(%d) = %d\n", INT_MIN, ft_sqrt(INT_MIN));
	return (0);
}