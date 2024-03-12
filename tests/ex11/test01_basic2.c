#include <stdio.h>

void	ft_div_mod(int a, int b, int *div, int *mod);

int main(void) {
	int		a = 153;
	int		b = 10;
	int		div = 15;
	int		mod = 3;

	ft_div_mod(a, b, &div, &mod);
	printf("A   = %d expected 153\n", a);
	printf("B   = %d expected 10\n", b);
	printf("div = %d expected 15\n", a);
	printf("mod = %d expected 3\n", b);
	return (0);
}