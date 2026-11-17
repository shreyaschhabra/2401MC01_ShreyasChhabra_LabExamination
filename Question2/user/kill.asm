
user/_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	bb 01 00 00 00       	mov    $0x1,%ebx
  15:	51                   	push   %ecx
  16:	83 ec 08             	sub    $0x8,%esp
  19:	8b 31                	mov    (%ecx),%esi
  1b:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  if(argc < 2){
  1e:	83 fe 01             	cmp    $0x1,%esi
  21:	7e 2f                	jle    52 <main+0x52>
  23:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  2f:	00 
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  30:	83 ec 0c             	sub    $0xc,%esp
  33:	ff 34 9f             	push   (%edi,%ebx,4)
  for(i=1; i<argc; i++)
  36:	83 c3 01             	add    $0x1,%ebx
    kill(atoi(argv[i]));
  39:	e8 22 02 00 00       	call   260 <atoi>
  3e:	89 04 24             	mov    %eax,(%esp)
  41:	e8 c1 02 00 00       	call   307 <kill>
  for(i=1; i<argc; i++)
  46:	83 c4 10             	add    $0x10,%esp
  49:	39 de                	cmp    %ebx,%esi
  4b:	75 e3                	jne    30 <main+0x30>
  exit();
  4d:	e8 85 02 00 00       	call   2d7 <exit>
    printf(2, "usage: kill pid...\n");
  52:	50                   	push   %eax
  53:	50                   	push   %eax
  54:	68 08 08 00 00       	push   $0x808
  59:	6a 02                	push   $0x2
  5b:	e8 00 04 00 00       	call   460 <printf>
    exit();
  60:	e8 72 02 00 00       	call   2d7 <exit>
  65:	66 90                	xchg   %ax,%ax
  67:	66 90                	xchg   %ax,%ax
  69:	66 90                	xchg   %ax,%ax
  6b:	66 90                	xchg   %ax,%ax
  6d:	66 90                	xchg   %ax,%ax
  6f:	66 90                	xchg   %ax,%ax
  71:	66 90                	xchg   %ax,%ax
  73:	66 90                	xchg   %ax,%ax
  75:	66 90                	xchg   %ax,%ax
  77:	66 90                	xchg   %ax,%ax
  79:	66 90                	xchg   %ax,%ax
  7b:	66 90                	xchg   %ax,%ax
  7d:	66 90                	xchg   %ax,%ax
  7f:	90                   	nop

00000080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  80:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  81:	31 c0                	xor    %eax,%eax
{
  83:	89 e5                	mov    %esp,%ebp
  85:	53                   	push   %ebx
  86:	8b 4d 08             	mov    0x8(%ebp),%ecx
  89:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  90:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  94:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  97:	83 c0 01             	add    $0x1,%eax
  9a:	84 d2                	test   %dl,%dl
  9c:	75 f2                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  a1:	89 c8                	mov    %ecx,%eax
  a3:	c9                   	leave
  a4:	c3                   	ret
  a5:	8d 76 00             	lea    0x0(%esi),%esi
  a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  af:	00 

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	53                   	push   %ebx
  b4:	8b 55 08             	mov    0x8(%ebp),%edx
  b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  ba:	0f b6 02             	movzbl (%edx),%eax
  bd:	84 c0                	test   %al,%al
  bf:	75 2d                	jne    ee <strcmp+0x3e>
  c1:	eb 3d                	jmp    100 <strcmp+0x50>
  c3:	eb 1b                	jmp    e0 <strcmp+0x30>
  c5:	8d 76 00             	lea    0x0(%esi),%esi
  c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  cf:	00 
  d0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  d7:	00 
  d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  df:	00 
  e0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  e4:	83 c2 01             	add    $0x1,%edx
  e7:	83 c1 01             	add    $0x1,%ecx
  while(*p && *p == *q)
  ea:	84 c0                	test   %al,%al
  ec:	74 12                	je     100 <strcmp+0x50>
  ee:	0f b6 19             	movzbl (%ecx),%ebx
  f1:	38 c3                	cmp    %al,%bl
  f3:	74 eb                	je     e0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
  f5:	29 d8                	sub    %ebx,%eax
}
  f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  fa:	c9                   	leave
  fb:	c3                   	ret
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return (uchar)*p - (uchar)*q;
 100:	0f b6 19             	movzbl (%ecx),%ebx
 103:	31 c0                	xor    %eax,%eax
 105:	29 d8                	sub    %ebx,%eax
}
 107:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 10a:	c9                   	leave
 10b:	c3                   	ret
 10c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000110 <strlen>:

uint
strlen(const char *s)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 116:	80 3a 00             	cmpb   $0x0,(%edx)
 119:	74 15                	je     130 <strlen+0x20>
 11b:	31 c0                	xor    %eax,%eax
 11d:	8d 76 00             	lea    0x0(%esi),%esi
 120:	83 c0 01             	add    $0x1,%eax
 123:	89 c1                	mov    %eax,%ecx
 125:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 129:	75 f5                	jne    120 <strlen+0x10>
    ;
  return n;
}
 12b:	89 c8                	mov    %ecx,%eax
 12d:	5d                   	pop    %ebp
 12e:	c3                   	ret
 12f:	90                   	nop
  for(n = 0; s[n]; n++)
 130:	31 c9                	xor    %ecx,%ecx
}
 132:	5d                   	pop    %ebp
 133:	89 c8                	mov    %ecx,%eax
 135:	c3                   	ret
 136:	66 90                	xchg   %ax,%ax
 138:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 13f:	00 

00000140 <memset>:

void*
memset(void *dst, int c, uint n)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 144:	8b 4d 10             	mov    0x10(%ebp),%ecx
 147:	8b 45 0c             	mov    0xc(%ebp),%eax
 14a:	8b 7d 08             	mov    0x8(%ebp),%edi
 14d:	fc                   	cld
 14e:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 150:	8b 45 08             	mov    0x8(%ebp),%eax
 153:	8b 7d fc             	mov    -0x4(%ebp),%edi
 156:	c9                   	leave
 157:	c3                   	ret
 158:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 15f:	00 

00000160 <strchr>:

char*
strchr(const char *s, char c)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 45 08             	mov    0x8(%ebp),%eax
 166:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 16a:	0f b6 10             	movzbl (%eax),%edx
 16d:	84 d2                	test   %dl,%dl
 16f:	75 1a                	jne    18b <strchr+0x2b>
 171:	eb 25                	jmp    198 <strchr+0x38>
 173:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 178:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 17f:	00 
 180:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 184:	83 c0 01             	add    $0x1,%eax
 187:	84 d2                	test   %dl,%dl
 189:	74 0d                	je     198 <strchr+0x38>
    if(*s == c)
 18b:	38 d1                	cmp    %dl,%cl
 18d:	75 f1                	jne    180 <strchr+0x20>
      return (char*)s;
  return 0;
}
 18f:	5d                   	pop    %ebp
 190:	c3                   	ret
 191:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 198:	31 c0                	xor    %eax,%eax
}
 19a:	5d                   	pop    %ebp
 19b:	c3                   	ret
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001a0 <gets>:

char*
gets(char *buf, int max)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	57                   	push   %edi
 1a4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 1a5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 1a8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 1a9:	31 db                	xor    %ebx,%ebx
{
 1ab:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 1ae:	eb 27                	jmp    1d7 <gets+0x37>
    cc = read(0, &c, 1);
 1b0:	83 ec 04             	sub    $0x4,%esp
 1b3:	6a 01                	push   $0x1
 1b5:	57                   	push   %edi
 1b6:	6a 00                	push   $0x0
 1b8:	e8 32 01 00 00       	call   2ef <read>
    if(cc < 1)
 1bd:	83 c4 10             	add    $0x10,%esp
 1c0:	85 c0                	test   %eax,%eax
 1c2:	7e 1d                	jle    1e1 <gets+0x41>
      break;
    buf[i++] = c;
 1c4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1c8:	8b 55 08             	mov    0x8(%ebp),%edx
 1cb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1cf:	3c 0a                	cmp    $0xa,%al
 1d1:	74 1d                	je     1f0 <gets+0x50>
 1d3:	3c 0d                	cmp    $0xd,%al
 1d5:	74 19                	je     1f0 <gets+0x50>
  for(i=0; i+1 < max; ){
 1d7:	89 de                	mov    %ebx,%esi
 1d9:	83 c3 01             	add    $0x1,%ebx
 1dc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1df:	7c cf                	jl     1b0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 1e1:	8b 45 08             	mov    0x8(%ebp),%eax
 1e4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1eb:	5b                   	pop    %ebx
 1ec:	5e                   	pop    %esi
 1ed:	5f                   	pop    %edi
 1ee:	5d                   	pop    %ebp
 1ef:	c3                   	ret
  buf[i] = '\0';
 1f0:	8b 45 08             	mov    0x8(%ebp),%eax
    buf[i++] = c;
 1f3:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 1f5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 1f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1fc:	5b                   	pop    %ebx
 1fd:	5e                   	pop    %esi
 1fe:	5f                   	pop    %edi
 1ff:	5d                   	pop    %ebp
 200:	c3                   	ret
 201:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 208:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 20f:	00 

00000210 <stat>:

int
stat(const char *n, struct stat *st)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 216:	6a 00                	push   $0x0
 218:	ff 75 08             	push   0x8(%ebp)
{
 21b:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 21e:	e8 f4 00 00 00       	call   317 <open>
  if(fd < 0)
 223:	83 c4 10             	add    $0x10,%esp
 226:	85 c0                	test   %eax,%eax
 228:	78 2e                	js     258 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 22a:	83 ec 08             	sub    $0x8,%esp
 22d:	ff 75 0c             	push   0xc(%ebp)
 230:	50                   	push   %eax
 231:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 234:	89 c3                	mov    %eax,%ebx
 236:	e8 f4 00 00 00       	call   32f <fstat>
  close(fd);
 23b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 23e:	89 c6                	mov    %eax,%esi
  close(fd);
 240:	e8 ba 00 00 00       	call   2ff <close>
  return r;
 245:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 248:	83 c4 10             	add    $0x10,%esp
}
 24b:	89 f0                	mov    %esi,%eax
 24d:	8b 75 fc             	mov    -0x4(%ebp),%esi
 250:	c9                   	leave
 251:	c3                   	ret
 252:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
 258:	be ff ff ff ff       	mov    $0xffffffff,%esi
 25d:	eb ec                	jmp    24b <stat+0x3b>
 25f:	90                   	nop

00000260 <atoi>:

int
atoi(const char *s)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 267:	0f be 02             	movsbl (%edx),%eax
 26a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 26d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 270:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 275:	77 1e                	ja     295 <atoi+0x35>
 277:	90                   	nop
 278:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 27f:	00 
    n = n*10 + *s++ - '0';
 280:	83 c2 01             	add    $0x1,%edx
 283:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 286:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 28a:	0f be 02             	movsbl (%edx),%eax
 28d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 290:	80 fb 09             	cmp    $0x9,%bl
 293:	76 eb                	jbe    280 <atoi+0x20>
  return n;
}
 295:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 298:	89 c8                	mov    %ecx,%eax
 29a:	c9                   	leave
 29b:	c3                   	ret
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	83 ec 08             	sub    $0x8,%esp
 2a6:	8b 45 10             	mov    0x10(%ebp),%eax
 2a9:	8b 55 08             	mov    0x8(%ebp),%edx
 2ac:	89 75 f8             	mov    %esi,-0x8(%ebp)
 2af:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2b2:	85 c0                	test   %eax,%eax
 2b4:	7e 12                	jle    2c8 <memmove+0x28>
 2b6:	89 7d fc             	mov    %edi,-0x4(%ebp)
 2b9:	01 d0                	add    %edx,%eax
  dst = vdst;
 2bb:	89 d7                	mov    %edx,%edi
 2bd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 2c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2c1:	39 f8                	cmp    %edi,%eax
 2c3:	75 fb                	jne    2c0 <memmove+0x20>
 2c5:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return vdst;
}
 2c8:	8b 75 f8             	mov    -0x8(%ebp),%esi
 2cb:	89 d0                	mov    %edx,%eax
 2cd:	c9                   	leave
 2ce:	c3                   	ret

000002cf <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2cf:	b8 01 00 00 00       	mov    $0x1,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret

000002d7 <exit>:
SYSCALL(exit)
 2d7:	b8 02 00 00 00       	mov    $0x2,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret

000002df <wait>:
SYSCALL(wait)
 2df:	b8 03 00 00 00       	mov    $0x3,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret

000002e7 <pipe>:
SYSCALL(pipe)
 2e7:	b8 04 00 00 00       	mov    $0x4,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret

000002ef <read>:
SYSCALL(read)
 2ef:	b8 05 00 00 00       	mov    $0x5,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret

000002f7 <write>:
SYSCALL(write)
 2f7:	b8 10 00 00 00       	mov    $0x10,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret

000002ff <close>:
SYSCALL(close)
 2ff:	b8 15 00 00 00       	mov    $0x15,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret

00000307 <kill>:
SYSCALL(kill)
 307:	b8 06 00 00 00       	mov    $0x6,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret

0000030f <exec>:
SYSCALL(exec)
 30f:	b8 07 00 00 00       	mov    $0x7,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret

00000317 <open>:
SYSCALL(open)
 317:	b8 0f 00 00 00       	mov    $0xf,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret

0000031f <mknod>:
SYSCALL(mknod)
 31f:	b8 11 00 00 00       	mov    $0x11,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret

00000327 <unlink>:
SYSCALL(unlink)
 327:	b8 12 00 00 00       	mov    $0x12,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret

0000032f <fstat>:
SYSCALL(fstat)
 32f:	b8 08 00 00 00       	mov    $0x8,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret

00000337 <link>:
SYSCALL(link)
 337:	b8 13 00 00 00       	mov    $0x13,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret

0000033f <mkdir>:
SYSCALL(mkdir)
 33f:	b8 14 00 00 00       	mov    $0x14,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret

00000347 <chdir>:
SYSCALL(chdir)
 347:	b8 09 00 00 00       	mov    $0x9,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret

0000034f <dup>:
SYSCALL(dup)
 34f:	b8 0a 00 00 00       	mov    $0xa,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret

00000357 <getpid>:
SYSCALL(getpid)
 357:	b8 0b 00 00 00       	mov    $0xb,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret

0000035f <sbrk>:
SYSCALL(sbrk)
 35f:	b8 0c 00 00 00       	mov    $0xc,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret

00000367 <sleep>:
SYSCALL(sleep)
 367:	b8 0d 00 00 00       	mov    $0xd,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret

0000036f <uptime>:
SYSCALL(uptime)
 36f:	b8 0e 00 00 00       	mov    $0xe,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret

00000377 <freepages>:
SYSCALL(freepages)
 377:	b8 16 00 00 00       	mov    $0x16,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret

0000037f <va2pa>:
SYSCALL(va2pa)
 37f:	b8 17 00 00 00       	mov    $0x17,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret
 387:	66 90                	xchg   %ax,%ax
 389:	66 90                	xchg   %ax,%ax
 38b:	66 90                	xchg   %ax,%ax
 38d:	66 90                	xchg   %ax,%ax
 38f:	66 90                	xchg   %ax,%ax
 391:	66 90                	xchg   %ax,%ax
 393:	66 90                	xchg   %ax,%ax
 395:	66 90                	xchg   %ax,%ax
 397:	66 90                	xchg   %ax,%ax
 399:	66 90                	xchg   %ax,%ax
 39b:	66 90                	xchg   %ax,%ax
 39d:	66 90                	xchg   %ax,%ax
 39f:	90                   	nop

000003a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	56                   	push   %esi
 3a5:	53                   	push   %ebx
 3a6:	89 cb                	mov    %ecx,%ebx
 3a8:	83 ec 3c             	sub    $0x3c,%esp
 3ab:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3ae:	85 d2                	test   %edx,%edx
 3b0:	0f 89 9a 00 00 00    	jns    450 <printint+0xb0>
 3b6:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3ba:	0f 84 90 00 00 00    	je     450 <printint+0xb0>
    neg = 1;
    x = -xx;
 3c0:	f7 da                	neg    %edx
    neg = 1;
 3c2:	b8 01 00 00 00       	mov    $0x1,%eax
 3c7:	89 45 c0             	mov    %eax,-0x40(%ebp)
 3ca:	89 d1                	mov    %edx,%ecx
  } else {
    x = xx;
  }

  i = 0;
 3cc:	31 f6                	xor    %esi,%esi
 3ce:	66 90                	xchg   %ax,%ax
 3d0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3d7:	00 
 3d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3df:	00 
  do{
    buf[i++] = digits[x % base];
 3e0:	89 c8                	mov    %ecx,%eax
 3e2:	31 d2                	xor    %edx,%edx
 3e4:	89 f7                	mov    %esi,%edi
 3e6:	f7 f3                	div    %ebx
 3e8:	8d 76 01             	lea    0x1(%esi),%esi
  }while((x /= base) != 0);
 3eb:	39 d9                	cmp    %ebx,%ecx
    buf[i++] = digits[x % base];
 3ed:	0f b6 92 7c 08 00 00 	movzbl 0x87c(%edx),%edx
  }while((x /= base) != 0);
 3f4:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
 3f6:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 3fa:	73 e4                	jae    3e0 <printint+0x40>
  if(neg)
 3fc:	8b 45 c0             	mov    -0x40(%ebp),%eax
 3ff:	85 c0                	test   %eax,%eax
 401:	74 07                	je     40a <printint+0x6a>
    buf[i++] = '-';
 403:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 408:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 40a:	8d 74 3d d8          	lea    -0x28(%ebp,%edi,1),%esi
 40e:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 411:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 418:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 41f:	00 
    putc(fd, buf[i]);
 420:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 423:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 426:	83 ee 01             	sub    $0x1,%esi
 429:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 42c:	8d 45 d7             	lea    -0x29(%ebp),%eax
 42f:	6a 01                	push   $0x1
 431:	50                   	push   %eax
 432:	57                   	push   %edi
 433:	e8 bf fe ff ff       	call   2f7 <write>
  while(--i >= 0)
 438:	83 c4 10             	add    $0x10,%esp
 43b:	39 f3                	cmp    %esi,%ebx
 43d:	75 e1                	jne    420 <printint+0x80>
}
 43f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 442:	5b                   	pop    %ebx
 443:	5e                   	pop    %esi
 444:	5f                   	pop    %edi
 445:	5d                   	pop    %ebp
 446:	c3                   	ret
 447:	90                   	nop
 448:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 44f:	00 
  neg = 0;
 450:	31 c0                	xor    %eax,%eax
 452:	e9 70 ff ff ff       	jmp    3c7 <printint+0x27>
 457:	90                   	nop
 458:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 45f:	00 

