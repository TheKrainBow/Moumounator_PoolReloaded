/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_range.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: maagosti <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/02/26 18:37:24 by maagosti          #+#    #+#             */
/*   Updated: 2024/02/26 18:37:28 by maagosti         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <stdio.h>

int	*ft_range(int min, int max)
{
	int	*dest;
	int	i;

	if (min >= max)
		return (NULL);
	dest = malloc(sizeof(int) * (max - min));
	if (!dest)
		return (NULL);
	i = 0;
	while (min + i < max)
	{
		dest[i] = min + i;
		i++;
	}
	return (dest);
}
