
user/_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
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
  10:	51                   	push   %ecx
  11:	83 ec 18             	sub    $0x18,%esp
  14:	8b 01                	mov    (%ecx),%eax
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
  19:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int fd, i;
  char *pattern;

  if(argc <= 1){
  1c:	83 f8 01             	cmp    $0x1,%eax
  1f:	7e 6f                	jle    90 <main+0x90>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  21:	8b 43 04             	mov    0x4(%ebx),%eax
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  24:	be 02 00 00 00       	mov    $0x2,%esi
  29:	83 c3 08             	add    $0x8,%ebx
  pattern = argv[1];
  2c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(argc <= 2){
  2f:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
  33:	74 6e                	je     a3 <main+0xa3>
  35:	8d 76 00             	lea    0x0(%esi),%esi
  38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  3f:	00 
    if((fd = open(argv[i], 0)) < 0){
  40:	83 ec 08             	sub    $0x8,%esp
  43:	6a 00                	push   $0x0
  45:	ff 33                	push   (%ebx)
  47:	e8 eb 05 00 00       	call   637 <open>
  4c:	83 c4 10             	add    $0x10,%esp
  4f:	89 c7                	mov    %eax,%edi
  51:	85 c0                	test   %eax,%eax
  53:	78 27                	js     7c <main+0x7c>
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  55:	83 ec 08             	sub    $0x8,%esp
  for(i = 2; i < argc; i++){
  58:	83 c6 01             	add    $0x1,%esi
  5b:	83 c3 04             	add    $0x4,%ebx
    grep(pattern, fd);
  5e:	50                   	push   %eax
  5f:	ff 75 e0             	push   -0x20(%ebp)
  62:	e8 89 01 00 00       	call   1f0 <grep>
    close(fd);
  67:	89 3c 24             	mov    %edi,(%esp)
  6a:	e8 b0 05 00 00       	call   61f <close>
  for(i = 2; i < argc; i++){
  6f:	83 c4 10             	add    $0x10,%esp
  72:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  75:	7f c9                	jg     40 <main+0x40>
  }
  exit();
  77:	e8 7b 05 00 00       	call   5f7 <exit>
      printf(1, "grep: cannot open %s\n", argv[i]);
  7c:	50                   	push   %eax
  7d:	ff 33                	push   (%ebx)
  7f:	68 48 0b 00 00       	push   $0xb48
  84:	6a 01                	push   $0x1
  86:	e8 f5 06 00 00       	call   780 <printf>
      exit();
  8b:	e8 67 05 00 00       	call   5f7 <exit>
    printf(2, "usage: grep pattern [file ...]\n");
  90:	51                   	push   %ecx
  91:	51                   	push   %ecx
  92:	68 28 0b 00 00       	push   $0xb28
  97:	6a 02                	push   $0x2
  99:	e8 e2 06 00 00       	call   780 <printf>
    exit();
  9e:	e8 54 05 00 00       	call   5f7 <exit>
    grep(pattern, 0);
  a3:	52                   	push   %edx
  a4:	52                   	push   %edx
  a5:	6a 00                	push   $0x0
  a7:	50                   	push   %eax
  a8:	e8 43 01 00 00       	call   1f0 <grep>
    exit();
  ad:	e8 45 05 00 00       	call   5f7 <exit>
  b2:	66 90                	xchg   %ax,%ax
  b4:	66 90                	xchg   %ax,%ax
  b6:	66 90                	xchg   %ax,%ax
  b8:	66 90                	xchg   %ax,%ax
  ba:	66 90                	xchg   %ax,%ax
  bc:	66 90                	xchg   %ax,%ax
  be:	66 90                	xchg   %ax,%ax

000000c0 <matchhere>:
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	83 ec 28             	sub    $0x28,%esp
  c6:	89 75 f8             	mov    %esi,-0x8(%ebp)
  c9:	8b 75 08             	mov    0x8(%ebp),%esi
  cc:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  cf:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '\0')
  d2:	0f b6 16             	movzbl (%esi),%edx
  d5:	84 d2                	test   %dl,%dl
  d7:	75 20                	jne    f9 <matchhere+0x39>
  d9:	eb 55                	jmp    130 <matchhere+0x70>
  db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  e0:	84 c9                	test   %cl,%cl
  e2:	74 3c                	je     120 <matchhere+0x60>
  e4:	80 fa 2e             	cmp    $0x2e,%dl
  e7:	74 04                	je     ed <matchhere+0x2d>
  e9:	38 d1                	cmp    %dl,%cl
  eb:	75 33                	jne    120 <matchhere+0x60>
  if(re[0] == '\0')
  ed:	84 c0                	test   %al,%al
  ef:	74 3f                	je     130 <matchhere+0x70>
    return matchhere(re+1, text+1);
  f1:	83 c3 01             	add    $0x1,%ebx
  f4:	83 c6 01             	add    $0x1,%esi
{
  f7:	89 c2                	mov    %eax,%edx
  if(re[1] == '*')
  f9:	0f b6 46 01          	movzbl 0x1(%esi),%eax
  fd:	3c 2a                	cmp    $0x2a,%al
  ff:	74 3f                	je     140 <matchhere+0x80>
    return *text == '\0';
 101:	0f b6 0b             	movzbl (%ebx),%ecx
  if(re[0] == '$' && re[1] == '\0')
 104:	80 fa 24             	cmp    $0x24,%dl
 107:	75 d7                	jne    e0 <matchhere+0x20>
 109:	84 c0                	test   %al,%al
 10b:	74 7a                	je     187 <matchhere+0xc7>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 10d:	84 c9                	test   %cl,%cl
 10f:	74 0f                	je     120 <matchhere+0x60>
 111:	80 f9 24             	cmp    $0x24,%cl
 114:	74 db                	je     f1 <matchhere+0x31>
 116:	66 90                	xchg   %ax,%ax
 118:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 11f:	00 
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  return 0;
 120:	31 c0                	xor    %eax,%eax
}
 122:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 125:	8b 75 f8             	mov    -0x8(%ebp),%esi
 128:	c9                   	leave
 129:	c3                   	ret
 12a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 130:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 133:	8b 75 f8             	mov    -0x8(%ebp),%esi
    return 1;
 136:	b8 01 00 00 00       	mov    $0x1,%eax
}
 13b:	c9                   	leave
 13c:	c3                   	ret
 13d:	8d 76 00             	lea    0x0(%esi),%esi
    return matchstar(re[0], re+2, text);
 140:	83 c6 02             	add    $0x2,%esi
  }while(*text!='\0' && (*text++==c || c=='.'));
 143:	80 fa 2e             	cmp    $0x2e,%dl
 146:	89 7d fc             	mov    %edi,-0x4(%ebp)
 149:	0f 94 c0             	sete   %al
 14c:	89 c7                	mov    %eax,%edi
 14e:	66 90                	xchg   %ax,%ax
    if(matchhere(re, text))
 150:	83 ec 08             	sub    $0x8,%esp
 153:	88 55 e7             	mov    %dl,-0x19(%ebp)
 156:	53                   	push   %ebx
 157:	56                   	push   %esi
 158:	e8 63 ff ff ff       	call   c0 <matchhere>
 15d:	83 c4 10             	add    $0x10,%esp
 160:	85 c0                	test   %eax,%eax
 162:	75 18                	jne    17c <matchhere+0xbc>
  }while(*text!='\0' && (*text++==c || c=='.'));
 164:	0f b6 0b             	movzbl (%ebx),%ecx
 167:	84 c9                	test   %cl,%cl
 169:	74 11                	je     17c <matchhere+0xbc>
 16b:	0f b6 55 e7          	movzbl -0x19(%ebp),%edx
 16f:	83 c3 01             	add    $0x1,%ebx
 172:	38 d1                	cmp    %dl,%cl
 174:	74 da                	je     150 <matchhere+0x90>
 176:	89 f9                	mov    %edi,%ecx
 178:	84 c9                	test   %cl,%cl
 17a:	75 d4                	jne    150 <matchhere+0x90>
 17c:	8b 7d fc             	mov    -0x4(%ebp),%edi
}
 17f:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 182:	8b 75 f8             	mov    -0x8(%ebp),%esi
 185:	c9                   	leave
 186:	c3                   	ret
    return *text == '\0';
 187:	31 c0                	xor    %eax,%eax
 189:	84 c9                	test   %cl,%cl
 18b:	0f 94 c0             	sete   %al
 18e:	eb 92                	jmp    122 <matchhere+0x62>

