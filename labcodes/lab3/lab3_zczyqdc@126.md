#操作系统第三次实验报告
钱迪晨 2013011402 计35
##练习1
###题目1
请描述页目录项（Pag Director Entry）和页表（Page Table Entry）中组成部分对ucore实现页替换算法的潜在用处。

答：页替换算法中存储的是一个线性地址la，通过PDE查找到对应的PTE，根据PTE的Present位决定是否缺页。缺页以后，根据read/write和present位置进行读写权限的判断。

###题目2
如果ucore的缺页服务例程在执行过程中访问内存，出现了页访问异常，请问硬件要做哪些事情？

答：硬件应该保存现场，进行嵌套中断，嵌套调用缺页服务例程，来获得缺失的页面。

##练习2
###题目1
如果要在ucore上实现"extended clock页替换算法"请给你的设计方案，现有的swap_manager框架是否足以支持在ucore中实现此算法？如果是，请给你的设计方案。如果不是，请给出你的新的扩展和基此扩展的设计方案。

- 需要被换出的页的特征是什么？
- 在ucore中如何判断具有这样特征的页？
- 何时进行换入和换出操作？

答：现有框架可以实现。只需要按照算法实现。由于硬件会自动记录页表的脏位和访问位置，我们只需要在访问Page数据结构的时候进行这两位的访问修改即可。

页的特征一定是，脏位=0，修改位=0.

缺页的时候进行换入换出。

##challenge
实现了基于脏位的页替换算法。
具体实现方式如下。

我将head当做当前查找的开始位置。
	
	*head = mm->sm_priv 表示的是当前查找的位置

插入的时候，在head前面插入页。

询问的时候，使用如下代码。

	while (1) {
        if (head == (list_entry_t*) mm->sm_priv) {
            head = list_next(head); // 查找到了哨兵跳过
        }
        struct Page *p = le2page(head, pra_page_link);
        pte_t *ptep = get_pte(mm->pgdir, p->pra_vaddr, 0);
        if ((*ptep & 0x40) > 0) { //如果脏位是1
            *ptep ^= 0x40; //修改脏位0
            head = list_next(head);
        } else {
            //swap out
            list_del(temp_head);
            prev = list_prev(head);
            *ptr_page = le2page(head, pra_page_link);
            list_del(head);
            list_add_after(prev, temp_head); //进行head的调整，以及页面的删除。
            return 0;
        }
    } 

可以在lab3cha分支里面查看代码。

##和提供答案的区别
实现了challenge。

##重要知识点
页替换算法，以及ucore的一些基础函数。