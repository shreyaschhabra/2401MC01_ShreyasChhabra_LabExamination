
user/_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
  11:	e8 79 02 00 00       	call   28f <fork>
  16:	85 c0                	test   %eax,%eax
  18:	7e 0d                	jle    27 <main+0x27>
    sleep(5);  // Let child exit before parent.
  1a:	83 ec 0c             	sub    $0xc,%esp
  1d:	6a 05                	push   $0x5
  1f:	e8 03 03 00 00       	call   327 <sleep>
  24:	83 c4 10             	add    $0x10,%esp
  exit();
  27:	e8 6b 02 00 00       	call   297 <exit>
  2c:	66 90                	xchg   %ax,%ax
  2e:	66 90                	xchg   %ax,%ax
  30:	66 90                	xchg   %ax,%ax
  32:	66 90                	xchg   %ax,%ax
  34:	66 90                	xchg   %ax,%ax
  36:	66 90                	xchg   %ax,%ax
  38:	66 90                	xchg   %ax,%ax
  3a:	66 90                	xchg   %ax,%ax
  3c:	66 90                	xchg   %ax,%ax
  3e:	66 90                	xchg   %ax,%ax

00000040 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  40:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  41:	31 c0                	xor    %eax,%eax
{
  43:	89 e5                	mov    %esp,%ebp
  45:	53                   	push   %ebx
  46:	8b 4d 08             	mov    0x8(%ebp),%ecx
  49:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  50:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  54:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  57:	83 c0 01             	add    $0x1,%eax
  5a:	84 d2                	test   %dl,%dl
  5c:	75 f2                	jne    50 <strcpy+0x10>
    ;
  return os;
}
  5e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  61:	89 c8                	mov    %ecx,%eax
  63:	c9                   	leave
  64:	c3                   	ret
  65:	8d 76 00             	lea    0x0(%esi),%esi
  68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  6f:	00 

00000070 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	53                   	push   %ebx
  74:	8b 55 08             	mov    0x8(%ebp),%edx
  77:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  7a:	0f b6 02             	movzbl (%edx),%eax
  7d:	84 c0                	test   %al,%al
  7f:	75 2d                	jne    ae <strcmp+0x3e>
  81:	eb 3d                	jmp    c0 <strcmp+0x50>
  83:	eb 1b                	jmp    a0 <strcmp+0x30>
  85:	8d 76 00             	lea    0x0(%esi),%esi
  88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  8f:	00 
  90:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  97:	00 
  98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  9f:	00 
  a0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  a4:	83 c2 01             	add    $0x1,%edx
  a7:	83 c1 01             	add    $0x1,%ecx
  while(*p && *p == *q)
  aa:	84 c0                	test   %al,%al
  ac:	74 12                	je     c0 <strcmp+0x50>
  ae:	0f b6 19             	movzbl (%ecx),%ebx
  b1:	38 c3                	cmp    %al,%bl
  b3:	74 eb                	je     a0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
  b5:	29 d8                	sub    %ebx,%eax
}
  b7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  ba:	c9                   	leave
  bb:	c3                   	ret
  bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return (uchar)*p - (uchar)*q;
  c0:	0f b6 19             	movzbl (%ecx),%ebx
  c3:	31 c0                	xor    %eax,%eax
  c5:	29 d8                	sub    %ebx,%eax
}
  c7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  ca:	c9                   	leave
  cb:	c3                   	ret
  cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000000d0 <strlen>:

uint
strlen(const char *s)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  d6:	80 3a 00             	cmpb   $0x0,(%edx)
  d9:	74 15                	je     f0 <strlen+0x20>
  db:	31 c0                	xor    %eax,%eax
  dd:	8d 76 00             	lea    0x0(%esi),%esi
  e0:	83 c0 01             	add    $0x1,%eax
  e3:	89 c1                	mov    %eax,%ecx
  e5:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  e9:	75 f5                	jne    e0 <strlen+0x10>
    ;
  return n;
}
  eb:	89 c8                	mov    %ecx,%eax
  ed:	5d                   	pop    %ebp
  ee:	c3                   	ret
  ef:	90                   	nop
  for(n = 0; s[n]; n++)
  f0:	31 c9                	xor    %ecx,%ecx
}
  f2:	5d                   	pop    %ebp
  f3:	89 c8                	mov    %ecx,%eax
  f5:	c3                   	ret
  f6:	66 90                	xchg   %ax,%ax
  f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ff:	00 

