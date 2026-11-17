
user/_memtest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

int g = 42;   // global variable whose address we translate

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	83 ec 20             	sub    $0x20,%esp
  int before, after_fork, after_wait, pid, p[2];
  char c;

  // (i) free pages at start-up
  printf(1, "(i)   freepages() at start-up        : %d\n", freepages());
  12:	e8 e0 04 00 00       	call   4f7 <freepages>
  17:	83 ec 04             	sub    $0x4,%esp
  1a:	50                   	push   %eax
  1b:	68 88 09 00 00       	push   $0x988
  20:	6a 01                	push   $0x1
  22:	e8 b9 05 00 00       	call   5e0 <printf>

  // (ii) after growing the heap by 10 pages
  if(sbrk(10 * 4096) == (char*)-1){
  27:	c7 04 24 00 a0 00 00 	movl   $0xa000,(%esp)
  2e:	e8 ac 04 00 00       	call   4df <sbrk>
  33:	83 c4 10             	add    $0x10,%esp
  36:	83 f8 ff             	cmp    $0xffffffff,%eax
  39:	0f 84 41 01 00 00    	je     180 <main+0x180>
    printf(1, "sbrk failed\n");
    exit();
  }
  printf(1, "(ii)  freepages() after sbrk(10*4096): %d\n", freepages());
  3f:	e8 b3 04 00 00       	call   4f7 <freepages>
  44:	83 ec 04             	sub    $0x4,%esp
  47:	50                   	push   %eax
  48:	68 b4 09 00 00       	push   $0x9b4
  4d:	6a 01                	push   $0x1
  4f:	e8 8c 05 00 00       	call   5e0 <printf>

  // (iii) virtual and physical address of a global variable
  printf(1, "(iii) &g: va = 0x%x  pa = 0x%x\n", (int)&g, va2pa((int)&g));
  54:	c7 04 24 c8 0b 00 00 	movl   $0xbc8,(%esp)
  5b:	e8 9f 04 00 00       	call   4ff <va2pa>
  60:	50                   	push   %eax
  61:	68 c8 0b 00 00       	push   $0xbc8
  66:	68 e0 09 00 00       	push   $0x9e0
  6b:	6a 01                	push   $0x1
  6d:	e8 6e 05 00 00       	call   5e0 <printf>

  // (iv) an address that is not mapped
  printf(1, "(iv)  va2pa(0x7FFFFFFF) = %d\n", va2pa(0x7FFFFFFF));
  72:	83 c4 14             	add    $0x14,%esp
  75:	68 ff ff ff 7f       	push   $0x7fffffff
  7a:	e8 80 04 00 00       	call   4ff <va2pa>
  7f:	83 c4 0c             	add    $0xc,%esp
  82:	50                   	push   %eax
  83:	68 fe 0a 00 00       	push   $0xafe
  88:	6a 01                	push   $0x1
  8a:	e8 51 05 00 00       	call   5e0 <printf>

  // (v) fork: the pipe only orders the output, it is created before the
  // "before" snapshot so it does not disturb the page counts.
  if(pipe(p) < 0){
  8f:	8d 45 f0             	lea    -0x10(%ebp),%eax
  92:	89 04 24             	mov    %eax,(%esp)
  95:	e8 cd 03 00 00       	call   467 <pipe>
  9a:	83 c4 10             	add    $0x10,%esp
  9d:	85 c0                	test   %eax,%eax
  9f:	0f 88 c8 00 00 00    	js     16d <main+0x16d>
    printf(1, "pipe failed\n");
    exit();
  }
  before = freepages();
  a5:	e8 4d 04 00 00       	call   4f7 <freepages>
  aa:	89 c3                	mov    %eax,%ebx
  printf(1, "(v)   freepages() before fork        : %d\n", before);
  ac:	50                   	push   %eax
  ad:	53                   	push   %ebx
  ae:	68 00 0a 00 00       	push   $0xa00
  b3:	6a 01                	push   $0x1
  b5:	e8 26 05 00 00       	call   5e0 <printf>

  pid = fork();
  ba:	e8 90 03 00 00       	call   44f <fork>
  if(pid < 0){
  bf:	83 c4 10             	add    $0x10,%esp
  c2:	85 c0                	test   %eax,%eax
  c4:	0f 88 ff 00 00 00    	js     1c9 <main+0x1c9>
    printf(1, "fork failed\n");
    exit();
  }
  if(pid == 0){
  ca:	0f 84 c3 00 00 00    	je     193 <main+0x193>
    // child: same virtual address, different physical page (pages are copied)
    printf(1, "      child : va = 0x%x  pa = 0x%x\n", (int)&g, va2pa((int)&g));
    write(p[1], "x", 1);   // tell the parent we have printed
    exit();
  }
  read(p[0], &c, 1);       // child has printed and is now exiting (zombie)
  d0:	8d 45 ef             	lea    -0x11(%ebp),%eax
  d3:	52                   	push   %edx
  d4:	6a 01                	push   $0x1
  d6:	50                   	push   %eax
  d7:	ff 75 f0             	push   -0x10(%ebp)
  da:	e8 90 03 00 00       	call   46f <read>
  after_fork = freepages();
  df:	e8 13 04 00 00       	call   4f7 <freepages>
  printf(1, "      parent: va = 0x%x  pa = 0x%x\n", (int)&g, va2pa((int)&g));
  e4:	c7 04 24 c8 0b 00 00 	movl   $0xbc8,(%esp)
  after_fork = freepages();
  eb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  printf(1, "      parent: va = 0x%x  pa = 0x%x\n", (int)&g, va2pa((int)&g));
  ee:	e8 0c 04 00 00       	call   4ff <va2pa>
  f3:	50                   	push   %eax
  f4:	68 c8 0b 00 00       	push   $0xbc8
  f9:	68 50 0a 00 00       	push   $0xa50
  fe:	6a 01                	push   $0x1
 100:	e8 db 04 00 00       	call   5e0 <printf>
  printf(1, "      freepages() after fork         : %d\n", after_fork);
 105:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 108:	83 c4 1c             	add    $0x1c,%esp
 10b:	52                   	push   %edx
 10c:	68 74 0a 00 00       	push   $0xa74
 111:	6a 01                	push   $0x1
 113:	e8 c8 04 00 00       	call   5e0 <printf>

  wait();
 118:	e8 42 03 00 00       	call   45f <wait>
  after_wait = freepages();
 11d:	e8 d5 03 00 00       	call   4f7 <freepages>
  printf(1, "      freepages() after child reaped : %d\n", after_wait);
 122:	83 c4 0c             	add    $0xc,%esp
 125:	50                   	push   %eax
 126:	68 a0 0a 00 00       	push   $0xaa0
 12b:	6a 01                	push   $0x1
 12d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 130:	e8 ab 04 00 00       	call   5e0 <printf>

  if(after_wait == before)
 135:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 138:	83 c4 10             	add    $0x10,%esp
 13b:	39 c3                	cmp    %eax,%ebx
 13d:	0f 84 99 00 00 00    	je     1dc <main+0x1dc>
    printf(1, "No memory leak: %d == %d\n", after_wait, before);
  else
    printf(1, "LEAK: before fork %d, after wait %d\n", before, after_wait);
 143:	50                   	push   %eax
 144:	53                   	push   %ebx
 145:	68 cc 0a 00 00       	push   $0xacc
 14a:	6a 01                	push   $0x1
 14c:	e8 8f 04 00 00       	call   5e0 <printf>
 151:	83 c4 10             	add    $0x10,%esp

  close(p[0]);
 154:	83 ec 0c             	sub    $0xc,%esp
 157:	ff 75 f0             	push   -0x10(%ebp)
 15a:	e8 20 03 00 00       	call   47f <close>
  close(p[1]);
 15f:	58                   	pop    %eax
 160:	ff 75 f4             	push   -0xc(%ebp)
 163:	e8 17 03 00 00       	call   47f <close>
  exit();
 168:	e8 ea 02 00 00       	call   457 <exit>
    printf(1, "pipe failed\n");
 16d:	50                   	push   %eax
 16e:	50                   	push   %eax
 16f:	68 1c 0b 00 00       	push   $0xb1c
 174:	6a 01                	push   $0x1
 176:	e8 65 04 00 00       	call   5e0 <printf>
    exit();
 17b:	e8 d7 02 00 00       	call   457 <exit>
    printf(1, "sbrk failed\n");
 180:	50                   	push   %eax
 181:	50                   	push   %eax
 182:	68 f1 0a 00 00       	push   $0xaf1
 187:	6a 01                	push   $0x1
 189:	e8 52 04 00 00       	call   5e0 <printf>
    exit();
 18e:	e8 c4 02 00 00       	call   457 <exit>
    printf(1, "      child : va = 0x%x  pa = 0x%x\n", (int)&g, va2pa((int)&g));
 193:	83 ec 0c             	sub    $0xc,%esp
 196:	68 c8 0b 00 00       	push   $0xbc8
 19b:	e8 5f 03 00 00       	call   4ff <va2pa>
 1a0:	50                   	push   %eax
 1a1:	68 c8 0b 00 00       	push   $0xbc8
 1a6:	68 2c 0a 00 00       	push   $0xa2c
 1ab:	6a 01                	push   $0x1
 1ad:	e8 2e 04 00 00       	call   5e0 <printf>
    write(p[1], "x", 1);   // tell the parent we have printed
 1b2:	83 c4 1c             	add    $0x1c,%esp
 1b5:	6a 01                	push   $0x1
 1b7:	68 36 0b 00 00       	push   $0xb36
 1bc:	ff 75 f4             	push   -0xc(%ebp)
 1bf:	e8 b3 02 00 00       	call   477 <write>
    exit();
 1c4:	e8 8e 02 00 00       	call   457 <exit>
    printf(1, "fork failed\n");
 1c9:	51                   	push   %ecx
 1ca:	51                   	push   %ecx
 1cb:	68 29 0b 00 00       	push   $0xb29
 1d0:	6a 01                	push   $0x1
 1d2:	e8 09 04 00 00       	call   5e0 <printf>
    exit();
 1d7:	e8 7b 02 00 00       	call   457 <exit>
    printf(1, "No memory leak: %d == %d\n", after_wait, before);
 1dc:	53                   	push   %ebx
 1dd:	53                   	push   %ebx
 1de:	68 38 0b 00 00       	push   $0xb38
 1e3:	6a 01                	push   $0x1
 1e5:	e8 f6 03 00 00       	call   5e0 <printf>
 1ea:	83 c4 10             	add    $0x10,%esp
 1ed:	e9 62 ff ff ff       	jmp    154 <main+0x154>
 1f2:	66 90                	xchg   %ax,%ax
 1f4:	66 90                	xchg   %ax,%ax
 1f6:	66 90                	xchg   %ax,%ax
 1f8:	66 90                	xchg   %ax,%ax
 1fa:	66 90                	xchg   %ax,%ax
 1fc:	66 90                	xchg   %ax,%ax
 1fe:	66 90                	xchg   %ax,%ax

