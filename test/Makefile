.SUFFIXES:
.PRECIOUS: %.o %.s

SOURCES=$(wildcard *.c) $(wildcard *.cpp) $(wildcard *asm.s)
ASSEMBLER=$(patsubst %.c,%.s,$(patsubst %.cpp,%.s,$(wildcard *.c) $(wildcard *.cpp)))
OBJECTS=$(patsubst %.s,%.o,$(patsubst %.c,%.o,$(patsubst %.cpp,%.o,$(SOURCES))))
BINARIES=$(patsubst %.o,%,$(OBJECTS))
TESTS=$(wildcard *asm.sh)
TXT=$(patsubst %.sh,%.txt,$(TESTS))

.PHONY: all
all:	$(BINARIES) $(TXT)

%.s : %.c
	$(CC) $(<) -S -o $(@)

%.s : %.cpp
	$(CXX) $(<) -S -o $(@)

%.o : %.s
	$(AS) -mpwr4 $(<) -o $(@)

% : %.o %.s
	$(CXX) -L$(LIBPATH) -lstdc++ -lgcc_s -Wl,-blibpath -Wl,/usr/lib:/opt/freeware/lib/pthread $(<) -o $(@)

%.txt : %.sh %.o
	./$(<)

.PHONY: clean
clean:
	rm -f $(TARGETS) $(OBJECTS) $(BINARIES) $(ASSEMBLER) $(TXT)
