#操作系统第七次实验报告
钱迪晨 2013011402 计35
##练习1

请在实验报告中给出内核级信号量的设计描述，并说其大致执行流流程。

请在实验报告中给出给用户态进程/线程提供信号量机制的设计方案，并比较说明给内核级提供信号量机制的异同。

答：

内核中的信号量数据结构。

	typedef struct {
		int value; //信号量的值
		wait_queue_t wait_queue; // 等待这个信号量的线程队列
	} semaphore_t;
	
处理信号量主要就是两个函数up，down。

up函数的作用是释放当前线程所占用的信号量，具体实现如下。

	static __noinline void __up(semaphore_t *sem, uint32_t wait_state) {
	    bool intr_flag;
	    local_intr_save(intr_flag); // 关闭中断，使得变成原子操作
	    {
	        wait_t *wait;
	        if ((wait = wait_queue_first(&(sem->wait_queue))) == NULL) {
	            sem->value ++; //如果等待队列里面为空，value+=1
	        }
	        else {
	            assert(wait->proc->wait_state == wait_state);
	            wakeup_wait(&(sem->wait_queue), wait, wait_state, 1);
	            // 否则取出第一个wait队列里面的线程，激活
	        }
	    }
	    local_intr_restore(intr_flag); // 开中断
 	}

down函数的作用是尝试获取信号量的资源，具体实现如下。

	static __noinline uint32_t __down(semaphore_t *sem, uint32_t wait_state) {
		bool intr_flag;
		local_intr_save(intr_flag); // 关中断
		if (sem->value > 0) { //如果可以获得，那么直接获得资源
		    sem->value --;
		    local_intr_restore(intr_flag);
		    return 0;
		}
		// 无法获取资源，将自己加入等待队列
		wait_t __wait, *wait = &__wait;
		wait_current_set(&(sem->wait_queue), wait, wait_state);
		local_intr_restore(intr_flag); // 开中断
		
		schedule(); // 切换线程
		
		local_intr_save(intr_flag); // 如果运行到这里，说明有线程释放资源，激活了它，所以直接关中断继续操作
		wait_current_del(&(sem->wait_queue), wait); // 删除等待队列
		local_intr_restore(intr_flag); // 开中断
		
		if (wait->wakeup_flags != wait_state) {
		    return wait->wakeup_flags;
		}
		return 0;
	}

而用户态的实现，由于要保障up，down操作的原子性，用户态不能关中断，我认为可以使用如下方案。

信号量的up操作和down操作直接设计成syscall，每次在用户态调用，切换到内核执行。

如果可以支持原子指令，那么在用户态可以直接使用这些指令实现一个锁，使得原子指令集不被打断，从而来实现信号量。

当然也可以进行软件模拟，但是感觉比较麻烦。

##练习2

请在实验报告中给出内核级条件变量的设计描述，并说其大致执行流流程。

请在实验报告中给出给用户态进程/线程提供条件变量机制的设计方案，并比较说明给内核级提供条件变量机制的异同。

请在实验报告中回答：能否不用基于信号量机制来完成条件变量？如果不能，请给出理由，如果能，请给出设计说明和具体实现。

答：

	typedef struct condvar{
	    semaphore_t sem;        // 信号量，用来记录资源数量
	    int count;              // 有多少等待的线程
	    monitor_t * owner;      // 管程的指针
	} condvar_t;
	
	typedef struct monitor{
	    semaphore_t mutex;      // 进入管程的锁
	    semaphore_t next;       // 表示即将离开管程的信号量，实际上仅仅是一个等待队列
	    int next_count;         // next的等待队列大小
	    condvar_t *cv;          // 条件变量
	} monitor_t;


具体函数有。

* cond_signal (condvar_t *cvp)，作用就是一个线程离开管程的时候调用，如果cvp->count>0，也就是有等待的线程，那么激活它，并将自己等待在next信号量中。原因是因为，要保证同一时间，只有一个线程在管程中。如果cvp->count=0啥都不做。
* cond_wait (condvar_t *cvp)，将自己加入等待队列，具体如果next队列里面有线程，那么激活它，否则释放monitor->mutex。然后下一句话执行的时候，肯定是切换回来了，紧接着应该就是获得资源cvp->sem。

在用户态实现可以使用软件模拟，比较麻烦。主要要解决的就是原子性的问题，在内核态可以关中断，用户态不行，所以可能需要系统调用。或者使用原子硬件指令，再加上一个锁，保证原子指令集只会一个线程运行。

如果不用信号量实现条件变量，可以用原子指令来模拟信号量的实现，条件变量的本质就是一个信号量和一个等待队列，而信号量可以完美用原子指令代替，所以可以这么实现。

##重要知识点
信号量的使用，条件变量的使用，管程的概念。