00000190 <match>:
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	56                   	push   %esi
 194:	53                   	push   %ebx
 195:	8b 75 08             	mov    0x8(%ebp),%esi
 198:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
 19b:	80 3e 5e             	cmpb   $0x5e,(%esi)
 19e:	75 11                	jne    1b1 <match+0x21>
 1a0:	eb 2e                	jmp    1d0 <match+0x40>
 1a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }while(*text++ != '\0');
 1a8:	83 c3 01             	add    $0x1,%ebx
 1ab:	80 7b ff 00          	cmpb   $0x0,-0x1(%ebx)
 1af:	74 11                	je     1c2 <match+0x32>
    if(matchhere(re, text))
 1b1:	83 ec 08             	sub    $0x8,%esp
 1b4:	53                   	push   %ebx
 1b5:	56                   	push   %esi
 1b6:	e8 05 ff ff ff       	call   c0 <matchhere>
 1bb:	83 c4 10             	add    $0x10,%esp
 1be:	85 c0                	test   %eax,%eax
 1c0:	74 e6                	je     1a8 <match+0x18>
}
 1c2:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1c5:	5b                   	pop    %ebx
 1c6:	5e                   	pop    %esi
 1c7:	5d                   	pop    %ebp
 1c8:	c3                   	ret
 1c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return matchhere(re+1, text);
 1d0:	83 c6 01             	add    $0x1,%esi
 1d3:	89 75 08             	mov    %esi,0x8(%ebp)
}
 1d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1d9:	5b                   	pop    %ebx
 1da:	5e                   	pop    %esi
 1db:	5d                   	pop    %ebp
    return matchhere(re+1, text);
 1dc:	e9 df fe ff ff       	jmp    c0 <matchhere>
 1e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ef:	00 

