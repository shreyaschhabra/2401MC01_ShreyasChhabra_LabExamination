
user/_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	8b 59 04             	mov    0x4(%ecx),%ebx
  if(argc != 3){
  12:	83 39 03             	cmpl   $0x3,(%ecx)
  15:	74 13                	je     2a <main+0x2a>
    printf(2, "Usage: ln old new\n");
  17:	52                   	push   %edx
  18:	52                   	push   %edx
  19:	68 e8 07 00 00       	push   $0x7e8
  1e:	6a 02                	push   $0x2
  20:	e8 1b 04 00 00       	call   440 <printf>
    exit();
  25:	e8 8d 02 00 00       	call   2b7 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  2a:	50                   	push   %eax
  2b:	50                   	push   %eax
  2c:	ff 73 08             	push   0x8(%ebx)
  2f:	ff 73 04             	push   0x4(%ebx)
  32:	e8 e0 02 00 00       	call   317 <link>
  37:	83 c4 10             	add    $0x10,%esp
  3a:	85 c0                	test   %eax,%eax
  3c:	78 05                	js     43 <main+0x43>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit();
  3e:	e8 74 02 00 00       	call   2b7 <exit>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  43:	ff 73 08             	push   0x8(%ebx)
  46:	ff 73 04             	push   0x4(%ebx)
  49:	68 fb 07 00 00       	push   $0x7fb
  4e:	6a 02                	push   $0x2
  50:	e8 eb 03 00 00       	call   440 <printf>
  55:	83 c4 10             	add    $0x10,%esp
  58:	eb e4                	jmp    3e <main+0x3e>
  5a:	66 90                	xchg   %ax,%ax
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  60:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  61:	31 c0                	xor    %eax,%eax
{
  63:	89 e5                	mov    %esp,%ebp
  65:	53                   	push   %ebx
  66:	8b 4d 08             	mov    0x8(%ebp),%ecx
  69:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  70:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  74:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  77:	83 c0 01             	add    $0x1,%eax
  7a:	84 d2                	test   %dl,%dl
  7c:	75 f2                	jne    70 <strcpy+0x10>
    ;
  return os;
}
  7e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  81:	89 c8                	mov    %ecx,%eax
  83:	c9                   	leave
  84:	c3                   	ret
  85:	8d 76 00             	lea    0x0(%esi),%esi
  88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  8f:	00 

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	53                   	push   %ebx
  94:	8b 55 08             	mov    0x8(%ebp),%edx
  97:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  9a:	0f b6 02             	movzbl (%edx),%eax
  9d:	84 c0                	test   %al,%al
  9f:	75 2d                	jne    ce <strcmp+0x3e>
  a1:	eb 3d                	jmp    e0 <strcmp+0x50>
  a3:	eb 1b                	jmp    c0 <strcmp+0x30>
  a5:	8d 76 00             	lea    0x0(%esi),%esi
  a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  af:	00 
  b0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  b7:	00 
  b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  bf:	00 
  c0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  c4:	83 c2 01             	add    $0x1,%edx
  c7:	83 c1 01             	add    $0x1,%ecx
  while(*p && *p == *q)
  ca:	84 c0                	test   %al,%al
  cc:	74 12                	je     e0 <strcmp+0x50>
  ce:	0f b6 19             	movzbl (%ecx),%ebx
  d1:	38 c3                	cmp    %al,%bl
  d3:	74 eb                	je     c0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
  d5:	29 d8                	sub    %ebx,%eax
}
  d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  da:	c9                   	leave
  db:	c3                   	ret
  dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return (uchar)*p - (uchar)*q;
  e0:	0f b6 19             	movzbl (%ecx),%ebx
  e3:	31 c0                	xor    %eax,%eax
  e5:	29 d8                	sub    %ebx,%eax
}
  e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  ea:	c9                   	leave
  eb:	c3                   	ret
  ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000000f0 <strlen>:

uint
strlen(const char *s)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  f6:	80 3a 00             	cmpb   $0x0,(%edx)
  f9:	74 15                	je     110 <strlen+0x20>
  fb:	31 c0                	xor    %eax,%eax
  fd:	8d 76 00             	lea    0x0(%esi),%esi
 100:	83 c0 01             	add    $0x1,%eax
 103:	89 c1                	mov    %eax,%ecx
 105:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 109:	75 f5                	jne    100 <strlen+0x10>
    ;
  return n;
}
 10b:	89 c8                	mov    %ecx,%eax
 10d:	5d                   	pop    %ebp
 10e:	c3                   	ret
 10f:	90                   	nop
  for(n = 0; s[n]; n++)
 110:	31 c9                	xor    %ecx,%ecx
}
 112:	5d                   	pop    %ebp
 113:	89 c8                	mov    %ecx,%eax
 115:	c3                   	ret
 116:	66 90                	xchg   %ax,%ax
 118:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 11f:	00 

00000120 <memset>:

void*
memset(void *dst, int c, uint n)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 124:	8b 4d 10             	mov    0x10(%ebp),%ecx
 127:	8b 45 0c             	mov    0xc(%ebp),%eax
 12a:	8b 7d 08             	mov    0x8(%ebp),%edi
 12d:	fc                   	cld
 12e:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 130:	8b 45 08             	mov    0x8(%ebp),%eax
 133:	8b 7d fc             	mov    -0x4(%ebp),%edi
 136:	c9                   	leave
 137:	c3                   	ret
 138:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 13f:	00 

00000140 <strchr>:

char*
strchr(const char *s, char c)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 45 08             	mov    0x8(%ebp),%eax
 146:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 14a:	0f b6 10             	movzbl (%eax),%edx
 14d:	84 d2                	test   %dl,%dl
 14f:	75 1a                	jne    16b <strchr+0x2b>
 151:	eb 25                	jmp    178 <strchr+0x38>
 153:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 158:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 15f:	00 
 160:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 164:	83 c0 01             	add    $0x1,%eax
 167:	84 d2                	test   %dl,%dl
 169:	74 0d                	je     178 <strchr+0x38>
    if(*s == c)
 16b:	38 d1                	cmp    %dl,%cl
 16d:	75 f1                	jne    160 <strchr+0x20>
      return (char*)s;
  return 0;
}
 16f:	5d                   	pop    %ebp
 170:	c3                   	ret
 171:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 178:	31 c0                	xor    %eax,%eax
}
 17a:	5d                   	pop    %ebp
 17b:	c3                   	ret
 17c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000180 <gets>:

char*
gets(char *buf, int max)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	57                   	push   %edi
 184:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 185:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 188:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 189:	31 db                	xor    %ebx,%ebx
{
 18b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 18e:	eb 27                	jmp    1b7 <gets+0x37>
    cc = read(0, &c, 1);
 190:	83 ec 04             	sub    $0x4,%esp
 193:	6a 01                	push   $0x1
 195:	57                   	push   %edi
 196:	6a 00                	push   $0x0
 198:	e8 32 01 00 00       	call   2cf <read>
    if(cc < 1)
 19d:	83 c4 10             	add    $0x10,%esp
 1a0:	85 c0                	test   %eax,%eax
 1a2:	7e 1d                	jle    1c1 <gets+0x41>
      break;
    buf[i++] = c;
 1a4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1a8:	8b 55 08             	mov    0x8(%ebp),%edx
 1ab:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1af:	3c 0a                	cmp    $0xa,%al
 1b1:	74 1d                	je     1d0 <gets+0x50>
 1b3:	3c 0d                	cmp    $0xd,%al
 1b5:	74 19                	je     1d0 <gets+0x50>
  for(i=0; i+1 < max; ){
 1b7:	89 de                	mov    %ebx,%esi
 1b9:	83 c3 01             	add    $0x1,%ebx
 1bc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1bf:	7c cf                	jl     190 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 1c1:	8b 45 08             	mov    0x8(%ebp),%eax
 1c4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1cb:	5b                   	pop    %ebx
 1cc:	5e                   	pop    %esi
 1cd:	5f                   	pop    %edi
 1ce:	5d                   	pop    %ebp
 1cf:	c3                   	ret
  buf[i] = '\0';
 1d0:	8b 45 08             	mov    0x8(%ebp),%eax
    buf[i++] = c;
 1d3:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 1d5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 1d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1dc:	5b                   	pop    %ebx
 1dd:	5e                   	pop    %esi
 1de:	5f                   	pop    %edi
 1df:	5d                   	pop    %ebp
 1e0:	c3                   	ret
 1e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ef:	00 

000001f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f6:	6a 00                	push   $0x0
 1f8:	ff 75 08             	push   0x8(%ebp)
{
 1fb:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 1fe:	e8 f4 00 00 00       	call   2f7 <open>
  if(fd < 0)
 203:	83 c4 10             	add    $0x10,%esp
 206:	85 c0                	test   %eax,%eax
 208:	78 2e                	js     238 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 20a:	83 ec 08             	sub    $0x8,%esp
 20d:	ff 75 0c             	push   0xc(%ebp)
 210:	50                   	push   %eax
 211:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 214:	89 c3                	mov    %eax,%ebx
 216:	e8 f4 00 00 00       	call   30f <fstat>
  close(fd);
 21b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 21e:	89 c6                	mov    %eax,%esi
  close(fd);
 220:	e8 ba 00 00 00       	call   2df <close>
  return r;
 225:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 228:	83 c4 10             	add    $0x10,%esp
}
 22b:	89 f0                	mov    %esi,%eax
 22d:	8b 75 fc             	mov    -0x4(%ebp),%esi
 230:	c9                   	leave
 231:	c3                   	ret
 232:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
 238:	be ff ff ff ff       	mov    $0xffffffff,%esi
 23d:	eb ec                	jmp    22b <stat+0x3b>
 23f:	90                   	nop

00000240 <atoi>:

int
atoi(const char *s)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	53                   	push   %ebx
 244:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 247:	0f be 02             	movsbl (%edx),%eax
 24a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 24d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 250:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 255:	77 1e                	ja     275 <atoi+0x35>
 257:	90                   	nop
 258:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 25f:	00 
    n = n*10 + *s++ - '0';
 260:	83 c2 01             	add    $0x1,%edx
 263:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 266:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 26a:	0f be 02             	movsbl (%edx),%eax
 26d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 270:	80 fb 09             	cmp    $0x9,%bl
 273:	76 eb                	jbe    260 <atoi+0x20>
  return n;
}
 275:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 278:	89 c8                	mov    %ecx,%eax
 27a:	c9                   	leave
 27b:	c3                   	ret
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000280 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	83 ec 08             	sub    $0x8,%esp
 286:	8b 45 10             	mov    0x10(%ebp),%eax
 289:	8b 55 08             	mov    0x8(%ebp),%edx
 28c:	89 75 f8             	mov    %esi,-0x8(%ebp)
 28f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 292:	85 c0                	test   %eax,%eax
 294:	7e 12                	jle    2a8 <memmove+0x28>
 296:	89 7d fc             	mov    %edi,-0x4(%ebp)
 299:	01 d0                	add    %edx,%eax
  dst = vdst;
 29b:	89 d7                	mov    %edx,%edi
 29d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 2a0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2a1:	39 f8                	cmp    %edi,%eax
 2a3:	75 fb                	jne    2a0 <memmove+0x20>
 2a5:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return vdst;
}
 2a8:	8b 75 f8             	mov    -0x8(%ebp),%esi
 2ab:	89 d0                	mov    %edx,%eax
 2ad:	c9                   	leave
 2ae:	c3                   	ret

000002af <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2af:	b8 01 00 00 00       	mov    $0x1,%eax
 2b4:	cd 40                	int    $0x40
 2b6:	c3                   	ret

000002b7 <exit>:
SYSCALL(exit)
 2b7:	b8 02 00 00 00       	mov    $0x2,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret

000002bf <wait>:
SYSCALL(wait)
 2bf:	b8 03 00 00 00       	mov    $0x3,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret

000002c7 <pipe>:
SYSCALL(pipe)
 2c7:	b8 04 00 00 00       	mov    $0x4,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret

000002cf <read>:
SYSCALL(read)
 2cf:	b8 05 00 00 00       	mov    $0x5,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret

000002d7 <write>:
SYSCALL(write)
 2d7:	b8 10 00 00 00       	mov    $0x10,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret

000002df <close>:
SYSCALL(close)
 2df:	b8 15 00 00 00       	mov    $0x15,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret

000002e7 <kill>:
SYSCALL(kill)
 2e7:	b8 06 00 00 00       	mov    $0x6,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret

000002ef <exec>:
SYSCALL(exec)
 2ef:	b8 07 00 00 00       	mov    $0x7,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret

000002f7 <open>:
SYSCALL(open)
 2f7:	b8 0f 00 00 00       	mov    $0xf,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret

000002ff <mknod>:
SYSCALL(mknod)
 2ff:	b8 11 00 00 00       	mov    $0x11,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret

00000307 <unlink>:
SYSCALL(unlink)
 307:	b8 12 00 00 00       	mov    $0x12,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret

0000030f <fstat>:
SYSCALL(fstat)
 30f:	b8 08 00 00 00       	mov    $0x8,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret

00000317 <link>:
SYSCALL(link)
 317:	b8 13 00 00 00       	mov    $0x13,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret

0000031f <mkdir>:
SYSCALL(mkdir)
 31f:	b8 14 00 00 00       	mov    $0x14,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret

00000327 <chdir>:
SYSCALL(chdir)
 327:	b8 09 00 00 00       	mov    $0x9,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret

0000032f <dup>:
SYSCALL(dup)
 32f:	b8 0a 00 00 00       	mov    $0xa,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret

00000337 <getpid>:
SYSCALL(getpid)
 337:	b8 0b 00 00 00       	mov    $0xb,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret

0000033f <sbrk>:
SYSCALL(sbrk)
 33f:	b8 0c 00 00 00       	mov    $0xc,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret

00000347 <sleep>:
SYSCALL(sleep)
 347:	b8 0d 00 00 00       	mov    $0xd,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret

0000034f <uptime>:
SYSCALL(uptime)
 34f:	b8 0e 00 00 00       	mov    $0xe,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret

00000357 <freepages>:
SYSCALL(freepages)
 357:	b8 16 00 00 00       	mov    $0x16,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret

0000035f <va2pa>:
SYSCALL(va2pa)
 35f:	b8 17 00 00 00       	mov    $0x17,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret
 367:	66 90                	xchg   %ax,%ax
 369:	66 90                	xchg   %ax,%ax
 36b:	66 90                	xchg   %ax,%ax
 36d:	66 90                	xchg   %ax,%ax
 36f:	66 90                	xchg   %ax,%ax
 371:	66 90                	xchg   %ax,%ax
 373:	66 90                	xchg   %ax,%ax
 375:	66 90                	xchg   %ax,%ax
 377:	66 90                	xchg   %ax,%ax
 379:	66 90                	xchg   %ax,%ax
 37b:	66 90                	xchg   %ax,%ax
 37d:	66 90                	xchg   %ax,%ax
 37f:	90                   	nop

00000380 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	53                   	push   %ebx
 386:	89 cb                	mov    %ecx,%ebx
 388:	83 ec 3c             	sub    $0x3c,%esp
 38b:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 38e:	85 d2                	test   %edx,%edx
 390:	0f 89 9a 00 00 00    	jns    430 <printint+0xb0>
 396:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 39a:	0f 84 90 00 00 00    	je     430 <printint+0xb0>
    neg = 1;
    x = -xx;
 3a0:	f7 da                	neg    %edx
    neg = 1;
 3a2:	b8 01 00 00 00       	mov    $0x1,%eax
 3a7:	89 45 c0             	mov    %eax,-0x40(%ebp)
 3aa:	89 d1                	mov    %edx,%ecx
  } else {
    x = xx;
  }

  i = 0;
 3ac:	31 f6                	xor    %esi,%esi
 3ae:	66 90                	xchg   %ax,%ax
 3b0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3b7:	00 
 3b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3bf:	00 
  do{
    buf[i++] = digits[x % base];
 3c0:	89 c8                	mov    %ecx,%eax
 3c2:	31 d2                	xor    %edx,%edx
 3c4:	89 f7                	mov    %esi,%edi
 3c6:	f7 f3                	div    %ebx
 3c8:	8d 76 01             	lea    0x1(%esi),%esi
  }while((x /= base) != 0);
 3cb:	39 d9                	cmp    %ebx,%ecx
    buf[i++] = digits[x % base];
 3cd:	0f b6 92 70 08 00 00 	movzbl 0x870(%edx),%edx
  }while((x /= base) != 0);
 3d4:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
 3d6:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 3da:	73 e4                	jae    3c0 <printint+0x40>
  if(neg)
 3dc:	8b 45 c0             	mov    -0x40(%ebp),%eax
 3df:	85 c0                	test   %eax,%eax
 3e1:	74 07                	je     3ea <printint+0x6a>
    buf[i++] = '-';
 3e3:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 3e8:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 3ea:	8d 74 3d d8          	lea    -0x28(%ebp,%edi,1),%esi
 3ee:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 3f1:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3ff:	00 
    putc(fd, buf[i]);
 400:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 403:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 406:	83 ee 01             	sub    $0x1,%esi
 409:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 40c:	8d 45 d7             	lea    -0x29(%ebp),%eax
 40f:	6a 01                	push   $0x1
 411:	50                   	push   %eax
 412:	57                   	push   %edi
 413:	e8 bf fe ff ff       	call   2d7 <write>
  while(--i >= 0)
 418:	83 c4 10             	add    $0x10,%esp
 41b:	39 f3                	cmp    %esi,%ebx
 41d:	75 e1                	jne    400 <printint+0x80>
}
 41f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 422:	5b                   	pop    %ebx
 423:	5e                   	pop    %esi
 424:	5f                   	pop    %edi
 425:	5d                   	pop    %ebp
 426:	c3                   	ret
 427:	90                   	nop
 428:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 42f:	00 
  neg = 0;
 430:	31 c0                	xor    %eax,%eax
 432:	e9 70 ff ff ff       	jmp    3a7 <printint+0x27>
 437:	90                   	nop
 438:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 43f:	00 

