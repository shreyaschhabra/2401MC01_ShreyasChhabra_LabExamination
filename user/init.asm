
user/_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

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
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   f:	83 ec 08             	sub    $0x8,%esp
  12:	6a 02                	push   $0x2
  14:	68 88 08 00 00       	push   $0x888
  19:	e8 79 03 00 00       	call   397 <open>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	85 c0                	test   %eax,%eax
  23:	0f 88 9f 00 00 00    	js     c8 <main+0xc8>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  29:	83 ec 0c             	sub    $0xc,%esp
  2c:	6a 00                	push   $0x0
  2e:	e8 9c 03 00 00       	call   3cf <dup>
  dup(0);  // stderr
  33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3a:	e8 90 03 00 00       	call   3cf <dup>
  3f:	83 c4 10             	add    $0x10,%esp
  42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  4f:	00 

  for(;;){
    printf(1, "init: starting sh\n");
  50:	83 ec 08             	sub    $0x8,%esp
  53:	68 90 08 00 00       	push   $0x890
  58:	6a 01                	push   $0x1
  5a:	e8 81 04 00 00       	call   4e0 <printf>
    pid = fork();
  5f:	e8 eb 02 00 00       	call   34f <fork>
    if(pid < 0){
  64:	83 c4 10             	add    $0x10,%esp
    pid = fork();
  67:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  69:	85 c0                	test   %eax,%eax
  6b:	78 24                	js     91 <main+0x91>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  6d:	74 35                	je     a4 <main+0xa4>
  6f:	90                   	nop
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  70:	e8 ea 02 00 00       	call   35f <wait>
  75:	85 c0                	test   %eax,%eax
  77:	78 d7                	js     50 <main+0x50>
  79:	39 c3                	cmp    %eax,%ebx
  7b:	74 d3                	je     50 <main+0x50>
      printf(1, "zombie!\n");
  7d:	83 ec 08             	sub    $0x8,%esp
  80:	68 cf 08 00 00       	push   $0x8cf
  85:	6a 01                	push   $0x1
  87:	e8 54 04 00 00       	call   4e0 <printf>
  8c:	83 c4 10             	add    $0x10,%esp
  8f:	eb df                	jmp    70 <main+0x70>
      printf(1, "init: fork failed\n");
  91:	53                   	push   %ebx
  92:	53                   	push   %ebx
  93:	68 a3 08 00 00       	push   $0x8a3
  98:	6a 01                	push   $0x1
  9a:	e8 41 04 00 00       	call   4e0 <printf>
      exit();
  9f:	e8 b3 02 00 00       	call   357 <exit>
      exec("sh", argv);
  a4:	50                   	push   %eax
  a5:	50                   	push   %eax
  a6:	68 4c 09 00 00       	push   $0x94c
  ab:	68 b6 08 00 00       	push   $0x8b6
  b0:	e8 da 02 00 00       	call   38f <exec>
      printf(1, "init: exec sh failed\n");
  b5:	5a                   	pop    %edx
  b6:	59                   	pop    %ecx
  b7:	68 b9 08 00 00       	push   $0x8b9
  bc:	6a 01                	push   $0x1
  be:	e8 1d 04 00 00       	call   4e0 <printf>
      exit();
  c3:	e8 8f 02 00 00       	call   357 <exit>
    mknod("console", 1, 1);
  c8:	50                   	push   %eax
  c9:	6a 01                	push   $0x1
  cb:	6a 01                	push   $0x1
  cd:	68 88 08 00 00       	push   $0x888
  d2:	e8 c8 02 00 00       	call   39f <mknod>
    open("console", O_RDWR);
  d7:	58                   	pop    %eax
  d8:	5a                   	pop    %edx
  d9:	6a 02                	push   $0x2
  db:	68 88 08 00 00       	push   $0x888
  e0:	e8 b2 02 00 00       	call   397 <open>
  e5:	83 c4 10             	add    $0x10,%esp
  e8:	e9 3c ff ff ff       	jmp    29 <main+0x29>
  ed:	66 90                	xchg   %ax,%ax
  ef:	66 90                	xchg   %ax,%ax
  f1:	66 90                	xchg   %ax,%ax
  f3:	66 90                	xchg   %ax,%ax
  f5:	66 90                	xchg   %ax,%ax
  f7:	66 90                	xchg   %ax,%ax
  f9:	66 90                	xchg   %ax,%ax
  fb:	66 90                	xchg   %ax,%ax
  fd:	66 90                	xchg   %ax,%ax
  ff:	90                   	nop

00000100 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 100:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 101:	31 c0                	xor    %eax,%eax
{
 103:	89 e5                	mov    %esp,%ebp
 105:	53                   	push   %ebx
 106:	8b 4d 08             	mov    0x8(%ebp),%ecx
 109:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 10c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 110:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 114:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 117:	83 c0 01             	add    $0x1,%eax
 11a:	84 d2                	test   %dl,%dl
 11c:	75 f2                	jne    110 <strcpy+0x10>
    ;
  return os;
}
 11e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 121:	89 c8                	mov    %ecx,%eax
 123:	c9                   	leave
 124:	c3                   	ret
 125:	8d 76 00             	lea    0x0(%esi),%esi
 128:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 12f:	00 

00000130 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	53                   	push   %ebx
 134:	8b 55 08             	mov    0x8(%ebp),%edx
 137:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 13a:	0f b6 02             	movzbl (%edx),%eax
 13d:	84 c0                	test   %al,%al
 13f:	75 2d                	jne    16e <strcmp+0x3e>
 141:	eb 3d                	jmp    180 <strcmp+0x50>
 143:	eb 1b                	jmp    160 <strcmp+0x30>
 145:	8d 76 00             	lea    0x0(%esi),%esi
 148:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 14f:	00 
 150:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 157:	00 
 158:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 15f:	00 
 160:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 164:	83 c2 01             	add    $0x1,%edx
 167:	83 c1 01             	add    $0x1,%ecx
  while(*p && *p == *q)
 16a:	84 c0                	test   %al,%al
 16c:	74 12                	je     180 <strcmp+0x50>
 16e:	0f b6 19             	movzbl (%ecx),%ebx
 171:	38 c3                	cmp    %al,%bl
 173:	74 eb                	je     160 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 175:	29 d8                	sub    %ebx,%eax
}
 177:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 17a:	c9                   	leave
 17b:	c3                   	ret
 17c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return (uchar)*p - (uchar)*q;
 180:	0f b6 19             	movzbl (%ecx),%ebx
 183:	31 c0                	xor    %eax,%eax
 185:	29 d8                	sub    %ebx,%eax
}
 187:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 18a:	c9                   	leave
 18b:	c3                   	ret
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000190 <strlen>:

uint
strlen(const char *s)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 196:	80 3a 00             	cmpb   $0x0,(%edx)
 199:	74 15                	je     1b0 <strlen+0x20>
 19b:	31 c0                	xor    %eax,%eax
 19d:	8d 76 00             	lea    0x0(%esi),%esi
 1a0:	83 c0 01             	add    $0x1,%eax
 1a3:	89 c1                	mov    %eax,%ecx
 1a5:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1a9:	75 f5                	jne    1a0 <strlen+0x10>
    ;
  return n;
}
 1ab:	89 c8                	mov    %ecx,%eax
 1ad:	5d                   	pop    %ebp
 1ae:	c3                   	ret
 1af:	90                   	nop
  for(n = 0; s[n]; n++)
 1b0:	31 c9                	xor    %ecx,%ecx
}
 1b2:	5d                   	pop    %ebp
 1b3:	89 c8                	mov    %ecx,%eax
 1b5:	c3                   	ret
 1b6:	66 90                	xchg   %ax,%ax
 1b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1bf:	00 

000001c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1c4:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1c7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ca:	8b 7d 08             	mov    0x8(%ebp),%edi
 1cd:	fc                   	cld
 1ce:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1d0:	8b 45 08             	mov    0x8(%ebp),%eax
 1d3:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1d6:	c9                   	leave
 1d7:	c3                   	ret
 1d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1df:	00 

000001e0 <strchr>:

char*
strchr(const char *s, char c)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ea:	0f b6 10             	movzbl (%eax),%edx
 1ed:	84 d2                	test   %dl,%dl
 1ef:	75 1a                	jne    20b <strchr+0x2b>
 1f1:	eb 25                	jmp    218 <strchr+0x38>
 1f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 1f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ff:	00 
 200:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 204:	83 c0 01             	add    $0x1,%eax
 207:	84 d2                	test   %dl,%dl
 209:	74 0d                	je     218 <strchr+0x38>
    if(*s == c)
 20b:	38 d1                	cmp    %dl,%cl
 20d:	75 f1                	jne    200 <strchr+0x20>
      return (char*)s;
  return 0;
}
 20f:	5d                   	pop    %ebp
 210:	c3                   	ret
 211:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 218:	31 c0                	xor    %eax,%eax
}
 21a:	5d                   	pop    %ebp
 21b:	c3                   	ret
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000220 <gets>:

char*
gets(char *buf, int max)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 225:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 228:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 229:	31 db                	xor    %ebx,%ebx
{
 22b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 22e:	eb 27                	jmp    257 <gets+0x37>
    cc = read(0, &c, 1);
 230:	83 ec 04             	sub    $0x4,%esp
 233:	6a 01                	push   $0x1
 235:	57                   	push   %edi
 236:	6a 00                	push   $0x0
 238:	e8 32 01 00 00       	call   36f <read>
    if(cc < 1)
 23d:	83 c4 10             	add    $0x10,%esp
 240:	85 c0                	test   %eax,%eax
 242:	7e 1d                	jle    261 <gets+0x41>
      break;
    buf[i++] = c;
 244:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 248:	8b 55 08             	mov    0x8(%ebp),%edx
 24b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 24f:	3c 0a                	cmp    $0xa,%al
 251:	74 1d                	je     270 <gets+0x50>
 253:	3c 0d                	cmp    $0xd,%al
 255:	74 19                	je     270 <gets+0x50>
  for(i=0; i+1 < max; ){
 257:	89 de                	mov    %ebx,%esi
 259:	83 c3 01             	add    $0x1,%ebx
 25c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 25f:	7c cf                	jl     230 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 261:	8b 45 08             	mov    0x8(%ebp),%eax
 264:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 268:	8d 65 f4             	lea    -0xc(%ebp),%esp
 26b:	5b                   	pop    %ebx
 26c:	5e                   	pop    %esi
 26d:	5f                   	pop    %edi
 26e:	5d                   	pop    %ebp
 26f:	c3                   	ret
  buf[i] = '\0';
 270:	8b 45 08             	mov    0x8(%ebp),%eax
    buf[i++] = c;
 273:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 275:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 279:	8d 65 f4             	lea    -0xc(%ebp),%esp
 27c:	5b                   	pop    %ebx
 27d:	5e                   	pop    %esi
 27e:	5f                   	pop    %edi
 27f:	5d                   	pop    %ebp
 280:	c3                   	ret
 281:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 288:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 28f:	00 

00000290 <stat>:

int
stat(const char *n, struct stat *st)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 296:	6a 00                	push   $0x0
 298:	ff 75 08             	push   0x8(%ebp)
{
 29b:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 29e:	e8 f4 00 00 00       	call   397 <open>
  if(fd < 0)
 2a3:	83 c4 10             	add    $0x10,%esp
 2a6:	85 c0                	test   %eax,%eax
 2a8:	78 2e                	js     2d8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 2aa:	83 ec 08             	sub    $0x8,%esp
 2ad:	ff 75 0c             	push   0xc(%ebp)
 2b0:	50                   	push   %eax
 2b1:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 2b4:	89 c3                	mov    %eax,%ebx
 2b6:	e8 f4 00 00 00       	call   3af <fstat>
  close(fd);
 2bb:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2be:	89 c6                	mov    %eax,%esi
  close(fd);
 2c0:	e8 ba 00 00 00       	call   37f <close>
  return r;
 2c5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2c8:	83 c4 10             	add    $0x10,%esp
}
 2cb:	89 f0                	mov    %esi,%eax
 2cd:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2d0:	c9                   	leave
 2d1:	c3                   	ret
 2d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
 2d8:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2dd:	eb ec                	jmp    2cb <stat+0x3b>
 2df:	90                   	nop

000002e0 <atoi>:

int
atoi(const char *s)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	53                   	push   %ebx
 2e4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2e7:	0f be 02             	movsbl (%edx),%eax
 2ea:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2ed:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2f0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2f5:	77 1e                	ja     315 <atoi+0x35>
 2f7:	90                   	nop
 2f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ff:	00 
    n = n*10 + *s++ - '0';
 300:	83 c2 01             	add    $0x1,%edx
 303:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 306:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 30a:	0f be 02             	movsbl (%edx),%eax
 30d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 310:	80 fb 09             	cmp    $0x9,%bl
 313:	76 eb                	jbe    300 <atoi+0x20>
  return n;
}
 315:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 318:	89 c8                	mov    %ecx,%eax
 31a:	c9                   	leave
 31b:	c3                   	ret
 31c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000320 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	83 ec 08             	sub    $0x8,%esp
 326:	8b 45 10             	mov    0x10(%ebp),%eax
 329:	8b 55 08             	mov    0x8(%ebp),%edx
 32c:	89 75 f8             	mov    %esi,-0x8(%ebp)
 32f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 332:	85 c0                	test   %eax,%eax
 334:	7e 12                	jle    348 <memmove+0x28>
 336:	89 7d fc             	mov    %edi,-0x4(%ebp)
 339:	01 d0                	add    %edx,%eax
  dst = vdst;
 33b:	89 d7                	mov    %edx,%edi
 33d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 340:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 341:	39 f8                	cmp    %edi,%eax
 343:	75 fb                	jne    340 <memmove+0x20>
 345:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return vdst;
}
 348:	8b 75 f8             	mov    -0x8(%ebp),%esi
 34b:	89 d0                	mov    %edx,%eax
 34d:	c9                   	leave
 34e:	c3                   	ret

