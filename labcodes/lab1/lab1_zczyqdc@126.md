#操作系统第一次实验报告
钱迪晨 2013011402 计35
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

答：
在调试challenge1的时候，会看到如下信息
    
    tf = {tf_regs = {reg_edi = 1, reg_esi = 0, reg_ebp = 31608, reg_oesp = 31564, 
    reg_ebx = 65684, reg_edx = 1063207, reg_ecx = 0, reg_eax = 30}, 
    tf_gs = 35, tf_padding0 = 0, tf_fs = 35, tf_padding1 = 0, tf_es = 16, 
    tf_padding2 = 0, tf_ds = 16, tf_padding3 = 0, tf_trapno = 120, tf_err = 0, 
    tf_eip = 1049085, tf_cs = 8, tf_padding4 = 0, tf_eflags = 514, tf_esp = 0, 
    tf_ss = 656, tf_padding5 = 161}

这个就是trapframe的信息，可以根据这个信息进行调试。

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

##练习5
实验已经成功可以执行。

    ebp:0x00007bc8 eip:0x00100055 0x00000000 0x00000000 0x00000000 0x00010094 
    kern/init/init.c:31: kern_init+84
    ebp:0x00007bf8 eip:0x00007d68 0xc031fcfa 0xc08ed88e 0x64e4d08e 0xfa7502a8 
    <unknow>: -- 0x00007d67 --

###实现流程
具体的实现过程就是使用asm指令获得eip和ebp的值，然后使用指针操作得出所有值。

###题目1
解释最后一行各个数值的含义。

答：代码的最后几行，ebp和eip是两个寄存器的值，后面四个是ebp+8,ebp+12,ebp+16,ebp+20四个参数的值。

下一行表示的是函数当前运行的位置，以及运行函数的位置。unknow是因为是汇编代码trap.S的代码，没有调试信息。

##练习6
###实现流程
    int index = 0;
    for (; index < 256; index ++) {
        if (index < IRQ_OFFSET) { // trap {
            SETGATE(idt[index], 1, GD_KTEXT, __vectors[index], DPL_KERNEL);
        } else {
            SETGATE(idt[index], 0, GD_KTEXT, __vectors[index], DPL_KERNEL);
        }
    }
    SETGATE(idt[T_SWITCH_TOU], 1, GD_KTEXT, __vectors[T_SWITCH_TOU], DPL_KERNEL);
    SETGATE(idt[T_SWITCH_TOK], 1, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);
    lidt(&idt_pd);
代码如上，使用SETGATE(第几个idt，是不是trap，kernelcode的段，代码的入口地址，权限)进行初始化。
最后用汇编lidt加载idt表。

###题目1
中断描述符表（也可简称为保护模式下的中断向量表）中一个表项占多少字节？其中哪几位代表中断处理代码的入口？

答：
8Byte。

低16位表示入口代码的offset的低16位。高16为表示入口代码的offset的高16位。


##challenge1
###设计方案
在idt初始化里面，加入这两条初始化。

    SETGATE(idt[T_SWITCH_TOU], 1, GD_KTEXT, __vectors[T_SWITCH_TOU], DPL_KERNEL);
    SETGATE(idt[T_SWITCH_TOK], 1, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);

切换的时候使用int指令，进行软中断。

    asm volatile(
        "sub $0x08, %%esp\n;"
        "int %0\n;"
        "movl %%ebp, %%esp;\n"
        : : "i"(T_SWITCH_TOU)
    );

这里"sub $0x08, %%esp\n;"的原因是，切换到user态的时候，由于kernel进入系统中断的时候，少了最后的esp和ss，需要补进去，所以预先分配2字节。

最后movl的恢复而不使用"add $0x08, %%esp\n;"恢复的原因是，切换到user态的时候，硬件最后不知道esp应该恢复成什么样，切换到kernel态的时候，esp不会恢复。所以这里必须手动恢复。

切换的具体设置请查看代码，主要是cs，ss，ds，es的设置。

##challenge2
###设计方案
在init.c的while(1)中，加入每隔1秒钟打印cs，ss，de，es的内容。

在keyboard的中断中间加入判断，判断是不是3和0，然后进行切换。

如果是切换到kernel则只需要修改cs，ss，ds，es即可（和challenge1一样）。

如果是切换到user，由于前面新加入的2字节不能提前分配，所以采用的方法是使用局部变量tf1代替tf，构造一个假的堆栈，填补信息，然后修改tf的内容（也就是esp）指向假的栈即可。具体代码请看trap.c文件。

最后的效果是，按0，3会有switch的信息提示，每隔一秒钟会输出当前所运行的状态（kernel还是用户态）

##和提供答案的区别
- 在练习6里面，answer没有管trap和中断这个0和1的设置。
- 在challenge1里面，answer使用了两个假的trapframe，比较麻烦，我直接在原来的trapframe修改。
- challenge2，answer没有实现。

##重要知识点
这次实验主要学习的是如何把整个ucore跑起来，知识点很多有DPL，IDT，makefile，image的创建，第一个扇区的创建，中断处理。
