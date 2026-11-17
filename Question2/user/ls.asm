
user/_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  close(fd);
}

int
main(int argc, char *argv[])
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
  21:	7e 27                	jle    4a <main+0x4a>
  23:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  2f:	00 
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  30:	83 ec 0c             	sub    $0xc,%esp
  33:	ff 34 9f             	push   (%edi,%ebx,4)
  for(i=1; i<argc; i++)
  36:	83 c3 01             	add    $0x1,%ebx
    ls(argv[i]);
  39:	e8 c2 00 00 00       	call   100 <ls>
  for(i=1; i<argc; i++)
  3e:	83 c4 10             	add    $0x10,%esp
  41:	39 de                	cmp    %ebx,%esi
  43:	75 eb                	jne    30 <main+0x30>
  exit();
  45:	e8 6d 05 00 00       	call   5b7 <exit>
    ls(".");
  4a:	83 ec 0c             	sub    $0xc,%esp
  4d:	68 30 0b 00 00       	push   $0xb30
  52:	e8 a9 00 00 00       	call   100 <ls>
    exit();
  57:	e8 5b 05 00 00       	call   5b7 <exit>
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <fmtname>:
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	56                   	push   %esi
  64:	53                   	push   %ebx
  65:	8b 75 08             	mov    0x8(%ebp),%esi
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  68:	83 ec 0c             	sub    $0xc,%esp
  6b:	56                   	push   %esi
  6c:	e8 7f 03 00 00       	call   3f0 <strlen>
  71:	83 c4 10             	add    $0x10,%esp
  74:	01 f0                	add    %esi,%eax
  76:	89 c3                	mov    %eax,%ebx
  78:	73 0f                	jae    89 <fmtname+0x29>
  7a:	eb 12                	jmp    8e <fmtname+0x2e>
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  80:	8d 43 ff             	lea    -0x1(%ebx),%eax
  83:	39 f0                	cmp    %esi,%eax
  85:	72 0a                	jb     91 <fmtname+0x31>
  87:	89 c3                	mov    %eax,%ebx
  89:	80 3b 2f             	cmpb   $0x2f,(%ebx)
  8c:	75 f2                	jne    80 <fmtname+0x20>
  p++;
  8e:	83 c3 01             	add    $0x1,%ebx
  if(strlen(p) >= DIRSIZ)
  91:	83 ec 0c             	sub    $0xc,%esp
  94:	53                   	push   %ebx
  95:	e8 56 03 00 00       	call   3f0 <strlen>
  9a:	83 c4 10             	add    $0x10,%esp
  9d:	83 f8 0d             	cmp    $0xd,%eax
  a0:	77 4a                	ja     ec <fmtname+0x8c>
  memmove(buf, p, strlen(p));
  a2:	83 ec 0c             	sub    $0xc,%esp
  a5:	53                   	push   %ebx
  a6:	e8 45 03 00 00       	call   3f0 <strlen>
  ab:	83 c4 0c             	add    $0xc,%esp
  ae:	50                   	push   %eax
  af:	53                   	push   %ebx
  b0:	68 a8 0b 00 00       	push   $0xba8
  b5:	e8 c6 04 00 00       	call   580 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  ba:	89 1c 24             	mov    %ebx,(%esp)
  bd:	e8 2e 03 00 00       	call   3f0 <strlen>
  c2:	89 1c 24             	mov    %ebx,(%esp)
  return buf;
  c5:	bb a8 0b 00 00       	mov    $0xba8,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  ca:	89 c6                	mov    %eax,%esi
  cc:	e8 1f 03 00 00       	call   3f0 <strlen>
  d1:	ba 0e 00 00 00       	mov    $0xe,%edx
  d6:	83 c4 0c             	add    $0xc,%esp
  d9:	29 f2                	sub    %esi,%edx
  db:	05 a8 0b 00 00       	add    $0xba8,%eax
  e0:	52                   	push   %edx
  e1:	6a 20                	push   $0x20
  e3:	50                   	push   %eax
  e4:	e8 37 03 00 00       	call   420 <memset>
  return buf;
  e9:	83 c4 10             	add    $0x10,%esp
}
  ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
  ef:	89 d8                	mov    %ebx,%eax
  f1:	5b                   	pop    %ebx
  f2:	5e                   	pop    %esi
  f3:	5d                   	pop    %ebp
  f4:	c3                   	ret
  f5:	8d 76 00             	lea    0x0(%esi),%esi
  f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ff:	00 

