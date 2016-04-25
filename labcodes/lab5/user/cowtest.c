#include <stdio.h>
#include <ulib.h>
#define MAX 128
int a[MAX][MAX];

int
main(void) {
    int i, j, k;
    cprintf("cow swap out test begin.\n");
    for (k = 0; k < 100000; k ++) {
	for (j = 0; j < MAX;j ++)
		for (i = 0; i < MAX;i ++)
			a[i][j] += 1;
	cprintf("cow status = %d\n", a[0][0]);
	}
    // int *a = (int *) malloc(4096);
    return 0;
}

