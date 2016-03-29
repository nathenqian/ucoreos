PROJ    := challenge
EMPTY   :=
SPACE   := $(EMPTY) $(EMPTY)
SLASH   := /

V       := @
# makefile 函数
# wildcard，文件名字匹配展开

#need llvm/cang-3.5+
#USELLVM := 1
# try to infer the correct GCCPREFX
# 检查gcc和qemu的安装，以及记录他们安装的路径
ifndef GCCPREFIX
GCCPREFIX := $(shell if i386-elf-objdump -i 2>&1 | grep '^elf32-i386$$' >/dev/null 2>&1; \
    then echo 'i386-elf-'; \
    elif objdump -i 2>&1 | grep 'elf32-i386' >/dev/null 2>&1; \
    then echo ''; \
    else echo "***" 1>&2; \
    echo "*** Error: Couldn't find an i386-elf version of GCC/binutils." 1>&2; \
    echo "*** Is the directory with i386-elf-gcc in your PATH?" 1>&2; \
    echo "*** If your i386-elf toolchain is installed with a command" 1>&2; \
    echo "*** prefix other than 'i386-elf-', set your GCCPREFIX" 1>&2; \
    echo "*** environment variable to that prefix and run 'make' again." 1>&2; \
    echo "*** To turn off this error, run 'gmake GCCPREFIX= ...'." 1>&2; \
    echo "***" 1>&2; exit 1; fi)
endif

# try to infer the correct QEMU
ifndef QEMU
QEMU := $(shell if which qemu-system-i386 > /dev/null; \
    then echo 'qemu-system-i386'; exit; \
    elif which i386-elf-qemu > /dev/null; \
    then echo 'i386-elf-qemu'; exit; \
    elif which qemu > /dev/null; \
    then echo 'qemu'; exit; \
    else \
    echo "***" 1>&2; \
    echo "*** Error: Couldn't find a working QEMU executable." 1>&2; \
    echo "*** Is the directory containing the qemu binary in your PATH" 1>&2; \
    echo "***" 1>&2; exit 1; fi)
endif

# eliminate default suffix rules
.SUFFIXES: .c .S .h

# delete target files if there is an error (or make is interrupted)
.DELETE_ON_ERROR:

# define compiler and flags
ifndef  USELLVM
# 设置编译的编译器以及参数以及编译器的位置
HOSTCC      := gcc
HOSTCFLAGS  := -g -Wall -O2
CC      := $(GCCPREFIX)gcc
CFLAGS  := -fno-builtin -Wall -ggdb -m32 -gstabs -nostdinc $(DEFS)
CFLAGS  += $(shell $(CC) -fno-stack-protector -E -x c /dev/null >/dev/null 2>&1 && echo -fno-stack-protector)
else
HOSTCC      := clang
HOSTCFLAGS  := -g -Wall -O2
CC      := clang
CFLAGS  := -fno-builtin -Wall -g -m32 -mno-sse -nostdinc $(DEFS)
CFLAGS  += $(shell $(CC) -fno-stack-protector -E -x c /dev/null >/dev/null 2>&1 && echo -fno-stack-protector)
endif

CTYPE   := c S

LD      := $(GCCPREFIX)ld
LDFLAGS := -m $(shell $(LD) -V | grep elf_i386 2>/dev/null)
LDFLAGS += -nostdlib

OBJCOPY := $(GCCPREFIX)objcopy
OBJDUMP := $(GCCPREFIX)objdump

COPY    := cp
MKDIR   := mkdir -p
MV      := mv
RM      := rm -f
AWK     := awk
SED     := sed
SH      := sh
TR      := tr
TOUCH   := touch -c

OBJDIR  := obj
BINDIR  := bin

ALLOBJS :=
ALLDEPS :=
TARGETS :=

include tools/function.mk
# 查找所有c和S后缀的文件
listf_cc = $(call listf,$(1),$(CTYPE))

# for cc
# 将文件加入到packet
add_files_cc = $(call add_files,$(1),$(CC),$(CFLAGS) $(3),$(2),$(4))
# 新建目标文件packet
create_target_cc = $(call create_target,$(1),$(2),$(3),$(CC),$(CFLAGS))

# for hostcc
add_files_host = $(call add_files,$(1),$(HOSTCC),$(HOSTCFLAGS),$(2),$(3))
create_target_host = $(call create_target,$(1),$(2),$(3),$(HOSTCC),$(HOSTCFLAGS))

cgtype = $(patsubst %.$(2),%.$(3),$(1))
objfile = $(call toobj,$(1))
asmfile = $(call cgtype,$(call toobj,$(1)),o,asm)
outfile = $(call cgtype,$(call toobj,$(1)),o,out)
symfile = $(call cgtype,$(call toobj,$(1)),o,sym)

# for match pattern
match = $(shell echo $(2) | $(AWK) '{for(i=1;i<=NF;i++){if(match("$(1)","^"$$(i)"$$")){exit 1;}}}'; echo $$?)

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# include kernel/user
# 将用户程序加入编译
INCLUDE += libs/

CFLAGS  += $(addprefix -I,$(INCLUDE))

LIBDIR  += libs

$(call add_files_cc,$(call listf_cc,$(LIBDIR)),libs,)

# -------------------------------------------------------------------
# kernel
# kernerinclude的文件夹
KINCLUDE    += kern/debug/ \
               kern/driver/ \
               kern/trap/ \
               kern/mm/
# kernel源代码
KSRCDIR     += kern/init \
               kern/libs \
               kern/debug \
               kern/driver \
               kern/trap \
               kern/mm
