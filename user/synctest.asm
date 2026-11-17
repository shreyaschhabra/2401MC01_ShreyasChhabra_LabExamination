
user/_synctest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  exit();
}

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 20             	sub    $0x20,%esp
  int i;

  // Invalid-argument checks of the system calls.
  if(sem_init(-1, 0) != -1 || sem_init(8, 0) != -1 || sem_init(0, -1) != -1 ||
  14:	6a 00                	push   $0x0
  16:	6a ff                	push   $0xffffffff
  18:	e8 3a 04 00 00       	call   457 <sem_init>
  1d:	83 c4 10             	add    $0x10,%esp
  20:	83 f8 ff             	cmp    $0xffffffff,%eax
  23:	74 14                	je     39 <main+0x39>
     sem_wait(7) != -1 || sem_post(7) != -1 || sem_wait(9) != -1){
    printf(1, "synctest: error-return check FAILED\n");
  25:	83 ec 08             	sub    $0x8,%esp
  28:	68 e8 08 00 00       	push   $0x8e8
  2d:	6a 01                	push   $0x1
  2f:	e8 0c 05 00 00       	call   540 <printf>
    exit();
  34:	e8 7e 03 00 00       	call   3b7 <exit>
  if(sem_init(-1, 0) != -1 || sem_init(8, 0) != -1 || sem_init(0, -1) != -1 ||
  39:	50                   	push   %eax
  3a:	50                   	push   %eax
  3b:	6a 00                	push   $0x0
  3d:	6a 08                	push   $0x8
  3f:	e8 13 04 00 00       	call   457 <sem_init>
  44:	83 c4 10             	add    $0x10,%esp
  47:	83 c0 01             	add    $0x1,%eax
  4a:	75 d9                	jne    25 <main+0x25>
  4c:	50                   	push   %eax
  4d:	50                   	push   %eax
  4e:	6a ff                	push   $0xffffffff
  50:	6a 00                	push   $0x0
  52:	e8 00 04 00 00       	call   457 <sem_init>
  57:	83 c4 10             	add    $0x10,%esp
  5a:	83 c0 01             	add    $0x1,%eax
  5d:	75 c6                	jne    25 <main+0x25>
     sem_wait(7) != -1 || sem_post(7) != -1 || sem_wait(9) != -1){
  5f:	83 ec 0c             	sub    $0xc,%esp
  62:	6a 07                	push   $0x7
  64:	e8 f6 03 00 00       	call   45f <sem_wait>
  if(sem_init(-1, 0) != -1 || sem_init(8, 0) != -1 || sem_init(0, -1) != -1 ||
  69:	83 c4 10             	add    $0x10,%esp
  6c:	83 c0 01             	add    $0x1,%eax
  6f:	75 b4                	jne    25 <main+0x25>
     sem_wait(7) != -1 || sem_post(7) != -1 || sem_wait(9) != -1){
  71:	83 ec 0c             	sub    $0xc,%esp
  74:	6a 07                	push   $0x7
  76:	e8 ec 03 00 00       	call   467 <sem_post>
  7b:	83 c4 10             	add    $0x10,%esp
  7e:	83 c0 01             	add    $0x1,%eax
  81:	75 a2                	jne    25 <main+0x25>
  83:	83 ec 0c             	sub    $0xc,%esp
  86:	6a 09                	push   $0x9
  88:	e8 d2 03 00 00       	call   45f <sem_wait>
  8d:	83 c4 10             	add    $0x10,%esp
  90:	83 c0 01             	add    $0x1,%eax
  93:	75 90                	jne    25 <main+0x25>
  }

  sem_init(0, 1);   // A may go first
  95:	51                   	push   %ecx
  96:	51                   	push   %ecx
  97:	6a 01                	push   $0x1
  99:	6a 00                	push   $0x0
  9b:	e8 b7 03 00 00       	call   457 <sem_init>
  sem_init(1, 0);
  a0:	5b                   	pop    %ebx
  a1:	5e                   	pop    %esi
  a2:	6a 00                	push   $0x0
  a4:	6a 01                	push   $0x1
  sem_init(2, 0);

  for(i = 0; i < 3; i++){
  a6:	31 db                	xor    %ebx,%ebx
  sem_init(1, 0);
  a8:	e8 aa 03 00 00       	call   457 <sem_init>
  sem_init(2, 0);
  ad:	5f                   	pop    %edi
  ae:	58                   	pop    %eax
  af:	6a 00                	push   $0x0
  b1:	6a 02                	push   $0x2
  b3:	e8 9f 03 00 00       	call   457 <sem_init>
  b8:	83 c4 10             	add    $0x10,%esp
    int pid = fork();
  bb:	e8 ef 02 00 00       	call   3af <fork>
    if(pid < 0){
  c0:	85 c0                	test   %eax,%eax
  c2:	78 79                	js     13d <main+0x13d>
    sem_post((idx + 1) % 3);       // hand the turn to the next letter
  c4:	8d 43 01             	lea    0x1(%ebx),%eax
      printf(1, "synctest: fork failed\n");
      exit();
    }
    if(pid == 0)
  c7:	74 2b                	je     f4 <main+0xf4>
  for(i = 0; i < 3; i++){
  c9:	83 f8 03             	cmp    $0x3,%eax
  cc:	74 04                	je     d2 <main+0xd2>
  ce:	89 c3                	mov    %eax,%ebx
  d0:	eb e9                	jmp    bb <main+0xbb>
      child(i, 'A' + i);
  }
  for(i = 0; i < 3; i++)
    wait();
  d2:	e8 e8 02 00 00       	call   3bf <wait>
  d7:	e8 e3 02 00 00       	call   3bf <wait>
  dc:	e8 de 02 00 00       	call   3bf <wait>
  printf(1, "\nDone\n");
  e1:	50                   	push   %eax
  e2:	50                   	push   %eax
  e3:	68 27 09 00 00       	push   $0x927
  e8:	6a 01                	push   $0x1
  ea:	e8 51 04 00 00       	call   540 <printf>
  exit();
  ef:	e8 c3 02 00 00       	call   3b7 <exit>
    sem_post((idx + 1) % 3);       // hand the turn to the next letter
  f4:	be 03 00 00 00       	mov    $0x3,%esi
  f9:	99                   	cltd
      child(i, 'A' + i);
  fa:	8d 4b 41             	lea    0x41(%ebx),%ecx
    sem_post((idx + 1) % 3);       // hand the turn to the next letter
  fd:	f7 fe                	idiv   %esi
  ff:	0f b6 f9             	movzbl %cl,%edi
 102:	89 d6                	mov    %edx,%esi
 104:	ba 05 00 00 00       	mov    $0x5,%edx
    sem_wait(idx);                 // wait for my turn
 109:	83 ec 0c             	sub    $0xc,%esp
 10c:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 10f:	53                   	push   %ebx
 110:	e8 4a 03 00 00       	call   45f <sem_wait>
    printf(1, "%c", letter);
 115:	83 c4 0c             	add    $0xc,%esp
 118:	57                   	push   %edi
 119:	68 24 09 00 00       	push   $0x924
 11e:	6a 01                	push   $0x1
 120:	e8 1b 04 00 00       	call   540 <printf>
    sem_post((idx + 1) % 3);       // hand the turn to the next letter
 125:	89 34 24             	mov    %esi,(%esp)
 128:	e8 3a 03 00 00       	call   467 <sem_post>
  for(i = 0; i < ROUNDS; i++){
 12d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 130:	83 c4 10             	add    $0x10,%esp
 133:	83 ea 01             	sub    $0x1,%edx
 136:	75 d1                	jne    109 <main+0x109>
  exit();
 138:	e8 7a 02 00 00       	call   3b7 <exit>
      printf(1, "synctest: fork failed\n");
 13d:	52                   	push   %edx
 13e:	52                   	push   %edx
 13f:	68 0d 09 00 00       	push   $0x90d
 144:	6a 01                	push   $0x1
 146:	e8 f5 03 00 00       	call   540 <printf>
      exit();
 14b:	e8 67 02 00 00       	call   3b7 <exit>
 150:	66 90                	xchg   %ax,%ax
 152:	66 90                	xchg   %ax,%ax
 154:	66 90                	xchg   %ax,%ax
 156:	66 90                	xchg   %ax,%ax
 158:	66 90                	xchg   %ax,%ax
 15a:	66 90                	xchg   %ax,%ax
 15c:	66 90                	xchg   %ax,%ax
 15e:	66 90                	xchg   %ax,%ax

00000160 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 160:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 161:	31 c0                	xor    %eax,%eax
{
 163:	89 e5                	mov    %esp,%ebp
 165:	53                   	push   %ebx
 166:	8b 4d 08             	mov    0x8(%ebp),%ecx
 169:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 16c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 170:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 174:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 177:	83 c0 01             	add    $0x1,%eax
 17a:	84 d2                	test   %dl,%dl
 17c:	75 f2                	jne    170 <strcpy+0x10>
    ;
  return os;
}
 17e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 181:	89 c8                	mov    %ecx,%eax
 183:	c9                   	leave
 184:	c3                   	ret
 185:	8d 76 00             	lea    0x0(%esi),%esi
 188:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 18f:	00 

00000190 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	53                   	push   %ebx
 194:	8b 55 08             	mov    0x8(%ebp),%edx
 197:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 19a:	0f b6 02             	movzbl (%edx),%eax
 19d:	84 c0                	test   %al,%al
 19f:	75 2d                	jne    1ce <strcmp+0x3e>
 1a1:	eb 3d                	jmp    1e0 <strcmp+0x50>
 1a3:	eb 1b                	jmp    1c0 <strcmp+0x30>
 1a5:	8d 76 00             	lea    0x0(%esi),%esi
 1a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1af:	00 
 1b0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1b7:	00 
 1b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1bf:	00 
 1c0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 1c4:	83 c2 01             	add    $0x1,%edx
 1c7:	83 c1 01             	add    $0x1,%ecx
  while(*p && *p == *q)
 1ca:	84 c0                	test   %al,%al
 1cc:	74 12                	je     1e0 <strcmp+0x50>
 1ce:	0f b6 19             	movzbl (%ecx),%ebx
 1d1:	38 c3                	cmp    %al,%bl
 1d3:	74 eb                	je     1c0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 1d5:	29 d8                	sub    %ebx,%eax
}
 1d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1da:	c9                   	leave
 1db:	c3                   	ret
 1dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return (uchar)*p - (uchar)*q;
 1e0:	0f b6 19             	movzbl (%ecx),%ebx
 1e3:	31 c0                	xor    %eax,%eax
 1e5:	29 d8                	sub    %ebx,%eax
}
 1e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1ea:	c9                   	leave
 1eb:	c3                   	ret
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001f0 <strlen>:

uint
strlen(const char *s)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1f6:	80 3a 00             	cmpb   $0x0,(%edx)
 1f9:	74 15                	je     210 <strlen+0x20>
 1fb:	31 c0                	xor    %eax,%eax
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
 200:	83 c0 01             	add    $0x1,%eax
 203:	89 c1                	mov    %eax,%ecx
 205:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 209:	75 f5                	jne    200 <strlen+0x10>
    ;
  return n;
}
 20b:	89 c8                	mov    %ecx,%eax
 20d:	5d                   	pop    %ebp
 20e:	c3                   	ret
 20f:	90                   	nop
  for(n = 0; s[n]; n++)
 210:	31 c9                	xor    %ecx,%ecx
}
 212:	5d                   	pop    %ebp
 213:	89 c8                	mov    %ecx,%eax
 215:	c3                   	ret
 216:	66 90                	xchg   %ax,%ax
 218:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 21f:	00 

