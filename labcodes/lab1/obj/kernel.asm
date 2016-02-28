
bin/kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <kern_init>:
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

int
kern_init(void) {
  100000:	55                   	push   %ebp
  100001:	89 e5                	mov    %esp,%ebp
  100003:	83 ec 28             	sub    $0x28,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
  100006:	ba 20 fd 10 00       	mov    $0x10fd20,%edx
  10000b:	b8 18 ea 10 00       	mov    $0x10ea18,%eax
  100010:	89 d1                	mov    %edx,%ecx
  100012:	29 c1                	sub    %eax,%ecx
  100014:	89 c8                	mov    %ecx,%eax
  100016:	89 44 24 08          	mov    %eax,0x8(%esp)
  10001a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100021:	00 
  100022:	c7 04 24 18 ea 10 00 	movl   $0x10ea18,(%esp)
  100029:	e8 39 31 00 00       	call   103167 <memset>

    cons_init();                // init the console
  10002e:	e8 ff 14 00 00       	call   101532 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  100033:	c7 45 f4 20 33 10 00 	movl   $0x103320,-0xc(%ebp)
    cprintf("%s\n\n", message);
  10003a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10003d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100041:	c7 04 24 3c 33 10 00 	movl   $0x10333c,(%esp)
  100048:	e8 ce 02 00 00       	call   10031b <cprintf>

    print_kerninfo();
  10004d:	e8 d8 07 00 00       	call   10082a <print_kerninfo>

    grade_backtrace();
  100052:	e8 86 00 00 00       	call   1000dd <grade_backtrace>

    pmm_init();                 // init physical memory management
  100057:	e8 fd 26 00 00       	call   102759 <pmm_init>

    pic_init();                 // init interrupt controller
  10005c:	e8 1c 16 00 00       	call   10167d <pic_init>
    idt_init();                 // init interrupt descriptor table
  100061:	e8 6e 17 00 00       	call   1017d4 <idt_init>

    clock_init();               // init clock interrupt
  100066:	e8 19 0c 00 00       	call   100c84 <clock_init>
    intr_enable();              // enable irq interrupt
  10006b:	e8 74 15 00 00       	call   1015e4 <intr_enable>
    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    //lab1_switch_test();

    /* do nothing */
    while (1);
  100070:	eb fe                	jmp    100070 <kern_init+0x70>

00100072 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  100072:	55                   	push   %ebp
  100073:	89 e5                	mov    %esp,%ebp
  100075:	83 ec 18             	sub    $0x18,%esp
    mon_backtrace(0, NULL, NULL);
  100078:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  10007f:	00 
  100080:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100087:	00 
  100088:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10008f:	e8 1a 0b 00 00       	call   100bae <mon_backtrace>
}
  100094:	c9                   	leave  
  100095:	c3                   	ret    

00100096 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  100096:	55                   	push   %ebp
  100097:	89 e5                	mov    %esp,%ebp
  100099:	53                   	push   %ebx
  10009a:	83 ec 14             	sub    $0x14,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  10009d:	8d 5d 0c             	lea    0xc(%ebp),%ebx
  1000a0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  1000a3:	8d 55 08             	lea    0x8(%ebp),%edx
  1000a6:	8b 45 08             	mov    0x8(%ebp),%eax
  1000a9:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  1000ad:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  1000b1:	89 54 24 04          	mov    %edx,0x4(%esp)
  1000b5:	89 04 24             	mov    %eax,(%esp)
  1000b8:	e8 b5 ff ff ff       	call   100072 <grade_backtrace2>
}
  1000bd:	83 c4 14             	add    $0x14,%esp
  1000c0:	5b                   	pop    %ebx
  1000c1:	5d                   	pop    %ebp
  1000c2:	c3                   	ret    

001000c3 <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000c3:	55                   	push   %ebp
  1000c4:	89 e5                	mov    %esp,%ebp
  1000c6:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace1(arg0, arg2);
  1000c9:	8b 45 10             	mov    0x10(%ebp),%eax
  1000cc:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000d0:	8b 45 08             	mov    0x8(%ebp),%eax
  1000d3:	89 04 24             	mov    %eax,(%esp)
  1000d6:	e8 bb ff ff ff       	call   100096 <grade_backtrace1>
}
  1000db:	c9                   	leave  
  1000dc:	c3                   	ret    

001000dd <grade_backtrace>:

void
grade_backtrace(void) {
  1000dd:	55                   	push   %ebp
  1000de:	89 e5                	mov    %esp,%ebp
  1000e0:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  1000e3:	b8 00 00 10 00       	mov    $0x100000,%eax
  1000e8:	c7 44 24 08 00 00 ff 	movl   $0xffff0000,0x8(%esp)
  1000ef:	ff 
  1000f0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000f4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1000fb:	e8 c3 ff ff ff       	call   1000c3 <grade_backtrace0>
}
  100100:	c9                   	leave  
  100101:	c3                   	ret    

00100102 <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  100102:	55                   	push   %ebp
  100103:	89 e5                	mov    %esp,%ebp
  100105:	83 ec 28             	sub    $0x28,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  100108:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  10010b:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  10010e:	8c 45 f2             	mov    %es,-0xe(%ebp)
  100111:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  100114:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100118:	0f b7 c0             	movzwl %ax,%eax
  10011b:	89 c2                	mov    %eax,%edx
  10011d:	83 e2 03             	and    $0x3,%edx
  100120:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100125:	89 54 24 08          	mov    %edx,0x8(%esp)
  100129:	89 44 24 04          	mov    %eax,0x4(%esp)
  10012d:	c7 04 24 41 33 10 00 	movl   $0x103341,(%esp)
  100134:	e8 e2 01 00 00       	call   10031b <cprintf>
    cprintf("%d:  cs = %x\n", round, reg1);
  100139:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10013d:	0f b7 d0             	movzwl %ax,%edx
  100140:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100145:	89 54 24 08          	mov    %edx,0x8(%esp)
  100149:	89 44 24 04          	mov    %eax,0x4(%esp)
  10014d:	c7 04 24 4f 33 10 00 	movl   $0x10334f,(%esp)
  100154:	e8 c2 01 00 00       	call   10031b <cprintf>
    cprintf("%d:  ds = %x\n", round, reg2);
  100159:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  10015d:	0f b7 d0             	movzwl %ax,%edx
  100160:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100165:	89 54 24 08          	mov    %edx,0x8(%esp)
  100169:	89 44 24 04          	mov    %eax,0x4(%esp)
  10016d:	c7 04 24 5d 33 10 00 	movl   $0x10335d,(%esp)
  100174:	e8 a2 01 00 00       	call   10031b <cprintf>
    cprintf("%d:  es = %x\n", round, reg3);
  100179:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  10017d:	0f b7 d0             	movzwl %ax,%edx
  100180:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100185:	89 54 24 08          	mov    %edx,0x8(%esp)
  100189:	89 44 24 04          	mov    %eax,0x4(%esp)
  10018d:	c7 04 24 6b 33 10 00 	movl   $0x10336b,(%esp)
  100194:	e8 82 01 00 00       	call   10031b <cprintf>
    cprintf("%d:  ss = %x\n", round, reg4);
  100199:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  10019d:	0f b7 d0             	movzwl %ax,%edx
  1001a0:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  1001a5:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001a9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001ad:	c7 04 24 79 33 10 00 	movl   $0x103379,(%esp)
  1001b4:	e8 62 01 00 00       	call   10031b <cprintf>
    round ++;
  1001b9:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  1001be:	83 c0 01             	add    $0x1,%eax
  1001c1:	a3 20 ea 10 00       	mov    %eax,0x10ea20
}
  1001c6:	c9                   	leave  
  1001c7:	c3                   	ret    

001001c8 <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  1001c8:	55                   	push   %ebp
  1001c9:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
}
  1001cb:	5d                   	pop    %ebp
  1001cc:	c3                   	ret    

001001cd <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  1001cd:	55                   	push   %ebp
  1001ce:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
}
  1001d0:	5d                   	pop    %ebp
  1001d1:	c3                   	ret    

001001d2 <lab1_switch_test>:

static void
lab1_switch_test(void) {
  1001d2:	55                   	push   %ebp
  1001d3:	89 e5                	mov    %esp,%ebp
  1001d5:	83 ec 18             	sub    $0x18,%esp
    lab1_print_cur_status();
  1001d8:	e8 25 ff ff ff       	call   100102 <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  1001dd:	c7 04 24 88 33 10 00 	movl   $0x103388,(%esp)
  1001e4:	e8 32 01 00 00       	call   10031b <cprintf>
    lab1_switch_to_user();
  1001e9:	e8 da ff ff ff       	call   1001c8 <lab1_switch_to_user>
    lab1_print_cur_status();
  1001ee:	e8 0f ff ff ff       	call   100102 <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  1001f3:	c7 04 24 a8 33 10 00 	movl   $0x1033a8,(%esp)
  1001fa:	e8 1c 01 00 00       	call   10031b <cprintf>
    lab1_switch_to_kernel();
  1001ff:	e8 c9 ff ff ff       	call   1001cd <lab1_switch_to_kernel>
    lab1_print_cur_status();
  100204:	e8 f9 fe ff ff       	call   100102 <lab1_print_cur_status>
}
  100209:	c9                   	leave  
  10020a:	c3                   	ret    
	...

0010020c <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  10020c:	55                   	push   %ebp
  10020d:	89 e5                	mov    %esp,%ebp
  10020f:	83 ec 28             	sub    $0x28,%esp
    if (prompt != NULL) {
  100212:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100216:	74 13                	je     10022b <readline+0x1f>
        cprintf("%s", prompt);
  100218:	8b 45 08             	mov    0x8(%ebp),%eax
  10021b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10021f:	c7 04 24 c7 33 10 00 	movl   $0x1033c7,(%esp)
  100226:	e8 f0 00 00 00       	call   10031b <cprintf>
    }
    int i = 0, c;
  10022b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100232:	eb 01                	jmp    100235 <readline+0x29>
        else if (c == '\n' || c == '\r') {
            cputchar(c);
            buf[i] = '\0';
            return buf;
        }
    }
  100234:	90                   	nop
    if (prompt != NULL) {
        cprintf("%s", prompt);
    }
    int i = 0, c;
    while (1) {
        c = getchar();
  100235:	e8 6e 01 00 00       	call   1003a8 <getchar>
  10023a:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  10023d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100241:	79 07                	jns    10024a <readline+0x3e>
            return NULL;
  100243:	b8 00 00 00 00       	mov    $0x0,%eax
  100248:	eb 79                	jmp    1002c3 <readline+0xb7>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  10024a:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  10024e:	7e 28                	jle    100278 <readline+0x6c>
  100250:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100257:	7f 1f                	jg     100278 <readline+0x6c>
            cputchar(c);
  100259:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10025c:	89 04 24             	mov    %eax,(%esp)
  10025f:	e8 df 00 00 00       	call   100343 <cputchar>
            buf[i ++] = c;
  100264:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100267:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10026a:	81 c2 40 ea 10 00    	add    $0x10ea40,%edx
  100270:	88 02                	mov    %al,(%edx)
  100272:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100276:	eb 46                	jmp    1002be <readline+0xb2>
        }
        else if (c == '\b' && i > 0) {
  100278:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  10027c:	75 17                	jne    100295 <readline+0x89>
  10027e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100282:	7e 11                	jle    100295 <readline+0x89>
            cputchar(c);
  100284:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100287:	89 04 24             	mov    %eax,(%esp)
  10028a:	e8 b4 00 00 00       	call   100343 <cputchar>
            i --;
  10028f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  100293:	eb 29                	jmp    1002be <readline+0xb2>
        }
        else if (c == '\n' || c == '\r') {
  100295:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  100299:	74 06                	je     1002a1 <readline+0x95>
  10029b:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  10029f:	75 93                	jne    100234 <readline+0x28>
            cputchar(c);
  1002a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1002a4:	89 04 24             	mov    %eax,(%esp)
  1002a7:	e8 97 00 00 00       	call   100343 <cputchar>
            buf[i] = '\0';
  1002ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1002af:	05 40 ea 10 00       	add    $0x10ea40,%eax
  1002b4:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1002b7:	b8 40 ea 10 00       	mov    $0x10ea40,%eax
  1002bc:	eb 05                	jmp    1002c3 <readline+0xb7>
        }
    }
  1002be:	e9 71 ff ff ff       	jmp    100234 <readline+0x28>
}
  1002c3:	c9                   	leave  
  1002c4:	c3                   	ret    
  1002c5:	00 00                	add    %al,(%eax)
	...

001002c8 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  1002c8:	55                   	push   %ebp
  1002c9:	89 e5                	mov    %esp,%ebp
  1002cb:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  1002ce:	8b 45 08             	mov    0x8(%ebp),%eax
  1002d1:	89 04 24             	mov    %eax,(%esp)
  1002d4:	e8 85 12 00 00       	call   10155e <cons_putc>
    (*cnt) ++;
  1002d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002dc:	8b 00                	mov    (%eax),%eax
  1002de:	8d 50 01             	lea    0x1(%eax),%edx
  1002e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002e4:	89 10                	mov    %edx,(%eax)
}
  1002e6:	c9                   	leave  
  1002e7:	c3                   	ret    

001002e8 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  1002e8:	55                   	push   %ebp
  1002e9:	89 e5                	mov    %esp,%ebp
  1002eb:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  1002ee:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  1002f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002f8:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1002fc:	8b 45 08             	mov    0x8(%ebp),%eax
  1002ff:	89 44 24 08          	mov    %eax,0x8(%esp)
  100303:	8d 45 f4             	lea    -0xc(%ebp),%eax
  100306:	89 44 24 04          	mov    %eax,0x4(%esp)
  10030a:	c7 04 24 c8 02 10 00 	movl   $0x1002c8,(%esp)
  100311:	e8 54 26 00 00       	call   10296a <vprintfmt>
    return cnt;
  100316:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100319:	c9                   	leave  
  10031a:	c3                   	ret    

0010031b <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  10031b:	55                   	push   %ebp
  10031c:	89 e5                	mov    %esp,%ebp
  10031e:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  100321:	8d 55 0c             	lea    0xc(%ebp),%edx
  100324:	8d 45 f0             	lea    -0x10(%ebp),%eax
  100327:	89 10                	mov    %edx,(%eax)
    cnt = vcprintf(fmt, ap);
  100329:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10032c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100330:	8b 45 08             	mov    0x8(%ebp),%eax
  100333:	89 04 24             	mov    %eax,(%esp)
  100336:	e8 ad ff ff ff       	call   1002e8 <vcprintf>
  10033b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  10033e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100341:	c9                   	leave  
  100342:	c3                   	ret    

00100343 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  100343:	55                   	push   %ebp
  100344:	89 e5                	mov    %esp,%ebp
  100346:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  100349:	8b 45 08             	mov    0x8(%ebp),%eax
  10034c:	89 04 24             	mov    %eax,(%esp)
  10034f:	e8 0a 12 00 00       	call   10155e <cons_putc>
}
  100354:	c9                   	leave  
  100355:	c3                   	ret    

00100356 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  100356:	55                   	push   %ebp
  100357:	89 e5                	mov    %esp,%ebp
  100359:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  10035c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  100363:	eb 13                	jmp    100378 <cputs+0x22>
        cputch(c, &cnt);
  100365:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  100369:	8d 55 f0             	lea    -0x10(%ebp),%edx
  10036c:	89 54 24 04          	mov    %edx,0x4(%esp)
  100370:	89 04 24             	mov    %eax,(%esp)
  100373:	e8 50 ff ff ff       	call   1002c8 <cputch>
 * */
int
cputs(const char *str) {
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
  100378:	8b 45 08             	mov    0x8(%ebp),%eax
  10037b:	0f b6 00             	movzbl (%eax),%eax
  10037e:	88 45 f7             	mov    %al,-0x9(%ebp)
  100381:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  100385:	0f 95 c0             	setne  %al
  100388:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  10038c:	84 c0                	test   %al,%al
  10038e:	75 d5                	jne    100365 <cputs+0xf>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
  100390:	8d 45 f0             	lea    -0x10(%ebp),%eax
  100393:	89 44 24 04          	mov    %eax,0x4(%esp)
  100397:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  10039e:	e8 25 ff ff ff       	call   1002c8 <cputch>
    return cnt;
  1003a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  1003a6:	c9                   	leave  
  1003a7:	c3                   	ret    

001003a8 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  1003a8:	55                   	push   %ebp
  1003a9:	89 e5                	mov    %esp,%ebp
  1003ab:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  1003ae:	e8 d4 11 00 00       	call   101587 <cons_getc>
  1003b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1003b6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003ba:	74 f2                	je     1003ae <getchar+0x6>
        /* do nothing */;
    return c;
  1003bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1003bf:	c9                   	leave  
  1003c0:	c3                   	ret    
  1003c1:	00 00                	add    %al,(%eax)
	...

001003c4 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  1003c4:	55                   	push   %ebp
  1003c5:	89 e5                	mov    %esp,%ebp
  1003c7:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  1003ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  1003cd:	8b 00                	mov    (%eax),%eax
  1003cf:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1003d2:	8b 45 10             	mov    0x10(%ebp),%eax
  1003d5:	8b 00                	mov    (%eax),%eax
  1003d7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1003da:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  1003e1:	e9 c6 00 00 00       	jmp    1004ac <stab_binsearch+0xe8>
        int true_m = (l + r) / 2, m = true_m;
  1003e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1003e9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1003ec:	01 d0                	add    %edx,%eax
  1003ee:	89 c2                	mov    %eax,%edx
  1003f0:	c1 ea 1f             	shr    $0x1f,%edx
  1003f3:	01 d0                	add    %edx,%eax
  1003f5:	d1 f8                	sar    %eax
  1003f7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1003fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1003fd:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  100400:	eb 04                	jmp    100406 <stab_binsearch+0x42>
            m --;
  100402:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)

    while (l <= r) {
        int true_m = (l + r) / 2, m = true_m;

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  100406:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100409:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  10040c:	7c 1b                	jl     100429 <stab_binsearch+0x65>
  10040e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100411:	89 d0                	mov    %edx,%eax
  100413:	01 c0                	add    %eax,%eax
  100415:	01 d0                	add    %edx,%eax
  100417:	c1 e0 02             	shl    $0x2,%eax
  10041a:	03 45 08             	add    0x8(%ebp),%eax
  10041d:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100421:	0f b6 c0             	movzbl %al,%eax
  100424:	3b 45 14             	cmp    0x14(%ebp),%eax
  100427:	75 d9                	jne    100402 <stab_binsearch+0x3e>
            m --;
        }
        if (m < l) {    // no match in [l, m]
  100429:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10042c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  10042f:	7d 0b                	jge    10043c <stab_binsearch+0x78>
            l = true_m + 1;
  100431:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100434:	83 c0 01             	add    $0x1,%eax
  100437:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  10043a:	eb 70                	jmp    1004ac <stab_binsearch+0xe8>
        }

        // actual binary search
        any_matches = 1;
  10043c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  100443:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100446:	89 d0                	mov    %edx,%eax
  100448:	01 c0                	add    %eax,%eax
  10044a:	01 d0                	add    %edx,%eax
  10044c:	c1 e0 02             	shl    $0x2,%eax
  10044f:	03 45 08             	add    0x8(%ebp),%eax
  100452:	8b 40 08             	mov    0x8(%eax),%eax
  100455:	3b 45 18             	cmp    0x18(%ebp),%eax
  100458:	73 13                	jae    10046d <stab_binsearch+0xa9>
            *region_left = m;
  10045a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10045d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100460:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  100462:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100465:	83 c0 01             	add    $0x1,%eax
  100468:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10046b:	eb 3f                	jmp    1004ac <stab_binsearch+0xe8>
        } else if (stabs[m].n_value > addr) {
  10046d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100470:	89 d0                	mov    %edx,%eax
  100472:	01 c0                	add    %eax,%eax
  100474:	01 d0                	add    %edx,%eax
  100476:	c1 e0 02             	shl    $0x2,%eax
  100479:	03 45 08             	add    0x8(%ebp),%eax
  10047c:	8b 40 08             	mov    0x8(%eax),%eax
  10047f:	3b 45 18             	cmp    0x18(%ebp),%eax
  100482:	76 16                	jbe    10049a <stab_binsearch+0xd6>
            *region_right = m - 1;
  100484:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100487:	8d 50 ff             	lea    -0x1(%eax),%edx
  10048a:	8b 45 10             	mov    0x10(%ebp),%eax
  10048d:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  10048f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100492:	83 e8 01             	sub    $0x1,%eax
  100495:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100498:	eb 12                	jmp    1004ac <stab_binsearch+0xe8>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  10049a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10049d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1004a0:	89 10                	mov    %edx,(%eax)
            l = m;
  1004a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1004a5:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  1004a8:	83 45 18 01          	addl   $0x1,0x18(%ebp)
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
    int l = *region_left, r = *region_right, any_matches = 0;

    while (l <= r) {
  1004ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1004af:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1004b2:	0f 8e 2e ff ff ff    	jle    1003e6 <stab_binsearch+0x22>
            l = m;
            addr ++;
        }
    }

    if (!any_matches) {
  1004b8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1004bc:	75 0f                	jne    1004cd <stab_binsearch+0x109>
        *region_right = *region_left - 1;
  1004be:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004c1:	8b 00                	mov    (%eax),%eax
  1004c3:	8d 50 ff             	lea    -0x1(%eax),%edx
  1004c6:	8b 45 10             	mov    0x10(%ebp),%eax
  1004c9:	89 10                	mov    %edx,(%eax)
  1004cb:	eb 3b                	jmp    100508 <stab_binsearch+0x144>
    }
    else {
        // find rightmost region containing 'addr'
        l = *region_right;
  1004cd:	8b 45 10             	mov    0x10(%ebp),%eax
  1004d0:	8b 00                	mov    (%eax),%eax
  1004d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  1004d5:	eb 04                	jmp    1004db <stab_binsearch+0x117>
  1004d7:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  1004db:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004de:	8b 00                	mov    (%eax),%eax
  1004e0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1004e3:	7d 1b                	jge    100500 <stab_binsearch+0x13c>
  1004e5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1004e8:	89 d0                	mov    %edx,%eax
  1004ea:	01 c0                	add    %eax,%eax
  1004ec:	01 d0                	add    %edx,%eax
  1004ee:	c1 e0 02             	shl    $0x2,%eax
  1004f1:	03 45 08             	add    0x8(%ebp),%eax
  1004f4:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1004f8:	0f b6 c0             	movzbl %al,%eax
  1004fb:	3b 45 14             	cmp    0x14(%ebp),%eax
  1004fe:	75 d7                	jne    1004d7 <stab_binsearch+0x113>
            /* do nothing */;
        *region_left = l;
  100500:	8b 45 0c             	mov    0xc(%ebp),%eax
  100503:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100506:	89 10                	mov    %edx,(%eax)
    }
}
  100508:	c9                   	leave  
  100509:	c3                   	ret    

