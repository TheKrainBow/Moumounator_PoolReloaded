#include <stdio.h>

void	ft_swap(int *a, int *b);

int main(void) {
	int		a = 23;
	int		b = 41;

	ft_swap(&a, &b);
	printf("A = %d expected 41\n", a);
	printf("B = %d expected 23\n", b);
	return (0);
}