00000100 <memset>:

void*
memset(void *dst, int c, uint n)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 104:	8b 4d 10             	mov    0x10(%ebp),%ecx
 107:	8b 45 0c             	mov    0xc(%ebp),%eax
 10a:	8b 7d 08             	mov    0x8(%ebp),%edi
 10d:	fc                   	cld
 10e:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 110:	8b 45 08             	mov    0x8(%ebp),%eax
 113:	8b 7d fc             	mov    -0x4(%ebp),%edi
 116:	c9                   	leave
 117:	c3                   	ret
 118:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 11f:	00 

00000120 <strchr>:

char*
strchr(const char *s, char c)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 45 08             	mov    0x8(%ebp),%eax
 126:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 12a:	0f b6 10             	movzbl (%eax),%edx
 12d:	84 d2                	test   %dl,%dl
 12f:	75 1a                	jne    14b <strchr+0x2b>
 131:	eb 25                	jmp    158 <strchr+0x38>
 133:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 138:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 13f:	00 
 140:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 144:	83 c0 01             	add    $0x1,%eax
 147:	84 d2                	test   %dl,%dl
 149:	74 0d                	je     158 <strchr+0x38>
    if(*s == c)
 14b:	38 d1                	cmp    %dl,%cl
 14d:	75 f1                	jne    140 <strchr+0x20>
      return (char*)s;
  return 0;
}
 14f:	5d                   	pop    %ebp
 150:	c3                   	ret
 151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 158:	31 c0                	xor    %eax,%eax
}
 15a:	5d                   	pop    %ebp
 15b:	c3                   	ret
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000160 <gets>:

char*
gets(char *buf, int max)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	57                   	push   %edi
 164:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 165:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 168:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 169:	31 db                	xor    %ebx,%ebx
{
 16b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 16e:	eb 27                	jmp    197 <gets+0x37>
    cc = read(0, &c, 1);
 170:	83 ec 04             	sub    $0x4,%esp
 173:	6a 01                	push   $0x1
 175:	57                   	push   %edi
 176:	6a 00                	push   $0x0
 178:	e8 32 01 00 00       	call   2af <read>
    if(cc < 1)
 17d:	83 c4 10             	add    $0x10,%esp
 180:	85 c0                	test   %eax,%eax
 182:	7e 1d                	jle    1a1 <gets+0x41>
      break;
    buf[i++] = c;
 184:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 188:	8b 55 08             	mov    0x8(%ebp),%edx
 18b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 18f:	3c 0a                	cmp    $0xa,%al
 191:	74 1d                	je     1b0 <gets+0x50>
 193:	3c 0d                	cmp    $0xd,%al
 195:	74 19                	je     1b0 <gets+0x50>
  for(i=0; i+1 < max; ){
 197:	89 de                	mov    %ebx,%esi
 199:	83 c3 01             	add    $0x1,%ebx
 19c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 19f:	7c cf                	jl     170 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 1a1:	8b 45 08             	mov    0x8(%ebp),%eax
 1a4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1ab:	5b                   	pop    %ebx
 1ac:	5e                   	pop    %esi
 1ad:	5f                   	pop    %edi
 1ae:	5d                   	pop    %ebp
 1af:	c3                   	ret
  buf[i] = '\0';
 1b0:	8b 45 08             	mov    0x8(%ebp),%eax
    buf[i++] = c;
 1b3:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 1b5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 1b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1bc:	5b                   	pop    %ebx
 1bd:	5e                   	pop    %esi
 1be:	5f                   	pop    %edi
 1bf:	5d                   	pop    %ebp
 1c0:	c3                   	ret
 1c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1cf:	00 

000001d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d6:	6a 00                	push   $0x0
 1d8:	ff 75 08             	push   0x8(%ebp)
{
 1db:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 1de:	e8 f4 00 00 00       	call   2d7 <open>
  if(fd < 0)
 1e3:	83 c4 10             	add    $0x10,%esp
 1e6:	85 c0                	test   %eax,%eax
 1e8:	78 2e                	js     218 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 1ea:	83 ec 08             	sub    $0x8,%esp
 1ed:	ff 75 0c             	push   0xc(%ebp)
 1f0:	50                   	push   %eax
 1f1:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1f4:	89 c3                	mov    %eax,%ebx
 1f6:	e8 f4 00 00 00       	call   2ef <fstat>
  close(fd);
 1fb:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1fe:	89 c6                	mov    %eax,%esi
  close(fd);
 200:	e8 ba 00 00 00       	call   2bf <close>
  return r;
 205:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 208:	83 c4 10             	add    $0x10,%esp
}
 20b:	89 f0                	mov    %esi,%eax
 20d:	8b 75 fc             	mov    -0x4(%ebp),%esi
 210:	c9                   	leave
 211:	c3                   	ret
 212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
 218:	be ff ff ff ff       	mov    $0xffffffff,%esi
 21d:	eb ec                	jmp    20b <stat+0x3b>
 21f:	90                   	nop

00000220 <atoi>:

int
atoi(const char *s)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	53                   	push   %ebx
 224:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 227:	0f be 02             	movsbl (%edx),%eax
 22a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 22d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 230:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 235:	77 1e                	ja     255 <atoi+0x35>
 237:	90                   	nop
 238:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 23f:	00 
    n = n*10 + *s++ - '0';
 240:	83 c2 01             	add    $0x1,%edx
 243:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 246:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 24a:	0f be 02             	movsbl (%edx),%eax
 24d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 250:	80 fb 09             	cmp    $0x9,%bl
 253:	76 eb                	jbe    240 <atoi+0x20>
  return n;
}
 255:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 258:	89 c8                	mov    %ecx,%eax
 25a:	c9                   	leave
 25b:	c3                   	ret
 25c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000260 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	83 ec 08             	sub    $0x8,%esp
 266:	8b 45 10             	mov    0x10(%ebp),%eax
 269:	8b 55 08             	mov    0x8(%ebp),%edx
 26c:	89 75 f8             	mov    %esi,-0x8(%ebp)
 26f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 272:	85 c0                	test   %eax,%eax
 274:	7e 12                	jle    288 <memmove+0x28>
 276:	89 7d fc             	mov    %edi,-0x4(%ebp)
 279:	01 d0                	add    %edx,%eax
  dst = vdst;
 27b:	89 d7                	mov    %edx,%edi
 27d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 280:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 281:	39 f8                	cmp    %edi,%eax
 283:	75 fb                	jne    280 <memmove+0x20>
 285:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return vdst;
}
 288:	8b 75 f8             	mov    -0x8(%ebp),%esi
 28b:	89 d0                	mov    %edx,%eax
 28d:	c9                   	leave
 28e:	c3                   	ret

