SRCS 	=	srcs/display_file.c\

OBJS	=	$(SRCS:.c=.o)
COMPILE	= 	cc
RM		= 	rm -f
NAME	= 	ft_display_file
FLAGS	= 	-Wall -Wextra -Werror


$(NAME):		$(OBJS) 
			$(CC) -o $(NAME) $(OBJS) $(FLAGS)

.c.o:
			$(CC) $(FLAGS) -c $< -o $(<:.c=.o)

all:			$(NAME)

clean:
			$(RM) $(OBJS)

fclean:			clean
			$(RM) $(NAME)

.PHONY: 		all clean fclean