# 编译参数，include之前加上-I
KCFLAGS     += $(addprefix -I,$(KINCLUDE))
# 将所有要编译的文件加入packet
$(call add_files_cc,$(call listf_cc,$(KSRCDIR)),kernel,$(KCFLAGS))
# 读取所有要编译的目标文件
KOBJS   = $(call read_packet,kernel libs)

# create kernel target
kernel = $(call totarget,kernel)
# 生成ucore kernel
$(kernel): tools/kernel.ld
# 下面进行ld的链接
$(kernel): $(KOBJS)
    @echo + ld $@
    $(V)$(LD) $(LDFLAGS) -T tools/kernel.ld -o $@ $(KOBJS)
    @$(OBJDUMP) -S $@ > $(call asmfile,kernel)
    @$(OBJDUMP) -t $@ | $(SED) '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $(call symfile,kernel)

$(call create_target,kernel)

# -------------------------------------------------------------------

# create bootblock
# 从boot文件夹里面读取文件，并编译
bootfiles = $(call listf_cc,boot)
$(foreach f,$(bootfiles),$(call cc_compile,$(f),$(CC),$(CFLAGS) -Os -nostdinc))
# 生成目标文件
bootblock = $(call totarget,bootblock)
# 生成目标文件进行链接
$(bootblock): $(call toobj,$(bootfiles)) | $(call totarget,sign)
    @echo + ld $@
    $(V)$(LD) $(LDFLAGS) -N -e start -Ttext 0x7C00 $^ -o $(call toobj,bootblock)
    @$(OBJDUMP) -S $(call objfile,bootblock) > $(call asmfile,bootblock)
    @$(OBJCOPY) -S -O binary $(call objfile,bootblock) $(call outfile,bootblock)
    @$(call totarget,sign) $(call outfile,bootblock) $(bootblock)

$(call create_target,bootblock)

# -------------------------------------------------------------------

# create 'sign' tools
# 这里生成sign的工具编译
$(call add_files_host,tools/sign.c,sign,sign)
$(call create_target_host,sign,sign)

# -------------------------------------------------------------------

# create ucore.img
UCOREIMG    := $(call totarget,ucore.img)
# 生成ucore.image，主要是生成kerner和bootloader然后生成引导扇区内容，然后合并两个文件第一句显示生成10000Byte“0”，然后将引导扇区写入，然后写入kernel。
$(UCOREIMG): $(kernel) $(bootblock)
    $(V)dd if=/dev/zero of=$@ count=10000
    $(V)dd if=$(bootblock) of=$@ conv=notrunc
    $(V)dd if=$(kernel) of=$@ seek=1 conv=notrunc

$(call create_target,ucore.img)

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

$(call finish_all)

IGNORE_ALLDEPS  = clean \
                  dist-clean \
                  grade \
                  touch \
                  print-.+ \
                  handin

ifeq ($(call match,$(MAKECMDGOALS),$(IGNORE_ALLDEPS)),0)
-include $(ALLDEPS)
endif

# files for grade script

TARGETS: $(TARGETS)

.DEFAULT_GOAL := TARGETS

.PHONY: qemu qemu-nox debug debug-nox
qemu-mon: $(UCOREIMG)
    $(V)$(QEMU)  -no-reboot -monitor stdio -hda $< -serial null
qemu: $(UCOREIMG)
    $(V)$(QEMU) -no-reboot -parallel stdio -hda $< -serial null
log: $(UCOREIMG)
    $(V)$(QEMU) -no-reboot -d int,cpu_reset  -D q.log -parallel stdio -hda $< -serial null
qemu-nox: $(UCOREIMG)
    $(V)$(QEMU)   -no-reboot -serial mon:stdio -hda $< -nographic
TERMINAL        :=gnome-terminal
debug: $(UCOREIMG)
    $(V)$(QEMU) -S -s -parallel stdio -hda $< -serial null &
    $(V)sleep 2
    $(V)$(TERMINAL) -e "gdb -q -tui -x tools/gdbinit"
    
debug-nox: $(UCOREIMG)
    $(V)$(QEMU) -S -s -serial mon:stdio -hda $< -nographic &
    $(V)sleep 2
    $(V)$(TERMINAL) -e "gdb -q -x tools/gdbinit"

.PHONY: grade touch

GRADE_GDB_IN    := .gdb.in
GRADE_QEMU_OUT  := .qemu.out
HANDIN          := proj$(PROJ)-handin.tar.gz

TOUCH_FILES     := kern/trap/trap.c

MAKEOPTS        := --quiet --no-print-directory

grade:
    $(V)$(MAKE) $(MAKEOPTS) clean
    $(V)$(SH) tools/grade.sh

touch:
    $(V)$(foreach f,$(TOUCH_FILES),$(TOUCH) $(f))

print-%:
    @echo $($(shell echo $(patsubst print-%,%,$@) | $(TR) [a-z] [A-Z]))

.PHONY: clean dist-clean handin packall tags
clean:
    $(V)$(RM) $(GRADE_GDB_IN) $(GRADE_QEMU_OUT) cscope* tags
    -$(RM) -r $(OBJDIR) $(BINDIR)

dist-clean: clean
    -$(RM) $(HANDIN)

handin: packall
    @echo Please visit http://learn.tsinghua.edu.cn and upload $(HANDIN). Thanks!

packall: clean
    @$(RM) -f $(HANDIN)
    @tar -czf $(HANDIN) `find . -type f -o -type d | grep -v '^\.*$$' | grep -vF '$(HANDIN)'`

tags:
    @echo TAGS ALL
    $(V)rm -f cscope.files cscope.in.out cscope.out cscope.po.out tags
    $(V)find . -type f -name "*.[chS]" >cscope.files
    $(V)cscope -bq 
    $(V)ctags -L cscope.files