00000200 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 200:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 201:	31 c0                	xor    %eax,%eax
{
 203:	89 e5                	mov    %esp,%ebp
 205:	53                   	push   %ebx
 206:	8b 4d 08             	mov    0x8(%ebp),%ecx
 209:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 210:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 214:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 217:	83 c0 01             	add    $0x1,%eax
 21a:	84 d2                	test   %dl,%dl
 21c:	75 f2                	jne    210 <strcpy+0x10>
    ;
  return os;
}
 21e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 221:	89 c8                	mov    %ecx,%eax
 223:	c9                   	leave
 224:	c3                   	ret
 225:	8d 76 00             	lea    0x0(%esi),%esi
 228:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 22f:	00 

00000230 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	53                   	push   %ebx
 234:	8b 55 08             	mov    0x8(%ebp),%edx
 237:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 23a:	0f b6 02             	movzbl (%edx),%eax
 23d:	84 c0                	test   %al,%al
 23f:	75 2d                	jne    26e <strcmp+0x3e>
 241:	eb 3d                	jmp    280 <strcmp+0x50>
 243:	eb 1b                	jmp    260 <strcmp+0x30>
 245:	8d 76 00             	lea    0x0(%esi),%esi
 248:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 24f:	00 
 250:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 257:	00 
 258:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 25f:	00 
 260:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 264:	83 c2 01             	add    $0x1,%edx
 267:	83 c1 01             	add    $0x1,%ecx
  while(*p && *p == *q)
 26a:	84 c0                	test   %al,%al
 26c:	74 12                	je     280 <strcmp+0x50>
 26e:	0f b6 19             	movzbl (%ecx),%ebx
 271:	38 c3                	cmp    %al,%bl
 273:	74 eb                	je     260 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 275:	29 d8                	sub    %ebx,%eax
}
 277:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 27a:	c9                   	leave
 27b:	c3                   	ret
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return (uchar)*p - (uchar)*q;
 280:	0f b6 19             	movzbl (%ecx),%ebx
 283:	31 c0                	xor    %eax,%eax
 285:	29 d8                	sub    %ebx,%eax
}
 287:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 28a:	c9                   	leave
 28b:	c3                   	ret
 28c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000290 <strlen>:

