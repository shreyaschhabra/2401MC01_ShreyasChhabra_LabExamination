
user/_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
  int fd, i;
  char path[] = "stressfs0";
   7:	b8 30 00 00 00       	mov    $0x30,%eax
{
   c:	ff 71 fc             	push   -0x4(%ecx)
   f:	55                   	push   %ebp
  10:	89 e5                	mov    %esp,%ebp
  12:	57                   	push   %edi
  13:	56                   	push   %esi
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));
  14:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
{
  1a:	53                   	push   %ebx

  for(i = 0; i < 4; i++)
  1b:	31 db                	xor    %ebx,%ebx
{
  1d:	51                   	push   %ecx
  1e:	81 ec 20 02 00 00    	sub    $0x220,%esp
  char path[] = "stressfs0";
  24:	66 89 85 e6 fd ff ff 	mov    %ax,-0x21a(%ebp)
  printf(1, "stressfs starting\n");
  2b:	68 c8 08 00 00       	push   $0x8c8
  30:	6a 01                	push   $0x1
  char path[] = "stressfs0";
  32:	c7 85 de fd ff ff 73 	movl   $0x65727473,-0x222(%ebp)
  39:	74 72 65 
  3c:	c7 85 e2 fd ff ff 73 	movl   $0x73667373,-0x21e(%ebp)
  43:	73 66 73 
  printf(1, "stressfs starting\n");
  46:	e8 d5 04 00 00       	call   520 <printf>
  memset(data, 'a', sizeof(data));
  4b:	83 c4 0c             	add    $0xc,%esp
  4e:	68 00 02 00 00       	push   $0x200
  53:	6a 61                	push   $0x61
  55:	56                   	push   %esi
  56:	e8 a5 01 00 00       	call   200 <memset>
  5b:	83 c4 10             	add    $0x10,%esp
    if(fork() > 0)
  5e:	e8 2c 03 00 00       	call   38f <fork>
  63:	85 c0                	test   %eax,%eax
  65:	0f 8f bf 00 00 00    	jg     12a <main+0x12a>
  for(i = 0; i < 4; i++)
  6b:	83 c3 01             	add    $0x1,%ebx
  6e:	83 fb 04             	cmp    $0x4,%ebx
  71:	75 eb                	jne    5e <main+0x5e>
  73:	bf 04 00 00 00       	mov    $0x4,%edi
      break;

  printf(1, "write %d\n", i);
  78:	83 ec 04             	sub    $0x4,%esp
  7b:	53                   	push   %ebx

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  7c:	bb 14 00 00 00       	mov    $0x14,%ebx
  printf(1, "write %d\n", i);
  81:	68 db 08 00 00       	push   $0x8db
  86:	6a 01                	push   $0x1
  88:	e8 93 04 00 00       	call   520 <printf>
  path[8] += i;
  8d:	89 f8                	mov    %edi,%eax
  fd = open(path, O_CREATE | O_RDWR);
  8f:	5f                   	pop    %edi
  path[8] += i;
  90:	00 85 e6 fd ff ff    	add    %al,-0x21a(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  96:	58                   	pop    %eax
  97:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  9d:	68 02 02 00 00       	push   $0x202
  a2:	50                   	push   %eax
  a3:	e8 2f 03 00 00       	call   3d7 <open>
  a8:	83 c4 10             	add    $0x10,%esp
  ab:	89 c7                	mov    %eax,%edi
  for(i = 0; i < 20; i++)
  ad:	8d 76 00             	lea    0x0(%esi),%esi
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  b0:	83 ec 04             	sub    $0x4,%esp
  b3:	68 00 02 00 00       	push   $0x200
  b8:	56                   	push   %esi
  b9:	57                   	push   %edi
  ba:	e8 f8 02 00 00       	call   3b7 <write>
  for(i = 0; i < 20; i++)
  bf:	83 c4 10             	add    $0x10,%esp
  c2:	83 eb 01             	sub    $0x1,%ebx
  c5:	75 e9                	jne    b0 <main+0xb0>
  close(fd);
  c7:	83 ec 0c             	sub    $0xc,%esp
  ca:	57                   	push   %edi
  cb:	e8 ef 02 00 00       	call   3bf <close>

  printf(1, "read\n");
  d0:	58                   	pop    %eax
  d1:	5a                   	pop    %edx
  d2:	68 e5 08 00 00       	push   $0x8e5
  d7:	6a 01                	push   $0x1
  d9:	e8 42 04 00 00       	call   520 <printf>

  fd = open(path, O_RDONLY);
  de:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  e4:	59                   	pop    %ecx
  e5:	5b                   	pop    %ebx
  e6:	6a 00                	push   $0x0
  e8:	bb 14 00 00 00       	mov    $0x14,%ebx
  ed:	50                   	push   %eax
  ee:	e8 e4 02 00 00       	call   3d7 <open>
  f3:	83 c4 10             	add    $0x10,%esp
  f6:	89 c7                	mov    %eax,%edi
  for (i = 0; i < 20; i++)
  f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ff:	00 
    read(fd, data, sizeof(data));
 100:	83 ec 04             	sub    $0x4,%esp
 103:	68 00 02 00 00       	push   $0x200
 108:	56                   	push   %esi
 109:	57                   	push   %edi
 10a:	e8 a0 02 00 00       	call   3af <read>
  for (i = 0; i < 20; i++)
 10f:	83 c4 10             	add    $0x10,%esp
 112:	83 eb 01             	sub    $0x1,%ebx
 115:	75 e9                	jne    100 <main+0x100>
  close(fd);
 117:	83 ec 0c             	sub    $0xc,%esp
 11a:	57                   	push   %edi
 11b:	e8 9f 02 00 00       	call   3bf <close>

  wait();
 120:	e8 7a 02 00 00       	call   39f <wait>

  exit();
 125:	e8 6d 02 00 00       	call   397 <exit>
  path[8] += i;
 12a:	89 df                	mov    %ebx,%edi
 12c:	e9 47 ff ff ff       	jmp    78 <main+0x78>
 131:	66 90                	xchg   %ax,%ax
 133:	66 90                	xchg   %ax,%ax
 135:	66 90                	xchg   %ax,%ax
 137:	66 90                	xchg   %ax,%ax
 139:	66 90                	xchg   %ax,%ax
 13b:	66 90                	xchg   %ax,%ax
 13d:	66 90                	xchg   %ax,%ax
 13f:	90                   	nop

00000140 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 140:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 141:	31 c0                	xor    %eax,%eax
{
 143:	89 e5                	mov    %esp,%ebp
 145:	53                   	push   %ebx
 146:	8b 4d 08             	mov    0x8(%ebp),%ecx
 149:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 150:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 154:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 157:	83 c0 01             	add    $0x1,%eax
 15a:	84 d2                	test   %dl,%dl
 15c:	75 f2                	jne    150 <strcpy+0x10>
    ;
  return os;
}
 15e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 161:	89 c8                	mov    %ecx,%eax
 163:	c9                   	leave
 164:	c3                   	ret
 165:	8d 76 00             	lea    0x0(%esi),%esi
 168:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 16f:	00 

00000170 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	53                   	push   %ebx
 174:	8b 55 08             	mov    0x8(%ebp),%edx
 177:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 17a:	0f b6 02             	movzbl (%edx),%eax
 17d:	84 c0                	test   %al,%al
 17f:	75 2d                	jne    1ae <strcmp+0x3e>
 181:	eb 3d                	jmp    1c0 <strcmp+0x50>
 183:	eb 1b                	jmp    1a0 <strcmp+0x30>
 185:	8d 76 00             	lea    0x0(%esi),%esi
 188:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 18f:	00 
 190:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 197:	00 
 198:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 19f:	00 
 1a0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 1a4:	83 c2 01             	add    $0x1,%edx
 1a7:	83 c1 01             	add    $0x1,%ecx
  while(*p && *p == *q)
 1aa:	84 c0                	test   %al,%al
 1ac:	74 12                	je     1c0 <strcmp+0x50>
 1ae:	0f b6 19             	movzbl (%ecx),%ebx
 1b1:	38 c3                	cmp    %al,%bl
 1b3:	74 eb                	je     1a0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 1b5:	29 d8                	sub    %ebx,%eax
}
 1b7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1ba:	c9                   	leave
 1bb:	c3                   	ret
 1bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return (uchar)*p - (uchar)*q;
 1c0:	0f b6 19             	movzbl (%ecx),%ebx
 1c3:	31 c0                	xor    %eax,%eax
 1c5:	29 d8                	sub    %ebx,%eax
}
 1c7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1ca:	c9                   	leave
 1cb:	c3                   	ret
 1cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001d0 <strlen>:

uint
strlen(const char *s)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1d6:	80 3a 00             	cmpb   $0x0,(%edx)
 1d9:	74 15                	je     1f0 <strlen+0x20>
 1db:	31 c0                	xor    %eax,%eax
 1dd:	8d 76 00             	lea    0x0(%esi),%esi
 1e0:	83 c0 01             	add    $0x1,%eax
 1e3:	89 c1                	mov    %eax,%ecx
 1e5:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1e9:	75 f5                	jne    1e0 <strlen+0x10>
    ;
  return n;
}
 1eb:	89 c8                	mov    %ecx,%eax
 1ed:	5d                   	pop    %ebp
 1ee:	c3                   	ret
 1ef:	90                   	nop
  for(n = 0; s[n]; n++)
 1f0:	31 c9                	xor    %ecx,%ecx
}
 1f2:	5d                   	pop    %ebp
 1f3:	89 c8                	mov    %ecx,%eax
 1f5:	c3                   	ret
 1f6:	66 90                	xchg   %ax,%ax
 1f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ff:	00 

