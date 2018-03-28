.SUFFIXES:
.PRECIOUS: %.o %.s

SOURCES=$(wildcard *.c) $(wildcard *.cpp) $(wildcard *asm.s)
ASSEMBLER=$(patsubst %.c,%.s,$(patsubst %.cpp,%.s,$(wildcard *.c) $(wildcard *.cpp)))
OBJECTS=$(patsubst %.s,%.o,$(patsubst %.c,%.o,$(patsubst %.cpp,%.o,$(SOURCES))))
BINARIES=$(patsubst %.o,%,$(OBJECTS))
RESULTS=$(patsubst %.o,%.txt,$(OBJECTS))
IP=10.10.14.1
USER=guest

.PHONY: all
all:	$(BINARIES) $(RESULTS)

%.s : %.c
	$(CC) $(CFLAGS) $(<) -S -o $(@)

%.s : %.cpp
	$(CXX) $(CXXFLAGS) $(<) -S -o $(@)

%.o : %.s
	$(AS) -mpwr4 $(<) -o $(@)

% : %.o %.s
	$(CXX) $(CXXFLAGS) --save-temps $(LIBPATH) -lstdc++ -lgcc_s -Wl,-blibpath -Wl,/usr/lib:/opt/freeware/lib/pthread $(<) -o $(@)

%.txt: %
	scp $(<) $(USER)@$(IP):/tmp/
	ssh $(USER)@$(IP) /tmp/$(<) > $(@)

.PHONY: clean
clean:
	rm -f $(TARGETS) $(OBJECTS) $(BINARIES) $(ASSEMBLER) $(RESULTS)