uint
strlen(const char *s)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 296:	80 3a 00             	cmpb   $0x0,(%edx)
 299:	74 15                	je     2b0 <strlen+0x20>
 29b:	31 c0                	xor    %eax,%eax
 29d:	8d 76 00             	lea    0x0(%esi),%esi
 2a0:	83 c0 01             	add    $0x1,%eax
 2a3:	89 c1                	mov    %eax,%ecx
 2a5:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 2a9:	75 f5                	jne    2a0 <strlen+0x10>
    ;
  return n;
}
 2ab:	89 c8                	mov    %ecx,%eax
 2ad:	5d                   	pop    %ebp
 2ae:	c3                   	ret
 2af:	90                   	nop
  for(n = 0; s[n]; n++)
 2b0:	31 c9                	xor    %ecx,%ecx
}
 2b2:	5d                   	pop    %ebp
 2b3:	89 c8                	mov    %ecx,%eax
 2b5:	c3                   	ret
 2b6:	66 90                	xchg   %ax,%ax
 2b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2bf:	00 

000002c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2c4:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2c7:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ca:	8b 7d 08             	mov    0x8(%ebp),%edi
 2cd:	fc                   	cld
 2ce:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2d0:	8b 45 08             	mov    0x8(%ebp),%eax
 2d3:	8b 7d fc             	mov    -0x4(%ebp),%edi
 2d6:	c9                   	leave
 2d7:	c3                   	ret
 2d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2df:	00 

000002e0 <strchr>:

char*
strchr(const char *s, char c)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	8b 45 08             	mov    0x8(%ebp),%eax
 2e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 2ea:	0f b6 10             	movzbl (%eax),%edx
 2ed:	84 d2                	test   %dl,%dl
 2ef:	75 1a                	jne    30b <strchr+0x2b>
 2f1:	eb 25                	jmp    318 <strchr+0x38>
 2f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 2f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ff:	00 
 300:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 304:	83 c0 01             	add    $0x1,%eax
 307:	84 d2                	test   %dl,%dl
 309:	74 0d                	je     318 <strchr+0x38>
    if(*s == c)
 30b:	38 d1                	cmp    %dl,%cl
 30d:	75 f1                	jne    300 <strchr+0x20>
      return (char*)s;
  return 0;
}
 30f:	5d                   	pop    %ebp
 310:	c3                   	ret
 311:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 318:	31 c0                	xor    %eax,%eax
}
 31a:	5d                   	pop    %ebp
 31b:	c3                   	ret
 31c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000320 <gets>:

char*
gets(char *buf, int max)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 325:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 328:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 329:	31 db                	xor    %ebx,%ebx
{
 32b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 32e:	eb 27                	jmp    357 <gets+0x37>
    cc = read(0, &c, 1);
 330:	83 ec 04             	sub    $0x4,%esp
 333:	6a 01                	push   $0x1
 335:	57                   	push   %edi
 336:	6a 00                	push   $0x0
 338:	e8 32 01 00 00       	call   46f <read>
    if(cc < 1)
 33d:	83 c4 10             	add    $0x10,%esp
 340:	85 c0                	test   %eax,%eax
 342:	7e 1d                	jle    361 <gets+0x41>
      break;
    buf[i++] = c;
 344:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 348:	8b 55 08             	mov    0x8(%ebp),%edx
 34b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 34f:	3c 0a                	cmp    $0xa,%al
 351:	74 1d                	je     370 <gets+0x50>
 353:	3c 0d                	cmp    $0xd,%al
 355:	74 19                	je     370 <gets+0x50>
  for(i=0; i+1 < max; ){
 357:	89 de                	mov    %ebx,%esi
 359:	83 c3 01             	add    $0x1,%ebx
 35c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 35f:	7c cf                	jl     330 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 361:	8b 45 08             	mov    0x8(%ebp),%eax
 364:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 368:	8d 65 f4             	lea    -0xc(%ebp),%esp
 36b:	5b                   	pop    %ebx
 36c:	5e                   	pop    %esi
 36d:	5f                   	pop    %edi
 36e:	5d                   	pop    %ebp
 36f:	c3                   	ret
  buf[i] = '\0';
 370:	8b 45 08             	mov    0x8(%ebp),%eax
    buf[i++] = c;
 373:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 375:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 379:	8d 65 f4             	lea    -0xc(%ebp),%esp
 37c:	5b                   	pop    %ebx
 37d:	5e                   	pop    %esi
 37e:	5f                   	pop    %edi
 37f:	5d                   	pop    %ebp
 380:	c3                   	ret
 381:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 388:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 38f:	00 

00000390 <stat>:

int
stat(const char *n, struct stat *st)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 396:	6a 00                	push   $0x0
 398:	ff 75 08             	push   0x8(%ebp)
{
 39b:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 39e:	e8 f4 00 00 00       	call   497 <open>
  if(fd < 0)
 3a3:	83 c4 10             	add    $0x10,%esp
 3a6:	85 c0                	test   %eax,%eax
 3a8:	78 2e                	js     3d8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 3aa:	83 ec 08             	sub    $0x8,%esp
 3ad:	ff 75 0c             	push   0xc(%ebp)
 3b0:	50                   	push   %eax
 3b1:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 3b4:	89 c3                	mov    %eax,%ebx
 3b6:	e8 f4 00 00 00       	call   4af <fstat>
  close(fd);
 3bb:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 3be:	89 c6                	mov    %eax,%esi
  close(fd);
 3c0:	e8 ba 00 00 00       	call   47f <close>
  return r;
 3c5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 3c8:	83 c4 10             	add    $0x10,%esp
}
 3cb:	89 f0                	mov    %esi,%eax
 3cd:	8b 75 fc             	mov    -0x4(%ebp),%esi
 3d0:	c9                   	leave
 3d1:	c3                   	ret
 3d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
 3d8:	be ff ff ff ff       	mov    $0xffffffff,%esi
 3dd:	eb ec                	jmp    3cb <stat+0x3b>
 3df:	90                   	nop

000003e0 <atoi>:

int
atoi(const char *s)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	53                   	push   %ebx
 3e4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3e7:	0f be 02             	movsbl (%edx),%eax
 3ea:	8d 48 d0             	lea    -0x30(%eax),%ecx
 3ed:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 3f0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 3f5:	77 1e                	ja     415 <atoi+0x35>
 3f7:	90                   	nop
 3f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3ff:	00 
    n = n*10 + *s++ - '0';
 400:	83 c2 01             	add    $0x1,%edx
 403:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 406:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 40a:	0f be 02             	movsbl (%edx),%eax
 40d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 410:	80 fb 09             	cmp    $0x9,%bl
 413:	76 eb                	jbe    400 <atoi+0x20>
  return n;
}
 415:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 418:	89 c8                	mov    %ecx,%eax
 41a:	c9                   	leave
 41b:	c3                   	ret
 41c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000420 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	83 ec 08             	sub    $0x8,%esp
 426:	8b 45 10             	mov    0x10(%ebp),%eax
 429:	8b 55 08             	mov    0x8(%ebp),%edx
 42c:	89 75 f8             	mov    %esi,-0x8(%ebp)
 42f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 432:	85 c0                	test   %eax,%eax
 434:	7e 12                	jle    448 <memmove+0x28>
 436:	89 7d fc             	mov    %edi,-0x4(%ebp)
 439:	01 d0                	add    %edx,%eax
  dst = vdst;
 43b:	89 d7                	mov    %edx,%edi
 43d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 440:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 441:	39 f8                	cmp    %edi,%eax
 443:	75 fb                	jne    440 <memmove+0x20>
 445:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return vdst;
}
 448:	8b 75 f8             	mov    -0x8(%ebp),%esi
 44b:	89 d0                	mov    %edx,%eax
 44d:	c9                   	leave
 44e:	c3                   	ret

0000044f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 44f:	b8 01 00 00 00       	mov    $0x1,%eax
 454:	cd 40                	int    $0x40
 456:	c3                   	ret

00000457 <exit>:
SYSCALL(exit)
 457:	b8 02 00 00 00       	mov    $0x2,%eax
 45c:	cd 40                	int    $0x40
 45e:	c3                   	ret

0000045f <wait>:
SYSCALL(wait)
 45f:	b8 03 00 00 00       	mov    $0x3,%eax
 464:	cd 40                	int    $0x40
 466:	c3                   	ret

00000467 <pipe>:
SYSCALL(pipe)
 467:	b8 04 00 00 00       	mov    $0x4,%eax
 46c:	cd 40                	int    $0x40
 46e:	c3                   	ret

0000046f <read>:
SYSCALL(read)
 46f:	b8 05 00 00 00       	mov    $0x5,%eax
 474:	cd 40                	int    $0x40
 476:	c3                   	ret

00000477 <write>:
SYSCALL(write)
 477:	b8 10 00 00 00       	mov    $0x10,%eax
 47c:	cd 40                	int    $0x40
 47e:	c3                   	ret

0000047f <close>:
SYSCALL(close)
 47f:	b8 15 00 00 00       	mov    $0x15,%eax
 484:	cd 40                	int    $0x40
 486:	c3                   	ret

00000487 <kill>:
SYSCALL(kill)
 487:	b8 06 00 00 00       	mov    $0x6,%eax
 48c:	cd 40                	int    $0x40
 48e:	c3                   	ret

0000048f <exec>:
SYSCALL(exec)
 48f:	b8 07 00 00 00       	mov    $0x7,%eax
 494:	cd 40                	int    $0x40
 496:	c3                   	ret

00000497 <open>:
SYSCALL(open)
 497:	b8 0f 00 00 00       	mov    $0xf,%eax
 49c:	cd 40                	int    $0x40
 49e:	c3                   	ret