00000100 <ls>:
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	81 ec 70 02 00 00    	sub    $0x270,%esp
 109:	89 7d fc             	mov    %edi,-0x4(%ebp)
 10c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((fd = open(path, 0)) < 0){
 10f:	6a 00                	push   $0x0
 111:	57                   	push   %edi
 112:	e8 e0 04 00 00       	call   5f7 <open>
 117:	83 c4 10             	add    $0x10,%esp
 11a:	85 c0                	test   %eax,%eax
 11c:	0f 88 9e 01 00 00    	js     2c0 <ls+0x1c0>
  if(fstat(fd, &st) < 0){
 122:	83 ec 08             	sub    $0x8,%esp
 125:	89 75 f8             	mov    %esi,-0x8(%ebp)
 128:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 12e:	56                   	push   %esi
 12f:	50                   	push   %eax
 130:	89 5d f4             	mov    %ebx,-0xc(%ebp)
 133:	89 c3                	mov    %eax,%ebx
 135:	e8 d5 04 00 00       	call   60f <fstat>
 13a:	83 c4 10             	add    $0x10,%esp
 13d:	85 c0                	test   %eax,%eax
 13f:	0f 88 bb 01 00 00    	js     300 <ls+0x200>
  switch(st.type){
 145:	0f b7 85 d4 fd ff ff 	movzwl -0x22c(%ebp),%eax
 14c:	66 83 f8 01          	cmp    $0x1,%ax
 150:	74 5e                	je     1b0 <ls+0xb0>
 152:	66 83 f8 02          	cmp    $0x2,%ax
 156:	75 37                	jne    18f <ls+0x8f>
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 158:	83 ec 0c             	sub    $0xc,%esp
 15b:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 161:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
 167:	57                   	push   %edi
 168:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 16e:	e8 ed fe ff ff       	call   60 <fmtname>
 173:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 179:	59                   	pop    %ecx
 17a:	5f                   	pop    %edi
 17b:	52                   	push   %edx
 17c:	56                   	push   %esi
 17d:	6a 02                	push   $0x2
 17f:	50                   	push   %eax
 180:	68 10 0b 00 00       	push   $0xb10
 185:	6a 01                	push   $0x1
 187:	e8 b4 05 00 00       	call   740 <printf>
    break;
 18c:	83 c4 20             	add    $0x20,%esp
  close(fd);
 18f:	83 ec 0c             	sub    $0xc,%esp
 192:	53                   	push   %ebx
 193:	e8 47 04 00 00       	call   5df <close>
 198:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 19b:	8b 75 f8             	mov    -0x8(%ebp),%esi
 19e:	83 c4 10             	add    $0x10,%esp
}
 1a1:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1a4:	c9                   	leave
 1a5:	c3                   	ret
 1a6:	66 90                	xchg   %ax,%ax
 1a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1af:	00 
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1b0:	83 ec 0c             	sub    $0xc,%esp
 1b3:	57                   	push   %edi
 1b4:	e8 37 02 00 00       	call   3f0 <strlen>
 1b9:	83 c4 10             	add    $0x10,%esp
 1bc:	83 c0 10             	add    $0x10,%eax
 1bf:	3d 00 02 00 00       	cmp    $0x200,%eax
 1c4:	0f 87 16 01 00 00    	ja     2e0 <ls+0x1e0>
    strcpy(buf, path);
 1ca:	83 ec 08             	sub    $0x8,%esp
 1cd:	57                   	push   %edi
 1ce:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
 1d4:	57                   	push   %edi
 1d5:	e8 86 01 00 00       	call   360 <strcpy>
    p = buf+strlen(buf);
 1da:	89 3c 24             	mov    %edi,(%esp)
 1dd:	e8 0e 02 00 00       	call   3f0 <strlen>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1e2:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 1e5:	01 f8                	add    %edi,%eax
    *p++ = '/';
 1e7:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 1ea:	89 85 a8 fd ff ff    	mov    %eax,-0x258(%ebp)
    *p++ = '/';
 1f0:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 1f6:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 200:	83 ec 04             	sub    $0x4,%esp
 203:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 209:	6a 10                	push   $0x10
 20b:	50                   	push   %eax
 20c:	53                   	push   %ebx
 20d:	e8 bd 03 00 00       	call   5cf <read>
 212:	83 c4 10             	add    $0x10,%esp
 215:	83 f8 10             	cmp    $0x10,%eax
 218:	0f 85 71 ff ff ff    	jne    18f <ls+0x8f>
      if(de.inum == 0)
 21e:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 225:	00 
 226:	74 d8                	je     200 <ls+0x100>
      memmove(p, de.name, DIRSIZ);
 228:	83 ec 04             	sub    $0x4,%esp
 22b:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 231:	6a 0e                	push   $0xe
 233:	50                   	push   %eax
 234:	ff b5 a4 fd ff ff    	push   -0x25c(%ebp)
 23a:	e8 41 03 00 00       	call   580 <memmove>
      p[DIRSIZ] = 0;
 23f:	8b 85 a8 fd ff ff    	mov    -0x258(%ebp),%eax
 245:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 249:	58                   	pop    %eax
 24a:	5a                   	pop    %edx
 24b:	56                   	push   %esi
 24c:	57                   	push   %edi
 24d:	e8 9e 02 00 00       	call   4f0 <stat>
 252:	83 c4 10             	add    $0x10,%esp
 255:	85 c0                	test   %eax,%eax
 257:	0f 88 d3 00 00 00    	js     330 <ls+0x230>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 25d:	83 ec 0c             	sub    $0xc,%esp
 260:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 266:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 26c:	57                   	push   %edi
 26d:	0f bf 85 d4 fd ff ff 	movswl -0x22c(%ebp),%eax
 274:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
 27a:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 280:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
 286:	e8 d5 fd ff ff       	call   60 <fmtname>
 28b:	5a                   	pop    %edx
 28c:	8b 95 b0 fd ff ff    	mov    -0x250(%ebp),%edx
 292:	59                   	pop    %ecx
 293:	8b 8d ac fd ff ff    	mov    -0x254(%ebp),%ecx
 299:	51                   	push   %ecx
 29a:	52                   	push   %edx
 29b:	ff b5 b4 fd ff ff    	push   -0x24c(%ebp)
 2a1:	50                   	push   %eax
 2a2:	68 10 0b 00 00       	push   $0xb10
 2a7:	6a 01                	push   $0x1
 2a9:	e8 92 04 00 00       	call   740 <printf>
 2ae:	83 c4 20             	add    $0x20,%esp
 2b1:	e9 4a ff ff ff       	jmp    200 <ls+0x100>
 2b6:	66 90                	xchg   %ax,%ax
 2b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2bf:	00 
    printf(2, "ls: cannot open %s\n", path);
 2c0:	83 ec 04             	sub    $0x4,%esp
 2c3:	57                   	push   %edi
 2c4:	68 e8 0a 00 00       	push   $0xae8
 2c9:	6a 02                	push   $0x2
 2cb:	e8 70 04 00 00       	call   740 <printf>
}
 2d0:	8b 7d fc             	mov    -0x4(%ebp),%edi
    return;
 2d3:	83 c4 10             	add    $0x10,%esp
}
 2d6:	c9                   	leave
 2d7:	c3                   	ret
 2d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2df:	00 
      printf(1, "ls: path too long\n");
 2e0:	83 ec 08             	sub    $0x8,%esp
 2e3:	68 1d 0b 00 00       	push   $0xb1d
 2e8:	6a 01                	push   $0x1
 2ea:	e8 51 04 00 00       	call   740 <printf>
      break;
 2ef:	83 c4 10             	add    $0x10,%esp
 2f2:	e9 98 fe ff ff       	jmp    18f <ls+0x8f>
 2f7:	90                   	nop
 2f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ff:	00 
    printf(2, "ls: cannot stat %s\n", path);
 300:	83 ec 04             	sub    $0x4,%esp
 303:	57                   	push   %edi
 304:	68 fc 0a 00 00       	push   $0xafc
 309:	6a 02                	push   $0x2
 30b:	e8 30 04 00 00       	call   740 <printf>
    close(fd);
 310:	89 1c 24             	mov    %ebx,(%esp)
 313:	e8 c7 02 00 00       	call   5df <close>
    return;
 318:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 31b:	8b 75 f8             	mov    -0x8(%ebp),%esi
 31e:	83 c4 10             	add    $0x10,%esp
}
 321:	8b 7d fc             	mov    -0x4(%ebp),%edi
 324:	c9                   	leave
 325:	c3                   	ret
 326:	66 90                	xchg   %ax,%ax
 328:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 32f:	00 
        printf(1, "ls: cannot stat %s\n", buf);
 330:	83 ec 04             	sub    $0x4,%esp
 333:	57                   	push   %edi
 334:	68 fc 0a 00 00       	push   $0xafc
 339:	6a 01                	push   $0x1
 33b:	e8 00 04 00 00       	call   740 <printf>
        continue;
 340:	83 c4 10             	add    $0x10,%esp
 343:	e9 b8 fe ff ff       	jmp    200 <ls+0x100>
 348:	66 90                	xchg   %ax,%ax
 34a:	66 90                	xchg   %ax,%ax
 34c:	66 90                	xchg   %ax,%ax
 34e:	66 90                	xchg   %ax,%ax
 350:	66 90                	xchg   %ax,%ax
 352:	66 90                	xchg   %ax,%ax
 354:	66 90                	xchg   %ax,%ax
 356:	66 90                	xchg   %ax,%ax
 358:	66 90                	xchg   %ax,%ax
 35a:	66 90                	xchg   %ax,%ax
 35c:	66 90                	xchg   %ax,%ax
 35e:	66 90                	xchg   %ax,%ax

