/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strcmp.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: maagosti <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/02/20 20:45:27 by maagosti          #+#    #+#             */
/*   Updated: 2024/02/21 21:42:47 by maagosti         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

int	ft_strcmp(char *s1, char *s2)
{
	int	i;

	i = 0;
	while (s1[i] == s2[i] && s1[i])
		i++;
	return (s1[i] - s2[i]);
}

/*
#include <string.h>
#include <stdio.h>
#define TESTING(s1, s2) \
printf("   strcmp(%s, %s) = %d\nft_strcmp(%s, %s) = %d\n",\
s1, s2, strcmp(s1, s2), s1, s2, ft_strcmp(s1, s2));
int	main(void) {
	TESTING("test", "toto")
	TESTING("", "toto")
	TESTING("test", "")

	TESTING("test", "test")
	TESTING("", "")
}
*/