00000460 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	83 ec 38             	sub    $0x38,%esp
 466:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 469:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 46c:	89 75 f8             	mov    %esi,-0x8(%ebp)
 46f:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 472:	0f b6 03             	movzbl (%ebx),%eax
 475:	84 c0                	test   %al,%al
 477:	0f 84 b6 00 00 00    	je     533 <printf+0xd3>
  ap = (uint*)(void*)&fmt + 1;
 47d:	8d 4d 10             	lea    0x10(%ebp),%ecx
 480:	89 7d fc             	mov    %edi,-0x4(%ebp)
 483:	83 c3 01             	add    $0x1,%ebx
 486:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 489:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 48c:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
 48f:	eb 2a                	jmp    4bb <printf+0x5b>
 491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 498:	83 ec 04             	sub    $0x4,%esp
 49b:	88 45 e7             	mov    %al,-0x19(%ebp)
 49e:	8d 45 e7             	lea    -0x19(%ebp),%eax
  for(i = 0; fmt[i]; i++){
 4a1:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 4a4:	6a 01                	push   $0x1
 4a6:	50                   	push   %eax
 4a7:	56                   	push   %esi
 4a8:	e8 4a fe ff ff       	call   2f7 <write>
  for(i = 0; fmt[i]; i++){
 4ad:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
 4b1:	83 c4 10             	add    $0x10,%esp
 4b4:	84 c0                	test   %al,%al
 4b6:	74 78                	je     530 <printf+0xd0>
    c = fmt[i] & 0xff;
 4b8:	0f b6 d0             	movzbl %al,%edx
      if(c == '%'){
 4bb:	83 fa 25             	cmp    $0x25,%edx
 4be:	75 d8                	jne    498 <printf+0x38>
  for(i = 0; fmt[i]; i++){
 4c0:	0f b6 13             	movzbl (%ebx),%edx
 4c3:	84 d2                	test   %dl,%dl
 4c5:	74 69                	je     530 <printf+0xd0>
    c = fmt[i] & 0xff;
 4c7:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 4ca:	80 fa 25             	cmp    $0x25,%dl
 4cd:	0f 84 25 01 00 00    	je     5f8 <printf+0x198>
 4d3:	83 e8 63             	sub    $0x63,%eax
 4d6:	83 f8 15             	cmp    $0x15,%eax
 4d9:	77 0d                	ja     4e8 <printf+0x88>
 4db:	ff 24 85 24 08 00 00 	jmp    *0x824(,%eax,4)
 4e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 4e8:	83 ec 04             	sub    $0x4,%esp
 4eb:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 4ee:	88 55 d0             	mov    %dl,-0x30(%ebp)
 4f1:	6a 01                	push   $0x1
 4f3:	51                   	push   %ecx
 4f4:	56                   	push   %esi
 4f5:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 4f8:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4fc:	e8 f6 fd ff ff       	call   2f7 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 501:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 505:	83 c4 0c             	add    $0xc,%esp
 508:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 50b:	6a 01                	push   $0x1
 50d:	88 55 e7             	mov    %dl,-0x19(%ebp)
 510:	51                   	push   %ecx
  for(i = 0; fmt[i]; i++){
 511:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 514:	56                   	push   %esi
 515:	e8 dd fd ff ff       	call   2f7 <write>
  for(i = 0; fmt[i]; i++){
 51a:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
 51e:	83 c4 10             	add    $0x10,%esp
 521:	84 c0                	test   %al,%al
 523:	75 93                	jne    4b8 <printf+0x58>
 525:	8d 76 00             	lea    0x0(%esi),%esi
 528:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 52f:	00 
 530:	8b 7d fc             	mov    -0x4(%ebp),%edi
      }
      state = 0;
    }
  }
}
 533:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 536:	8b 75 f8             	mov    -0x8(%ebp),%esi
 539:	c9                   	leave
 53a:	c3                   	ret
 53b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 16, 0);
 540:	83 ec 0c             	sub    $0xc,%esp
 543:	8b 17                	mov    (%edi),%edx
 545:	b9 10 00 00 00       	mov    $0x10,%ecx
 54a:	89 f0                	mov    %esi,%eax
 54c:	6a 00                	push   $0x0
 54e:	e8 4d fe ff ff       	call   3a0 <printint>
  for(i = 0; fmt[i]; i++){
 553:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 557:	83 c3 02             	add    $0x2,%ebx
 55a:	83 c4 10             	add    $0x10,%esp
 55d:	84 c0                	test   %al,%al
 55f:	74 cf                	je     530 <printf+0xd0>
        ap++;
 561:	83 c7 04             	add    $0x4,%edi
 564:	e9 4f ff ff ff       	jmp    4b8 <printf+0x58>
 569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 570:	83 ec 0c             	sub    $0xc,%esp
 573:	8b 17                	mov    (%edi),%edx
 575:	b9 0a 00 00 00       	mov    $0xa,%ecx
 57a:	89 f0                	mov    %esi,%eax
 57c:	6a 01                	push   $0x1
 57e:	e8 1d fe ff ff       	call   3a0 <printint>
  for(i = 0; fmt[i]; i++){
 583:	eb ce                	jmp    553 <printf+0xf3>
 585:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 588:	83 ec 04             	sub    $0x4,%esp
 58b:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        putc(fd, *ap);
 58e:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 590:	6a 01                	push   $0x1
 592:	51                   	push   %ecx
 593:	56                   	push   %esi
        putc(fd, *ap);
 594:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 597:	e8 5b fd ff ff       	call   2f7 <write>
 59c:	eb b5                	jmp    553 <printf+0xf3>
 59e:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
 5a0:	8b 07                	mov    (%edi),%eax
        ap++;
 5a2:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 5a5:	85 c0                	test   %eax,%eax
 5a7:	74 67                	je     610 <printf+0x1b0>
        while(*s != 0){
 5a9:	0f b6 10             	movzbl (%eax),%edx
 5ac:	84 d2                	test   %dl,%dl
 5ae:	74 6f                	je     61f <printf+0x1bf>
 5b0:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 5b3:	89 c7                	mov    %eax,%edi
 5b5:	89 d0                	mov    %edx,%eax
 5b7:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5ba:	89 fb                	mov    %edi,%ebx
 5bc:	8d 7d e7             	lea    -0x19(%ebp),%edi
 5bf:	90                   	nop
  write(fd, &c, 1);
 5c0:	83 ec 04             	sub    $0x4,%esp
          s++;
 5c3:	83 c3 01             	add    $0x1,%ebx
 5c6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5c9:	6a 01                	push   $0x1
 5cb:	57                   	push   %edi
 5cc:	56                   	push   %esi
 5cd:	e8 25 fd ff ff       	call   2f7 <write>
        while(*s != 0){
 5d2:	0f b6 03             	movzbl (%ebx),%eax
 5d5:	83 c4 10             	add    $0x10,%esp
 5d8:	84 c0                	test   %al,%al
 5da:	75 e4                	jne    5c0 <printf+0x160>
 5dc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 5df:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 5e3:	83 c3 02             	add    $0x2,%ebx
 5e6:	84 c0                	test   %al,%al
 5e8:	0f 85 9b fe ff ff    	jne    489 <printf+0x29>
 5ee:	e9 3d ff ff ff       	jmp    530 <printf+0xd0>
 5f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 5f8:	83 ec 04             	sub    $0x4,%esp
 5fb:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5ff:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 602:	6a 01                	push   $0x1
 604:	e9 07 ff ff ff       	jmp    510 <printf+0xb0>
 609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 610:	89 7d d4             	mov    %edi,-0x2c(%ebp)
        if(s == 0)
 613:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 618:	bf 1c 08 00 00       	mov    $0x81c,%edi
 61d:	eb 98                	jmp    5b7 <printf+0x157>
  for(i = 0; fmt[i]; i++){
 61f:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 623:	83 c3 02             	add    $0x2,%ebx
 626:	84 c0                	test   %al,%al
 628:	0f 85 8a fe ff ff    	jne    4b8 <printf+0x58>
 62e:	e9 fd fe ff ff       	jmp    530 <printf+0xd0>
 633:	66 90                	xchg   %ax,%ax
 635:	66 90                	xchg   %ax,%ax
 637:	66 90                	xchg   %ax,%ax
 639:	66 90                	xchg   %ax,%ax
 63b:	66 90                	xchg   %ax,%ax
 63d:	66 90                	xchg   %ax,%ax
 63f:	90                   	nop

00000640 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 640:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 641:	a1 90 08 00 00       	mov    0x890,%eax
{
 646:	89 e5                	mov    %esp,%ebp
 648:	57                   	push   %edi
 649:	56                   	push   %esi
 64a:	53                   	push   %ebx
 64b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 64e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 658:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 65f:	00 
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 660:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 662:	39 c8                	cmp    %ecx,%eax
 664:	73 32                	jae    698 <free+0x58>
 666:	39 d1                	cmp    %edx,%ecx
 668:	72 04                	jb     66e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 66a:	39 d0                	cmp    %edx,%eax
 66c:	72 32                	jb     6a0 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 66e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 671:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 674:	39 fa                	cmp    %edi,%edx
 676:	74 30                	je     6a8 <free+0x68>
 678:	89 53 f8             	mov    %edx,-0x8(%ebx)
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 67b:	8b 50 04             	mov    0x4(%eax),%edx
 67e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 681:	39 f1                	cmp    %esi,%ecx
 683:	74 3a                	je     6bf <free+0x7f>
 685:	89 08                	mov    %ecx,(%eax)
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 687:	5b                   	pop    %ebx
  freep = p;
 688:	a3 90 08 00 00       	mov    %eax,0x890
}
 68d:	5e                   	pop    %esi
 68e:	5f                   	pop    %edi
 68f:	5d                   	pop    %ebp
 690:	c3                   	ret
 691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 698:	39 d0                	cmp    %edx,%eax
 69a:	72 04                	jb     6a0 <free+0x60>
 69c:	39 d1                	cmp    %edx,%ecx
 69e:	72 ce                	jb     66e <free+0x2e>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a0:	89 d0                	mov    %edx,%eax
 6a2:	eb bc                	jmp    660 <free+0x20>
 6a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 6a8:	03 72 04             	add    0x4(%edx),%esi
 6ab:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6ae:	8b 10                	mov    (%eax),%edx
 6b0:	8b 12                	mov    (%edx),%edx
 6b2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6b5:	8b 50 04             	mov    0x4(%eax),%edx
 6b8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6bb:	39 f1                	cmp    %esi,%ecx
 6bd:	75 c6                	jne    685 <free+0x45>
    p->s.size += bp->s.size;
 6bf:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 6c2:	a3 90 08 00 00       	mov    %eax,0x890
    p->s.size += bp->s.size;
 6c7:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6ca:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 6cd:	89 08                	mov    %ecx,(%eax)
}
 6cf:	5b                   	pop    %ebx
 6d0:	5e                   	pop    %esi
 6d1:	5f                   	pop    %edi
 6d2:	5d                   	pop    %ebp
 6d3:	c3                   	ret
 6d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6df:	00 

000006e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e6:	8b 45 08             	mov    0x8(%ebp),%eax
{
 6e9:	89 7d fc             	mov    %edi,-0x4(%ebp)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6ec:	8d 78 07             	lea    0x7(%eax),%edi
  if((prevp = freep) == 0){
 6ef:	a1 90 08 00 00       	mov    0x890,%eax
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f4:	c1 ef 03             	shr    $0x3,%edi
 6f7:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 6fa:	85 c0                	test   %eax,%eax
 6fc:	0f 84 c6 00 00 00    	je     7c8 <malloc+0xe8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 702:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 704:	8b 4a 04             	mov    0x4(%edx),%ecx
 707:	39 f9                	cmp    %edi,%ecx
 709:	0f 83 87 00 00 00    	jae    796 <malloc+0xb6>
 70f:	89 5d f4             	mov    %ebx,-0xc(%ebp)
 712:	89 75 f8             	mov    %esi,-0x8(%ebp)
  if(nu < 4096)
 715:	bb 00 10 00 00       	mov    $0x1000,%ebx
 71a:	39 df                	cmp    %ebx,%edi
 71c:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 71f:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 726:	eb 21                	jmp    749 <malloc+0x69>
 728:	eb 16                	jmp    740 <malloc+0x60>
 72a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 730:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 737:	00 
 738:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 73f:	00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 740:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 742:	8b 4a 04             	mov    0x4(%edx),%ecx
 745:	39 f9                	cmp    %edi,%ecx
 747:	73 47                	jae    790 <malloc+0xb0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 749:	89 d0                	mov    %edx,%eax
 74b:	39 15 90 08 00 00    	cmp    %edx,0x890
 751:	75 ed                	jne    740 <malloc+0x60>
  p = sbrk(nu * sizeof(Header));
 753:	83 ec 0c             	sub    $0xc,%esp
 756:	56                   	push   %esi
 757:	e8 03 fc ff ff       	call   35f <sbrk>
  if(p == (char*)-1)
 75c:	83 c4 10             	add    $0x10,%esp
 75f:	83 f8 ff             	cmp    $0xffffffff,%eax
 762:	74 54                	je     7b8 <malloc+0xd8>
  hp->s.size = nu;
 764:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 767:	83 ec 0c             	sub    $0xc,%esp
 76a:	83 c0 08             	add    $0x8,%eax
 76d:	50                   	push   %eax
 76e:	e8 cd fe ff ff       	call   640 <free>
  return freep;
 773:	a1 90 08 00 00       	mov    0x890,%eax
      if((p = morecore(nunits)) == 0)
 778:	83 c4 10             	add    $0x10,%esp
 77b:	85 c0                	test   %eax,%eax
 77d:	75 c1                	jne    740 <malloc+0x60>
 77f:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 782:	8b 75 f8             	mov    -0x8(%ebp),%esi
 785:	eb 26                	jmp    7ad <malloc+0xcd>
 787:	90                   	nop
 788:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 78f:	00 
 790:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 793:	8b 75 f8             	mov    -0x8(%ebp),%esi
      if(p->s.size == nunits)
 796:	39 cf                	cmp    %ecx,%edi
 798:	74 66                	je     800 <malloc+0x120>
        p->s.size -= nunits;
 79a:	29 f9                	sub    %edi,%ecx
 79c:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 79f:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 7a2:	89 7a 04             	mov    %edi,0x4(%edx)
      freep = prevp;
 7a5:	a3 90 08 00 00       	mov    %eax,0x890
      return (void*)(p + 1);
 7aa:	8d 42 08             	lea    0x8(%edx),%eax
        return 0;
  }
}
 7ad:	8b 7d fc             	mov    -0x4(%ebp),%edi
 7b0:	c9                   	leave
 7b1:	c3                   	ret
 7b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return 0;
 7b8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 7bb:	8b 75 f8             	mov    -0x8(%ebp),%esi
 7be:	31 c0                	xor    %eax,%eax
}
 7c0:	8b 7d fc             	mov    -0x4(%ebp),%edi
 7c3:	c9                   	leave
 7c4:	c3                   	ret
 7c5:	8d 76 00             	lea    0x0(%esi),%esi
 7c8:	89 5d f4             	mov    %ebx,-0xc(%ebp)
    base.s.size = 0;
 7cb:	ba 94 08 00 00       	mov    $0x894,%edx
 7d0:	89 75 f8             	mov    %esi,-0x8(%ebp)
    base.s.ptr = freep = prevp = &base;
 7d3:	c7 05 90 08 00 00 94 	movl   $0x894,0x890
 7da:	08 00 00 
 7dd:	c7 05 94 08 00 00 94 	movl   $0x894,0x894
 7e4:	08 00 00 
    base.s.size = 0;
 7e7:	c7 05 98 08 00 00 00 	movl   $0x0,0x898
 7ee:	00 00 00 
    if(p->s.size >= nunits){
 7f1:	e9 1f ff ff ff       	jmp    715 <malloc+0x35>
 7f6:	66 90                	xchg   %ax,%ax
 7f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7ff:	00 
        prevp->s.ptr = p->s.ptr;
 800:	8b 0a                	mov    (%edx),%ecx
 802:	89 08                	mov    %ecx,(%eax)
 804:	eb 9f                	jmp    7a5 <malloc+0xc5>