0000049f <mknod>:
SYSCALL(mknod)
 49f:	b8 11 00 00 00       	mov    $0x11,%eax
 4a4:	cd 40                	int    $0x40
 4a6:	c3                   	ret

000004a7 <unlink>:
SYSCALL(unlink)
 4a7:	b8 12 00 00 00       	mov    $0x12,%eax
 4ac:	cd 40                	int    $0x40
 4ae:	c3                   	ret

000004af <fstat>:
SYSCALL(fstat)
 4af:	b8 08 00 00 00       	mov    $0x8,%eax
 4b4:	cd 40                	int    $0x40
 4b6:	c3                   	ret

000004b7 <link>:
SYSCALL(link)
 4b7:	b8 13 00 00 00       	mov    $0x13,%eax
 4bc:	cd 40                	int    $0x40
 4be:	c3                   	ret

000004bf <mkdir>:
SYSCALL(mkdir)
 4bf:	b8 14 00 00 00       	mov    $0x14,%eax
 4c4:	cd 40                	int    $0x40
 4c6:	c3                   	ret

000004c7 <chdir>:
SYSCALL(chdir)
 4c7:	b8 09 00 00 00       	mov    $0x9,%eax
 4cc:	cd 40                	int    $0x40
 4ce:	c3                   	ret

000004cf <dup>:
SYSCALL(dup)
 4cf:	b8 0a 00 00 00       	mov    $0xa,%eax
 4d4:	cd 40                	int    $0x40
 4d6:	c3                   	ret

000004d7 <getpid>:
SYSCALL(getpid)
 4d7:	b8 0b 00 00 00       	mov    $0xb,%eax
 4dc:	cd 40                	int    $0x40
 4de:	c3                   	ret

000004df <sbrk>:
SYSCALL(sbrk)
 4df:	b8 0c 00 00 00       	mov    $0xc,%eax
 4e4:	cd 40                	int    $0x40
 4e6:	c3                   	ret

000004e7 <sleep>:
SYSCALL(sleep)
 4e7:	b8 0d 00 00 00       	mov    $0xd,%eax
 4ec:	cd 40                	int    $0x40
 4ee:	c3                   	ret

000004ef <uptime>:
SYSCALL(uptime)
 4ef:	b8 0e 00 00 00       	mov    $0xe,%eax
 4f4:	cd 40                	int    $0x40
 4f6:	c3                   	ret

000004f7 <freepages>:
SYSCALL(freepages)
 4f7:	b8 16 00 00 00       	mov    $0x16,%eax
 4fc:	cd 40                	int    $0x40
 4fe:	c3                   	ret

000004ff <va2pa>:
SYSCALL(va2pa)
 4ff:	b8 17 00 00 00       	mov    $0x17,%eax
 504:	cd 40                	int    $0x40
 506:	c3                   	ret
 507:	66 90                	xchg   %ax,%ax
 509:	66 90                	xchg   %ax,%ax
 50b:	66 90                	xchg   %ax,%ax
 50d:	66 90                	xchg   %ax,%ax
 50f:	66 90                	xchg   %ax,%ax
 511:	66 90                	xchg   %ax,%ax
 513:	66 90                	xchg   %ax,%ax
 515:	66 90                	xchg   %ax,%ax
 517:	66 90                	xchg   %ax,%ax
 519:	66 90                	xchg   %ax,%ax
 51b:	66 90                	xchg   %ax,%ax
 51d:	66 90                	xchg   %ax,%ax
 51f:	90                   	nop

00000520 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	53                   	push   %ebx
 526:	89 cb                	mov    %ecx,%ebx
 528:	83 ec 3c             	sub    $0x3c,%esp
 52b:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 52e:	85 d2                	test   %edx,%edx
 530:	0f 89 9a 00 00 00    	jns    5d0 <printint+0xb0>
 536:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 53a:	0f 84 90 00 00 00    	je     5d0 <printint+0xb0>
    neg = 1;
    x = -xx;
 540:	f7 da                	neg    %edx
    neg = 1;
 542:	b8 01 00 00 00       	mov    $0x1,%eax
 547:	89 45 c0             	mov    %eax,-0x40(%ebp)
 54a:	89 d1                	mov    %edx,%ecx
  } else {
    x = xx;
  }

  i = 0;
 54c:	31 f6                	xor    %esi,%esi
 54e:	66 90                	xchg   %ax,%ax
 550:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 557:	00 
 558:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 55f:	00 
  do{
    buf[i++] = digits[x % base];
 560:	89 c8                	mov    %ecx,%eax
 562:	31 d2                	xor    %edx,%edx
 564:	89 f7                	mov    %esi,%edi
 566:	f7 f3                	div    %ebx
 568:	8d 76 01             	lea    0x1(%esi),%esi
  }while((x /= base) != 0);
 56b:	39 d9                	cmp    %ebx,%ecx
    buf[i++] = digits[x % base];
 56d:	0f b6 92 b4 0b 00 00 	movzbl 0xbb4(%edx),%edx
  }while((x /= base) != 0);
 574:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
 576:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 57a:	73 e4                	jae    560 <printint+0x40>
  if(neg)
 57c:	8b 45 c0             	mov    -0x40(%ebp),%eax
 57f:	85 c0                	test   %eax,%eax
 581:	74 07                	je     58a <printint+0x6a>
    buf[i++] = '-';
 583:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 588:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 58a:	8d 74 3d d8          	lea    -0x28(%ebp,%edi,1),%esi
 58e:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 591:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 598:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 59f:	00 
    putc(fd, buf[i]);
 5a0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 5a3:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 5a6:	83 ee 01             	sub    $0x1,%esi
 5a9:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 5ac:	8d 45 d7             	lea    -0x29(%ebp),%eax
 5af:	6a 01                	push   $0x1
 5b1:	50                   	push   %eax
 5b2:	57                   	push   %edi
 5b3:	e8 bf fe ff ff       	call   477 <write>
  while(--i >= 0)
 5b8:	83 c4 10             	add    $0x10,%esp
 5bb:	39 f3                	cmp    %esi,%ebx
 5bd:	75 e1                	jne    5a0 <printint+0x80>
}
 5bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5c2:	5b                   	pop    %ebx
 5c3:	5e                   	pop    %esi
 5c4:	5f                   	pop    %edi
 5c5:	5d                   	pop    %ebp
 5c6:	c3                   	ret
 5c7:	90                   	nop
 5c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5cf:	00 
  neg = 0;
 5d0:	31 c0                	xor    %eax,%eax
 5d2:	e9 70 ff ff ff       	jmp    547 <printint+0x27>
 5d7:	90                   	nop
 5d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5df:	00 