00000200 <memset>:

void*
memset(void *dst, int c, uint n)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 204:	8b 4d 10             	mov    0x10(%ebp),%ecx
 207:	8b 45 0c             	mov    0xc(%ebp),%eax
 20a:	8b 7d 08             	mov    0x8(%ebp),%edi
 20d:	fc                   	cld
 20e:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 210:	8b 45 08             	mov    0x8(%ebp),%eax
 213:	8b 7d fc             	mov    -0x4(%ebp),%edi
 216:	c9                   	leave
 217:	c3                   	ret
 218:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 21f:	00 

00000220 <strchr>:

char*
strchr(const char *s, char c)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	8b 45 08             	mov    0x8(%ebp),%eax
 226:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 22a:	0f b6 10             	movzbl (%eax),%edx
 22d:	84 d2                	test   %dl,%dl
 22f:	75 1a                	jne    24b <strchr+0x2b>
 231:	eb 25                	jmp    258 <strchr+0x38>
 233:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 238:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 23f:	00 
 240:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 244:	83 c0 01             	add    $0x1,%eax
 247:	84 d2                	test   %dl,%dl
 249:	74 0d                	je     258 <strchr+0x38>
    if(*s == c)
 24b:	38 d1                	cmp    %dl,%cl
 24d:	75 f1                	jne    240 <strchr+0x20>
      return (char*)s;
  return 0;
}
 24f:	5d                   	pop    %ebp
 250:	c3                   	ret
 251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 258:	31 c0                	xor    %eax,%eax
}
 25a:	5d                   	pop    %ebp
 25b:	c3                   	ret
 25c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000260 <gets>:

char*
gets(char *buf, int max)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	57                   	push   %edi
 264:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 265:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 268:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 269:	31 db                	xor    %ebx,%ebx
{
 26b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 26e:	eb 27                	jmp    297 <gets+0x37>
    cc = read(0, &c, 1);
 270:	83 ec 04             	sub    $0x4,%esp
 273:	6a 01                	push   $0x1
 275:	57                   	push   %edi
 276:	6a 00                	push   $0x0
 278:	e8 32 01 00 00       	call   3af <read>
    if(cc < 1)
 27d:	83 c4 10             	add    $0x10,%esp
 280:	85 c0                	test   %eax,%eax
 282:	7e 1d                	jle    2a1 <gets+0x41>
      break;
    buf[i++] = c;
 284:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 288:	8b 55 08             	mov    0x8(%ebp),%edx
 28b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 28f:	3c 0a                	cmp    $0xa,%al
 291:	74 1d                	je     2b0 <gets+0x50>
 293:	3c 0d                	cmp    $0xd,%al
 295:	74 19                	je     2b0 <gets+0x50>
  for(i=0; i+1 < max; ){
 297:	89 de                	mov    %ebx,%esi
 299:	83 c3 01             	add    $0x1,%ebx
 29c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 29f:	7c cf                	jl     270 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 2a1:	8b 45 08             	mov    0x8(%ebp),%eax
 2a4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2ab:	5b                   	pop    %ebx
 2ac:	5e                   	pop    %esi
 2ad:	5f                   	pop    %edi
 2ae:	5d                   	pop    %ebp
 2af:	c3                   	ret
  buf[i] = '\0';
 2b0:	8b 45 08             	mov    0x8(%ebp),%eax
    buf[i++] = c;
 2b3:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 2b5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 2b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2bc:	5b                   	pop    %ebx
 2bd:	5e                   	pop    %esi
 2be:	5f                   	pop    %edi
 2bf:	5d                   	pop    %ebp
 2c0:	c3                   	ret
 2c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2cf:	00 

000002d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d6:	6a 00                	push   $0x0
 2d8:	ff 75 08             	push   0x8(%ebp)
{
 2db:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 2de:	e8 f4 00 00 00       	call   3d7 <open>
  if(fd < 0)
 2e3:	83 c4 10             	add    $0x10,%esp
 2e6:	85 c0                	test   %eax,%eax
 2e8:	78 2e                	js     318 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 2ea:	83 ec 08             	sub    $0x8,%esp
 2ed:	ff 75 0c             	push   0xc(%ebp)
 2f0:	50                   	push   %eax
 2f1:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 2f4:	89 c3                	mov    %eax,%ebx
 2f6:	e8 f4 00 00 00       	call   3ef <fstat>
  close(fd);
 2fb:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2fe:	89 c6                	mov    %eax,%esi
  close(fd);
 300:	e8 ba 00 00 00       	call   3bf <close>
  return r;
 305:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 308:	83 c4 10             	add    $0x10,%esp
}
 30b:	89 f0                	mov    %esi,%eax
 30d:	8b 75 fc             	mov    -0x4(%ebp),%esi
 310:	c9                   	leave
 311:	c3                   	ret
 312:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
 318:	be ff ff ff ff       	mov    $0xffffffff,%esi
 31d:	eb ec                	jmp    30b <stat+0x3b>
 31f:	90                   	nop

00000320 <atoi>:

int
atoi(const char *s)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	53                   	push   %ebx
 324:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 327:	0f be 02             	movsbl (%edx),%eax
 32a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 32d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 330:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 335:	77 1e                	ja     355 <atoi+0x35>
 337:	90                   	nop
 338:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 33f:	00 
    n = n*10 + *s++ - '0';
 340:	83 c2 01             	add    $0x1,%edx
 343:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 346:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 34a:	0f be 02             	movsbl (%edx),%eax
 34d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 350:	80 fb 09             	cmp    $0x9,%bl
 353:	76 eb                	jbe    340 <atoi+0x20>
  return n;
}
 355:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 358:	89 c8                	mov    %ecx,%eax
 35a:	c9                   	leave
 35b:	c3                   	ret
 35c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000360 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	83 ec 08             	sub    $0x8,%esp
 366:	8b 45 10             	mov    0x10(%ebp),%eax
 369:	8b 55 08             	mov    0x8(%ebp),%edx
 36c:	89 75 f8             	mov    %esi,-0x8(%ebp)
 36f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 372:	85 c0                	test   %eax,%eax
 374:	7e 12                	jle    388 <memmove+0x28>
 376:	89 7d fc             	mov    %edi,-0x4(%ebp)
 379:	01 d0                	add    %edx,%eax
  dst = vdst;
 37b:	89 d7                	mov    %edx,%edi
 37d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 380:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 381:	39 f8                	cmp    %edi,%eax
 383:	75 fb                	jne    380 <memmove+0x20>
 385:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return vdst;
}
 388:	8b 75 f8             	mov    -0x8(%ebp),%esi
 38b:	89 d0                	mov    %edx,%eax
 38d:	c9                   	leave
 38e:	c3                   	ret

