#define MIN 0
#define MAX 10

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char	*ft_strchr(char *str, char c)
{
	while (str && *str)
	{
		if (*str == c)
			return (str);
		str++;
	}
	return (NULL);
}

int	ft_strlen(char *str)
{
	int	i;

	i = 0;
	while (str && str[i])
		i++;
	return (i);
}

char	*ft_strndup(char *str, int size)
{
	int		strlen;
	int		i;
	char	*dest;

	strlen = ft_strlen(str);
	if (strlen < size)
		size = strlen;
	dest = malloc(sizeof(char) * (size + 1));
	i = 0;
	while (str && i < size)
	{
		dest[i] = str[i];
		i++;
	}
	dest[i] = '\0';
	return (dest);
}

int	word_count(char *str, char *charset)
{
	int	word_count;

	if (!str || !str)
		return (0);
	word_count = 0;
	while (*str)
	{
		while (*str && ft_strchr(charset, *str))
			str++;
		if (!*str)
			break ;
		word_count++;
		while (*str && !ft_strchr(charset, *str))
			str++;
	}
	return (word_count);
}

char	**ft_split(char *str, char *charset)
{
	char	**dest;
	int		word;
	int		dest_size;
	char	*word_start;

	dest_size = word_count(str, charset) + 1;
	dest = malloc(sizeof(char *) * (dest_size));
	if (!dest)
		return (NULL);
	word = -1;
	if (!str)
		return (dest);
	while (*str)
	{
		while (*str && ft_strchr(charset, *str))
			str++;
		if (!*str)
			break ;
		word_start = str;
		while (*str && !ft_strchr(charset, *str))
			str++;
		dest[++word] = ft_strndup(word_start, str - word_start);
	}
	dest[dest_size - 1] = NULL;
	return (dest);
}

#include <string.h>

int	ft_count_if(char **tab, int (*f)(char*));

#define X 3

int		find_x_a(char *str)
{
	int	i;

	i = 0;
	while (*str)
	{
		if (*str == 'a')
			i++;
		str++;
	}
	return (i == X);
}

int main(void) {
	char	**strs = ft_split("aaa aa a aa aaa aa a aa aaa", " ");
	if (strs == NULL)
	{
		printf("ft_split returned NULL\n");
		return (0);
	}
	printf("ft_count_if found %d with exactly %d a\n", ft_count_if(strs, &find_x_a), X);

	for (int i = 0; strs[i]; i++)
		free(strs[i]);
	free(strs);
	return (0);
}