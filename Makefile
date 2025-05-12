PREFIX = /usr/local


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

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f ${TARGET} ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/${TARGET}

clean:
	rm -f $(OBJS) $(TARGET)

.PHONY: all install clean