000005e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	83 ec 38             	sub    $0x38,%esp
 5e6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5e9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 5ec:	89 75 f8             	mov    %esi,-0x8(%ebp)
 5ef:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 5f2:	0f b6 03             	movzbl (%ebx),%eax
 5f5:	84 c0                	test   %al,%al
 5f7:	0f 84 b6 00 00 00    	je     6b3 <printf+0xd3>
  ap = (uint*)(void*)&fmt + 1;
 5fd:	8d 4d 10             	lea    0x10(%ebp),%ecx
 600:	89 7d fc             	mov    %edi,-0x4(%ebp)
 603:	83 c3 01             	add    $0x1,%ebx
 606:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 609:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 60c:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
 60f:	eb 2a                	jmp    63b <printf+0x5b>
 611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 618:	83 ec 04             	sub    $0x4,%esp
 61b:	88 45 e7             	mov    %al,-0x19(%ebp)
 61e:	8d 45 e7             	lea    -0x19(%ebp),%eax
  for(i = 0; fmt[i]; i++){
 621:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 624:	6a 01                	push   $0x1
 626:	50                   	push   %eax
 627:	56                   	push   %esi
 628:	e8 4a fe ff ff       	call   477 <write>
  for(i = 0; fmt[i]; i++){
 62d:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
 631:	83 c4 10             	add    $0x10,%esp
 634:	84 c0                	test   %al,%al
 636:	74 78                	je     6b0 <printf+0xd0>
    c = fmt[i] & 0xff;
 638:	0f b6 d0             	movzbl %al,%edx
      if(c == '%'){
 63b:	83 fa 25             	cmp    $0x25,%edx
 63e:	75 d8                	jne    618 <printf+0x38>
  for(i = 0; fmt[i]; i++){
 640:	0f b6 13             	movzbl (%ebx),%edx
 643:	84 d2                	test   %dl,%dl
 645:	74 69                	je     6b0 <printf+0xd0>
    c = fmt[i] & 0xff;
 647:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 64a:	80 fa 25             	cmp    $0x25,%dl
 64d:	0f 84 25 01 00 00    	je     778 <printf+0x198>
 653:	83 e8 63             	sub    $0x63,%eax
 656:	83 f8 15             	cmp    $0x15,%eax
 659:	77 0d                	ja     668 <printf+0x88>
 65b:	ff 24 85 5c 0b 00 00 	jmp    *0xb5c(,%eax,4)
 662:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 668:	83 ec 04             	sub    $0x4,%esp
 66b:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 66e:	88 55 d0             	mov    %dl,-0x30(%ebp)
 671:	6a 01                	push   $0x1
 673:	51                   	push   %ecx
 674:	56                   	push   %esi
 675:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 678:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 67c:	e8 f6 fd ff ff       	call   477 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 681:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 685:	83 c4 0c             	add    $0xc,%esp
 688:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 68b:	6a 01                	push   $0x1
 68d:	88 55 e7             	mov    %dl,-0x19(%ebp)
 690:	51                   	push   %ecx
  for(i = 0; fmt[i]; i++){
 691:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 694:	56                   	push   %esi
 695:	e8 dd fd ff ff       	call   477 <write>
  for(i = 0; fmt[i]; i++){
 69a:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
 69e:	83 c4 10             	add    $0x10,%esp
 6a1:	84 c0                	test   %al,%al
 6a3:	75 93                	jne    638 <printf+0x58>
 6a5:	8d 76 00             	lea    0x0(%esi),%esi
 6a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6af:	00 
 6b0:	8b 7d fc             	mov    -0x4(%ebp),%edi
      }
      state = 0;
    }
  }
}
 6b3:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 6b6:	8b 75 f8             	mov    -0x8(%ebp),%esi
 6b9:	c9                   	leave
 6ba:	c3                   	ret
 6bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 16, 0);
 6c0:	83 ec 0c             	sub    $0xc,%esp
 6c3:	8b 17                	mov    (%edi),%edx
 6c5:	b9 10 00 00 00       	mov    $0x10,%ecx
 6ca:	89 f0                	mov    %esi,%eax
 6cc:	6a 00                	push   $0x0
 6ce:	e8 4d fe ff ff       	call   520 <printint>
  for(i = 0; fmt[i]; i++){
 6d3:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 6d7:	83 c3 02             	add    $0x2,%ebx
 6da:	83 c4 10             	add    $0x10,%esp
 6dd:	84 c0                	test   %al,%al
 6df:	74 cf                	je     6b0 <printf+0xd0>
        ap++;
 6e1:	83 c7 04             	add    $0x4,%edi
 6e4:	e9 4f ff ff ff       	jmp    638 <printf+0x58>
 6e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 6f0:	83 ec 0c             	sub    $0xc,%esp
 6f3:	8b 17                	mov    (%edi),%edx
 6f5:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6fa:	89 f0                	mov    %esi,%eax
 6fc:	6a 01                	push   $0x1
 6fe:	e8 1d fe ff ff       	call   520 <printint>
  for(i = 0; fmt[i]; i++){
 703:	eb ce                	jmp    6d3 <printf+0xf3>
 705:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 708:	83 ec 04             	sub    $0x4,%esp
 70b:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        putc(fd, *ap);
 70e:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 710:	6a 01                	push   $0x1
 712:	51                   	push   %ecx
 713:	56                   	push   %esi
        putc(fd, *ap);
 714:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 717:	e8 5b fd ff ff       	call   477 <write>
 71c:	eb b5                	jmp    6d3 <printf+0xf3>
 71e:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
 720:	8b 07                	mov    (%edi),%eax
        ap++;
 722:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 725:	85 c0                	test   %eax,%eax
 727:	74 67                	je     790 <printf+0x1b0>
        while(*s != 0){
 729:	0f b6 10             	movzbl (%eax),%edx
 72c:	84 d2                	test   %dl,%dl
 72e:	74 6f                	je     79f <printf+0x1bf>
 730:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 733:	89 c7                	mov    %eax,%edi
 735:	89 d0                	mov    %edx,%eax
 737:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 73a:	89 fb                	mov    %edi,%ebx
 73c:	8d 7d e7             	lea    -0x19(%ebp),%edi
 73f:	90                   	nop
  write(fd, &c, 1);
 740:	83 ec 04             	sub    $0x4,%esp
          s++;
 743:	83 c3 01             	add    $0x1,%ebx
 746:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 749:	6a 01                	push   $0x1
 74b:	57                   	push   %edi
 74c:	56                   	push   %esi
 74d:	e8 25 fd ff ff       	call   477 <write>
        while(*s != 0){
 752:	0f b6 03             	movzbl (%ebx),%eax
 755:	83 c4 10             	add    $0x10,%esp
 758:	84 c0                	test   %al,%al
 75a:	75 e4                	jne    740 <printf+0x160>
 75c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 75f:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 763:	83 c3 02             	add    $0x2,%ebx
 766:	84 c0                	test   %al,%al
 768:	0f 85 9b fe ff ff    	jne    609 <printf+0x29>
 76e:	e9 3d ff ff ff       	jmp    6b0 <printf+0xd0>
 773:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 778:	83 ec 04             	sub    $0x4,%esp
 77b:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 77f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 782:	6a 01                	push   $0x1
 784:	e9 07 ff ff ff       	jmp    690 <printf+0xb0>
 789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 790:	89 7d d4             	mov    %edi,-0x2c(%ebp)
        if(s == 0)
 793:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 798:	bf 52 0b 00 00       	mov    $0xb52,%edi
 79d:	eb 98                	jmp    737 <printf+0x157>
  for(i = 0; fmt[i]; i++){
 79f:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 7a3:	83 c3 02             	add    $0x2,%ebx
 7a6:	84 c0                	test   %al,%al
 7a8:	0f 85 8a fe ff ff    	jne    638 <printf+0x58>
 7ae:	e9 fd fe ff ff       	jmp    6b0 <printf+0xd0>
 7b3:	66 90                	xchg   %ax,%ax
 7b5:	66 90                	xchg   %ax,%ax
 7b7:	66 90                	xchg   %ax,%ax
 7b9:	66 90                	xchg   %ax,%ax
 7bb:	66 90                	xchg   %ax,%ax
 7bd:	66 90                	xchg   %ax,%ax
 7bf:	90                   	nop

000007c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c1:	a1 cc 0b 00 00       	mov    0xbcc,%eax
{
 7c6:	89 e5                	mov    %esp,%ebp
 7c8:	57                   	push   %edi
 7c9:	56                   	push   %esi
 7ca:	53                   	push   %ebx
 7cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 7ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7df:	00 
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7e0:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e2:	39 c8                	cmp    %ecx,%eax
 7e4:	73 32                	jae    818 <free+0x58>
 7e6:	39 d1                	cmp    %edx,%ecx
 7e8:	72 04                	jb     7ee <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ea:	39 d0                	cmp    %edx,%eax
 7ec:	72 32                	jb     820 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7ee:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7f1:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7f4:	39 fa                	cmp    %edi,%edx
 7f6:	74 30                	je     828 <free+0x68>
 7f8:	89 53 f8             	mov    %edx,-0x8(%ebx)
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7fb:	8b 50 04             	mov    0x4(%eax),%edx
 7fe:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 801:	39 f1                	cmp    %esi,%ecx
 803:	74 3a                	je     83f <free+0x7f>
 805:	89 08                	mov    %ecx,(%eax)
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 807:	5b                   	pop    %ebx
  freep = p;
 808:	a3 cc 0b 00 00       	mov    %eax,0xbcc
}
 80d:	5e                   	pop    %esi
 80e:	5f                   	pop    %edi
 80f:	5d                   	pop    %ebp
 810:	c3                   	ret
 811:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 818:	39 d0                	cmp    %edx,%eax
 81a:	72 04                	jb     820 <free+0x60>
 81c:	39 d1                	cmp    %edx,%ecx
 81e:	72 ce                	jb     7ee <free+0x2e>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 820:	89 d0                	mov    %edx,%eax
 822:	eb bc                	jmp    7e0 <free+0x20>
 824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 828:	03 72 04             	add    0x4(%edx),%esi
 82b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 82e:	8b 10                	mov    (%eax),%edx
 830:	8b 12                	mov    (%edx),%edx
 832:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 835:	8b 50 04             	mov    0x4(%eax),%edx
 838:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 83b:	39 f1                	cmp    %esi,%ecx
 83d:	75 c6                	jne    805 <free+0x45>
    p->s.size += bp->s.size;
 83f:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 842:	a3 cc 0b 00 00       	mov    %eax,0xbcc
    p->s.size += bp->s.size;
 847:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 84a:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 84d:	89 08                	mov    %ecx,(%eax)
}
 84f:	5b                   	pop    %ebx
 850:	5e                   	pop    %esi
 851:	5f                   	pop    %edi
 852:	5d                   	pop    %ebp
 853:	c3                   	ret
 854:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 858:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 85f:	00 

00000860 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 860:	55                   	push   %ebp
 861:	89 e5                	mov    %esp,%ebp
 863:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 866:	8b 45 08             	mov    0x8(%ebp),%eax
{
 869:	89 7d fc             	mov    %edi,-0x4(%ebp)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 86c:	8d 78 07             	lea    0x7(%eax),%edi
  if((prevp = freep) == 0){
 86f:	a1 cc 0b 00 00       	mov    0xbcc,%eax
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 874:	c1 ef 03             	shr    $0x3,%edi
 877:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 87a:	85 c0                	test   %eax,%eax
 87c:	0f 84 c6 00 00 00    	je     948 <malloc+0xe8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 882:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 884:	8b 4a 04             	mov    0x4(%edx),%ecx
 887:	39 f9                	cmp    %edi,%ecx
 889:	0f 83 87 00 00 00    	jae    916 <malloc+0xb6>
 88f:	89 5d f4             	mov    %ebx,-0xc(%ebp)
 892:	89 75 f8             	mov    %esi,-0x8(%ebp)
  if(nu < 4096)
 895:	bb 00 10 00 00       	mov    $0x1000,%ebx
 89a:	39 df                	cmp    %ebx,%edi
 89c:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 89f:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 8a6:	eb 21                	jmp    8c9 <malloc+0x69>
 8a8:	eb 16                	jmp    8c0 <malloc+0x60>
 8aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 8b0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8b7:	00 
 8b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8bf:	00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 8c2:	8b 4a 04             	mov    0x4(%edx),%ecx
 8c5:	39 f9                	cmp    %edi,%ecx
 8c7:	73 47                	jae    910 <malloc+0xb0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8c9:	89 d0                	mov    %edx,%eax
 8cb:	39 15 cc 0b 00 00    	cmp    %edx,0xbcc
 8d1:	75 ed                	jne    8c0 <malloc+0x60>
  p = sbrk(nu * sizeof(Header));
 8d3:	83 ec 0c             	sub    $0xc,%esp
 8d6:	56                   	push   %esi
 8d7:	e8 03 fc ff ff       	call   4df <sbrk>
  if(p == (char*)-1)
 8dc:	83 c4 10             	add    $0x10,%esp
 8df:	83 f8 ff             	cmp    $0xffffffff,%eax
 8e2:	74 54                	je     938 <malloc+0xd8>
  hp->s.size = nu;
 8e4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 8e7:	83 ec 0c             	sub    $0xc,%esp
 8ea:	83 c0 08             	add    $0x8,%eax
 8ed:	50                   	push   %eax
 8ee:	e8 cd fe ff ff       	call   7c0 <free>
  return freep;
 8f3:	a1 cc 0b 00 00       	mov    0xbcc,%eax
      if((p = morecore(nunits)) == 0)
 8f8:	83 c4 10             	add    $0x10,%esp
 8fb:	85 c0                	test   %eax,%eax
 8fd:	75 c1                	jne    8c0 <malloc+0x60>
 8ff:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 902:	8b 75 f8             	mov    -0x8(%ebp),%esi
 905:	eb 26                	jmp    92d <malloc+0xcd>
 907:	90                   	nop
 908:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 90f:	00 
 910:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 913:	8b 75 f8             	mov    -0x8(%ebp),%esi
      if(p->s.size == nunits)
 916:	39 cf                	cmp    %ecx,%edi
 918:	74 66                	je     980 <malloc+0x120>
        p->s.size -= nunits;
 91a:	29 f9                	sub    %edi,%ecx
 91c:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 91f:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 922:	89 7a 04             	mov    %edi,0x4(%edx)
      freep = prevp;
 925:	a3 cc 0b 00 00       	mov    %eax,0xbcc
      return (void*)(p + 1);
 92a:	8d 42 08             	lea    0x8(%edx),%eax
        return 0;
  }
}
 92d:	8b 7d fc             	mov    -0x4(%ebp),%edi
 930:	c9                   	leave
 931:	c3                   	ret
 932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return 0;
 938:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 93b:	8b 75 f8             	mov    -0x8(%ebp),%esi
 93e:	31 c0                	xor    %eax,%eax
}
 940:	8b 7d fc             	mov    -0x4(%ebp),%edi
 943:	c9                   	leave
 944:	c3                   	ret
 945:	8d 76 00             	lea    0x0(%esi),%esi
 948:	89 5d f4             	mov    %ebx,-0xc(%ebp)
    base.s.size = 0;
 94b:	ba d0 0b 00 00       	mov    $0xbd0,%edx
 950:	89 75 f8             	mov    %esi,-0x8(%ebp)
    base.s.ptr = freep = prevp = &base;
 953:	c7 05 cc 0b 00 00 d0 	movl   $0xbd0,0xbcc
 95a:	0b 00 00 
 95d:	c7 05 d0 0b 00 00 d0 	movl   $0xbd0,0xbd0
 964:	0b 00 00 
    base.s.size = 0;
 967:	c7 05 d4 0b 00 00 00 	movl   $0x0,0xbd4
 96e:	00 00 00 
    if(p->s.size >= nunits){
 971:	e9 1f ff ff ff       	jmp    895 <malloc+0x35>
 976:	66 90                	xchg   %ax,%ax
 978:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 97f:	00 
        prevp->s.ptr = p->s.ptr;
 980:	8b 0a                	mov    (%edx),%ecx
 982:	89 08                	mov    %ecx,(%eax)
 984:	eb 9f                	jmp    925 <malloc+0xc5>
