.SUFFIXES:
.PRECIOUS: %.o %.s

SOURCES=$(wildcard *.c) $(wildcard *.cpp)
OBJECTS=$(patsubst %.c,%,$(patsubst %.cpp,%,$(SOURCES)))

.PHONY: all
all:	$(OBJECTS)

%.s : %.c
	$(CC) $(<) -S -o $(@)

%.s : %.cpp
	$(CXX) $(<) -S -o $(@)

%.o : %.s
	$(AS) $(<) -o $(@)

% : %.o %.c
	$(CC) -L$(LIBPATH) -lgcc_s -Wl,-blibpath -Wl,/usr/lib:/opt/freeware/lib/pthread $(<) -o $(@)

% : %.o %.cpp
	$(CXX) -L$(LIBPATH) -lgcc_s -Wl,-blibpath -Wl,/usr/lib:/opt/freeware/lib/pthread $(<) -o $(@)

.PHONY: clean
clean:
	rm -f *.o *.s $(TARGETS) $(OBJECTS)
