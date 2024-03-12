/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   display_file.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: maagosti <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/02/29 14:14:07 by maagosti          #+#    #+#             */
/*   Updated: 2024/02/29 14:31:56 by maagosti         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>

int	ft_putstr(int fd, char *str)
{
	int	i;

	i = -1;
	while (str[++i])
		write(fd, str + i, 1);
	return (1);
}

int	main(int ac, char **av)
{
	char	buffer[11];
	int		read_return;
	int		fd;

	if (ac == 1)
		return (ft_putstr(2, "File name missing.\n"));
	if (ac > 2)
		return (ft_putstr(2, "Too many arguments.\n"));
	fd = open(av[1], O_RDONLY);
	if (fd == -1)
		return (ft_putstr(2, "Cannot read file.\n"));
	read_return = 1;
	while (read_return)
	{
		read_return = read(fd, buffer, 10);
		buffer[read_return] = 0;
		ft_putstr(1, buffer);
	}
	close(fd);
}
