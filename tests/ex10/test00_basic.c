#include <stdio.h>

void	ft_swap(int *a, int *b);

int main(void) {
	int		a = 24;
	int		b = 42;

	ft_swap(&a, &b);
	printf("A = %d expected 42\n", a);
	printf("B = %d expected 24\n", b);
	return (0);
}