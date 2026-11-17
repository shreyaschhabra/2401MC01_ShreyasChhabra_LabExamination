// Prints A B C A B C ... (5 rounds) using only counting semaphores.
#include "types.h"
#include "stat.h"
#include "user.h"

#define ROUNDS 5

static void
child(int idx, char letter)
{
  int i;

  for(i = 0; i < ROUNDS; i++){
    sem_wait(idx);                 // wait for my turn
    printf(1, "%c", letter);
    sem_post((idx + 1) % 3);       // hand the turn to the next letter
  }
  exit();
}

int
main(void)
{
  int i;

  // Invalid-argument checks of the system calls.
  if(sem_init(-1, 0) != -1 || sem_init(8, 0) != -1 || sem_init(0, -1) != -1 ||
     sem_wait(7) != -1 || sem_post(7) != -1 || sem_wait(9) != -1){
    printf(1, "synctest: error-return check FAILED\n");
    exit();
  }

  sem_init(0, 1);   // A may go first
  sem_init(1, 0);
  sem_init(2, 0);

  for(i = 0; i < 3; i++){
    int pid = fork();
    if(pid < 0){
      printf(1, "synctest: fork failed\n");
      exit();
    }
    if(pid == 0)
      child(i, 'A' + i);
  }
  for(i = 0; i < 3; i++)
    wait();
  printf(1, "\nDone\n");
  exit();
}