00000220 <memset>:

void*
memset(void *dst, int c, uint n)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 224:	8b 4d 10             	mov    0x10(%ebp),%ecx
 227:	8b 45 0c             	mov    0xc(%ebp),%eax
 22a:	8b 7d 08             	mov    0x8(%ebp),%edi
 22d:	fc                   	cld
 22e:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 230:	8b 45 08             	mov    0x8(%ebp),%eax
 233:	8b 7d fc             	mov    -0x4(%ebp),%edi
 236:	c9                   	leave
 237:	c3                   	ret
 238:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 23f:	00 

00000240 <strchr>:

char*
strchr(const char *s, char c)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 45 08             	mov    0x8(%ebp),%eax
 246:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 24a:	0f b6 10             	movzbl (%eax),%edx
 24d:	84 d2                	test   %dl,%dl
 24f:	75 1a                	jne    26b <strchr+0x2b>
 251:	eb 25                	jmp    278 <strchr+0x38>
 253:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 258:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 25f:	00 
 260:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 264:	83 c0 01             	add    $0x1,%eax
 267:	84 d2                	test   %dl,%dl
 269:	74 0d                	je     278 <strchr+0x38>
    if(*s == c)
 26b:	38 d1                	cmp    %dl,%cl
 26d:	75 f1                	jne    260 <strchr+0x20>
      return (char*)s;
  return 0;
}
 26f:	5d                   	pop    %ebp
 270:	c3                   	ret
 271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 278:	31 c0                	xor    %eax,%eax
}
 27a:	5d                   	pop    %ebp
 27b:	c3                   	ret
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000280 <gets>:

char*
gets(char *buf, int max)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	57                   	push   %edi
 284:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 285:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 288:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 289:	31 db                	xor    %ebx,%ebx
{
 28b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 28e:	eb 27                	jmp    2b7 <gets+0x37>
    cc = read(0, &c, 1);
 290:	83 ec 04             	sub    $0x4,%esp
 293:	6a 01                	push   $0x1
 295:	57                   	push   %edi
 296:	6a 00                	push   $0x0
 298:	e8 32 01 00 00       	call   3cf <read>
    if(cc < 1)
 29d:	83 c4 10             	add    $0x10,%esp
 2a0:	85 c0                	test   %eax,%eax
 2a2:	7e 1d                	jle    2c1 <gets+0x41>
      break;
    buf[i++] = c;
 2a4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2a8:	8b 55 08             	mov    0x8(%ebp),%edx
 2ab:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2af:	3c 0a                	cmp    $0xa,%al
 2b1:	74 1d                	je     2d0 <gets+0x50>
 2b3:	3c 0d                	cmp    $0xd,%al
 2b5:	74 19                	je     2d0 <gets+0x50>
  for(i=0; i+1 < max; ){
 2b7:	89 de                	mov    %ebx,%esi
 2b9:	83 c3 01             	add    $0x1,%ebx
 2bc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2bf:	7c cf                	jl     290 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 2c1:	8b 45 08             	mov    0x8(%ebp),%eax
 2c4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2cb:	5b                   	pop    %ebx
 2cc:	5e                   	pop    %esi
 2cd:	5f                   	pop    %edi
 2ce:	5d                   	pop    %ebp
 2cf:	c3                   	ret
  buf[i] = '\0';
 2d0:	8b 45 08             	mov    0x8(%ebp),%eax
    buf[i++] = c;
 2d3:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 2d5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 2d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2dc:	5b                   	pop    %ebx
 2dd:	5e                   	pop    %esi
 2de:	5f                   	pop    %edi
 2df:	5d                   	pop    %ebp
 2e0:	c3                   	ret
 2e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ef:	00 

000002f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f6:	6a 00                	push   $0x0
 2f8:	ff 75 08             	push   0x8(%ebp)
{
 2fb:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 2fe:	e8 f4 00 00 00       	call   3f7 <open>
  if(fd < 0)
 303:	83 c4 10             	add    $0x10,%esp
 306:	85 c0                	test   %eax,%eax
 308:	78 2e                	js     338 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 30a:	83 ec 08             	sub    $0x8,%esp
 30d:	ff 75 0c             	push   0xc(%ebp)
 310:	50                   	push   %eax
 311:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 314:	89 c3                	mov    %eax,%ebx
 316:	e8 f4 00 00 00       	call   40f <fstat>
  close(fd);
 31b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 31e:	89 c6                	mov    %eax,%esi
  close(fd);
 320:	e8 ba 00 00 00       	call   3df <close>
  return r;
 325:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 328:	83 c4 10             	add    $0x10,%esp
}
 32b:	89 f0                	mov    %esi,%eax
 32d:	8b 75 fc             	mov    -0x4(%ebp),%esi
 330:	c9                   	leave
 331:	c3                   	ret
 332:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
 338:	be ff ff ff ff       	mov    $0xffffffff,%esi
 33d:	eb ec                	jmp    32b <stat+0x3b>
 33f:	90                   	nop

00000340 <atoi>:

int
atoi(const char *s)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	53                   	push   %ebx
 344:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 347:	0f be 02             	movsbl (%edx),%eax
 34a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 34d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 350:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 355:	77 1e                	ja     375 <atoi+0x35>
 357:	90                   	nop
 358:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 35f:	00 
    n = n*10 + *s++ - '0';
 360:	83 c2 01             	add    $0x1,%edx
 363:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 366:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 36a:	0f be 02             	movsbl (%edx),%eax
 36d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 370:	80 fb 09             	cmp    $0x9,%bl
 373:	76 eb                	jbe    360 <atoi+0x20>
  return n;
}
 375:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 378:	89 c8                	mov    %ecx,%eax
 37a:	c9                   	leave
 37b:	c3                   	ret
 37c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000380 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	83 ec 08             	sub    $0x8,%esp
 386:	8b 45 10             	mov    0x10(%ebp),%eax
 389:	8b 55 08             	mov    0x8(%ebp),%edx
 38c:	89 75 f8             	mov    %esi,-0x8(%ebp)
 38f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 392:	85 c0                	test   %eax,%eax
 394:	7e 12                	jle    3a8 <memmove+0x28>
 396:	89 7d fc             	mov    %edi,-0x4(%ebp)
 399:	01 d0                	add    %edx,%eax
  dst = vdst;
 39b:	89 d7                	mov    %edx,%edi
 39d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 3a0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3a1:	39 f8                	cmp    %edi,%eax
 3a3:	75 fb                	jne    3a0 <memmove+0x20>
 3a5:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return vdst;
}
 3a8:	8b 75 f8             	mov    -0x8(%ebp),%esi
 3ab:	89 d0                	mov    %edx,%eax
 3ad:	c9                   	leave
 3ae:	c3                   	ret