00000360 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 360:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 361:	31 c0                	xor    %eax,%eax
{
 363:	89 e5                	mov    %esp,%ebp
 365:	53                   	push   %ebx
 366:	8b 4d 08             	mov    0x8(%ebp),%ecx
 369:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 36c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 370:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 374:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 377:	83 c0 01             	add    $0x1,%eax
 37a:	84 d2                	test   %dl,%dl
 37c:	75 f2                	jne    370 <strcpy+0x10>
    ;
  return os;
}
 37e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 381:	89 c8                	mov    %ecx,%eax
 383:	c9                   	leave
 384:	c3                   	ret
 385:	8d 76 00             	lea    0x0(%esi),%esi
 388:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 38f:	00 

00000390 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	53                   	push   %ebx
 394:	8b 55 08             	mov    0x8(%ebp),%edx
 397:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 39a:	0f b6 02             	movzbl (%edx),%eax
 39d:	84 c0                	test   %al,%al
 39f:	75 2d                	jne    3ce <strcmp+0x3e>
 3a1:	eb 3d                	jmp    3e0 <strcmp+0x50>
 3a3:	eb 1b                	jmp    3c0 <strcmp+0x30>
 3a5:	8d 76 00             	lea    0x0(%esi),%esi
 3a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3af:	00 
 3b0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3b7:	00 
 3b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3bf:	00 
 3c0:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 3c4:	83 c2 01             	add    $0x1,%edx
 3c7:	83 c1 01             	add    $0x1,%ecx
  while(*p && *p == *q)
 3ca:	84 c0                	test   %al,%al
 3cc:	74 12                	je     3e0 <strcmp+0x50>
 3ce:	0f b6 19             	movzbl (%ecx),%ebx
 3d1:	38 c3                	cmp    %al,%bl
 3d3:	74 eb                	je     3c0 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 3d5:	29 d8                	sub    %ebx,%eax
}
 3d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3da:	c9                   	leave
 3db:	c3                   	ret
 3dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return (uchar)*p - (uchar)*q;
 3e0:	0f b6 19             	movzbl (%ecx),%ebx
 3e3:	31 c0                	xor    %eax,%eax
 3e5:	29 d8                	sub    %ebx,%eax
}
 3e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3ea:	c9                   	leave
 3eb:	c3                   	ret
 3ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003f0 <strlen>:

uint
strlen(const char *s)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 3f6:	80 3a 00             	cmpb   $0x0,(%edx)
 3f9:	74 15                	je     410 <strlen+0x20>
 3fb:	31 c0                	xor    %eax,%eax
 3fd:	8d 76 00             	lea    0x0(%esi),%esi
 400:	83 c0 01             	add    $0x1,%eax
 403:	89 c1                	mov    %eax,%ecx
 405:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 409:	75 f5                	jne    400 <strlen+0x10>
    ;
  return n;
}
 40b:	89 c8                	mov    %ecx,%eax
 40d:	5d                   	pop    %ebp
 40e:	c3                   	ret
 40f:	90                   	nop
  for(n = 0; s[n]; n++)
 410:	31 c9                	xor    %ecx,%ecx
}
 412:	5d                   	pop    %ebp
 413:	89 c8                	mov    %ecx,%eax
 415:	c3                   	ret
 416:	66 90                	xchg   %ax,%ax
 418:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 41f:	00 

00000420 <memset>:

void*
memset(void *dst, int c, uint n)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 424:	8b 4d 10             	mov    0x10(%ebp),%ecx
 427:	8b 45 0c             	mov    0xc(%ebp),%eax
 42a:	8b 7d 08             	mov    0x8(%ebp),%edi
 42d:	fc                   	cld
 42e:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 430:	8b 45 08             	mov    0x8(%ebp),%eax
 433:	8b 7d fc             	mov    -0x4(%ebp),%edi
 436:	c9                   	leave
 437:	c3                   	ret
 438:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 43f:	00 

00000440 <strchr>:

char*
strchr(const char *s, char c)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	8b 45 08             	mov    0x8(%ebp),%eax
 446:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 44a:	0f b6 10             	movzbl (%eax),%edx
 44d:	84 d2                	test   %dl,%dl
 44f:	75 1a                	jne    46b <strchr+0x2b>
 451:	eb 25                	jmp    478 <strchr+0x38>
 453:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 458:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 45f:	00 
 460:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 464:	83 c0 01             	add    $0x1,%eax
 467:	84 d2                	test   %dl,%dl
 469:	74 0d                	je     478 <strchr+0x38>
    if(*s == c)
 46b:	38 d1                	cmp    %dl,%cl
 46d:	75 f1                	jne    460 <strchr+0x20>
      return (char*)s;
  return 0;
}
 46f:	5d                   	pop    %ebp
 470:	c3                   	ret
 471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 478:	31 c0                	xor    %eax,%eax
}
 47a:	5d                   	pop    %ebp
 47b:	c3                   	ret
 47c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000480 <gets>:

char*
gets(char *buf, int max)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 485:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 488:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 489:	31 db                	xor    %ebx,%ebx
{
 48b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 48e:	eb 27                	jmp    4b7 <gets+0x37>
    cc = read(0, &c, 1);
 490:	83 ec 04             	sub    $0x4,%esp
 493:	6a 01                	push   $0x1
 495:	57                   	push   %edi
 496:	6a 00                	push   $0x0
 498:	e8 32 01 00 00       	call   5cf <read>
    if(cc < 1)
 49d:	83 c4 10             	add    $0x10,%esp
 4a0:	85 c0                	test   %eax,%eax
 4a2:	7e 1d                	jle    4c1 <gets+0x41>
      break;
    buf[i++] = c;
 4a4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 4a8:	8b 55 08             	mov    0x8(%ebp),%edx
 4ab:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 4af:	3c 0a                	cmp    $0xa,%al
 4b1:	74 1d                	je     4d0 <gets+0x50>
 4b3:	3c 0d                	cmp    $0xd,%al
 4b5:	74 19                	je     4d0 <gets+0x50>
  for(i=0; i+1 < max; ){
 4b7:	89 de                	mov    %ebx,%esi
 4b9:	83 c3 01             	add    $0x1,%ebx
 4bc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 4bf:	7c cf                	jl     490 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 4c1:	8b 45 08             	mov    0x8(%ebp),%eax
 4c4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 4c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4cb:	5b                   	pop    %ebx
 4cc:	5e                   	pop    %esi
 4cd:	5f                   	pop    %edi
 4ce:	5d                   	pop    %ebp
 4cf:	c3                   	ret
  buf[i] = '\0';
 4d0:	8b 45 08             	mov    0x8(%ebp),%eax
    buf[i++] = c;
 4d3:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 4d5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 4d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4dc:	5b                   	pop    %ebx
 4dd:	5e                   	pop    %esi
 4de:	5f                   	pop    %edi
 4df:	5d                   	pop    %ebp
 4e0:	c3                   	ret
 4e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 4ef:	00 

000004f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4f6:	6a 00                	push   $0x0
 4f8:	ff 75 08             	push   0x8(%ebp)
{
 4fb:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 4fe:	e8 f4 00 00 00       	call   5f7 <open>
  if(fd < 0)
 503:	83 c4 10             	add    $0x10,%esp
 506:	85 c0                	test   %eax,%eax
 508:	78 2e                	js     538 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 50a:	83 ec 08             	sub    $0x8,%esp
 50d:	ff 75 0c             	push   0xc(%ebp)
 510:	50                   	push   %eax
 511:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 514:	89 c3                	mov    %eax,%ebx
 516:	e8 f4 00 00 00       	call   60f <fstat>
  close(fd);
 51b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 51e:	89 c6                	mov    %eax,%esi
  close(fd);
 520:	e8 ba 00 00 00       	call   5df <close>
  return r;
 525:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 528:	83 c4 10             	add    $0x10,%esp
}
 52b:	89 f0                	mov    %esi,%eax
 52d:	8b 75 fc             	mov    -0x4(%ebp),%esi
 530:	c9                   	leave
 531:	c3                   	ret
 532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
 538:	be ff ff ff ff       	mov    $0xffffffff,%esi
 53d:	eb ec                	jmp    52b <stat+0x3b>
 53f:	90                   	nop

00000540 <atoi>:

int
atoi(const char *s)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	53                   	push   %ebx
 544:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 547:	0f be 02             	movsbl (%edx),%eax
 54a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 54d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 550:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 555:	77 1e                	ja     575 <atoi+0x35>
 557:	90                   	nop
 558:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 55f:	00 
    n = n*10 + *s++ - '0';
 560:	83 c2 01             	add    $0x1,%edx
 563:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 566:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 56a:	0f be 02             	movsbl (%edx),%eax
 56d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 570:	80 fb 09             	cmp    $0x9,%bl
 573:	76 eb                	jbe    560 <atoi+0x20>
  return n;
}
 575:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 578:	89 c8                	mov    %ecx,%eax
 57a:	c9                   	leave
 57b:	c3                   	ret
 57c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000580 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	83 ec 08             	sub    $0x8,%esp
 586:	8b 45 10             	mov    0x10(%ebp),%eax
 589:	8b 55 08             	mov    0x8(%ebp),%edx
 58c:	89 75 f8             	mov    %esi,-0x8(%ebp)
 58f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 592:	85 c0                	test   %eax,%eax
 594:	7e 12                	jle    5a8 <memmove+0x28>
 596:	89 7d fc             	mov    %edi,-0x4(%ebp)
 599:	01 d0                	add    %edx,%eax
  dst = vdst;
 59b:	89 d7                	mov    %edx,%edi
 59d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 5a0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 5a1:	39 f8                	cmp    %edi,%eax
 5a3:	75 fb                	jne    5a0 <memmove+0x20>
 5a5:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return vdst;
}
 5a8:	8b 75 f8             	mov    -0x8(%ebp),%esi
 5ab:	89 d0                	mov    %edx,%eax
 5ad:	c9                   	leave
 5ae:	c3                   	ret

000005af <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5af:	b8 01 00 00 00       	mov    $0x1,%eax
 5b4:	cd 40                	int    $0x40
 5b6:	c3                   	ret

000005b7 <exit>:
SYSCALL(exit)
 5b7:	b8 02 00 00 00       	mov    $0x2,%eax
 5bc:	cd 40                	int    $0x40
 5be:	c3                   	ret

000005bf <wait>:
SYSCALL(wait)
 5bf:	b8 03 00 00 00       	mov    $0x3,%eax
 5c4:	cd 40                	int    $0x40
 5c6:	c3                   	ret