000001f0 <grep>:
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	57                   	push   %edi
 1f4:	56                   	push   %esi
 1f5:	53                   	push   %ebx
 1f6:	83 ec 1c             	sub    $0x1c,%esp
 1f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
 1fc:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    return matchhere(re+1, text);
 203:	8d 43 01             	lea    0x1(%ebx),%eax
 206:	89 45 dc             	mov    %eax,-0x24(%ebp)
 209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 210:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 213:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 218:	83 ec 04             	sub    $0x4,%esp
 21b:	29 c8                	sub    %ecx,%eax
 21d:	50                   	push   %eax
 21e:	8d 81 e0 0b 00 00    	lea    0xbe0(%ecx),%eax
 224:	50                   	push   %eax
 225:	ff 75 0c             	push   0xc(%ebp)
 228:	e8 e2 03 00 00       	call   60f <read>
 22d:	83 c4 10             	add    $0x10,%esp
 230:	85 c0                	test   %eax,%eax
 232:	0f 8e fd 00 00 00    	jle    335 <grep+0x145>
    m += n;
 238:	01 45 e0             	add    %eax,-0x20(%ebp)
 23b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    buf[m] = '\0';
 23e:	bf e0 0b 00 00       	mov    $0xbe0,%edi
 243:	89 de                	mov    %ebx,%esi
 245:	c6 81 e0 0b 00 00 00 	movb   $0x0,0xbe0(%ecx)
    while((q = strchr(p, '\n')) != 0){
 24c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 250:	83 ec 08             	sub    $0x8,%esp
 253:	6a 0a                	push   $0xa
 255:	57                   	push   %edi
 256:	e8 25 02 00 00       	call   480 <strchr>
 25b:	83 c4 10             	add    $0x10,%esp
 25e:	89 c2                	mov    %eax,%edx
 260:	85 c0                	test   %eax,%eax
 262:	0f 84 88 00 00 00    	je     2f0 <grep+0x100>
      *q = 0;
 268:	c6 02 00             	movb   $0x0,(%edx)
  if(re[0] == '^')
 26b:	80 3e 5e             	cmpb   $0x5e,(%esi)
 26e:	74 58                	je     2c8 <grep+0xd8>
 270:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 273:	89 d3                	mov    %edx,%ebx
 275:	eb 12                	jmp    289 <grep+0x99>
 277:	90                   	nop
 278:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 27f:	00 
  }while(*text++ != '\0');
 280:	83 c7 01             	add    $0x1,%edi
 283:	80 7f ff 00          	cmpb   $0x0,-0x1(%edi)
 287:	74 37                	je     2c0 <grep+0xd0>
    if(matchhere(re, text))
 289:	83 ec 08             	sub    $0x8,%esp
 28c:	57                   	push   %edi
 28d:	56                   	push   %esi
 28e:	e8 2d fe ff ff       	call   c0 <matchhere>
 293:	83 c4 10             	add    $0x10,%esp
 296:	85 c0                	test   %eax,%eax
 298:	74 e6                	je     280 <grep+0x90>
        write(1, p, q+1 - p);
 29a:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 29d:	89 da                	mov    %ebx,%edx
 29f:	8d 5b 01             	lea    0x1(%ebx),%ebx
 2a2:	89 d8                	mov    %ebx,%eax
 2a4:	83 ec 04             	sub    $0x4,%esp
        *q = '\n';
 2a7:	c6 02 0a             	movb   $0xa,(%edx)
        write(1, p, q+1 - p);
 2aa:	29 f8                	sub    %edi,%eax
 2ac:	50                   	push   %eax
 2ad:	57                   	push   %edi
 2ae:	89 df                	mov    %ebx,%edi
 2b0:	6a 01                	push   $0x1
 2b2:	e8 60 03 00 00       	call   617 <write>
 2b7:	83 c4 10             	add    $0x10,%esp
 2ba:	eb 94                	jmp    250 <grep+0x60>
 2bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2c0:	8d 7b 01             	lea    0x1(%ebx),%edi
      p = q+1;
 2c3:	eb 8b                	jmp    250 <grep+0x60>
 2c5:	8d 76 00             	lea    0x0(%esi),%esi
    return matchhere(re+1, text);
 2c8:	83 ec 08             	sub    $0x8,%esp
 2cb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 2ce:	57                   	push   %edi
 2cf:	ff 75 dc             	push   -0x24(%ebp)
 2d2:	e8 e9 fd ff ff       	call   c0 <matchhere>
        write(1, p, q+1 - p);
 2d7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    return matchhere(re+1, text);
 2da:	83 c4 10             	add    $0x10,%esp
        write(1, p, q+1 - p);
 2dd:	8d 5a 01             	lea    0x1(%edx),%ebx
      if(match(pattern, p)){
 2e0:	85 c0                	test   %eax,%eax
 2e2:	75 be                	jne    2a2 <grep+0xb2>
        write(1, p, q+1 - p);
 2e4:	89 df                	mov    %ebx,%edi
 2e6:	e9 65 ff ff ff       	jmp    250 <grep+0x60>
 2eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(p == buf)
 2f0:	89 f3                	mov    %esi,%ebx
 2f2:	81 ff e0 0b 00 00    	cmp    $0xbe0,%edi
 2f8:	74 2f                	je     329 <grep+0x139>
    if(m > 0){
 2fa:	8b 45 e0             	mov    -0x20(%ebp),%eax
 2fd:	85 c0                	test   %eax,%eax
 2ff:	0f 8e 0b ff ff ff    	jle    210 <grep+0x20>
      m -= p - buf;
 305:	89 f8                	mov    %edi,%eax
      memmove(buf, p, m);
 307:	83 ec 04             	sub    $0x4,%esp
      m -= p - buf;
 30a:	2d e0 0b 00 00       	sub    $0xbe0,%eax
 30f:	29 45 e0             	sub    %eax,-0x20(%ebp)
 312:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      memmove(buf, p, m);
 315:	51                   	push   %ecx
 316:	57                   	push   %edi
 317:	68 e0 0b 00 00       	push   $0xbe0
 31c:	e8 9f 02 00 00       	call   5c0 <memmove>
 321:	83 c4 10             	add    $0x10,%esp
 324:	e9 e7 fe ff ff       	jmp    210 <grep+0x20>
      m = 0;
 329:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 330:	e9 db fe ff ff       	jmp    210 <grep+0x20>
}
 335:	8d 65 f4             	lea    -0xc(%ebp),%esp
 338:	5b                   	pop    %ebx
 339:	5e                   	pop    %esi
 33a:	5f                   	pop    %edi
 33b:	5d                   	pop    %ebp
 33c:	c3                   	ret
 33d:	8d 76 00             	lea    0x0(%esi),%esi

00000340 <matchstar>:
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	56                   	push   %esi
 345:	53                   	push   %ebx
 346:	83 ec 1c             	sub    $0x1c,%esp
 349:	8b 5d 08             	mov    0x8(%ebp),%ebx
 34c:	8b 75 0c             	mov    0xc(%ebp),%esi
 34f:	8b 7d 10             	mov    0x10(%ebp),%edi
  }while(*text!='\0' && (*text++==c || c=='.'));
 352:	83 fb 2e             	cmp    $0x2e,%ebx
 355:	0f 94 45 e7          	sete   -0x19(%ebp)
 359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(matchhere(re, text))
 360:	83 ec 08             	sub    $0x8,%esp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
 365:	e8 56 fd ff ff       	call   c0 <matchhere>
 36a:	83 c4 10             	add    $0x10,%esp
 36d:	89 c1                	mov    %eax,%ecx
 36f:	85 c0                	test   %eax,%eax
 371:	75 14                	jne    387 <matchstar+0x47>
  }while(*text!='\0' && (*text++==c || c=='.'));
 373:	0f be 07             	movsbl (%edi),%eax
 376:	84 c0                	test   %al,%al
 378:	74 0d                	je     387 <matchstar+0x47>
 37a:	83 c7 01             	add    $0x1,%edi
 37d:	39 d8                	cmp    %ebx,%eax
 37f:	74 df                	je     360 <matchstar+0x20>
 381:	80 7d e7 00          	cmpb   $0x0,-0x19(%ebp)
 385:	75 d9                	jne    360 <matchstar+0x20>
}
 387:	8d 65 f4             	lea    -0xc(%ebp),%esp
 38a:	89 c8                	mov    %ecx,%eax
 38c:	5b                   	pop    %ebx
 38d:	5e                   	pop    %esi
 38e:	5f                   	pop    %edi
 38f:	5d                   	pop    %ebp
 390:	c3                   	ret
 391:	66 90                	xchg   %ax,%ax
 393:	66 90                	xchg   %ax,%ax
 395:	66 90                	xchg   %ax,%ax
 397:	66 90                	xchg   %ax,%ax
 399:	66 90                	xchg   %ax,%ax
 39b:	66 90                	xchg   %ax,%ax
 39d:	66 90                	xchg   %ax,%ax
 39f:	90                   	nop

000003a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 3a0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 3a1:	31 c0                	xor    %eax,%eax
{
 3a3:	89 e5                	mov    %esp,%ebp
 3a5:	53                   	push   %ebx
 3a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 3ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 3b0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 3b4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 3b7:	83 c0 01             	add    $0x1,%eax
 3ba:	84 d2                	test   %dl,%dl
 3bc:	75 f2                	jne    3b0 <strcpy+0x10>
    ;
  return os;
}
 3be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3c1:	89 c8                	mov    %ecx,%eax
 3c3:	c9                   	leave
 3c4:	c3                   	ret
 3c5:	8d 76 00             	lea    0x0(%esi),%esi
 3c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3cf:	00 

000003d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	53                   	push   %ebx
 3d4:	8b 55 08             	mov    0x8(%ebp),%edx
 3d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 3da:	0f b6 02             	movzbl (%edx),%eax
 3dd:	84 c0                	test   %al,%al
 3df:	75 2d                	jne    40e <strcmp+0x3e>
 3e1:	eb 3d                	jmp    420 <strcmp+0x50>
 3e3:	eb 1b                	jmp    400 <strcmp+0x30>
 3e5:	8d 76 00             	lea    0x0(%esi),%esi
 3e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3ef:	00 
 3f0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3f7:	00 
 3f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3ff:	00 
 400:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 404:	83 c2 01             	add    $0x1,%edx
 407:	83 c1 01             	add    $0x1,%ecx
  while(*p && *p == *q)
 40a:	84 c0                	test   %al,%al
 40c:	74 12                	je     420 <strcmp+0x50>
 40e:	0f b6 19             	movzbl (%ecx),%ebx
 411:	38 c3                	cmp    %al,%bl
 413:	74 eb                	je     400 <strcmp+0x30>
  return (uchar)*p - (uchar)*q;
 415:	29 d8                	sub    %ebx,%eax
}
 417:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 41a:	c9                   	leave
 41b:	c3                   	ret
 41c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return (uchar)*p - (uchar)*q;
 420:	0f b6 19             	movzbl (%ecx),%ebx
 423:	31 c0                	xor    %eax,%eax
 425:	29 d8                	sub    %ebx,%eax
}
 427:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 42a:	c9                   	leave
 42b:	c3                   	ret
 42c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000430 <strlen>:

uint
strlen(const char *s)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 436:	80 3a 00             	cmpb   $0x0,(%edx)
 439:	74 15                	je     450 <strlen+0x20>
 43b:	31 c0                	xor    %eax,%eax
 43d:	8d 76 00             	lea    0x0(%esi),%esi
 440:	83 c0 01             	add    $0x1,%eax
 443:	89 c1                	mov    %eax,%ecx
 445:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 449:	75 f5                	jne    440 <strlen+0x10>
    ;
  return n;
}
 44b:	89 c8                	mov    %ecx,%eax
 44d:	5d                   	pop    %ebp
 44e:	c3                   	ret
 44f:	90                   	nop
  for(n = 0; s[n]; n++)
 450:	31 c9                	xor    %ecx,%ecx
}
 452:	5d                   	pop    %ebp
 453:	89 c8                	mov    %ecx,%eax
 455:	c3                   	ret
 456:	66 90                	xchg   %ax,%ax
 458:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 45f:	00 

00000460 <memset>:

void*
memset(void *dst, int c, uint n)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 464:	8b 4d 10             	mov    0x10(%ebp),%ecx
 467:	8b 45 0c             	mov    0xc(%ebp),%eax
 46a:	8b 7d 08             	mov    0x8(%ebp),%edi
 46d:	fc                   	cld
 46e:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 470:	8b 45 08             	mov    0x8(%ebp),%eax
 473:	8b 7d fc             	mov    -0x4(%ebp),%edi
 476:	c9                   	leave
 477:	c3                   	ret
 478:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 47f:	00 

00000480 <strchr>:

char*
strchr(const char *s, char c)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	8b 45 08             	mov    0x8(%ebp),%eax
 486:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 48a:	0f b6 10             	movzbl (%eax),%edx
 48d:	84 d2                	test   %dl,%dl
 48f:	75 1a                	jne    4ab <strchr+0x2b>
 491:	eb 25                	jmp    4b8 <strchr+0x38>
 493:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 498:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 49f:	00 
 4a0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 4a4:	83 c0 01             	add    $0x1,%eax
 4a7:	84 d2                	test   %dl,%dl
 4a9:	74 0d                	je     4b8 <strchr+0x38>
    if(*s == c)
 4ab:	38 d1                	cmp    %dl,%cl
 4ad:	75 f1                	jne    4a0 <strchr+0x20>
      return (char*)s;
  return 0;
}
 4af:	5d                   	pop    %ebp
 4b0:	c3                   	ret
 4b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 4b8:	31 c0                	xor    %eax,%eax
}
 4ba:	5d                   	pop    %ebp
 4bb:	c3                   	ret
 4bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004c0 <gets>:

char*
gets(char *buf, int max)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 4c5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 4c8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 4c9:	31 db                	xor    %ebx,%ebx
{
 4cb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 4ce:	eb 27                	jmp    4f7 <gets+0x37>
    cc = read(0, &c, 1);
 4d0:	83 ec 04             	sub    $0x4,%esp
 4d3:	6a 01                	push   $0x1
 4d5:	57                   	push   %edi
 4d6:	6a 00                	push   $0x0
 4d8:	e8 32 01 00 00       	call   60f <read>
    if(cc < 1)
 4dd:	83 c4 10             	add    $0x10,%esp
 4e0:	85 c0                	test   %eax,%eax
 4e2:	7e 1d                	jle    501 <gets+0x41>
      break;
    buf[i++] = c;
 4e4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 4e8:	8b 55 08             	mov    0x8(%ebp),%edx
 4eb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 4ef:	3c 0a                	cmp    $0xa,%al
 4f1:	74 1d                	je     510 <gets+0x50>
 4f3:	3c 0d                	cmp    $0xd,%al
 4f5:	74 19                	je     510 <gets+0x50>
  for(i=0; i+1 < max; ){
 4f7:	89 de                	mov    %ebx,%esi
 4f9:	83 c3 01             	add    $0x1,%ebx
 4fc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 4ff:	7c cf                	jl     4d0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 501:	8b 45 08             	mov    0x8(%ebp),%eax
 504:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 508:	8d 65 f4             	lea    -0xc(%ebp),%esp
 50b:	5b                   	pop    %ebx
 50c:	5e                   	pop    %esi
 50d:	5f                   	pop    %edi
 50e:	5d                   	pop    %ebp
 50f:	c3                   	ret
  buf[i] = '\0';
 510:	8b 45 08             	mov    0x8(%ebp),%eax
    buf[i++] = c;
 513:	89 de                	mov    %ebx,%esi
  buf[i] = '\0';
 515:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 519:	8d 65 f4             	lea    -0xc(%ebp),%esp
 51c:	5b                   	pop    %ebx
 51d:	5e                   	pop    %esi
 51e:	5f                   	pop    %edi
 51f:	5d                   	pop    %ebp
 520:	c3                   	ret
 521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 528:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 52f:	00 

00000530 <stat>:

int
stat(const char *n, struct stat *st)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 536:	6a 00                	push   $0x0
 538:	ff 75 08             	push   0x8(%ebp)
{
 53b:	89 75 fc             	mov    %esi,-0x4(%ebp)
  fd = open(n, O_RDONLY);
 53e:	e8 f4 00 00 00       	call   637 <open>
  if(fd < 0)
 543:	83 c4 10             	add    $0x10,%esp
 546:	85 c0                	test   %eax,%eax
 548:	78 2e                	js     578 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 54a:	83 ec 08             	sub    $0x8,%esp
 54d:	ff 75 0c             	push   0xc(%ebp)
 550:	50                   	push   %eax
 551:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 554:	89 c3                	mov    %eax,%ebx
 556:	e8 f4 00 00 00       	call   64f <fstat>
  close(fd);
 55b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 55e:	89 c6                	mov    %eax,%esi
  close(fd);
 560:	e8 ba 00 00 00       	call   61f <close>
  return r;
 565:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 568:	83 c4 10             	add    $0x10,%esp
}
 56b:	89 f0                	mov    %esi,%eax
 56d:	8b 75 fc             	mov    -0x4(%ebp),%esi
 570:	c9                   	leave
 571:	c3                   	ret
 572:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
 578:	be ff ff ff ff       	mov    $0xffffffff,%esi
 57d:	eb ec                	jmp    56b <stat+0x3b>
 57f:	90                   	nop

00000580 <atoi>:

int
atoi(const char *s)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	53                   	push   %ebx
 584:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 587:	0f be 02             	movsbl (%edx),%eax
 58a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 58d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 590:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 595:	77 1e                	ja     5b5 <atoi+0x35>
 597:	90                   	nop
 598:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 59f:	00 
    n = n*10 + *s++ - '0';
 5a0:	83 c2 01             	add    $0x1,%edx
 5a3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 5a6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 5aa:	0f be 02             	movsbl (%edx),%eax
 5ad:	8d 58 d0             	lea    -0x30(%eax),%ebx
 5b0:	80 fb 09             	cmp    $0x9,%bl
 5b3:	76 eb                	jbe    5a0 <atoi+0x20>
  return n;
}
 5b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5b8:	89 c8                	mov    %ecx,%eax
 5ba:	c9                   	leave
 5bb:	c3                   	ret
 5bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000005c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	83 ec 08             	sub    $0x8,%esp
 5c6:	8b 45 10             	mov    0x10(%ebp),%eax
 5c9:	8b 55 08             	mov    0x8(%ebp),%edx
 5cc:	89 75 f8             	mov    %esi,-0x8(%ebp)
 5cf:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5d2:	85 c0                	test   %eax,%eax
 5d4:	7e 12                	jle    5e8 <memmove+0x28>
 5d6:	89 7d fc             	mov    %edi,-0x4(%ebp)
 5d9:	01 d0                	add    %edx,%eax
  dst = vdst;
 5db:	89 d7                	mov    %edx,%edi
 5dd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 5e0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 5e1:	39 f8                	cmp    %edi,%eax
 5e3:	75 fb                	jne    5e0 <memmove+0x20>
 5e5:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return vdst;
}
 5e8:	8b 75 f8             	mov    -0x8(%ebp),%esi
 5eb:	89 d0                	mov    %edx,%eax
 5ed:	c9                   	leave
 5ee:	c3                   	ret