0010050a <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  10050a:	55                   	push   %ebp
  10050b:	89 e5                	mov    %esp,%ebp
  10050d:	53                   	push   %ebx
  10050e:	83 ec 54             	sub    $0x54,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  100511:	8b 45 0c             	mov    0xc(%ebp),%eax
  100514:	c7 00 cc 33 10 00    	movl   $0x1033cc,(%eax)
    info->eip_line = 0;
  10051a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10051d:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  100524:	8b 45 0c             	mov    0xc(%ebp),%eax
  100527:	c7 40 08 cc 33 10 00 	movl   $0x1033cc,0x8(%eax)
    info->eip_fn_namelen = 9;
  10052e:	8b 45 0c             	mov    0xc(%ebp),%eax
  100531:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  100538:	8b 45 0c             	mov    0xc(%ebp),%eax
  10053b:	8b 55 08             	mov    0x8(%ebp),%edx
  10053e:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  100541:	8b 45 0c             	mov    0xc(%ebp),%eax
  100544:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  10054b:	c7 45 f4 ec 3b 10 00 	movl   $0x103bec,-0xc(%ebp)
    stab_end = __STAB_END__;
  100552:	c7 45 f0 54 b2 10 00 	movl   $0x10b254,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  100559:	c7 45 ec 55 b2 10 00 	movl   $0x10b255,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  100560:	c7 45 e8 eb d1 10 00 	movl   $0x10d1eb,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  100567:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10056a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  10056d:	76 0d                	jbe    10057c <debuginfo_eip+0x72>
  10056f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100572:	83 e8 01             	sub    $0x1,%eax
  100575:	0f b6 00             	movzbl (%eax),%eax
  100578:	84 c0                	test   %al,%al
  10057a:	74 0a                	je     100586 <debuginfo_eip+0x7c>
        return -1;
  10057c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100581:	e9 9e 02 00 00       	jmp    100824 <debuginfo_eip+0x31a>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  100586:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  10058d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100590:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100593:	89 d1                	mov    %edx,%ecx
  100595:	29 c1                	sub    %eax,%ecx
  100597:	89 c8                	mov    %ecx,%eax
  100599:	c1 f8 02             	sar    $0x2,%eax
  10059c:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  1005a2:	83 e8 01             	sub    $0x1,%eax
  1005a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  1005a8:	8b 45 08             	mov    0x8(%ebp),%eax
  1005ab:	89 44 24 10          	mov    %eax,0x10(%esp)
  1005af:	c7 44 24 0c 64 00 00 	movl   $0x64,0xc(%esp)
  1005b6:	00 
  1005b7:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1005ba:	89 44 24 08          	mov    %eax,0x8(%esp)
  1005be:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1005c1:	89 44 24 04          	mov    %eax,0x4(%esp)
  1005c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1005c8:	89 04 24             	mov    %eax,(%esp)
  1005cb:	e8 f4 fd ff ff       	call   1003c4 <stab_binsearch>
    if (lfile == 0)
  1005d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1005d3:	85 c0                	test   %eax,%eax
  1005d5:	75 0a                	jne    1005e1 <debuginfo_eip+0xd7>
        return -1;
  1005d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1005dc:	e9 43 02 00 00       	jmp    100824 <debuginfo_eip+0x31a>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  1005e1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1005e4:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1005e7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1005ea:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  1005ed:	8b 45 08             	mov    0x8(%ebp),%eax
  1005f0:	89 44 24 10          	mov    %eax,0x10(%esp)
  1005f4:	c7 44 24 0c 24 00 00 	movl   $0x24,0xc(%esp)
  1005fb:	00 
  1005fc:	8d 45 d8             	lea    -0x28(%ebp),%eax
  1005ff:	89 44 24 08          	mov    %eax,0x8(%esp)
  100603:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100606:	89 44 24 04          	mov    %eax,0x4(%esp)
  10060a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10060d:	89 04 24             	mov    %eax,(%esp)
  100610:	e8 af fd ff ff       	call   1003c4 <stab_binsearch>

    if (lfun <= rfun) {
  100615:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100618:	8b 45 d8             	mov    -0x28(%ebp),%eax
  10061b:	39 c2                	cmp    %eax,%edx
  10061d:	7f 72                	jg     100691 <debuginfo_eip+0x187>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  10061f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100622:	89 c2                	mov    %eax,%edx
  100624:	89 d0                	mov    %edx,%eax
  100626:	01 c0                	add    %eax,%eax
  100628:	01 d0                	add    %edx,%eax
  10062a:	c1 e0 02             	shl    $0x2,%eax
  10062d:	03 45 f4             	add    -0xc(%ebp),%eax
  100630:	8b 10                	mov    (%eax),%edx
  100632:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  100635:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100638:	89 cb                	mov    %ecx,%ebx
  10063a:	29 c3                	sub    %eax,%ebx
  10063c:	89 d8                	mov    %ebx,%eax
  10063e:	39 c2                	cmp    %eax,%edx
  100640:	73 1e                	jae    100660 <debuginfo_eip+0x156>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  100642:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100645:	89 c2                	mov    %eax,%edx
  100647:	89 d0                	mov    %edx,%eax
  100649:	01 c0                	add    %eax,%eax
  10064b:	01 d0                	add    %edx,%eax
  10064d:	c1 e0 02             	shl    $0x2,%eax
  100650:	03 45 f4             	add    -0xc(%ebp),%eax
  100653:	8b 00                	mov    (%eax),%eax
  100655:	89 c2                	mov    %eax,%edx
  100657:	03 55 ec             	add    -0x14(%ebp),%edx
  10065a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10065d:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  100660:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100663:	89 c2                	mov    %eax,%edx
  100665:	89 d0                	mov    %edx,%eax
  100667:	01 c0                	add    %eax,%eax
  100669:	01 d0                	add    %edx,%eax
  10066b:	c1 e0 02             	shl    $0x2,%eax
  10066e:	03 45 f4             	add    -0xc(%ebp),%eax
  100671:	8b 50 08             	mov    0x8(%eax),%edx
  100674:	8b 45 0c             	mov    0xc(%ebp),%eax
  100677:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  10067a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10067d:	8b 40 10             	mov    0x10(%eax),%eax
  100680:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  100683:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100686:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  100689:	8b 45 d8             	mov    -0x28(%ebp),%eax
  10068c:	89 45 d0             	mov    %eax,-0x30(%ebp)
  10068f:	eb 15                	jmp    1006a6 <debuginfo_eip+0x19c>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  100691:	8b 45 0c             	mov    0xc(%ebp),%eax
  100694:	8b 55 08             	mov    0x8(%ebp),%edx
  100697:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  10069a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10069d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  1006a0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1006a3:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  1006a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006a9:	8b 40 08             	mov    0x8(%eax),%eax
  1006ac:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
  1006b3:	00 
  1006b4:	89 04 24             	mov    %eax,(%esp)
  1006b7:	e8 23 29 00 00       	call   102fdf <strfind>
  1006bc:	89 c2                	mov    %eax,%edx
  1006be:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006c1:	8b 40 08             	mov    0x8(%eax),%eax
  1006c4:	29 c2                	sub    %eax,%edx
  1006c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006c9:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  1006cc:	8b 45 08             	mov    0x8(%ebp),%eax
  1006cf:	89 44 24 10          	mov    %eax,0x10(%esp)
  1006d3:	c7 44 24 0c 44 00 00 	movl   $0x44,0xc(%esp)
  1006da:	00 
  1006db:	8d 45 d0             	lea    -0x30(%ebp),%eax
  1006de:	89 44 24 08          	mov    %eax,0x8(%esp)
  1006e2:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  1006e5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1006e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006ec:	89 04 24             	mov    %eax,(%esp)
  1006ef:	e8 d0 fc ff ff       	call   1003c4 <stab_binsearch>
    if (lline <= rline) {
  1006f4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1006f7:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1006fa:	39 c2                	cmp    %eax,%edx
  1006fc:	7f 20                	jg     10071e <debuginfo_eip+0x214>
        info->eip_line = stabs[rline].n_desc;
  1006fe:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100701:	89 c2                	mov    %eax,%edx
  100703:	89 d0                	mov    %edx,%eax
  100705:	01 c0                	add    %eax,%eax
  100707:	01 d0                	add    %edx,%eax
  100709:	c1 e0 02             	shl    $0x2,%eax
  10070c:	03 45 f4             	add    -0xc(%ebp),%eax
  10070f:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  100713:	0f b7 d0             	movzwl %ax,%edx
  100716:	8b 45 0c             	mov    0xc(%ebp),%eax
  100719:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  10071c:	eb 13                	jmp    100731 <debuginfo_eip+0x227>
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
    if (lline <= rline) {
        info->eip_line = stabs[rline].n_desc;
    } else {
        return -1;
  10071e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100723:	e9 fc 00 00 00       	jmp    100824 <debuginfo_eip+0x31a>
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  100728:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10072b:	83 e8 01             	sub    $0x1,%eax
  10072e:	89 45 d4             	mov    %eax,-0x2c(%ebp)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  100731:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100734:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100737:	39 c2                	cmp    %eax,%edx
  100739:	7c 4a                	jl     100785 <debuginfo_eip+0x27b>
           && stabs[lline].n_type != N_SOL
  10073b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10073e:	89 c2                	mov    %eax,%edx
  100740:	89 d0                	mov    %edx,%eax
  100742:	01 c0                	add    %eax,%eax
  100744:	01 d0                	add    %edx,%eax
  100746:	c1 e0 02             	shl    $0x2,%eax
  100749:	03 45 f4             	add    -0xc(%ebp),%eax
  10074c:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100750:	3c 84                	cmp    $0x84,%al
  100752:	74 31                	je     100785 <debuginfo_eip+0x27b>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  100754:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100757:	89 c2                	mov    %eax,%edx
  100759:	89 d0                	mov    %edx,%eax
  10075b:	01 c0                	add    %eax,%eax
  10075d:	01 d0                	add    %edx,%eax
  10075f:	c1 e0 02             	shl    $0x2,%eax
  100762:	03 45 f4             	add    -0xc(%ebp),%eax
  100765:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100769:	3c 64                	cmp    $0x64,%al
  10076b:	75 bb                	jne    100728 <debuginfo_eip+0x21e>
  10076d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100770:	89 c2                	mov    %eax,%edx
  100772:	89 d0                	mov    %edx,%eax
  100774:	01 c0                	add    %eax,%eax
  100776:	01 d0                	add    %edx,%eax
  100778:	c1 e0 02             	shl    $0x2,%eax
  10077b:	03 45 f4             	add    -0xc(%ebp),%eax
  10077e:	8b 40 08             	mov    0x8(%eax),%eax
  100781:	85 c0                	test   %eax,%eax
  100783:	74 a3                	je     100728 <debuginfo_eip+0x21e>
        lline --;
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  100785:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100788:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10078b:	39 c2                	cmp    %eax,%edx
  10078d:	7c 40                	jl     1007cf <debuginfo_eip+0x2c5>
  10078f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100792:	89 c2                	mov    %eax,%edx
  100794:	89 d0                	mov    %edx,%eax
  100796:	01 c0                	add    %eax,%eax
  100798:	01 d0                	add    %edx,%eax
  10079a:	c1 e0 02             	shl    $0x2,%eax
  10079d:	03 45 f4             	add    -0xc(%ebp),%eax
  1007a0:	8b 10                	mov    (%eax),%edx
  1007a2:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  1007a5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1007a8:	89 cb                	mov    %ecx,%ebx
  1007aa:	29 c3                	sub    %eax,%ebx
  1007ac:	89 d8                	mov    %ebx,%eax
  1007ae:	39 c2                	cmp    %eax,%edx
  1007b0:	73 1d                	jae    1007cf <debuginfo_eip+0x2c5>
        info->eip_file = stabstr + stabs[lline].n_strx;
  1007b2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007b5:	89 c2                	mov    %eax,%edx
  1007b7:	89 d0                	mov    %edx,%eax
  1007b9:	01 c0                	add    %eax,%eax
  1007bb:	01 d0                	add    %edx,%eax
  1007bd:	c1 e0 02             	shl    $0x2,%eax
  1007c0:	03 45 f4             	add    -0xc(%ebp),%eax
  1007c3:	8b 00                	mov    (%eax),%eax
  1007c5:	89 c2                	mov    %eax,%edx
  1007c7:	03 55 ec             	add    -0x14(%ebp),%edx
  1007ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007cd:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  1007cf:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1007d2:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1007d5:	39 c2                	cmp    %eax,%edx
  1007d7:	7d 46                	jge    10081f <debuginfo_eip+0x315>
        for (lline = lfun + 1;
  1007d9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1007dc:	83 c0 01             	add    $0x1,%eax
  1007df:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  1007e2:	eb 18                	jmp    1007fc <debuginfo_eip+0x2f2>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  1007e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007e7:	8b 40 14             	mov    0x14(%eax),%eax
  1007ea:	8d 50 01             	lea    0x1(%eax),%edx
  1007ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007f0:	89 50 14             	mov    %edx,0x14(%eax)
    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
  1007f3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007f6:	83 c0 01             	add    $0x1,%eax
  1007f9:	89 45 d4             	mov    %eax,-0x2c(%ebp)

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
             lline < rfun && stabs[lline].n_type == N_PSYM;
  1007fc:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1007ff:	8b 45 d8             	mov    -0x28(%ebp),%eax
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
  100802:	39 c2                	cmp    %eax,%edx
  100804:	7d 19                	jge    10081f <debuginfo_eip+0x315>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100806:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100809:	89 c2                	mov    %eax,%edx
  10080b:	89 d0                	mov    %edx,%eax
  10080d:	01 c0                	add    %eax,%eax
  10080f:	01 d0                	add    %edx,%eax
  100811:	c1 e0 02             	shl    $0x2,%eax
  100814:	03 45 f4             	add    -0xc(%ebp),%eax
  100817:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10081b:	3c a0                	cmp    $0xa0,%al
  10081d:	74 c5                	je     1007e4 <debuginfo_eip+0x2da>
             lline ++) {
            info->eip_fn_narg ++;
        }
    }
    return 0;
  10081f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100824:	83 c4 54             	add    $0x54,%esp
  100827:	5b                   	pop    %ebx
  100828:	5d                   	pop    %ebp
  100829:	c3                   	ret    

0010082a <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  10082a:	55                   	push   %ebp
  10082b:	89 e5                	mov    %esp,%ebp
  10082d:	83 ec 18             	sub    $0x18,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  100830:	c7 04 24 d6 33 10 00 	movl   $0x1033d6,(%esp)
  100837:	e8 df fa ff ff       	call   10031b <cprintf>
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  10083c:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  100843:	00 
  100844:	c7 04 24 ef 33 10 00 	movl   $0x1033ef,(%esp)
  10084b:	e8 cb fa ff ff       	call   10031b <cprintf>
    cprintf("  etext  0x%08x (phys)\n", etext);
  100850:	c7 44 24 04 1f 33 10 	movl   $0x10331f,0x4(%esp)
  100857:	00 
  100858:	c7 04 24 07 34 10 00 	movl   $0x103407,(%esp)
  10085f:	e8 b7 fa ff ff       	call   10031b <cprintf>
    cprintf("  edata  0x%08x (phys)\n", edata);
  100864:	c7 44 24 04 18 ea 10 	movl   $0x10ea18,0x4(%esp)
  10086b:	00 
  10086c:	c7 04 24 1f 34 10 00 	movl   $0x10341f,(%esp)
  100873:	e8 a3 fa ff ff       	call   10031b <cprintf>
    cprintf("  end    0x%08x (phys)\n", end);
  100878:	c7 44 24 04 20 fd 10 	movl   $0x10fd20,0x4(%esp)
  10087f:	00 
  100880:	c7 04 24 37 34 10 00 	movl   $0x103437,(%esp)
  100887:	e8 8f fa ff ff       	call   10031b <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  10088c:	b8 20 fd 10 00       	mov    $0x10fd20,%eax
  100891:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  100897:	b8 00 00 10 00       	mov    $0x100000,%eax
  10089c:	89 d1                	mov    %edx,%ecx
  10089e:	29 c1                	sub    %eax,%ecx
  1008a0:	89 c8                	mov    %ecx,%eax
  1008a2:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1008a8:	85 c0                	test   %eax,%eax
  1008aa:	0f 48 c2             	cmovs  %edx,%eax
  1008ad:	c1 f8 0a             	sar    $0xa,%eax
  1008b0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008b4:	c7 04 24 50 34 10 00 	movl   $0x103450,(%esp)
  1008bb:	e8 5b fa ff ff       	call   10031b <cprintf>
}
  1008c0:	c9                   	leave  
  1008c1:	c3                   	ret    

001008c2 <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  1008c2:	55                   	push   %ebp
  1008c3:	89 e5                	mov    %esp,%ebp
  1008c5:	81 ec 48 01 00 00    	sub    $0x148,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  1008cb:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1008ce:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008d2:	8b 45 08             	mov    0x8(%ebp),%eax
  1008d5:	89 04 24             	mov    %eax,(%esp)
  1008d8:	e8 2d fc ff ff       	call   10050a <debuginfo_eip>
  1008dd:	85 c0                	test   %eax,%eax
  1008df:	74 15                	je     1008f6 <print_debuginfo+0x34>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  1008e1:	8b 45 08             	mov    0x8(%ebp),%eax
  1008e4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008e8:	c7 04 24 7a 34 10 00 	movl   $0x10347a,(%esp)
  1008ef:	e8 27 fa ff ff       	call   10031b <cprintf>
  1008f4:	eb 69                	jmp    10095f <print_debuginfo+0x9d>
    }
    else {
        char fnname[256];
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  1008f6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1008fd:	eb 1a                	jmp    100919 <print_debuginfo+0x57>
            fnname[j] = info.eip_fn_name[j];
  1008ff:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  100902:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100905:	01 d0                	add    %edx,%eax
  100907:	0f b6 10             	movzbl (%eax),%edx
  10090a:	8d 85 dc fe ff ff    	lea    -0x124(%ebp),%eax
  100910:	03 45 f4             	add    -0xc(%ebp),%eax
  100913:	88 10                	mov    %dl,(%eax)
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
    }
    else {
        char fnname[256];
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100915:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100919:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10091c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  10091f:	7f de                	jg     1008ff <print_debuginfo+0x3d>
            fnname[j] = info.eip_fn_name[j];
        }
        fnname[j] = '\0';
  100921:	8d 85 dc fe ff ff    	lea    -0x124(%ebp),%eax
  100927:	03 45 f4             	add    -0xc(%ebp),%eax
  10092a:	c6 00 00             	movb   $0x0,(%eax)
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
  10092d:	8b 45 ec             	mov    -0x14(%ebp),%eax
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
            fnname[j] = info.eip_fn_name[j];
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  100930:	8b 55 08             	mov    0x8(%ebp),%edx
  100933:	89 d1                	mov    %edx,%ecx
  100935:	29 c1                	sub    %eax,%ecx
  100937:	8b 55 e0             	mov    -0x20(%ebp),%edx
  10093a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10093d:	89 4c 24 10          	mov    %ecx,0x10(%esp)
                fnname, eip - info.eip_fn_addr);
  100941:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100947:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
            fnname[j] = info.eip_fn_name[j];
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  10094b:	89 54 24 08          	mov    %edx,0x8(%esp)
  10094f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100953:	c7 04 24 96 34 10 00 	movl   $0x103496,(%esp)
  10095a:	e8 bc f9 ff ff       	call   10031b <cprintf>
                fnname, eip - info.eip_fn_addr);
    }
}
  10095f:	c9                   	leave  
  100960:	c3                   	ret    

00100961 <read_eip>:

static __noinline uint32_t
read_eip(void) {
  100961:	55                   	push   %ebp
  100962:	89 e5                	mov    %esp,%ebp
  100964:	53                   	push   %ebx
  100965:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100968:	8b 5d 04             	mov    0x4(%ebp),%ebx
  10096b:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    return eip;
  10096e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  100971:	83 c4 10             	add    $0x10,%esp
  100974:	5b                   	pop    %ebx
  100975:	5d                   	pop    %ebp
  100976:	c3                   	ret    

00100977 <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100977:	55                   	push   %ebp
  100978:	89 e5                	mov    %esp,%ebp
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
}
  10097a:	5d                   	pop    %ebp
  10097b:	c3                   	ret    

0010097c <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  10097c:	55                   	push   %ebp
  10097d:	89 e5                	mov    %esp,%ebp
  10097f:	83 ec 28             	sub    $0x28,%esp
    int argc = 0;
  100982:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100989:	eb 0d                	jmp    100998 <parse+0x1c>
        }
        argv[argc ++] = buf;
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
            buf ++;
        }
    }
  10098b:	90                   	nop
static int
parse(char *buf, char **argv) {
    int argc = 0;
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  10098c:	eb 0a                	jmp    100998 <parse+0x1c>
            *buf ++ = '\0';
  10098e:	8b 45 08             	mov    0x8(%ebp),%eax
  100991:	c6 00 00             	movb   $0x0,(%eax)
  100994:	83 45 08 01          	addl   $0x1,0x8(%ebp)
static int
parse(char *buf, char **argv) {
    int argc = 0;
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100998:	8b 45 08             	mov    0x8(%ebp),%eax
  10099b:	0f b6 00             	movzbl (%eax),%eax
  10099e:	84 c0                	test   %al,%al
  1009a0:	74 1d                	je     1009bf <parse+0x43>
  1009a2:	8b 45 08             	mov    0x8(%ebp),%eax
  1009a5:	0f b6 00             	movzbl (%eax),%eax
  1009a8:	0f be c0             	movsbl %al,%eax
  1009ab:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009af:	c7 04 24 28 35 10 00 	movl   $0x103528,(%esp)
  1009b6:	e8 f1 25 00 00       	call   102fac <strchr>
  1009bb:	85 c0                	test   %eax,%eax
  1009bd:	75 cf                	jne    10098e <parse+0x12>
            *buf ++ = '\0';
        }
        if (*buf == '\0') {
  1009bf:	8b 45 08             	mov    0x8(%ebp),%eax
  1009c2:	0f b6 00             	movzbl (%eax),%eax
  1009c5:	84 c0                	test   %al,%al
  1009c7:	74 5e                	je     100a27 <parse+0xab>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  1009c9:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  1009cd:	75 14                	jne    1009e3 <parse+0x67>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  1009cf:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  1009d6:	00 
  1009d7:	c7 04 24 2d 35 10 00 	movl   $0x10352d,(%esp)
  1009de:	e8 38 f9 ff ff       	call   10031b <cprintf>
        }
        argv[argc ++] = buf;
  1009e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009e6:	c1 e0 02             	shl    $0x2,%eax
  1009e9:	03 45 0c             	add    0xc(%ebp),%eax
  1009ec:	8b 55 08             	mov    0x8(%ebp),%edx
  1009ef:	89 10                	mov    %edx,(%eax)
  1009f1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  1009f5:	eb 04                	jmp    1009fb <parse+0x7f>
            buf ++;
  1009f7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        // save and scan past next arg
        if (argc == MAXARGS - 1) {
            cprintf("Too many arguments (max %d).\n", MAXARGS);
        }
        argv[argc ++] = buf;
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  1009fb:	8b 45 08             	mov    0x8(%ebp),%eax
  1009fe:	0f b6 00             	movzbl (%eax),%eax
  100a01:	84 c0                	test   %al,%al
  100a03:	74 86                	je     10098b <parse+0xf>
  100a05:	8b 45 08             	mov    0x8(%ebp),%eax
  100a08:	0f b6 00             	movzbl (%eax),%eax
  100a0b:	0f be c0             	movsbl %al,%eax
  100a0e:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a12:	c7 04 24 28 35 10 00 	movl   $0x103528,(%esp)
  100a19:	e8 8e 25 00 00       	call   102fac <strchr>
  100a1e:	85 c0                	test   %eax,%eax
  100a20:	74 d5                	je     1009f7 <parse+0x7b>
            buf ++;
        }
    }
  100a22:	e9 64 ff ff ff       	jmp    10098b <parse+0xf>
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
            *buf ++ = '\0';
        }
        if (*buf == '\0') {
            break;
  100a27:	90                   	nop
        argv[argc ++] = buf;
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
            buf ++;
        }
    }
    return argc;
  100a28:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100a2b:	c9                   	leave  
  100a2c:	c3                   	ret    

00100a2d <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100a2d:	55                   	push   %ebp
  100a2e:	89 e5                	mov    %esp,%ebp
  100a30:	83 ec 68             	sub    $0x68,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100a33:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100a36:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a3a:	8b 45 08             	mov    0x8(%ebp),%eax
  100a3d:	89 04 24             	mov    %eax,(%esp)
  100a40:	e8 37 ff ff ff       	call   10097c <parse>
  100a45:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100a48:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100a4c:	75 0a                	jne    100a58 <runcmd+0x2b>
        return 0;
  100a4e:	b8 00 00 00 00       	mov    $0x0,%eax
  100a53:	e9 85 00 00 00       	jmp    100add <runcmd+0xb0>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100a58:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100a5f:	eb 5c                	jmp    100abd <runcmd+0x90>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100a61:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100a64:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100a67:	89 d0                	mov    %edx,%eax
  100a69:	01 c0                	add    %eax,%eax
  100a6b:	01 d0                	add    %edx,%eax
  100a6d:	c1 e0 02             	shl    $0x2,%eax
  100a70:	05 00 e0 10 00       	add    $0x10e000,%eax
  100a75:	8b 00                	mov    (%eax),%eax
  100a77:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100a7b:	89 04 24             	mov    %eax,(%esp)
  100a7e:	e8 84 24 00 00       	call   102f07 <strcmp>
  100a83:	85 c0                	test   %eax,%eax
  100a85:	75 32                	jne    100ab9 <runcmd+0x8c>
            return commands[i].func(argc - 1, argv + 1, tf);
  100a87:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100a8a:	89 d0                	mov    %edx,%eax
  100a8c:	01 c0                	add    %eax,%eax
  100a8e:	01 d0                	add    %edx,%eax
  100a90:	c1 e0 02             	shl    $0x2,%eax
  100a93:	05 00 e0 10 00       	add    $0x10e000,%eax
  100a98:	8b 50 08             	mov    0x8(%eax),%edx
  100a9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100a9e:	8d 48 ff             	lea    -0x1(%eax),%ecx
  100aa1:	8b 45 0c             	mov    0xc(%ebp),%eax
  100aa4:	89 44 24 08          	mov    %eax,0x8(%esp)
  100aa8:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100aab:	83 c0 04             	add    $0x4,%eax
  100aae:	89 44 24 04          	mov    %eax,0x4(%esp)
  100ab2:	89 0c 24             	mov    %ecx,(%esp)
  100ab5:	ff d2                	call   *%edx
  100ab7:	eb 24                	jmp    100add <runcmd+0xb0>
    int argc = parse(buf, argv);
    if (argc == 0) {
        return 0;
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100ab9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100abd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ac0:	83 f8 02             	cmp    $0x2,%eax
  100ac3:	76 9c                	jbe    100a61 <runcmd+0x34>
        if (strcmp(commands[i].name, argv[0]) == 0) {
            return commands[i].func(argc - 1, argv + 1, tf);
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100ac5:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100ac8:	89 44 24 04          	mov    %eax,0x4(%esp)
  100acc:	c7 04 24 4b 35 10 00 	movl   $0x10354b,(%esp)
  100ad3:	e8 43 f8 ff ff       	call   10031b <cprintf>
    return 0;
  100ad8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100add:	c9                   	leave  
  100ade:	c3                   	ret    

00100adf <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100adf:	55                   	push   %ebp
  100ae0:	89 e5                	mov    %esp,%ebp
  100ae2:	83 ec 28             	sub    $0x28,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100ae5:	c7 04 24 64 35 10 00 	movl   $0x103564,(%esp)
  100aec:	e8 2a f8 ff ff       	call   10031b <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
  100af1:	c7 04 24 8c 35 10 00 	movl   $0x10358c,(%esp)
  100af8:	e8 1e f8 ff ff       	call   10031b <cprintf>

    if (tf != NULL) {
  100afd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100b01:	74 0e                	je     100b11 <kmonitor+0x32>
        print_trapframe(tf);
  100b03:	8b 45 08             	mov    0x8(%ebp),%eax
  100b06:	89 04 24             	mov    %eax,(%esp)
  100b09:	e8 12 0d 00 00       	call   101820 <print_trapframe>
  100b0e:	eb 01                	jmp    100b11 <kmonitor+0x32>
        if ((buf = readline("K> ")) != NULL) {
            if (runcmd(buf, tf) < 0) {
                break;
            }
        }
    }
  100b10:	90                   	nop
        print_trapframe(tf);
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100b11:	c7 04 24 b1 35 10 00 	movl   $0x1035b1,(%esp)
  100b18:	e8 ef f6 ff ff       	call   10020c <readline>
  100b1d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100b20:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100b24:	74 ea                	je     100b10 <kmonitor+0x31>
            if (runcmd(buf, tf) < 0) {
  100b26:	8b 45 08             	mov    0x8(%ebp),%eax
  100b29:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b30:	89 04 24             	mov    %eax,(%esp)
  100b33:	e8 f5 fe ff ff       	call   100a2d <runcmd>
  100b38:	85 c0                	test   %eax,%eax
  100b3a:	79 d4                	jns    100b10 <kmonitor+0x31>
                break;
  100b3c:	90                   	nop
            }
        }
    }
}
  100b3d:	c9                   	leave  
  100b3e:	c3                   	ret    

00100b3f <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100b3f:	55                   	push   %ebp
  100b40:	89 e5                	mov    %esp,%ebp
  100b42:	83 ec 28             	sub    $0x28,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100b45:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100b4c:	eb 3f                	jmp    100b8d <mon_help+0x4e>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100b4e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100b51:	89 d0                	mov    %edx,%eax
  100b53:	01 c0                	add    %eax,%eax
  100b55:	01 d0                	add    %edx,%eax
  100b57:	c1 e0 02             	shl    $0x2,%eax
  100b5a:	05 00 e0 10 00       	add    $0x10e000,%eax
  100b5f:	8b 48 04             	mov    0x4(%eax),%ecx
  100b62:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100b65:	89 d0                	mov    %edx,%eax
  100b67:	01 c0                	add    %eax,%eax
  100b69:	01 d0                	add    %edx,%eax
  100b6b:	c1 e0 02             	shl    $0x2,%eax
  100b6e:	05 00 e0 10 00       	add    $0x10e000,%eax
  100b73:	8b 00                	mov    (%eax),%eax
  100b75:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100b79:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b7d:	c7 04 24 b5 35 10 00 	movl   $0x1035b5,(%esp)
  100b84:	e8 92 f7 ff ff       	call   10031b <cprintf>

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100b89:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100b8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b90:	83 f8 02             	cmp    $0x2,%eax
  100b93:	76 b9                	jbe    100b4e <mon_help+0xf>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
    }
    return 0;
  100b95:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100b9a:	c9                   	leave  
  100b9b:	c3                   	ret    

00100b9c <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100b9c:	55                   	push   %ebp
  100b9d:	89 e5                	mov    %esp,%ebp
  100b9f:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100ba2:	e8 83 fc ff ff       	call   10082a <print_kerninfo>
    return 0;
  100ba7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100bac:	c9                   	leave  
  100bad:	c3                   	ret    

00100bae <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100bae:	55                   	push   %ebp
  100baf:	89 e5                	mov    %esp,%ebp
  100bb1:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100bb4:	e8 be fd ff ff       	call   100977 <print_stackframe>
    return 0;
  100bb9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100bbe:	c9                   	leave  
  100bbf:	c3                   	ret    

00100bc0 <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  100bc0:	55                   	push   %ebp
  100bc1:	89 e5                	mov    %esp,%ebp
  100bc3:	83 ec 28             	sub    $0x28,%esp
    if (is_panic) {
  100bc6:	a1 40 ee 10 00       	mov    0x10ee40,%eax
  100bcb:	85 c0                	test   %eax,%eax
  100bcd:	75 4c                	jne    100c1b <__panic+0x5b>
        goto panic_dead;
    }
    is_panic = 1;
  100bcf:	c7 05 40 ee 10 00 01 	movl   $0x1,0x10ee40
  100bd6:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  100bd9:	8d 55 14             	lea    0x14(%ebp),%edx
  100bdc:	8d 45 f4             	lea    -0xc(%ebp),%eax
  100bdf:	89 10                	mov    %edx,(%eax)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  100be1:	8b 45 0c             	mov    0xc(%ebp),%eax
  100be4:	89 44 24 08          	mov    %eax,0x8(%esp)
  100be8:	8b 45 08             	mov    0x8(%ebp),%eax
  100beb:	89 44 24 04          	mov    %eax,0x4(%esp)
  100bef:	c7 04 24 be 35 10 00 	movl   $0x1035be,(%esp)
  100bf6:	e8 20 f7 ff ff       	call   10031b <cprintf>
    vcprintf(fmt, ap);
  100bfb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100bfe:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c02:	8b 45 10             	mov    0x10(%ebp),%eax
  100c05:	89 04 24             	mov    %eax,(%esp)
  100c08:	e8 db f6 ff ff       	call   1002e8 <vcprintf>
    cprintf("\n");
  100c0d:	c7 04 24 da 35 10 00 	movl   $0x1035da,(%esp)
  100c14:	e8 02 f7 ff ff       	call   10031b <cprintf>
  100c19:	eb 01                	jmp    100c1c <__panic+0x5c>
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
    if (is_panic) {
        goto panic_dead;
  100c1b:	90                   	nop
    vcprintf(fmt, ap);
    cprintf("\n");
    va_end(ap);

panic_dead:
    intr_disable();
  100c1c:	e8 c9 09 00 00       	call   1015ea <intr_disable>
    while (1) {
        kmonitor(NULL);
  100c21:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100c28:	e8 b2 fe ff ff       	call   100adf <kmonitor>
    }
  100c2d:	eb f2                	jmp    100c21 <__panic+0x61>

00100c2f <__warn>:
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  100c2f:	55                   	push   %ebp
  100c30:	89 e5                	mov    %esp,%ebp
  100c32:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    va_start(ap, fmt);
  100c35:	8d 55 14             	lea    0x14(%ebp),%edx
  100c38:	8d 45 f4             	lea    -0xc(%ebp),%eax
  100c3b:	89 10                	mov    %edx,(%eax)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  100c3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100c40:	89 44 24 08          	mov    %eax,0x8(%esp)
  100c44:	8b 45 08             	mov    0x8(%ebp),%eax
  100c47:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c4b:	c7 04 24 dc 35 10 00 	movl   $0x1035dc,(%esp)
  100c52:	e8 c4 f6 ff ff       	call   10031b <cprintf>
    vcprintf(fmt, ap);
  100c57:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c5a:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c5e:	8b 45 10             	mov    0x10(%ebp),%eax
  100c61:	89 04 24             	mov    %eax,(%esp)
  100c64:	e8 7f f6 ff ff       	call   1002e8 <vcprintf>
    cprintf("\n");
  100c69:	c7 04 24 da 35 10 00 	movl   $0x1035da,(%esp)
  100c70:	e8 a6 f6 ff ff       	call   10031b <cprintf>
    va_end(ap);
}
  100c75:	c9                   	leave  
  100c76:	c3                   	ret    

00100c77 <is_kernel_panic>:

bool
is_kernel_panic(void) {
  100c77:	55                   	push   %ebp
  100c78:	89 e5                	mov    %esp,%ebp
    return is_panic;
  100c7a:	a1 40 ee 10 00       	mov    0x10ee40,%eax
}
  100c7f:	5d                   	pop    %ebp
  100c80:	c3                   	ret    
  100c81:	00 00                	add    %al,(%eax)
	...

00100c84 <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100c84:	55                   	push   %ebp
  100c85:	89 e5                	mov    %esp,%ebp
  100c87:	83 ec 28             	sub    $0x28,%esp
  100c8a:	66 c7 45 f6 43 00    	movw   $0x43,-0xa(%ebp)
  100c90:	c6 45 f5 34          	movb   $0x34,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100c94:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100c98:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100c9c:	ee                   	out    %al,(%dx)
  100c9d:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100ca3:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
  100ca7:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100cab:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100caf:	ee                   	out    %al,(%dx)
  100cb0:	66 c7 45 ee 40 00    	movw   $0x40,-0x12(%ebp)
  100cb6:	c6 45 ed 2e          	movb   $0x2e,-0x13(%ebp)
  100cba:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100cbe:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100cc2:	ee                   	out    %al,(%dx)
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100cc3:	c7 05 08 f9 10 00 00 	movl   $0x0,0x10f908
  100cca:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100ccd:	c7 04 24 fa 35 10 00 	movl   $0x1035fa,(%esp)
  100cd4:	e8 42 f6 ff ff       	call   10031b <cprintf>
    pic_enable(IRQ_TIMER);
  100cd9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100ce0:	e8 63 09 00 00       	call   101648 <pic_enable>
}
  100ce5:	c9                   	leave  
  100ce6:	c3                   	ret    
	...