000005c7 <pipe>:
SYSCALL(pipe)
 5c7:	b8 04 00 00 00       	mov    $0x4,%eax
 5cc:	cd 40                	int    $0x40
 5ce:	c3                   	ret

000005cf <read>:
SYSCALL(read)
 5cf:	b8 05 00 00 00       	mov    $0x5,%eax
 5d4:	cd 40                	int    $0x40
 5d6:	c3                   	ret

000005d7 <write>:
SYSCALL(write)
 5d7:	b8 10 00 00 00       	mov    $0x10,%eax
 5dc:	cd 40                	int    $0x40
 5de:	c3                   	ret

000005df <close>:
SYSCALL(close)
 5df:	b8 15 00 00 00       	mov    $0x15,%eax
 5e4:	cd 40                	int    $0x40
 5e6:	c3                   	ret

000005e7 <kill>:
SYSCALL(kill)
 5e7:	b8 06 00 00 00       	mov    $0x6,%eax
 5ec:	cd 40                	int    $0x40
 5ee:	c3                   	ret

000005ef <exec>:
SYSCALL(exec)
 5ef:	b8 07 00 00 00       	mov    $0x7,%eax
 5f4:	cd 40                	int    $0x40
 5f6:	c3                   	ret

000005f7 <open>:
SYSCALL(open)
 5f7:	b8 0f 00 00 00       	mov    $0xf,%eax
 5fc:	cd 40                	int    $0x40
 5fe:	c3                   	ret

000005ff <mknod>:
SYSCALL(mknod)
 5ff:	b8 11 00 00 00       	mov    $0x11,%eax
 604:	cd 40                	int    $0x40
 606:	c3                   	ret

00000607 <unlink>:
SYSCALL(unlink)
 607:	b8 12 00 00 00       	mov    $0x12,%eax
 60c:	cd 40                	int    $0x40
 60e:	c3                   	ret

0000060f <fstat>:
SYSCALL(fstat)
 60f:	b8 08 00 00 00       	mov    $0x8,%eax
 614:	cd 40                	int    $0x40
 616:	c3                   	ret

00000617 <link>:
SYSCALL(link)
 617:	b8 13 00 00 00       	mov    $0x13,%eax
 61c:	cd 40                	int    $0x40
 61e:	c3                   	ret

0000061f <mkdir>:
SYSCALL(mkdir)
 61f:	b8 14 00 00 00       	mov    $0x14,%eax
 624:	cd 40                	int    $0x40
 626:	c3                   	ret

00000627 <chdir>:
SYSCALL(chdir)
 627:	b8 09 00 00 00       	mov    $0x9,%eax
 62c:	cd 40                	int    $0x40
 62e:	c3                   	ret

0000062f <dup>:
SYSCALL(dup)
 62f:	b8 0a 00 00 00       	mov    $0xa,%eax
 634:	cd 40                	int    $0x40
 636:	c3                   	ret

00000637 <getpid>:
SYSCALL(getpid)
 637:	b8 0b 00 00 00       	mov    $0xb,%eax
 63c:	cd 40                	int    $0x40
 63e:	c3                   	ret

0000063f <sbrk>:
SYSCALL(sbrk)
 63f:	b8 0c 00 00 00       	mov    $0xc,%eax
 644:	cd 40                	int    $0x40
 646:	c3                   	ret

00000647 <sleep>:
SYSCALL(sleep)
 647:	b8 0d 00 00 00       	mov    $0xd,%eax
 64c:	cd 40                	int    $0x40
 64e:	c3                   	ret

0000064f <uptime>:
SYSCALL(uptime)
 64f:	b8 0e 00 00 00       	mov    $0xe,%eax
 654:	cd 40                	int    $0x40
 656:	c3                   	ret

00000657 <freepages>:
SYSCALL(freepages)
 657:	b8 16 00 00 00       	mov    $0x16,%eax
 65c:	cd 40                	int    $0x40
 65e:	c3                   	ret

0000065f <va2pa>:
SYSCALL(va2pa)
 65f:	b8 17 00 00 00       	mov    $0x17,%eax
 664:	cd 40                	int    $0x40
 666:	c3                   	ret
 667:	66 90                	xchg   %ax,%ax
 669:	66 90                	xchg   %ax,%ax
 66b:	66 90                	xchg   %ax,%ax
 66d:	66 90                	xchg   %ax,%ax
 66f:	66 90                	xchg   %ax,%ax
 671:	66 90                	xchg   %ax,%ax
 673:	66 90                	xchg   %ax,%ax
 675:	66 90                	xchg   %ax,%ax
 677:	66 90                	xchg   %ax,%ax
 679:	66 90                	xchg   %ax,%ax
 67b:	66 90                	xchg   %ax,%ax
 67d:	66 90                	xchg   %ax,%ax
 67f:	90                   	nop