0000028f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 28f:	b8 01 00 00 00       	mov    $0x1,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret

00000297 <exit>:
SYSCALL(exit)
 297:	b8 02 00 00 00       	mov    $0x2,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret

0000029f <wait>:
SYSCALL(wait)
 29f:	b8 03 00 00 00       	mov    $0x3,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret

000002a7 <pipe>:
SYSCALL(pipe)
 2a7:	b8 04 00 00 00       	mov    $0x4,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret

000002af <read>:
SYSCALL(read)
 2af:	b8 05 00 00 00       	mov    $0x5,%eax
 2b4:	cd 40                	int    $0x40
 2b6:	c3                   	ret

000002b7 <write>:
SYSCALL(write)
 2b7:	b8 10 00 00 00       	mov    $0x10,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret

000002bf <close>:
SYSCALL(close)
 2bf:	b8 15 00 00 00       	mov    $0x15,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret

000002c7 <kill>:
SYSCALL(kill)
 2c7:	b8 06 00 00 00       	mov    $0x6,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret

000002cf <exec>:
SYSCALL(exec)
 2cf:	b8 07 00 00 00       	mov    $0x7,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret

000002d7 <open>:
SYSCALL(open)
 2d7:	b8 0f 00 00 00       	mov    $0xf,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret

000002df <mknod>:
SYSCALL(mknod)
 2df:	b8 11 00 00 00       	mov    $0x11,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret

000002e7 <unlink>:
SYSCALL(unlink)
 2e7:	b8 12 00 00 00       	mov    $0x12,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret

000002ef <fstat>:
SYSCALL(fstat)
 2ef:	b8 08 00 00 00       	mov    $0x8,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret

000002f7 <link>:
SYSCALL(link)
 2f7:	b8 13 00 00 00       	mov    $0x13,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret

000002ff <mkdir>:
SYSCALL(mkdir)
 2ff:	b8 14 00 00 00       	mov    $0x14,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret

00000307 <chdir>:
SYSCALL(chdir)
 307:	b8 09 00 00 00       	mov    $0x9,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret

0000030f <dup>:
SYSCALL(dup)
 30f:	b8 0a 00 00 00       	mov    $0xa,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret

00000317 <getpid>:
SYSCALL(getpid)
 317:	b8 0b 00 00 00       	mov    $0xb,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret

0000031f <sbrk>:
SYSCALL(sbrk)
 31f:	b8 0c 00 00 00       	mov    $0xc,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret

00000327 <sleep>:
SYSCALL(sleep)
 327:	b8 0d 00 00 00       	mov    $0xd,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret

0000032f <uptime>:
SYSCALL(uptime)
 32f:	b8 0e 00 00 00       	mov    $0xe,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret

00000337 <sem_init>:
SYSCALL(sem_init)
 337:	b8 16 00 00 00       	mov    $0x16,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret

0000033f <sem_wait>:
SYSCALL(sem_wait)
 33f:	b8 17 00 00 00       	mov    $0x17,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret

00000347 <sem_post>:
SYSCALL(sem_post)
 347:	b8 18 00 00 00       	mov    $0x18,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret
 34f:	66 90                	xchg   %ax,%ax
 351:	66 90                	xchg   %ax,%ax
 353:	66 90                	xchg   %ax,%ax
 355:	66 90                	xchg   %ax,%ax
 357:	66 90                	xchg   %ax,%ax
 359:	66 90                	xchg   %ax,%ax
 35b:	66 90                	xchg   %ax,%ax
 35d:	66 90                	xchg   %ax,%ax
 35f:	90                   	nop

00000360 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
 365:	53                   	push   %ebx
 366:	89 cb                	mov    %ecx,%ebx
 368:	83 ec 3c             	sub    $0x3c,%esp
 36b:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 36e:	85 d2                	test   %edx,%edx
 370:	0f 89 9a 00 00 00    	jns    410 <printint+0xb0>
 376:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 37a:	0f 84 90 00 00 00    	je     410 <printint+0xb0>
    neg = 1;
    x = -xx;
 380:	f7 da                	neg    %edx
    neg = 1;
 382:	b8 01 00 00 00       	mov    $0x1,%eax
 387:	89 45 c0             	mov    %eax,-0x40(%ebp)
 38a:	89 d1                	mov    %edx,%ecx
  } else {
    x = xx;
  }

  i = 0;
 38c:	31 f6                	xor    %esi,%esi
 38e:	66 90                	xchg   %ax,%ax
 390:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 397:	00 
 398:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 39f:	00 
  do{
    buf[i++] = digits[x % base];
 3a0:	89 c8                	mov    %ecx,%eax
 3a2:	31 d2                	xor    %edx,%edx
 3a4:	89 f7                	mov    %esi,%edi
 3a6:	f7 f3                	div    %ebx
 3a8:	8d 76 01             	lea    0x1(%esi),%esi
  }while((x /= base) != 0);
 3ab:	39 d9                	cmp    %ebx,%ecx
    buf[i++] = digits[x % base];
 3ad:	0f b6 92 28 08 00 00 	movzbl 0x828(%edx),%edx
  }while((x /= base) != 0);
 3b4:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
 3b6:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 3ba:	73 e4                	jae    3a0 <printint+0x40>
  if(neg)
 3bc:	8b 45 c0             	mov    -0x40(%ebp),%eax
 3bf:	85 c0                	test   %eax,%eax
 3c1:	74 07                	je     3ca <printint+0x6a>
    buf[i++] = '-';
 3c3:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 3c8:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 3ca:	8d 74 3d d8          	lea    -0x28(%ebp,%edi,1),%esi
 3ce:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 3d1:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3df:	00 
    putc(fd, buf[i]);
 3e0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 3e3:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 3e6:	83 ee 01             	sub    $0x1,%esi
 3e9:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 3ec:	8d 45 d7             	lea    -0x29(%ebp),%eax
 3ef:	6a 01                	push   $0x1
 3f1:	50                   	push   %eax
 3f2:	57                   	push   %edi
 3f3:	e8 bf fe ff ff       	call   2b7 <write>
  while(--i >= 0)
 3f8:	83 c4 10             	add    $0x10,%esp
 3fb:	39 f3                	cmp    %esi,%ebx
 3fd:	75 e1                	jne    3e0 <printint+0x80>
}
 3ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
 402:	5b                   	pop    %ebx
 403:	5e                   	pop    %esi
 404:	5f                   	pop    %edi
 405:	5d                   	pop    %ebp
 406:	c3                   	ret
 407:	90                   	nop
 408:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 40f:	00 
  neg = 0;
 410:	31 c0                	xor    %eax,%eax
 412:	e9 70 ff ff ff       	jmp    387 <printint+0x27>
 417:	90                   	nop
 418:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 41f:	00 

