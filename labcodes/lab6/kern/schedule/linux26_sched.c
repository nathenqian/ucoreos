#include <defs.h>
#include <list.h>
#include <proc.h>
#include <assert.h>
#include <default_sched.h>

#define LINUX26_MAX_PRIORITY 32

static void
linux26_init(struct run_queue *rq) {
     /* LAB6: YOUR CODE 
      * (1) init the ready process list: rq->run_list
      * (2) init the run pool: rq->lab6_run_pool
      * (3) set number of process: rq->proc_num to 0       
      */
    int i;
    rq->active_list = rq->list1;
    rq->expire_list = rq->list2;
    for (i = 0; i < LINUX26_MAX_PRIORITY; i ++) {
      list_init(&(rq->active_list[i]));
      list_init(&(rq->expire_list[i]));
    }
    rq->active_bitmap = rq->expire_bitmap = 0;
    rq->proc_num = 0;
}

/*
 * stride_enqueue inserts the process ``proc'' into the run-queue
 * ``rq''. The procedure should verify/initialize the relevant members
 * of ``proc'', and then put the ``lab6_run_pool'' node into the
 * queue(since we use priority queue here). The procedure should also
 * update the meta date in ``rq'' structure.
 *
 * proc->time_slice denotes the time slices allocation for the
 * process, which should set to rq->max_time_slice.
 * 
 * hint: see libs/skew_heap.h for routines of the priority
 * queue structures.
 */
static void
linux26_enqueue(struct run_queue *rq, struct proc_struct *proc) {
     /* LAB6: YOUR CODE 
      * (1) insert the proc into rq correctly
      * NOTICE: you can use skew_heap or list. Important functions
      *         skew_heap_insert: insert a entry into skew_heap
      *         list_add_before: insert  a entry into the last of list   
      * (2) recalculate proc->time_slice
      * (3) set proc->rq pointer to rq
      * (4) increase rq->proc_num
      */
    if (list_empty(&(rq->expire_list[proc->lab6_priority]))) {
      rq->expire_bitmap |= ((unsigned int)1) << proc->lab6_priority;
    }
    list_add_before(&(rq->expire_list[proc->lab6_priority]), &proc->run_link);

    if (proc->time_slice == 0 || proc->time_slice > rq->max_time_slice) {
        proc->time_slice = rq->max_time_slice;
    }
    proc->rq = rq;
    rq->proc_num += 1;
}

/*
 * stride_dequeue removes the process ``proc'' from the run-queue
 * ``rq'', the operation would be finished by the skew_heap_remove
 * operations. Remember to update the ``rq'' structure.
 *
 * hint: see libs/skew_heap.h for routines of the priority
 * queue structures.
 */
static void
linux26_dequeue(struct run_queue *rq, struct proc_struct *proc) {
     /* LAB6: YOUR CODE 
      * (1) remove the proc from rq correctly
      * NOTICE: you can use skew_heap or list. Important functions
      *         skew_heap_remove: remove a entry from skew_heap
      *         list_del_init: remove a entry from the  list
      */

    list_del(&(proc->run_link));
    if (list_empty(&(rq->expire_list[proc->lab6_priority]))) {
      rq->expire_bitmap &= ~(((unsigned int)1) << proc->lab6_priority);
    }
    rq->proc_num --;

}
/*
 * stride_pick_next pick the element from the ``run-queue'', with the
 * minimum value of stride, and returns the corresponding process
 * pointer. The process pointer would be calculated by macro le2proc,
 * see kern/process/proc.h for definition. Return NULL if
 * there is no process in the queue.
 *
 * When one proc structure is selected, remember to update the stride
 * property of the proc. (stride += BIG_STRIDE / priority)
 *
 * hint: see libs/skew_heap.h for routines of the priority
 * queue structures.
 */
static struct proc_struct *
linux26_pick_next(struct run_queue *rq) {
     /* LAB6: YOUR CODE 
      * (1) get a  proc_struct pointer p  with the minimum value of stride
             (1.1) If using skew_heap, we can use le2proc get the p from rq->lab6_run_poll
             (1.2) If using list, we have to search list to find the p with minimum stride value
      * (2) update p;s stride value: p->lab6_stride
      * (3) return p
      */
     unsigned int u, t;
     if (rq->lab6_run_pool == NULL) return NULL;
     if (rq->active_bitmap == 0) {
      unsigned int temp = rq->active_bitmap;
      rq->active_bitmap = rq->expire_bitmap;
      rq->expire_bitmap = temp;
      list_entry_t *stemp = rq->active_list;
      rq->active_list = rq->expire_list;
      rq->expire_list = stemp;
     }
     if (rq->active_bitmap == 0) return NULL;
     for (u = 1, t = 1; t <= 32; t ++, u <<= 1)
      if ((rq->active_bitmap) & u != 0) {
        struct proc_struct *p = le2proc(rq->active_list[u].next, run_link);
        return p;
      }
}

/*
 * stride_proc_tick works with the tick event of current process. You
 * should check whether the time slices for current process is
 * exhausted and update the proc struct ``proc''. proc->time_slice
 * denotes the time slices left for current
 * process. proc->need_resched is the flag variable for process
 * switching.
 */
static void
linux26_proc_tick(struct run_queue *rq, struct proc_struct *proc) {
     /* LAB6: YOUR CODE */
    if (proc->time_slice > 0) {
        -- proc->time_slice;
    } else {
        proc->need_resched = 1;
    }
}

struct sched_class linux26_sched_class = {
     .name = "linux26_scheduler",
     .init = linux26_init,
     .enqueue = linux26_enqueue,
     .dequeue = linux26_dequeue,
     .pick_next = linux26_pick_next,
     .proc_tick = linux26_proc_tick,
};