0000038f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 38f:	b8 01 00 00 00       	mov    $0x1,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret

00000397 <exit>:
SYSCALL(exit)
 397:	b8 02 00 00 00       	mov    $0x2,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret

0000039f <wait>:
SYSCALL(wait)
 39f:	b8 03 00 00 00       	mov    $0x3,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret

000003a7 <pipe>:
SYSCALL(pipe)
 3a7:	b8 04 00 00 00       	mov    $0x4,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret

000003af <read>:
SYSCALL(read)
 3af:	b8 05 00 00 00       	mov    $0x5,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret

000003b7 <write>:
SYSCALL(write)
 3b7:	b8 10 00 00 00       	mov    $0x10,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret

000003bf <close>:
SYSCALL(close)
 3bf:	b8 15 00 00 00       	mov    $0x15,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret

000003c7 <kill>:
SYSCALL(kill)
 3c7:	b8 06 00 00 00       	mov    $0x6,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret

000003cf <exec>:
SYSCALL(exec)
 3cf:	b8 07 00 00 00       	mov    $0x7,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret

000003d7 <open>:
SYSCALL(open)
 3d7:	b8 0f 00 00 00       	mov    $0xf,%eax
 3dc:	cd 40                	int    $0x40
 3de:	c3                   	ret

000003df <mknod>:
SYSCALL(mknod)
 3df:	b8 11 00 00 00       	mov    $0x11,%eax
 3e4:	cd 40                	int    $0x40
 3e6:	c3                   	ret

000003e7 <unlink>:
SYSCALL(unlink)
 3e7:	b8 12 00 00 00       	mov    $0x12,%eax
 3ec:	cd 40                	int    $0x40
 3ee:	c3                   	ret

000003ef <fstat>:
SYSCALL(fstat)
 3ef:	b8 08 00 00 00       	mov    $0x8,%eax
 3f4:	cd 40                	int    $0x40
 3f6:	c3                   	ret

000003f7 <link>:
SYSCALL(link)
 3f7:	b8 13 00 00 00       	mov    $0x13,%eax
 3fc:	cd 40                	int    $0x40
 3fe:	c3                   	ret

000003ff <mkdir>:
SYSCALL(mkdir)
 3ff:	b8 14 00 00 00       	mov    $0x14,%eax
 404:	cd 40                	int    $0x40
 406:	c3                   	ret

00000407 <chdir>:
SYSCALL(chdir)
 407:	b8 09 00 00 00       	mov    $0x9,%eax
 40c:	cd 40                	int    $0x40
 40e:	c3                   	ret

0000040f <dup>:
SYSCALL(dup)
 40f:	b8 0a 00 00 00       	mov    $0xa,%eax
 414:	cd 40                	int    $0x40
 416:	c3                   	ret

00000417 <getpid>:
SYSCALL(getpid)
 417:	b8 0b 00 00 00       	mov    $0xb,%eax
 41c:	cd 40                	int    $0x40
 41e:	c3                   	ret

0000041f <sbrk>:
SYSCALL(sbrk)
 41f:	b8 0c 00 00 00       	mov    $0xc,%eax
 424:	cd 40                	int    $0x40
 426:	c3                   	ret

00000427 <sleep>:
SYSCALL(sleep)
 427:	b8 0d 00 00 00       	mov    $0xd,%eax
 42c:	cd 40                	int    $0x40
 42e:	c3                   	ret

0000042f <uptime>:
SYSCALL(uptime)
 42f:	b8 0e 00 00 00       	mov    $0xe,%eax
 434:	cd 40                	int    $0x40
 436:	c3                   	ret

00000437 <freepages>:
SYSCALL(freepages)
 437:	b8 16 00 00 00       	mov    $0x16,%eax
 43c:	cd 40                	int    $0x40
 43e:	c3                   	ret