000003af <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3af:	b8 01 00 00 00       	mov    $0x1,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret

000003b7 <exit>:
SYSCALL(exit)
 3b7:	b8 02 00 00 00       	mov    $0x2,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret

000003bf <wait>:
SYSCALL(wait)
 3bf:	b8 03 00 00 00       	mov    $0x3,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret

000003c7 <pipe>:
SYSCALL(pipe)
 3c7:	b8 04 00 00 00       	mov    $0x4,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret

000003cf <read>:
SYSCALL(read)
 3cf:	b8 05 00 00 00       	mov    $0x5,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret

000003d7 <write>:
SYSCALL(write)
 3d7:	b8 10 00 00 00       	mov    $0x10,%eax
 3dc:	cd 40                	int    $0x40
 3de:	c3                   	ret

000003df <close>:
SYSCALL(close)
 3df:	b8 15 00 00 00       	mov    $0x15,%eax
 3e4:	cd 40                	int    $0x40
 3e6:	c3                   	ret

000003e7 <kill>:
SYSCALL(kill)
 3e7:	b8 06 00 00 00       	mov    $0x6,%eax
 3ec:	cd 40                	int    $0x40
 3ee:	c3                   	ret

000003ef <exec>:
SYSCALL(exec)
 3ef:	b8 07 00 00 00       	mov    $0x7,%eax
 3f4:	cd 40                	int    $0x40
 3f6:	c3                   	ret

000003f7 <open>:
SYSCALL(open)
 3f7:	b8 0f 00 00 00       	mov    $0xf,%eax
 3fc:	cd 40                	int    $0x40
 3fe:	c3                   	ret

000003ff <mknod>:
SYSCALL(mknod)
 3ff:	b8 11 00 00 00       	mov    $0x11,%eax
 404:	cd 40                	int    $0x40
 406:	c3                   	ret

00000407 <unlink>:
SYSCALL(unlink)
 407:	b8 12 00 00 00       	mov    $0x12,%eax
 40c:	cd 40                	int    $0x40
 40e:	c3                   	ret

0000040f <fstat>:
SYSCALL(fstat)
 40f:	b8 08 00 00 00       	mov    $0x8,%eax
 414:	cd 40                	int    $0x40
 416:	c3                   	ret

00000417 <link>:
SYSCALL(link)
 417:	b8 13 00 00 00       	mov    $0x13,%eax
 41c:	cd 40                	int    $0x40
 41e:	c3                   	ret

0000041f <mkdir>:
SYSCALL(mkdir)
 41f:	b8 14 00 00 00       	mov    $0x14,%eax
 424:	cd 40                	int    $0x40
 426:	c3                   	ret

00000427 <chdir>:
SYSCALL(chdir)
 427:	b8 09 00 00 00       	mov    $0x9,%eax
 42c:	cd 40                	int    $0x40
 42e:	c3                   	ret

0000042f <dup>:
SYSCALL(dup)
 42f:	b8 0a 00 00 00       	mov    $0xa,%eax
 434:	cd 40                	int    $0x40
 436:	c3                   	ret