000005ef <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5ef:	b8 01 00 00 00       	mov    $0x1,%eax
 5f4:	cd 40                	int    $0x40
 5f6:	c3                   	ret

000005f7 <exit>:
SYSCALL(exit)
 5f7:	b8 02 00 00 00       	mov    $0x2,%eax
 5fc:	cd 40                	int    $0x40
 5fe:	c3                   	ret

000005ff <wait>:
SYSCALL(wait)
 5ff:	b8 03 00 00 00       	mov    $0x3,%eax
 604:	cd 40                	int    $0x40
 606:	c3                   	ret

00000607 <pipe>:
SYSCALL(pipe)
 607:	b8 04 00 00 00       	mov    $0x4,%eax
 60c:	cd 40                	int    $0x40
 60e:	c3                   	ret

0000060f <read>:
SYSCALL(read)
 60f:	b8 05 00 00 00       	mov    $0x5,%eax
 614:	cd 40                	int    $0x40
 616:	c3                   	ret

00000617 <write>:
SYSCALL(write)
 617:	b8 10 00 00 00       	mov    $0x10,%eax
 61c:	cd 40                	int    $0x40
 61e:	c3                   	ret

0000061f <close>:
SYSCALL(close)
 61f:	b8 15 00 00 00       	mov    $0x15,%eax
 624:	cd 40                	int    $0x40
 626:	c3                   	ret

00000627 <kill>:
SYSCALL(kill)
 627:	b8 06 00 00 00       	mov    $0x6,%eax
 62c:	cd 40                	int    $0x40
 62e:	c3                   	ret

0000062f <exec>:
SYSCALL(exec)
 62f:	b8 07 00 00 00       	mov    $0x7,%eax
 634:	cd 40                	int    $0x40
 636:	c3                   	ret

00000637 <open>:
SYSCALL(open)
 637:	b8 0f 00 00 00       	mov    $0xf,%eax
 63c:	cd 40                	int    $0x40
 63e:	c3                   	ret

0000063f <mknod>:
SYSCALL(mknod)
 63f:	b8 11 00 00 00       	mov    $0x11,%eax
 644:	cd 40                	int    $0x40
 646:	c3                   	ret

00000647 <unlink>:
SYSCALL(unlink)
 647:	b8 12 00 00 00       	mov    $0x12,%eax
 64c:	cd 40                	int    $0x40
 64e:	c3                   	ret

0000064f <fstat>:
SYSCALL(fstat)
 64f:	b8 08 00 00 00       	mov    $0x8,%eax
 654:	cd 40                	int    $0x40
 656:	c3                   	ret

00000657 <link>:
SYSCALL(link)
 657:	b8 13 00 00 00       	mov    $0x13,%eax
 65c:	cd 40                	int    $0x40
 65e:	c3                   	ret

0000065f <mkdir>:
SYSCALL(mkdir)
 65f:	b8 14 00 00 00       	mov    $0x14,%eax
 664:	cd 40                	int    $0x40
 666:	c3                   	ret

00000667 <chdir>:
SYSCALL(chdir)
 667:	b8 09 00 00 00       	mov    $0x9,%eax
 66c:	cd 40                	int    $0x40
 66e:	c3                   	ret

0000066f <dup>:
SYSCALL(dup)
 66f:	b8 0a 00 00 00       	mov    $0xa,%eax
 674:	cd 40                	int    $0x40
 676:	c3                   	ret

00000677 <getpid>:
SYSCALL(getpid)
 677:	b8 0b 00 00 00       	mov    $0xb,%eax
 67c:	cd 40                	int    $0x40
 67e:	c3                   	ret

0000067f <sbrk>:
SYSCALL(sbrk)
 67f:	b8 0c 00 00 00       	mov    $0xc,%eax
 684:	cd 40                	int    $0x40
 686:	c3                   	ret

00000687 <sleep>:
SYSCALL(sleep)
 687:	b8 0d 00 00 00       	mov    $0xd,%eax
 68c:	cd 40                	int    $0x40
 68e:	c3                   	ret

0000068f <uptime>:
SYSCALL(uptime)
 68f:	b8 0e 00 00 00       	mov    $0xe,%eax
 694:	cd 40                	int    $0x40
 696:	c3                   	ret

00000697 <freepages>:
SYSCALL(freepages)
 697:	b8 16 00 00 00       	mov    $0x16,%eax
 69c:	cd 40                	int    $0x40
 69e:	c3                   	ret

0000069f <va2pa>:
SYSCALL(va2pa)
 69f:	b8 17 00 00 00       	mov    $0x17,%eax
 6a4:	cd 40                	int    $0x40
 6a6:	c3                   	ret
 6a7:	66 90                	xchg   %ax,%ax
 6a9:	66 90                	xchg   %ax,%ax
 6ab:	66 90                	xchg   %ax,%ax
 6ad:	66 90                	xchg   %ax,%ax
 6af:	66 90                	xchg   %ax,%ax
 6b1:	66 90                	xchg   %ax,%ax
 6b3:	66 90                	xchg   %ax,%ax
 6b5:	66 90                	xchg   %ax,%ax
 6b7:	66 90                	xchg   %ax,%ax
 6b9:	66 90                	xchg   %ax,%ax
 6bb:	66 90                	xchg   %ax,%ax
 6bd:	66 90                	xchg   %ax,%ax
 6bf:	90                   	nop

