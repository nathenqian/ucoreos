#操作系统第八次实验报告
钱迪晨 2013011402 计35
##练习1

请在实验报告中给出设计实现”UNIX的PIPE机制“的概要设方案，鼓励给出详细设计方案

答：

PIPE机制是用来一个进程写内容，一个进程读内容的特殊内存文件。由于是内存文件，所以只保存在内存当中。这样的话，VFS接口都是一样的，一个进程只能写，一个进程只能读。在VFS下面一层实际FS中对管道的操作主要就是维护管道的这么一个队列，DEVICE则仅仅就是对内存的读写。

具体实现的时候，可以新建数据结构PIPE_INODE，里面最重要的需要记录一个内存的页，表示管道开始的内存，然后利用链表的结构来维护整个PIPE的队列，同时需要两个指针维护管道的头和尾。这里的链表我觉得可以把每一页的最后4Byte用来当做下一页的开始。如果往管道里面写的内容超过了管道的最大一页，那么就新分配一页用来，如果读完了一页，那么就应该free掉这个页。

	struct pipe_inode {
		struct pipe_disk_inode *din; //仅仅用来简单的鞋
		semaphore_t sem;                                /* semaphore for din */
		list_entry_t inode_link;                        /* entry for linked-list in sfs_fs */
		list_entry_t hash_link;                         /* entry for hash linked-list in sfs_fs */
		char *pipe_list_head; // 这个是pipe队列的第一个页的地址
		char *pipe_list_tail; // 这个是pipe队列的最后一个页的地址
		uint32_t head_offset, tail_offset; // 表示的是pipe当前头尾页的偏移。

		
	}

DEVICE这里仅仅就是对内存的读写，比较简单。

##练习2
请在实验报告中给出设计实现基于”UNIX的硬链接和软链接机制“的概要设方案，鼓励给出详细设计方案

答：

对于硬链接，每个链接都会单独的新建不同的inode，指向一样的disk_inode，由于我们在disk上记录了这个文件的硬链接数目，所以现在的ucore基本上已经可以支持硬链接了。

对于软链接实际上，我们只需要标记这是软链接以及链接的地址，查找inode的时候找到对应的真正的地址所对应的inode就可以了。具体事先的时候在inode的struct里面增加soft_link_flag表示是不是软链接，如果是还有一个数据结构char *soft_dir表示链接的地址，这样就可以事先软链接了。

	struct inode {
	    union {
	        struct device __device_info;
	        struct sfs_inode __sfs_inode_info;
	    } in_info;
	    enum {
	        inode_type_device_info = 0x1234,
	        inode_type_sfs_inode_info,
	    } in_type;
	    int ref_count;
	    int open_count;
	    struct fs *in_fs;
	    const struct inode_ops *in_ops;
	    bool soft_link_flag; //是不是软链接
	    char *soft_dir; //如果是那么软链接的地址是什么
	};

##重要知识点
文件系统的分层结构的理解，如何一层一层的调用接口，从VFS到SFS到DEVICE。