00000420 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	83 ec 38             	sub    $0x38,%esp
 426:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 429:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 42c:	89 75 f8             	mov    %esi,-0x8(%ebp)
 42f:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 432:	0f b6 03             	movzbl (%ebx),%eax
 435:	84 c0                	test   %al,%al
 437:	0f 84 b6 00 00 00    	je     4f3 <printf+0xd3>
  ap = (uint*)(void*)&fmt + 1;
 43d:	8d 4d 10             	lea    0x10(%ebp),%ecx
 440:	89 7d fc             	mov    %edi,-0x4(%ebp)
 443:	83 c3 01             	add    $0x1,%ebx
 446:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 449:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 44c:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
 44f:	eb 2a                	jmp    47b <printf+0x5b>
 451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 458:	83 ec 04             	sub    $0x4,%esp
 45b:	88 45 e7             	mov    %al,-0x19(%ebp)
 45e:	8d 45 e7             	lea    -0x19(%ebp),%eax
  for(i = 0; fmt[i]; i++){
 461:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 464:	6a 01                	push   $0x1
 466:	50                   	push   %eax
 467:	56                   	push   %esi
 468:	e8 4a fe ff ff       	call   2b7 <write>
  for(i = 0; fmt[i]; i++){
 46d:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
 471:	83 c4 10             	add    $0x10,%esp
 474:	84 c0                	test   %al,%al
 476:	74 78                	je     4f0 <printf+0xd0>
    c = fmt[i] & 0xff;
 478:	0f b6 d0             	movzbl %al,%edx
      if(c == '%'){
 47b:	83 fa 25             	cmp    $0x25,%edx
 47e:	75 d8                	jne    458 <printf+0x38>
  for(i = 0; fmt[i]; i++){
 480:	0f b6 13             	movzbl (%ebx),%edx
 483:	84 d2                	test   %dl,%dl
 485:	74 69                	je     4f0 <printf+0xd0>
    c = fmt[i] & 0xff;
 487:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 48a:	80 fa 25             	cmp    $0x25,%dl
 48d:	0f 84 25 01 00 00    	je     5b8 <printf+0x198>
 493:	83 e8 63             	sub    $0x63,%eax
 496:	83 f8 15             	cmp    $0x15,%eax
 499:	77 0d                	ja     4a8 <printf+0x88>
 49b:	ff 24 85 d0 07 00 00 	jmp    *0x7d0(,%eax,4)
 4a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 4a8:	83 ec 04             	sub    $0x4,%esp
 4ab:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 4ae:	88 55 d0             	mov    %dl,-0x30(%ebp)
 4b1:	6a 01                	push   $0x1
 4b3:	51                   	push   %ecx
 4b4:	56                   	push   %esi
 4b5:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 4b8:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4bc:	e8 f6 fd ff ff       	call   2b7 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4c1:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 4c5:	83 c4 0c             	add    $0xc,%esp
 4c8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 4cb:	6a 01                	push   $0x1
 4cd:	88 55 e7             	mov    %dl,-0x19(%ebp)
 4d0:	51                   	push   %ecx
  for(i = 0; fmt[i]; i++){
 4d1:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 4d4:	56                   	push   %esi
 4d5:	e8 dd fd ff ff       	call   2b7 <write>
  for(i = 0; fmt[i]; i++){
 4da:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
 4de:	83 c4 10             	add    $0x10,%esp
 4e1:	84 c0                	test   %al,%al
 4e3:	75 93                	jne    478 <printf+0x58>
 4e5:	8d 76 00             	lea    0x0(%esi),%esi
 4e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4ef:	00 
 4f0:	8b 7d fc             	mov    -0x4(%ebp),%edi
      }
      state = 0;
    }
  }
}
 4f3:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 4f6:	8b 75 f8             	mov    -0x8(%ebp),%esi
 4f9:	c9                   	leave
 4fa:	c3                   	ret
 4fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 16, 0);
 500:	83 ec 0c             	sub    $0xc,%esp
 503:	8b 17                	mov    (%edi),%edx
 505:	b9 10 00 00 00       	mov    $0x10,%ecx
 50a:	89 f0                	mov    %esi,%eax
 50c:	6a 00                	push   $0x0
 50e:	e8 4d fe ff ff       	call   360 <printint>
  for(i = 0; fmt[i]; i++){
 513:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 517:	83 c3 02             	add    $0x2,%ebx
 51a:	83 c4 10             	add    $0x10,%esp
 51d:	84 c0                	test   %al,%al
 51f:	74 cf                	je     4f0 <printf+0xd0>
        ap++;
 521:	83 c7 04             	add    $0x4,%edi
 524:	e9 4f ff ff ff       	jmp    478 <printf+0x58>
 529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 530:	83 ec 0c             	sub    $0xc,%esp
 533:	8b 17                	mov    (%edi),%edx
 535:	b9 0a 00 00 00       	mov    $0xa,%ecx
 53a:	89 f0                	mov    %esi,%eax
 53c:	6a 01                	push   $0x1
 53e:	e8 1d fe ff ff       	call   360 <printint>
  for(i = 0; fmt[i]; i++){
 543:	eb ce                	jmp    513 <printf+0xf3>
 545:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 548:	83 ec 04             	sub    $0x4,%esp
 54b:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        putc(fd, *ap);
 54e:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 550:	6a 01                	push   $0x1
 552:	51                   	push   %ecx
 553:	56                   	push   %esi
        putc(fd, *ap);
 554:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 557:	e8 5b fd ff ff       	call   2b7 <write>
 55c:	eb b5                	jmp    513 <printf+0xf3>
 55e:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
 560:	8b 07                	mov    (%edi),%eax
        ap++;
 562:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 565:	85 c0                	test   %eax,%eax
 567:	74 67                	je     5d0 <printf+0x1b0>
        while(*s != 0){
 569:	0f b6 10             	movzbl (%eax),%edx
 56c:	84 d2                	test   %dl,%dl
 56e:	74 6f                	je     5df <printf+0x1bf>
 570:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 573:	89 c7                	mov    %eax,%edi
 575:	89 d0                	mov    %edx,%eax
 577:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 57a:	89 fb                	mov    %edi,%ebx
 57c:	8d 7d e7             	lea    -0x19(%ebp),%edi
 57f:	90                   	nop
  write(fd, &c, 1);
 580:	83 ec 04             	sub    $0x4,%esp
          s++;
 583:	83 c3 01             	add    $0x1,%ebx
 586:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 589:	6a 01                	push   $0x1
 58b:	57                   	push   %edi
 58c:	56                   	push   %esi
 58d:	e8 25 fd ff ff       	call   2b7 <write>
        while(*s != 0){
 592:	0f b6 03             	movzbl (%ebx),%eax
 595:	83 c4 10             	add    $0x10,%esp
 598:	84 c0                	test   %al,%al
 59a:	75 e4                	jne    580 <printf+0x160>
 59c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 59f:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 5a3:	83 c3 02             	add    $0x2,%ebx
 5a6:	84 c0                	test   %al,%al
 5a8:	0f 85 9b fe ff ff    	jne    449 <printf+0x29>
 5ae:	e9 3d ff ff ff       	jmp    4f0 <printf+0xd0>
 5b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 5b8:	83 ec 04             	sub    $0x4,%esp
 5bb:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5bf:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 5c2:	6a 01                	push   $0x1
 5c4:	e9 07 ff ff ff       	jmp    4d0 <printf+0xb0>
 5c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 5d0:	89 7d d4             	mov    %edi,-0x2c(%ebp)
        if(s == 0)
 5d3:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 5d8:	bf c8 07 00 00       	mov    $0x7c8,%edi
 5dd:	eb 98                	jmp    577 <printf+0x157>
  for(i = 0; fmt[i]; i++){
 5df:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 5e3:	83 c3 02             	add    $0x2,%ebx
 5e6:	84 c0                	test   %al,%al
 5e8:	0f 85 8a fe ff ff    	jne    478 <printf+0x58>
 5ee:	e9 fd fe ff ff       	jmp    4f0 <printf+0xd0>
 5f3:	66 90                	xchg   %ax,%ax
 5f5:	66 90                	xchg   %ax,%ax
 5f7:	66 90                	xchg   %ax,%ax
 5f9:	66 90                	xchg   %ax,%ax
 5fb:	66 90                	xchg   %ax,%ax
 5fd:	66 90                	xchg   %ax,%ax
 5ff:	90                   	nop

00000600 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 600:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 601:	a1 3c 08 00 00       	mov    0x83c,%eax
{
 606:	89 e5                	mov    %esp,%ebp
 608:	57                   	push   %edi
 609:	56                   	push   %esi
 60a:	53                   	push   %ebx
 60b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 60e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 618:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 61f:	00 
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 620:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 622:	39 c8                	cmp    %ecx,%eax
 624:	73 32                	jae    658 <free+0x58>
 626:	39 d1                	cmp    %edx,%ecx
 628:	72 04                	jb     62e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 62a:	39 d0                	cmp    %edx,%eax
 62c:	72 32                	jb     660 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 62e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 631:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 634:	39 fa                	cmp    %edi,%edx
 636:	74 30                	je     668 <free+0x68>
 638:	89 53 f8             	mov    %edx,-0x8(%ebx)
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 63b:	8b 50 04             	mov    0x4(%eax),%edx
 63e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 641:	39 f1                	cmp    %esi,%ecx
 643:	74 3a                	je     67f <free+0x7f>
 645:	89 08                	mov    %ecx,(%eax)
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 647:	5b                   	pop    %ebx
  freep = p;
 648:	a3 3c 08 00 00       	mov    %eax,0x83c
}
 64d:	5e                   	pop    %esi
 64e:	5f                   	pop    %edi
 64f:	5d                   	pop    %ebp
 650:	c3                   	ret
 651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 658:	39 d0                	cmp    %edx,%eax
 65a:	72 04                	jb     660 <free+0x60>
 65c:	39 d1                	cmp    %edx,%ecx
 65e:	72 ce                	jb     62e <free+0x2e>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 660:	89 d0                	mov    %edx,%eax
 662:	eb bc                	jmp    620 <free+0x20>
 664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 668:	03 72 04             	add    0x4(%edx),%esi
 66b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 66e:	8b 10                	mov    (%eax),%edx
 670:	8b 12                	mov    (%edx),%edx
 672:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 675:	8b 50 04             	mov    0x4(%eax),%edx
 678:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 67b:	39 f1                	cmp    %esi,%ecx
 67d:	75 c6                	jne    645 <free+0x45>
    p->s.size += bp->s.size;
 67f:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 682:	a3 3c 08 00 00       	mov    %eax,0x83c
    p->s.size += bp->s.size;
 687:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 68a:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 68d:	89 08                	mov    %ecx,(%eax)
}
 68f:	5b                   	pop    %ebx
 690:	5e                   	pop    %esi
 691:	5f                   	pop    %edi
 692:	5d                   	pop    %ebp
 693:	c3                   	ret
 694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 698:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 69f:	00 

000006a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6a6:	8b 45 08             	mov    0x8(%ebp),%eax
{
 6a9:	89 7d fc             	mov    %edi,-0x4(%ebp)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6ac:	8d 78 07             	lea    0x7(%eax),%edi
  if((prevp = freep) == 0){
 6af:	a1 3c 08 00 00       	mov    0x83c,%eax
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6b4:	c1 ef 03             	shr    $0x3,%edi
 6b7:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 6ba:	85 c0                	test   %eax,%eax
 6bc:	0f 84 c6 00 00 00    	je     788 <malloc+0xe8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6c2:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 6c4:	8b 4a 04             	mov    0x4(%edx),%ecx
 6c7:	39 f9                	cmp    %edi,%ecx
 6c9:	0f 83 87 00 00 00    	jae    756 <malloc+0xb6>
 6cf:	89 5d f4             	mov    %ebx,-0xc(%ebp)
 6d2:	89 75 f8             	mov    %esi,-0x8(%ebp)
  if(nu < 4096)
 6d5:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6da:	39 df                	cmp    %ebx,%edi
 6dc:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6df:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6e6:	eb 21                	jmp    709 <malloc+0x69>
 6e8:	eb 16                	jmp    700 <malloc+0x60>
 6ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6f0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6f7:	00 
 6f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6ff:	00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 700:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 702:	8b 4a 04             	mov    0x4(%edx),%ecx
 705:	39 f9                	cmp    %edi,%ecx
 707:	73 47                	jae    750 <malloc+0xb0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 709:	89 d0                	mov    %edx,%eax
 70b:	39 15 3c 08 00 00    	cmp    %edx,0x83c
 711:	75 ed                	jne    700 <malloc+0x60>
  p = sbrk(nu * sizeof(Header));
 713:	83 ec 0c             	sub    $0xc,%esp
 716:	56                   	push   %esi
 717:	e8 03 fc ff ff       	call   31f <sbrk>
  if(p == (char*)-1)
 71c:	83 c4 10             	add    $0x10,%esp
 71f:	83 f8 ff             	cmp    $0xffffffff,%eax
 722:	74 54                	je     778 <malloc+0xd8>
  hp->s.size = nu;
 724:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 727:	83 ec 0c             	sub    $0xc,%esp
 72a:	83 c0 08             	add    $0x8,%eax
 72d:	50                   	push   %eax
 72e:	e8 cd fe ff ff       	call   600 <free>
  return freep;
 733:	a1 3c 08 00 00       	mov    0x83c,%eax
      if((p = morecore(nunits)) == 0)
 738:	83 c4 10             	add    $0x10,%esp
 73b:	85 c0                	test   %eax,%eax
 73d:	75 c1                	jne    700 <malloc+0x60>
 73f:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 742:	8b 75 f8             	mov    -0x8(%ebp),%esi
 745:	eb 26                	jmp    76d <malloc+0xcd>
 747:	90                   	nop
 748:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 74f:	00 
 750:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 753:	8b 75 f8             	mov    -0x8(%ebp),%esi
      if(p->s.size == nunits)
 756:	39 cf                	cmp    %ecx,%edi
 758:	74 66                	je     7c0 <malloc+0x120>
        p->s.size -= nunits;
 75a:	29 f9                	sub    %edi,%ecx
 75c:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 75f:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 762:	89 7a 04             	mov    %edi,0x4(%edx)
      freep = prevp;
 765:	a3 3c 08 00 00       	mov    %eax,0x83c
      return (void*)(p + 1);
 76a:	8d 42 08             	lea    0x8(%edx),%eax
        return 0;
  }
}
 76d:	8b 7d fc             	mov    -0x4(%ebp),%edi
 770:	c9                   	leave
 771:	c3                   	ret
 772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return 0;
 778:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 77b:	8b 75 f8             	mov    -0x8(%ebp),%esi
 77e:	31 c0                	xor    %eax,%eax
}
 780:	8b 7d fc             	mov    -0x4(%ebp),%edi
 783:	c9                   	leave
 784:	c3                   	ret
 785:	8d 76 00             	lea    0x0(%esi),%esi
 788:	89 5d f4             	mov    %ebx,-0xc(%ebp)
    base.s.size = 0;
 78b:	ba 40 08 00 00       	mov    $0x840,%edx
 790:	89 75 f8             	mov    %esi,-0x8(%ebp)
    base.s.ptr = freep = prevp = &base;
 793:	c7 05 3c 08 00 00 40 	movl   $0x840,0x83c
 79a:	08 00 00 
 79d:	c7 05 40 08 00 00 40 	movl   $0x840,0x840
 7a4:	08 00 00 
    base.s.size = 0;
 7a7:	c7 05 44 08 00 00 00 	movl   $0x0,0x844
 7ae:	00 00 00 
    if(p->s.size >= nunits){
 7b1:	e9 1f ff ff ff       	jmp    6d5 <malloc+0x35>
 7b6:	66 90                	xchg   %ax,%ax
 7b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7bf:	00 
        prevp->s.ptr = p->s.ptr;
 7c0:	8b 0a                	mov    (%edx),%ecx
 7c2:	89 08                	mov    %ecx,(%eax)
 7c4:	eb 9f                	jmp    765 <malloc+0xc5>