000006c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	56                   	push   %esi
 6c5:	53                   	push   %ebx
 6c6:	89 cb                	mov    %ecx,%ebx
 6c8:	83 ec 3c             	sub    $0x3c,%esp
 6cb:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6ce:	85 d2                	test   %edx,%edx
 6d0:	0f 89 9a 00 00 00    	jns    770 <printint+0xb0>
 6d6:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 6da:	0f 84 90 00 00 00    	je     770 <printint+0xb0>
    neg = 1;
    x = -xx;
 6e0:	f7 da                	neg    %edx
    neg = 1;
 6e2:	b8 01 00 00 00       	mov    $0x1,%eax
 6e7:	89 45 c0             	mov    %eax,-0x40(%ebp)
 6ea:	89 d1                	mov    %edx,%ecx
  } else {
    x = xx;
  }

  i = 0;
 6ec:	31 f6                	xor    %esi,%esi
 6ee:	66 90                	xchg   %ax,%ax
 6f0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6f7:	00 
 6f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 6ff:	00 
  do{
    buf[i++] = digits[x % base];
 700:	89 c8                	mov    %ecx,%eax
 702:	31 d2                	xor    %edx,%edx
 704:	89 f7                	mov    %esi,%edi
 706:	f7 f3                	div    %ebx
 708:	8d 76 01             	lea    0x1(%esi),%esi
  }while((x /= base) != 0);
 70b:	39 d9                	cmp    %ebx,%ecx
    buf[i++] = digits[x % base];
 70d:	0f b6 92 c0 0b 00 00 	movzbl 0xbc0(%edx),%edx
  }while((x /= base) != 0);
 714:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
 716:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 71a:	73 e4                	jae    700 <printint+0x40>
  if(neg)
 71c:	8b 45 c0             	mov    -0x40(%ebp),%eax
 71f:	85 c0                	test   %eax,%eax
 721:	74 07                	je     72a <printint+0x6a>
    buf[i++] = '-';
 723:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 728:	89 f7                	mov    %esi,%edi

  while(--i >= 0)
 72a:	8d 74 3d d8          	lea    -0x28(%ebp,%edi,1),%esi
 72e:	8b 7d c4             	mov    -0x3c(%ebp),%edi
 731:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 738:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 73f:	00 
    putc(fd, buf[i]);
 740:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 743:	83 ec 04             	sub    $0x4,%esp
  while(--i >= 0)
 746:	83 ee 01             	sub    $0x1,%esi
 749:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 74c:	8d 45 d7             	lea    -0x29(%ebp),%eax
 74f:	6a 01                	push   $0x1
 751:	50                   	push   %eax
 752:	57                   	push   %edi
 753:	e8 bf fe ff ff       	call   617 <write>
  while(--i >= 0)
 758:	83 c4 10             	add    $0x10,%esp
 75b:	39 f3                	cmp    %esi,%ebx
 75d:	75 e1                	jne    740 <printint+0x80>
}
 75f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 762:	5b                   	pop    %ebx
 763:	5e                   	pop    %esi
 764:	5f                   	pop    %edi
 765:	5d                   	pop    %ebp
 766:	c3                   	ret
 767:	90                   	nop
 768:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 76f:	00 
  neg = 0;
 770:	31 c0                	xor    %eax,%eax
 772:	e9 70 ff ff ff       	jmp    6e7 <printint+0x27>
 777:	90                   	nop
 778:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 77f:	00 

