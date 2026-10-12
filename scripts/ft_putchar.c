#include <unistd.h>

/* Weak so a user file that defines its own ft_putchar still links */
__attribute__((weak)) void	ft_putchar(char c)
{
	write(1, &c, 1);
}
