#操作系统第四次实验报告
钱迪晨 2013011402 计35
##练习1
###题目1
请说明proc_struct中`struct context context`和`struct trapframe *tf`成员变量含义和在本实验中的作用是啥？（提示通过看代码和编程调试可以判断出来）

答:

context是上下文的内容，也就是进程切换的时候需要修改的东西。

tf是中断返回时候保存的东西。实际上ucorefork的进程需要进行一次额外的iret才能返回到真正用户代码开始的地方执行。

###题目2
请说明ucore是否做到给每个新fork的线程一个唯一的id？请说明你的分析和理由。

答：

从get_pid这个函数可以看到，分配的pid的方法是，每次取一个pid，遍历所有进程，如果又一个相同，pid+1，继续repeat。所以id是唯一的。

###题目3

请在实验报告中简要说明你对proc\_run函数的分析。并回答如下问题：
 - 在本实验的执行过程中，创建且运行了几个内核线程？
 - 语句`local_intr_save(intr_flag);....local_intr_restore(intr_flag);`在这里有何作用?请说明理由

	void
	proc_run(struct proc_struct *proc) {
	    if (proc != current) { //如果需要切换
	        bool intr_flag;
	        struct proc_struct *prev = current, *next = proc;
	        local_intr_save(intr_flag); // 关中断，保存当前的eflag中中断使能开关
	        {
	            current = proc;
	            load_esp0(next->kstack + KSTACKSIZE);//切换tss的栈
	            lcr3(next->cr3);//切换页表
	            switch_to(&(prev->context), &(next->context));//切换上下文
	        }
	        local_intr_restore(intr_flag);//恢复eflag中断使能开关
	    }
	}
	
本次是实验内核有2个线程。

第二问请看代码注释。

##重要知识点
这次试验主要的难点在进程的切换，这里面有大量的细节，切换过程，比如页表切换会出问题吗？等等