00000780 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	83 ec 38             	sub    $0x38,%esp
 786:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 789:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 78c:	89 75 f8             	mov    %esi,-0x8(%ebp)
 78f:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 792:	0f b6 03             	movzbl (%ebx),%eax
 795:	84 c0                	test   %al,%al
 797:	0f 84 b6 00 00 00    	je     853 <printf+0xd3>
  ap = (uint*)(void*)&fmt + 1;
 79d:	8d 4d 10             	lea    0x10(%ebp),%ecx
 7a0:	89 7d fc             	mov    %edi,-0x4(%ebp)
 7a3:	83 c3 01             	add    $0x1,%ebx
 7a6:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
 7a9:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 7ac:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
 7af:	eb 2a                	jmp    7db <printf+0x5b>
 7b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 7b8:	83 ec 04             	sub    $0x4,%esp
 7bb:	88 45 e7             	mov    %al,-0x19(%ebp)
 7be:	8d 45 e7             	lea    -0x19(%ebp),%eax
  for(i = 0; fmt[i]; i++){
 7c1:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 7c4:	6a 01                	push   $0x1
 7c6:	50                   	push   %eax
 7c7:	56                   	push   %esi
 7c8:	e8 4a fe ff ff       	call   617 <write>
  for(i = 0; fmt[i]; i++){
 7cd:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
 7d1:	83 c4 10             	add    $0x10,%esp
 7d4:	84 c0                	test   %al,%al
 7d6:	74 78                	je     850 <printf+0xd0>
    c = fmt[i] & 0xff;
 7d8:	0f b6 d0             	movzbl %al,%edx
      if(c == '%'){
 7db:	83 fa 25             	cmp    $0x25,%edx
 7de:	75 d8                	jne    7b8 <printf+0x38>
  for(i = 0; fmt[i]; i++){
 7e0:	0f b6 13             	movzbl (%ebx),%edx
 7e3:	84 d2                	test   %dl,%dl
 7e5:	74 69                	je     850 <printf+0xd0>
    c = fmt[i] & 0xff;
 7e7:	0f b6 c2             	movzbl %dl,%eax
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
 7ea:	80 fa 25             	cmp    $0x25,%dl
 7ed:	0f 84 25 01 00 00    	je     918 <printf+0x198>
 7f3:	83 e8 63             	sub    $0x63,%eax
 7f6:	83 f8 15             	cmp    $0x15,%eax
 7f9:	77 0d                	ja     808 <printf+0x88>
 7fb:	ff 24 85 68 0b 00 00 	jmp    *0xb68(,%eax,4)
 802:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 808:	83 ec 04             	sub    $0x4,%esp
 80b:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 80e:	88 55 d0             	mov    %dl,-0x30(%ebp)
 811:	6a 01                	push   $0x1
 813:	51                   	push   %ecx
 814:	56                   	push   %esi
 815:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
 818:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 81c:	e8 f6 fd ff ff       	call   617 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 821:	0f b6 55 d0          	movzbl -0x30(%ebp),%edx
  write(fd, &c, 1);
 825:	83 c4 0c             	add    $0xc,%esp
 828:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 82b:	6a 01                	push   $0x1
 82d:	88 55 e7             	mov    %dl,-0x19(%ebp)
 830:	51                   	push   %ecx
  for(i = 0; fmt[i]; i++){
 831:	83 c3 02             	add    $0x2,%ebx
  write(fd, &c, 1);
 834:	56                   	push   %esi
 835:	e8 dd fd ff ff       	call   617 <write>
  for(i = 0; fmt[i]; i++){
 83a:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
 83e:	83 c4 10             	add    $0x10,%esp
 841:	84 c0                	test   %al,%al
 843:	75 93                	jne    7d8 <printf+0x58>
 845:	8d 76 00             	lea    0x0(%esi),%esi
 848:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 84f:	00 
 850:	8b 7d fc             	mov    -0x4(%ebp),%edi
      }
      state = 0;
    }
  }
}
 853:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 856:	8b 75 f8             	mov    -0x8(%ebp),%esi
 859:	c9                   	leave
 85a:	c3                   	ret
 85b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 16, 0);
 860:	83 ec 0c             	sub    $0xc,%esp
 863:	8b 17                	mov    (%edi),%edx
 865:	b9 10 00 00 00       	mov    $0x10,%ecx
 86a:	89 f0                	mov    %esi,%eax
 86c:	6a 00                	push   $0x0
 86e:	e8 4d fe ff ff       	call   6c0 <printint>
  for(i = 0; fmt[i]; i++){
 873:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 877:	83 c3 02             	add    $0x2,%ebx
 87a:	83 c4 10             	add    $0x10,%esp
 87d:	84 c0                	test   %al,%al
 87f:	74 cf                	je     850 <printf+0xd0>
        ap++;
 881:	83 c7 04             	add    $0x4,%edi
 884:	e9 4f ff ff ff       	jmp    7d8 <printf+0x58>
 889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 890:	83 ec 0c             	sub    $0xc,%esp
 893:	8b 17                	mov    (%edi),%edx
 895:	b9 0a 00 00 00       	mov    $0xa,%ecx
 89a:	89 f0                	mov    %esi,%eax
 89c:	6a 01                	push   $0x1
 89e:	e8 1d fe ff ff       	call   6c0 <printint>
  for(i = 0; fmt[i]; i++){
 8a3:	eb ce                	jmp    873 <printf+0xf3>
 8a5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 8a8:	83 ec 04             	sub    $0x4,%esp
 8ab:	8d 4d e7             	lea    -0x19(%ebp),%ecx
        putc(fd, *ap);
 8ae:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 8b0:	6a 01                	push   $0x1
 8b2:	51                   	push   %ecx
 8b3:	56                   	push   %esi
        putc(fd, *ap);
 8b4:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 8b7:	e8 5b fd ff ff       	call   617 <write>
 8bc:	eb b5                	jmp    873 <printf+0xf3>
 8be:	66 90                	xchg   %ax,%ax
        s = (char*)*ap;
 8c0:	8b 07                	mov    (%edi),%eax
        ap++;
 8c2:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
 8c5:	85 c0                	test   %eax,%eax
 8c7:	74 67                	je     930 <printf+0x1b0>
        while(*s != 0){
 8c9:	0f b6 10             	movzbl (%eax),%edx
 8cc:	84 d2                	test   %dl,%dl
 8ce:	74 6f                	je     93f <printf+0x1bf>
 8d0:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 8d3:	89 c7                	mov    %eax,%edi
 8d5:	89 d0                	mov    %edx,%eax
 8d7:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 8da:	89 fb                	mov    %edi,%ebx
 8dc:	8d 7d e7             	lea    -0x19(%ebp),%edi
 8df:	90                   	nop
  write(fd, &c, 1);
 8e0:	83 ec 04             	sub    $0x4,%esp
          s++;
 8e3:	83 c3 01             	add    $0x1,%ebx
 8e6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 8e9:	6a 01                	push   $0x1
 8eb:	57                   	push   %edi
 8ec:	56                   	push   %esi
 8ed:	e8 25 fd ff ff       	call   617 <write>
        while(*s != 0){
 8f2:	0f b6 03             	movzbl (%ebx),%eax
 8f5:	83 c4 10             	add    $0x10,%esp
 8f8:	84 c0                	test   %al,%al
 8fa:	75 e4                	jne    8e0 <printf+0x160>
 8fc:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  for(i = 0; fmt[i]; i++){
 8ff:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 903:	83 c3 02             	add    $0x2,%ebx
 906:	84 c0                	test   %al,%al
 908:	0f 85 9b fe ff ff    	jne    7a9 <printf+0x29>
 90e:	e9 3d ff ff ff       	jmp    850 <printf+0xd0>
 913:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 918:	83 ec 04             	sub    $0x4,%esp
 91b:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 91f:	8d 4d e7             	lea    -0x19(%ebp),%ecx
 922:	6a 01                	push   $0x1
 924:	e9 07 ff ff ff       	jmp    830 <printf+0xb0>
 929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
          s = "(null)";
 930:	89 7d d4             	mov    %edi,-0x2c(%ebp)
        if(s == 0)
 933:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 938:	bf 5e 0b 00 00       	mov    $0xb5e,%edi
 93d:	eb 98                	jmp    8d7 <printf+0x157>
  for(i = 0; fmt[i]; i++){
 93f:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
 943:	83 c3 02             	add    $0x2,%ebx
 946:	84 c0                	test   %al,%al
 948:	0f 85 8a fe ff ff    	jne    7d8 <printf+0x58>
 94e:	e9 fd fe ff ff       	jmp    850 <printf+0xd0>
 953:	66 90                	xchg   %ax,%ax
 955:	66 90                	xchg   %ax,%ax
 957:	66 90                	xchg   %ax,%ax
 959:	66 90                	xchg   %ax,%ax
 95b:	66 90                	xchg   %ax,%ax
 95d:	66 90                	xchg   %ax,%ax
 95f:	90                   	nop

00000960 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 960:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 961:	a1 e0 0f 00 00       	mov    0xfe0,%eax
{
 966:	89 e5                	mov    %esp,%ebp
 968:	57                   	push   %edi
 969:	56                   	push   %esi
 96a:	53                   	push   %ebx
 96b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 96e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 971:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 978:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 97f:	00 
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 980:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 982:	39 c8                	cmp    %ecx,%eax
 984:	73 32                	jae    9b8 <free+0x58>
 986:	39 d1                	cmp    %edx,%ecx
 988:	72 04                	jb     98e <free+0x2e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 98a:	39 d0                	cmp    %edx,%eax
 98c:	72 32                	jb     9c0 <free+0x60>
      break;
  if(bp + bp->s.size == p->s.ptr){
 98e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 991:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 994:	39 fa                	cmp    %edi,%edx
 996:	74 30                	je     9c8 <free+0x68>
 998:	89 53 f8             	mov    %edx,-0x8(%ebx)
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 99b:	8b 50 04             	mov    0x4(%eax),%edx
 99e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9a1:	39 f1                	cmp    %esi,%ecx
 9a3:	74 3a                	je     9df <free+0x7f>
 9a5:	89 08                	mov    %ecx,(%eax)
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}
 9a7:	5b                   	pop    %ebx
  freep = p;
 9a8:	a3 e0 0f 00 00       	mov    %eax,0xfe0
}
 9ad:	5e                   	pop    %esi
 9ae:	5f                   	pop    %edi
 9af:	5d                   	pop    %ebp
 9b0:	c3                   	ret
 9b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9b8:	39 d0                	cmp    %edx,%eax
 9ba:	72 04                	jb     9c0 <free+0x60>
 9bc:	39 d1                	cmp    %edx,%ecx
 9be:	72 ce                	jb     98e <free+0x2e>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9c0:	89 d0                	mov    %edx,%eax
 9c2:	eb bc                	jmp    980 <free+0x20>
 9c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 9c8:	03 72 04             	add    0x4(%edx),%esi
 9cb:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 9ce:	8b 10                	mov    (%eax),%edx
 9d0:	8b 12                	mov    (%edx),%edx
 9d2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 9d5:	8b 50 04             	mov    0x4(%eax),%edx
 9d8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9db:	39 f1                	cmp    %esi,%ecx
 9dd:	75 c6                	jne    9a5 <free+0x45>
    p->s.size += bp->s.size;
 9df:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 9e2:	a3 e0 0f 00 00       	mov    %eax,0xfe0
    p->s.size += bp->s.size;
 9e7:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9ea:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 9ed:	89 08                	mov    %ecx,(%eax)
}
 9ef:	5b                   	pop    %ebx
 9f0:	5e                   	pop    %esi
 9f1:	5f                   	pop    %edi
 9f2:	5d                   	pop    %ebp
 9f3:	c3                   	ret
 9f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 9f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 9ff:	00 

00000a00 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a00:	55                   	push   %ebp
 a01:	89 e5                	mov    %esp,%ebp
 a03:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a06:	8b 45 08             	mov    0x8(%ebp),%eax
{
 a09:	89 7d fc             	mov    %edi,-0x4(%ebp)
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a0c:	8d 78 07             	lea    0x7(%eax),%edi
  if((prevp = freep) == 0){
 a0f:	a1 e0 0f 00 00       	mov    0xfe0,%eax
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a14:	c1 ef 03             	shr    $0x3,%edi
 a17:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 a1a:	85 c0                	test   %eax,%eax
 a1c:	0f 84 c6 00 00 00    	je     ae8 <malloc+0xe8>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a22:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 a24:	8b 4a 04             	mov    0x4(%edx),%ecx
 a27:	39 f9                	cmp    %edi,%ecx
 a29:	0f 83 87 00 00 00    	jae    ab6 <malloc+0xb6>
 a2f:	89 5d f4             	mov    %ebx,-0xc(%ebp)
 a32:	89 75 f8             	mov    %esi,-0x8(%ebp)
  if(nu < 4096)
 a35:	bb 00 10 00 00       	mov    $0x1000,%ebx
 a3a:	39 df                	cmp    %ebx,%edi
 a3c:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 a3f:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 a46:	eb 21                	jmp    a69 <malloc+0x69>
 a48:	eb 16                	jmp    a60 <malloc+0x60>
 a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 a50:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a57:	00 
 a58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 a5f:	00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a60:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 a62:	8b 4a 04             	mov    0x4(%edx),%ecx
 a65:	39 f9                	cmp    %edi,%ecx
 a67:	73 47                	jae    ab0 <malloc+0xb0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a69:	89 d0                	mov    %edx,%eax
 a6b:	39 15 e0 0f 00 00    	cmp    %edx,0xfe0
 a71:	75 ed                	jne    a60 <malloc+0x60>
  p = sbrk(nu * sizeof(Header));
 a73:	83 ec 0c             	sub    $0xc,%esp
 a76:	56                   	push   %esi
 a77:	e8 03 fc ff ff       	call   67f <sbrk>
  if(p == (char*)-1)
 a7c:	83 c4 10             	add    $0x10,%esp
 a7f:	83 f8 ff             	cmp    $0xffffffff,%eax
 a82:	74 54                	je     ad8 <malloc+0xd8>
  hp->s.size = nu;
 a84:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 a87:	83 ec 0c             	sub    $0xc,%esp
 a8a:	83 c0 08             	add    $0x8,%eax
 a8d:	50                   	push   %eax
 a8e:	e8 cd fe ff ff       	call   960 <free>
  return freep;
 a93:	a1 e0 0f 00 00       	mov    0xfe0,%eax
      if((p = morecore(nunits)) == 0)
 a98:	83 c4 10             	add    $0x10,%esp
 a9b:	85 c0                	test   %eax,%eax
 a9d:	75 c1                	jne    a60 <malloc+0x60>
 a9f:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 aa2:	8b 75 f8             	mov    -0x8(%ebp),%esi
 aa5:	eb 26                	jmp    acd <malloc+0xcd>
 aa7:	90                   	nop
 aa8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 aaf:	00 
 ab0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 ab3:	8b 75 f8             	mov    -0x8(%ebp),%esi
      if(p->s.size == nunits)
 ab6:	39 cf                	cmp    %ecx,%edi
 ab8:	74 66                	je     b20 <malloc+0x120>
        p->s.size -= nunits;
 aba:	29 f9                	sub    %edi,%ecx
 abc:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 abf:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 ac2:	89 7a 04             	mov    %edi,0x4(%edx)
      freep = prevp;
 ac5:	a3 e0 0f 00 00       	mov    %eax,0xfe0
      return (void*)(p + 1);
 aca:	8d 42 08             	lea    0x8(%edx),%eax
        return 0;
  }
}
 acd:	8b 7d fc             	mov    -0x4(%ebp),%edi
 ad0:	c9                   	leave
 ad1:	c3                   	ret
 ad2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return 0;
 ad8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 adb:	8b 75 f8             	mov    -0x8(%ebp),%esi
 ade:	31 c0                	xor    %eax,%eax
}
 ae0:	8b 7d fc             	mov    -0x4(%ebp),%edi
 ae3:	c9                   	leave
 ae4:	c3                   	ret
 ae5:	8d 76 00             	lea    0x0(%esi),%esi
 ae8:	89 5d f4             	mov    %ebx,-0xc(%ebp)
    base.s.size = 0;
 aeb:	ba e4 0f 00 00       	mov    $0xfe4,%edx
 af0:	89 75 f8             	mov    %esi,-0x8(%ebp)
    base.s.ptr = freep = prevp = &base;
 af3:	c7 05 e0 0f 00 00 e4 	movl   $0xfe4,0xfe0
 afa:	0f 00 00 
 afd:	c7 05 e4 0f 00 00 e4 	movl   $0xfe4,0xfe4
 b04:	0f 00 00 
    base.s.size = 0;
 b07:	c7 05 e8 0f 00 00 00 	movl   $0x0,0xfe8
 b0e:	00 00 00 
    if(p->s.size >= nunits){
 b11:	e9 1f ff ff ff       	jmp    a35 <malloc+0x35>
 b16:	66 90                	xchg   %ax,%ax
 b18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 b1f:	00 
        prevp->s.ptr = p->s.ptr;
 b20:	8b 0a                	mov    (%edx),%ecx
 b22:	89 08                	mov    %ecx,(%eax)
 b24:	eb 9f                	jmp    ac5 <malloc+0xc5>
