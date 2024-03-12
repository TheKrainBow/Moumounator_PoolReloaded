#include <stdio.h>

int	ft_sqrt(int nb);

int main(void) {
	for (int i = 0; i <= 200 ; i++) printf("ft_sqrt(%d) = %d\n", i, ft_sqrt(i));
	return (0);
}