00100ce8 <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100ce8:	55                   	push   %ebp
  100ce9:	89 e5                	mov    %esp,%ebp
  100ceb:	53                   	push   %ebx
  100cec:	83 ec 14             	sub    $0x14,%esp
  100cef:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100cf5:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100cf9:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  100cfd:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100d01:	ec                   	in     (%dx),%al
  100d02:	89 c3                	mov    %eax,%ebx
  100d04:	88 5d f9             	mov    %bl,-0x7(%ebp)
    return data;
  100d07:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100d0d:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100d11:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  100d15:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100d19:	ec                   	in     (%dx),%al
  100d1a:	89 c3                	mov    %eax,%ebx
  100d1c:	88 5d f5             	mov    %bl,-0xb(%ebp)
    return data;
  100d1f:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100d25:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100d29:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  100d2d:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100d31:	ec                   	in     (%dx),%al
  100d32:	89 c3                	mov    %eax,%ebx
  100d34:	88 5d f1             	mov    %bl,-0xf(%ebp)
    return data;
  100d37:	66 c7 45 ee 84 00    	movw   $0x84,-0x12(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100d3d:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100d41:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  100d45:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100d49:	ec                   	in     (%dx),%al
  100d4a:	89 c3                	mov    %eax,%ebx
  100d4c:	88 5d ed             	mov    %bl,-0x13(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100d4f:	83 c4 14             	add    $0x14,%esp
  100d52:	5b                   	pop    %ebx
  100d53:	5d                   	pop    %ebp
  100d54:	c3                   	ret    

00100d55 <cga_init>:
//    -- 数据寄存器 映射 到 端口 0x3D5或0x3B5 
//    -- 索引寄存器 0x3D4或0x3B4,决定在数据寄存器中的数据表示什么。

/* TEXT-mode CGA/VGA display output */
static void
cga_init(void) {
  100d55:	55                   	push   %ebp
  100d56:	89 e5                	mov    %esp,%ebp
  100d58:	53                   	push   %ebx
  100d59:	83 ec 24             	sub    $0x24,%esp
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;   //CGA_BUF: 0xB8000 (彩色显示的显存物理基址)
  100d5c:	c7 45 f8 00 80 0b 00 	movl   $0xb8000,-0x8(%ebp)
    uint16_t was = *cp;                                            //保存当前显存0xB8000处的值
  100d63:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100d66:	0f b7 00             	movzwl (%eax),%eax
  100d69:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
    *cp = (uint16_t) 0xA55A;                                   // 给这个地址随便写个值，看看能否再读出同样的值
  100d6d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100d70:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {                                            // 如果读不出来，说明没有这块显存，即是单显配置
  100d75:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100d78:	0f b7 00             	movzwl (%eax),%eax
  100d7b:	66 3d 5a a5          	cmp    $0xa55a,%ax
  100d7f:	74 12                	je     100d93 <cga_init+0x3e>
        cp = (uint16_t*)MONO_BUF;                         //设置为单显的显存基址 MONO_BUF： 0xB0000
  100d81:	c7 45 f8 00 00 0b 00 	movl   $0xb0000,-0x8(%ebp)
        addr_6845 = MONO_BASE;                           //设置为单显控制的IO地址，MONO_BASE: 0x3B4
  100d88:	66 c7 05 66 ee 10 00 	movw   $0x3b4,0x10ee66
  100d8f:	b4 03 
  100d91:	eb 13                	jmp    100da6 <cga_init+0x51>
    } else {                                                                // 如果读出来了，有这块显存，即是彩显配置
        *cp = was;                                                      //还原原来显存位置的值
  100d93:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100d96:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100d9a:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;                               // 设置为彩显控制的IO地址，CGA_BASE: 0x3D4 
  100d9d:	66 c7 05 66 ee 10 00 	movw   $0x3d4,0x10ee66
  100da4:	d4 03 
    // Extract cursor location
    // 6845索引寄存器的index 0x0E（及十进制的14）== 光标位置(高位)
    // 6845索引寄存器的index 0x0F（及十进制的15）== 光标位置(低位)
    // 6845 reg 15 : Cursor Address (Low Byte)
    uint32_t pos;
    outb(addr_6845, 14);                                        
  100da6:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100dad:	0f b7 c0             	movzwl %ax,%eax
  100db0:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  100db4:	c6 45 ed 0e          	movb   $0xe,-0x13(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100db8:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100dbc:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100dc0:	ee                   	out    %al,(%dx)
    pos = inb(addr_6845 + 1) << 8;                       //读出了光标位置(高位)
  100dc1:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100dc8:	83 c0 01             	add    $0x1,%eax
  100dcb:	0f b7 c0             	movzwl %ax,%eax
  100dce:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100dd2:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100dd6:	66 89 55 da          	mov    %dx,-0x26(%ebp)
  100dda:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  100dde:	ec                   	in     (%dx),%al
  100ddf:	89 c3                	mov    %eax,%ebx
  100de1:	88 5d e9             	mov    %bl,-0x17(%ebp)
    return data;
  100de4:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100de8:	0f b6 c0             	movzbl %al,%eax
  100deb:	c1 e0 08             	shl    $0x8,%eax
  100dee:	89 45 f0             	mov    %eax,-0x10(%ebp)
    outb(addr_6845, 15);
  100df1:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100df8:	0f b7 c0             	movzwl %ax,%eax
  100dfb:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  100dff:	c6 45 e5 0f          	movb   $0xf,-0x1b(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100e03:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100e07:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100e0b:	ee                   	out    %al,(%dx)
    pos |= inb(addr_6845 + 1);                             //读出了光标位置(低位)
  100e0c:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100e13:	83 c0 01             	add    $0x1,%eax
  100e16:	0f b7 c0             	movzwl %ax,%eax
  100e19:	66 89 45 e2          	mov    %ax,-0x1e(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100e1d:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  100e21:	66 89 55 da          	mov    %dx,-0x26(%ebp)
  100e25:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  100e29:	ec                   	in     (%dx),%al
  100e2a:	89 c3                	mov    %eax,%ebx
  100e2c:	88 5d e1             	mov    %bl,-0x1f(%ebp)
    return data;
  100e2f:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  100e33:	0f b6 c0             	movzbl %al,%eax
  100e36:	09 45 f0             	or     %eax,-0x10(%ebp)

    crt_buf = (uint16_t*) cp;                                  //crt_buf是CGA显存起始地址
  100e39:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100e3c:	a3 60 ee 10 00       	mov    %eax,0x10ee60
    crt_pos = pos;                                                  //crt_pos是CGA当前光标位置
  100e41:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100e44:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
}
  100e4a:	83 c4 24             	add    $0x24,%esp
  100e4d:	5b                   	pop    %ebx
  100e4e:	5d                   	pop    %ebp
  100e4f:	c3                   	ret    

00100e50 <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100e50:	55                   	push   %ebp
  100e51:	89 e5                	mov    %esp,%ebp
  100e53:	53                   	push   %ebx
  100e54:	83 ec 54             	sub    $0x54,%esp
  100e57:	66 c7 45 f6 fa 03    	movw   $0x3fa,-0xa(%ebp)
  100e5d:	c6 45 f5 00          	movb   $0x0,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100e61:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100e65:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100e69:	ee                   	out    %al,(%dx)
  100e6a:	66 c7 45 f2 fb 03    	movw   $0x3fb,-0xe(%ebp)
  100e70:	c6 45 f1 80          	movb   $0x80,-0xf(%ebp)
  100e74:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100e78:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100e7c:	ee                   	out    %al,(%dx)
  100e7d:	66 c7 45 ee f8 03    	movw   $0x3f8,-0x12(%ebp)
  100e83:	c6 45 ed 0c          	movb   $0xc,-0x13(%ebp)
  100e87:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100e8b:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100e8f:	ee                   	out    %al,(%dx)
  100e90:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  100e96:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
  100e9a:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100e9e:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100ea2:	ee                   	out    %al,(%dx)
  100ea3:	66 c7 45 e6 fb 03    	movw   $0x3fb,-0x1a(%ebp)
  100ea9:	c6 45 e5 03          	movb   $0x3,-0x1b(%ebp)
  100ead:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100eb1:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100eb5:	ee                   	out    %al,(%dx)
  100eb6:	66 c7 45 e2 fc 03    	movw   $0x3fc,-0x1e(%ebp)
  100ebc:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
  100ec0:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  100ec4:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  100ec8:	ee                   	out    %al,(%dx)
  100ec9:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  100ecf:	c6 45 dd 01          	movb   $0x1,-0x23(%ebp)
  100ed3:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  100ed7:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  100edb:	ee                   	out    %al,(%dx)
  100edc:	66 c7 45 da fd 03    	movw   $0x3fd,-0x26(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100ee2:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  100ee6:	66 89 55 c6          	mov    %dx,-0x3a(%ebp)
  100eea:	0f b7 55 c6          	movzwl -0x3a(%ebp),%edx
  100eee:	ec                   	in     (%dx),%al
  100eef:	89 c3                	mov    %eax,%ebx
  100ef1:	88 5d d9             	mov    %bl,-0x27(%ebp)
    return data;
  100ef4:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  100ef8:	3c ff                	cmp    $0xff,%al
  100efa:	0f 95 c0             	setne  %al
  100efd:	0f b6 c0             	movzbl %al,%eax
  100f00:	a3 68 ee 10 00       	mov    %eax,0x10ee68
  100f05:	66 c7 45 d6 fa 03    	movw   $0x3fa,-0x2a(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f0b:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  100f0f:	66 89 55 c6          	mov    %dx,-0x3a(%ebp)
  100f13:	0f b7 55 c6          	movzwl -0x3a(%ebp),%edx
  100f17:	ec                   	in     (%dx),%al
  100f18:	89 c3                	mov    %eax,%ebx
  100f1a:	88 5d d5             	mov    %bl,-0x2b(%ebp)
    return data;
  100f1d:	66 c7 45 d2 f8 03    	movw   $0x3f8,-0x2e(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f23:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  100f27:	66 89 55 c6          	mov    %dx,-0x3a(%ebp)
  100f2b:	0f b7 55 c6          	movzwl -0x3a(%ebp),%edx
  100f2f:	ec                   	in     (%dx),%al
  100f30:	89 c3                	mov    %eax,%ebx
  100f32:	88 5d d1             	mov    %bl,-0x2f(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  100f35:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  100f3a:	85 c0                	test   %eax,%eax
  100f3c:	74 0c                	je     100f4a <serial_init+0xfa>
        pic_enable(IRQ_COM1);
  100f3e:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  100f45:	e8 fe 06 00 00       	call   101648 <pic_enable>
    }
}
  100f4a:	83 c4 54             	add    $0x54,%esp
  100f4d:	5b                   	pop    %ebx
  100f4e:	5d                   	pop    %ebp
  100f4f:	c3                   	ret    

00100f50 <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  100f50:	55                   	push   %ebp
  100f51:	89 e5                	mov    %esp,%ebp
  100f53:	53                   	push   %ebx
  100f54:	83 ec 24             	sub    $0x24,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  100f57:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  100f5e:	eb 09                	jmp    100f69 <lpt_putc_sub+0x19>
        delay();
  100f60:	e8 83 fd ff ff       	call   100ce8 <delay>
}

static void
lpt_putc_sub(int c) {
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  100f65:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  100f69:	66 c7 45 f6 79 03    	movw   $0x379,-0xa(%ebp)
  100f6f:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100f73:	66 89 55 da          	mov    %dx,-0x26(%ebp)
  100f77:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  100f7b:	ec                   	in     (%dx),%al
  100f7c:	89 c3                	mov    %eax,%ebx
  100f7e:	88 5d f5             	mov    %bl,-0xb(%ebp)
    return data;
  100f81:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100f85:	84 c0                	test   %al,%al
  100f87:	78 09                	js     100f92 <lpt_putc_sub+0x42>
  100f89:	81 7d f8 ff 31 00 00 	cmpl   $0x31ff,-0x8(%ebp)
  100f90:	7e ce                	jle    100f60 <lpt_putc_sub+0x10>
        delay();
    }
    outb(LPTPORT + 0, c);
  100f92:	8b 45 08             	mov    0x8(%ebp),%eax
  100f95:	0f b6 c0             	movzbl %al,%eax
  100f98:	66 c7 45 f2 78 03    	movw   $0x378,-0xe(%ebp)
  100f9e:	88 45 f1             	mov    %al,-0xf(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fa1:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100fa5:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100fa9:	ee                   	out    %al,(%dx)
  100faa:	66 c7 45 ee 7a 03    	movw   $0x37a,-0x12(%ebp)
  100fb0:	c6 45 ed 0d          	movb   $0xd,-0x13(%ebp)
  100fb4:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100fb8:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100fbc:	ee                   	out    %al,(%dx)
  100fbd:	66 c7 45 ea 7a 03    	movw   $0x37a,-0x16(%ebp)
  100fc3:	c6 45 e9 08          	movb   $0x8,-0x17(%ebp)
  100fc7:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100fcb:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100fcf:	ee                   	out    %al,(%dx)
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  100fd0:	83 c4 24             	add    $0x24,%esp
  100fd3:	5b                   	pop    %ebx
  100fd4:	5d                   	pop    %ebp
  100fd5:	c3                   	ret    

00100fd6 <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  100fd6:	55                   	push   %ebp
  100fd7:	89 e5                	mov    %esp,%ebp
  100fd9:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  100fdc:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  100fe0:	74 0d                	je     100fef <lpt_putc+0x19>
        lpt_putc_sub(c);
  100fe2:	8b 45 08             	mov    0x8(%ebp),%eax
  100fe5:	89 04 24             	mov    %eax,(%esp)
  100fe8:	e8 63 ff ff ff       	call   100f50 <lpt_putc_sub>
  100fed:	eb 24                	jmp    101013 <lpt_putc+0x3d>
    }
    else {
        lpt_putc_sub('\b');
  100fef:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  100ff6:	e8 55 ff ff ff       	call   100f50 <lpt_putc_sub>
        lpt_putc_sub(' ');
  100ffb:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  101002:	e8 49 ff ff ff       	call   100f50 <lpt_putc_sub>
        lpt_putc_sub('\b');
  101007:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10100e:	e8 3d ff ff ff       	call   100f50 <lpt_putc_sub>
    }
}
  101013:	c9                   	leave  
  101014:	c3                   	ret    

00101015 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  101015:	55                   	push   %ebp
  101016:	89 e5                	mov    %esp,%ebp
  101018:	53                   	push   %ebx
  101019:	83 ec 34             	sub    $0x34,%esp
    // set black on white
    if (!(c & ~0xFF)) {
  10101c:	8b 45 08             	mov    0x8(%ebp),%eax
  10101f:	b0 00                	mov    $0x0,%al
  101021:	85 c0                	test   %eax,%eax
  101023:	75 07                	jne    10102c <cga_putc+0x17>
        c |= 0x0700;
  101025:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  10102c:	8b 45 08             	mov    0x8(%ebp),%eax
  10102f:	25 ff 00 00 00       	and    $0xff,%eax
  101034:	83 f8 0a             	cmp    $0xa,%eax
  101037:	74 4e                	je     101087 <cga_putc+0x72>
  101039:	83 f8 0d             	cmp    $0xd,%eax
  10103c:	74 59                	je     101097 <cga_putc+0x82>
  10103e:	83 f8 08             	cmp    $0x8,%eax
  101041:	0f 85 8c 00 00 00    	jne    1010d3 <cga_putc+0xbe>
    case '\b':
        if (crt_pos > 0) {
  101047:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10104e:	66 85 c0             	test   %ax,%ax
  101051:	0f 84 a1 00 00 00    	je     1010f8 <cga_putc+0xe3>
            crt_pos --;
  101057:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10105e:	83 e8 01             	sub    $0x1,%eax
  101061:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  101067:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  10106c:	0f b7 15 64 ee 10 00 	movzwl 0x10ee64,%edx
  101073:	0f b7 d2             	movzwl %dx,%edx
  101076:	01 d2                	add    %edx,%edx
  101078:	01 c2                	add    %eax,%edx
  10107a:	8b 45 08             	mov    0x8(%ebp),%eax
  10107d:	b0 00                	mov    $0x0,%al
  10107f:	83 c8 20             	or     $0x20,%eax
  101082:	66 89 02             	mov    %ax,(%edx)
        }
        break;
  101085:	eb 71                	jmp    1010f8 <cga_putc+0xe3>
    case '\n':
        crt_pos += CRT_COLS;
  101087:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10108e:	83 c0 50             	add    $0x50,%eax
  101091:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  101097:	0f b7 1d 64 ee 10 00 	movzwl 0x10ee64,%ebx
  10109e:	0f b7 0d 64 ee 10 00 	movzwl 0x10ee64,%ecx
  1010a5:	0f b7 c1             	movzwl %cx,%eax
  1010a8:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  1010ae:	c1 e8 10             	shr    $0x10,%eax
  1010b1:	89 c2                	mov    %eax,%edx
  1010b3:	66 c1 ea 06          	shr    $0x6,%dx
  1010b7:	89 d0                	mov    %edx,%eax
  1010b9:	c1 e0 02             	shl    $0x2,%eax
  1010bc:	01 d0                	add    %edx,%eax
  1010be:	c1 e0 04             	shl    $0x4,%eax
  1010c1:	89 ca                	mov    %ecx,%edx
  1010c3:	66 29 c2             	sub    %ax,%dx
  1010c6:	89 d8                	mov    %ebx,%eax
  1010c8:	66 29 d0             	sub    %dx,%ax
  1010cb:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
        break;
  1010d1:	eb 26                	jmp    1010f9 <cga_putc+0xe4>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  1010d3:	8b 15 60 ee 10 00    	mov    0x10ee60,%edx
  1010d9:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1010e0:	0f b7 c8             	movzwl %ax,%ecx
  1010e3:	01 c9                	add    %ecx,%ecx
  1010e5:	01 d1                	add    %edx,%ecx
  1010e7:	8b 55 08             	mov    0x8(%ebp),%edx
  1010ea:	66 89 11             	mov    %dx,(%ecx)
  1010ed:	83 c0 01             	add    $0x1,%eax
  1010f0:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
        break;
  1010f6:	eb 01                	jmp    1010f9 <cga_putc+0xe4>
    case '\b':
        if (crt_pos > 0) {
            crt_pos --;
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
        }
        break;
  1010f8:	90                   	nop
        crt_buf[crt_pos ++] = c;     // write the character
        break;
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  1010f9:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101100:	66 3d cf 07          	cmp    $0x7cf,%ax
  101104:	76 5b                	jbe    101161 <cga_putc+0x14c>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  101106:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  10110b:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  101111:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  101116:	c7 44 24 08 00 0f 00 	movl   $0xf00,0x8(%esp)
  10111d:	00 
  10111e:	89 54 24 04          	mov    %edx,0x4(%esp)
  101122:	89 04 24             	mov    %eax,(%esp)
  101125:	e8 88 20 00 00       	call   1031b2 <memmove>
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  10112a:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  101131:	eb 15                	jmp    101148 <cga_putc+0x133>
            crt_buf[i] = 0x0700 | ' ';
  101133:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  101138:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10113b:	01 d2                	add    %edx,%edx
  10113d:	01 d0                	add    %edx,%eax
  10113f:	66 c7 00 20 07       	movw   $0x720,(%eax)

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101144:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101148:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  10114f:	7e e2                	jle    101133 <cga_putc+0x11e>
            crt_buf[i] = 0x0700 | ' ';
        }
        crt_pos -= CRT_COLS;
  101151:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101158:	83 e8 50             	sub    $0x50,%eax
  10115b:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  101161:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  101168:	0f b7 c0             	movzwl %ax,%eax
  10116b:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
  10116f:	c6 45 f1 0e          	movb   $0xe,-0xf(%ebp)
  101173:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101177:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10117b:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos >> 8);
  10117c:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101183:	66 c1 e8 08          	shr    $0x8,%ax
  101187:	0f b6 c0             	movzbl %al,%eax
  10118a:	0f b7 15 66 ee 10 00 	movzwl 0x10ee66,%edx
  101191:	83 c2 01             	add    $0x1,%edx
  101194:	0f b7 d2             	movzwl %dx,%edx
  101197:	66 89 55 ee          	mov    %dx,-0x12(%ebp)
  10119b:	88 45 ed             	mov    %al,-0x13(%ebp)
  10119e:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1011a2:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1011a6:	ee                   	out    %al,(%dx)
    outb(addr_6845, 15);
  1011a7:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  1011ae:	0f b7 c0             	movzwl %ax,%eax
  1011b1:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
  1011b5:	c6 45 e9 0f          	movb   $0xf,-0x17(%ebp)
  1011b9:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  1011bd:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  1011c1:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos);
  1011c2:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1011c9:	0f b6 c0             	movzbl %al,%eax
  1011cc:	0f b7 15 66 ee 10 00 	movzwl 0x10ee66,%edx
  1011d3:	83 c2 01             	add    $0x1,%edx
  1011d6:	0f b7 d2             	movzwl %dx,%edx
  1011d9:	66 89 55 e6          	mov    %dx,-0x1a(%ebp)
  1011dd:	88 45 e5             	mov    %al,-0x1b(%ebp)
  1011e0:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  1011e4:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  1011e8:	ee                   	out    %al,(%dx)
}
  1011e9:	83 c4 34             	add    $0x34,%esp
  1011ec:	5b                   	pop    %ebx
  1011ed:	5d                   	pop    %ebp
  1011ee:	c3                   	ret    

001011ef <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  1011ef:	55                   	push   %ebp
  1011f0:	89 e5                	mov    %esp,%ebp
  1011f2:	53                   	push   %ebx
  1011f3:	83 ec 14             	sub    $0x14,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  1011f6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  1011fd:	eb 09                	jmp    101208 <serial_putc_sub+0x19>
        delay();
  1011ff:	e8 e4 fa ff ff       	call   100ce8 <delay>
}

static void
serial_putc_sub(int c) {
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  101204:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  101208:	66 c7 45 f6 fd 03    	movw   $0x3fd,-0xa(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10120e:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101212:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  101216:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  10121a:	ec                   	in     (%dx),%al
  10121b:	89 c3                	mov    %eax,%ebx
  10121d:	88 5d f5             	mov    %bl,-0xb(%ebp)
    return data;
  101220:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101224:	0f b6 c0             	movzbl %al,%eax
  101227:	83 e0 20             	and    $0x20,%eax
  10122a:	85 c0                	test   %eax,%eax
  10122c:	75 09                	jne    101237 <serial_putc_sub+0x48>
  10122e:	81 7d f8 ff 31 00 00 	cmpl   $0x31ff,-0x8(%ebp)
  101235:	7e c8                	jle    1011ff <serial_putc_sub+0x10>
        delay();
    }
    outb(COM1 + COM_TX, c);
  101237:	8b 45 08             	mov    0x8(%ebp),%eax
  10123a:	0f b6 c0             	movzbl %al,%eax
  10123d:	66 c7 45 f2 f8 03    	movw   $0x3f8,-0xe(%ebp)
  101243:	88 45 f1             	mov    %al,-0xf(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101246:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10124a:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10124e:	ee                   	out    %al,(%dx)
}
  10124f:	83 c4 14             	add    $0x14,%esp
  101252:	5b                   	pop    %ebx
  101253:	5d                   	pop    %ebp
  101254:	c3                   	ret    

00101255 <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  101255:	55                   	push   %ebp
  101256:	89 e5                	mov    %esp,%ebp
  101258:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  10125b:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  10125f:	74 0d                	je     10126e <serial_putc+0x19>
        serial_putc_sub(c);
  101261:	8b 45 08             	mov    0x8(%ebp),%eax
  101264:	89 04 24             	mov    %eax,(%esp)
  101267:	e8 83 ff ff ff       	call   1011ef <serial_putc_sub>
  10126c:	eb 24                	jmp    101292 <serial_putc+0x3d>
    }
    else {
        serial_putc_sub('\b');
  10126e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  101275:	e8 75 ff ff ff       	call   1011ef <serial_putc_sub>
        serial_putc_sub(' ');
  10127a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  101281:	e8 69 ff ff ff       	call   1011ef <serial_putc_sub>
        serial_putc_sub('\b');
  101286:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10128d:	e8 5d ff ff ff       	call   1011ef <serial_putc_sub>
    }
}
  101292:	c9                   	leave  
  101293:	c3                   	ret    

00101294 <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  101294:	55                   	push   %ebp
  101295:	89 e5                	mov    %esp,%ebp
  101297:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  10129a:	eb 32                	jmp    1012ce <cons_intr+0x3a>
        if (c != 0) {
  10129c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1012a0:	74 2c                	je     1012ce <cons_intr+0x3a>
            cons.buf[cons.wpos ++] = c;
  1012a2:	a1 84 f0 10 00       	mov    0x10f084,%eax
  1012a7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1012aa:	88 90 80 ee 10 00    	mov    %dl,0x10ee80(%eax)
  1012b0:	83 c0 01             	add    $0x1,%eax
  1012b3:	a3 84 f0 10 00       	mov    %eax,0x10f084
            if (cons.wpos == CONSBUFSIZE) {
  1012b8:	a1 84 f0 10 00       	mov    0x10f084,%eax
  1012bd:	3d 00 02 00 00       	cmp    $0x200,%eax
  1012c2:	75 0a                	jne    1012ce <cons_intr+0x3a>
                cons.wpos = 0;
  1012c4:	c7 05 84 f0 10 00 00 	movl   $0x0,0x10f084
  1012cb:	00 00 00 
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
    int c;
    while ((c = (*proc)()) != -1) {
  1012ce:	8b 45 08             	mov    0x8(%ebp),%eax
  1012d1:	ff d0                	call   *%eax
  1012d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1012d6:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  1012da:	75 c0                	jne    10129c <cons_intr+0x8>
            if (cons.wpos == CONSBUFSIZE) {
                cons.wpos = 0;
            }
        }
    }
}
  1012dc:	c9                   	leave  
  1012dd:	c3                   	ret    

001012de <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  1012de:	55                   	push   %ebp
  1012df:	89 e5                	mov    %esp,%ebp
  1012e1:	53                   	push   %ebx
  1012e2:	83 ec 14             	sub    $0x14,%esp
  1012e5:	66 c7 45 f6 fd 03    	movw   $0x3fd,-0xa(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1012eb:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1012ef:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  1012f3:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  1012f7:	ec                   	in     (%dx),%al
  1012f8:	89 c3                	mov    %eax,%ebx
  1012fa:	88 5d f5             	mov    %bl,-0xb(%ebp)
    return data;
  1012fd:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  101301:	0f b6 c0             	movzbl %al,%eax
  101304:	83 e0 01             	and    $0x1,%eax
  101307:	85 c0                	test   %eax,%eax
  101309:	75 07                	jne    101312 <serial_proc_data+0x34>
        return -1;
  10130b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101310:	eb 32                	jmp    101344 <serial_proc_data+0x66>
  101312:	66 c7 45 f2 f8 03    	movw   $0x3f8,-0xe(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101318:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10131c:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  101320:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101324:	ec                   	in     (%dx),%al
  101325:	89 c3                	mov    %eax,%ebx
  101327:	88 5d f1             	mov    %bl,-0xf(%ebp)
    return data;
  10132a:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  10132e:	0f b6 c0             	movzbl %al,%eax
  101331:	89 45 f8             	mov    %eax,-0x8(%ebp)
    if (c == 127) {
  101334:	83 7d f8 7f          	cmpl   $0x7f,-0x8(%ebp)
  101338:	75 07                	jne    101341 <serial_proc_data+0x63>
        c = '\b';
  10133a:	c7 45 f8 08 00 00 00 	movl   $0x8,-0x8(%ebp)
    }
    return c;
  101341:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  101344:	83 c4 14             	add    $0x14,%esp
  101347:	5b                   	pop    %ebx
  101348:	5d                   	pop    %ebp
  101349:	c3                   	ret    

0010134a <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  10134a:	55                   	push   %ebp
  10134b:	89 e5                	mov    %esp,%ebp
  10134d:	83 ec 18             	sub    $0x18,%esp
    if (serial_exists) {
  101350:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  101355:	85 c0                	test   %eax,%eax
  101357:	74 0c                	je     101365 <serial_intr+0x1b>
        cons_intr(serial_proc_data);
  101359:	c7 04 24 de 12 10 00 	movl   $0x1012de,(%esp)
  101360:	e8 2f ff ff ff       	call   101294 <cons_intr>
    }
}
  101365:	c9                   	leave  
  101366:	c3                   	ret    

00101367 <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  101367:	55                   	push   %ebp
  101368:	89 e5                	mov    %esp,%ebp
  10136a:	53                   	push   %ebx
  10136b:	83 ec 44             	sub    $0x44,%esp
  10136e:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101374:	0f b7 55 f0          	movzwl -0x10(%ebp),%edx
  101378:	66 89 55 d6          	mov    %dx,-0x2a(%ebp)
  10137c:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  101380:	ec                   	in     (%dx),%al
  101381:	89 c3                	mov    %eax,%ebx
  101383:	88 5d ef             	mov    %bl,-0x11(%ebp)
    return data;
  101386:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  10138a:	0f b6 c0             	movzbl %al,%eax
  10138d:	83 e0 01             	and    $0x1,%eax
  101390:	85 c0                	test   %eax,%eax
  101392:	75 0a                	jne    10139e <kbd_proc_data+0x37>
        return -1;
  101394:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101399:	e9 61 01 00 00       	jmp    1014ff <kbd_proc_data+0x198>
  10139e:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1013a4:	0f b7 55 ec          	movzwl -0x14(%ebp),%edx
  1013a8:	66 89 55 d6          	mov    %dx,-0x2a(%ebp)
  1013ac:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  1013b0:	ec                   	in     (%dx),%al
  1013b1:	89 c3                	mov    %eax,%ebx
  1013b3:	88 5d eb             	mov    %bl,-0x15(%ebp)
    return data;
  1013b6:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  1013ba:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  1013bd:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  1013c1:	75 17                	jne    1013da <kbd_proc_data+0x73>
        // E0 escape character
        shift |= E0ESC;
  1013c3:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1013c8:	83 c8 40             	or     $0x40,%eax
  1013cb:	a3 88 f0 10 00       	mov    %eax,0x10f088
        return 0;
  1013d0:	b8 00 00 00 00       	mov    $0x0,%eax
  1013d5:	e9 25 01 00 00       	jmp    1014ff <kbd_proc_data+0x198>
    } else if (data & 0x80) {
  1013da:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1013de:	84 c0                	test   %al,%al
  1013e0:	79 47                	jns    101429 <kbd_proc_data+0xc2>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  1013e2:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1013e7:	83 e0 40             	and    $0x40,%eax
  1013ea:	85 c0                	test   %eax,%eax
  1013ec:	75 09                	jne    1013f7 <kbd_proc_data+0x90>
  1013ee:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1013f2:	83 e0 7f             	and    $0x7f,%eax
  1013f5:	eb 04                	jmp    1013fb <kbd_proc_data+0x94>
  1013f7:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1013fb:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  1013fe:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101402:	0f b6 80 40 e0 10 00 	movzbl 0x10e040(%eax),%eax
  101409:	83 c8 40             	or     $0x40,%eax
  10140c:	0f b6 c0             	movzbl %al,%eax
  10140f:	f7 d0                	not    %eax
  101411:	89 c2                	mov    %eax,%edx
  101413:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101418:	21 d0                	and    %edx,%eax
  10141a:	a3 88 f0 10 00       	mov    %eax,0x10f088
        return 0;
  10141f:	b8 00 00 00 00       	mov    $0x0,%eax
  101424:	e9 d6 00 00 00       	jmp    1014ff <kbd_proc_data+0x198>
    } else if (shift & E0ESC) {
  101429:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10142e:	83 e0 40             	and    $0x40,%eax
  101431:	85 c0                	test   %eax,%eax
  101433:	74 11                	je     101446 <kbd_proc_data+0xdf>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  101435:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  101439:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10143e:	83 e0 bf             	and    $0xffffffbf,%eax
  101441:	a3 88 f0 10 00       	mov    %eax,0x10f088
    }

    shift |= shiftcode[data];
  101446:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10144a:	0f b6 80 40 e0 10 00 	movzbl 0x10e040(%eax),%eax
  101451:	0f b6 d0             	movzbl %al,%edx
  101454:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101459:	09 d0                	or     %edx,%eax
  10145b:	a3 88 f0 10 00       	mov    %eax,0x10f088
    shift ^= togglecode[data];
  101460:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101464:	0f b6 80 40 e1 10 00 	movzbl 0x10e140(%eax),%eax
  10146b:	0f b6 d0             	movzbl %al,%edx
  10146e:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101473:	31 d0                	xor    %edx,%eax
  101475:	a3 88 f0 10 00       	mov    %eax,0x10f088

    c = charcode[shift & (CTL | SHIFT)][data];
  10147a:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10147f:	83 e0 03             	and    $0x3,%eax
  101482:	8b 14 85 40 e5 10 00 	mov    0x10e540(,%eax,4),%edx
  101489:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10148d:	01 d0                	add    %edx,%eax
  10148f:	0f b6 00             	movzbl (%eax),%eax
  101492:	0f b6 c0             	movzbl %al,%eax
  101495:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  101498:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10149d:	83 e0 08             	and    $0x8,%eax
  1014a0:	85 c0                	test   %eax,%eax
  1014a2:	74 22                	je     1014c6 <kbd_proc_data+0x15f>
        if ('a' <= c && c <= 'z')
  1014a4:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  1014a8:	7e 0c                	jle    1014b6 <kbd_proc_data+0x14f>
  1014aa:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  1014ae:	7f 06                	jg     1014b6 <kbd_proc_data+0x14f>
            c += 'A' - 'a';
  1014b0:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  1014b4:	eb 10                	jmp    1014c6 <kbd_proc_data+0x15f>
        else if ('A' <= c && c <= 'Z')
  1014b6:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  1014ba:	7e 0a                	jle    1014c6 <kbd_proc_data+0x15f>
  1014bc:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  1014c0:	7f 04                	jg     1014c6 <kbd_proc_data+0x15f>
            c += 'a' - 'A';
  1014c2:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  1014c6:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014cb:	f7 d0                	not    %eax
  1014cd:	83 e0 06             	and    $0x6,%eax
  1014d0:	85 c0                	test   %eax,%eax
  1014d2:	75 28                	jne    1014fc <kbd_proc_data+0x195>
  1014d4:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  1014db:	75 1f                	jne    1014fc <kbd_proc_data+0x195>
        cprintf("Rebooting!\n");
  1014dd:	c7 04 24 15 36 10 00 	movl   $0x103615,(%esp)
  1014e4:	e8 32 ee ff ff       	call   10031b <cprintf>
  1014e9:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  1014ef:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1014f3:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  1014f7:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
  1014fb:	ee                   	out    %al,(%dx)
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  1014fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1014ff:	83 c4 44             	add    $0x44,%esp
  101502:	5b                   	pop    %ebx
  101503:	5d                   	pop    %ebp
  101504:	c3                   	ret    

00101505 <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  101505:	55                   	push   %ebp
  101506:	89 e5                	mov    %esp,%ebp
  101508:	83 ec 18             	sub    $0x18,%esp
    cons_intr(kbd_proc_data);
  10150b:	c7 04 24 67 13 10 00 	movl   $0x101367,(%esp)
  101512:	e8 7d fd ff ff       	call   101294 <cons_intr>
}
  101517:	c9                   	leave  
  101518:	c3                   	ret    

00101519 <kbd_init>:

static void
kbd_init(void) {
  101519:	55                   	push   %ebp
  10151a:	89 e5                	mov    %esp,%ebp
  10151c:	83 ec 18             	sub    $0x18,%esp
    // drain the kbd buffer
    kbd_intr();
  10151f:	e8 e1 ff ff ff       	call   101505 <kbd_intr>
    pic_enable(IRQ_KBD);
  101524:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  10152b:	e8 18 01 00 00       	call   101648 <pic_enable>
}
  101530:	c9                   	leave  
  101531:	c3                   	ret    

00101532 <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  101532:	55                   	push   %ebp
  101533:	89 e5                	mov    %esp,%ebp
  101535:	83 ec 18             	sub    $0x18,%esp
    cga_init();
  101538:	e8 18 f8 ff ff       	call   100d55 <cga_init>
    serial_init();
  10153d:	e8 0e f9 ff ff       	call   100e50 <serial_init>
    kbd_init();
  101542:	e8 d2 ff ff ff       	call   101519 <kbd_init>
    if (!serial_exists) {
  101547:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  10154c:	85 c0                	test   %eax,%eax
  10154e:	75 0c                	jne    10155c <cons_init+0x2a>
        cprintf("serial port does not exist!!\n");
  101550:	c7 04 24 21 36 10 00 	movl   $0x103621,(%esp)
  101557:	e8 bf ed ff ff       	call   10031b <cprintf>
    }
}
  10155c:	c9                   	leave  
  10155d:	c3                   	ret    

