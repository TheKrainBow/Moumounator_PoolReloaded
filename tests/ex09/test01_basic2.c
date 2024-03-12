#define TESTED_STRING "Bien jouer, tu sais compter!"

#include <stdio.h>

void	ft_ft(int *nbr);

int main(void) {
	int		a = 28;

	ft_ft(&a);
	printf("A = %d expected 42\n", a);
	return (0);
}