00000680 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	57                   	push   %edi
 684:	56                   	push   %esi
 685:	53                   	push   %ebx
 686:	89 cb                	mov    %ecx,%ebx
 688:	83 ec 3c             	sub    $0x3c,%esp
 68b:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 68e:	85 d2                	test   %edx,%edx
 690:	0f 89 9a 00 00 00    	jns    730 <printint+0xb0>
 696:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 69a:	0f 84 90 00 00 00    	je     730 <printint+0xb0>
    neg = 1;
    x = -xx;
 6a0:	f7 da                	neg    %edx
    neg = 1;
 6a2:	b8 01 00 00 00       	mov    $0x1,%eax
 6a7:	89 45 c0             	mov    %eax,-0x40(%ebp)
 6aa:	89 d1                	mov    %edx,%ecx
  } else {
    x = xx;
  }

  i = 0;
 6ac:	31 f6                	xor    %esi,%esi
 6ae:	66 90                	xchg   %ax,%ax
 6b0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6b7:	00 
 6b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6bf:	00 
  do{
    buf[i++] = digits[x % base];
 6c0:	89 c8                	mov    %ecx,%eax
 6c2:	31 d2                	xor    %edx,%edx
 6c4:	89 f7                	mov    %esi,%edi
 6c6:	f7 f3                	div    %ebx
 6c8:	8d 76 01             	lea    0x1(%esi),%esi
  }while((x /= base) != 0);
 6cb:	39 d9                	cmp    %ebx,%ecx
    buf[i++] = digits[x % base];
 6cd:	0f b6 92 94 0b 00 00 	movzbl 0xb94(%edx),%edx
  }while((x /= base) != 0);
 6d4:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
 6d6:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 6da:	73 e4                	jae    6c0 <printint+0x40>
  if(neg)
 6dc:	8b 45 c0             	mov    -0x40(%ebp),%eax
 6df:	85 c0                	test   %eax,%eax
 6e1:	74 07                	je     6ea <printint+0x6a>
    buf[i++] = '-';
 6e3:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 6e8:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 6ea:	8d 74 3d d8          	lea    -0x28(%ebp,%edi,1),%esi
 6ee:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 6f1:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 6f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6ff:	00 
    putc(fd, buf[i]);
 700:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 703:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 706:	83 ee 01             	sub    $0x1,%esi
 709:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 70c:	8d 45 d7             	lea    -0x29(%ebp),%eax
 70f:	6a 01                	push   $0x1
 711:	50                   	push   %eax
 712:	57                   	push   %edi
 713:	e8 bf fe ff ff       	call   5d7 <write>
  while(--i >= 0)
 718:	83 c4 10             	add    $0x10,%esp
 71b:	39 f3                	cmp    %esi,%ebx
 71d:	75 e1                	jne    700 <printint+0x80>
}
 71f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 722:	5b                   	pop    %ebx
 723:	5e                   	pop    %esi
 724:	5f                   	pop    %edi
 725:	5d                   	pop    %ebp
 726:	c3                   	ret
 727:	90                   	nop
 728:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 72f:	00 
  neg = 0;
 730:	31 c0                	xor    %eax,%eax
 732:	e9 70 ff ff ff       	jmp    6a7 <printint+0x27>
 737:	90                   	nop
 738:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 73f:	00 