0000043f <va2pa>:
SYSCALL(va2pa)
 43f:	b8 17 00 00 00       	mov    $0x17,%eax
 444:	cd 40                	int    $0x40
 446:	c3                   	ret
 447:	66 90                	xchg   %ax,%ax
 449:	66 90                	xchg   %ax,%ax
 44b:	66 90                	xchg   %ax,%ax
 44d:	66 90                	xchg   %ax,%ax
 44f:	66 90                	xchg   %ax,%ax
 451:	66 90                	xchg   %ax,%ax
 453:	66 90                	xchg   %ax,%ax
 455:	66 90                	xchg   %ax,%ax
 457:	66 90                	xchg   %ax,%ax
 459:	66 90                	xchg   %ax,%ax
 45b:	66 90                	xchg   %ax,%ax
 45d:	66 90                	xchg   %ax,%ax
 45f:	90                   	nop

00000460 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
 465:	53                   	push   %ebx
 466:	89 cb                	mov    %ecx,%ebx
 468:	83 ec 3c             	sub    $0x3c,%esp
 46b:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 46e:	85 d2                	test   %edx,%edx
 470:	0f 89 9a 00 00 00    	jns    510 <printint+0xb0>
 476:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 47a:	0f 84 90 00 00 00    	je     510 <printint+0xb0>
    neg = 1;
    x = -xx;
 480:	f7 da                	neg    %edx
    neg = 1;
 482:	b8 01 00 00 00       	mov    $0x1,%eax
 487:	89 45 c0             	mov    %eax,-0x40(%ebp)
 48a:	89 d1                	mov    %edx,%ecx
  } else {
    x = xx;
  }

  i = 0;
 48c:	31 f6                	xor    %esi,%esi
 48e:	66 90                	xchg   %ax,%ax
 490:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 497:	00 
 498:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 49f:	00 
  do{
    buf[i++] = digits[x % base];
 4a0:	89 c8                	mov    %ecx,%eax
 4a2:	31 d2                	xor    %edx,%edx
 4a4:	89 f7                	mov    %esi,%edi
 4a6:	f7 f3                	div    %ebx
 4a8:	8d 76 01             	lea    0x1(%esi),%esi
  }while((x /= base) != 0);
 4ab:	39 d9                	cmp    %ebx,%ecx
    buf[i++] = digits[x % base];
 4ad:	0f b6 92 4c 09 00 00 	movzbl 0x94c(%edx),%edx
  }while((x /= base) != 0);
 4b4:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
 4b6:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 4ba:	73 e4                	jae    4a0 <printint+0x40>
  if(neg)
 4bc:	8b 45 c0             	mov    -0x40(%ebp),%eax
 4bf:	85 c0                	test   %eax,%eax
 4c1:	74 07                	je     4ca <printint+0x6a>
    buf[i++] = '-';
 4c3:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 4c8:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 4ca:	8d 74 3d d8          	lea    -0x28(%ebp,%edi,1),%esi
 4ce:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 4d1:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 4d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4df:	00 
    putc(fd, buf[i]);
 4e0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 4e3:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 4e6:	83 ee 01             	sub    $0x1,%esi
 4e9:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 4ec:	8d 45 d7             	lea    -0x29(%ebp),%eax
 4ef:	6a 01                	push   $0x1
 4f1:	50                   	push   %eax
 4f2:	57                   	push   %edi
 4f3:	e8 bf fe ff ff       	call   3b7 <write>
  while(--i >= 0)
 4f8:	83 c4 10             	add    $0x10,%esp
 4fb:	39 f3                	cmp    %esi,%ebx
 4fd:	75 e1                	jne    4e0 <printint+0x80>
}
 4ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
 502:	5b                   	pop    %ebx
 503:	5e                   	pop    %esi
 504:	5f                   	pop    %edi
 505:	5d                   	pop    %ebp
 506:	c3                   	ret
 507:	90                   	nop
 508:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 50f:	00 
  neg = 0;
 510:	31 c0                	xor    %eax,%eax
 512:	e9 70 ff ff ff       	jmp    487 <printint+0x27>
 517:	90                   	nop
 518:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 51f:	00 