00000440 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	83 ec 38             	sub    $0x38,%esp
 446:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 449:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 44c:	89 75 f8             	mov    %esi,-0x8(%ebp)
 44f:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 452:	0f b6 03             	movzbl (%ebx),%eax
 455:	84 c0                	test   %al,%al
 457:	0f 84 b6 00 00 00    	je     513 <printf+0xd3>
  ap = (uint*)(void*)&fmt + 1;
 45d:	8d 4d 10             	lea    0x10(%ebp),%ecx
 460:	89 7d fc             	mov    %edi,-0x4(%ebp)
 463:	83 c3 01             	add    $0x1,%ebx
 466:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 469:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 46c:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
 46f:	eb 2a                	jmp    49b <printf+0x5b>
 471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 478:	83 ec 04             	sub    $0x4,%esp
 47b:	88 45 e7             	mov    %al,-0x19(%ebp)
 47e:	8d 45 e7             	lea    -0x19(%ebp),%eax
  for(i = 0; fmt[i]; i++){
 481:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 484:	6a 01                	push   $0x1
 486:	50                   	push   %eax
 487:	56                   	push   %esi
 488:	e8 4a fe ff ff       	call   2d7 <write>
  for(i = 0; fmt[i]; i++){
 48d:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
 491:	83 c4 10             	add    $0x10,%esp
 494:	84 c0                	test   %al,%al
 496:	74 78                	je     510 <printf+0xd0>
    c = fmt[i] & 0xff;
 498:	0f b6 d0             	movzbl %al,%edx
      if(c == '%'){
 49b:	83 fa 25             	cmp    $0x25,%edx
 49e:	75 d8                	jne    478 <printf+0x38>
  for(i = 0; fmt[i]; i++){
 4a0:	0f b6 13             	movzbl (%ebx),%edx
 4a3:	84 d2                	test   %dl,%dl
 4a5:	74 69                	je     510 <printf+0xd0>
    c = fmt[i] & 0xff;
 4a7:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 4aa:	80 fa 25             	cmp    $0x25,%dl
 4ad:	0f 84 25 01 00 00    	je     5d8 <printf+0x198>
 4b3:	83 e8 63             	sub    $0x63,%eax
 4b6:	83 f8 15             	cmp    $0x15,%eax
 4b9:	77 0d                	ja     4c8 <printf+0x88>
 4bb:	ff 24 85 18 08 00 00 	jmp    *0x818(,%eax,4)
 4c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 4c8:	83 ec 04             	sub    $0x4,%esp
 4cb:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 4ce:	88 55 d0             	mov    %dl,-0x30(%ebp)
 4d1:	6a 01                	push   $0x1
 4d3:	51                   	push   %ecx
 4d4:	56                   	push   %esi
 4d5:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 4d8:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4dc:	e8 f6 fd ff ff       	call   2d7 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4e1:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 4e5:	83 c4 0c             	add    $0xc,%esp
 4e8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 4eb:	6a 01                	push   $0x1
 4ed:	88 55 e7             	mov    %dl,-0x19(%ebp)
 4f0:	51                   	push   %ecx
  for(i = 0; fmt[i]; i++){
 4f1:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 4f4:	56                   	push   %esi
 4f5:	e8 dd fd ff ff       	call   2d7 <write>
  for(i = 0; fmt[i]; i++){
 4fa:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
 4fe:	83 c4 10             	add    $0x10,%esp
 501:	84 c0                	test   %al,%al
 503:	75 93                	jne    498 <printf+0x58>
 505:	8d 76 00             	lea    0x0(%esi),%esi
 508:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 50f:	00 
 510:	8b 7d fc             	mov    -0x4(%ebp),%edi
      }
      state = 0;
    }
  }
}
 513:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 516:	8b 75 f8             	mov    -0x8(%ebp),%esi
 519:	c9                   	leave
 51a:	c3                   	ret
 51b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 16, 0);
 520:	83 ec 0c             	sub    $0xc,%esp
 523:	8b 17                	mov    (%edi),%edx
 525:	b9 10 00 00 00       	mov    $0x10,%ecx
 52a:	89 f0                	mov    %esi,%eax
 52c:	6a 00                	push   $0x0
 52e:	e8 4d fe ff ff       	call   380 <printint>
  for(i = 0; fmt[i]; i++){
 533:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 537:	83 c3 02             	add    $0x2,%ebx
 53a:	83 c4 10             	add    $0x10,%esp
 53d:	84 c0                	test   %al,%al
 53f:	74 cf                	je     510 <printf+0xd0>
        ap++;
 541:	83 c7 04             	add    $0x4,%edi
 544:	e9 4f ff ff ff       	jmp    498 <printf+0x58>
 549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 550:	83 ec 0c             	sub    $0xc,%esp
 553:	8b 17                	mov    (%edi),%edx
 555:	b9 0a 00 00 00       	mov    $0xa,%ecx
 55a:	89 f0                	mov    %esi,%eax
 55c:	6a 01                	push   $0x1
 55e:	e8 1d fe ff ff       	call   380 <printint>
  for(i = 0; fmt[i]; i++){
 563:	eb ce                	jmp    533 <printf+0xf3>
 565:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 568:	83 ec 04             	sub    $0x4,%esp
 56b:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        putc(fd, *ap);
 56e:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 570:	6a 01                	push   $0x1
 572:	51                   	push   %ecx
 573:	56                   	push   %esi
        putc(fd, *ap);
 574:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 577:	e8 5b fd ff ff       	call   2d7 <write>
 57c:	eb b5                	jmp    533 <printf+0xf3>
 57e:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
 580:	8b 07                	mov    (%edi),%eax
        ap++;
 582:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 585:	85 c0                	test   %eax,%eax
 587:	74 67                	je     5f0 <printf+0x1b0>
        while(*s != 0){
 589:	0f b6 10             	movzbl (%eax),%edx
 58c:	84 d2                	test   %dl,%dl
 58e:	74 6f                	je     5ff <printf+0x1bf>
 590:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 593:	89 c7                	mov    %eax,%edi
 595:	89 d0                	mov    %edx,%eax
 597:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 59a:	89 fb                	mov    %edi,%ebx
 59c:	8d 7d e7             	lea    -0x19(%ebp),%edi
 59f:	90                   	nop
  write(fd, &c, 1);
 5a0:	83 ec 04             	sub    $0x4,%esp
          s++;
 5a3:	83 c3 01             	add    $0x1,%ebx
 5a6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5a9:	6a 01                	push   $0x1
 5ab:	57                   	push   %edi
 5ac:	56                   	push   %esi
 5ad:	e8 25 fd ff ff       	call   2d7 <write>
        while(*s != 0){
 5b2:	0f b6 03             	movzbl (%ebx),%eax
 5b5:	83 c4 10             	add    $0x10,%esp
 5b8:	84 c0                	test   %al,%al
 5ba:	75 e4                	jne    5a0 <printf+0x160>
 5bc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 5bf:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 5c3:	83 c3 02             	add    $0x2,%ebx
 5c6:	84 c0                	test   %al,%al
 5c8:	0f 85 9b fe ff ff    	jne    469 <printf+0x29>
 5ce:	e9 3d ff ff ff       	jmp    510 <printf+0xd0>
 5d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 5d8:	83 ec 04             	sub    $0x4,%esp
 5db:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5df:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 5e2:	6a 01                	push   $0x1
 5e4:	e9 07 ff ff ff       	jmp    4f0 <printf+0xb0>
 5e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 5f0:	89 7d d4             	mov    %edi,-0x2c(%ebp)
        if(s == 0)
 5f3:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 5f8:	bf 0f 08 00 00       	mov    $0x80f,%edi
 5fd:	eb 98                	jmp    597 <printf+0x157>
  for(i = 0; fmt[i]; i++){
 5ff:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 603:	83 c3 02             	add    $0x2,%ebx
 606:	84 c0                	test   %al,%al
 608:	0f 85 8a fe ff ff    	jne    498 <printf+0x58>
 60e:	e9 fd fe ff ff       	jmp    510 <printf+0xd0>
 613:	66 90                	xchg   %ax,%ax
 615:	66 90                	xchg   %ax,%ax
 617:	66 90                	xchg   %ax,%ax
 619:	66 90                	xchg   %ax,%ax
 61b:	66 90                	xchg   %ax,%ax
 61d:	66 90                	xchg   %ax,%ax
 61f:	90                   	nop

00000620 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 620:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 621:	a1 84 08 00 00       	mov    0x884,%eax
{
 626:	89 e5                	mov    %esp,%ebp
 628:	57                   	push   %edi
 629:	56                   	push   %esi
 62a:	53                   	push   %ebx
 62b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 62e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 638:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 63f:	00 
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 640:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 642:	39 c8                	cmp    %ecx,%eax
 644:	73 32                	jae    678 <free+0x58>
 646:	39 d1                	cmp    %edx,%ecx
 648:	72 04                	jb     64e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 64a:	39 d0                	cmp    %edx,%eax
 64c:	72 32                	jb     680 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 64e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 651:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 654:	39 fa                	cmp    %edi,%edx
 656:	74 30                	je     688 <free+0x68>
 658:	89 53 f8             	mov    %edx,-0x8(%ebx)
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 65b:	8b 50 04             	mov    0x4(%eax),%edx
 65e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 661:	39 f1                	cmp    %esi,%ecx
 663:	74 3a                	je     69f <free+0x7f>
 665:	89 08                	mov    %ecx,(%eax)
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 667:	5b                   	pop    %ebx
  freep = p;
 668:	a3 84 08 00 00       	mov    %eax,0x884
}
 66d:	5e                   	pop    %esi
 66e:	5f                   	pop    %edi
 66f:	5d                   	pop    %ebp
 670:	c3                   	ret
 671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 678:	39 d0                	cmp    %edx,%eax
 67a:	72 04                	jb     680 <free+0x60>
 67c:	39 d1                	cmp    %edx,%ecx
 67e:	72 ce                	jb     64e <free+0x2e>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 680:	89 d0                	mov    %edx,%eax
 682:	eb bc                	jmp    640 <free+0x20>
 684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 688:	03 72 04             	add    0x4(%edx),%esi
 68b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 68e:	8b 10                	mov    (%eax),%edx
 690:	8b 12                	mov    (%edx),%edx
 692:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 695:	8b 50 04             	mov    0x4(%eax),%edx
 698:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 69b:	39 f1                	cmp    %esi,%ecx
 69d:	75 c6                	jne    665 <free+0x45>
    p->s.size += bp->s.size;
 69f:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 6a2:	a3 84 08 00 00       	mov    %eax,0x884
    p->s.size += bp->s.size;
 6a7:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6aa:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 6ad:	89 08                	mov    %ecx,(%eax)
}
 6af:	5b                   	pop    %ebx
 6b0:	5e                   	pop    %esi
 6b1:	5f                   	pop    %edi
 6b2:	5d                   	pop    %ebp
 6b3:	c3                   	ret
 6b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6bf:	00 

000006c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6c6:	8b 45 08             	mov    0x8(%ebp),%eax
{
 6c9:	89 7d fc             	mov    %edi,-0x4(%ebp)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6cc:	8d 78 07             	lea    0x7(%eax),%edi
  if((prevp = freep) == 0){
 6cf:	a1 84 08 00 00       	mov    0x884,%eax
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d4:	c1 ef 03             	shr    $0x3,%edi
 6d7:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 6da:	85 c0                	test   %eax,%eax
 6dc:	0f 84 c6 00 00 00    	je     7a8 <malloc+0xe8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6e2:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 6e4:	8b 4a 04             	mov    0x4(%edx),%ecx
 6e7:	39 f9                	cmp    %edi,%ecx
 6e9:	0f 83 87 00 00 00    	jae    776 <malloc+0xb6>
 6ef:	89 5d f4             	mov    %ebx,-0xc(%ebp)
 6f2:	89 75 f8             	mov    %esi,-0x8(%ebp)
  if(nu < 4096)
 6f5:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6fa:	39 df                	cmp    %ebx,%edi
 6fc:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6ff:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 706:	eb 21                	jmp    729 <malloc+0x69>
 708:	eb 16                	jmp    720 <malloc+0x60>
 70a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 710:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 717:	00 
 718:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 71f:	00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 720:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 722:	8b 4a 04             	mov    0x4(%edx),%ecx
 725:	39 f9                	cmp    %edi,%ecx
 727:	73 47                	jae    770 <malloc+0xb0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 729:	89 d0                	mov    %edx,%eax
 72b:	39 15 84 08 00 00    	cmp    %edx,0x884
 731:	75 ed                	jne    720 <malloc+0x60>
  p = sbrk(nu * sizeof(Header));
 733:	83 ec 0c             	sub    $0xc,%esp
 736:	56                   	push   %esi
 737:	e8 03 fc ff ff       	call   33f <sbrk>
  if(p == (char*)-1)
 73c:	83 c4 10             	add    $0x10,%esp
 73f:	83 f8 ff             	cmp    $0xffffffff,%eax
 742:	74 54                	je     798 <malloc+0xd8>
  hp->s.size = nu;
 744:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 747:	83 ec 0c             	sub    $0xc,%esp
 74a:	83 c0 08             	add    $0x8,%eax
 74d:	50                   	push   %eax
 74e:	e8 cd fe ff ff       	call   620 <free>
  return freep;
 753:	a1 84 08 00 00       	mov    0x884,%eax
      if((p = morecore(nunits)) == 0)
 758:	83 c4 10             	add    $0x10,%esp
 75b:	85 c0                	test   %eax,%eax
 75d:	75 c1                	jne    720 <malloc+0x60>
 75f:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 762:	8b 75 f8             	mov    -0x8(%ebp),%esi
 765:	eb 26                	jmp    78d <malloc+0xcd>
 767:	90                   	nop
 768:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 76f:	00 
 770:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 773:	8b 75 f8             	mov    -0x8(%ebp),%esi
      if(p->s.size == nunits)
 776:	39 cf                	cmp    %ecx,%edi
 778:	74 66                	je     7e0 <malloc+0x120>
        p->s.size -= nunits;
 77a:	29 f9                	sub    %edi,%ecx
 77c:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 77f:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 782:	89 7a 04             	mov    %edi,0x4(%edx)
      freep = prevp;
 785:	a3 84 08 00 00       	mov    %eax,0x884
      return (void*)(p + 1);
 78a:	8d 42 08             	lea    0x8(%edx),%eax
        return 0;
  }
}
 78d:	8b 7d fc             	mov    -0x4(%ebp),%edi
 790:	c9                   	leave
 791:	c3                   	ret
 792:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return 0;
 798:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 79b:	8b 75 f8             	mov    -0x8(%ebp),%esi
 79e:	31 c0                	xor    %eax,%eax
}
 7a0:	8b 7d fc             	mov    -0x4(%ebp),%edi
 7a3:	c9                   	leave
 7a4:	c3                   	ret
 7a5:	8d 76 00             	lea    0x0(%esi),%esi
 7a8:	89 5d f4             	mov    %ebx,-0xc(%ebp)
    base.s.size = 0;
 7ab:	ba 88 08 00 00       	mov    $0x888,%edx
 7b0:	89 75 f8             	mov    %esi,-0x8(%ebp)
    base.s.ptr = freep = prevp = &base;
 7b3:	c7 05 84 08 00 00 88 	movl   $0x888,0x884
 7ba:	08 00 00 
 7bd:	c7 05 88 08 00 00 88 	movl   $0x888,0x888
 7c4:	08 00 00 
    base.s.size = 0;
 7c7:	c7 05 8c 08 00 00 00 	movl   $0x0,0x88c
 7ce:	00 00 00 
    if(p->s.size >= nunits){
 7d1:	e9 1f ff ff ff       	jmp    6f5 <malloc+0x35>
 7d6:	66 90                	xchg   %ax,%ax
 7d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7df:	00 
        prevp->s.ptr = p->s.ptr;
 7e0:	8b 0a                	mov    (%edx),%ecx
 7e2:	89 08                	mov    %ecx,(%eax)
 7e4:	eb 9f                	jmp    785 <malloc+0xc5>
