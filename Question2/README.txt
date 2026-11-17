OPERATING SYSTEMS LAB ASSIGNMENT - QUESTION 2
Memory Statistics and Address Translation

1. OBJECTIVE
- Base           : mit-pdos/xv6-public
- Test Program   : memtest.c
- Shell Command  : $ memtest

Question-
xv6 allocates 4096-byte pages from a free list (kalloc.c) and translates addresses
with a two-level page table (vm.c). Add two system calls that let a user program
observe both:
(a) kalloc.c keeps a count of free physical pages, updated in kalloc() and kfree()
    (kmem.lock used when in use). int freepages(void) returns the count.
(b) int va2pa(int va) walks the page table of the calling process (helper in vm.c,
    declared in defs.h, because walkpgdir() is static) and returns the physical
    address (frame address + page offset); -1 if the page is not present or
    PTE_U is not set.
(c) memtest.c prints: (i) freepages() at start-up; (ii) freepages() after
    sbrk(10*4096); (iii) va and pa of a global variable; (iv) va2pa(0x7FFFFFFF);
    (v) after fork(): pa of the global in parent and child, freepages() after the
    fork and again after the child has exited and been reaped with wait().

2. DESIGN NOTES
- kmem.nfree is incremented in kfree() and decremented in kalloc() in the same
  place the free list is changed, so it is under kmem.lock whenever the lock is
  in use (kmem.use_lock). kinit1() runs single-threaded before the lock is
  enabled, so the pages freed there are counted too.
- countfreepages() takes kmem.lock (when use_lock) to read nfree.
- va2pa_walk(pgdir, va) calls walkpgdir(pgdir, va, 0) (alloc = 0: never creates
  page tables), rejects a missing PDE/PTE (PTE_P) and kernel-only pages (PTE_U),
  and returns PTE_ADDR(*pte) | (va & 0xFFF). sys_va2pa passes myproc()->pgdir.
- Same virtual address, different physical address in parent and child: fork()
  uses copyuvm(), which allocates new pages and copies the content.
- A zombie child still holds its page table and pages until the parent calls
  wait(); only then are they freed. That is why freepages() drops after the
  fork (80 pages: child's pages + page tables + kernel stack) and returns to the
  exact value it had before fork() after wait().
- A pipe in memtest only orders the output (child prints, then parent). It is
  created before the "before fork" snapshot so it does not change the counts.

3. FILES ADDED / MODIFIED
--------------------------------------------------------------------------------
File                | Nature   | Change
--------------------+----------+------------------------------------------------
user/memtest.c      | Created  | test program for part (c)
kernel/kalloc.c     | Modified | kmem.nfree, updated in kalloc()/kfree(); countfreepages()
kernel/vm.c         | Modified | va2pa_walk() helper (uses static walkpgdir)
kernel/defs.h       | Modified | prototypes for countfreepages() and va2pa_walk()
kernel/syscall.h    | Modified | SYS_freepages 22, SYS_va2pa 23
kernel/syscall.c    | Modified | extern declarations + syscalls[] entries
kernel/sysproc.c    | Modified | sys_freepages / sys_va2pa
user/user.h         | Modified | user prototypes
user/usys.S         | Modified | SYSCALL(freepages), SYSCALL(va2pa)
Makefile            | Modified | $U/_memtest added to UPROGS

4. HOW TO COMPILE AND RUN
make clean && make qemu
$ memtest
Exit QEMU: Ctrl-A + X

5. VERIFIED OUTPUT (also in "screenshot(output evidence)/output.txt")
$ memtest
(i)   freepages() at start-up        : 56789
(ii)  freepages() after sbrk(10*4096): 56779
(iii) &g: va = 0xBC8  pa = 0xDEE2BC8
(iv)  va2pa(0x7FFFFFFF) = -1
(v)   freepages() before fork        : 56778
      child : va = 0xBC8  pa = 0xDF74BC8
      parent: va = 0xBC8  pa = 0xDEE2BC8
      freepages() after fork         : 56698
      freepages() after child reaped : 56778
No memory leak: 56778 == 56778
