OPERATING SYSTEMS LAB ASSIGNMENT - QUESTION 1
Counting Semaphores for Process Synchronization

1. OBJECTIVE
- Base           : mit-pdos/xv6-public
- Test Program   : synctest.c
- Shell Command  : $ synctest

Question- 
xv6 has sleep()/wakeup() inside the kernel only. Add counting semaphores so that
user processes (related by fork()) can synchronize with each other:
(a) kernel table of 8 semaphores (ids 0..7), each {value, inuse}, protected by a
    spinlock initialised at kernel start.
(b) int sem_init(int id, int value) -- 0; -1 for bad id or value < 0
  int sem_wait(int id) -- blocks with sleep() while value == 0, else decrements, returns 0
  int sem_post(int id) -- increments, wakeup()s waiters, returns 0
  wait/post return -1 on a bad id or a never-initialised semaphore.
(c) synctest.c: 3 children print A, B, C five times each, forced to the order
  ABCABC... using only semaphores (no sleep() in user code, no busy waiting).
  Parent waits for all children and prints "Done".

2. DESIGN NOTES
- One spinlock (semtable.lock) guards the whole table. sem_wait calls
  sleep(&sem[id], &semtable.lock) with that lock held and sem_post changes the
  value under the same lock, so a wake-up cannot be lost.
- sem_wait uses `while(value == 0) sleep(...)`: one post may wake several waiters
  but only some can proceed, so the value is re-checked after every wake-up.
- A killed process sleeping in sem_wait returns -1 instead of blocking forever.
- synctest: sem0=1, sem1=0, sem2=0. Child i: repeat 5 times { sem_wait(i);
  print letter; sem_post((i+1)%3); }  => token passes A -> B -> C -> A ...
  Before the main test it also checks the -1 error returns.


3. FILES ADDED / MODIFIED
--------------------------------------------------------------------------------
File                | Nature   | Change
--------------------+----------+------------------------------------------------
kernel/sem.c        | Created  | semtable, seminit(), semcreate(), semwait(), sempost()
user/synctest.c     | Created  | test program for part (c)
kernel/defs.h       | Modified | prototypes for the four functions of sem.c
kernel/main.c       | Modified | seminit() called in main()
kernel/syscall.h    | Modified | SYS_sem_init 22, SYS_sem_wait 23, SYS_sem_post 24
kernel/syscall.c    | Modified | extern declarations + syscalls[] entries
kernel/sysproc.c    | Modified | sys_sem_init / sys_sem_wait / sys_sem_post
user/user.h         | Modified | user prototypes
user/usys.S   Modified | SYSCALL(sem_init/sem_wait/sem_post)


4. HOW TO COMPILE AND RUN
make clean && make qemu
$ synctest
Exit QEMU: Ctrl-A + X


5. VERIFIED OUTPUT
this is the ans 
$ synctest
ABCABCABCABCABC
Done