00000520 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	83 ec 38             	sub    $0x38,%esp
 526:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 529:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 52c:	89 75 f8             	mov    %esi,-0x8(%ebp)
 52f:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 532:	0f b6 03             	movzbl (%ebx),%eax
 535:	84 c0                	test   %al,%al
 537:	0f 84 b6 00 00 00    	je     5f3 <printf+0xd3>
  ap = (uint*)(void*)&fmt + 1;
 53d:	8d 4d 10             	lea    0x10(%ebp),%ecx
 540:	89 7d fc             	mov    %edi,-0x4(%ebp)
 543:	83 c3 01             	add    $0x1,%ebx
 546:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 549:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 54c:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
 54f:	eb 2a                	jmp    57b <printf+0x5b>
 551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 558:	83 ec 04             	sub    $0x4,%esp
 55b:	88 45 e7             	mov    %al,-0x19(%ebp)
 55e:	8d 45 e7             	lea    -0x19(%ebp),%eax
  for(i = 0; fmt[i]; i++){
 561:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 564:	6a 01                	push   $0x1
 566:	50                   	push   %eax
 567:	56                   	push   %esi
 568:	e8 4a fe ff ff       	call   3b7 <write>
  for(i = 0; fmt[i]; i++){
 56d:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
 571:	83 c4 10             	add    $0x10,%esp
 574:	84 c0                	test   %al,%al
 576:	74 78                	je     5f0 <printf+0xd0>
    c = fmt[i] & 0xff;
 578:	0f b6 d0             	movzbl %al,%edx
      if(c == '%'){
 57b:	83 fa 25             	cmp    $0x25,%edx
 57e:	75 d8                	jne    558 <printf+0x38>
  for(i = 0; fmt[i]; i++){
 580:	0f b6 13             	movzbl (%ebx),%edx
 583:	84 d2                	test   %dl,%dl
 585:	74 69                	je     5f0 <printf+0xd0>
    c = fmt[i] & 0xff;
 587:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 58a:	80 fa 25             	cmp    $0x25,%dl
 58d:	0f 84 25 01 00 00    	je     6b8 <printf+0x198>
 593:	83 e8 63             	sub    $0x63,%eax
 596:	83 f8 15             	cmp    $0x15,%eax
 599:	77 0d                	ja     5a8 <printf+0x88>
 59b:	ff 24 85 f4 08 00 00 	jmp    *0x8f4(,%eax,4)
 5a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5a8:	83 ec 04             	sub    $0x4,%esp
 5ab:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 5ae:	88 55 d0             	mov    %dl,-0x30(%ebp)
 5b1:	6a 01                	push   $0x1
 5b3:	51                   	push   %ecx
 5b4:	56                   	push   %esi
 5b5:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 5b8:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5bc:	e8 f6 fd ff ff       	call   3b7 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5c1:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 5c5:	83 c4 0c             	add    $0xc,%esp
 5c8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 5cb:	6a 01                	push   $0x1
 5cd:	88 55 e7             	mov    %dl,-0x19(%ebp)
 5d0:	51                   	push   %ecx
  for(i = 0; fmt[i]; i++){
 5d1:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 5d4:	56                   	push   %esi
 5d5:	e8 dd fd ff ff       	call   3b7 <write>
  for(i = 0; fmt[i]; i++){
 5da:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
 5de:	83 c4 10             	add    $0x10,%esp
 5e1:	84 c0                	test   %al,%al
 5e3:	75 93                	jne    578 <printf+0x58>
 5e5:	8d 76 00             	lea    0x0(%esi),%esi
 5e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 5ef:	00 
 5f0:	8b 7d fc             	mov    -0x4(%ebp),%edi
      }
      state = 0;
    }
  }
}
 5f3:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 5f6:	8b 75 f8             	mov    -0x8(%ebp),%esi
 5f9:	c9                   	leave
 5fa:	c3                   	ret
 5fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 16, 0);
 600:	83 ec 0c             	sub    $0xc,%esp
 603:	8b 17                	mov    (%edi),%edx
 605:	b9 10 00 00 00       	mov    $0x10,%ecx
 60a:	89 f0                	mov    %esi,%eax
 60c:	6a 00                	push   $0x0
 60e:	e8 4d fe ff ff       	call   460 <printint>
  for(i = 0; fmt[i]; i++){
 613:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 617:	83 c3 02             	add    $0x2,%ebx
 61a:	83 c4 10             	add    $0x10,%esp
 61d:	84 c0                	test   %al,%al
 61f:	74 cf                	je     5f0 <printf+0xd0>
        ap++;
 621:	83 c7 04             	add    $0x4,%edi
 624:	e9 4f ff ff ff       	jmp    578 <printf+0x58>
 629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 630:	83 ec 0c             	sub    $0xc,%esp
 633:	8b 17                	mov    (%edi),%edx
 635:	b9 0a 00 00 00       	mov    $0xa,%ecx
 63a:	89 f0                	mov    %esi,%eax
 63c:	6a 01                	push   $0x1
 63e:	e8 1d fe ff ff       	call   460 <printint>
  for(i = 0; fmt[i]; i++){
 643:	eb ce                	jmp    613 <printf+0xf3>
 645:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 648:	83 ec 04             	sub    $0x4,%esp
 64b:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        putc(fd, *ap);
 64e:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 650:	6a 01                	push   $0x1
 652:	51                   	push   %ecx
 653:	56                   	push   %esi
        putc(fd, *ap);
 654:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 657:	e8 5b fd ff ff       	call   3b7 <write>
 65c:	eb b5                	jmp    613 <printf+0xf3>
 65e:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
 660:	8b 07                	mov    (%edi),%eax
        ap++;
 662:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 665:	85 c0                	test   %eax,%eax
 667:	74 67                	je     6d0 <printf+0x1b0>
        while(*s != 0){
 669:	0f b6 10             	movzbl (%eax),%edx
 66c:	84 d2                	test   %dl,%dl
 66e:	74 6f                	je     6df <printf+0x1bf>
 670:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 673:	89 c7                	mov    %eax,%edi
 675:	89 d0                	mov    %edx,%eax
 677:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 67a:	89 fb                	mov    %edi,%ebx
 67c:	8d 7d e7             	lea    -0x19(%ebp),%edi
 67f:	90                   	nop
  write(fd, &c, 1);
 680:	83 ec 04             	sub    $0x4,%esp
          s++;
 683:	83 c3 01             	add    $0x1,%ebx
 686:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 689:	6a 01                	push   $0x1
 68b:	57                   	push   %edi
 68c:	56                   	push   %esi
 68d:	e8 25 fd ff ff       	call   3b7 <write>
        while(*s != 0){
 692:	0f b6 03             	movzbl (%ebx),%eax
 695:	83 c4 10             	add    $0x10,%esp
 698:	84 c0                	test   %al,%al
 69a:	75 e4                	jne    680 <printf+0x160>
 69c:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 69f:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 6a3:	83 c3 02             	add    $0x2,%ebx
 6a6:	84 c0                	test   %al,%al
 6a8:	0f 85 9b fe ff ff    	jne    549 <printf+0x29>
 6ae:	e9 3d ff ff ff       	jmp    5f0 <printf+0xd0>
 6b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 6b8:	83 ec 04             	sub    $0x4,%esp
 6bb:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 6bf:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 6c2:	6a 01                	push   $0x1
 6c4:	e9 07 ff ff ff       	jmp    5d0 <printf+0xb0>
 6c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 6d0:	89 7d d4             	mov    %edi,-0x2c(%ebp)
        if(s == 0)
 6d3:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 6d8:	bf eb 08 00 00       	mov    $0x8eb,%edi
 6dd:	eb 98                	jmp    677 <printf+0x157>
  for(i = 0; fmt[i]; i++){
 6df:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 6e3:	83 c3 02             	add    $0x2,%ebx
 6e6:	84 c0                	test   %al,%al
 6e8:	0f 85 8a fe ff ff    	jne    578 <printf+0x58>
 6ee:	e9 fd fe ff ff       	jmp    5f0 <printf+0xd0>
 6f3:	66 90                	xchg   %ax,%ax
 6f5:	66 90                	xchg   %ax,%ax
 6f7:	66 90                	xchg   %ax,%ax
 6f9:	66 90                	xchg   %ax,%ax
 6fb:	66 90                	xchg   %ax,%ax
 6fd:	66 90                	xchg   %ax,%ax
 6ff:	90                   	nop

00000700 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 700:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 701:	a1 60 09 00 00       	mov    0x960,%eax
{
 706:	89 e5                	mov    %esp,%ebp
 708:	57                   	push   %edi
 709:	56                   	push   %esi
 70a:	53                   	push   %ebx
 70b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 70e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 718:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 71f:	00 
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 720:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 722:	39 c8                	cmp    %ecx,%eax
 724:	73 32                	jae    758 <free+0x58>
 726:	39 d1                	cmp    %edx,%ecx
 728:	72 04                	jb     72e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 72a:	39 d0                	cmp    %edx,%eax
 72c:	72 32                	jb     760 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 72e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 731:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 734:	39 fa                	cmp    %edi,%edx
 736:	74 30                	je     768 <free+0x68>
 738:	89 53 f8             	mov    %edx,-0x8(%ebx)
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 73b:	8b 50 04             	mov    0x4(%eax),%edx
 73e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 741:	39 f1                	cmp    %esi,%ecx
 743:	74 3a                	je     77f <free+0x7f>
 745:	89 08                	mov    %ecx,(%eax)
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 747:	5b                   	pop    %ebx
  freep = p;
 748:	a3 60 09 00 00       	mov    %eax,0x960
}
 74d:	5e                   	pop    %esi
 74e:	5f                   	pop    %edi
 74f:	5d                   	pop    %ebp
 750:	c3                   	ret
 751:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 758:	39 d0                	cmp    %edx,%eax
 75a:	72 04                	jb     760 <free+0x60>
 75c:	39 d1                	cmp    %edx,%ecx
 75e:	72 ce                	jb     72e <free+0x2e>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 760:	89 d0                	mov    %edx,%eax
 762:	eb bc                	jmp    720 <free+0x20>
 764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 768:	03 72 04             	add    0x4(%edx),%esi
 76b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 76e:	8b 10                	mov    (%eax),%edx
 770:	8b 12                	mov    (%edx),%edx
 772:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 775:	8b 50 04             	mov    0x4(%eax),%edx
 778:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 77b:	39 f1                	cmp    %esi,%ecx
 77d:	75 c6                	jne    745 <free+0x45>
    p->s.size += bp->s.size;
 77f:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 782:	a3 60 09 00 00       	mov    %eax,0x960
    p->s.size += bp->s.size;
 787:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 78a:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 78d:	89 08                	mov    %ecx,(%eax)
}
 78f:	5b                   	pop    %ebx
 790:	5e                   	pop    %esi
 791:	5f                   	pop    %edi
 792:	5d                   	pop    %ebp
 793:	c3                   	ret
 794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 798:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 79f:	00 

000007a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7a0:	55                   	push   %ebp
 7a1:	89 e5                	mov    %esp,%ebp
 7a3:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a6:	8b 45 08             	mov    0x8(%ebp),%eax
{
 7a9:	89 7d fc             	mov    %edi,-0x4(%ebp)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7ac:	8d 78 07             	lea    0x7(%eax),%edi
  if((prevp = freep) == 0){
 7af:	a1 60 09 00 00       	mov    0x960,%eax
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7b4:	c1 ef 03             	shr    $0x3,%edi
 7b7:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 7ba:	85 c0                	test   %eax,%eax
 7bc:	0f 84 c6 00 00 00    	je     888 <malloc+0xe8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c2:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 7c4:	8b 4a 04             	mov    0x4(%edx),%ecx
 7c7:	39 f9                	cmp    %edi,%ecx
 7c9:	0f 83 87 00 00 00    	jae    856 <malloc+0xb6>
 7cf:	89 5d f4             	mov    %ebx,-0xc(%ebp)
 7d2:	89 75 f8             	mov    %esi,-0x8(%ebp)
  if(nu < 4096)
 7d5:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7da:	39 df                	cmp    %ebx,%edi
 7dc:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7df:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7e6:	eb 21                	jmp    809 <malloc+0x69>
 7e8:	eb 16                	jmp    800 <malloc+0x60>
 7ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7f0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7f7:	00 
 7f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7ff:	00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 800:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 802:	8b 4a 04             	mov    0x4(%edx),%ecx
 805:	39 f9                	cmp    %edi,%ecx
 807:	73 47                	jae    850 <malloc+0xb0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 809:	89 d0                	mov    %edx,%eax
 80b:	39 15 60 09 00 00    	cmp    %edx,0x960
 811:	75 ed                	jne    800 <malloc+0x60>
  p = sbrk(nu * sizeof(Header));
 813:	83 ec 0c             	sub    $0xc,%esp
 816:	56                   	push   %esi
 817:	e8 03 fc ff ff       	call   41f <sbrk>
  if(p == (char*)-1)
 81c:	83 c4 10             	add    $0x10,%esp
 81f:	83 f8 ff             	cmp    $0xffffffff,%eax
 822:	74 54                	je     878 <malloc+0xd8>
  hp->s.size = nu;
 824:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 827:	83 ec 0c             	sub    $0xc,%esp
 82a:	83 c0 08             	add    $0x8,%eax
 82d:	50                   	push   %eax
 82e:	e8 cd fe ff ff       	call   700 <free>
  return freep;
 833:	a1 60 09 00 00       	mov    0x960,%eax
      if((p = morecore(nunits)) == 0)
 838:	83 c4 10             	add    $0x10,%esp
 83b:	85 c0                	test   %eax,%eax
 83d:	75 c1                	jne    800 <malloc+0x60>
 83f:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 842:	8b 75 f8             	mov    -0x8(%ebp),%esi
 845:	eb 26                	jmp    86d <malloc+0xcd>
 847:	90                   	nop
 848:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 84f:	00 
 850:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 853:	8b 75 f8             	mov    -0x8(%ebp),%esi
      if(p->s.size == nunits)
 856:	39 cf                	cmp    %ecx,%edi
 858:	74 66                	je     8c0 <malloc+0x120>
        p->s.size -= nunits;
 85a:	29 f9                	sub    %edi,%ecx
 85c:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 85f:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 862:	89 7a 04             	mov    %edi,0x4(%edx)
      freep = prevp;
 865:	a3 60 09 00 00       	mov    %eax,0x960
      return (void*)(p + 1);
 86a:	8d 42 08             	lea    0x8(%edx),%eax
        return 0;
  }
}
 86d:	8b 7d fc             	mov    -0x4(%ebp),%edi
 870:	c9                   	leave
 871:	c3                   	ret
 872:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return 0;
 878:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 87b:	8b 75 f8             	mov    -0x8(%ebp),%esi
 87e:	31 c0                	xor    %eax,%eax
}
 880:	8b 7d fc             	mov    -0x4(%ebp),%edi
 883:	c9                   	leave
 884:	c3                   	ret
 885:	8d 76 00             	lea    0x0(%esi),%esi
 888:	89 5d f4             	mov    %ebx,-0xc(%ebp)
    base.s.size = 0;
 88b:	ba 64 09 00 00       	mov    $0x964,%edx
 890:	89 75 f8             	mov    %esi,-0x8(%ebp)
    base.s.ptr = freep = prevp = &base;
 893:	c7 05 60 09 00 00 64 	movl   $0x964,0x960
 89a:	09 00 00 
 89d:	c7 05 64 09 00 00 64 	movl   $0x964,0x964
 8a4:	09 00 00 
    base.s.size = 0;
 8a7:	c7 05 68 09 00 00 00 	movl   $0x0,0x968
 8ae:	00 00 00 
    if(p->s.size >= nunits){
 8b1:	e9 1f ff ff ff       	jmp    7d5 <malloc+0x35>
 8b6:	66 90                	xchg   %ax,%ax
 8b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8bf:	00 
        prevp->s.ptr = p->s.ptr;
 8c0:	8b 0a                	mov    (%edx),%ecx
 8c2:	89 08                	mov    %ecx,(%eax)
 8c4:	eb 9f                	jmp    865 <malloc+0xc5>