0010155e <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  10155e:	55                   	push   %ebp
  10155f:	89 e5                	mov    %esp,%ebp
  101561:	83 ec 18             	sub    $0x18,%esp
    lpt_putc(c);
  101564:	8b 45 08             	mov    0x8(%ebp),%eax
  101567:	89 04 24             	mov    %eax,(%esp)
  10156a:	e8 67 fa ff ff       	call   100fd6 <lpt_putc>
    cga_putc(c);
  10156f:	8b 45 08             	mov    0x8(%ebp),%eax
  101572:	89 04 24             	mov    %eax,(%esp)
  101575:	e8 9b fa ff ff       	call   101015 <cga_putc>
    serial_putc(c);
  10157a:	8b 45 08             	mov    0x8(%ebp),%eax
  10157d:	89 04 24             	mov    %eax,(%esp)
  101580:	e8 d0 fc ff ff       	call   101255 <serial_putc>
}
  101585:	c9                   	leave  
  101586:	c3                   	ret    

00101587 <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  101587:	55                   	push   %ebp
  101588:	89 e5                	mov    %esp,%ebp
  10158a:	83 ec 18             	sub    $0x18,%esp
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  10158d:	e8 b8 fd ff ff       	call   10134a <serial_intr>
    kbd_intr();
  101592:	e8 6e ff ff ff       	call   101505 <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  101597:	8b 15 80 f0 10 00    	mov    0x10f080,%edx
  10159d:	a1 84 f0 10 00       	mov    0x10f084,%eax
  1015a2:	39 c2                	cmp    %eax,%edx
  1015a4:	74 35                	je     1015db <cons_getc+0x54>
        c = cons.buf[cons.rpos ++];
  1015a6:	a1 80 f0 10 00       	mov    0x10f080,%eax
  1015ab:	0f b6 90 80 ee 10 00 	movzbl 0x10ee80(%eax),%edx
  1015b2:	0f b6 d2             	movzbl %dl,%edx
  1015b5:	89 55 f4             	mov    %edx,-0xc(%ebp)
  1015b8:	83 c0 01             	add    $0x1,%eax
  1015bb:	a3 80 f0 10 00       	mov    %eax,0x10f080
        if (cons.rpos == CONSBUFSIZE) {
  1015c0:	a1 80 f0 10 00       	mov    0x10f080,%eax
  1015c5:	3d 00 02 00 00       	cmp    $0x200,%eax
  1015ca:	75 0a                	jne    1015d6 <cons_getc+0x4f>
            cons.rpos = 0;
  1015cc:	c7 05 80 f0 10 00 00 	movl   $0x0,0x10f080
  1015d3:	00 00 00 
        }
        return c;
  1015d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1015d9:	eb 05                	jmp    1015e0 <cons_getc+0x59>
    }
    return 0;
  1015db:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1015e0:	c9                   	leave  
  1015e1:	c3                   	ret    
	...

001015e4 <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  1015e4:	55                   	push   %ebp
  1015e5:	89 e5                	mov    %esp,%ebp
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  1015e7:	fb                   	sti    
    sti();
}
  1015e8:	5d                   	pop    %ebp
  1015e9:	c3                   	ret    

001015ea <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  1015ea:	55                   	push   %ebp
  1015eb:	89 e5                	mov    %esp,%ebp
}

static inline void
cli(void) {
    asm volatile ("cli");
  1015ed:	fa                   	cli    
    cli();
}
  1015ee:	5d                   	pop    %ebp
  1015ef:	c3                   	ret    

001015f0 <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  1015f0:	55                   	push   %ebp
  1015f1:	89 e5                	mov    %esp,%ebp
  1015f3:	83 ec 14             	sub    $0x14,%esp
  1015f6:	8b 45 08             	mov    0x8(%ebp),%eax
  1015f9:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  1015fd:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101601:	66 a3 50 e5 10 00    	mov    %ax,0x10e550
    if (did_init) {
  101607:	a1 8c f0 10 00       	mov    0x10f08c,%eax
  10160c:	85 c0                	test   %eax,%eax
  10160e:	74 36                	je     101646 <pic_setmask+0x56>
        outb(IO_PIC1 + 1, mask);
  101610:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101614:	0f b6 c0             	movzbl %al,%eax
  101617:	66 c7 45 fe 21 00    	movw   $0x21,-0x2(%ebp)
  10161d:	88 45 fd             	mov    %al,-0x3(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101620:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101624:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101628:	ee                   	out    %al,(%dx)
        outb(IO_PIC2 + 1, mask >> 8);
  101629:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10162d:	66 c1 e8 08          	shr    $0x8,%ax
  101631:	0f b6 c0             	movzbl %al,%eax
  101634:	66 c7 45 fa a1 00    	movw   $0xa1,-0x6(%ebp)
  10163a:	88 45 f9             	mov    %al,-0x7(%ebp)
  10163d:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101641:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101645:	ee                   	out    %al,(%dx)
    }
}
  101646:	c9                   	leave  
  101647:	c3                   	ret    

00101648 <pic_enable>:

void
pic_enable(unsigned int irq) {
  101648:	55                   	push   %ebp
  101649:	89 e5                	mov    %esp,%ebp
  10164b:	53                   	push   %ebx
  10164c:	83 ec 04             	sub    $0x4,%esp
    pic_setmask(irq_mask & ~(1 << irq));
  10164f:	8b 45 08             	mov    0x8(%ebp),%eax
  101652:	ba 01 00 00 00       	mov    $0x1,%edx
  101657:	89 d3                	mov    %edx,%ebx
  101659:	89 c1                	mov    %eax,%ecx
  10165b:	d3 e3                	shl    %cl,%ebx
  10165d:	89 d8                	mov    %ebx,%eax
  10165f:	89 c2                	mov    %eax,%edx
  101661:	f7 d2                	not    %edx
  101663:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  10166a:	21 d0                	and    %edx,%eax
  10166c:	0f b7 c0             	movzwl %ax,%eax
  10166f:	89 04 24             	mov    %eax,(%esp)
  101672:	e8 79 ff ff ff       	call   1015f0 <pic_setmask>
}
  101677:	83 c4 04             	add    $0x4,%esp
  10167a:	5b                   	pop    %ebx
  10167b:	5d                   	pop    %ebp
  10167c:	c3                   	ret    

0010167d <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  10167d:	55                   	push   %ebp
  10167e:	89 e5                	mov    %esp,%ebp
  101680:	83 ec 44             	sub    $0x44,%esp
    did_init = 1;
  101683:	c7 05 8c f0 10 00 01 	movl   $0x1,0x10f08c
  10168a:	00 00 00 
  10168d:	66 c7 45 fe 21 00    	movw   $0x21,-0x2(%ebp)
  101693:	c6 45 fd ff          	movb   $0xff,-0x3(%ebp)
  101697:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  10169b:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  10169f:	ee                   	out    %al,(%dx)
  1016a0:	66 c7 45 fa a1 00    	movw   $0xa1,-0x6(%ebp)
  1016a6:	c6 45 f9 ff          	movb   $0xff,-0x7(%ebp)
  1016aa:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1016ae:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  1016b2:	ee                   	out    %al,(%dx)
  1016b3:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  1016b9:	c6 45 f5 11          	movb   $0x11,-0xb(%ebp)
  1016bd:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1016c1:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1016c5:	ee                   	out    %al,(%dx)
  1016c6:	66 c7 45 f2 21 00    	movw   $0x21,-0xe(%ebp)
  1016cc:	c6 45 f1 20          	movb   $0x20,-0xf(%ebp)
  1016d0:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1016d4:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1016d8:	ee                   	out    %al,(%dx)
  1016d9:	66 c7 45 ee 21 00    	movw   $0x21,-0x12(%ebp)
  1016df:	c6 45 ed 04          	movb   $0x4,-0x13(%ebp)
  1016e3:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1016e7:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1016eb:	ee                   	out    %al,(%dx)
  1016ec:	66 c7 45 ea 21 00    	movw   $0x21,-0x16(%ebp)
  1016f2:	c6 45 e9 03          	movb   $0x3,-0x17(%ebp)
  1016f6:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  1016fa:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  1016fe:	ee                   	out    %al,(%dx)
  1016ff:	66 c7 45 e6 a0 00    	movw   $0xa0,-0x1a(%ebp)
  101705:	c6 45 e5 11          	movb   $0x11,-0x1b(%ebp)
  101709:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  10170d:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101711:	ee                   	out    %al,(%dx)
  101712:	66 c7 45 e2 a1 00    	movw   $0xa1,-0x1e(%ebp)
  101718:	c6 45 e1 28          	movb   $0x28,-0x1f(%ebp)
  10171c:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  101720:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  101724:	ee                   	out    %al,(%dx)
  101725:	66 c7 45 de a1 00    	movw   $0xa1,-0x22(%ebp)
  10172b:	c6 45 dd 02          	movb   $0x2,-0x23(%ebp)
  10172f:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  101733:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  101737:	ee                   	out    %al,(%dx)
  101738:	66 c7 45 da a1 00    	movw   $0xa1,-0x26(%ebp)
  10173e:	c6 45 d9 03          	movb   $0x3,-0x27(%ebp)
  101742:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  101746:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  10174a:	ee                   	out    %al,(%dx)
  10174b:	66 c7 45 d6 20 00    	movw   $0x20,-0x2a(%ebp)
  101751:	c6 45 d5 68          	movb   $0x68,-0x2b(%ebp)
  101755:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  101759:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  10175d:	ee                   	out    %al,(%dx)
  10175e:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  101764:	c6 45 d1 0a          	movb   $0xa,-0x2f(%ebp)
  101768:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  10176c:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  101770:	ee                   	out    %al,(%dx)
  101771:	66 c7 45 ce a0 00    	movw   $0xa0,-0x32(%ebp)
  101777:	c6 45 cd 68          	movb   $0x68,-0x33(%ebp)
  10177b:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  10177f:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  101783:	ee                   	out    %al,(%dx)
  101784:	66 c7 45 ca a0 00    	movw   $0xa0,-0x36(%ebp)
  10178a:	c6 45 c9 0a          	movb   $0xa,-0x37(%ebp)
  10178e:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  101792:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  101796:	ee                   	out    %al,(%dx)
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  101797:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  10179e:	66 83 f8 ff          	cmp    $0xffff,%ax
  1017a2:	74 12                	je     1017b6 <pic_init+0x139>
        pic_setmask(irq_mask);
  1017a4:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  1017ab:	0f b7 c0             	movzwl %ax,%eax
  1017ae:	89 04 24             	mov    %eax,(%esp)
  1017b1:	e8 3a fe ff ff       	call   1015f0 <pic_setmask>
    }
}
  1017b6:	c9                   	leave  
  1017b7:	c3                   	ret    

001017b8 <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
  1017b8:	55                   	push   %ebp
  1017b9:	89 e5                	mov    %esp,%ebp
  1017bb:	83 ec 18             	sub    $0x18,%esp
    cprintf("%d ticks\n",TICK_NUM);
  1017be:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
  1017c5:	00 
  1017c6:	c7 04 24 40 36 10 00 	movl   $0x103640,(%esp)
  1017cd:	e8 49 eb ff ff       	call   10031b <cprintf>
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
    panic("EOT: kernel seems ok.");
#endif
}
  1017d2:	c9                   	leave  
  1017d3:	c3                   	ret    

001017d4 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  1017d4:	55                   	push   %ebp
  1017d5:	89 e5                	mov    %esp,%ebp
      *     Can you see idt[256] in this file? Yes, it's IDT! you can use SETGATE macro to setup each item of IDT
      * (3) After setup the contents of IDT, you will let CPU know where is the IDT by using 'lidt' instruction.
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
}
  1017d7:	5d                   	pop    %ebp
  1017d8:	c3                   	ret    

001017d9 <trapname>:

static const char *
trapname(int trapno) {
  1017d9:	55                   	push   %ebp
  1017da:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  1017dc:	8b 45 08             	mov    0x8(%ebp),%eax
  1017df:	83 f8 13             	cmp    $0x13,%eax
  1017e2:	77 0c                	ja     1017f0 <trapname+0x17>
        return excnames[trapno];
  1017e4:	8b 45 08             	mov    0x8(%ebp),%eax
  1017e7:	8b 04 85 a0 39 10 00 	mov    0x1039a0(,%eax,4),%eax
  1017ee:	eb 18                	jmp    101808 <trapname+0x2f>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  1017f0:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  1017f4:	7e 0d                	jle    101803 <trapname+0x2a>
  1017f6:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  1017fa:	7f 07                	jg     101803 <trapname+0x2a>
        return "Hardware Interrupt";
  1017fc:	b8 4a 36 10 00       	mov    $0x10364a,%eax
  101801:	eb 05                	jmp    101808 <trapname+0x2f>
    }
    return "(unknown trap)";
  101803:	b8 5d 36 10 00       	mov    $0x10365d,%eax
}
  101808:	5d                   	pop    %ebp
  101809:	c3                   	ret    

0010180a <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  10180a:	55                   	push   %ebp
  10180b:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  10180d:	8b 45 08             	mov    0x8(%ebp),%eax
  101810:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101814:	66 83 f8 08          	cmp    $0x8,%ax
  101818:	0f 94 c0             	sete   %al
  10181b:	0f b6 c0             	movzbl %al,%eax
}
  10181e:	5d                   	pop    %ebp
  10181f:	c3                   	ret    

00101820 <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101820:	55                   	push   %ebp
  101821:	89 e5                	mov    %esp,%ebp
  101823:	83 ec 28             	sub    $0x28,%esp
    cprintf("trapframe at %p\n", tf);
  101826:	8b 45 08             	mov    0x8(%ebp),%eax
  101829:	89 44 24 04          	mov    %eax,0x4(%esp)
  10182d:	c7 04 24 9e 36 10 00 	movl   $0x10369e,(%esp)
  101834:	e8 e2 ea ff ff       	call   10031b <cprintf>
    print_regs(&tf->tf_regs);
  101839:	8b 45 08             	mov    0x8(%ebp),%eax
  10183c:	89 04 24             	mov    %eax,(%esp)
  10183f:	e8 a1 01 00 00       	call   1019e5 <print_regs>
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101844:	8b 45 08             	mov    0x8(%ebp),%eax
  101847:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  10184b:	0f b7 c0             	movzwl %ax,%eax
  10184e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101852:	c7 04 24 af 36 10 00 	movl   $0x1036af,(%esp)
  101859:	e8 bd ea ff ff       	call   10031b <cprintf>
    cprintf("  es   0x----%04x\n", tf->tf_es);
  10185e:	8b 45 08             	mov    0x8(%ebp),%eax
  101861:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101865:	0f b7 c0             	movzwl %ax,%eax
  101868:	89 44 24 04          	mov    %eax,0x4(%esp)
  10186c:	c7 04 24 c2 36 10 00 	movl   $0x1036c2,(%esp)
  101873:	e8 a3 ea ff ff       	call   10031b <cprintf>
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101878:	8b 45 08             	mov    0x8(%ebp),%eax
  10187b:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  10187f:	0f b7 c0             	movzwl %ax,%eax
  101882:	89 44 24 04          	mov    %eax,0x4(%esp)
  101886:	c7 04 24 d5 36 10 00 	movl   $0x1036d5,(%esp)
  10188d:	e8 89 ea ff ff       	call   10031b <cprintf>
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101892:	8b 45 08             	mov    0x8(%ebp),%eax
  101895:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101899:	0f b7 c0             	movzwl %ax,%eax
  10189c:	89 44 24 04          	mov    %eax,0x4(%esp)
  1018a0:	c7 04 24 e8 36 10 00 	movl   $0x1036e8,(%esp)
  1018a7:	e8 6f ea ff ff       	call   10031b <cprintf>
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  1018ac:	8b 45 08             	mov    0x8(%ebp),%eax
  1018af:	8b 40 30             	mov    0x30(%eax),%eax
  1018b2:	89 04 24             	mov    %eax,(%esp)
  1018b5:	e8 1f ff ff ff       	call   1017d9 <trapname>
  1018ba:	8b 55 08             	mov    0x8(%ebp),%edx
  1018bd:	8b 52 30             	mov    0x30(%edx),%edx
  1018c0:	89 44 24 08          	mov    %eax,0x8(%esp)
  1018c4:	89 54 24 04          	mov    %edx,0x4(%esp)
  1018c8:	c7 04 24 fb 36 10 00 	movl   $0x1036fb,(%esp)
  1018cf:	e8 47 ea ff ff       	call   10031b <cprintf>
    cprintf("  err  0x%08x\n", tf->tf_err);
  1018d4:	8b 45 08             	mov    0x8(%ebp),%eax
  1018d7:	8b 40 34             	mov    0x34(%eax),%eax
  1018da:	89 44 24 04          	mov    %eax,0x4(%esp)
  1018de:	c7 04 24 0d 37 10 00 	movl   $0x10370d,(%esp)
  1018e5:	e8 31 ea ff ff       	call   10031b <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  1018ea:	8b 45 08             	mov    0x8(%ebp),%eax
  1018ed:	8b 40 38             	mov    0x38(%eax),%eax
  1018f0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1018f4:	c7 04 24 1c 37 10 00 	movl   $0x10371c,(%esp)
  1018fb:	e8 1b ea ff ff       	call   10031b <cprintf>
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101900:	8b 45 08             	mov    0x8(%ebp),%eax
  101903:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101907:	0f b7 c0             	movzwl %ax,%eax
  10190a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10190e:	c7 04 24 2b 37 10 00 	movl   $0x10372b,(%esp)
  101915:	e8 01 ea ff ff       	call   10031b <cprintf>
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  10191a:	8b 45 08             	mov    0x8(%ebp),%eax
  10191d:	8b 40 40             	mov    0x40(%eax),%eax
  101920:	89 44 24 04          	mov    %eax,0x4(%esp)
  101924:	c7 04 24 3e 37 10 00 	movl   $0x10373e,(%esp)
  10192b:	e8 eb e9 ff ff       	call   10031b <cprintf>

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101930:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101937:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  10193e:	eb 3e                	jmp    10197e <print_trapframe+0x15e>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101940:	8b 45 08             	mov    0x8(%ebp),%eax
  101943:	8b 50 40             	mov    0x40(%eax),%edx
  101946:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101949:	21 d0                	and    %edx,%eax
  10194b:	85 c0                	test   %eax,%eax
  10194d:	74 28                	je     101977 <print_trapframe+0x157>
  10194f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101952:	8b 04 85 80 e5 10 00 	mov    0x10e580(,%eax,4),%eax
  101959:	85 c0                	test   %eax,%eax
  10195b:	74 1a                	je     101977 <print_trapframe+0x157>
            cprintf("%s,", IA32flags[i]);
  10195d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101960:	8b 04 85 80 e5 10 00 	mov    0x10e580(,%eax,4),%eax
  101967:	89 44 24 04          	mov    %eax,0x4(%esp)
  10196b:	c7 04 24 4d 37 10 00 	movl   $0x10374d,(%esp)
  101972:	e8 a4 e9 ff ff       	call   10031b <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
    cprintf("  flag 0x%08x ", tf->tf_eflags);

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101977:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  10197b:	d1 65 f0             	shll   -0x10(%ebp)
  10197e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101981:	83 f8 17             	cmp    $0x17,%eax
  101984:	76 ba                	jbe    101940 <print_trapframe+0x120>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
            cprintf("%s,", IA32flags[i]);
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101986:	8b 45 08             	mov    0x8(%ebp),%eax
  101989:	8b 40 40             	mov    0x40(%eax),%eax
  10198c:	25 00 30 00 00       	and    $0x3000,%eax
  101991:	c1 e8 0c             	shr    $0xc,%eax
  101994:	89 44 24 04          	mov    %eax,0x4(%esp)
  101998:	c7 04 24 51 37 10 00 	movl   $0x103751,(%esp)
  10199f:	e8 77 e9 ff ff       	call   10031b <cprintf>

    if (!trap_in_kernel(tf)) {
  1019a4:	8b 45 08             	mov    0x8(%ebp),%eax
  1019a7:	89 04 24             	mov    %eax,(%esp)
  1019aa:	e8 5b fe ff ff       	call   10180a <trap_in_kernel>
  1019af:	85 c0                	test   %eax,%eax
  1019b1:	75 30                	jne    1019e3 <print_trapframe+0x1c3>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  1019b3:	8b 45 08             	mov    0x8(%ebp),%eax
  1019b6:	8b 40 44             	mov    0x44(%eax),%eax
  1019b9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1019bd:	c7 04 24 5a 37 10 00 	movl   $0x10375a,(%esp)
  1019c4:	e8 52 e9 ff ff       	call   10031b <cprintf>
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  1019c9:	8b 45 08             	mov    0x8(%ebp),%eax
  1019cc:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  1019d0:	0f b7 c0             	movzwl %ax,%eax
  1019d3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1019d7:	c7 04 24 69 37 10 00 	movl   $0x103769,(%esp)
  1019de:	e8 38 e9 ff ff       	call   10031b <cprintf>
    }
}
  1019e3:	c9                   	leave  
  1019e4:	c3                   	ret    

001019e5 <print_regs>:

void
print_regs(struct pushregs *regs) {
  1019e5:	55                   	push   %ebp
  1019e6:	89 e5                	mov    %esp,%ebp
  1019e8:	83 ec 18             	sub    $0x18,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  1019eb:	8b 45 08             	mov    0x8(%ebp),%eax
  1019ee:	8b 00                	mov    (%eax),%eax
  1019f0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1019f4:	c7 04 24 7c 37 10 00 	movl   $0x10377c,(%esp)
  1019fb:	e8 1b e9 ff ff       	call   10031b <cprintf>
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101a00:	8b 45 08             	mov    0x8(%ebp),%eax
  101a03:	8b 40 04             	mov    0x4(%eax),%eax
  101a06:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a0a:	c7 04 24 8b 37 10 00 	movl   $0x10378b,(%esp)
  101a11:	e8 05 e9 ff ff       	call   10031b <cprintf>
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101a16:	8b 45 08             	mov    0x8(%ebp),%eax
  101a19:	8b 40 08             	mov    0x8(%eax),%eax
  101a1c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a20:	c7 04 24 9a 37 10 00 	movl   $0x10379a,(%esp)
  101a27:	e8 ef e8 ff ff       	call   10031b <cprintf>
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101a2c:	8b 45 08             	mov    0x8(%ebp),%eax
  101a2f:	8b 40 0c             	mov    0xc(%eax),%eax
  101a32:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a36:	c7 04 24 a9 37 10 00 	movl   $0x1037a9,(%esp)
  101a3d:	e8 d9 e8 ff ff       	call   10031b <cprintf>
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101a42:	8b 45 08             	mov    0x8(%ebp),%eax
  101a45:	8b 40 10             	mov    0x10(%eax),%eax
  101a48:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a4c:	c7 04 24 b8 37 10 00 	movl   $0x1037b8,(%esp)
  101a53:	e8 c3 e8 ff ff       	call   10031b <cprintf>
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101a58:	8b 45 08             	mov    0x8(%ebp),%eax
  101a5b:	8b 40 14             	mov    0x14(%eax),%eax
  101a5e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a62:	c7 04 24 c7 37 10 00 	movl   $0x1037c7,(%esp)
  101a69:	e8 ad e8 ff ff       	call   10031b <cprintf>
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101a6e:	8b 45 08             	mov    0x8(%ebp),%eax
  101a71:	8b 40 18             	mov    0x18(%eax),%eax
  101a74:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a78:	c7 04 24 d6 37 10 00 	movl   $0x1037d6,(%esp)
  101a7f:	e8 97 e8 ff ff       	call   10031b <cprintf>
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101a84:	8b 45 08             	mov    0x8(%ebp),%eax
  101a87:	8b 40 1c             	mov    0x1c(%eax),%eax
  101a8a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a8e:	c7 04 24 e5 37 10 00 	movl   $0x1037e5,(%esp)
  101a95:	e8 81 e8 ff ff       	call   10031b <cprintf>
}
  101a9a:	c9                   	leave  
  101a9b:	c3                   	ret    

00101a9c <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101a9c:	55                   	push   %ebp
  101a9d:	89 e5                	mov    %esp,%ebp
  101a9f:	83 ec 28             	sub    $0x28,%esp
    char c;

    switch (tf->tf_trapno) {
  101aa2:	8b 45 08             	mov    0x8(%ebp),%eax
  101aa5:	8b 40 30             	mov    0x30(%eax),%eax
  101aa8:	83 f8 2f             	cmp    $0x2f,%eax
  101aab:	77 1e                	ja     101acb <trap_dispatch+0x2f>
  101aad:	83 f8 2e             	cmp    $0x2e,%eax
  101ab0:	0f 83 bf 00 00 00    	jae    101b75 <trap_dispatch+0xd9>
  101ab6:	83 f8 21             	cmp    $0x21,%eax
  101ab9:	74 40                	je     101afb <trap_dispatch+0x5f>
  101abb:	83 f8 24             	cmp    $0x24,%eax
  101abe:	74 15                	je     101ad5 <trap_dispatch+0x39>
  101ac0:	83 f8 20             	cmp    $0x20,%eax
  101ac3:	0f 84 af 00 00 00    	je     101b78 <trap_dispatch+0xdc>
  101ac9:	eb 72                	jmp    101b3d <trap_dispatch+0xa1>
  101acb:	83 e8 78             	sub    $0x78,%eax
  101ace:	83 f8 01             	cmp    $0x1,%eax
  101ad1:	77 6a                	ja     101b3d <trap_dispatch+0xa1>
  101ad3:	eb 4c                	jmp    101b21 <trap_dispatch+0x85>
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        break;
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101ad5:	e8 ad fa ff ff       	call   101587 <cons_getc>
  101ada:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101add:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101ae1:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101ae5:	89 54 24 08          	mov    %edx,0x8(%esp)
  101ae9:	89 44 24 04          	mov    %eax,0x4(%esp)
  101aed:	c7 04 24 f4 37 10 00 	movl   $0x1037f4,(%esp)
  101af4:	e8 22 e8 ff ff       	call   10031b <cprintf>
        break;
  101af9:	eb 7e                	jmp    101b79 <trap_dispatch+0xdd>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101afb:	e8 87 fa ff ff       	call   101587 <cons_getc>
  101b00:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101b03:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101b07:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101b0b:	89 54 24 08          	mov    %edx,0x8(%esp)
  101b0f:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b13:	c7 04 24 06 38 10 00 	movl   $0x103806,(%esp)
  101b1a:	e8 fc e7 ff ff       	call   10031b <cprintf>
        break;
  101b1f:	eb 58                	jmp    101b79 <trap_dispatch+0xdd>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
    case T_SWITCH_TOK:
        panic("T_SWITCH_** ??\n");
  101b21:	c7 44 24 08 15 38 10 	movl   $0x103815,0x8(%esp)
  101b28:	00 
  101b29:	c7 44 24 04 a2 00 00 	movl   $0xa2,0x4(%esp)
  101b30:	00 
  101b31:	c7 04 24 25 38 10 00 	movl   $0x103825,(%esp)
  101b38:	e8 83 f0 ff ff       	call   100bc0 <__panic>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101b3d:	8b 45 08             	mov    0x8(%ebp),%eax
  101b40:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101b44:	0f b7 c0             	movzwl %ax,%eax
  101b47:	83 e0 03             	and    $0x3,%eax
  101b4a:	85 c0                	test   %eax,%eax
  101b4c:	75 2b                	jne    101b79 <trap_dispatch+0xdd>
            print_trapframe(tf);
  101b4e:	8b 45 08             	mov    0x8(%ebp),%eax
  101b51:	89 04 24             	mov    %eax,(%esp)
  101b54:	e8 c7 fc ff ff       	call   101820 <print_trapframe>
            panic("unexpected trap in kernel.\n");
  101b59:	c7 44 24 08 36 38 10 	movl   $0x103836,0x8(%esp)
  101b60:	00 
  101b61:	c7 44 24 04 ac 00 00 	movl   $0xac,0x4(%esp)
  101b68:	00 
  101b69:	c7 04 24 25 38 10 00 	movl   $0x103825,(%esp)
  101b70:	e8 4b f0 ff ff       	call   100bc0 <__panic>
        panic("T_SWITCH_** ??\n");
        break;
    case IRQ_OFFSET + IRQ_IDE1:
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
  101b75:	90                   	nop
  101b76:	eb 01                	jmp    101b79 <trap_dispatch+0xdd>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        break;
  101b78:	90                   	nop
        if ((tf->tf_cs & 3) == 0) {
            print_trapframe(tf);
            panic("unexpected trap in kernel.\n");
        }
    }
}
  101b79:	c9                   	leave  
  101b7a:	c3                   	ret    

00101b7b <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101b7b:	55                   	push   %ebp
  101b7c:	89 e5                	mov    %esp,%ebp
  101b7e:	83 ec 18             	sub    $0x18,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101b81:	8b 45 08             	mov    0x8(%ebp),%eax
  101b84:	89 04 24             	mov    %eax,(%esp)
  101b87:	e8 10 ff ff ff       	call   101a9c <trap_dispatch>
}
  101b8c:	c9                   	leave  
  101b8d:	c3                   	ret    
	...

00101b90 <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  101b90:	1e                   	push   %ds
    pushl %es
  101b91:	06                   	push   %es
    pushl %fs
  101b92:	0f a0                	push   %fs
    pushl %gs
  101b94:	0f a8                	push   %gs
    pushal
  101b96:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  101b97:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  101b9c:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  101b9e:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  101ba0:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  101ba1:	e8 d5 ff ff ff       	call   101b7b <trap>

    # pop the pushed stack pointer
    popl %esp
  101ba6:	5c                   	pop    %esp

00101ba7 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  101ba7:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  101ba8:	0f a9                	pop    %gs
    popl %fs
  101baa:	0f a1                	pop    %fs
    popl %es
  101bac:	07                   	pop    %es
    popl %ds
  101bad:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  101bae:	83 c4 08             	add    $0x8,%esp
    iret
  101bb1:	cf                   	iret   
	...

00101bb4 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101bb4:	6a 00                	push   $0x0
  pushl $0
  101bb6:	6a 00                	push   $0x0
  jmp __alltraps
  101bb8:	e9 d3 ff ff ff       	jmp    101b90 <__alltraps>

00101bbd <vector1>:
.globl vector1
vector1:
  pushl $0
  101bbd:	6a 00                	push   $0x0
  pushl $1
  101bbf:	6a 01                	push   $0x1
  jmp __alltraps
  101bc1:	e9 ca ff ff ff       	jmp    101b90 <__alltraps>

00101bc6 <vector2>:
.globl vector2
vector2:
  pushl $0
  101bc6:	6a 00                	push   $0x0
  pushl $2
  101bc8:	6a 02                	push   $0x2
  jmp __alltraps
  101bca:	e9 c1 ff ff ff       	jmp    101b90 <__alltraps>

00101bcf <vector3>:
.globl vector3
vector3:
  pushl $0
  101bcf:	6a 00                	push   $0x0
  pushl $3
  101bd1:	6a 03                	push   $0x3
  jmp __alltraps
  101bd3:	e9 b8 ff ff ff       	jmp    101b90 <__alltraps>

00101bd8 <vector4>:
.globl vector4
vector4:
  pushl $0
  101bd8:	6a 00                	push   $0x0
  pushl $4
  101bda:	6a 04                	push   $0x4
  jmp __alltraps
  101bdc:	e9 af ff ff ff       	jmp    101b90 <__alltraps>

00101be1 <vector5>:
.globl vector5
vector5:
  pushl $0
  101be1:	6a 00                	push   $0x0
  pushl $5
  101be3:	6a 05                	push   $0x5
  jmp __alltraps
  101be5:	e9 a6 ff ff ff       	jmp    101b90 <__alltraps>

00101bea <vector6>:
.globl vector6
vector6:
  pushl $0
  101bea:	6a 00                	push   $0x0
  pushl $6
  101bec:	6a 06                	push   $0x6
  jmp __alltraps
  101bee:	e9 9d ff ff ff       	jmp    101b90 <__alltraps>

00101bf3 <vector7>:
.globl vector7
vector7:
  pushl $0
  101bf3:	6a 00                	push   $0x0
  pushl $7
  101bf5:	6a 07                	push   $0x7
  jmp __alltraps
  101bf7:	e9 94 ff ff ff       	jmp    101b90 <__alltraps>

00101bfc <vector8>:
.globl vector8
vector8:
  pushl $8
  101bfc:	6a 08                	push   $0x8
  jmp __alltraps
  101bfe:	e9 8d ff ff ff       	jmp    101b90 <__alltraps>

00101c03 <vector9>:
.globl vector9
vector9:
  pushl $9
  101c03:	6a 09                	push   $0x9
  jmp __alltraps
  101c05:	e9 86 ff ff ff       	jmp    101b90 <__alltraps>

