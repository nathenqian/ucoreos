#操作系统第一次实验报告
钱迪晨
##练习1
###题目1
操作系统镜像文件ucore.img是如何一步一步生成的？(要比较详细地解释Makefile中每一条相关命令和命令参数的含义，以及说明命令导致的结果)。

答：请看report/makefile_explain.make文件里面的注释。

###题目2
一个被系统认为是符合规范的硬盘主引导扇区的特征是什么？

答：特征有如下几方面。

* 大小为512字节。
* 第511字节为0x55，第512字节为0xAA。
* 具体操作代码大小最大只有510字节。

##练习2
###题目1
从CPU加电后执行的第一条指令开始，单步跟踪BIOS的执行。

答：通过修改tools/gdbinit文件，删除continue操作，可以看到第一条指令的eip=0xfff0，cs=0x000f，所以第一条指令的地址是0xffff0。

    0xffff0:     ljmp   $0x3630,$0xf000e05b
是一条大的jump指令，下一条指令是。

    0xfe05b:     cmpw   $0xffa4,%cs:(%esi)
接下来就是读取引导扇区的代码了。

###题目2
在初始化位置0x7c00设置实地址断点,测试断点正常。
答：调试以后，执行continue可以看到。

    Breakpoint 1, 0x00007c00 in ?? ()
可以看到断电正常。

###题目3
从0x7c00开始跟踪代码运行,将单步跟踪反汇编得到的代码与bootasm.S和 bootblock.asm进行比较。

答：由于最开始的入口应该是bootasm.S的start，查看代码。
    0x7c01:      cli
    0x7c01:      cld    
    0x7c02:      xor    %eax,%eax
    0x7c04:      mov    %eax,%ds
    0x7c06:      mov    %eax,%es
    0x7c08:      mov    %eax,%ss
    0x7c0a:      in     $0x64,%al
查看bootasm.S得到
    cli                                             # Disable interrupts
    cld                                             # String operations increment
    xorw %ax, %ax                                   # Segment number zero
    movw %ax, %ds                                   # -> Data Segment
    movw %ax, %es                                   # -> Extra Segment
    movw %ax, %ss                                   # -> Stack Segment
可以发现是一样的。

###题目4
自己找一个bootloader或内核中的代码位置，设置断点并进行测试。

##练习3
###题目1
BIOS将通过读取硬盘主引导扇区到内存，并转跳到对应内存中的位置执行bootloader。请分析bootloader是如何完成从实模式进入保护模式的。

答：
####开启A20 Gate
	seta20.1:
	等待8042的input buffer为空,64是status register，为0则为空，先输入0x64表示写，然后往0x60写数据
	inb $0x64, %al                                  # Wait for not busy(8042 input buffer empty).
	testb $0x2, %al
	jnz seta20.1
	向0x64端口写入0xd1
	movb $0xd1, %al                                 # 0xd1 -> port 0x64
	outb %al, $0x64                                 # 0xd1 means: write data to 8042's P2 port
	
	seta20.2:
	等待8042的input buffer为空
	inb $0x64, %al                                  # Wait for not busy(8042 input buffer empty).
	testb $0x2, %al
	jnz seta20.2
	向0x60端口写入0xdf	
	movb $0xdf, %al                                 # 0xdf -> port 0x60
	outb %al, $0x60                                 # 0xdf = 11011111, means set P2's A20 bit(the 1 bit) to 1
####初始化GDT表
	# 加载GDT表
	lgdt gdtdesc
	# 进入保护模式，cr0中的第0位为1表示处于保护模式，cr0中的第0位为0，表示处于实模式  
	movl %cr0, %eax
	orl $CR0_PE_ON, %eax
	movl %eax, %cr0
	
	# 长跳转准备进入bootmain主程序，由于已经开启了段模式，这里加入了段的选择子
	ljmp $PROT_MODE_CSEG, $protcseg

    # 清空所有寄存器，初始化ebp和esp准备进入bootmain函数
    .code32                                             # Assemble for 32-bit mode
    protcseg:
    # Set up the protected-mode data segment registers
    movw $PROT_MODE_DSEG, %ax                       # Our data segment selector
    movw %ax, %ds                                   # -> DS: Data Segment
    movw %ax, %es                                   # -> ES: Extra Segment
    movw %ax, %fs                                   # -> FS
    movw %ax, %gs                                   # -> GS
    movw %ax, %ss                                   # -> SS: Stack Segment

    # Set up the stack pointer and call into C. The stack region is from 0--start(0x7c00)
    movl $0x0, %ebp
    movl $start, %esp
    call bootmain


    .p2align 2                                          # force 4 byte alignment
    # 三个段描述符
    gdt:
    SEG_NULLASM                                     # null seg
    SEG_ASM(STA_X|STA_R, 0x0, 0xffffffff)           # code seg for bootloader and kernel
    SEG_ASM(STA_W, 0x0, 0xffffffff)                 # data seg for bootloader and kernel

    gdtdesc:
    .word 0x17                                      # sizeof(gdt) - 1
    .long gdt                                       # address gdt

##练习4
通过阅读bootmain.c，了解bootloader如何加载ELF文件。通过分析源代码和通过qemu来运行并调试bootloader&OS。
###题目1
bootloader如何读取硬盘扇区的？

答：bootloader在bootmain里面可以看到读取硬盘扇区的代码。
    static void
    waitdisk(void) {
        // 0x1F7是状态寄存器，为0x40则表示空闲
        while ((inb(0x1F7) & 0xC0) != 0x40)
            /* do nothing */;
    }
    static void
    readsect(void *dst, uint32_t secno) {
        // wait for disk to be ready
        waitdisk();
        // 0x1F2 表示的是读取的扇区个数
        outb(0x1F2, 1);                         // count = 1
        //0x1F3, 0x1F4, 0x1F5分别是第几个扇区的0-7,8-15,16-23位。
        outb(0x1F3, secno & 0xFF);
        outb(0x1F4, (secno >> 8) & 0xFF);
        outb(0x1F5, (secno >> 16) & 0xFF);
        //0x1F6的低四为是LBA的24-27位，第4位：为0主盘；为1从盘，第6位：为1=LBA模式；0 = CHS模式第7位和第5位必须为1，所以最后就是0xE。
        outb(0x1F6, ((secno >> 24) & 0xF) | 0xE0);
        outb(0x1F7, 0x20);                      // cmd 0x20 - read sectors

        // wait for disk to be ready
        waitdisk();

        // read a sector读取扇区
        insl(0x1F0, dst, SECTSIZE / 4);
    }
###题目2
bootloader是如何加载ELF格式的OS？

答：
    判断magic_number对不对。
    if (ELFHDR->e_magic != ELF_MAGIC) {
        goto bad;
    }

    struct proghdr *ph, *eph;

    // load each program segment (ignores ph flags)
    // ph是program header table的头地址
    ph = (struct proghdr *)((uintptr_t)ELFHDR + ELFHDR->e_phoff);
    // eph是program header table的尾地址
    eph = ph + ELFHDR->e_phnum;
    for (; ph < eph; ph ++) {
        // 从program header的虚拟地址， 读取p_memsz大小的内容，以及内容的开头是p_offset
        readseg(ph->p_va & 0xFFFFFF, ph->p_memsz, ph->p_offset);
    }

    // call the entry point from the ELF header
    // note: does not return
    // 从ELFHEADER里面的e_entry得知第一条代码的运行地址。
    ((void (*)(void))(ELFHDR->e_entry & 0xFFFFFF))();