0000034f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 34f:	b8 01 00 00 00       	mov    $0x1,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret

00000357 <exit>:
SYSCALL(exit)
 357:	b8 02 00 00 00       	mov    $0x2,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret

0000035f <wait>:
SYSCALL(wait)
 35f:	b8 03 00 00 00       	mov    $0x3,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret

00000367 <pipe>:
SYSCALL(pipe)
 367:	b8 04 00 00 00       	mov    $0x4,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret

0000036f <read>:
SYSCALL(read)
 36f:	b8 05 00 00 00       	mov    $0x5,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret

00000377 <write>:
SYSCALL(write)
 377:	b8 10 00 00 00       	mov    $0x10,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret

0000037f <close>:
SYSCALL(close)
 37f:	b8 15 00 00 00       	mov    $0x15,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret

00000387 <kill>:
SYSCALL(kill)
 387:	b8 06 00 00 00       	mov    $0x6,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret

0000038f <exec>:
SYSCALL(exec)
 38f:	b8 07 00 00 00       	mov    $0x7,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret

00000397 <open>:
SYSCALL(open)
 397:	b8 0f 00 00 00       	mov    $0xf,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret

0000039f <mknod>:
SYSCALL(mknod)
 39f:	b8 11 00 00 00       	mov    $0x11,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret

000003a7 <unlink>:
SYSCALL(unlink)
 3a7:	b8 12 00 00 00       	mov    $0x12,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret

000003af <fstat>:
SYSCALL(fstat)
 3af:	b8 08 00 00 00       	mov    $0x8,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret

000003b7 <link>:
SYSCALL(link)
 3b7:	b8 13 00 00 00       	mov    $0x13,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret

000003bf <mkdir>:
SYSCALL(mkdir)
 3bf:	b8 14 00 00 00       	mov    $0x14,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret

000003c7 <chdir>:
SYSCALL(chdir)
 3c7:	b8 09 00 00 00       	mov    $0x9,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret

000003cf <dup>:
SYSCALL(dup)
 3cf:	b8 0a 00 00 00       	mov    $0xa,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret

000003d7 <getpid>:
SYSCALL(getpid)
 3d7:	b8 0b 00 00 00       	mov    $0xb,%eax
 3dc:	cd 40                	int    $0x40
 3de:	c3                   	ret

000003df <sbrk>:
SYSCALL(sbrk)
 3df:	b8 0c 00 00 00       	mov    $0xc,%eax
 3e4:	cd 40                	int    $0x40
 3e6:	c3                   	ret

000003e7 <sleep>:
SYSCALL(sleep)
 3e7:	b8 0d 00 00 00       	mov    $0xd,%eax
 3ec:	cd 40                	int    $0x40
 3ee:	c3                   	ret

000003ef <uptime>:
SYSCALL(uptime)
 3ef:	b8 0e 00 00 00       	mov    $0xe,%eax
 3f4:	cd 40                	int    $0x40
 3f6:	c3                   	ret

000003f7 <sem_init>:
SYSCALL(sem_init)
 3f7:	b8 16 00 00 00       	mov    $0x16,%eax
 3fc:	cd 40                	int    $0x40
 3fe:	c3                   	ret

000003ff <sem_wait>:
SYSCALL(sem_wait)
 3ff:	b8 17 00 00 00       	mov    $0x17,%eax
 404:	cd 40                	int    $0x40
 406:	c3                   	ret

00000407 <sem_post>:
SYSCALL(sem_post)
 407:	b8 18 00 00 00       	mov    $0x18,%eax
 40c:	cd 40                	int    $0x40
 40e:	c3                   	ret
 40f:	66 90                	xchg   %ax,%ax
 411:	66 90                	xchg   %ax,%ax
 413:	66 90                	xchg   %ax,%ax
 415:	66 90                	xchg   %ax,%ax
 417:	66 90                	xchg   %ax,%ax
 419:	66 90                	xchg   %ax,%ax
 41b:	66 90                	xchg   %ax,%ax
 41d:	66 90                	xchg   %ax,%ax
 41f:	90                   	nop

