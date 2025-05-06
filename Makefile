CC = 
LIBS = 
INCLUDES = 
LDFLAGS = 

CFLAGS = -W -Wall -Wextra -O2 -g

SRCS = 
OBJS = $(SRCS:.c=.o)

TARGET = 

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f $(OBJS) $(TARGET)

.PHONY: all clean