00101c0a <vector10>:
.globl vector10
vector10:
  pushl $10
  101c0a:	6a 0a                	push   $0xa
  jmp __alltraps
  101c0c:	e9 7f ff ff ff       	jmp    101b90 <__alltraps>

00101c11 <vector11>:
.globl vector11
vector11:
  pushl $11
  101c11:	6a 0b                	push   $0xb
  jmp __alltraps
  101c13:	e9 78 ff ff ff       	jmp    101b90 <__alltraps>

00101c18 <vector12>:
.globl vector12
vector12:
  pushl $12
  101c18:	6a 0c                	push   $0xc
  jmp __alltraps
  101c1a:	e9 71 ff ff ff       	jmp    101b90 <__alltraps>

00101c1f <vector13>:
.globl vector13
vector13:
  pushl $13
  101c1f:	6a 0d                	push   $0xd
  jmp __alltraps
  101c21:	e9 6a ff ff ff       	jmp    101b90 <__alltraps>

00101c26 <vector14>:
.globl vector14
vector14:
  pushl $14
  101c26:	6a 0e                	push   $0xe
  jmp __alltraps
  101c28:	e9 63 ff ff ff       	jmp    101b90 <__alltraps>

00101c2d <vector15>:
.globl vector15
vector15:
  pushl $0
  101c2d:	6a 00                	push   $0x0
  pushl $15
  101c2f:	6a 0f                	push   $0xf
  jmp __alltraps
  101c31:	e9 5a ff ff ff       	jmp    101b90 <__alltraps>

00101c36 <vector16>:
.globl vector16
vector16:
  pushl $0
  101c36:	6a 00                	push   $0x0
  pushl $16
  101c38:	6a 10                	push   $0x10
  jmp __alltraps
  101c3a:	e9 51 ff ff ff       	jmp    101b90 <__alltraps>

00101c3f <vector17>:
.globl vector17
vector17:
  pushl $17
  101c3f:	6a 11                	push   $0x11
  jmp __alltraps
  101c41:	e9 4a ff ff ff       	jmp    101b90 <__alltraps>

00101c46 <vector18>:
.globl vector18
vector18:
  pushl $0
  101c46:	6a 00                	push   $0x0
  pushl $18
  101c48:	6a 12                	push   $0x12
  jmp __alltraps
  101c4a:	e9 41 ff ff ff       	jmp    101b90 <__alltraps>

00101c4f <vector19>:
.globl vector19
vector19:
  pushl $0
  101c4f:	6a 00                	push   $0x0
  pushl $19
  101c51:	6a 13                	push   $0x13
  jmp __alltraps
  101c53:	e9 38 ff ff ff       	jmp    101b90 <__alltraps>

00101c58 <vector20>:
.globl vector20
vector20:
  pushl $0
  101c58:	6a 00                	push   $0x0
  pushl $20
  101c5a:	6a 14                	push   $0x14
  jmp __alltraps
  101c5c:	e9 2f ff ff ff       	jmp    101b90 <__alltraps>

00101c61 <vector21>:
.globl vector21
vector21:
  pushl $0
  101c61:	6a 00                	push   $0x0
  pushl $21
  101c63:	6a 15                	push   $0x15
  jmp __alltraps
  101c65:	e9 26 ff ff ff       	jmp    101b90 <__alltraps>

00101c6a <vector22>:
.globl vector22
vector22:
  pushl $0
  101c6a:	6a 00                	push   $0x0
  pushl $22
  101c6c:	6a 16                	push   $0x16
  jmp __alltraps
  101c6e:	e9 1d ff ff ff       	jmp    101b90 <__alltraps>

00101c73 <vector23>:
.globl vector23
vector23:
  pushl $0
  101c73:	6a 00                	push   $0x0
  pushl $23
  101c75:	6a 17                	push   $0x17
  jmp __alltraps
  101c77:	e9 14 ff ff ff       	jmp    101b90 <__alltraps>

00101c7c <vector24>:
.globl vector24
vector24:
  pushl $0
  101c7c:	6a 00                	push   $0x0
  pushl $24
  101c7e:	6a 18                	push   $0x18
  jmp __alltraps
  101c80:	e9 0b ff ff ff       	jmp    101b90 <__alltraps>

00101c85 <vector25>:
.globl vector25
vector25:
  pushl $0
  101c85:	6a 00                	push   $0x0
  pushl $25
  101c87:	6a 19                	push   $0x19
  jmp __alltraps
  101c89:	e9 02 ff ff ff       	jmp    101b90 <__alltraps>

00101c8e <vector26>:
.globl vector26
vector26:
  pushl $0
  101c8e:	6a 00                	push   $0x0
  pushl $26
  101c90:	6a 1a                	push   $0x1a
  jmp __alltraps
  101c92:	e9 f9 fe ff ff       	jmp    101b90 <__alltraps>

00101c97 <vector27>:
.globl vector27
vector27:
  pushl $0
  101c97:	6a 00                	push   $0x0
  pushl $27
  101c99:	6a 1b                	push   $0x1b
  jmp __alltraps
  101c9b:	e9 f0 fe ff ff       	jmp    101b90 <__alltraps>

00101ca0 <vector28>:
.globl vector28
vector28:
  pushl $0
  101ca0:	6a 00                	push   $0x0
  pushl $28
  101ca2:	6a 1c                	push   $0x1c
  jmp __alltraps
  101ca4:	e9 e7 fe ff ff       	jmp    101b90 <__alltraps>

00101ca9 <vector29>:
.globl vector29
vector29:
  pushl $0
  101ca9:	6a 00                	push   $0x0
  pushl $29
  101cab:	6a 1d                	push   $0x1d
  jmp __alltraps
  101cad:	e9 de fe ff ff       	jmp    101b90 <__alltraps>

00101cb2 <vector30>:
.globl vector30
vector30:
  pushl $0
  101cb2:	6a 00                	push   $0x0
  pushl $30
  101cb4:	6a 1e                	push   $0x1e
  jmp __alltraps
  101cb6:	e9 d5 fe ff ff       	jmp    101b90 <__alltraps>

00101cbb <vector31>:
.globl vector31
vector31:
  pushl $0
  101cbb:	6a 00                	push   $0x0
  pushl $31
  101cbd:	6a 1f                	push   $0x1f
  jmp __alltraps
  101cbf:	e9 cc fe ff ff       	jmp    101b90 <__alltraps>

00101cc4 <vector32>:
.globl vector32
vector32:
  pushl $0
  101cc4:	6a 00                	push   $0x0
  pushl $32
  101cc6:	6a 20                	push   $0x20
  jmp __alltraps
  101cc8:	e9 c3 fe ff ff       	jmp    101b90 <__alltraps>

00101ccd <vector33>:
.globl vector33
vector33:
  pushl $0
  101ccd:	6a 00                	push   $0x0
  pushl $33
  101ccf:	6a 21                	push   $0x21
  jmp __alltraps
  101cd1:	e9 ba fe ff ff       	jmp    101b90 <__alltraps>

00101cd6 <vector34>:
.globl vector34
vector34:
  pushl $0
  101cd6:	6a 00                	push   $0x0
  pushl $34
  101cd8:	6a 22                	push   $0x22
  jmp __alltraps
  101cda:	e9 b1 fe ff ff       	jmp    101b90 <__alltraps>

00101cdf <vector35>:
.globl vector35
vector35:
  pushl $0
  101cdf:	6a 00                	push   $0x0
  pushl $35
  101ce1:	6a 23                	push   $0x23
  jmp __alltraps
  101ce3:	e9 a8 fe ff ff       	jmp    101b90 <__alltraps>

00101ce8 <vector36>:
.globl vector36
vector36:
  pushl $0
  101ce8:	6a 00                	push   $0x0
  pushl $36
  101cea:	6a 24                	push   $0x24
  jmp __alltraps
  101cec:	e9 9f fe ff ff       	jmp    101b90 <__alltraps>

00101cf1 <vector37>:
.globl vector37
vector37:
  pushl $0
  101cf1:	6a 00                	push   $0x0
  pushl $37
  101cf3:	6a 25                	push   $0x25
  jmp __alltraps
  101cf5:	e9 96 fe ff ff       	jmp    101b90 <__alltraps>

00101cfa <vector38>:
.globl vector38
vector38:
  pushl $0
  101cfa:	6a 00                	push   $0x0
  pushl $38
  101cfc:	6a 26                	push   $0x26
  jmp __alltraps
  101cfe:	e9 8d fe ff ff       	jmp    101b90 <__alltraps>

00101d03 <vector39>:
.globl vector39
vector39:
  pushl $0
  101d03:	6a 00                	push   $0x0
  pushl $39
  101d05:	6a 27                	push   $0x27
  jmp __alltraps
  101d07:	e9 84 fe ff ff       	jmp    101b90 <__alltraps>

00101d0c <vector40>:
.globl vector40
vector40:
  pushl $0
  101d0c:	6a 00                	push   $0x0
  pushl $40
  101d0e:	6a 28                	push   $0x28
  jmp __alltraps
  101d10:	e9 7b fe ff ff       	jmp    101b90 <__alltraps>

00101d15 <vector41>:
.globl vector41
vector41:
  pushl $0
  101d15:	6a 00                	push   $0x0
  pushl $41
  101d17:	6a 29                	push   $0x29
  jmp __alltraps
  101d19:	e9 72 fe ff ff       	jmp    101b90 <__alltraps>

00101d1e <vector42>:
.globl vector42
vector42:
  pushl $0
  101d1e:	6a 00                	push   $0x0
  pushl $42
  101d20:	6a 2a                	push   $0x2a
  jmp __alltraps
  101d22:	e9 69 fe ff ff       	jmp    101b90 <__alltraps>

00101d27 <vector43>:
.globl vector43
vector43:
  pushl $0
  101d27:	6a 00                	push   $0x0
  pushl $43
  101d29:	6a 2b                	push   $0x2b
  jmp __alltraps
  101d2b:	e9 60 fe ff ff       	jmp    101b90 <__alltraps>

00101d30 <vector44>:
.globl vector44
vector44:
  pushl $0
  101d30:	6a 00                	push   $0x0
  pushl $44
  101d32:	6a 2c                	push   $0x2c
  jmp __alltraps
  101d34:	e9 57 fe ff ff       	jmp    101b90 <__alltraps>

00101d39 <vector45>:
.globl vector45
vector45:
  pushl $0
  101d39:	6a 00                	push   $0x0
  pushl $45
  101d3b:	6a 2d                	push   $0x2d
  jmp __alltraps
  101d3d:	e9 4e fe ff ff       	jmp    101b90 <__alltraps>

00101d42 <vector46>:
.globl vector46
vector46:
  pushl $0
  101d42:	6a 00                	push   $0x0
  pushl $46
  101d44:	6a 2e                	push   $0x2e
  jmp __alltraps
  101d46:	e9 45 fe ff ff       	jmp    101b90 <__alltraps>

00101d4b <vector47>:
.globl vector47
vector47:
  pushl $0
  101d4b:	6a 00                	push   $0x0
  pushl $47
  101d4d:	6a 2f                	push   $0x2f
  jmp __alltraps
  101d4f:	e9 3c fe ff ff       	jmp    101b90 <__alltraps>

00101d54 <vector48>:
.globl vector48
vector48:
  pushl $0
  101d54:	6a 00                	push   $0x0
  pushl $48
  101d56:	6a 30                	push   $0x30
  jmp __alltraps
  101d58:	e9 33 fe ff ff       	jmp    101b90 <__alltraps>

00101d5d <vector49>:
.globl vector49
vector49:
  pushl $0
  101d5d:	6a 00                	push   $0x0
  pushl $49
  101d5f:	6a 31                	push   $0x31
  jmp __alltraps
  101d61:	e9 2a fe ff ff       	jmp    101b90 <__alltraps>

00101d66 <vector50>:
.globl vector50
vector50:
  pushl $0
  101d66:	6a 00                	push   $0x0
  pushl $50
  101d68:	6a 32                	push   $0x32
  jmp __alltraps
  101d6a:	e9 21 fe ff ff       	jmp    101b90 <__alltraps>

00101d6f <vector51>:
.globl vector51
vector51:
  pushl $0
  101d6f:	6a 00                	push   $0x0
  pushl $51
  101d71:	6a 33                	push   $0x33
  jmp __alltraps
  101d73:	e9 18 fe ff ff       	jmp    101b90 <__alltraps>

00101d78 <vector52>:
.globl vector52
vector52:
  pushl $0
  101d78:	6a 00                	push   $0x0
  pushl $52
  101d7a:	6a 34                	push   $0x34
  jmp __alltraps
  101d7c:	e9 0f fe ff ff       	jmp    101b90 <__alltraps>

00101d81 <vector53>:
.globl vector53
vector53:
  pushl $0
  101d81:	6a 00                	push   $0x0
  pushl $53
  101d83:	6a 35                	push   $0x35
  jmp __alltraps
  101d85:	e9 06 fe ff ff       	jmp    101b90 <__alltraps>

00101d8a <vector54>:
.globl vector54
vector54:
  pushl $0
  101d8a:	6a 00                	push   $0x0
  pushl $54
  101d8c:	6a 36                	push   $0x36
  jmp __alltraps
  101d8e:	e9 fd fd ff ff       	jmp    101b90 <__alltraps>

00101d93 <vector55>:
.globl vector55
vector55:
  pushl $0
  101d93:	6a 00                	push   $0x0
  pushl $55
  101d95:	6a 37                	push   $0x37
  jmp __alltraps
  101d97:	e9 f4 fd ff ff       	jmp    101b90 <__alltraps>

00101d9c <vector56>:
.globl vector56
vector56:
  pushl $0
  101d9c:	6a 00                	push   $0x0
  pushl $56
  101d9e:	6a 38                	push   $0x38
  jmp __alltraps
  101da0:	e9 eb fd ff ff       	jmp    101b90 <__alltraps>

00101da5 <vector57>:
.globl vector57
vector57:
  pushl $0
  101da5:	6a 00                	push   $0x0
  pushl $57
  101da7:	6a 39                	push   $0x39
  jmp __alltraps
  101da9:	e9 e2 fd ff ff       	jmp    101b90 <__alltraps>

00101dae <vector58>:
.globl vector58
vector58:
  pushl $0
  101dae:	6a 00                	push   $0x0
  pushl $58
  101db0:	6a 3a                	push   $0x3a
  jmp __alltraps
  101db2:	e9 d9 fd ff ff       	jmp    101b90 <__alltraps>

00101db7 <vector59>:
.globl vector59
vector59:
  pushl $0
  101db7:	6a 00                	push   $0x0
  pushl $59
  101db9:	6a 3b                	push   $0x3b
  jmp __alltraps
  101dbb:	e9 d0 fd ff ff       	jmp    101b90 <__alltraps>

00101dc0 <vector60>:
.globl vector60
vector60:
  pushl $0
  101dc0:	6a 00                	push   $0x0
  pushl $60
  101dc2:	6a 3c                	push   $0x3c
  jmp __alltraps
  101dc4:	e9 c7 fd ff ff       	jmp    101b90 <__alltraps>

00101dc9 <vector61>:
.globl vector61
vector61:
  pushl $0
  101dc9:	6a 00                	push   $0x0
  pushl $61
  101dcb:	6a 3d                	push   $0x3d
  jmp __alltraps
  101dcd:	e9 be fd ff ff       	jmp    101b90 <__alltraps>

00101dd2 <vector62>:
.globl vector62
vector62:
  pushl $0
  101dd2:	6a 00                	push   $0x0
  pushl $62
  101dd4:	6a 3e                	push   $0x3e
  jmp __alltraps
  101dd6:	e9 b5 fd ff ff       	jmp    101b90 <__alltraps>

00101ddb <vector63>:
.globl vector63
vector63:
  pushl $0
  101ddb:	6a 00                	push   $0x0
  pushl $63
  101ddd:	6a 3f                	push   $0x3f
  jmp __alltraps
  101ddf:	e9 ac fd ff ff       	jmp    101b90 <__alltraps>

00101de4 <vector64>:
.globl vector64
vector64:
  pushl $0
  101de4:	6a 00                	push   $0x0
  pushl $64
  101de6:	6a 40                	push   $0x40
  jmp __alltraps
  101de8:	e9 a3 fd ff ff       	jmp    101b90 <__alltraps>

00101ded <vector65>:
.globl vector65
vector65:
  pushl $0
  101ded:	6a 00                	push   $0x0
  pushl $65
  101def:	6a 41                	push   $0x41
  jmp __alltraps
  101df1:	e9 9a fd ff ff       	jmp    101b90 <__alltraps>

00101df6 <vector66>:
.globl vector66
vector66:
  pushl $0
  101df6:	6a 00                	push   $0x0
  pushl $66
  101df8:	6a 42                	push   $0x42
  jmp __alltraps
  101dfa:	e9 91 fd ff ff       	jmp    101b90 <__alltraps>

00101dff <vector67>:
.globl vector67
vector67:
  pushl $0
  101dff:	6a 00                	push   $0x0
  pushl $67
  101e01:	6a 43                	push   $0x43
  jmp __alltraps
  101e03:	e9 88 fd ff ff       	jmp    101b90 <__alltraps>

00101e08 <vector68>:
.globl vector68
vector68:
  pushl $0
  101e08:	6a 00                	push   $0x0
  pushl $68
  101e0a:	6a 44                	push   $0x44
  jmp __alltraps
  101e0c:	e9 7f fd ff ff       	jmp    101b90 <__alltraps>

00101e11 <vector69>:
.globl vector69
vector69:
  pushl $0
  101e11:	6a 00                	push   $0x0
  pushl $69
  101e13:	6a 45                	push   $0x45
  jmp __alltraps
  101e15:	e9 76 fd ff ff       	jmp    101b90 <__alltraps>

00101e1a <vector70>:
.globl vector70
vector70:
  pushl $0
  101e1a:	6a 00                	push   $0x0
  pushl $70
  101e1c:	6a 46                	push   $0x46
  jmp __alltraps
  101e1e:	e9 6d fd ff ff       	jmp    101b90 <__alltraps>

00101e23 <vector71>:
.globl vector71
vector71:
  pushl $0
  101e23:	6a 00                	push   $0x0
  pushl $71
  101e25:	6a 47                	push   $0x47
  jmp __alltraps
  101e27:	e9 64 fd ff ff       	jmp    101b90 <__alltraps>

00101e2c <vector72>:
.globl vector72
vector72:
  pushl $0
  101e2c:	6a 00                	push   $0x0
  pushl $72
  101e2e:	6a 48                	push   $0x48
  jmp __alltraps
  101e30:	e9 5b fd ff ff       	jmp    101b90 <__alltraps>

00101e35 <vector73>:
.globl vector73
vector73:
  pushl $0
  101e35:	6a 00                	push   $0x0
  pushl $73
  101e37:	6a 49                	push   $0x49
  jmp __alltraps
  101e39:	e9 52 fd ff ff       	jmp    101b90 <__alltraps>

00101e3e <vector74>:
.globl vector74
vector74:
  pushl $0
  101e3e:	6a 00                	push   $0x0
  pushl $74
  101e40:	6a 4a                	push   $0x4a
  jmp __alltraps
  101e42:	e9 49 fd ff ff       	jmp    101b90 <__alltraps>

00101e47 <vector75>:
.globl vector75
vector75:
  pushl $0
  101e47:	6a 00                	push   $0x0
  pushl $75
  101e49:	6a 4b                	push   $0x4b
  jmp __alltraps
  101e4b:	e9 40 fd ff ff       	jmp    101b90 <__alltraps>

00101e50 <vector76>:
.globl vector76
vector76:
  pushl $0
  101e50:	6a 00                	push   $0x0
  pushl $76
  101e52:	6a 4c                	push   $0x4c
  jmp __alltraps
  101e54:	e9 37 fd ff ff       	jmp    101b90 <__alltraps>

00101e59 <vector77>:
.globl vector77
vector77:
  pushl $0
  101e59:	6a 00                	push   $0x0
  pushl $77
  101e5b:	6a 4d                	push   $0x4d
  jmp __alltraps
  101e5d:	e9 2e fd ff ff       	jmp    101b90 <__alltraps>

00101e62 <vector78>:
.globl vector78
vector78:
  pushl $0
  101e62:	6a 00                	push   $0x0
  pushl $78
  101e64:	6a 4e                	push   $0x4e
  jmp __alltraps
  101e66:	e9 25 fd ff ff       	jmp    101b90 <__alltraps>

00101e6b <vector79>:
.globl vector79
vector79:
  pushl $0
  101e6b:	6a 00                	push   $0x0
  pushl $79
  101e6d:	6a 4f                	push   $0x4f
  jmp __alltraps
  101e6f:	e9 1c fd ff ff       	jmp    101b90 <__alltraps>

00101e74 <vector80>:
.globl vector80
vector80:
  pushl $0
  101e74:	6a 00                	push   $0x0
  pushl $80
  101e76:	6a 50                	push   $0x50
  jmp __alltraps
  101e78:	e9 13 fd ff ff       	jmp    101b90 <__alltraps>

00101e7d <vector81>:
.globl vector81
vector81:
  pushl $0
  101e7d:	6a 00                	push   $0x0
  pushl $81
  101e7f:	6a 51                	push   $0x51
  jmp __alltraps
  101e81:	e9 0a fd ff ff       	jmp    101b90 <__alltraps>

00101e86 <vector82>:
.globl vector82
vector82:
  pushl $0
  101e86:	6a 00                	push   $0x0
  pushl $82
  101e88:	6a 52                	push   $0x52
  jmp __alltraps
  101e8a:	e9 01 fd ff ff       	jmp    101b90 <__alltraps>

00101e8f <vector83>:
.globl vector83
vector83:
  pushl $0
  101e8f:	6a 00                	push   $0x0
  pushl $83
  101e91:	6a 53                	push   $0x53
  jmp __alltraps
  101e93:	e9 f8 fc ff ff       	jmp    101b90 <__alltraps>

00101e98 <vector84>:
.globl vector84
vector84:
  pushl $0
  101e98:	6a 00                	push   $0x0
  pushl $84
  101e9a:	6a 54                	push   $0x54
  jmp __alltraps
  101e9c:	e9 ef fc ff ff       	jmp    101b90 <__alltraps>

00101ea1 <vector85>:
.globl vector85
vector85:
  pushl $0
  101ea1:	6a 00                	push   $0x0
  pushl $85
  101ea3:	6a 55                	push   $0x55
  jmp __alltraps
  101ea5:	e9 e6 fc ff ff       	jmp    101b90 <__alltraps>

00101eaa <vector86>:
.globl vector86
vector86:
  pushl $0
  101eaa:	6a 00                	push   $0x0
  pushl $86
  101eac:	6a 56                	push   $0x56
  jmp __alltraps
  101eae:	e9 dd fc ff ff       	jmp    101b90 <__alltraps>

00101eb3 <vector87>:
.globl vector87
vector87:
  pushl $0
  101eb3:	6a 00                	push   $0x0
  pushl $87
  101eb5:	6a 57                	push   $0x57
  jmp __alltraps
  101eb7:	e9 d4 fc ff ff       	jmp    101b90 <__alltraps>

00101ebc <vector88>:
.globl vector88
vector88:
  pushl $0
  101ebc:	6a 00                	push   $0x0
  pushl $88
  101ebe:	6a 58                	push   $0x58
  jmp __alltraps
  101ec0:	e9 cb fc ff ff       	jmp    101b90 <__alltraps>

00101ec5 <vector89>:
.globl vector89
vector89:
  pushl $0
  101ec5:	6a 00                	push   $0x0
  pushl $89
  101ec7:	6a 59                	push   $0x59
  jmp __alltraps
  101ec9:	e9 c2 fc ff ff       	jmp    101b90 <__alltraps>

00101ece <vector90>:
.globl vector90
vector90:
  pushl $0
  101ece:	6a 00                	push   $0x0
  pushl $90
  101ed0:	6a 5a                	push   $0x5a
  jmp __alltraps
  101ed2:	e9 b9 fc ff ff       	jmp    101b90 <__alltraps>

00101ed7 <vector91>:
.globl vector91
vector91:
  pushl $0
  101ed7:	6a 00                	push   $0x0
  pushl $91
  101ed9:	6a 5b                	push   $0x5b
  jmp __alltraps
  101edb:	e9 b0 fc ff ff       	jmp    101b90 <__alltraps>

00101ee0 <vector92>:
.globl vector92
vector92:
  pushl $0
  101ee0:	6a 00                	push   $0x0
  pushl $92
  101ee2:	6a 5c                	push   $0x5c
  jmp __alltraps
  101ee4:	e9 a7 fc ff ff       	jmp    101b90 <__alltraps>

00101ee9 <vector93>:
.globl vector93
vector93:
  pushl $0
  101ee9:	6a 00                	push   $0x0
  pushl $93
  101eeb:	6a 5d                	push   $0x5d
  jmp __alltraps
  101eed:	e9 9e fc ff ff       	jmp    101b90 <__alltraps>

00101ef2 <vector94>:
.globl vector94
vector94:
  pushl $0
  101ef2:	6a 00                	push   $0x0
  pushl $94
  101ef4:	6a 5e                	push   $0x5e
  jmp __alltraps
  101ef6:	e9 95 fc ff ff       	jmp    101b90 <__alltraps>

00101efb <vector95>:
.globl vector95
vector95:
  pushl $0
  101efb:	6a 00                	push   $0x0
  pushl $95
  101efd:	6a 5f                	push   $0x5f
  jmp __alltraps
  101eff:	e9 8c fc ff ff       	jmp    101b90 <__alltraps>

00101f04 <vector96>:
.globl vector96
vector96:
  pushl $0
  101f04:	6a 00                	push   $0x0
  pushl $96
  101f06:	6a 60                	push   $0x60
  jmp __alltraps
  101f08:	e9 83 fc ff ff       	jmp    101b90 <__alltraps>

00101f0d <vector97>:
.globl vector97
vector97:
  pushl $0
  101f0d:	6a 00                	push   $0x0
  pushl $97
  101f0f:	6a 61                	push   $0x61
  jmp __alltraps
  101f11:	e9 7a fc ff ff       	jmp    101b90 <__alltraps>

00101f16 <vector98>:
.globl vector98
vector98:
  pushl $0
  101f16:	6a 00                	push   $0x0
  pushl $98
  101f18:	6a 62                	push   $0x62
  jmp __alltraps
  101f1a:	e9 71 fc ff ff       	jmp    101b90 <__alltraps>

00101f1f <vector99>:
.globl vector99
vector99:
  pushl $0
  101f1f:	6a 00                	push   $0x0
  pushl $99
  101f21:	6a 63                	push   $0x63
  jmp __alltraps
  101f23:	e9 68 fc ff ff       	jmp    101b90 <__alltraps>

00101f28 <vector100>:
.globl vector100
vector100:
  pushl $0
  101f28:	6a 00                	push   $0x0
  pushl $100
  101f2a:	6a 64                	push   $0x64
  jmp __alltraps
  101f2c:	e9 5f fc ff ff       	jmp    101b90 <__alltraps>

00101f31 <vector101>:
.globl vector101
vector101:
  pushl $0
  101f31:	6a 00                	push   $0x0
  pushl $101
  101f33:	6a 65                	push   $0x65
  jmp __alltraps
  101f35:	e9 56 fc ff ff       	jmp    101b90 <__alltraps>

00101f3a <vector102>:
.globl vector102
vector102:
  pushl $0
  101f3a:	6a 00                	push   $0x0
  pushl $102
  101f3c:	6a 66                	push   $0x66
  jmp __alltraps
  101f3e:	e9 4d fc ff ff       	jmp    101b90 <__alltraps>

00101f43 <vector103>:
.globl vector103
vector103:
  pushl $0
  101f43:	6a 00                	push   $0x0
  pushl $103
  101f45:	6a 67                	push   $0x67
  jmp __alltraps
  101f47:	e9 44 fc ff ff       	jmp    101b90 <__alltraps>

00101f4c <vector104>:
.globl vector104
vector104:
  pushl $0
  101f4c:	6a 00                	push   $0x0
  pushl $104
  101f4e:	6a 68                	push   $0x68
  jmp __alltraps
  101f50:	e9 3b fc ff ff       	jmp    101b90 <__alltraps>

00101f55 <vector105>:
.globl vector105
vector105:
  pushl $0
  101f55:	6a 00                	push   $0x0
  pushl $105
  101f57:	6a 69                	push   $0x69
  jmp __alltraps
  101f59:	e9 32 fc ff ff       	jmp    101b90 <__alltraps>

00101f5e <vector106>:
.globl vector106
vector106:
  pushl $0
  101f5e:	6a 00                	push   $0x0
  pushl $106
  101f60:	6a 6a                	push   $0x6a
  jmp __alltraps
  101f62:	e9 29 fc ff ff       	jmp    101b90 <__alltraps>

00101f67 <vector107>:
.globl vector107
vector107:
  pushl $0
  101f67:	6a 00                	push   $0x0
  pushl $107
  101f69:	6a 6b                	push   $0x6b
  jmp __alltraps
  101f6b:	e9 20 fc ff ff       	jmp    101b90 <__alltraps>

00101f70 <vector108>:
.globl vector108
vector108:
  pushl $0
  101f70:	6a 00                	push   $0x0
  pushl $108
  101f72:	6a 6c                	push   $0x6c
  jmp __alltraps
  101f74:	e9 17 fc ff ff       	jmp    101b90 <__alltraps>

00101f79 <vector109>:
.globl vector109
vector109:
  pushl $0
  101f79:	6a 00                	push   $0x0
  pushl $109
  101f7b:	6a 6d                	push   $0x6d
  jmp __alltraps
  101f7d:	e9 0e fc ff ff       	jmp    101b90 <__alltraps>

00101f82 <vector110>:
.globl vector110
vector110:
  pushl $0
  101f82:	6a 00                	push   $0x0
  pushl $110
  101f84:	6a 6e                	push   $0x6e
  jmp __alltraps
  101f86:	e9 05 fc ff ff       	jmp    101b90 <__alltraps>

00101f8b <vector111>:
.globl vector111
vector111:
  pushl $0
  101f8b:	6a 00                	push   $0x0
  pushl $111
  101f8d:	6a 6f                	push   $0x6f
  jmp __alltraps
  101f8f:	e9 fc fb ff ff       	jmp    101b90 <__alltraps>

00101f94 <vector112>:
.globl vector112
vector112:
  pushl $0
  101f94:	6a 00                	push   $0x0
  pushl $112
  101f96:	6a 70                	push   $0x70
  jmp __alltraps
  101f98:	e9 f3 fb ff ff       	jmp    101b90 <__alltraps>

00101f9d <vector113>:
.globl vector113
vector113:
  pushl $0
  101f9d:	6a 00                	push   $0x0
  pushl $113
  101f9f:	6a 71                	push   $0x71
  jmp __alltraps
  101fa1:	e9 ea fb ff ff       	jmp    101b90 <__alltraps>

00101fa6 <vector114>:
.globl vector114
vector114:
  pushl $0
  101fa6:	6a 00                	push   $0x0
  pushl $114
  101fa8:	6a 72                	push   $0x72
  jmp __alltraps
  101faa:	e9 e1 fb ff ff       	jmp    101b90 <__alltraps>

00101faf <vector115>:
.globl vector115
vector115:
  pushl $0
  101faf:	6a 00                	push   $0x0
  pushl $115
  101fb1:	6a 73                	push   $0x73
  jmp __alltraps
  101fb3:	e9 d8 fb ff ff       	jmp    101b90 <__alltraps>

00101fb8 <vector116>:
.globl vector116
vector116:
  pushl $0
  101fb8:	6a 00                	push   $0x0
  pushl $116
  101fba:	6a 74                	push   $0x74
  jmp __alltraps
  101fbc:	e9 cf fb ff ff       	jmp    101b90 <__alltraps>

00101fc1 <vector117>:
.globl vector117
vector117:
  pushl $0
  101fc1:	6a 00                	push   $0x0
  pushl $117
  101fc3:	6a 75                	push   $0x75
  jmp __alltraps
  101fc5:	e9 c6 fb ff ff       	jmp    101b90 <__alltraps>

00101fca <vector118>:
.globl vector118
vector118:
  pushl $0
  101fca:	6a 00                	push   $0x0
  pushl $118
  101fcc:	6a 76                	push   $0x76
  jmp __alltraps
  101fce:	e9 bd fb ff ff       	jmp    101b90 <__alltraps>

