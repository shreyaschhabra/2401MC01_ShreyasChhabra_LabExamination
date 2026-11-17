// memtest: exercises the freepages() and va2pa() system calls.
#include "types.h"
#include "stat.h"
#include "user.h"

int g = 42;   // global variable whose address we translate

int
main(void)
{
  int before, after_fork, after_wait, pid, p[2];
  char c;

  // (i) free pages at start-up
  printf(1, "(i)   freepages() at start-up        : %d\n", freepages());

  // (ii) after growing the heap by 10 pages
  if(sbrk(10 * 4096) == (char*)-1){
    printf(1, "sbrk failed\n");
    exit();
  }
  printf(1, "(ii)  freepages() after sbrk(10*4096): %d\n", freepages());

  // (iii) virtual and physical address of a global variable
  printf(1, "(iii) &g: va = 0x%x  pa = 0x%x\n", (int)&g, va2pa((int)&g));

  // (iv) an address that is not mapped
  printf(1, "(iv)  va2pa(0x7FFFFFFF) = %d\n", va2pa(0x7FFFFFFF));

  // (v) fork: the pipe only orders the output, it is created before the
  // "before" snapshot so it does not disturb the page counts.
  if(pipe(p) < 0){
    printf(1, "pipe failed\n");
    exit();
  }
  before = freepages();
  printf(1, "(v)   freepages() before fork        : %d\n", before);

  pid = fork();
  if(pid < 0){
    printf(1, "fork failed\n");
    exit();
  }
  if(pid == 0){
    // child: same virtual address, different physical page (pages are copied)
    printf(1, "      child : va = 0x%x  pa = 0x%x\n", (int)&g, va2pa((int)&g));
    write(p[1], "x", 1);   // tell the parent we have printed
    exit();
  }
  read(p[0], &c, 1);       // child has printed and is now exiting (zombie)
  after_fork = freepages();
  printf(1, "      parent: va = 0x%x  pa = 0x%x\n", (int)&g, va2pa((int)&g));
  printf(1, "      freepages() after fork         : %d\n", after_fork);

  wait();
  after_wait = freepages();
  printf(1, "      freepages() after child reaped : %d\n", after_wait);

  if(after_wait == before)
    printf(1, "No memory leak: %d == %d\n", after_wait, before);
  else
    printf(1, "LEAK: before fork %d, after wait %d\n", before, after_wait);

  close(p[0]);
  close(p[1]);
  exit();
}
