HOSTTYPE    = $(shell "echo $HOSTTYPE")

ifeq ($(HOSTTYPE),)
	HOSTTYPE := $(shell uname -m)_$(shell uname -s)
endif

NAME        = libft_malloc_$(HOSTTYPE).so
CC          = clang
CFLAGS      = -Wall -Wextra -g -O0 -fPIC

SRCS_DIR    = ./src
OBJS_DIR    = ./obj
HEADERS_DIR = ./include
LIBFT_DIR   = ./libft

HEADERS     = ft_malloc.h
HEADERS    := $(addprefix $(HEADERS_DIR)/, $(HEADERS))

SRCS        = ft_malloc.c

OBJS        = $(SRCS:.c=.o)

INCLUDES    = -I include/
INCLUDES   += -I libft/include

LIBFT       = $(LIBFT_DIR)/libft.a

LIBRARIES   = -lm -lpthread
LIBRARIES  += -L libft/ -lft

LINK_FLAGS  = $(addprefix $(OBJS_DIR)/, $(OBJS)) $(LIBRARIES) -shared

VPATH       = $(SRCS_DIR) $(OBJS_DIR) $(SRCS_DIR)/opencl $(SRCS_DIR)/scene $(SRCS_DIR)/math
VPATH      += $(SRCS_DIR)/gui $(SRCS_DIR)/parsing $(SRCS_DIR)/icons $(SRCS_DIR)/events

all         : $(NAME)

$(NAME)     : $(LIBFT) $(OBJS_DIR) $(OBJS) $(HEADERS)
	@$(CC) $(CFLAGS) -o $(NAME) $(LINK_FLAGS)
	@printf "\e[38;5;46m./$(NAME)   SUCCESSFUL BUILD 🖥\e[0m\n"

$(LIBFT)    :
	@make -C $(LIBFT_DIR)

$(OBJS_DIR) :
	@mkdir $(OBJS_DIR)

$(OBJS)     : %.o : %.c $(HEADERS)
	@$(CC) $(CFLAGS) -c $< -o $(OBJS_DIR)/$@ $(INCLUDES)

clean       :
	@rm -rf $(OBJS_DIR)
	@make -C $(LIBFT_DIR) clean

fclean      : clean
	@rm -f $(NAME)
	@make -C $(LIBFT_DIR) fclean
	@printf "\e[38;5;226m./$(NAME)   DELETED\e[0m\n"

re          : fclean all

.PHONY: clean fclean re
