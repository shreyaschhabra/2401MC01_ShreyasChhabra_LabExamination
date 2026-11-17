// Cnting semaphore for user processes
#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"

#define NSEM 8

struct {
  struct spinlock lock;
  struct {
    int value;
    int inuse;
  } sem[NSEM];
} semtable;

// Called once from main() at kernel start.
void
seminit(void)
{
  int i;

  initlock(&semtable.lock, "semtable");
  for(i = 0; i < NSEM; i++){
    semtable.sem[i].value = 0;
    semtable.sem[i].inuse = 0;
  }
}

int
semcreate(int id, int value)
{
  if(id < 0 || id >= NSEM || value < 0)
    return -1;
  acquire(&semtable.lock);
  semtable.sem[id].value = value;
  semtable.sem[id].inuse = 1;
  release(&semtable.lock);
  return 0;
}

int
semwait(int id)
{
  if(id < 0 || id >= NSEM)
    return -1;
  acquire(&semtable.lock);
  if(!semtable.sem[id].inuse){
    release(&semtable.lock);
    return -1;
  }
  // Re-check the value after every wake-up (several waiters may be woken
  // by one post, only some of them can proceed).
  while(semtable.sem[id].value == 0){
    if(myproc()->killed){
      release(&semtable.lock);
      return -1;
    }
    sleep(&semtable.sem[id], &semtable.lock);
  }
  semtable.sem[id].value--;
  release(&semtable.lock);
  return 0;
}

int
sempost(int id)
{
  if(id < 0 || id >= NSEM)
    return -1;
  acquire(&semtable.lock);
  if(!semtable.sem[id].inuse){
    release(&semtable.lock);
    return -1;
  }
  semtable.sem[id].value++;
  wakeup(&semtable.sem[id]);
  release(&semtable.lock);
  return 0;
}
