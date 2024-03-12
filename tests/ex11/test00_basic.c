#include <stdio.h>

void	ft_div_mod(int a, int b, int *div, int *mod);

int main(void) {
	int		a = 12;
	int		b = 5;
	int		div = 2;
	int		mod = 2;

	ft_div_mod(a, b, &div, &mod);
	printf("A   = %d expected 12\n", a);
	printf("B   = %d expected 5\n", b);
	printf("div = %d expected 2\n", a);
	printf("mod = %d expected 2\n", b);
	return (0);
}