00000420 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	56                   	push   %esi
 425:	53                   	push   %ebx
 426:	89 cb                	mov    %ecx,%ebx
 428:	83 ec 3c             	sub    $0x3c,%esp
 42b:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 42e:	85 d2                	test   %edx,%edx
 430:	0f 89 9a 00 00 00    	jns    4d0 <printint+0xb0>
 436:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 43a:	0f 84 90 00 00 00    	je     4d0 <printint+0xb0>
    neg = 1;
    x = -xx;
 440:	f7 da                	neg    %edx
    neg = 1;
 442:	b8 01 00 00 00       	mov    $0x1,%eax
 447:	89 45 c0             	mov    %eax,-0x40(%ebp)
 44a:	89 d1                	mov    %edx,%ecx
  } else {
    x = xx;
  }

  i = 0;
 44c:	31 f6                	xor    %esi,%esi
 44e:	66 90                	xchg   %ax,%ax
 450:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 457:	00 
 458:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 45f:	00 
  do{
    buf[i++] = digits[x % base];
 460:	89 c8                	mov    %ecx,%eax
 462:	31 d2                	xor    %edx,%edx
 464:	89 f7                	mov    %esi,%edi
 466:	f7 f3                	div    %ebx
 468:	8d 76 01             	lea    0x1(%esi),%esi
  }while((x /= base) != 0);
 46b:	39 d9                	cmp    %ebx,%ecx
    buf[i++] = digits[x % base];
 46d:	0f b6 92 38 09 00 00 	movzbl 0x938(%edx),%edx
  }while((x /= base) != 0);
 474:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
 476:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 47a:	73 e4                	jae    460 <printint+0x40>
  if(neg)
 47c:	8b 45 c0             	mov    -0x40(%ebp),%eax
 47f:	85 c0                	test   %eax,%eax
 481:	74 07                	je     48a <printint+0x6a>
    buf[i++] = '-';
 483:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 488:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 48a:	8d 74 3d d8          	lea    -0x28(%ebp,%edi,1),%esi
 48e:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 491:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 498:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 49f:	00 
    putc(fd, buf[i]);
 4a0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 4a3:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 4a6:	83 ee 01             	sub    $0x1,%esi
 4a9:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 4ac:	8d 45 d7             	lea    -0x29(%ebp),%eax
 4af:	6a 01                	push   $0x1
 4b1:	50                   	push   %eax
 4b2:	57                   	push   %edi
 4b3:	e8 bf fe ff ff       	call   377 <write>
  while(--i >= 0)
 4b8:	83 c4 10             	add    $0x10,%esp
 4bb:	39 f3                	cmp    %esi,%ebx
 4bd:	75 e1                	jne    4a0 <printint+0x80>
}
 4bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4c2:	5b                   	pop    %ebx
 4c3:	5e                   	pop    %esi
 4c4:	5f                   	pop    %edi
 4c5:	5d                   	pop    %ebp
 4c6:	c3                   	ret
 4c7:	90                   	nop
 4c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4cf:	00 
  neg = 0;
 4d0:	31 c0                	xor    %eax,%eax
 4d2:	e9 70 ff ff ff       	jmp    447 <printint+0x27>
 4d7:	90                   	nop
 4d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4df:	00 