00101fd3 <vector119>:
.globl vector119
vector119:
  pushl $0
  101fd3:	6a 00                	push   $0x0
  pushl $119
  101fd5:	6a 77                	push   $0x77
  jmp __alltraps
  101fd7:	e9 b4 fb ff ff       	jmp    101b90 <__alltraps>

00101fdc <vector120>:
.globl vector120
vector120:
  pushl $0
  101fdc:	6a 00                	push   $0x0
  pushl $120
  101fde:	6a 78                	push   $0x78
  jmp __alltraps
  101fe0:	e9 ab fb ff ff       	jmp    101b90 <__alltraps>

00101fe5 <vector121>:
.globl vector121
vector121:
  pushl $0
  101fe5:	6a 00                	push   $0x0
  pushl $121
  101fe7:	6a 79                	push   $0x79
  jmp __alltraps
  101fe9:	e9 a2 fb ff ff       	jmp    101b90 <__alltraps>

00101fee <vector122>:
.globl vector122
vector122:
  pushl $0
  101fee:	6a 00                	push   $0x0
  pushl $122
  101ff0:	6a 7a                	push   $0x7a
  jmp __alltraps
  101ff2:	e9 99 fb ff ff       	jmp    101b90 <__alltraps>

00101ff7 <vector123>:
.globl vector123
vector123:
  pushl $0
  101ff7:	6a 00                	push   $0x0
  pushl $123
  101ff9:	6a 7b                	push   $0x7b
  jmp __alltraps
  101ffb:	e9 90 fb ff ff       	jmp    101b90 <__alltraps>

00102000 <vector124>:
.globl vector124
vector124:
  pushl $0
  102000:	6a 00                	push   $0x0
  pushl $124
  102002:	6a 7c                	push   $0x7c
  jmp __alltraps
  102004:	e9 87 fb ff ff       	jmp    101b90 <__alltraps>

00102009 <vector125>:
.globl vector125
vector125:
  pushl $0
  102009:	6a 00                	push   $0x0
  pushl $125
  10200b:	6a 7d                	push   $0x7d
  jmp __alltraps
  10200d:	e9 7e fb ff ff       	jmp    101b90 <__alltraps>

00102012 <vector126>:
.globl vector126
vector126:
  pushl $0
  102012:	6a 00                	push   $0x0
  pushl $126
  102014:	6a 7e                	push   $0x7e
  jmp __alltraps
  102016:	e9 75 fb ff ff       	jmp    101b90 <__alltraps>

0010201b <vector127>:
.globl vector127
vector127:
  pushl $0
  10201b:	6a 00                	push   $0x0
  pushl $127
  10201d:	6a 7f                	push   $0x7f
  jmp __alltraps
  10201f:	e9 6c fb ff ff       	jmp    101b90 <__alltraps>

00102024 <vector128>:
.globl vector128
vector128:
  pushl $0
  102024:	6a 00                	push   $0x0
  pushl $128
  102026:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  10202b:	e9 60 fb ff ff       	jmp    101b90 <__alltraps>

00102030 <vector129>:
.globl vector129
vector129:
  pushl $0
  102030:	6a 00                	push   $0x0
  pushl $129
  102032:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  102037:	e9 54 fb ff ff       	jmp    101b90 <__alltraps>

0010203c <vector130>:
.globl vector130
vector130:
  pushl $0
  10203c:	6a 00                	push   $0x0
  pushl $130
  10203e:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  102043:	e9 48 fb ff ff       	jmp    101b90 <__alltraps>

00102048 <vector131>:
.globl vector131
vector131:
  pushl $0
  102048:	6a 00                	push   $0x0
  pushl $131
  10204a:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  10204f:	e9 3c fb ff ff       	jmp    101b90 <__alltraps>

00102054 <vector132>:
.globl vector132
vector132:
  pushl $0
  102054:	6a 00                	push   $0x0
  pushl $132
  102056:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  10205b:	e9 30 fb ff ff       	jmp    101b90 <__alltraps>

00102060 <vector133>:
.globl vector133
vector133:
  pushl $0
  102060:	6a 00                	push   $0x0
  pushl $133
  102062:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  102067:	e9 24 fb ff ff       	jmp    101b90 <__alltraps>

0010206c <vector134>:
.globl vector134
vector134:
  pushl $0
  10206c:	6a 00                	push   $0x0
  pushl $134
  10206e:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  102073:	e9 18 fb ff ff       	jmp    101b90 <__alltraps>

00102078 <vector135>:
.globl vector135
vector135:
  pushl $0
  102078:	6a 00                	push   $0x0
  pushl $135
  10207a:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  10207f:	e9 0c fb ff ff       	jmp    101b90 <__alltraps>

00102084 <vector136>:
.globl vector136
vector136:
  pushl $0
  102084:	6a 00                	push   $0x0
  pushl $136
  102086:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  10208b:	e9 00 fb ff ff       	jmp    101b90 <__alltraps>

00102090 <vector137>:
.globl vector137
vector137:
  pushl $0
  102090:	6a 00                	push   $0x0
  pushl $137
  102092:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  102097:	e9 f4 fa ff ff       	jmp    101b90 <__alltraps>

0010209c <vector138>:
.globl vector138
vector138:
  pushl $0
  10209c:	6a 00                	push   $0x0
  pushl $138
  10209e:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  1020a3:	e9 e8 fa ff ff       	jmp    101b90 <__alltraps>

001020a8 <vector139>:
.globl vector139
vector139:
  pushl $0
  1020a8:	6a 00                	push   $0x0
  pushl $139
  1020aa:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  1020af:	e9 dc fa ff ff       	jmp    101b90 <__alltraps>

001020b4 <vector140>:
.globl vector140
vector140:
  pushl $0
  1020b4:	6a 00                	push   $0x0
  pushl $140
  1020b6:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  1020bb:	e9 d0 fa ff ff       	jmp    101b90 <__alltraps>

001020c0 <vector141>:
.globl vector141
vector141:
  pushl $0
  1020c0:	6a 00                	push   $0x0
  pushl $141
  1020c2:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  1020c7:	e9 c4 fa ff ff       	jmp    101b90 <__alltraps>

001020cc <vector142>:
.globl vector142
vector142:
  pushl $0
  1020cc:	6a 00                	push   $0x0
  pushl $142
  1020ce:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  1020d3:	e9 b8 fa ff ff       	jmp    101b90 <__alltraps>

001020d8 <vector143>:
.globl vector143
vector143:
  pushl $0
  1020d8:	6a 00                	push   $0x0
  pushl $143
  1020da:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  1020df:	e9 ac fa ff ff       	jmp    101b90 <__alltraps>

001020e4 <vector144>:
.globl vector144
vector144:
  pushl $0
  1020e4:	6a 00                	push   $0x0
  pushl $144
  1020e6:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  1020eb:	e9 a0 fa ff ff       	jmp    101b90 <__alltraps>

001020f0 <vector145>:
.globl vector145
vector145:
  pushl $0
  1020f0:	6a 00                	push   $0x0
  pushl $145
  1020f2:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  1020f7:	e9 94 fa ff ff       	jmp    101b90 <__alltraps>

001020fc <vector146>:
.globl vector146
vector146:
  pushl $0
  1020fc:	6a 00                	push   $0x0
  pushl $146
  1020fe:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  102103:	e9 88 fa ff ff       	jmp    101b90 <__alltraps>

00102108 <vector147>:
.globl vector147
vector147:
  pushl $0
  102108:	6a 00                	push   $0x0
  pushl $147
  10210a:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  10210f:	e9 7c fa ff ff       	jmp    101b90 <__alltraps>

00102114 <vector148>:
.globl vector148
vector148:
  pushl $0
  102114:	6a 00                	push   $0x0
  pushl $148
  102116:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  10211b:	e9 70 fa ff ff       	jmp    101b90 <__alltraps>

00102120 <vector149>:
.globl vector149
vector149:
  pushl $0
  102120:	6a 00                	push   $0x0
  pushl $149
  102122:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  102127:	e9 64 fa ff ff       	jmp    101b90 <__alltraps>

0010212c <vector150>:
.globl vector150
vector150:
  pushl $0
  10212c:	6a 00                	push   $0x0
  pushl $150
  10212e:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  102133:	e9 58 fa ff ff       	jmp    101b90 <__alltraps>

00102138 <vector151>:
.globl vector151
vector151:
  pushl $0
  102138:	6a 00                	push   $0x0
  pushl $151
  10213a:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  10213f:	e9 4c fa ff ff       	jmp    101b90 <__alltraps>

00102144 <vector152>:
.globl vector152
vector152:
  pushl $0
  102144:	6a 00                	push   $0x0
  pushl $152
  102146:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  10214b:	e9 40 fa ff ff       	jmp    101b90 <__alltraps>

00102150 <vector153>:
.globl vector153
vector153:
  pushl $0
  102150:	6a 00                	push   $0x0
  pushl $153
  102152:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  102157:	e9 34 fa ff ff       	jmp    101b90 <__alltraps>

0010215c <vector154>:
.globl vector154
vector154:
  pushl $0
  10215c:	6a 00                	push   $0x0
  pushl $154
  10215e:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  102163:	e9 28 fa ff ff       	jmp    101b90 <__alltraps>

00102168 <vector155>:
.globl vector155
vector155:
  pushl $0
  102168:	6a 00                	push   $0x0
  pushl $155
  10216a:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  10216f:	e9 1c fa ff ff       	jmp    101b90 <__alltraps>

00102174 <vector156>:
.globl vector156
vector156:
  pushl $0
  102174:	6a 00                	push   $0x0
  pushl $156
  102176:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  10217b:	e9 10 fa ff ff       	jmp    101b90 <__alltraps>

00102180 <vector157>:
.globl vector157
vector157:
  pushl $0
  102180:	6a 00                	push   $0x0
  pushl $157
  102182:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  102187:	e9 04 fa ff ff       	jmp    101b90 <__alltraps>

0010218c <vector158>:
.globl vector158
vector158:
  pushl $0
  10218c:	6a 00                	push   $0x0
  pushl $158
  10218e:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  102193:	e9 f8 f9 ff ff       	jmp    101b90 <__alltraps>

00102198 <vector159>:
.globl vector159
vector159:
  pushl $0
  102198:	6a 00                	push   $0x0
  pushl $159
  10219a:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  10219f:	e9 ec f9 ff ff       	jmp    101b90 <__alltraps>

001021a4 <vector160>:
.globl vector160
vector160:
  pushl $0
  1021a4:	6a 00                	push   $0x0
  pushl $160
  1021a6:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  1021ab:	e9 e0 f9 ff ff       	jmp    101b90 <__alltraps>

001021b0 <vector161>:
.globl vector161
vector161:
  pushl $0
  1021b0:	6a 00                	push   $0x0
  pushl $161
  1021b2:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  1021b7:	e9 d4 f9 ff ff       	jmp    101b90 <__alltraps>

001021bc <vector162>:
.globl vector162
vector162:
  pushl $0
  1021bc:	6a 00                	push   $0x0
  pushl $162
  1021be:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  1021c3:	e9 c8 f9 ff ff       	jmp    101b90 <__alltraps>

001021c8 <vector163>:
.globl vector163
vector163:
  pushl $0
  1021c8:	6a 00                	push   $0x0
  pushl $163
  1021ca:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  1021cf:	e9 bc f9 ff ff       	jmp    101b90 <__alltraps>

001021d4 <vector164>:
.globl vector164
vector164:
  pushl $0
  1021d4:	6a 00                	push   $0x0
  pushl $164
  1021d6:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  1021db:	e9 b0 f9 ff ff       	jmp    101b90 <__alltraps>

001021e0 <vector165>:
.globl vector165
vector165:
  pushl $0
  1021e0:	6a 00                	push   $0x0
  pushl $165
  1021e2:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  1021e7:	e9 a4 f9 ff ff       	jmp    101b90 <__alltraps>

001021ec <vector166>:
.globl vector166
vector166:
  pushl $0
  1021ec:	6a 00                	push   $0x0
  pushl $166
  1021ee:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  1021f3:	e9 98 f9 ff ff       	jmp    101b90 <__alltraps>

001021f8 <vector167>:
.globl vector167
vector167:
  pushl $0
  1021f8:	6a 00                	push   $0x0
  pushl $167
  1021fa:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  1021ff:	e9 8c f9 ff ff       	jmp    101b90 <__alltraps>

00102204 <vector168>:
.globl vector168
vector168:
  pushl $0
  102204:	6a 00                	push   $0x0
  pushl $168
  102206:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  10220b:	e9 80 f9 ff ff       	jmp    101b90 <__alltraps>

00102210 <vector169>:
.globl vector169
vector169:
  pushl $0
  102210:	6a 00                	push   $0x0
  pushl $169
  102212:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  102217:	e9 74 f9 ff ff       	jmp    101b90 <__alltraps>

0010221c <vector170>:
.globl vector170
vector170:
  pushl $0
  10221c:	6a 00                	push   $0x0
  pushl $170
  10221e:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  102223:	e9 68 f9 ff ff       	jmp    101b90 <__alltraps>

00102228 <vector171>:
.globl vector171
vector171:
  pushl $0
  102228:	6a 00                	push   $0x0
  pushl $171
  10222a:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  10222f:	e9 5c f9 ff ff       	jmp    101b90 <__alltraps>

00102234 <vector172>:
.globl vector172
vector172:
  pushl $0
  102234:	6a 00                	push   $0x0
  pushl $172
  102236:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  10223b:	e9 50 f9 ff ff       	jmp    101b90 <__alltraps>

00102240 <vector173>:
.globl vector173
vector173:
  pushl $0
  102240:	6a 00                	push   $0x0
  pushl $173
  102242:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  102247:	e9 44 f9 ff ff       	jmp    101b90 <__alltraps>

0010224c <vector174>:
.globl vector174
vector174:
  pushl $0
  10224c:	6a 00                	push   $0x0
  pushl $174
  10224e:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  102253:	e9 38 f9 ff ff       	jmp    101b90 <__alltraps>

00102258 <vector175>:
.globl vector175
vector175:
  pushl $0
  102258:	6a 00                	push   $0x0
  pushl $175
  10225a:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  10225f:	e9 2c f9 ff ff       	jmp    101b90 <__alltraps>

00102264 <vector176>:
.globl vector176
vector176:
  pushl $0
  102264:	6a 00                	push   $0x0
  pushl $176
  102266:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  10226b:	e9 20 f9 ff ff       	jmp    101b90 <__alltraps>

00102270 <vector177>:
.globl vector177
vector177:
  pushl $0
  102270:	6a 00                	push   $0x0
  pushl $177
  102272:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  102277:	e9 14 f9 ff ff       	jmp    101b90 <__alltraps>

0010227c <vector178>:
.globl vector178
vector178:
  pushl $0
  10227c:	6a 00                	push   $0x0
  pushl $178
  10227e:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  102283:	e9 08 f9 ff ff       	jmp    101b90 <__alltraps>

00102288 <vector179>:
.globl vector179
vector179:
  pushl $0
  102288:	6a 00                	push   $0x0
  pushl $179
  10228a:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  10228f:	e9 fc f8 ff ff       	jmp    101b90 <__alltraps>

00102294 <vector180>:
.globl vector180
vector180:
  pushl $0
  102294:	6a 00                	push   $0x0
  pushl $180
  102296:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  10229b:	e9 f0 f8 ff ff       	jmp    101b90 <__alltraps>

001022a0 <vector181>:
.globl vector181
vector181:
  pushl $0
  1022a0:	6a 00                	push   $0x0
  pushl $181
  1022a2:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  1022a7:	e9 e4 f8 ff ff       	jmp    101b90 <__alltraps>

001022ac <vector182>:
.globl vector182
vector182:
  pushl $0
  1022ac:	6a 00                	push   $0x0
  pushl $182
  1022ae:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  1022b3:	e9 d8 f8 ff ff       	jmp    101b90 <__alltraps>

001022b8 <vector183>:
.globl vector183
vector183:
  pushl $0
  1022b8:	6a 00                	push   $0x0
  pushl $183
  1022ba:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  1022bf:	e9 cc f8 ff ff       	jmp    101b90 <__alltraps>

001022c4 <vector184>:
.globl vector184
vector184:
  pushl $0
  1022c4:	6a 00                	push   $0x0
  pushl $184
  1022c6:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  1022cb:	e9 c0 f8 ff ff       	jmp    101b90 <__alltraps>

001022d0 <vector185>:
.globl vector185
vector185:
  pushl $0
  1022d0:	6a 00                	push   $0x0
  pushl $185
  1022d2:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  1022d7:	e9 b4 f8 ff ff       	jmp    101b90 <__alltraps>

001022dc <vector186>:
.globl vector186
vector186:
  pushl $0
  1022dc:	6a 00                	push   $0x0
  pushl $186
  1022de:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  1022e3:	e9 a8 f8 ff ff       	jmp    101b90 <__alltraps>

001022e8 <vector187>:
.globl vector187
vector187:
  pushl $0
  1022e8:	6a 00                	push   $0x0
  pushl $187
  1022ea:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  1022ef:	e9 9c f8 ff ff       	jmp    101b90 <__alltraps>

001022f4 <vector188>:
.globl vector188
vector188:
  pushl $0
  1022f4:	6a 00                	push   $0x0
  pushl $188
  1022f6:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  1022fb:	e9 90 f8 ff ff       	jmp    101b90 <__alltraps>

00102300 <vector189>:
.globl vector189
vector189:
  pushl $0
  102300:	6a 00                	push   $0x0
  pushl $189
  102302:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  102307:	e9 84 f8 ff ff       	jmp    101b90 <__alltraps>

0010230c <vector190>:
.globl vector190
vector190:
  pushl $0
  10230c:	6a 00                	push   $0x0
  pushl $190
  10230e:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  102313:	e9 78 f8 ff ff       	jmp    101b90 <__alltraps>

00102318 <vector191>:
.globl vector191
vector191:
  pushl $0
  102318:	6a 00                	push   $0x0
  pushl $191
  10231a:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  10231f:	e9 6c f8 ff ff       	jmp    101b90 <__alltraps>

00102324 <vector192>:
.globl vector192
vector192:
  pushl $0
  102324:	6a 00                	push   $0x0
  pushl $192
  102326:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  10232b:	e9 60 f8 ff ff       	jmp    101b90 <__alltraps>

00102330 <vector193>:
.globl vector193
vector193:
  pushl $0
  102330:	6a 00                	push   $0x0
  pushl $193
  102332:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  102337:	e9 54 f8 ff ff       	jmp    101b90 <__alltraps>

0010233c <vector194>:
.globl vector194
vector194:
  pushl $0
  10233c:	6a 00                	push   $0x0
  pushl $194
  10233e:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  102343:	e9 48 f8 ff ff       	jmp    101b90 <__alltraps>

00102348 <vector195>:
.globl vector195
vector195:
  pushl $0
  102348:	6a 00                	push   $0x0
  pushl $195
  10234a:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  10234f:	e9 3c f8 ff ff       	jmp    101b90 <__alltraps>

00102354 <vector196>:
.globl vector196
vector196:
  pushl $0
  102354:	6a 00                	push   $0x0
  pushl $196
  102356:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  10235b:	e9 30 f8 ff ff       	jmp    101b90 <__alltraps>

00102360 <vector197>:
.globl vector197
vector197:
  pushl $0
  102360:	6a 00                	push   $0x0
  pushl $197
  102362:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  102367:	e9 24 f8 ff ff       	jmp    101b90 <__alltraps>

0010236c <vector198>:
.globl vector198
vector198:
  pushl $0
  10236c:	6a 00                	push   $0x0
  pushl $198
  10236e:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  102373:	e9 18 f8 ff ff       	jmp    101b90 <__alltraps>

00102378 <vector199>:
.globl vector199
vector199:
  pushl $0
  102378:	6a 00                	push   $0x0
  pushl $199
  10237a:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  10237f:	e9 0c f8 ff ff       	jmp    101b90 <__alltraps>

00102384 <vector200>:
.globl vector200
vector200:
  pushl $0
  102384:	6a 00                	push   $0x0
  pushl $200
  102386:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  10238b:	e9 00 f8 ff ff       	jmp    101b90 <__alltraps>

00102390 <vector201>:
.globl vector201
vector201:
  pushl $0
  102390:	6a 00                	push   $0x0
  pushl $201
  102392:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  102397:	e9 f4 f7 ff ff       	jmp    101b90 <__alltraps>

0010239c <vector202>:
.globl vector202
vector202:
  pushl $0
  10239c:	6a 00                	push   $0x0
  pushl $202
  10239e:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  1023a3:	e9 e8 f7 ff ff       	jmp    101b90 <__alltraps>

001023a8 <vector203>:
.globl vector203
vector203:
  pushl $0
  1023a8:	6a 00                	push   $0x0
  pushl $203
  1023aa:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  1023af:	e9 dc f7 ff ff       	jmp    101b90 <__alltraps>

001023b4 <vector204>:
.globl vector204
vector204:
  pushl $0
  1023b4:	6a 00                	push   $0x0
  pushl $204
  1023b6:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  1023bb:	e9 d0 f7 ff ff       	jmp    101b90 <__alltraps>

001023c0 <vector205>:
.globl vector205
vector205:
  pushl $0
  1023c0:	6a 00                	push   $0x0
  pushl $205
  1023c2:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  1023c7:	e9 c4 f7 ff ff       	jmp    101b90 <__alltraps>

001023cc <vector206>:
.globl vector206
vector206:
  pushl $0
  1023cc:	6a 00                	push   $0x0
  pushl $206
  1023ce:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  1023d3:	e9 b8 f7 ff ff       	jmp    101b90 <__alltraps>

001023d8 <vector207>:
.globl vector207
vector207:
  pushl $0
  1023d8:	6a 00                	push   $0x0
  pushl $207
  1023da:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  1023df:	e9 ac f7 ff ff       	jmp    101b90 <__alltraps>

001023e4 <vector208>:
.globl vector208
vector208:
  pushl $0
  1023e4:	6a 00                	push   $0x0
  pushl $208
  1023e6:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  1023eb:	e9 a0 f7 ff ff       	jmp    101b90 <__alltraps>

001023f0 <vector209>:
.globl vector209
vector209:
  pushl $0
  1023f0:	6a 00                	push   $0x0
  pushl $209
  1023f2:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  1023f7:	e9 94 f7 ff ff       	jmp    101b90 <__alltraps>

001023fc <vector210>:
.globl vector210
vector210:
  pushl $0
  1023fc:	6a 00                	push   $0x0
  pushl $210
  1023fe:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  102403:	e9 88 f7 ff ff       	jmp    101b90 <__alltraps>

00102408 <vector211>:
.globl vector211
vector211:
  pushl $0
  102408:	6a 00                	push   $0x0
  pushl $211
  10240a:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  10240f:	e9 7c f7 ff ff       	jmp    101b90 <__alltraps>

00102414 <vector212>:
.globl vector212
vector212:
  pushl $0
  102414:	6a 00                	push   $0x0
  pushl $212
  102416:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  10241b:	e9 70 f7 ff ff       	jmp    101b90 <__alltraps>

00102420 <vector213>:
.globl vector213
vector213:
  pushl $0
  102420:	6a 00                	push   $0x0
  pushl $213
  102422:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  102427:	e9 64 f7 ff ff       	jmp    101b90 <__alltraps>

0010242c <vector214>:
.globl vector214
vector214:
  pushl $0
  10242c:	6a 00                	push   $0x0
  pushl $214
  10242e:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  102433:	e9 58 f7 ff ff       	jmp    101b90 <__alltraps>

00102438 <vector215>:
.globl vector215
vector215:
  pushl $0
  102438:	6a 00                	push   $0x0
  pushl $215
  10243a:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  10243f:	e9 4c f7 ff ff       	jmp    101b90 <__alltraps>

00102444 <vector216>:
.globl vector216
vector216:
  pushl $0
  102444:	6a 00                	push   $0x0
  pushl $216
  102446:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  10244b:	e9 40 f7 ff ff       	jmp    101b90 <__alltraps>

00102450 <vector217>:
.globl vector217
vector217:
  pushl $0
  102450:	6a 00                	push   $0x0
  pushl $217
  102452:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  102457:	e9 34 f7 ff ff       	jmp    101b90 <__alltraps>

0010245c <vector218>:
.globl vector218
vector218:
  pushl $0
  10245c:	6a 00                	push   $0x0
  pushl $218
  10245e:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  102463:	e9 28 f7 ff ff       	jmp    101b90 <__alltraps>

00102468 <vector219>:
.globl vector219
vector219:
  pushl $0
  102468:	6a 00                	push   $0x0
  pushl $219
  10246a:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  10246f:	e9 1c f7 ff ff       	jmp    101b90 <__alltraps>

00102474 <vector220>:
.globl vector220
vector220:
  pushl $0
  102474:	6a 00                	push   $0x0
  pushl $220
  102476:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  10247b:	e9 10 f7 ff ff       	jmp    101b90 <__alltraps>

00102480 <vector221>:
.globl vector221
vector221:
  pushl $0
  102480:	6a 00                	push   $0x0
  pushl $221
  102482:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  102487:	e9 04 f7 ff ff       	jmp    101b90 <__alltraps>

0010248c <vector222>:
.globl vector222
vector222:
  pushl $0
  10248c:	6a 00                	push   $0x0
  pushl $222
  10248e:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  102493:	e9 f8 f6 ff ff       	jmp    101b90 <__alltraps>

00102498 <vector223>:
.globl vector223
vector223:
  pushl $0
  102498:	6a 00                	push   $0x0
  pushl $223
  10249a:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  10249f:	e9 ec f6 ff ff       	jmp    101b90 <__alltraps>

001024a4 <vector224>:
.globl vector224
vector224:
  pushl $0
  1024a4:	6a 00                	push   $0x0
  pushl $224
  1024a6:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  1024ab:	e9 e0 f6 ff ff       	jmp    101b90 <__alltraps>

001024b0 <vector225>:
.globl vector225
vector225:
  pushl $0
  1024b0:	6a 00                	push   $0x0
  pushl $225
  1024b2:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  1024b7:	e9 d4 f6 ff ff       	jmp    101b90 <__alltraps>

001024bc <vector226>:
.globl vector226
vector226:
  pushl $0
  1024bc:	6a 00                	push   $0x0
  pushl $226
  1024be:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  1024c3:	e9 c8 f6 ff ff       	jmp    101b90 <__alltraps>

001024c8 <vector227>:
.globl vector227
vector227:
  pushl $0
  1024c8:	6a 00                	push   $0x0
  pushl $227
  1024ca:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  1024cf:	e9 bc f6 ff ff       	jmp    101b90 <__alltraps>

001024d4 <vector228>:
.globl vector228
vector228:
  pushl $0
  1024d4:	6a 00                	push   $0x0
  pushl $228
  1024d6:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  1024db:	e9 b0 f6 ff ff       	jmp    101b90 <__alltraps>

001024e0 <vector229>:
.globl vector229
vector229:
  pushl $0
  1024e0:	6a 00                	push   $0x0
  pushl $229
  1024e2:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  1024e7:	e9 a4 f6 ff ff       	jmp    101b90 <__alltraps>

001024ec <vector230>:
.globl vector230
vector230:
  pushl $0
  1024ec:	6a 00                	push   $0x0
  pushl $230
  1024ee:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  1024f3:	e9 98 f6 ff ff       	jmp    101b90 <__alltraps>

001024f8 <vector231>:
.globl vector231
vector231:
  pushl $0
  1024f8:	6a 00                	push   $0x0
  pushl $231
  1024fa:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  1024ff:	e9 8c f6 ff ff       	jmp    101b90 <__alltraps>

00102504 <vector232>:
.globl vector232
vector232:
  pushl $0
  102504:	6a 00                	push   $0x0
  pushl $232
  102506:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  10250b:	e9 80 f6 ff ff       	jmp    101b90 <__alltraps>

00102510 <vector233>:
.globl vector233
vector233:
  pushl $0
  102510:	6a 00                	push   $0x0
  pushl $233
  102512:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  102517:	e9 74 f6 ff ff       	jmp    101b90 <__alltraps>

0010251c <vector234>:
.globl vector234
vector234:
  pushl $0
  10251c:	6a 00                	push   $0x0
  pushl $234
  10251e:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  102523:	e9 68 f6 ff ff       	jmp    101b90 <__alltraps>

00102528 <vector235>:
.globl vector235
vector235:
  pushl $0
  102528:	6a 00                	push   $0x0
  pushl $235
  10252a:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  10252f:	e9 5c f6 ff ff       	jmp    101b90 <__alltraps>

00102534 <vector236>:
.globl vector236
vector236:
  pushl $0
  102534:	6a 00                	push   $0x0
  pushl $236
  102536:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  10253b:	e9 50 f6 ff ff       	jmp    101b90 <__alltraps>

00102540 <vector237>:
.globl vector237
vector237:
  pushl $0
  102540:	6a 00                	push   $0x0
  pushl $237
  102542:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  102547:	e9 44 f6 ff ff       	jmp    101b90 <__alltraps>

0010254c <vector238>:
.globl vector238
vector238:
  pushl $0
  10254c:	6a 00                	push   $0x0
  pushl $238
  10254e:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  102553:	e9 38 f6 ff ff       	jmp    101b90 <__alltraps>

00102558 <vector239>:
.globl vector239
vector239:
  pushl $0
  102558:	6a 00                	push   $0x0
  pushl $239
  10255a:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  10255f:	e9 2c f6 ff ff       	jmp    101b90 <__alltraps>

00102564 <vector240>:
.globl vector240
vector240:
  pushl $0
  102564:	6a 00                	push   $0x0
  pushl $240
  102566:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  10256b:	e9 20 f6 ff ff       	jmp    101b90 <__alltraps>

00102570 <vector241>:
.globl vector241
vector241:
  pushl $0
  102570:	6a 00                	push   $0x0
  pushl $241
  102572:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  102577:	e9 14 f6 ff ff       	jmp    101b90 <__alltraps>

0010257c <vector242>:
.globl vector242
vector242:
  pushl $0
  10257c:	6a 00                	push   $0x0
  pushl $242
  10257e:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  102583:	e9 08 f6 ff ff       	jmp    101b90 <__alltraps>

00102588 <vector243>:
.globl vector243
vector243:
  pushl $0
  102588:	6a 00                	push   $0x0
  pushl $243
  10258a:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  10258f:	e9 fc f5 ff ff       	jmp    101b90 <__alltraps>

00102594 <vector244>:
.globl vector244
vector244:
  pushl $0
  102594:	6a 00                	push   $0x0
  pushl $244
  102596:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  10259b:	e9 f0 f5 ff ff       	jmp    101b90 <__alltraps>

001025a0 <vector245>:
.globl vector245
vector245:
  pushl $0
  1025a0:	6a 00                	push   $0x0
  pushl $245
  1025a2:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  1025a7:	e9 e4 f5 ff ff       	jmp    101b90 <__alltraps>

001025ac <vector246>:
.globl vector246
vector246:
  pushl $0
  1025ac:	6a 00                	push   $0x0
  pushl $246
  1025ae:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  1025b3:	e9 d8 f5 ff ff       	jmp    101b90 <__alltraps>

001025b8 <vector247>:
.globl vector247
vector247:
  pushl $0
  1025b8:	6a 00                	push   $0x0
  pushl $247
  1025ba:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  1025bf:	e9 cc f5 ff ff       	jmp    101b90 <__alltraps>

001025c4 <vector248>:
.globl vector248
vector248:
  pushl $0
  1025c4:	6a 00                	push   $0x0
  pushl $248
  1025c6:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  1025cb:	e9 c0 f5 ff ff       	jmp    101b90 <__alltraps>

001025d0 <vector249>:
.globl vector249
vector249:
  pushl $0
  1025d0:	6a 00                	push   $0x0
  pushl $249
  1025d2:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  1025d7:	e9 b4 f5 ff ff       	jmp    101b90 <__alltraps>

001025dc <vector250>:
.globl vector250
vector250:
  pushl $0
  1025dc:	6a 00                	push   $0x0
  pushl $250
  1025de:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  1025e3:	e9 a8 f5 ff ff       	jmp    101b90 <__alltraps>

001025e8 <vector251>:
.globl vector251
vector251:
  pushl $0
  1025e8:	6a 00                	push   $0x0
  pushl $251
  1025ea:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  1025ef:	e9 9c f5 ff ff       	jmp    101b90 <__alltraps>