00000740 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	83 ec 38             	sub    $0x38,%esp
 746:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 749:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 74c:	89 75 f8             	mov    %esi,-0x8(%ebp)
 74f:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 752:	0f b6 03             	movzbl (%ebx),%eax
 755:	84 c0                	test   %al,%al
 757:	0f 84 b6 00 00 00    	je     813 <printf+0xd3>
  ap = (uint*)(void*)&fmt + 1;
 75d:	8d 4d 10             	lea    0x10(%ebp),%ecx
 760:	89 7d fc             	mov    %edi,-0x4(%ebp)
 763:	83 c3 01             	add    $0x1,%ebx
 766:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 769:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 76c:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
 76f:	eb 2a                	jmp    79b <printf+0x5b>
 771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 778:	83 ec 04             	sub    $0x4,%esp
 77b:	88 45 e7             	mov    %al,-0x19(%ebp)
 77e:	8d 45 e7             	lea    -0x19(%ebp),%eax
  for(i = 0; fmt[i]; i++){
 781:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 784:	6a 01                	push   $0x1
 786:	50                   	push   %eax
 787:	56                   	push   %esi
 788:	e8 4a fe ff ff       	call   5d7 <write>
  for(i = 0; fmt[i]; i++){
 78d:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
 791:	83 c4 10             	add    $0x10,%esp
 794:	84 c0                	test   %al,%al
 796:	74 78                	je     810 <printf+0xd0>
    c = fmt[i] & 0xff;
 798:	0f b6 d0             	movzbl %al,%edx
      if(c == '%'){
 79b:	83 fa 25             	cmp    $0x25,%edx
 79e:	75 d8                	jne    778 <printf+0x38>
  for(i = 0; fmt[i]; i++){
 7a0:	0f b6 13             	movzbl (%ebx),%edx
 7a3:	84 d2                	test   %dl,%dl
 7a5:	74 69                	je     810 <printf+0xd0>
    c = fmt[i] & 0xff;
 7a7:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 7aa:	80 fa 25             	cmp    $0x25,%dl
 7ad:	0f 84 25 01 00 00    	je     8d8 <printf+0x198>
 7b3:	83 e8 63             	sub    $0x63,%eax
 7b6:	83 f8 15             	cmp    $0x15,%eax
 7b9:	77 0d                	ja     7c8 <printf+0x88>
 7bb:	ff 24 85 3c 0b 00 00 	jmp    *0xb3c(,%eax,4)
 7c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 7c8:	83 ec 04             	sub    $0x4,%esp
 7cb:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 7ce:	88 55 d0             	mov    %dl,-0x30(%ebp)
 7d1:	6a 01                	push   $0x1
 7d3:	51                   	push   %ecx
 7d4:	56                   	push   %esi
 7d5:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 7d8:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 7dc:	e8 f6 fd ff ff       	call   5d7 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 7e1:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 7e5:	83 c4 0c             	add    $0xc,%esp
 7e8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 7eb:	6a 01                	push   $0x1
 7ed:	88 55 e7             	mov    %dl,-0x19(%ebp)
 7f0:	51                   	push   %ecx
  for(i = 0; fmt[i]; i++){
 7f1:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 7f4:	56                   	push   %esi
 7f5:	e8 dd fd ff ff       	call   5d7 <write>
  for(i = 0; fmt[i]; i++){
 7fa:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
 7fe:	83 c4 10             	add    $0x10,%esp
 801:	84 c0                	test   %al,%al
 803:	75 93                	jne    798 <printf+0x58>
 805:	8d 76 00             	lea    0x0(%esi),%esi
 808:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 80f:	00 
 810:	8b 7d fc             	mov    -0x4(%ebp),%edi
      }
      state = 0;
    }
  }
}
 813:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 816:	8b 75 f8             	mov    -0x8(%ebp),%esi
 819:	c9                   	leave
 81a:	c3                   	ret
 81b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 16, 0);
 820:	83 ec 0c             	sub    $0xc,%esp
 823:	8b 17                	mov    (%edi),%edx
 825:	b9 10 00 00 00       	mov    $0x10,%ecx
 82a:	89 f0                	mov    %esi,%eax
 82c:	6a 00                	push   $0x0
 82e:	e8 4d fe ff ff       	call   680 <printint>
  for(i = 0; fmt[i]; i++){
 833:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 837:	83 c3 02             	add    $0x2,%ebx
 83a:	83 c4 10             	add    $0x10,%esp
 83d:	84 c0                	test   %al,%al
 83f:	74 cf                	je     810 <printf+0xd0>
        ap++;
 841:	83 c7 04             	add    $0x4,%edi
 844:	e9 4f ff ff ff       	jmp    798 <printf+0x58>
 849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 850:	83 ec 0c             	sub    $0xc,%esp
 853:	8b 17                	mov    (%edi),%edx
 855:	b9 0a 00 00 00       	mov    $0xa,%ecx
 85a:	89 f0                	mov    %esi,%eax
 85c:	6a 01                	push   $0x1
 85e:	e8 1d fe ff ff       	call   680 <printint>
  for(i = 0; fmt[i]; i++){
 863:	eb ce                	jmp    833 <printf+0xf3>
 865:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 868:	83 ec 04             	sub    $0x4,%esp
 86b:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        putc(fd, *ap);
 86e:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 870:	6a 01                	push   $0x1
 872:	51                   	push   %ecx
 873:	56                   	push   %esi
        putc(fd, *ap);
 874:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 877:	e8 5b fd ff ff       	call   5d7 <write>
 87c:	eb b5                	jmp    833 <printf+0xf3>
 87e:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
 880:	8b 07                	mov    (%edi),%eax
        ap++;
 882:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 885:	85 c0                	test   %eax,%eax
 887:	74 67                	je     8f0 <printf+0x1b0>
        while(*s != 0){
 889:	0f b6 10             	movzbl (%eax),%edx
 88c:	84 d2                	test   %dl,%dl
 88e:	74 6f                	je     8ff <printf+0x1bf>
 890:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 893:	89 c7                	mov    %eax,%edi
 895:	89 d0                	mov    %edx,%eax
 897:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 89a:	89 fb                	mov    %edi,%ebx
 89c:	8d 7d e7             	lea    -0x19(%ebp),%edi
 89f:	90                   	nop
  write(fd, &c, 1);
 8a0:	83 ec 04             	sub    $0x4,%esp
          s++;
 8a3:	83 c3 01             	add    $0x1,%ebx
 8a6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 8a9:	6a 01                	push   $0x1
 8ab:	57                   	push   %edi
 8ac:	56                   	push   %esi
 8ad:	e8 25 fd ff ff       	call   5d7 <write>
        while(*s != 0){
 8b2:	0f b6 03             	movzbl (%ebx),%eax
 8b5:	83 c4 10             	add    $0x10,%esp
 8b8:	84 c0                	test   %al,%al
 8ba:	75 e4                	jne    8a0 <printf+0x160>
 8bc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 8bf:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 8c3:	83 c3 02             	add    $0x2,%ebx
 8c6:	84 c0                	test   %al,%al
 8c8:	0f 85 9b fe ff ff    	jne    769 <printf+0x29>
 8ce:	e9 3d ff ff ff       	jmp    810 <printf+0xd0>
 8d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 8d8:	83 ec 04             	sub    $0x4,%esp
 8db:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 8df:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 8e2:	6a 01                	push   $0x1
 8e4:	e9 07 ff ff ff       	jmp    7f0 <printf+0xb0>
 8e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 8f0:	89 7d d4             	mov    %edi,-0x2c(%ebp)
        if(s == 0)
 8f3:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 8f8:	bf 32 0b 00 00       	mov    $0xb32,%edi
 8fd:	eb 98                	jmp    897 <printf+0x157>
  for(i = 0; fmt[i]; i++){
 8ff:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 903:	83 c3 02             	add    $0x2,%ebx
 906:	84 c0                	test   %al,%al
 908:	0f 85 8a fe ff ff    	jne    798 <printf+0x58>
 90e:	e9 fd fe ff ff       	jmp    810 <printf+0xd0>
 913:	66 90                	xchg   %ax,%ax
 915:	66 90                	xchg   %ax,%ax
 917:	66 90                	xchg   %ax,%ax
 919:	66 90                	xchg   %ax,%ax
 91b:	66 90                	xchg   %ax,%ax
 91d:	66 90                	xchg   %ax,%ax
 91f:	90                   	nop

00000920 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 920:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 921:	a1 b8 0b 00 00       	mov    0xbb8,%eax
{
 926:	89 e5                	mov    %esp,%ebp
 928:	57                   	push   %edi
 929:	56                   	push   %esi
 92a:	53                   	push   %ebx
 92b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 92e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 938:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 93f:	00 
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 940:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 942:	39 c8                	cmp    %ecx,%eax
 944:	73 32                	jae    978 <free+0x58>
 946:	39 d1                	cmp    %edx,%ecx
 948:	72 04                	jb     94e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 94a:	39 d0                	cmp    %edx,%eax
 94c:	72 32                	jb     980 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 94e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 951:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 954:	39 fa                	cmp    %edi,%edx
 956:	74 30                	je     988 <free+0x68>
 958:	89 53 f8             	mov    %edx,-0x8(%ebx)
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 95b:	8b 50 04             	mov    0x4(%eax),%edx
 95e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 961:	39 f1                	cmp    %esi,%ecx
 963:	74 3a                	je     99f <free+0x7f>
 965:	89 08                	mov    %ecx,(%eax)
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 967:	5b                   	pop    %ebx
  freep = p;
 968:	a3 b8 0b 00 00       	mov    %eax,0xbb8
}
 96d:	5e                   	pop    %esi
 96e:	5f                   	pop    %edi
 96f:	5d                   	pop    %ebp
 970:	c3                   	ret
 971:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 978:	39 d0                	cmp    %edx,%eax
 97a:	72 04                	jb     980 <free+0x60>
 97c:	39 d1                	cmp    %edx,%ecx
 97e:	72 ce                	jb     94e <free+0x2e>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 980:	89 d0                	mov    %edx,%eax
 982:	eb bc                	jmp    940 <free+0x20>
 984:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 988:	03 72 04             	add    0x4(%edx),%esi
 98b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 98e:	8b 10                	mov    (%eax),%edx
 990:	8b 12                	mov    (%edx),%edx
 992:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 995:	8b 50 04             	mov    0x4(%eax),%edx
 998:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 99b:	39 f1                	cmp    %esi,%ecx
 99d:	75 c6                	jne    965 <free+0x45>
    p->s.size += bp->s.size;
 99f:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 9a2:	a3 b8 0b 00 00       	mov    %eax,0xbb8
    p->s.size += bp->s.size;
 9a7:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9aa:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 9ad:	89 08                	mov    %ecx,(%eax)
}
 9af:	5b                   	pop    %ebx
 9b0:	5e                   	pop    %esi
 9b1:	5f                   	pop    %edi
 9b2:	5d                   	pop    %ebp
 9b3:	c3                   	ret
 9b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 9b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 9bf:	00 

000009c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9c0:	55                   	push   %ebp
 9c1:	89 e5                	mov    %esp,%ebp
 9c3:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9c6:	8b 45 08             	mov    0x8(%ebp),%eax
{
 9c9:	89 7d fc             	mov    %edi,-0x4(%ebp)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9cc:	8d 78 07             	lea    0x7(%eax),%edi
  if((prevp = freep) == 0){
 9cf:	a1 b8 0b 00 00       	mov    0xbb8,%eax
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9d4:	c1 ef 03             	shr    $0x3,%edi
 9d7:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 9da:	85 c0                	test   %eax,%eax
 9dc:	0f 84 c6 00 00 00    	je     aa8 <malloc+0xe8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e2:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 9e4:	8b 4a 04             	mov    0x4(%edx),%ecx
 9e7:	39 f9                	cmp    %edi,%ecx
 9e9:	0f 83 87 00 00 00    	jae    a76 <malloc+0xb6>
 9ef:	89 5d f4             	mov    %ebx,-0xc(%ebp)
 9f2:	89 75 f8             	mov    %esi,-0x8(%ebp)
  if(nu < 4096)
 9f5:	bb 00 10 00 00       	mov    $0x1000,%ebx
 9fa:	39 df                	cmp    %ebx,%edi
 9fc:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 9ff:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 a06:	eb 21                	jmp    a29 <malloc+0x69>
 a08:	eb 16                	jmp    a20 <malloc+0x60>
 a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 a10:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a17:	00 
 a18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a1f:	00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a20:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 a22:	8b 4a 04             	mov    0x4(%edx),%ecx
 a25:	39 f9                	cmp    %edi,%ecx
 a27:	73 47                	jae    a70 <malloc+0xb0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a29:	89 d0                	mov    %edx,%eax
 a2b:	39 15 b8 0b 00 00    	cmp    %edx,0xbb8
 a31:	75 ed                	jne    a20 <malloc+0x60>
  p = sbrk(nu * sizeof(Header));
 a33:	83 ec 0c             	sub    $0xc,%esp
 a36:	56                   	push   %esi
 a37:	e8 03 fc ff ff       	call   63f <sbrk>
  if(p == (char*)-1)
 a3c:	83 c4 10             	add    $0x10,%esp
 a3f:	83 f8 ff             	cmp    $0xffffffff,%eax
 a42:	74 54                	je     a98 <malloc+0xd8>
  hp->s.size = nu;
 a44:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 a47:	83 ec 0c             	sub    $0xc,%esp
 a4a:	83 c0 08             	add    $0x8,%eax
 a4d:	50                   	push   %eax
 a4e:	e8 cd fe ff ff       	call   920 <free>
  return freep;
 a53:	a1 b8 0b 00 00       	mov    0xbb8,%eax
      if((p = morecore(nunits)) == 0)
 a58:	83 c4 10             	add    $0x10,%esp
 a5b:	85 c0                	test   %eax,%eax
 a5d:	75 c1                	jne    a20 <malloc+0x60>
 a5f:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 a62:	8b 75 f8             	mov    -0x8(%ebp),%esi
 a65:	eb 26                	jmp    a8d <malloc+0xcd>
 a67:	90                   	nop
 a68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a6f:	00 
 a70:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 a73:	8b 75 f8             	mov    -0x8(%ebp),%esi
      if(p->s.size == nunits)
 a76:	39 cf                	cmp    %ecx,%edi
 a78:	74 66                	je     ae0 <malloc+0x120>
        p->s.size -= nunits;
 a7a:	29 f9                	sub    %edi,%ecx
 a7c:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 a7f:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 a82:	89 7a 04             	mov    %edi,0x4(%edx)
      freep = prevp;
 a85:	a3 b8 0b 00 00       	mov    %eax,0xbb8
      return (void*)(p + 1);
 a8a:	8d 42 08             	lea    0x8(%edx),%eax
        return 0;
  }
}
 a8d:	8b 7d fc             	mov    -0x4(%ebp),%edi
 a90:	c9                   	leave
 a91:	c3                   	ret
 a92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return 0;
 a98:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 a9b:	8b 75 f8             	mov    -0x8(%ebp),%esi
 a9e:	31 c0                	xor    %eax,%eax
}
 aa0:	8b 7d fc             	mov    -0x4(%ebp),%edi
 aa3:	c9                   	leave
 aa4:	c3                   	ret
 aa5:	8d 76 00             	lea    0x0(%esi),%esi
 aa8:	89 5d f4             	mov    %ebx,-0xc(%ebp)
    base.s.size = 0;
 aab:	ba bc 0b 00 00       	mov    $0xbbc,%edx
 ab0:	89 75 f8             	mov    %esi,-0x8(%ebp)
    base.s.ptr = freep = prevp = &base;
 ab3:	c7 05 b8 0b 00 00 bc 	movl   $0xbbc,0xbb8
 aba:	0b 00 00 
 abd:	c7 05 bc 0b 00 00 bc 	movl   $0xbbc,0xbbc
 ac4:	0b 00 00 
    base.s.size = 0;
 ac7:	c7 05 c0 0b 00 00 00 	movl   $0x0,0xbc0
 ace:	00 00 00 
    if(p->s.size >= nunits){
 ad1:	e9 1f ff ff ff       	jmp    9f5 <malloc+0x35>
 ad6:	66 90                	xchg   %ax,%ax
 ad8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 adf:	00 
        prevp->s.ptr = p->s.ptr;
 ae0:	8b 0a                	mov    (%edx),%ecx
 ae2:	89 08                	mov    %ecx,(%eax)
 ae4:	eb 9f                	jmp    a85 <malloc+0xc5>