00000437 <getpid>:
SYSCALL(getpid)
 437:	b8 0b 00 00 00       	mov    $0xb,%eax
 43c:	cd 40                	int    $0x40
 43e:	c3                   	ret

0000043f <sbrk>:
SYSCALL(sbrk)
 43f:	b8 0c 00 00 00       	mov    $0xc,%eax
 444:	cd 40                	int    $0x40
 446:	c3                   	ret

00000447 <sleep>:
SYSCALL(sleep)
 447:	b8 0d 00 00 00       	mov    $0xd,%eax
 44c:	cd 40                	int    $0x40
 44e:	c3                   	ret

0000044f <uptime>:
SYSCALL(uptime)
 44f:	b8 0e 00 00 00       	mov    $0xe,%eax
 454:	cd 40                	int    $0x40
 456:	c3                   	ret

00000457 <sem_init>:
SYSCALL(sem_init)
 457:	b8 16 00 00 00       	mov    $0x16,%eax
 45c:	cd 40                	int    $0x40
 45e:	c3                   	ret

0000045f <sem_wait>:
SYSCALL(sem_wait)
 45f:	b8 17 00 00 00       	mov    $0x17,%eax
 464:	cd 40                	int    $0x40
 466:	c3                   	ret

00000467 <sem_post>:
SYSCALL(sem_post)
 467:	b8 18 00 00 00       	mov    $0x18,%eax
 46c:	cd 40                	int    $0x40
 46e:	c3                   	ret
 46f:	66 90                	xchg   %ax,%ax
 471:	66 90                	xchg   %ax,%ax
 473:	66 90                	xchg   %ax,%ax
 475:	66 90                	xchg   %ax,%ax
 477:	66 90                	xchg   %ax,%ax
 479:	66 90                	xchg   %ax,%ax
 47b:	66 90                	xchg   %ax,%ax
 47d:	66 90                	xchg   %ax,%ax
 47f:	90                   	nop

00000480 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
 486:	89 cb                	mov    %ecx,%ebx
 488:	83 ec 3c             	sub    $0x3c,%esp
 48b:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 48e:	85 d2                	test   %edx,%edx
 490:	0f 89 9a 00 00 00    	jns    530 <printint+0xb0>
 496:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 49a:	0f 84 90 00 00 00    	je     530 <printint+0xb0>
    neg = 1;
    x = -xx;
 4a0:	f7 da                	neg    %edx
    neg = 1;
 4a2:	b8 01 00 00 00       	mov    $0x1,%eax
 4a7:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4aa:	89 d1                	mov    %edx,%ecx
  } else {
    x = xx;
  }

  i = 0;
 4ac:	31 f6                	xor    %esi,%esi
 4ae:	66 90                	xchg   %ax,%ax
 4b0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4b7:	00 
 4b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4bf:	00 
  do{
    buf[i++] = digits[x % base];
 4c0:	89 c8                	mov    %ecx,%eax
 4c2:	31 d2                	xor    %edx,%edx
 4c4:	89 f7                	mov    %esi,%edi
 4c6:	f7 f3                	div    %ebx
 4c8:	8d 76 01             	lea    0x1(%esi),%esi
  }while((x /= base) != 0);
 4cb:	39 d9                	cmp    %ebx,%ecx
    buf[i++] = digits[x % base];
 4cd:	0f b6 92 90 09 00 00 	movzbl 0x990(%edx),%edx
  }while((x /= base) != 0);
 4d4:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
 4d6:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 4da:	73 e4                	jae    4c0 <printint+0x40>
  if(neg)
 4dc:	8b 45 c0             	mov    -0x40(%ebp),%eax
 4df:	85 c0                	test   %eax,%eax
 4e1:	74 07                	je     4ea <printint+0x6a>
    buf[i++] = '-';
 4e3:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 4e8:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 4ea:	8d 74 3d d8          	lea    -0x28(%ebp,%edi,1),%esi
 4ee:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 4f1:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 4f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4ff:	00 
    putc(fd, buf[i]);
 500:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 503:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 506:	83 ee 01             	sub    $0x1,%esi
 509:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 50c:	8d 45 d7             	lea    -0x29(%ebp),%eax
 50f:	6a 01                	push   $0x1
 511:	50                   	push   %eax
 512:	57                   	push   %edi
 513:	e8 bf fe ff ff       	call   3d7 <write>
  while(--i >= 0)
 518:	83 c4 10             	add    $0x10,%esp
 51b:	39 f3                	cmp    %esi,%ebx
 51d:	75 e1                	jne    500 <printint+0x80>
}
 51f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 522:	5b                   	pop    %ebx
 523:	5e                   	pop    %esi
 524:	5f                   	pop    %edi
 525:	5d                   	pop    %ebp
 526:	c3                   	ret
 527:	90                   	nop
 528:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 52f:	00 
  neg = 0;
 530:	31 c0                	xor    %eax,%eax
 532:	e9 70 ff ff ff       	jmp    4a7 <printint+0x27>
 537:	90                   	nop
 538:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 53f:	00 

