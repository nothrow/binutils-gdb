.SUFFIXES:
.PRECIOUS: %.o %.s

SOURCES=$(wildcard *.c) $(wildcard *.cpp) $(wildcard *asm.s) $(wildcard *.cc)
ASSEMBLER=$(patsubst %.cc,%.s,$(patsubst %.c,%.s,$(patsubst %.cpp,%.s,$(wildcard *.c) $(wildcard *.cpp) $(wildcard *.cc))))
OBJECTS=$(patsubst %.s,%.o,$(patsubst %.c,%.o,$(patsubst %.cpp,%.o,$(filter-out %.cc,$(SOURCES)))))
SOBJECTS=$(patsubst %.cc,%.o,$(filter %.cc,$(SOURCES)))
BINARIES=$(patsubst %.s,%,$(patsubst %.c,%,$(patsubst %.cpp,%,$(filter-out %.cc,$(SOURCES)))))
RESULTS=$(patsubst %,%.txt,$(BINARIES))
IP=10.10.14.1
USER=guest

.PHONY: all
all:	$(BINARIES) $(RESULTS) $(SOBJECTS)

%.s : %.c
	$(CC) $(CFLAGS) -I.. $(<) -S -o $(@)

%.s : %.cpp
	$(CXX) $(CXXFLAGS) -I.. $(<) -S -o $(@)

%.s : %.cc
	$(CXX) $(CXXFLAGS) -I.. $(<) -S -o $(@)

%.o : %.s
	$(AS) -mpwr4 $(<) -o $(@)

liba.a : $(SOBJECTS)
	$(AR) qc $(@) $(^)
	$(RANLIB) $(@)

% : %.o liba.a %.s %.c
	$(CC) $(CFLAGS) --save-temps $(LIBPATH) -Wl,-blibpath -Wl,/usr/lib:/opt/freeware/lib/pthread $(<) -o $(@) -L. -la

% : %.o liba.a %.s %.cpp
	$(CXX) $(CXXFLAGS) --save-temps $(LIBPATH) -lstdc++ -lgcc_s -Wl,-blibpath -Wl,/usr/lib:/opt/freeware/lib/pthread $(<) -o $(@) -L. -la

%.txt: %
	scp $(<) $(USER)@$(IP):/tmp/
	ssh $(USER)@$(IP) /tmp/$(<) > $(@)

.PHONY: clean
clean:
	rm -f $(TARGETS) $(OBJECTS) $(BINARIES) $(ASSEMBLER) $(RESULTS) liba.a