000004e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	83 ec 38             	sub    $0x38,%esp
 4e6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4e9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 4ec:	89 75 f8             	mov    %esi,-0x8(%ebp)
 4ef:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 4f2:	0f b6 03             	movzbl (%ebx),%eax
 4f5:	84 c0                	test   %al,%al
 4f7:	0f 84 b6 00 00 00    	je     5b3 <printf+0xd3>
  ap = (uint*)(void*)&fmt + 1;
 4fd:	8d 4d 10             	lea    0x10(%ebp),%ecx
 500:	89 7d fc             	mov    %edi,-0x4(%ebp)
 503:	83 c3 01             	add    $0x1,%ebx
 506:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 509:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 50c:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
 50f:	eb 2a                	jmp    53b <printf+0x5b>
 511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 518:	83 ec 04             	sub    $0x4,%esp
 51b:	88 45 e7             	mov    %al,-0x19(%ebp)
 51e:	8d 45 e7             	lea    -0x19(%ebp),%eax
  for(i = 0; fmt[i]; i++){
 521:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 524:	6a 01                	push   $0x1
 526:	50                   	push   %eax
 527:	56                   	push   %esi
 528:	e8 4a fe ff ff       	call   377 <write>
  for(i = 0; fmt[i]; i++){
 52d:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
 531:	83 c4 10             	add    $0x10,%esp
 534:	84 c0                	test   %al,%al
 536:	74 78                	je     5b0 <printf+0xd0>
    c = fmt[i] & 0xff;
 538:	0f b6 d0             	movzbl %al,%edx
      if(c == '%'){
 53b:	83 fa 25             	cmp    $0x25,%edx
 53e:	75 d8                	jne    518 <printf+0x38>
  for(i = 0; fmt[i]; i++){
 540:	0f b6 13             	movzbl (%ebx),%edx
 543:	84 d2                	test   %dl,%dl
 545:	74 69                	je     5b0 <printf+0xd0>
    c = fmt[i] & 0xff;
 547:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 54a:	80 fa 25             	cmp    $0x25,%dl
 54d:	0f 84 25 01 00 00    	je     678 <printf+0x198>
 553:	83 e8 63             	sub    $0x63,%eax
 556:	83 f8 15             	cmp    $0x15,%eax
 559:	77 0d                	ja     568 <printf+0x88>
 55b:	ff 24 85 e0 08 00 00 	jmp    *0x8e0(,%eax,4)
 562:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 568:	83 ec 04             	sub    $0x4,%esp
 56b:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 56e:	88 55 d0             	mov    %dl,-0x30(%ebp)
 571:	6a 01                	push   $0x1
 573:	51                   	push   %ecx
 574:	56                   	push   %esi
 575:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 578:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 57c:	e8 f6 fd ff ff       	call   377 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 581:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 585:	83 c4 0c             	add    $0xc,%esp
 588:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 58b:	6a 01                	push   $0x1
 58d:	88 55 e7             	mov    %dl,-0x19(%ebp)
 590:	51                   	push   %ecx
  for(i = 0; fmt[i]; i++){
 591:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 594:	56                   	push   %esi
 595:	e8 dd fd ff ff       	call   377 <write>
  for(i = 0; fmt[i]; i++){
 59a:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
 59e:	83 c4 10             	add    $0x10,%esp
 5a1:	84 c0                	test   %al,%al
 5a3:	75 93                	jne    538 <printf+0x58>
 5a5:	8d 76 00             	lea    0x0(%esi),%esi
 5a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5af:	00 
 5b0:	8b 7d fc             	mov    -0x4(%ebp),%edi
      }
      state = 0;
    }
  }
}
 5b3:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 5b6:	8b 75 f8             	mov    -0x8(%ebp),%esi
 5b9:	c9                   	leave
 5ba:	c3                   	ret
 5bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 16, 0);
 5c0:	83 ec 0c             	sub    $0xc,%esp
 5c3:	8b 17                	mov    (%edi),%edx
 5c5:	b9 10 00 00 00       	mov    $0x10,%ecx
 5ca:	89 f0                	mov    %esi,%eax
 5cc:	6a 00                	push   $0x0
 5ce:	e8 4d fe ff ff       	call   420 <printint>
  for(i = 0; fmt[i]; i++){
 5d3:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 5d7:	83 c3 02             	add    $0x2,%ebx
 5da:	83 c4 10             	add    $0x10,%esp
 5dd:	84 c0                	test   %al,%al
 5df:	74 cf                	je     5b0 <printf+0xd0>
        ap++;
 5e1:	83 c7 04             	add    $0x4,%edi
 5e4:	e9 4f ff ff ff       	jmp    538 <printf+0x58>
 5e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 5f0:	83 ec 0c             	sub    $0xc,%esp
 5f3:	8b 17                	mov    (%edi),%edx
 5f5:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5fa:	89 f0                	mov    %esi,%eax
 5fc:	6a 01                	push   $0x1
 5fe:	e8 1d fe ff ff       	call   420 <printint>
  for(i = 0; fmt[i]; i++){
 603:	eb ce                	jmp    5d3 <printf+0xf3>
 605:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 608:	83 ec 04             	sub    $0x4,%esp
 60b:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        putc(fd, *ap);
 60e:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 610:	6a 01                	push   $0x1
 612:	51                   	push   %ecx
 613:	56                   	push   %esi
        putc(fd, *ap);
 614:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 617:	e8 5b fd ff ff       	call   377 <write>
 61c:	eb b5                	jmp    5d3 <printf+0xf3>
 61e:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
 620:	8b 07                	mov    (%edi),%eax
        ap++;
 622:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 625:	85 c0                	test   %eax,%eax
 627:	74 67                	je     690 <printf+0x1b0>
        while(*s != 0){
 629:	0f b6 10             	movzbl (%eax),%edx
 62c:	84 d2                	test   %dl,%dl
 62e:	74 6f                	je     69f <printf+0x1bf>
 630:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 633:	89 c7                	mov    %eax,%edi
 635:	89 d0                	mov    %edx,%eax
 637:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 63a:	89 fb                	mov    %edi,%ebx
 63c:	8d 7d e7             	lea    -0x19(%ebp),%edi
 63f:	90                   	nop
  write(fd, &c, 1);
 640:	83 ec 04             	sub    $0x4,%esp
          s++;
 643:	83 c3 01             	add    $0x1,%ebx
 646:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 649:	6a 01                	push   $0x1
 64b:	57                   	push   %edi
 64c:	56                   	push   %esi
 64d:	e8 25 fd ff ff       	call   377 <write>
        while(*s != 0){
 652:	0f b6 03             	movzbl (%ebx),%eax
 655:	83 c4 10             	add    $0x10,%esp
 658:	84 c0                	test   %al,%al
 65a:	75 e4                	jne    640 <printf+0x160>
 65c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 65f:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 663:	83 c3 02             	add    $0x2,%ebx
 666:	84 c0                	test   %al,%al
 668:	0f 85 9b fe ff ff    	jne    509 <printf+0x29>
 66e:	e9 3d ff ff ff       	jmp    5b0 <printf+0xd0>
 673:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 678:	83 ec 04             	sub    $0x4,%esp
 67b:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 67f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 682:	6a 01                	push   $0x1
 684:	e9 07 ff ff ff       	jmp    590 <printf+0xb0>
 689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 690:	89 7d d4             	mov    %edi,-0x2c(%ebp)
        if(s == 0)
 693:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 698:	bf d8 08 00 00       	mov    $0x8d8,%edi
 69d:	eb 98                	jmp    637 <printf+0x157>
  for(i = 0; fmt[i]; i++){
 69f:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 6a3:	83 c3 02             	add    $0x2,%ebx
 6a6:	84 c0                	test   %al,%al
 6a8:	0f 85 8a fe ff ff    	jne    538 <printf+0x58>
 6ae:	e9 fd fe ff ff       	jmp    5b0 <printf+0xd0>
 6b3:	66 90                	xchg   %ax,%ax
 6b5:	66 90                	xchg   %ax,%ax
 6b7:	66 90                	xchg   %ax,%ax
 6b9:	66 90                	xchg   %ax,%ax
 6bb:	66 90                	xchg   %ax,%ax
 6bd:	66 90                	xchg   %ax,%ax
 6bf:	90                   	nop

000006c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c1:	a1 54 09 00 00       	mov    0x954,%eax
{
 6c6:	89 e5                	mov    %esp,%ebp
 6c8:	57                   	push   %edi
 6c9:	56                   	push   %esi
 6ca:	53                   	push   %ebx
 6cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6df:	00 
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e0:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e2:	39 c8                	cmp    %ecx,%eax
 6e4:	73 32                	jae    718 <free+0x58>
 6e6:	39 d1                	cmp    %edx,%ecx
 6e8:	72 04                	jb     6ee <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ea:	39 d0                	cmp    %edx,%eax
 6ec:	72 32                	jb     720 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6ee:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6f1:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6f4:	39 fa                	cmp    %edi,%edx
 6f6:	74 30                	je     728 <free+0x68>
 6f8:	89 53 f8             	mov    %edx,-0x8(%ebx)
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6fb:	8b 50 04             	mov    0x4(%eax),%edx
 6fe:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 701:	39 f1                	cmp    %esi,%ecx
 703:	74 3a                	je     73f <free+0x7f>
 705:	89 08                	mov    %ecx,(%eax)
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 707:	5b                   	pop    %ebx
  freep = p;
 708:	a3 54 09 00 00       	mov    %eax,0x954
}
 70d:	5e                   	pop    %esi
 70e:	5f                   	pop    %edi
 70f:	5d                   	pop    %ebp
 710:	c3                   	ret
 711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 718:	39 d0                	cmp    %edx,%eax
 71a:	72 04                	jb     720 <free+0x60>
 71c:	39 d1                	cmp    %edx,%ecx
 71e:	72 ce                	jb     6ee <free+0x2e>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 720:	89 d0                	mov    %edx,%eax
 722:	eb bc                	jmp    6e0 <free+0x20>
 724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 728:	03 72 04             	add    0x4(%edx),%esi
 72b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 72e:	8b 10                	mov    (%eax),%edx
 730:	8b 12                	mov    (%edx),%edx
 732:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 735:	8b 50 04             	mov    0x4(%eax),%edx
 738:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 73b:	39 f1                	cmp    %esi,%ecx
 73d:	75 c6                	jne    705 <free+0x45>
    p->s.size += bp->s.size;
 73f:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 742:	a3 54 09 00 00       	mov    %eax,0x954
    p->s.size += bp->s.size;
 747:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 74a:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 74d:	89 08                	mov    %ecx,(%eax)
}
 74f:	5b                   	pop    %ebx
 750:	5e                   	pop    %esi
 751:	5f                   	pop    %edi
 752:	5d                   	pop    %ebp
 753:	c3                   	ret
 754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 758:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 75f:	00 

00000760 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 766:	8b 45 08             	mov    0x8(%ebp),%eax
{
 769:	89 7d fc             	mov    %edi,-0x4(%ebp)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 76c:	8d 78 07             	lea    0x7(%eax),%edi
  if((prevp = freep) == 0){
 76f:	a1 54 09 00 00       	mov    0x954,%eax
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 774:	c1 ef 03             	shr    $0x3,%edi
 777:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 77a:	85 c0                	test   %eax,%eax
 77c:	0f 84 c6 00 00 00    	je     848 <malloc+0xe8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 782:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 784:	8b 4a 04             	mov    0x4(%edx),%ecx
 787:	39 f9                	cmp    %edi,%ecx
 789:	0f 83 87 00 00 00    	jae    816 <malloc+0xb6>
 78f:	89 5d f4             	mov    %ebx,-0xc(%ebp)
 792:	89 75 f8             	mov    %esi,-0x8(%ebp)
  if(nu < 4096)
 795:	bb 00 10 00 00       	mov    $0x1000,%ebx
 79a:	39 df                	cmp    %ebx,%edi
 79c:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 79f:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7a6:	eb 21                	jmp    7c9 <malloc+0x69>
 7a8:	eb 16                	jmp    7c0 <malloc+0x60>
 7aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7b0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7b7:	00 
 7b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7bf:	00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 7c2:	8b 4a 04             	mov    0x4(%edx),%ecx
 7c5:	39 f9                	cmp    %edi,%ecx
 7c7:	73 47                	jae    810 <malloc+0xb0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7c9:	89 d0                	mov    %edx,%eax
 7cb:	39 15 54 09 00 00    	cmp    %edx,0x954
 7d1:	75 ed                	jne    7c0 <malloc+0x60>
  p = sbrk(nu * sizeof(Header));
 7d3:	83 ec 0c             	sub    $0xc,%esp
 7d6:	56                   	push   %esi
 7d7:	e8 03 fc ff ff       	call   3df <sbrk>
  if(p == (char*)-1)
 7dc:	83 c4 10             	add    $0x10,%esp
 7df:	83 f8 ff             	cmp    $0xffffffff,%eax
 7e2:	74 54                	je     838 <malloc+0xd8>
  hp->s.size = nu;
 7e4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7e7:	83 ec 0c             	sub    $0xc,%esp
 7ea:	83 c0 08             	add    $0x8,%eax
 7ed:	50                   	push   %eax
 7ee:	e8 cd fe ff ff       	call   6c0 <free>
  return freep;
 7f3:	a1 54 09 00 00       	mov    0x954,%eax
      if((p = morecore(nunits)) == 0)
 7f8:	83 c4 10             	add    $0x10,%esp
 7fb:	85 c0                	test   %eax,%eax
 7fd:	75 c1                	jne    7c0 <malloc+0x60>
 7ff:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 802:	8b 75 f8             	mov    -0x8(%ebp),%esi
 805:	eb 26                	jmp    82d <malloc+0xcd>
 807:	90                   	nop
 808:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 80f:	00 
 810:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 813:	8b 75 f8             	mov    -0x8(%ebp),%esi
      if(p->s.size == nunits)
 816:	39 cf                	cmp    %ecx,%edi
 818:	74 66                	je     880 <malloc+0x120>
        p->s.size -= nunits;
 81a:	29 f9                	sub    %edi,%ecx
 81c:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 81f:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 822:	89 7a 04             	mov    %edi,0x4(%edx)
      freep = prevp;
 825:	a3 54 09 00 00       	mov    %eax,0x954
      return (void*)(p + 1);
 82a:	8d 42 08             	lea    0x8(%edx),%eax
        return 0;
  }
}
 82d:	8b 7d fc             	mov    -0x4(%ebp),%edi
 830:	c9                   	leave
 831:	c3                   	ret
 832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return 0;
 838:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 83b:	8b 75 f8             	mov    -0x8(%ebp),%esi
 83e:	31 c0                	xor    %eax,%eax
}
 840:	8b 7d fc             	mov    -0x4(%ebp),%edi
 843:	c9                   	leave
 844:	c3                   	ret
 845:	8d 76 00             	lea    0x0(%esi),%esi
 848:	89 5d f4             	mov    %ebx,-0xc(%ebp)
    base.s.size = 0;
 84b:	ba 58 09 00 00       	mov    $0x958,%edx
 850:	89 75 f8             	mov    %esi,-0x8(%ebp)
    base.s.ptr = freep = prevp = &base;
 853:	c7 05 54 09 00 00 58 	movl   $0x958,0x954
 85a:	09 00 00 
 85d:	c7 05 58 09 00 00 58 	movl   $0x958,0x958
 864:	09 00 00 
    base.s.size = 0;
 867:	c7 05 5c 09 00 00 00 	movl   $0x0,0x95c
 86e:	00 00 00 
    if(p->s.size >= nunits){
 871:	e9 1f ff ff ff       	jmp    795 <malloc+0x35>
 876:	66 90                	xchg   %ax,%ax
 878:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 87f:	00 
        prevp->s.ptr = p->s.ptr;
 880:	8b 0a                	mov    (%edx),%ecx
 882:	89 08                	mov    %ecx,(%eax)
 884:	eb 9f                	jmp    825 <malloc+0xc5>