001025f4 <vector252>:
.globl vector252
vector252:
  pushl $0
  1025f4:	6a 00                	push   $0x0
  pushl $252
  1025f6:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  1025fb:	e9 90 f5 ff ff       	jmp    101b90 <__alltraps>

00102600 <vector253>:
.globl vector253
vector253:
  pushl $0
  102600:	6a 00                	push   $0x0
  pushl $253
  102602:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  102607:	e9 84 f5 ff ff       	jmp    101b90 <__alltraps>

0010260c <vector254>:
.globl vector254
vector254:
  pushl $0
  10260c:	6a 00                	push   $0x0
  pushl $254
  10260e:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  102613:	e9 78 f5 ff ff       	jmp    101b90 <__alltraps>

00102618 <vector255>:
.globl vector255
vector255:
  pushl $0
  102618:	6a 00                	push   $0x0
  pushl $255
  10261a:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  10261f:	e9 6c f5 ff ff       	jmp    101b90 <__alltraps>

00102624 <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  102624:	55                   	push   %ebp
  102625:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  102627:	8b 45 08             	mov    0x8(%ebp),%eax
  10262a:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  10262d:	b8 23 00 00 00       	mov    $0x23,%eax
  102632:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102634:	b8 23 00 00 00       	mov    $0x23,%eax
  102639:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  10263b:	b8 10 00 00 00       	mov    $0x10,%eax
  102640:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  102642:	b8 10 00 00 00       	mov    $0x10,%eax
  102647:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102649:	b8 10 00 00 00       	mov    $0x10,%eax
  10264e:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  102650:	ea 57 26 10 00 08 00 	ljmp   $0x8,$0x102657
}
  102657:	5d                   	pop    %ebp
  102658:	c3                   	ret    

00102659 <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  102659:	55                   	push   %ebp
  10265a:	89 e5                	mov    %esp,%ebp
  10265c:	83 ec 14             	sub    $0x14,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  10265f:	b8 20 f9 10 00       	mov    $0x10f920,%eax
  102664:	05 00 04 00 00       	add    $0x400,%eax
  102669:	a3 a4 f8 10 00       	mov    %eax,0x10f8a4
    ts.ts_ss0 = KERNEL_DS;
  10266e:	66 c7 05 a8 f8 10 00 	movw   $0x10,0x10f8a8
  102675:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  102677:	66 c7 05 08 ea 10 00 	movw   $0x68,0x10ea08
  10267e:	68 00 
  102680:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  102685:	66 a3 0a ea 10 00    	mov    %ax,0x10ea0a
  10268b:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  102690:	c1 e8 10             	shr    $0x10,%eax
  102693:	a2 0c ea 10 00       	mov    %al,0x10ea0c
  102698:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  10269f:	83 e0 f0             	and    $0xfffffff0,%eax
  1026a2:	83 c8 09             	or     $0x9,%eax
  1026a5:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  1026aa:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  1026b1:	83 c8 10             	or     $0x10,%eax
  1026b4:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  1026b9:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  1026c0:	83 e0 9f             	and    $0xffffff9f,%eax
  1026c3:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  1026c8:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  1026cf:	83 c8 80             	or     $0xffffff80,%eax
  1026d2:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  1026d7:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  1026de:	83 e0 f0             	and    $0xfffffff0,%eax
  1026e1:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  1026e6:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  1026ed:	83 e0 ef             	and    $0xffffffef,%eax
  1026f0:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  1026f5:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  1026fc:	83 e0 df             	and    $0xffffffdf,%eax
  1026ff:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102704:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  10270b:	83 c8 40             	or     $0x40,%eax
  10270e:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102713:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  10271a:	83 e0 7f             	and    $0x7f,%eax
  10271d:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102722:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  102727:	c1 e8 18             	shr    $0x18,%eax
  10272a:	a2 0f ea 10 00       	mov    %al,0x10ea0f
    gdt[SEG_TSS].sd_s = 0;
  10272f:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102736:	83 e0 ef             	and    $0xffffffef,%eax
  102739:	a2 0d ea 10 00       	mov    %al,0x10ea0d

    // reload all segment registers
    lgdt(&gdt_pd);
  10273e:	c7 04 24 10 ea 10 00 	movl   $0x10ea10,(%esp)
  102745:	e8 da fe ff ff       	call   102624 <lgdt>
  10274a:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
    asm volatile ("cli");
}

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102750:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102754:	0f 00 d8             	ltr    %ax

    // load the TSS
    ltr(GD_TSS);
}
  102757:	c9                   	leave  
  102758:	c3                   	ret    

00102759 <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102759:	55                   	push   %ebp
  10275a:	89 e5                	mov    %esp,%ebp
    gdt_init();
  10275c:	e8 f8 fe ff ff       	call   102659 <gdt_init>
}
  102761:	5d                   	pop    %ebp
  102762:	c3                   	ret    
	...

00102764 <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  102764:	55                   	push   %ebp
  102765:	89 e5                	mov    %esp,%ebp
  102767:	56                   	push   %esi
  102768:	53                   	push   %ebx
  102769:	83 ec 60             	sub    $0x60,%esp
  10276c:	8b 45 10             	mov    0x10(%ebp),%eax
  10276f:	89 45 d0             	mov    %eax,-0x30(%ebp)
  102772:	8b 45 14             	mov    0x14(%ebp),%eax
  102775:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  102778:	8b 45 d0             	mov    -0x30(%ebp),%eax
  10277b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10277e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102781:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  102784:	8b 45 18             	mov    0x18(%ebp),%eax
  102787:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  10278a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10278d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102790:	89 45 c8             	mov    %eax,-0x38(%ebp)
  102793:	89 55 cc             	mov    %edx,-0x34(%ebp)
  102796:	8b 45 c8             	mov    -0x38(%ebp),%eax
  102799:	8b 55 cc             	mov    -0x34(%ebp),%edx
  10279c:	89 d3                	mov    %edx,%ebx
  10279e:	89 c6                	mov    %eax,%esi
  1027a0:	89 75 e0             	mov    %esi,-0x20(%ebp)
  1027a3:	89 5d f0             	mov    %ebx,-0x10(%ebp)
  1027a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1027a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1027ac:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  1027b0:	74 1c                	je     1027ce <printnum+0x6a>
  1027b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1027b5:	ba 00 00 00 00       	mov    $0x0,%edx
  1027ba:	f7 75 e4             	divl   -0x1c(%ebp)
  1027bd:	89 55 f4             	mov    %edx,-0xc(%ebp)
  1027c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1027c3:	ba 00 00 00 00       	mov    $0x0,%edx
  1027c8:	f7 75 e4             	divl   -0x1c(%ebp)
  1027cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1027ce:	8b 55 e0             	mov    -0x20(%ebp),%edx
  1027d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1027d4:	89 d6                	mov    %edx,%esi
  1027d6:	89 c3                	mov    %eax,%ebx
  1027d8:	89 f0                	mov    %esi,%eax
  1027da:	89 da                	mov    %ebx,%edx
  1027dc:	f7 75 e4             	divl   -0x1c(%ebp)
  1027df:	89 d3                	mov    %edx,%ebx
  1027e1:	89 c6                	mov    %eax,%esi
  1027e3:	89 75 e0             	mov    %esi,-0x20(%ebp)
  1027e6:	89 5d dc             	mov    %ebx,-0x24(%ebp)
  1027e9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1027ec:	89 45 c8             	mov    %eax,-0x38(%ebp)
  1027ef:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1027f2:	89 55 c4             	mov    %edx,-0x3c(%ebp)
  1027f5:	8b 45 c8             	mov    -0x38(%ebp),%eax
  1027f8:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  1027fb:	89 c3                	mov    %eax,%ebx
  1027fd:	89 d6                	mov    %edx,%esi
  1027ff:	89 5d e8             	mov    %ebx,-0x18(%ebp)
  102802:	89 75 ec             	mov    %esi,-0x14(%ebp)
  102805:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102808:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  10280b:	8b 45 18             	mov    0x18(%ebp),%eax
  10280e:	ba 00 00 00 00       	mov    $0x0,%edx
  102813:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  102816:	77 56                	ja     10286e <printnum+0x10a>
  102818:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  10281b:	72 05                	jb     102822 <printnum+0xbe>
  10281d:	3b 45 d0             	cmp    -0x30(%ebp),%eax
  102820:	77 4c                	ja     10286e <printnum+0x10a>
        printnum(putch, putdat, result, base, width - 1, padc);
  102822:	8b 45 1c             	mov    0x1c(%ebp),%eax
  102825:	8d 50 ff             	lea    -0x1(%eax),%edx
  102828:	8b 45 20             	mov    0x20(%ebp),%eax
  10282b:	89 44 24 18          	mov    %eax,0x18(%esp)
  10282f:	89 54 24 14          	mov    %edx,0x14(%esp)
  102833:	8b 45 18             	mov    0x18(%ebp),%eax
  102836:	89 44 24 10          	mov    %eax,0x10(%esp)
  10283a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10283d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102840:	89 44 24 08          	mov    %eax,0x8(%esp)
  102844:	89 54 24 0c          	mov    %edx,0xc(%esp)
  102848:	8b 45 0c             	mov    0xc(%ebp),%eax
  10284b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10284f:	8b 45 08             	mov    0x8(%ebp),%eax
  102852:	89 04 24             	mov    %eax,(%esp)
  102855:	e8 0a ff ff ff       	call   102764 <printnum>
  10285a:	eb 1c                	jmp    102878 <printnum+0x114>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  10285c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10285f:	89 44 24 04          	mov    %eax,0x4(%esp)
  102863:	8b 45 20             	mov    0x20(%ebp),%eax
  102866:	89 04 24             	mov    %eax,(%esp)
  102869:	8b 45 08             	mov    0x8(%ebp),%eax
  10286c:	ff d0                	call   *%eax
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  10286e:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  102872:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  102876:	7f e4                	jg     10285c <printnum+0xf8>
            putch(padc, putdat);
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  102878:	8b 45 d8             	mov    -0x28(%ebp),%eax
  10287b:	05 70 3a 10 00       	add    $0x103a70,%eax
  102880:	0f b6 00             	movzbl (%eax),%eax
  102883:	0f be c0             	movsbl %al,%eax
  102886:	8b 55 0c             	mov    0xc(%ebp),%edx
  102889:	89 54 24 04          	mov    %edx,0x4(%esp)
  10288d:	89 04 24             	mov    %eax,(%esp)
  102890:	8b 45 08             	mov    0x8(%ebp),%eax
  102893:	ff d0                	call   *%eax
}
  102895:	83 c4 60             	add    $0x60,%esp
  102898:	5b                   	pop    %ebx
  102899:	5e                   	pop    %esi
  10289a:	5d                   	pop    %ebp
  10289b:	c3                   	ret    

0010289c <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  10289c:	55                   	push   %ebp
  10289d:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  10289f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  1028a3:	7e 14                	jle    1028b9 <getuint+0x1d>
        return va_arg(*ap, unsigned long long);
  1028a5:	8b 45 08             	mov    0x8(%ebp),%eax
  1028a8:	8b 00                	mov    (%eax),%eax
  1028aa:	8d 48 08             	lea    0x8(%eax),%ecx
  1028ad:	8b 55 08             	mov    0x8(%ebp),%edx
  1028b0:	89 0a                	mov    %ecx,(%edx)
  1028b2:	8b 50 04             	mov    0x4(%eax),%edx
  1028b5:	8b 00                	mov    (%eax),%eax
  1028b7:	eb 30                	jmp    1028e9 <getuint+0x4d>
    }
    else if (lflag) {
  1028b9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1028bd:	74 16                	je     1028d5 <getuint+0x39>
        return va_arg(*ap, unsigned long);
  1028bf:	8b 45 08             	mov    0x8(%ebp),%eax
  1028c2:	8b 00                	mov    (%eax),%eax
  1028c4:	8d 48 04             	lea    0x4(%eax),%ecx
  1028c7:	8b 55 08             	mov    0x8(%ebp),%edx
  1028ca:	89 0a                	mov    %ecx,(%edx)
  1028cc:	8b 00                	mov    (%eax),%eax
  1028ce:	ba 00 00 00 00       	mov    $0x0,%edx
  1028d3:	eb 14                	jmp    1028e9 <getuint+0x4d>
    }
    else {
        return va_arg(*ap, unsigned int);
  1028d5:	8b 45 08             	mov    0x8(%ebp),%eax
  1028d8:	8b 00                	mov    (%eax),%eax
  1028da:	8d 48 04             	lea    0x4(%eax),%ecx
  1028dd:	8b 55 08             	mov    0x8(%ebp),%edx
  1028e0:	89 0a                	mov    %ecx,(%edx)
  1028e2:	8b 00                	mov    (%eax),%eax
  1028e4:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  1028e9:	5d                   	pop    %ebp
  1028ea:	c3                   	ret    

001028eb <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  1028eb:	55                   	push   %ebp
  1028ec:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  1028ee:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  1028f2:	7e 14                	jle    102908 <getint+0x1d>
        return va_arg(*ap, long long);
  1028f4:	8b 45 08             	mov    0x8(%ebp),%eax
  1028f7:	8b 00                	mov    (%eax),%eax
  1028f9:	8d 48 08             	lea    0x8(%eax),%ecx
  1028fc:	8b 55 08             	mov    0x8(%ebp),%edx
  1028ff:	89 0a                	mov    %ecx,(%edx)
  102901:	8b 50 04             	mov    0x4(%eax),%edx
  102904:	8b 00                	mov    (%eax),%eax
  102906:	eb 30                	jmp    102938 <getint+0x4d>
    }
    else if (lflag) {
  102908:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  10290c:	74 16                	je     102924 <getint+0x39>
        return va_arg(*ap, long);
  10290e:	8b 45 08             	mov    0x8(%ebp),%eax
  102911:	8b 00                	mov    (%eax),%eax
  102913:	8d 48 04             	lea    0x4(%eax),%ecx
  102916:	8b 55 08             	mov    0x8(%ebp),%edx
  102919:	89 0a                	mov    %ecx,(%edx)
  10291b:	8b 00                	mov    (%eax),%eax
  10291d:	89 c2                	mov    %eax,%edx
  10291f:	c1 fa 1f             	sar    $0x1f,%edx
  102922:	eb 14                	jmp    102938 <getint+0x4d>
    }
    else {
        return va_arg(*ap, int);
  102924:	8b 45 08             	mov    0x8(%ebp),%eax
  102927:	8b 00                	mov    (%eax),%eax
  102929:	8d 48 04             	lea    0x4(%eax),%ecx
  10292c:	8b 55 08             	mov    0x8(%ebp),%edx
  10292f:	89 0a                	mov    %ecx,(%edx)
  102931:	8b 00                	mov    (%eax),%eax
  102933:	89 c2                	mov    %eax,%edx
  102935:	c1 fa 1f             	sar    $0x1f,%edx
    }
}
  102938:	5d                   	pop    %ebp
  102939:	c3                   	ret    

0010293a <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  10293a:	55                   	push   %ebp
  10293b:	89 e5                	mov    %esp,%ebp
  10293d:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
  102940:	8d 55 14             	lea    0x14(%ebp),%edx
  102943:	8d 45 f4             	lea    -0xc(%ebp),%eax
  102946:	89 10                	mov    %edx,(%eax)
    vprintfmt(putch, putdat, fmt, ap);
  102948:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10294b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10294f:	8b 45 10             	mov    0x10(%ebp),%eax
  102952:	89 44 24 08          	mov    %eax,0x8(%esp)
  102956:	8b 45 0c             	mov    0xc(%ebp),%eax
  102959:	89 44 24 04          	mov    %eax,0x4(%esp)
  10295d:	8b 45 08             	mov    0x8(%ebp),%eax
  102960:	89 04 24             	mov    %eax,(%esp)
  102963:	e8 02 00 00 00       	call   10296a <vprintfmt>
    va_end(ap);
}
  102968:	c9                   	leave  
  102969:	c3                   	ret    

0010296a <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  10296a:	55                   	push   %ebp
  10296b:	89 e5                	mov    %esp,%ebp
  10296d:	56                   	push   %esi
  10296e:	53                   	push   %ebx
  10296f:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102972:	eb 17                	jmp    10298b <vprintfmt+0x21>
            if (ch == '\0') {
  102974:	85 db                	test   %ebx,%ebx
  102976:	0f 84 db 03 00 00    	je     102d57 <vprintfmt+0x3ed>
                return;
            }
            putch(ch, putdat);
  10297c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10297f:	89 44 24 04          	mov    %eax,0x4(%esp)
  102983:	89 1c 24             	mov    %ebx,(%esp)
  102986:	8b 45 08             	mov    0x8(%ebp),%eax
  102989:	ff d0                	call   *%eax
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  10298b:	8b 45 10             	mov    0x10(%ebp),%eax
  10298e:	0f b6 00             	movzbl (%eax),%eax
  102991:	0f b6 d8             	movzbl %al,%ebx
  102994:	83 fb 25             	cmp    $0x25,%ebx
  102997:	0f 95 c0             	setne  %al
  10299a:	83 45 10 01          	addl   $0x1,0x10(%ebp)
  10299e:	84 c0                	test   %al,%al
  1029a0:	75 d2                	jne    102974 <vprintfmt+0xa>
            }
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
  1029a2:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  1029a6:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  1029ad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1029b0:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  1029b3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  1029ba:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1029bd:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1029c0:	eb 04                	jmp    1029c6 <vprintfmt+0x5c>
            goto process_precision;

        case '.':
            if (width < 0)
                width = 0;
            goto reswitch;
  1029c2:	90                   	nop
  1029c3:	eb 01                	jmp    1029c6 <vprintfmt+0x5c>
            goto reswitch;

        process_precision:
            if (width < 0)
                width = precision, precision = -1;
            goto reswitch;
  1029c5:	90                   	nop
        char padc = ' ';
        width = precision = -1;
        lflag = altflag = 0;

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  1029c6:	8b 45 10             	mov    0x10(%ebp),%eax
  1029c9:	0f b6 00             	movzbl (%eax),%eax
  1029cc:	0f b6 d8             	movzbl %al,%ebx
  1029cf:	89 d8                	mov    %ebx,%eax
  1029d1:	83 45 10 01          	addl   $0x1,0x10(%ebp)
  1029d5:	83 e8 23             	sub    $0x23,%eax
  1029d8:	83 f8 55             	cmp    $0x55,%eax
  1029db:	0f 87 45 03 00 00    	ja     102d26 <vprintfmt+0x3bc>
  1029e1:	8b 04 85 94 3a 10 00 	mov    0x103a94(,%eax,4),%eax
  1029e8:	ff e0                	jmp    *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  1029ea:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  1029ee:	eb d6                	jmp    1029c6 <vprintfmt+0x5c>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  1029f0:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  1029f4:	eb d0                	jmp    1029c6 <vprintfmt+0x5c>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  1029f6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  1029fd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102a00:	89 d0                	mov    %edx,%eax
  102a02:	c1 e0 02             	shl    $0x2,%eax
  102a05:	01 d0                	add    %edx,%eax
  102a07:	01 c0                	add    %eax,%eax
  102a09:	01 d8                	add    %ebx,%eax
  102a0b:	83 e8 30             	sub    $0x30,%eax
  102a0e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  102a11:	8b 45 10             	mov    0x10(%ebp),%eax
  102a14:	0f b6 00             	movzbl (%eax),%eax
  102a17:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  102a1a:	83 fb 2f             	cmp    $0x2f,%ebx
  102a1d:	7e 39                	jle    102a58 <vprintfmt+0xee>
  102a1f:	83 fb 39             	cmp    $0x39,%ebx
  102a22:	7f 34                	jg     102a58 <vprintfmt+0xee>
            padc = '0';
            goto reswitch;

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  102a24:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
                ch = *fmt;
                if (ch < '0' || ch > '9') {
                    break;
                }
            }
  102a28:	eb d3                	jmp    1029fd <vprintfmt+0x93>
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  102a2a:	8b 45 14             	mov    0x14(%ebp),%eax
  102a2d:	8d 50 04             	lea    0x4(%eax),%edx
  102a30:	89 55 14             	mov    %edx,0x14(%ebp)
  102a33:	8b 00                	mov    (%eax),%eax
  102a35:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  102a38:	eb 1f                	jmp    102a59 <vprintfmt+0xef>

        case '.':
            if (width < 0)
  102a3a:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102a3e:	79 82                	jns    1029c2 <vprintfmt+0x58>
                width = 0;
  102a40:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  102a47:	e9 76 ff ff ff       	jmp    1029c2 <vprintfmt+0x58>

        case '#':
            altflag = 1;
  102a4c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  102a53:	e9 6e ff ff ff       	jmp    1029c6 <vprintfmt+0x5c>
                ch = *fmt;
                if (ch < '0' || ch > '9') {
                    break;
                }
            }
            goto process_precision;
  102a58:	90                   	nop
        case '#':
            altflag = 1;
            goto reswitch;

        process_precision:
            if (width < 0)
  102a59:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102a5d:	0f 89 62 ff ff ff    	jns    1029c5 <vprintfmt+0x5b>
                width = precision, precision = -1;
  102a63:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102a66:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102a69:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  102a70:	e9 50 ff ff ff       	jmp    1029c5 <vprintfmt+0x5b>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  102a75:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
            goto reswitch;
  102a79:	e9 48 ff ff ff       	jmp    1029c6 <vprintfmt+0x5c>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  102a7e:	8b 45 14             	mov    0x14(%ebp),%eax
  102a81:	8d 50 04             	lea    0x4(%eax),%edx
  102a84:	89 55 14             	mov    %edx,0x14(%ebp)
  102a87:	8b 00                	mov    (%eax),%eax
  102a89:	8b 55 0c             	mov    0xc(%ebp),%edx
  102a8c:	89 54 24 04          	mov    %edx,0x4(%esp)
  102a90:	89 04 24             	mov    %eax,(%esp)
  102a93:	8b 45 08             	mov    0x8(%ebp),%eax
  102a96:	ff d0                	call   *%eax
            break;
  102a98:	e9 b4 02 00 00       	jmp    102d51 <vprintfmt+0x3e7>

        // error message
        case 'e':
            err = va_arg(ap, int);
  102a9d:	8b 45 14             	mov    0x14(%ebp),%eax
  102aa0:	8d 50 04             	lea    0x4(%eax),%edx
  102aa3:	89 55 14             	mov    %edx,0x14(%ebp)
  102aa6:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  102aa8:	85 db                	test   %ebx,%ebx
  102aaa:	79 02                	jns    102aae <vprintfmt+0x144>
                err = -err;
  102aac:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  102aae:	83 fb 06             	cmp    $0x6,%ebx
  102ab1:	7f 0b                	jg     102abe <vprintfmt+0x154>
  102ab3:	8b 34 9d 54 3a 10 00 	mov    0x103a54(,%ebx,4),%esi
  102aba:	85 f6                	test   %esi,%esi
  102abc:	75 23                	jne    102ae1 <vprintfmt+0x177>
                printfmt(putch, putdat, "error %d", err);
  102abe:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  102ac2:	c7 44 24 08 81 3a 10 	movl   $0x103a81,0x8(%esp)
  102ac9:	00 
  102aca:	8b 45 0c             	mov    0xc(%ebp),%eax
  102acd:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ad1:	8b 45 08             	mov    0x8(%ebp),%eax
  102ad4:	89 04 24             	mov    %eax,(%esp)
  102ad7:	e8 5e fe ff ff       	call   10293a <printfmt>
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  102adc:	e9 70 02 00 00       	jmp    102d51 <vprintfmt+0x3e7>
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
                printfmt(putch, putdat, "error %d", err);
            }
            else {
                printfmt(putch, putdat, "%s", p);
  102ae1:	89 74 24 0c          	mov    %esi,0xc(%esp)
  102ae5:	c7 44 24 08 8a 3a 10 	movl   $0x103a8a,0x8(%esp)
  102aec:	00 
  102aed:	8b 45 0c             	mov    0xc(%ebp),%eax
  102af0:	89 44 24 04          	mov    %eax,0x4(%esp)
  102af4:	8b 45 08             	mov    0x8(%ebp),%eax
  102af7:	89 04 24             	mov    %eax,(%esp)
  102afa:	e8 3b fe ff ff       	call   10293a <printfmt>
            }
            break;
  102aff:	e9 4d 02 00 00       	jmp    102d51 <vprintfmt+0x3e7>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  102b04:	8b 45 14             	mov    0x14(%ebp),%eax
  102b07:	8d 50 04             	lea    0x4(%eax),%edx
  102b0a:	89 55 14             	mov    %edx,0x14(%ebp)
  102b0d:	8b 30                	mov    (%eax),%esi
  102b0f:	85 f6                	test   %esi,%esi
  102b11:	75 05                	jne    102b18 <vprintfmt+0x1ae>
                p = "(null)";
  102b13:	be 8d 3a 10 00       	mov    $0x103a8d,%esi
            }
            if (width > 0 && padc != '-') {
  102b18:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102b1c:	7e 7c                	jle    102b9a <vprintfmt+0x230>
  102b1e:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  102b22:	74 76                	je     102b9a <vprintfmt+0x230>
                for (width -= strnlen(p, precision); width > 0; width --) {
  102b24:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  102b27:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102b2a:	89 44 24 04          	mov    %eax,0x4(%esp)
  102b2e:	89 34 24             	mov    %esi,(%esp)
  102b31:	e8 21 03 00 00       	call   102e57 <strnlen>
  102b36:	89 da                	mov    %ebx,%edx
  102b38:	29 c2                	sub    %eax,%edx
  102b3a:	89 d0                	mov    %edx,%eax
  102b3c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102b3f:	eb 17                	jmp    102b58 <vprintfmt+0x1ee>
                    putch(padc, putdat);
  102b41:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  102b45:	8b 55 0c             	mov    0xc(%ebp),%edx
  102b48:	89 54 24 04          	mov    %edx,0x4(%esp)
  102b4c:	89 04 24             	mov    %eax,(%esp)
  102b4f:	8b 45 08             	mov    0x8(%ebp),%eax
  102b52:	ff d0                	call   *%eax
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
                p = "(null)";
            }
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
  102b54:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102b58:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102b5c:	7f e3                	jg     102b41 <vprintfmt+0x1d7>
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  102b5e:	eb 3a                	jmp    102b9a <vprintfmt+0x230>
                if (altflag && (ch < ' ' || ch > '~')) {
  102b60:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  102b64:	74 1f                	je     102b85 <vprintfmt+0x21b>
  102b66:	83 fb 1f             	cmp    $0x1f,%ebx
  102b69:	7e 05                	jle    102b70 <vprintfmt+0x206>
  102b6b:	83 fb 7e             	cmp    $0x7e,%ebx
  102b6e:	7e 15                	jle    102b85 <vprintfmt+0x21b>
                    putch('?', putdat);
  102b70:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b73:	89 44 24 04          	mov    %eax,0x4(%esp)
  102b77:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  102b7e:	8b 45 08             	mov    0x8(%ebp),%eax
  102b81:	ff d0                	call   *%eax
  102b83:	eb 0f                	jmp    102b94 <vprintfmt+0x22a>
                }
                else {
                    putch(ch, putdat);
  102b85:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b88:	89 44 24 04          	mov    %eax,0x4(%esp)
  102b8c:	89 1c 24             	mov    %ebx,(%esp)
  102b8f:	8b 45 08             	mov    0x8(%ebp),%eax
  102b92:	ff d0                	call   *%eax
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  102b94:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102b98:	eb 01                	jmp    102b9b <vprintfmt+0x231>
  102b9a:	90                   	nop
  102b9b:	0f b6 06             	movzbl (%esi),%eax
  102b9e:	0f be d8             	movsbl %al,%ebx
  102ba1:	85 db                	test   %ebx,%ebx
  102ba3:	0f 95 c0             	setne  %al
  102ba6:	83 c6 01             	add    $0x1,%esi
  102ba9:	84 c0                	test   %al,%al
  102bab:	74 29                	je     102bd6 <vprintfmt+0x26c>
  102bad:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102bb1:	78 ad                	js     102b60 <vprintfmt+0x1f6>
  102bb3:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  102bb7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102bbb:	79 a3                	jns    102b60 <vprintfmt+0x1f6>
                }
                else {
                    putch(ch, putdat);
                }
            }
            for (; width > 0; width --) {
  102bbd:	eb 17                	jmp    102bd6 <vprintfmt+0x26c>
                putch(' ', putdat);
  102bbf:	8b 45 0c             	mov    0xc(%ebp),%eax
  102bc2:	89 44 24 04          	mov    %eax,0x4(%esp)
  102bc6:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  102bcd:	8b 45 08             	mov    0x8(%ebp),%eax
  102bd0:	ff d0                	call   *%eax
                }
                else {
                    putch(ch, putdat);
                }
            }
            for (; width > 0; width --) {
  102bd2:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102bd6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102bda:	7f e3                	jg     102bbf <vprintfmt+0x255>
                putch(' ', putdat);
            }
            break;
  102bdc:	e9 70 01 00 00       	jmp    102d51 <vprintfmt+0x3e7>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  102be1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102be4:	89 44 24 04          	mov    %eax,0x4(%esp)
  102be8:	8d 45 14             	lea    0x14(%ebp),%eax
  102beb:	89 04 24             	mov    %eax,(%esp)
  102bee:	e8 f8 fc ff ff       	call   1028eb <getint>
  102bf3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102bf6:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  102bf9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102bfc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102bff:	85 d2                	test   %edx,%edx
  102c01:	79 26                	jns    102c29 <vprintfmt+0x2bf>
                putch('-', putdat);
  102c03:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c06:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c0a:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  102c11:	8b 45 08             	mov    0x8(%ebp),%eax
  102c14:	ff d0                	call   *%eax
                num = -(long long)num;
  102c16:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102c19:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102c1c:	f7 d8                	neg    %eax
  102c1e:	83 d2 00             	adc    $0x0,%edx
  102c21:	f7 da                	neg    %edx
  102c23:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102c26:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  102c29:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  102c30:	e9 a8 00 00 00       	jmp    102cdd <vprintfmt+0x373>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  102c35:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102c38:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c3c:	8d 45 14             	lea    0x14(%ebp),%eax
  102c3f:	89 04 24             	mov    %eax,(%esp)
  102c42:	e8 55 fc ff ff       	call   10289c <getuint>
  102c47:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102c4a:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  102c4d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  102c54:	e9 84 00 00 00       	jmp    102cdd <vprintfmt+0x373>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  102c59:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102c5c:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c60:	8d 45 14             	lea    0x14(%ebp),%eax
  102c63:	89 04 24             	mov    %eax,(%esp)
  102c66:	e8 31 fc ff ff       	call   10289c <getuint>
  102c6b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102c6e:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  102c71:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  102c78:	eb 63                	jmp    102cdd <vprintfmt+0x373>

        // pointer
        case 'p':
            putch('0', putdat);
  102c7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c7d:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c81:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  102c88:	8b 45 08             	mov    0x8(%ebp),%eax
  102c8b:	ff d0                	call   *%eax
            putch('x', putdat);
  102c8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c90:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c94:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  102c9b:	8b 45 08             	mov    0x8(%ebp),%eax
  102c9e:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  102ca0:	8b 45 14             	mov    0x14(%ebp),%eax
  102ca3:	8d 50 04             	lea    0x4(%eax),%edx
  102ca6:	89 55 14             	mov    %edx,0x14(%ebp)
  102ca9:	8b 00                	mov    (%eax),%eax
  102cab:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102cae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  102cb5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  102cbc:	eb 1f                	jmp    102cdd <vprintfmt+0x373>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  102cbe:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102cc1:	89 44 24 04          	mov    %eax,0x4(%esp)
  102cc5:	8d 45 14             	lea    0x14(%ebp),%eax
  102cc8:	89 04 24             	mov    %eax,(%esp)
  102ccb:	e8 cc fb ff ff       	call   10289c <getuint>
  102cd0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102cd3:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  102cd6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  102cdd:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  102ce1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102ce4:	89 54 24 18          	mov    %edx,0x18(%esp)
  102ce8:	8b 55 e8             	mov    -0x18(%ebp),%edx
  102ceb:	89 54 24 14          	mov    %edx,0x14(%esp)
  102cef:	89 44 24 10          	mov    %eax,0x10(%esp)
  102cf3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102cf6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102cf9:	89 44 24 08          	mov    %eax,0x8(%esp)
  102cfd:	89 54 24 0c          	mov    %edx,0xc(%esp)
  102d01:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d04:	89 44 24 04          	mov    %eax,0x4(%esp)
  102d08:	8b 45 08             	mov    0x8(%ebp),%eax
  102d0b:	89 04 24             	mov    %eax,(%esp)
  102d0e:	e8 51 fa ff ff       	call   102764 <printnum>
            break;
  102d13:	eb 3c                	jmp    102d51 <vprintfmt+0x3e7>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  102d15:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d18:	89 44 24 04          	mov    %eax,0x4(%esp)
  102d1c:	89 1c 24             	mov    %ebx,(%esp)
  102d1f:	8b 45 08             	mov    0x8(%ebp),%eax
  102d22:	ff d0                	call   *%eax
            break;
  102d24:	eb 2b                	jmp    102d51 <vprintfmt+0x3e7>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  102d26:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d29:	89 44 24 04          	mov    %eax,0x4(%esp)
  102d2d:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  102d34:	8b 45 08             	mov    0x8(%ebp),%eax
  102d37:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
  102d39:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  102d3d:	eb 04                	jmp    102d43 <vprintfmt+0x3d9>
  102d3f:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  102d43:	8b 45 10             	mov    0x10(%ebp),%eax
  102d46:	83 e8 01             	sub    $0x1,%eax
  102d49:	0f b6 00             	movzbl (%eax),%eax
  102d4c:	3c 25                	cmp    $0x25,%al
  102d4e:	75 ef                	jne    102d3f <vprintfmt+0x3d5>
                /* do nothing */;
            break;
  102d50:	90                   	nop
        }
    }
  102d51:	90                   	nop
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102d52:	e9 34 fc ff ff       	jmp    10298b <vprintfmt+0x21>
            if (ch == '\0') {
                return;
  102d57:	90                   	nop
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  102d58:	83 c4 40             	add    $0x40,%esp
  102d5b:	5b                   	pop    %ebx
  102d5c:	5e                   	pop    %esi
  102d5d:	5d                   	pop    %ebp
  102d5e:	c3                   	ret    

00102d5f <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  102d5f:	55                   	push   %ebp
  102d60:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  102d62:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d65:	8b 40 08             	mov    0x8(%eax),%eax
  102d68:	8d 50 01             	lea    0x1(%eax),%edx
  102d6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d6e:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  102d71:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d74:	8b 10                	mov    (%eax),%edx
  102d76:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d79:	8b 40 04             	mov    0x4(%eax),%eax
  102d7c:	39 c2                	cmp    %eax,%edx
  102d7e:	73 12                	jae    102d92 <sprintputch+0x33>
        *b->buf ++ = ch;
  102d80:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d83:	8b 00                	mov    (%eax),%eax
  102d85:	8b 55 08             	mov    0x8(%ebp),%edx
  102d88:	88 10                	mov    %dl,(%eax)
  102d8a:	8d 50 01             	lea    0x1(%eax),%edx
  102d8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d90:	89 10                	mov    %edx,(%eax)
    }
}
  102d92:	5d                   	pop    %ebp
  102d93:	c3                   	ret    

