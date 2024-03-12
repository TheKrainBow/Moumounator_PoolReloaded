SRCS 	=	srcs/ft_putchar.c\
		srcs/ft_swap.c\
		srcs/ft_putstr.c\
		srcs/ft_strlen.c\
		srcs/ft_strcmp.c\

OBJS	=	$(SRCS:.c=.o)
COMPILE	= 	gcc
REMOVE	= 	rm -f
NAME	= 	libft.a
FLAGS	= 	-Wall -Wextra -Werror -Iincludes

.c.o:
			$(CC) $(FLAGS) -c $< -o $(<:.c=.o)

$(NAME):		$(OBJS) 
			ar rcs $(NAME) $(OBJS)

all:			$(NAME)

clean:
			$(RM) $(OBJS)

fclean:			clean
			$(RM) $(NAME)

re:				fclean all

.PHONY: 		all clean fclean re
