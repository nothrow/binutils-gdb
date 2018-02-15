.SUFFIXES:
.PRECIOUS: %.o %.s

SOURCES=$(wildcard *.c) $(wildcard *.cpp) $(wildcard *asm.s)
ASSEMBLER=$(patsubst %.c,%.s,$(patsubst %.cpp,%.s,$(wildcard *.c) $(wildcard *.cpp)))
OBJECTS=$(patsubst %.s,%.o,$(patsubst %.c,%.o,$(patsubst %.cpp,%.o,$(SOURCES))))
BINARIES=$(patsubst %.o,%,$(OBJECTS))

.PHONY: all
all:	$(BINARIES)

%.s : %.c
	$(CC) $(<) -S -o $(@)

%.s : %.cpp
	$(CXX) $(<) -S -o $(@)

%.o : %.s
	$(AS) $(<) -o $(@)

% : %.o %.s
	$(CXX) -L$(LIBPATH) -lstdc++ -lgcc_s -Wl,-v -Wl,-blibpath -Wl,/usr/lib:/opt/freeware/lib/pthread $(<) -o $(@)

.PHONY: clean
clean:
	rm -f $(TARGETS) $(OBJECTS) $(BINARIES) $(ASSEMBLER)