00102d94 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  102d94:	55                   	push   %ebp
  102d95:	89 e5                	mov    %esp,%ebp
  102d97:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  102d9a:	8d 55 14             	lea    0x14(%ebp),%edx
  102d9d:	8d 45 f0             	lea    -0x10(%ebp),%eax
  102da0:	89 10                	mov    %edx,(%eax)
    cnt = vsnprintf(str, size, fmt, ap);
  102da2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102da5:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102da9:	8b 45 10             	mov    0x10(%ebp),%eax
  102dac:	89 44 24 08          	mov    %eax,0x8(%esp)
  102db0:	8b 45 0c             	mov    0xc(%ebp),%eax
  102db3:	89 44 24 04          	mov    %eax,0x4(%esp)
  102db7:	8b 45 08             	mov    0x8(%ebp),%eax
  102dba:	89 04 24             	mov    %eax,(%esp)
  102dbd:	e8 08 00 00 00       	call   102dca <vsnprintf>
  102dc2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  102dc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  102dc8:	c9                   	leave  
  102dc9:	c3                   	ret    

00102dca <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  102dca:	55                   	push   %ebp
  102dcb:	89 e5                	mov    %esp,%ebp
  102dcd:	83 ec 28             	sub    $0x28,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  102dd0:	8b 45 08             	mov    0x8(%ebp),%eax
  102dd3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102dd6:	8b 45 0c             	mov    0xc(%ebp),%eax
  102dd9:	83 e8 01             	sub    $0x1,%eax
  102ddc:	03 45 08             	add    0x8(%ebp),%eax
  102ddf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102de2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  102de9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  102ded:	74 0a                	je     102df9 <vsnprintf+0x2f>
  102def:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102df2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102df5:	39 c2                	cmp    %eax,%edx
  102df7:	76 07                	jbe    102e00 <vsnprintf+0x36>
        return -E_INVAL;
  102df9:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  102dfe:	eb 2a                	jmp    102e2a <vsnprintf+0x60>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  102e00:	8b 45 14             	mov    0x14(%ebp),%eax
  102e03:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102e07:	8b 45 10             	mov    0x10(%ebp),%eax
  102e0a:	89 44 24 08          	mov    %eax,0x8(%esp)
  102e0e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  102e11:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e15:	c7 04 24 5f 2d 10 00 	movl   $0x102d5f,(%esp)
  102e1c:	e8 49 fb ff ff       	call   10296a <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
  102e21:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102e24:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  102e27:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  102e2a:	c9                   	leave  
  102e2b:	c3                   	ret    

00102e2c <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  102e2c:	55                   	push   %ebp
  102e2d:	89 e5                	mov    %esp,%ebp
  102e2f:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102e32:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  102e39:	eb 04                	jmp    102e3f <strlen+0x13>
        cnt ++;
  102e3b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
  102e3f:	8b 45 08             	mov    0x8(%ebp),%eax
  102e42:	0f b6 00             	movzbl (%eax),%eax
  102e45:	84 c0                	test   %al,%al
  102e47:	0f 95 c0             	setne  %al
  102e4a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102e4e:	84 c0                	test   %al,%al
  102e50:	75 e9                	jne    102e3b <strlen+0xf>
        cnt ++;
    }
    return cnt;
  102e52:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102e55:	c9                   	leave  
  102e56:	c3                   	ret    

00102e57 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  102e57:	55                   	push   %ebp
  102e58:	89 e5                	mov    %esp,%ebp
  102e5a:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102e5d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102e64:	eb 04                	jmp    102e6a <strnlen+0x13>
        cnt ++;
  102e66:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
    while (cnt < len && *s ++ != '\0') {
  102e6a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102e6d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  102e70:	73 13                	jae    102e85 <strnlen+0x2e>
  102e72:	8b 45 08             	mov    0x8(%ebp),%eax
  102e75:	0f b6 00             	movzbl (%eax),%eax
  102e78:	84 c0                	test   %al,%al
  102e7a:	0f 95 c0             	setne  %al
  102e7d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102e81:	84 c0                	test   %al,%al
  102e83:	75 e1                	jne    102e66 <strnlen+0xf>
        cnt ++;
    }
    return cnt;
  102e85:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102e88:	c9                   	leave  
  102e89:	c3                   	ret    

00102e8a <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  102e8a:	55                   	push   %ebp
  102e8b:	89 e5                	mov    %esp,%ebp
  102e8d:	57                   	push   %edi
  102e8e:	56                   	push   %esi
  102e8f:	53                   	push   %ebx
  102e90:	83 ec 24             	sub    $0x24,%esp
  102e93:	8b 45 08             	mov    0x8(%ebp),%eax
  102e96:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102e99:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e9c:	89 45 ec             	mov    %eax,-0x14(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  102e9f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102ea2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102ea5:	89 d6                	mov    %edx,%esi
  102ea7:	89 c3                	mov    %eax,%ebx
  102ea9:	89 df                	mov    %ebx,%edi
  102eab:	ac                   	lods   %ds:(%esi),%al
  102eac:	aa                   	stos   %al,%es:(%edi)
  102ead:	84 c0                	test   %al,%al
  102eaf:	75 fa                	jne    102eab <strcpy+0x21>
  102eb1:	89 45 d0             	mov    %eax,-0x30(%ebp)
  102eb4:	89 fb                	mov    %edi,%ebx
  102eb6:	89 75 e8             	mov    %esi,-0x18(%ebp)
  102eb9:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  102ebc:	8b 45 d0             	mov    -0x30(%ebp),%eax
  102ebf:	89 45 e0             	mov    %eax,-0x20(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  102ec2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  102ec5:	83 c4 24             	add    $0x24,%esp
  102ec8:	5b                   	pop    %ebx
  102ec9:	5e                   	pop    %esi
  102eca:	5f                   	pop    %edi
  102ecb:	5d                   	pop    %ebp
  102ecc:	c3                   	ret    

00102ecd <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  102ecd:	55                   	push   %ebp
  102ece:	89 e5                	mov    %esp,%ebp
  102ed0:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  102ed3:	8b 45 08             	mov    0x8(%ebp),%eax
  102ed6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  102ed9:	eb 21                	jmp    102efc <strncpy+0x2f>
        if ((*p = *src) != '\0') {
  102edb:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ede:	0f b6 10             	movzbl (%eax),%edx
  102ee1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102ee4:	88 10                	mov    %dl,(%eax)
  102ee6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102ee9:	0f b6 00             	movzbl (%eax),%eax
  102eec:	84 c0                	test   %al,%al
  102eee:	74 04                	je     102ef4 <strncpy+0x27>
            src ++;
  102ef0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
  102ef4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  102ef8:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
    char *p = dst;
    while (len > 0) {
  102efc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102f00:	75 d9                	jne    102edb <strncpy+0xe>
        if ((*p = *src) != '\0') {
            src ++;
        }
        p ++, len --;
    }
    return dst;
  102f02:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102f05:	c9                   	leave  
  102f06:	c3                   	ret    

00102f07 <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  102f07:	55                   	push   %ebp
  102f08:	89 e5                	mov    %esp,%ebp
  102f0a:	57                   	push   %edi
  102f0b:	56                   	push   %esi
  102f0c:	53                   	push   %ebx
  102f0d:	83 ec 24             	sub    $0x24,%esp
  102f10:	8b 45 08             	mov    0x8(%ebp),%eax
  102f13:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102f16:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f19:	89 45 ec             	mov    %eax,-0x14(%ebp)
#ifndef __HAVE_ARCH_STRCMP
#define __HAVE_ARCH_STRCMP
static inline int
__strcmp(const char *s1, const char *s2) {
    int d0, d1, ret;
    asm volatile (
  102f1c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102f1f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102f22:	89 d6                	mov    %edx,%esi
  102f24:	89 c3                	mov    %eax,%ebx
  102f26:	89 df                	mov    %ebx,%edi
  102f28:	ac                   	lods   %ds:(%esi),%al
  102f29:	ae                   	scas   %es:(%edi),%al
  102f2a:	75 08                	jne    102f34 <strcmp+0x2d>
  102f2c:	84 c0                	test   %al,%al
  102f2e:	75 f8                	jne    102f28 <strcmp+0x21>
  102f30:	31 c0                	xor    %eax,%eax
  102f32:	eb 04                	jmp    102f38 <strcmp+0x31>
  102f34:	19 c0                	sbb    %eax,%eax
  102f36:	0c 01                	or     $0x1,%al
  102f38:	89 fb                	mov    %edi,%ebx
  102f3a:	89 45 d0             	mov    %eax,-0x30(%ebp)
  102f3d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  102f40:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102f43:	89 75 e4             	mov    %esi,-0x1c(%ebp)
  102f46:	89 5d e0             	mov    %ebx,-0x20(%ebp)
            "orb $1, %%al;"
            "3:"
            : "=a" (ret), "=&S" (d0), "=&D" (d1)
            : "1" (s1), "2" (s2)
            : "memory");
    return ret;
  102f49:	8b 45 e8             	mov    -0x18(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  102f4c:	83 c4 24             	add    $0x24,%esp
  102f4f:	5b                   	pop    %ebx
  102f50:	5e                   	pop    %esi
  102f51:	5f                   	pop    %edi
  102f52:	5d                   	pop    %ebp
  102f53:	c3                   	ret    

00102f54 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  102f54:	55                   	push   %ebp
  102f55:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102f57:	eb 0c                	jmp    102f65 <strncmp+0x11>
        n --, s1 ++, s2 ++;
  102f59:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  102f5d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102f61:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102f65:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102f69:	74 1a                	je     102f85 <strncmp+0x31>
  102f6b:	8b 45 08             	mov    0x8(%ebp),%eax
  102f6e:	0f b6 00             	movzbl (%eax),%eax
  102f71:	84 c0                	test   %al,%al
  102f73:	74 10                	je     102f85 <strncmp+0x31>
  102f75:	8b 45 08             	mov    0x8(%ebp),%eax
  102f78:	0f b6 10             	movzbl (%eax),%edx
  102f7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f7e:	0f b6 00             	movzbl (%eax),%eax
  102f81:	38 c2                	cmp    %al,%dl
  102f83:	74 d4                	je     102f59 <strncmp+0x5>
        n --, s1 ++, s2 ++;
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  102f85:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102f89:	74 1a                	je     102fa5 <strncmp+0x51>
  102f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  102f8e:	0f b6 00             	movzbl (%eax),%eax
  102f91:	0f b6 d0             	movzbl %al,%edx
  102f94:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f97:	0f b6 00             	movzbl (%eax),%eax
  102f9a:	0f b6 c0             	movzbl %al,%eax
  102f9d:	89 d1                	mov    %edx,%ecx
  102f9f:	29 c1                	sub    %eax,%ecx
  102fa1:	89 c8                	mov    %ecx,%eax
  102fa3:	eb 05                	jmp    102faa <strncmp+0x56>
  102fa5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102faa:	5d                   	pop    %ebp
  102fab:	c3                   	ret    

00102fac <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  102fac:	55                   	push   %ebp
  102fad:	89 e5                	mov    %esp,%ebp
  102faf:	83 ec 04             	sub    $0x4,%esp
  102fb2:	8b 45 0c             	mov    0xc(%ebp),%eax
  102fb5:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102fb8:	eb 14                	jmp    102fce <strchr+0x22>
        if (*s == c) {
  102fba:	8b 45 08             	mov    0x8(%ebp),%eax
  102fbd:	0f b6 00             	movzbl (%eax),%eax
  102fc0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  102fc3:	75 05                	jne    102fca <strchr+0x1e>
            return (char *)s;
  102fc5:	8b 45 08             	mov    0x8(%ebp),%eax
  102fc8:	eb 13                	jmp    102fdd <strchr+0x31>
        }
        s ++;
  102fca:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
  102fce:	8b 45 08             	mov    0x8(%ebp),%eax
  102fd1:	0f b6 00             	movzbl (%eax),%eax
  102fd4:	84 c0                	test   %al,%al
  102fd6:	75 e2                	jne    102fba <strchr+0xe>
        if (*s == c) {
            return (char *)s;
        }
        s ++;
    }
    return NULL;
  102fd8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102fdd:	c9                   	leave  
  102fde:	c3                   	ret    

00102fdf <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  102fdf:	55                   	push   %ebp
  102fe0:	89 e5                	mov    %esp,%ebp
  102fe2:	83 ec 04             	sub    $0x4,%esp
  102fe5:	8b 45 0c             	mov    0xc(%ebp),%eax
  102fe8:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102feb:	eb 0f                	jmp    102ffc <strfind+0x1d>
        if (*s == c) {
  102fed:	8b 45 08             	mov    0x8(%ebp),%eax
  102ff0:	0f b6 00             	movzbl (%eax),%eax
  102ff3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  102ff6:	74 10                	je     103008 <strfind+0x29>
            break;
        }
        s ++;
  102ff8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
    while (*s != '\0') {
  102ffc:	8b 45 08             	mov    0x8(%ebp),%eax
  102fff:	0f b6 00             	movzbl (%eax),%eax
  103002:	84 c0                	test   %al,%al
  103004:	75 e7                	jne    102fed <strfind+0xe>
  103006:	eb 01                	jmp    103009 <strfind+0x2a>
        if (*s == c) {
            break;
  103008:	90                   	nop
        }
        s ++;
    }
    return (char *)s;
  103009:	8b 45 08             	mov    0x8(%ebp),%eax
}
  10300c:	c9                   	leave  
  10300d:	c3                   	ret    

0010300e <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  10300e:	55                   	push   %ebp
  10300f:	89 e5                	mov    %esp,%ebp
  103011:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  103014:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  10301b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  103022:	eb 04                	jmp    103028 <strtol+0x1a>
        s ++;
  103024:	83 45 08 01          	addl   $0x1,0x8(%ebp)
strtol(const char *s, char **endptr, int base) {
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  103028:	8b 45 08             	mov    0x8(%ebp),%eax
  10302b:	0f b6 00             	movzbl (%eax),%eax
  10302e:	3c 20                	cmp    $0x20,%al
  103030:	74 f2                	je     103024 <strtol+0x16>
  103032:	8b 45 08             	mov    0x8(%ebp),%eax
  103035:	0f b6 00             	movzbl (%eax),%eax
  103038:	3c 09                	cmp    $0x9,%al
  10303a:	74 e8                	je     103024 <strtol+0x16>
        s ++;
    }

    // plus/minus sign
    if (*s == '+') {
  10303c:	8b 45 08             	mov    0x8(%ebp),%eax
  10303f:	0f b6 00             	movzbl (%eax),%eax
  103042:	3c 2b                	cmp    $0x2b,%al
  103044:	75 06                	jne    10304c <strtol+0x3e>
        s ++;
  103046:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  10304a:	eb 15                	jmp    103061 <strtol+0x53>
    }
    else if (*s == '-') {
  10304c:	8b 45 08             	mov    0x8(%ebp),%eax
  10304f:	0f b6 00             	movzbl (%eax),%eax
  103052:	3c 2d                	cmp    $0x2d,%al
  103054:	75 0b                	jne    103061 <strtol+0x53>
        s ++, neg = 1;
  103056:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  10305a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  103061:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103065:	74 06                	je     10306d <strtol+0x5f>
  103067:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  10306b:	75 24                	jne    103091 <strtol+0x83>
  10306d:	8b 45 08             	mov    0x8(%ebp),%eax
  103070:	0f b6 00             	movzbl (%eax),%eax
  103073:	3c 30                	cmp    $0x30,%al
  103075:	75 1a                	jne    103091 <strtol+0x83>
  103077:	8b 45 08             	mov    0x8(%ebp),%eax
  10307a:	83 c0 01             	add    $0x1,%eax
  10307d:	0f b6 00             	movzbl (%eax),%eax
  103080:	3c 78                	cmp    $0x78,%al
  103082:	75 0d                	jne    103091 <strtol+0x83>
        s += 2, base = 16;
  103084:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  103088:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  10308f:	eb 2a                	jmp    1030bb <strtol+0xad>
    }
    else if (base == 0 && s[0] == '0') {
  103091:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103095:	75 17                	jne    1030ae <strtol+0xa0>
  103097:	8b 45 08             	mov    0x8(%ebp),%eax
  10309a:	0f b6 00             	movzbl (%eax),%eax
  10309d:	3c 30                	cmp    $0x30,%al
  10309f:	75 0d                	jne    1030ae <strtol+0xa0>
        s ++, base = 8;
  1030a1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1030a5:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  1030ac:	eb 0d                	jmp    1030bb <strtol+0xad>
    }
    else if (base == 0) {
  1030ae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1030b2:	75 07                	jne    1030bb <strtol+0xad>
        base = 10;
  1030b4:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  1030bb:	8b 45 08             	mov    0x8(%ebp),%eax
  1030be:	0f b6 00             	movzbl (%eax),%eax
  1030c1:	3c 2f                	cmp    $0x2f,%al
  1030c3:	7e 1b                	jle    1030e0 <strtol+0xd2>
  1030c5:	8b 45 08             	mov    0x8(%ebp),%eax
  1030c8:	0f b6 00             	movzbl (%eax),%eax
  1030cb:	3c 39                	cmp    $0x39,%al
  1030cd:	7f 11                	jg     1030e0 <strtol+0xd2>
            dig = *s - '0';
  1030cf:	8b 45 08             	mov    0x8(%ebp),%eax
  1030d2:	0f b6 00             	movzbl (%eax),%eax
  1030d5:	0f be c0             	movsbl %al,%eax
  1030d8:	83 e8 30             	sub    $0x30,%eax
  1030db:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1030de:	eb 48                	jmp    103128 <strtol+0x11a>
        }
        else if (*s >= 'a' && *s <= 'z') {
  1030e0:	8b 45 08             	mov    0x8(%ebp),%eax
  1030e3:	0f b6 00             	movzbl (%eax),%eax
  1030e6:	3c 60                	cmp    $0x60,%al
  1030e8:	7e 1b                	jle    103105 <strtol+0xf7>
  1030ea:	8b 45 08             	mov    0x8(%ebp),%eax
  1030ed:	0f b6 00             	movzbl (%eax),%eax
  1030f0:	3c 7a                	cmp    $0x7a,%al
  1030f2:	7f 11                	jg     103105 <strtol+0xf7>
            dig = *s - 'a' + 10;
  1030f4:	8b 45 08             	mov    0x8(%ebp),%eax
  1030f7:	0f b6 00             	movzbl (%eax),%eax
  1030fa:	0f be c0             	movsbl %al,%eax
  1030fd:	83 e8 57             	sub    $0x57,%eax
  103100:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103103:	eb 23                	jmp    103128 <strtol+0x11a>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  103105:	8b 45 08             	mov    0x8(%ebp),%eax
  103108:	0f b6 00             	movzbl (%eax),%eax
  10310b:	3c 40                	cmp    $0x40,%al
  10310d:	7e 38                	jle    103147 <strtol+0x139>
  10310f:	8b 45 08             	mov    0x8(%ebp),%eax
  103112:	0f b6 00             	movzbl (%eax),%eax
  103115:	3c 5a                	cmp    $0x5a,%al
  103117:	7f 2e                	jg     103147 <strtol+0x139>
            dig = *s - 'A' + 10;
  103119:	8b 45 08             	mov    0x8(%ebp),%eax
  10311c:	0f b6 00             	movzbl (%eax),%eax
  10311f:	0f be c0             	movsbl %al,%eax
  103122:	83 e8 37             	sub    $0x37,%eax
  103125:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  103128:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10312b:	3b 45 10             	cmp    0x10(%ebp),%eax
  10312e:	7d 16                	jge    103146 <strtol+0x138>
            break;
        }
        s ++, val = (val * base) + dig;
  103130:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103134:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103137:	0f af 45 10          	imul   0x10(%ebp),%eax
  10313b:	03 45 f4             	add    -0xc(%ebp),%eax
  10313e:	89 45 f8             	mov    %eax,-0x8(%ebp)
        // we don't properly detect overflow!
    }
  103141:	e9 75 ff ff ff       	jmp    1030bb <strtol+0xad>
        }
        else {
            break;
        }
        if (dig >= base) {
            break;
  103146:	90                   	nop
        }
        s ++, val = (val * base) + dig;
        // we don't properly detect overflow!
    }

    if (endptr) {
  103147:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  10314b:	74 08                	je     103155 <strtol+0x147>
        *endptr = (char *) s;
  10314d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103150:	8b 55 08             	mov    0x8(%ebp),%edx
  103153:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  103155:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  103159:	74 07                	je     103162 <strtol+0x154>
  10315b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10315e:	f7 d8                	neg    %eax
  103160:	eb 03                	jmp    103165 <strtol+0x157>
  103162:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  103165:	c9                   	leave  
  103166:	c3                   	ret    

00103167 <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  103167:	55                   	push   %ebp
  103168:	89 e5                	mov    %esp,%ebp
  10316a:	57                   	push   %edi
  10316b:	56                   	push   %esi
  10316c:	53                   	push   %ebx
  10316d:	83 ec 24             	sub    $0x24,%esp
  103170:	8b 45 0c             	mov    0xc(%ebp),%eax
  103173:	88 45 d0             	mov    %al,-0x30(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  103176:	0f be 45 d0          	movsbl -0x30(%ebp),%eax
  10317a:	8b 55 08             	mov    0x8(%ebp),%edx
  10317d:	89 55 f0             	mov    %edx,-0x10(%ebp)
  103180:	88 45 ef             	mov    %al,-0x11(%ebp)
  103183:	8b 45 10             	mov    0x10(%ebp),%eax
  103186:	89 45 e8             	mov    %eax,-0x18(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  103189:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  10318c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
  103190:	8b 55 f0             	mov    -0x10(%ebp),%edx
  103193:	89 ce                	mov    %ecx,%esi
  103195:	89 d3                	mov    %edx,%ebx
  103197:	89 f1                	mov    %esi,%ecx
  103199:	89 df                	mov    %ebx,%edi
  10319b:	f3 aa                	rep stos %al,%es:(%edi)
  10319d:	89 fb                	mov    %edi,%ebx
  10319f:	89 ce                	mov    %ecx,%esi
  1031a1:	89 75 e4             	mov    %esi,-0x1c(%ebp)
  1031a4:	89 5d e0             	mov    %ebx,-0x20(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  1031a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  1031aa:	83 c4 24             	add    $0x24,%esp
  1031ad:	5b                   	pop    %ebx
  1031ae:	5e                   	pop    %esi
  1031af:	5f                   	pop    %edi
  1031b0:	5d                   	pop    %ebp
  1031b1:	c3                   	ret    

001031b2 <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  1031b2:	55                   	push   %ebp
  1031b3:	89 e5                	mov    %esp,%ebp
  1031b5:	57                   	push   %edi
  1031b6:	56                   	push   %esi
  1031b7:	53                   	push   %ebx
  1031b8:	83 ec 38             	sub    $0x38,%esp
  1031bb:	8b 45 08             	mov    0x8(%ebp),%eax
  1031be:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1031c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031c4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1031c7:	8b 45 10             	mov    0x10(%ebp),%eax
  1031ca:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  1031cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1031d0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  1031d3:	73 4e                	jae    103223 <memmove+0x71>
  1031d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1031d8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1031db:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1031de:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1031e1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1031e4:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  1031e7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1031ea:	89 c1                	mov    %eax,%ecx
  1031ec:	c1 e9 02             	shr    $0x2,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
  1031ef:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1031f2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1031f5:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  1031f8:	89 d7                	mov    %edx,%edi
  1031fa:	89 c3                	mov    %eax,%ebx
  1031fc:	8b 4d c0             	mov    -0x40(%ebp),%ecx
  1031ff:	89 de                	mov    %ebx,%esi
  103201:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  103203:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  103206:	83 e1 03             	and    $0x3,%ecx
  103209:	74 02                	je     10320d <memmove+0x5b>
  10320b:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  10320d:	89 f3                	mov    %esi,%ebx
  10320f:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  103212:	8b 4d c0             	mov    -0x40(%ebp),%ecx
  103215:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  103218:	89 7d d4             	mov    %edi,-0x2c(%ebp)
  10321b:	89 5d d0             	mov    %ebx,-0x30(%ebp)
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
            : "memory");
    return dst;
  10321e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103221:	eb 3b                	jmp    10325e <memmove+0xac>
    asm volatile (
            "std;"
            "rep; movsb;"
            "cld;"
            : "=&c" (d0), "=&S" (d1), "=&D" (d2)
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  103223:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103226:	83 e8 01             	sub    $0x1,%eax
  103229:	89 c2                	mov    %eax,%edx
  10322b:	03 55 ec             	add    -0x14(%ebp),%edx
  10322e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103231:	83 e8 01             	sub    $0x1,%eax
  103234:	03 45 f0             	add    -0x10(%ebp),%eax
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
        return __memcpy(dst, src, n);
    }
    int d0, d1, d2;
    asm volatile (
  103237:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  10323a:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  10323d:	89 d6                	mov    %edx,%esi
  10323f:	89 c3                	mov    %eax,%ebx
  103241:	8b 4d bc             	mov    -0x44(%ebp),%ecx
  103244:	89 df                	mov    %ebx,%edi
  103246:	fd                   	std    
  103247:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  103249:	fc                   	cld    
  10324a:	89 fb                	mov    %edi,%ebx
  10324c:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  10324f:	8b 4d bc             	mov    -0x44(%ebp),%ecx
  103252:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  103255:	89 75 c8             	mov    %esi,-0x38(%ebp)
  103258:	89 5d c4             	mov    %ebx,-0x3c(%ebp)
            "rep; movsb;"
            "cld;"
            : "=&c" (d0), "=&S" (d1), "=&D" (d2)
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
            : "memory");
    return dst;
  10325b:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  10325e:	83 c4 38             	add    $0x38,%esp
  103261:	5b                   	pop    %ebx
  103262:	5e                   	pop    %esi
  103263:	5f                   	pop    %edi
  103264:	5d                   	pop    %ebp
  103265:	c3                   	ret    

00103266 <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  103266:	55                   	push   %ebp
  103267:	89 e5                	mov    %esp,%ebp
  103269:	57                   	push   %edi
  10326a:	56                   	push   %esi
  10326b:	53                   	push   %ebx
  10326c:	83 ec 24             	sub    $0x24,%esp
  10326f:	8b 45 08             	mov    0x8(%ebp),%eax
  103272:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103275:	8b 45 0c             	mov    0xc(%ebp),%eax
  103278:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10327b:	8b 45 10             	mov    0x10(%ebp),%eax
  10327e:	89 45 e8             	mov    %eax,-0x18(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  103281:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103284:	89 c1                	mov    %eax,%ecx
  103286:	c1 e9 02             	shr    $0x2,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
  103289:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10328c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10328f:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  103292:	89 d7                	mov    %edx,%edi
  103294:	89 c3                	mov    %eax,%ebx
  103296:	8b 4d d0             	mov    -0x30(%ebp),%ecx
  103299:	89 de                	mov    %ebx,%esi
  10329b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  10329d:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  1032a0:	83 e1 03             	and    $0x3,%ecx
  1032a3:	74 02                	je     1032a7 <memcpy+0x41>
  1032a5:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  1032a7:	89 f3                	mov    %esi,%ebx
  1032a9:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  1032ac:	8b 4d d0             	mov    -0x30(%ebp),%ecx
  1032af:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  1032b2:	89 7d e0             	mov    %edi,-0x20(%ebp)
  1032b5:	89 5d dc             	mov    %ebx,-0x24(%ebp)
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
            : "memory");
    return dst;
  1032b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  1032bb:	83 c4 24             	add    $0x24,%esp
  1032be:	5b                   	pop    %ebx
  1032bf:	5e                   	pop    %esi
  1032c0:	5f                   	pop    %edi
  1032c1:	5d                   	pop    %ebp
  1032c2:	c3                   	ret    

001032c3 <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  1032c3:	55                   	push   %ebp
  1032c4:	89 e5                	mov    %esp,%ebp
  1032c6:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  1032c9:	8b 45 08             	mov    0x8(%ebp),%eax
  1032cc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  1032cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  1032d2:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  1032d5:	eb 32                	jmp    103309 <memcmp+0x46>
        if (*s1 != *s2) {
  1032d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1032da:	0f b6 10             	movzbl (%eax),%edx
  1032dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1032e0:	0f b6 00             	movzbl (%eax),%eax
  1032e3:	38 c2                	cmp    %al,%dl
  1032e5:	74 1a                	je     103301 <memcmp+0x3e>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  1032e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1032ea:	0f b6 00             	movzbl (%eax),%eax
  1032ed:	0f b6 d0             	movzbl %al,%edx
  1032f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1032f3:	0f b6 00             	movzbl (%eax),%eax
  1032f6:	0f b6 c0             	movzbl %al,%eax
  1032f9:	89 d1                	mov    %edx,%ecx
  1032fb:	29 c1                	sub    %eax,%ecx
  1032fd:	89 c8                	mov    %ecx,%eax
  1032ff:	eb 1c                	jmp    10331d <memcmp+0x5a>
        }
        s1 ++, s2 ++;
  103301:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  103305:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
    const char *s1 = (const char *)v1;
    const char *s2 = (const char *)v2;
    while (n -- > 0) {
  103309:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10330d:	0f 95 c0             	setne  %al
  103310:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  103314:	84 c0                	test   %al,%al
  103316:	75 bf                	jne    1032d7 <memcmp+0x14>
        if (*s1 != *s2) {
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
        }
        s1 ++, s2 ++;
    }
    return 0;
  103318:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10331d:	c9                   	leave  
  10331e:	c3                   	ret    