00000540 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	83 ec 38             	sub    $0x38,%esp
 546:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 549:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 54c:	89 75 f8             	mov    %esi,-0x8(%ebp)
 54f:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 552:	0f b6 03             	movzbl (%ebx),%eax
 555:	84 c0                	test   %al,%al
 557:	0f 84 b6 00 00 00    	je     613 <printf+0xd3>
  ap = (uint*)(void*)&fmt + 1;
 55d:	8d 4d 10             	lea    0x10(%ebp),%ecx
 560:	89 7d fc             	mov    %edi,-0x4(%ebp)
 563:	83 c3 01             	add    $0x1,%ebx
 566:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 569:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 56c:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
 56f:	eb 2a                	jmp    59b <printf+0x5b>
 571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 578:	83 ec 04             	sub    $0x4,%esp
 57b:	88 45 e7             	mov    %al,-0x19(%ebp)
 57e:	8d 45 e7             	lea    -0x19(%ebp),%eax
  for(i = 0; fmt[i]; i++){
 581:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 584:	6a 01                	push   $0x1
 586:	50                   	push   %eax
 587:	56                   	push   %esi
 588:	e8 4a fe ff ff       	call   3d7 <write>
  for(i = 0; fmt[i]; i++){
 58d:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
 591:	83 c4 10             	add    $0x10,%esp
 594:	84 c0                	test   %al,%al
 596:	74 78                	je     610 <printf+0xd0>
    c = fmt[i] & 0xff;
 598:	0f b6 d0             	movzbl %al,%edx
      if(c == '%'){
 59b:	83 fa 25             	cmp    $0x25,%edx
 59e:	75 d8                	jne    578 <printf+0x38>
  for(i = 0; fmt[i]; i++){
 5a0:	0f b6 13             	movzbl (%ebx),%edx
 5a3:	84 d2                	test   %dl,%dl
 5a5:	74 69                	je     610 <printf+0xd0>
    c = fmt[i] & 0xff;
 5a7:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 5aa:	80 fa 25             	cmp    $0x25,%dl
 5ad:	0f 84 25 01 00 00    	je     6d8 <printf+0x198>
 5b3:	83 e8 63             	sub    $0x63,%eax
 5b6:	83 f8 15             	cmp    $0x15,%eax
 5b9:	77 0d                	ja     5c8 <printf+0x88>
 5bb:	ff 24 85 38 09 00 00 	jmp    *0x938(,%eax,4)
 5c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5c8:	83 ec 04             	sub    $0x4,%esp
 5cb:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 5ce:	88 55 d0             	mov    %dl,-0x30(%ebp)
 5d1:	6a 01                	push   $0x1
 5d3:	51                   	push   %ecx
 5d4:	56                   	push   %esi
 5d5:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 5d8:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5dc:	e8 f6 fd ff ff       	call   3d7 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5e1:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 5e5:	83 c4 0c             	add    $0xc,%esp
 5e8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 5eb:	6a 01                	push   $0x1
 5ed:	88 55 e7             	mov    %dl,-0x19(%ebp)
 5f0:	51                   	push   %ecx
  for(i = 0; fmt[i]; i++){
 5f1:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 5f4:	56                   	push   %esi
 5f5:	e8 dd fd ff ff       	call   3d7 <write>
  for(i = 0; fmt[i]; i++){
 5fa:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
 5fe:	83 c4 10             	add    $0x10,%esp
 601:	84 c0                	test   %al,%al
 603:	75 93                	jne    598 <printf+0x58>
 605:	8d 76 00             	lea    0x0(%esi),%esi
 608:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 60f:	00 
 610:	8b 7d fc             	mov    -0x4(%ebp),%edi
      }
      state = 0;
    }
  }
}
 613:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 616:	8b 75 f8             	mov    -0x8(%ebp),%esi
 619:	c9                   	leave
 61a:	c3                   	ret
 61b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 16, 0);
 620:	83 ec 0c             	sub    $0xc,%esp
 623:	8b 17                	mov    (%edi),%edx
 625:	b9 10 00 00 00       	mov    $0x10,%ecx
 62a:	89 f0                	mov    %esi,%eax
 62c:	6a 00                	push   $0x0
 62e:	e8 4d fe ff ff       	call   480 <printint>
  for(i = 0; fmt[i]; i++){
 633:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 637:	83 c3 02             	add    $0x2,%ebx
 63a:	83 c4 10             	add    $0x10,%esp
 63d:	84 c0                	test   %al,%al
 63f:	74 cf                	je     610 <printf+0xd0>
        ap++;
 641:	83 c7 04             	add    $0x4,%edi
 644:	e9 4f ff ff ff       	jmp    598 <printf+0x58>
 649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 650:	83 ec 0c             	sub    $0xc,%esp
 653:	8b 17                	mov    (%edi),%edx
 655:	b9 0a 00 00 00       	mov    $0xa,%ecx
 65a:	89 f0                	mov    %esi,%eax
 65c:	6a 01                	push   $0x1
 65e:	e8 1d fe ff ff       	call   480 <printint>
  for(i = 0; fmt[i]; i++){
 663:	eb ce                	jmp    633 <printf+0xf3>
 665:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 668:	83 ec 04             	sub    $0x4,%esp
 66b:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        putc(fd, *ap);
 66e:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 670:	6a 01                	push   $0x1
 672:	51                   	push   %ecx
 673:	56                   	push   %esi
        putc(fd, *ap);
 674:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 677:	e8 5b fd ff ff       	call   3d7 <write>
 67c:	eb b5                	jmp    633 <printf+0xf3>
 67e:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
 680:	8b 07                	mov    (%edi),%eax
        ap++;
 682:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 685:	85 c0                	test   %eax,%eax
 687:	74 67                	je     6f0 <printf+0x1b0>
        while(*s != 0){
 689:	0f b6 10             	movzbl (%eax),%edx
 68c:	84 d2                	test   %dl,%dl
 68e:	74 6f                	je     6ff <printf+0x1bf>
 690:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 693:	89 c7                	mov    %eax,%edi
 695:	89 d0                	mov    %edx,%eax
 697:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 69a:	89 fb                	mov    %edi,%ebx
 69c:	8d 7d e7             	lea    -0x19(%ebp),%edi
 69f:	90                   	nop
  write(fd, &c, 1);
 6a0:	83 ec 04             	sub    $0x4,%esp
          s++;
 6a3:	83 c3 01             	add    $0x1,%ebx
 6a6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6a9:	6a 01                	push   $0x1
 6ab:	57                   	push   %edi
 6ac:	56                   	push   %esi
 6ad:	e8 25 fd ff ff       	call   3d7 <write>
        while(*s != 0){
 6b2:	0f b6 03             	movzbl (%ebx),%eax
 6b5:	83 c4 10             	add    $0x10,%esp
 6b8:	84 c0                	test   %al,%al
 6ba:	75 e4                	jne    6a0 <printf+0x160>
 6bc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 6bf:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 6c3:	83 c3 02             	add    $0x2,%ebx
 6c6:	84 c0                	test   %al,%al
 6c8:	0f 85 9b fe ff ff    	jne    569 <printf+0x29>
 6ce:	e9 3d ff ff ff       	jmp    610 <printf+0xd0>
 6d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 6d8:	83 ec 04             	sub    $0x4,%esp
 6db:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 6df:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 6e2:	6a 01                	push   $0x1
 6e4:	e9 07 ff ff ff       	jmp    5f0 <printf+0xb0>
 6e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 6f0:	89 7d d4             	mov    %edi,-0x2c(%ebp)
        if(s == 0)
 6f3:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 6f8:	bf 2e 09 00 00       	mov    $0x92e,%edi
 6fd:	eb 98                	jmp    697 <printf+0x157>
  for(i = 0; fmt[i]; i++){
 6ff:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 703:	83 c3 02             	add    $0x2,%ebx
 706:	84 c0                	test   %al,%al
 708:	0f 85 8a fe ff ff    	jne    598 <printf+0x58>
 70e:	e9 fd fe ff ff       	jmp    610 <printf+0xd0>
 713:	66 90                	xchg   %ax,%ax
 715:	66 90                	xchg   %ax,%ax
 717:	66 90                	xchg   %ax,%ax
 719:	66 90                	xchg   %ax,%ax
 71b:	66 90                	xchg   %ax,%ax
 71d:	66 90                	xchg   %ax,%ax
 71f:	90                   	nop

00000720 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 720:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 721:	a1 a4 09 00 00       	mov    0x9a4,%eax
{
 726:	89 e5                	mov    %esp,%ebp
 728:	57                   	push   %edi
 729:	56                   	push   %esi
 72a:	53                   	push   %ebx
 72b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 72e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 731:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 738:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 73f:	00 
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 740:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 742:	39 c8                	cmp    %ecx,%eax
 744:	73 32                	jae    778 <free+0x58>
 746:	39 d1                	cmp    %edx,%ecx
 748:	72 04                	jb     74e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 74a:	39 d0                	cmp    %edx,%eax
 74c:	72 32                	jb     780 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 74e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 751:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 754:	39 fa                	cmp    %edi,%edx
 756:	74 30                	je     788 <free+0x68>
 758:	89 53 f8             	mov    %edx,-0x8(%ebx)
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 75b:	8b 50 04             	mov    0x4(%eax),%edx
 75e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 761:	39 f1                	cmp    %esi,%ecx
 763:	74 3a                	je     79f <free+0x7f>
 765:	89 08                	mov    %ecx,(%eax)
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 767:	5b                   	pop    %ebx
  freep = p;
 768:	a3 a4 09 00 00       	mov    %eax,0x9a4
}
 76d:	5e                   	pop    %esi
 76e:	5f                   	pop    %edi
 76f:	5d                   	pop    %ebp
 770:	c3                   	ret
 771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 778:	39 d0                	cmp    %edx,%eax
 77a:	72 04                	jb     780 <free+0x60>
 77c:	39 d1                	cmp    %edx,%ecx
 77e:	72 ce                	jb     74e <free+0x2e>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 780:	89 d0                	mov    %edx,%eax
 782:	eb bc                	jmp    740 <free+0x20>
 784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 788:	03 72 04             	add    0x4(%edx),%esi
 78b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 78e:	8b 10                	mov    (%eax),%edx
 790:	8b 12                	mov    (%edx),%edx
 792:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 795:	8b 50 04             	mov    0x4(%eax),%edx
 798:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 79b:	39 f1                	cmp    %esi,%ecx
 79d:	75 c6                	jne    765 <free+0x45>
    p->s.size += bp->s.size;
 79f:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 7a2:	a3 a4 09 00 00       	mov    %eax,0x9a4
    p->s.size += bp->s.size;
 7a7:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7aa:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 7ad:	89 08                	mov    %ecx,(%eax)
}
 7af:	5b                   	pop    %ebx
 7b0:	5e                   	pop    %esi
 7b1:	5f                   	pop    %edi
 7b2:	5d                   	pop    %ebp
 7b3:	c3                   	ret
 7b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7bf:	00 

000007c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c6:	8b 45 08             	mov    0x8(%ebp),%eax
{
 7c9:	89 7d fc             	mov    %edi,-0x4(%ebp)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7cc:	8d 78 07             	lea    0x7(%eax),%edi
  if((prevp = freep) == 0){
 7cf:	a1 a4 09 00 00       	mov    0x9a4,%eax
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d4:	c1 ef 03             	shr    $0x3,%edi
 7d7:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 7da:	85 c0                	test   %eax,%eax
 7dc:	0f 84 c6 00 00 00    	je     8a8 <malloc+0xe8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e2:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 7e4:	8b 4a 04             	mov    0x4(%edx),%ecx
 7e7:	39 f9                	cmp    %edi,%ecx
 7e9:	0f 83 87 00 00 00    	jae    876 <malloc+0xb6>
 7ef:	89 5d f4             	mov    %ebx,-0xc(%ebp)
 7f2:	89 75 f8             	mov    %esi,-0x8(%ebp)
  if(nu < 4096)
 7f5:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7fa:	39 df                	cmp    %ebx,%edi
 7fc:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7ff:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 806:	eb 21                	jmp    829 <malloc+0x69>
 808:	eb 16                	jmp    820 <malloc+0x60>
 80a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 810:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 817:	00 
 818:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 81f:	00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 820:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 822:	8b 4a 04             	mov    0x4(%edx),%ecx
 825:	39 f9                	cmp    %edi,%ecx
 827:	73 47                	jae    870 <malloc+0xb0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 829:	89 d0                	mov    %edx,%eax
 82b:	39 15 a4 09 00 00    	cmp    %edx,0x9a4
 831:	75 ed                	jne    820 <malloc+0x60>
  p = sbrk(nu * sizeof(Header));
 833:	83 ec 0c             	sub    $0xc,%esp
 836:	56                   	push   %esi
 837:	e8 03 fc ff ff       	call   43f <sbrk>
  if(p == (char*)-1)
 83c:	83 c4 10             	add    $0x10,%esp
 83f:	83 f8 ff             	cmp    $0xffffffff,%eax
 842:	74 54                	je     898 <malloc+0xd8>
  hp->s.size = nu;
 844:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 847:	83 ec 0c             	sub    $0xc,%esp
 84a:	83 c0 08             	add    $0x8,%eax
 84d:	50                   	push   %eax
 84e:	e8 cd fe ff ff       	call   720 <free>
  return freep;
 853:	a1 a4 09 00 00       	mov    0x9a4,%eax
      if((p = morecore(nunits)) == 0)
 858:	83 c4 10             	add    $0x10,%esp
 85b:	85 c0                	test   %eax,%eax
 85d:	75 c1                	jne    820 <malloc+0x60>
 85f:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 862:	8b 75 f8             	mov    -0x8(%ebp),%esi
 865:	eb 26                	jmp    88d <malloc+0xcd>
 867:	90                   	nop
 868:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 86f:	00 
 870:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 873:	8b 75 f8             	mov    -0x8(%ebp),%esi
      if(p->s.size == nunits)
 876:	39 cf                	cmp    %ecx,%edi
 878:	74 66                	je     8e0 <malloc+0x120>
        p->s.size -= nunits;
 87a:	29 f9                	sub    %edi,%ecx
 87c:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 87f:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 882:	89 7a 04             	mov    %edi,0x4(%edx)
      freep = prevp;
 885:	a3 a4 09 00 00       	mov    %eax,0x9a4
      return (void*)(p + 1);
 88a:	8d 42 08             	lea    0x8(%edx),%eax
        return 0;
  }
}
 88d:	8b 7d fc             	mov    -0x4(%ebp),%edi
 890:	c9                   	leave
 891:	c3                   	ret
 892:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return 0;
 898:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 89b:	8b 75 f8             	mov    -0x8(%ebp),%esi
 89e:	31 c0                	xor    %eax,%eax
}
 8a0:	8b 7d fc             	mov    -0x4(%ebp),%edi
 8a3:	c9                   	leave
 8a4:	c3                   	ret
 8a5:	8d 76 00             	lea    0x0(%esi),%esi
 8a8:	89 5d f4             	mov    %ebx,-0xc(%ebp)
    base.s.size = 0;
 8ab:	ba a8 09 00 00       	mov    $0x9a8,%edx
 8b0:	89 75 f8             	mov    %esi,-0x8(%ebp)
    base.s.ptr = freep = prevp = &base;
 8b3:	c7 05 a4 09 00 00 a8 	movl   $0x9a8,0x9a4
 8ba:	09 00 00 
 8bd:	c7 05 a8 09 00 00 a8 	movl   $0x9a8,0x9a8
 8c4:	09 00 00 
    base.s.size = 0;
 8c7:	c7 05 ac 09 00 00 00 	movl   $0x0,0x9ac
 8ce:	00 00 00 
    if(p->s.size >= nunits){
 8d1:	e9 1f ff ff ff       	jmp    7f5 <malloc+0x35>
 8d6:	66 90                	xchg   %ax,%ax
 8d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8df:	00 
        prevp->s.ptr = p->s.ptr;
 8e0:	8b 0a                	mov    (%edx),%ecx
 8e2:	89 08                	mov    %ecx,(%eax)
 8e4:	eb 9f                	jmp    885 <malloc+0xc5>
