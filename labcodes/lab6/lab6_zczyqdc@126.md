#操作系统第六次实验报告
钱迪晨 2013011402 计35
##练习1

###题目1
请在实验报告中完成：
 - 请理解并分析sched_class中各个函数指针的用法，并接合Round Robin 调度算法描ucore的调度执行过程
 - 请在实验报告中简要说明如何设计实现”多级反馈队列调度算法“，给出概要设计，鼓励给出详细设计

答：

	struct sched_class {
    // the name of sched_class
    const char *name;
    // Init the run queue
    void (*init)(struct run_queue *rq);//初始化
    void (*enqueue)(struct run_queue *rq, struct proc_struct *proc);//一个process进入就绪状态
    void (*dequeue)(struct run_queue *rq, struct proc_struct *proc);//一个process变成运行状态
    struct proc_struct *(*pick_next)(struct run_queue *rq);//选择下一个运行的process
    void (*proc_tick)(struct run_queue *rq, struct proc_struct *proc);//时钟中断,timeslice在这里修改
	};

RR算法：

* 时钟中断
* trap里面调用proc_tick
* slice修改，如果为0则reschedule
* trap里面可能会reschedule
* 将当前进程enqueue，并且选择下一个进程，并将其dequeue

多级反馈队列调度，我的想法：

本来的ucore里面只维护了一个队列，那么现在我们可以维护多个队列，每当一个进程选择成为next以后，我们可以将它重新放到新的队列中，这个队列的选择我们可以自行设计。


###题目2
请在实验报告中简要说明你的设计实现过程。

答：

striding scheduling主要就是每个process维护一个stride，最小的进程先运行，每次运行后，stride值变大，变大MAX_STRIDE / (priority）。这样即可。

维护最小的stride我们使用的是斜堆来维护。

###challenge
本次实验我实现了linux2.6的O（1）简化调度。
具体方法就是维护两个队列，active_list和expire_list以及对应的bitmap。
每次根据active_list里面，选取优先级最小的一个进程运行。选取的加速使用bitmap来维护。
详细请看代码master分支的linux26_sched.c。需要运行的话请修改sched.c里面的调度器在50行。

##重要知识点
schedule的过程以及重点函数。