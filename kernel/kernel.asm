
kernel/kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 50 65 11 80       	mov    $0x80116550,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 30 32 10 80       	mov    $0x80103230,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 00 79 10 80       	push   $0x80107900
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 e5 47 00 00       	call   80104840 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 0d                	jmp    80100086 <binit+0x46>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	81 c3 5c 02 00 00    	add    $0x25c,%ebx
    b->next = bcache.head.next;
80100086:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100089:	83 ec 08             	sub    $0x8,%esp
8010008c:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008f:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100096:	68 07 79 10 80       	push   $0x80107907
8010009b:	50                   	push   %eax
8010009c:	e8 5f 46 00 00       	call   80104700 <initsleeplock>
    bcache.head.next->prev = b;
801000a1:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a6:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000a9:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ac:	89 d8                	mov    %ebx,%eax
801000ae:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b4:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
801000ba:	75 c4                	jne    80100080 <binit+0x40>
  }
}
801000bc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000bf:	c9                   	leave
801000c0:	c3                   	ret
801000c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801000cf:	00 

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 77 49 00 00       	call   80104a60 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 4f                	jmp    8010016a <bread+0x9a>
8010011b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 1d                	jne    8010014b <bread+0x7b>
8010012e:	eb 7e                	jmp    801001ae <bread+0xde>
80100130:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100137:	00 
80100138:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010013f:	00 
80100140:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100143:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100149:	74 63                	je     801001ae <bread+0xde>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010014b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010014e:	85 c0                	test   %eax,%eax
80100150:	75 ee                	jne    80100140 <bread+0x70>
80100152:	f6 03 04             	testb  $0x4,(%ebx)
80100155:	75 e9                	jne    80100140 <bread+0x70>
      b->dev = dev;
80100157:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010015a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010015d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100163:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010016a:	83 ec 0c             	sub    $0xc,%esp
8010016d:	68 20 b5 10 80       	push   $0x8010b520
80100172:	e8 89 48 00 00       	call   80104a00 <release>
      acquiresleep(&b->lock);
80100177:	8d 43 0c             	lea    0xc(%ebx),%eax
8010017a:	89 04 24             	mov    %eax,(%esp)
8010017d:	e8 be 45 00 00       	call   80104740 <acquiresleep>
      return b;
80100182:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100185:	f6 03 02             	testb  $0x2,(%ebx)
80100188:	74 0e                	je     80100198 <bread+0xc8>
    iderw(b);
  }
  return b;
}
8010018a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010018d:	89 d8                	mov    %ebx,%eax
8010018f:	5b                   	pop    %ebx
80100190:	5e                   	pop    %esi
80100191:	5f                   	pop    %edi
80100192:	5d                   	pop    %ebp
80100193:	c3                   	ret
80100194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100198:	83 ec 0c             	sub    $0xc,%esp
8010019b:	53                   	push   %ebx
8010019c:	e8 8f 22 00 00       	call   80102430 <iderw>
801001a1:	83 c4 10             	add    $0x10,%esp
}
801001a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801001a7:	89 d8                	mov    %ebx,%eax
801001a9:	5b                   	pop    %ebx
801001aa:	5e                   	pop    %esi
801001ab:	5f                   	pop    %edi
801001ac:	5d                   	pop    %ebp
801001ad:	c3                   	ret
  panic("bget: no buffers");
801001ae:	83 ec 0c             	sub    $0xc,%esp
801001b1:	68 0e 79 10 80       	push   $0x8010790e
801001b6:	e8 e5 01 00 00       	call   801003a0 <panic>
801001bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801001c0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001c0:	55                   	push   %ebp
801001c1:	89 e5                	mov    %esp,%ebp
801001c3:	53                   	push   %ebx
801001c4:	83 ec 10             	sub    $0x10,%esp
801001c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ca:	8d 43 0c             	lea    0xc(%ebx),%eax
801001cd:	50                   	push   %eax
801001ce:	e8 0d 46 00 00       	call   801047e0 <holdingsleep>
801001d3:	83 c4 10             	add    $0x10,%esp
801001d6:	85 c0                	test   %eax,%eax
801001d8:	74 0f                	je     801001e9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001da:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001dd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001e3:	c9                   	leave
  iderw(b);
801001e4:	e9 47 22 00 00       	jmp    80102430 <iderw>
    panic("bwrite");
801001e9:	83 ec 0c             	sub    $0xc,%esp
801001ec:	68 1f 79 10 80       	push   $0x8010791f
801001f1:	e8 aa 01 00 00       	call   801003a0 <panic>
801001f6:	66 90                	xchg   %ax,%ax
801001f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801001ff:	00 

80100200 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
80100200:	55                   	push   %ebp
80100201:	89 e5                	mov    %esp,%ebp
80100203:	56                   	push   %esi
80100204:	53                   	push   %ebx
80100205:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
80100208:	8d 73 0c             	lea    0xc(%ebx),%esi
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 cc 45 00 00       	call   801047e0 <holdingsleep>
80100214:	83 c4 10             	add    $0x10,%esp
80100217:	85 c0                	test   %eax,%eax
80100219:	74 63                	je     8010027e <brelse+0x7e>
    panic("brelse");

  releasesleep(&b->lock);
8010021b:	83 ec 0c             	sub    $0xc,%esp
8010021e:	56                   	push   %esi
8010021f:	e8 7c 45 00 00       	call   801047a0 <releasesleep>

  acquire(&bcache.lock);
80100224:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010022b:	e8 30 48 00 00       	call   80104a60 <acquire>
  b->refcnt--;
80100230:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100233:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100236:	83 e8 01             	sub    $0x1,%eax
80100239:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010023c:	85 c0                	test   %eax,%eax
8010023e:	75 2c                	jne    8010026c <brelse+0x6c>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100240:	8b 53 54             	mov    0x54(%ebx),%edx
80100243:	8b 43 50             	mov    0x50(%ebx),%eax
80100246:	89 42 50             	mov    %eax,0x50(%edx)
    b->prev->next = b->next;
80100249:	8b 53 54             	mov    0x54(%ebx),%edx
8010024c:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
8010024f:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
    b->prev = &bcache.head;
80100254:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    b->next = bcache.head.next;
8010025b:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
8010025e:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100263:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100266:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  }
  
  release(&bcache.lock);
8010026c:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80100273:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100276:	5b                   	pop    %ebx
80100277:	5e                   	pop    %esi
80100278:	5d                   	pop    %ebp
  release(&bcache.lock);
80100279:	e9 82 47 00 00       	jmp    80104a00 <release>
    panic("brelse");
8010027e:	83 ec 0c             	sub    $0xc,%esp
80100281:	68 26 79 10 80       	push   $0x80107926
80100286:	e8 15 01 00 00       	call   801003a0 <panic>
8010028b:	66 90                	xchg   %ax,%ax
8010028d:	66 90                	xchg   %ax,%ax
8010028f:	66 90                	xchg   %ax,%ax
80100291:	66 90                	xchg   %ax,%ax
80100293:	66 90                	xchg   %ax,%ax
80100295:	66 90                	xchg   %ax,%ax
80100297:	66 90                	xchg   %ax,%ax
80100299:	66 90                	xchg   %ax,%ax
8010029b:	66 90                	xchg   %ax,%ax
8010029d:	66 90                	xchg   %ax,%ax
8010029f:	90                   	nop

801002a0 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
801002a0:	55                   	push   %ebp
801002a1:	89 e5                	mov    %esp,%ebp
801002a3:	57                   	push   %edi
801002a4:	56                   	push   %esi
801002a5:	53                   	push   %ebx
801002a6:	83 ec 18             	sub    $0x18,%esp
801002a9:	8b 5d 10             	mov    0x10(%ebp),%ebx
801002ac:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
801002af:	ff 75 08             	push   0x8(%ebp)
  target = n;
801002b2:	89 df                	mov    %ebx,%edi
  iunlock(ip);
801002b4:	e8 87 16 00 00       	call   80101940 <iunlock>
  acquire(&cons.lock);
801002b9:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801002c0:	e8 9b 47 00 00       	call   80104a60 <acquire>
  while(n > 0){
801002c5:	83 c4 10             	add    $0x10,%esp
801002c8:	85 db                	test   %ebx,%ebx
801002ca:	0f 8e 94 00 00 00    	jle    80100364 <consoleread+0xc4>
    while(input.r == input.w){
801002d0:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002d5:	39 05 04 ff 10 80    	cmp    %eax,0x8010ff04
801002db:	74 25                	je     80100302 <consoleread+0x62>
801002dd:	eb 59                	jmp    80100338 <consoleread+0x98>
801002df:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002e0:	83 ec 08             	sub    $0x8,%esp
801002e3:	68 20 ff 10 80       	push   $0x8010ff20
801002e8:	68 00 ff 10 80       	push   $0x8010ff00
801002ed:	e8 be 3f 00 00       	call   801042b0 <sleep>
    while(input.r == input.w){
801002f2:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002f7:	83 c4 10             	add    $0x10,%esp
801002fa:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
80100300:	75 36                	jne    80100338 <consoleread+0x98>
      if(myproc()->killed){
80100302:	e8 99 38 00 00       	call   80103ba0 <myproc>
80100307:	8b 48 24             	mov    0x24(%eax),%ecx
8010030a:	85 c9                	test   %ecx,%ecx
8010030c:	74 d2                	je     801002e0 <consoleread+0x40>
        release(&cons.lock);
8010030e:	83 ec 0c             	sub    $0xc,%esp
80100311:	68 20 ff 10 80       	push   $0x8010ff20
80100316:	e8 e5 46 00 00       	call   80104a00 <release>
        ilock(ip);
8010031b:	5a                   	pop    %edx
8010031c:	ff 75 08             	push   0x8(%ebp)
8010031f:	e8 3c 15 00 00       	call   80101860 <ilock>
        return -1;
80100324:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100327:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010032a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010032f:	5b                   	pop    %ebx
80100330:	5e                   	pop    %esi
80100331:	5f                   	pop    %edi
80100332:	5d                   	pop    %ebp
80100333:	c3                   	ret
80100334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100338:	8d 50 01             	lea    0x1(%eax),%edx
8010033b:	89 15 00 ff 10 80    	mov    %edx,0x8010ff00
80100341:	89 c2                	mov    %eax,%edx
80100343:	83 e2 7f             	and    $0x7f,%edx
80100346:	0f be 8a 80 fe 10 80 	movsbl -0x7fef0180(%edx),%ecx
    if(c == C('D')){  // EOF
8010034d:	80 f9 04             	cmp    $0x4,%cl
80100350:	74 37                	je     80100389 <consoleread+0xe9>
    *dst++ = c;
80100352:	83 c6 01             	add    $0x1,%esi
    --n;
80100355:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100358:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010035b:	83 f9 0a             	cmp    $0xa,%ecx
8010035e:	0f 85 64 ff ff ff    	jne    801002c8 <consoleread+0x28>
  release(&cons.lock);
80100364:	83 ec 0c             	sub    $0xc,%esp
80100367:	68 20 ff 10 80       	push   $0x8010ff20
8010036c:	e8 8f 46 00 00       	call   80104a00 <release>
  ilock(ip);
80100371:	58                   	pop    %eax
80100372:	ff 75 08             	push   0x8(%ebp)
80100375:	e8 e6 14 00 00       	call   80101860 <ilock>
  return target - n;
8010037a:	89 f8                	mov    %edi,%eax
8010037c:	83 c4 10             	add    $0x10,%esp
}
8010037f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100382:	29 d8                	sub    %ebx,%eax
}
80100384:	5b                   	pop    %ebx
80100385:	5e                   	pop    %esi
80100386:	5f                   	pop    %edi
80100387:	5d                   	pop    %ebp
80100388:	c3                   	ret
      if(n < target){
80100389:	39 fb                	cmp    %edi,%ebx
8010038b:	73 d7                	jae    80100364 <consoleread+0xc4>
        input.r--;
8010038d:	a3 00 ff 10 80       	mov    %eax,0x8010ff00
80100392:	eb d0                	jmp    80100364 <consoleread+0xc4>
80100394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100398:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010039f:	00 

801003a0 <panic>:
{
801003a0:	55                   	push   %ebp
801003a1:	89 e5                	mov    %esp,%ebp
801003a3:	53                   	push   %ebx
801003a4:	83 ec 34             	sub    $0x34,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
801003a7:	fa                   	cli
  cons.locking = 0;
801003a8:	c7 05 54 ff 10 80 00 	movl   $0x0,0x8010ff54
801003af:	00 00 00 
  getcallerpcs(&s, pcs);
801003b2:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  cprintf("lapicid %d: panic: ", lapicid());
801003b5:	e8 b6 26 00 00       	call   80102a70 <lapicid>
801003ba:	83 ec 08             	sub    $0x8,%esp
801003bd:	50                   	push   %eax
801003be:	68 2d 79 10 80       	push   $0x8010792d
801003c3:	e8 28 03 00 00       	call   801006f0 <cprintf>
  cprintf(s);
801003c8:	58                   	pop    %eax
801003c9:	ff 75 08             	push   0x8(%ebp)
801003cc:	e8 1f 03 00 00       	call   801006f0 <cprintf>
  cprintf("\n");
801003d1:	c7 04 24 b8 7d 10 80 	movl   $0x80107db8,(%esp)
801003d8:	e8 13 03 00 00       	call   801006f0 <cprintf>
  getcallerpcs(&s, pcs);
801003dd:	8d 45 08             	lea    0x8(%ebp),%eax
801003e0:	5a                   	pop    %edx
801003e1:	59                   	pop    %ecx
801003e2:	53                   	push   %ebx
801003e3:	50                   	push   %eax
801003e4:	e8 77 44 00 00       	call   80104860 <getcallerpcs>
  for(i=0; i<10; i++)
801003e9:	83 c4 10             	add    $0x10,%esp
801003ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf(" %p", pcs[i]);
801003f0:	83 ec 08             	sub    $0x8,%esp
801003f3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003f5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003f8:	68 41 79 10 80       	push   $0x80107941
801003fd:	e8 ee 02 00 00       	call   801006f0 <cprintf>
  for(i=0; i<10; i++)
80100402:	8d 45 f8             	lea    -0x8(%ebp),%eax
80100405:	83 c4 10             	add    $0x10,%esp
80100408:	39 c3                	cmp    %eax,%ebx
8010040a:	75 e4                	jne    801003f0 <panic+0x50>
  panicked = 1; // freeze other CPU
8010040c:	c7 05 58 ff 10 80 01 	movl   $0x1,0x8010ff58
80100413:	00 00 00 
80100416:	66 90                	xchg   %ax,%ax
80100418:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010041f:	00 
  for(;;)
80100420:	eb fe                	jmp    80100420 <panic+0x80>
80100422:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100428:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010042f:	00 

80100430 <consputc.part.0>:
consputc(int c)
80100430:	55                   	push   %ebp
80100431:	89 e5                	mov    %esp,%ebp
80100433:	57                   	push   %edi
80100434:	56                   	push   %esi
80100435:	53                   	push   %ebx
80100436:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
80100439:	3d 00 01 00 00       	cmp    $0x100,%eax
8010043e:	0f 84 cc 00 00 00    	je     80100510 <consputc.part.0+0xe0>
    uartputc(c);
80100444:	83 ec 0c             	sub    $0xc,%esp
80100447:	89 c3                	mov    %eax,%ebx
80100449:	50                   	push   %eax
8010044a:	e8 a1 5f 00 00       	call   801063f0 <uartputc>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010044f:	b8 0e 00 00 00       	mov    $0xe,%eax
80100454:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100459:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010045a:	ba d5 03 00 00       	mov    $0x3d5,%edx
8010045f:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100460:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100463:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100468:	b8 0f 00 00 00       	mov    $0xf,%eax
8010046d:	c1 e1 08             	shl    $0x8,%ecx
80100470:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100471:	ba d5 03 00 00       	mov    $0x3d5,%edx
80100476:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100477:	0f b6 c0             	movzbl %al,%eax
  if(c == '\n')
8010047a:	83 c4 10             	add    $0x10,%esp
  pos |= inb(CRTPORT+1);
8010047d:	09 c8                	or     %ecx,%eax
  if(c == '\n')
8010047f:	83 fb 0a             	cmp    $0xa,%ebx
80100482:	75 74                	jne    801004f8 <consputc.part.0+0xc8>
    pos += 80 - pos%80;
80100484:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100489:	f7 e2                	mul    %edx
8010048b:	c1 ea 06             	shr    $0x6,%edx
8010048e:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100491:	c1 e0 04             	shl    $0x4,%eax
80100494:	8d 78 50             	lea    0x50(%eax),%edi
  if(pos < 0 || pos > 25*80)
80100497:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
8010049d:	0f 8f 23 01 00 00    	jg     801005c6 <consputc.part.0+0x196>
  if((pos/80) >= 24){  // Scroll up.
801004a3:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
801004a9:	0f 8f c1 00 00 00    	jg     80100570 <consputc.part.0+0x140>
  outb(CRTPORT+1, pos>>8);
801004af:	89 f8                	mov    %edi,%eax
  outb(CRTPORT+1, pos);
801004b1:	89 fb                	mov    %edi,%ebx
  crt[pos] = ' ' | 0x0700;
801004b3:	8d bc 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%edi
  outb(CRTPORT+1, pos>>8);
801004ba:	0f b6 f4             	movzbl %ah,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004bd:	b8 0e 00 00 00       	mov    $0xe,%eax
801004c2:	ba d4 03 00 00       	mov    $0x3d4,%edx
801004c7:	ee                   	out    %al,(%dx)
801004c8:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004cd:	89 f0                	mov    %esi,%eax
801004cf:	ee                   	out    %al,(%dx)
801004d0:	b8 0f 00 00 00       	mov    $0xf,%eax
801004d5:	ba d4 03 00 00       	mov    $0x3d4,%edx
801004da:	ee                   	out    %al,(%dx)
801004db:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004e0:	89 d8                	mov    %ebx,%eax
801004e2:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004e3:	b8 20 07 00 00       	mov    $0x720,%eax
801004e8:	66 89 07             	mov    %ax,(%edi)
}
801004eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004ee:	5b                   	pop    %ebx
801004ef:	5e                   	pop    %esi
801004f0:	5f                   	pop    %edi
801004f1:	5d                   	pop    %ebp
801004f2:	c3                   	ret
801004f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
801004f8:	0f b6 db             	movzbl %bl,%ebx
801004fb:	8d 78 01             	lea    0x1(%eax),%edi
801004fe:	80 cf 07             	or     $0x7,%bh
80100501:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
80100508:	80 
80100509:	eb 8c                	jmp    80100497 <consputc.part.0+0x67>
8010050b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100510:	83 ec 0c             	sub    $0xc,%esp
80100513:	6a 08                	push   $0x8
80100515:	e8 d6 5e 00 00       	call   801063f0 <uartputc>
8010051a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100521:	e8 ca 5e 00 00       	call   801063f0 <uartputc>
80100526:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010052d:	e8 be 5e 00 00       	call   801063f0 <uartputc>
80100532:	b8 0e 00 00 00       	mov    $0xe,%eax
80100537:	ba d4 03 00 00       	mov    $0x3d4,%edx
8010053c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010053d:	ba d5 03 00 00       	mov    $0x3d5,%edx
80100542:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100543:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100546:	ba d4 03 00 00       	mov    $0x3d4,%edx
8010054b:	b8 0f 00 00 00       	mov    $0xf,%eax
80100550:	c1 e3 08             	shl    $0x8,%ebx
80100553:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100554:	ba d5 03 00 00       	mov    $0x3d5,%edx
80100559:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
8010055a:	0f b6 c8             	movzbl %al,%ecx
    if(pos > 0) --pos;
8010055d:	83 c4 10             	add    $0x10,%esp
80100560:	09 d9                	or     %ebx,%ecx
80100562:	74 54                	je     801005b8 <consputc.part.0+0x188>
80100564:	8d 79 ff             	lea    -0x1(%ecx),%edi
80100567:	e9 2b ff ff ff       	jmp    80100497 <consputc.part.0+0x67>
8010056c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100570:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100573:	8d 5f b0             	lea    -0x50(%edi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100576:	8d bc 3f 60 7f 0b 80 	lea    -0x7ff480a0(%edi,%edi,1),%edi
  outb(CRTPORT+1, pos);
8010057d:	be 07 00 00 00       	mov    $0x7,%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100582:	68 60 0e 00 00       	push   $0xe60
80100587:	68 a0 80 0b 80       	push   $0x800b80a0
8010058c:	68 00 80 0b 80       	push   $0x800b8000
80100591:	e8 8a 46 00 00       	call   80104c20 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100596:	b8 80 07 00 00       	mov    $0x780,%eax
8010059b:	83 c4 0c             	add    $0xc,%esp
8010059e:	29 d8                	sub    %ebx,%eax
801005a0:	01 c0                	add    %eax,%eax
801005a2:	50                   	push   %eax
801005a3:	6a 00                	push   $0x0
801005a5:	57                   	push   %edi
801005a6:	e8 d5 45 00 00       	call   80104b80 <memset>
  outb(CRTPORT+1, pos);
801005ab:	83 c4 10             	add    $0x10,%esp
801005ae:	e9 0a ff ff ff       	jmp    801004bd <consputc.part.0+0x8d>
801005b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(pos > 0) --pos;
801005b8:	bf 00 80 0b 80       	mov    $0x800b8000,%edi
801005bd:	31 db                	xor    %ebx,%ebx
801005bf:	31 f6                	xor    %esi,%esi
801005c1:	e9 f7 fe ff ff       	jmp    801004bd <consputc.part.0+0x8d>
    panic("pos under/overflow");
801005c6:	83 ec 0c             	sub    $0xc,%esp
801005c9:	68 45 79 10 80       	push   $0x80107945
801005ce:	e8 cd fd ff ff       	call   801003a0 <panic>
801005d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801005d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801005df:	00 

801005e0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005e0:	55                   	push   %ebp
801005e1:	89 e5                	mov    %esp,%ebp
801005e3:	83 ec 24             	sub    $0x24,%esp
  int i;

  iunlock(ip);
801005e6:	ff 75 08             	push   0x8(%ebp)
{
801005e9:	89 75 f8             	mov    %esi,-0x8(%ebp)
801005ec:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
801005ef:	e8 4c 13 00 00       	call   80101940 <iunlock>
  acquire(&cons.lock);
801005f4:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801005fb:	e8 60 44 00 00       	call   80104a60 <acquire>
  for(i = 0; i < n; i++)
80100600:	83 c4 10             	add    $0x10,%esp
80100603:	85 f6                	test   %esi,%esi
80100605:	7e 30                	jle    80100637 <consolewrite+0x57>
80100607:	89 5d f4             	mov    %ebx,-0xc(%ebp)
8010060a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010060d:	89 7d fc             	mov    %edi,-0x4(%ebp)
80100610:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
80100613:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100619:	85 d2                	test   %edx,%edx
8010061b:	74 05                	je     80100622 <consolewrite+0x42>
  asm volatile("cli");
8010061d:	fa                   	cli
8010061e:	66 90                	xchg   %ax,%ax
    for(;;)
80100620:	eb fe                	jmp    80100620 <consolewrite+0x40>
    consputc(buf[i] & 0xff);
80100622:	0f b6 03             	movzbl (%ebx),%eax
  for(i = 0; i < n; i++)
80100625:	83 c3 01             	add    $0x1,%ebx
80100628:	e8 03 fe ff ff       	call   80100430 <consputc.part.0>
8010062d:	39 fb                	cmp    %edi,%ebx
8010062f:	75 e2                	jne    80100613 <consolewrite+0x33>
80100631:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100634:	8b 7d fc             	mov    -0x4(%ebp),%edi
  release(&cons.lock);
80100637:	83 ec 0c             	sub    $0xc,%esp
8010063a:	68 20 ff 10 80       	push   $0x8010ff20
8010063f:	e8 bc 43 00 00       	call   80104a00 <release>
  ilock(ip);
80100644:	58                   	pop    %eax
80100645:	ff 75 08             	push   0x8(%ebp)
80100648:	e8 13 12 00 00       	call   80101860 <ilock>

  return n;
}
8010064d:	89 f0                	mov    %esi,%eax
8010064f:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100652:	c9                   	leave
80100653:	c3                   	ret
80100654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100658:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010065f:	00 

80100660 <printint>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	89 d3                	mov    %edx,%ebx
80100668:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010066b:	85 c0                	test   %eax,%eax
8010066d:	79 05                	jns    80100674 <printint+0x14>
8010066f:	83 e1 01             	and    $0x1,%ecx
80100672:	75 5f                	jne    801006d3 <printint+0x73>
80100674:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
8010067b:	89 c1                	mov    %eax,%ecx
  i = 0;
8010067d:	31 f6                	xor    %esi,%esi
8010067f:	90                   	nop
    buf[i++] = digits[x % base];
80100680:	89 c8                	mov    %ecx,%eax
80100682:	31 d2                	xor    %edx,%edx
80100684:	89 f7                	mov    %esi,%edi
80100686:	f7 f3                	div    %ebx
80100688:	8d 76 01             	lea    0x1(%esi),%esi
  }while((x /= base) != 0);
8010068b:	39 d9                	cmp    %ebx,%ecx
    buf[i++] = digits[x % base];
8010068d:	0f b6 92 0c 7e 10 80 	movzbl -0x7fef81f4(%edx),%edx
  }while((x /= base) != 0);
80100694:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
80100696:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
8010069a:	73 e4                	jae    80100680 <printint+0x20>
  if(sign)
8010069c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010069f:	85 d2                	test   %edx,%edx
801006a1:	74 07                	je     801006aa <printint+0x4a>
    buf[i++] = '-';
801006a3:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
801006a8:	89 f7                	mov    %esi,%edi
  while(--i >= 0)
801006aa:	8d 5d d8             	lea    -0x28(%ebp),%ebx
801006ad:	01 df                	add    %ebx,%edi
  if(panicked){
801006af:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
801006b4:	85 c0                	test   %eax,%eax
801006b6:	74 0a                	je     801006c2 <printint+0x62>
801006b8:	fa                   	cli
801006b9:	90                   	nop
801006ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(;;)
801006c0:	eb fe                	jmp    801006c0 <printint+0x60>
    consputc(buf[i]);
801006c2:	0f be 07             	movsbl (%edi),%eax
801006c5:	e8 66 fd ff ff       	call   80100430 <consputc.part.0>
  while(--i >= 0)
801006ca:	39 fb                	cmp    %edi,%ebx
801006cc:	74 10                	je     801006de <printint+0x7e>
801006ce:	83 ef 01             	sub    $0x1,%edi
801006d1:	eb dc                	jmp    801006af <printint+0x4f>
  if(sign && (sign = xx < 0))
801006d3:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    x = -xx;
801006da:	f7 d8                	neg    %eax
801006dc:	eb 9d                	jmp    8010067b <printint+0x1b>
}
801006de:	83 c4 2c             	add    $0x2c,%esp
801006e1:	5b                   	pop    %ebx
801006e2:	5e                   	pop    %esi
801006e3:	5f                   	pop    %edi
801006e4:	5d                   	pop    %ebp
801006e5:	c3                   	ret
801006e6:	66 90                	xchg   %ax,%ax
801006e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801006ef:	00 

801006f0 <cprintf>:
{
801006f0:	55                   	push   %ebp
801006f1:	89 e5                	mov    %esp,%ebp
801006f3:	83 ec 28             	sub    $0x28,%esp
  locking = cons.locking;
801006f6:	8b 15 54 ff 10 80    	mov    0x8010ff54,%edx
{
801006fc:	89 75 f8             	mov    %esi,-0x8(%ebp)
  if (fmt == 0)
801006ff:	8b 75 08             	mov    0x8(%ebp),%esi
  if(locking)
80100702:	85 d2                	test   %edx,%edx
80100704:	0f 85 26 01 00 00    	jne    80100830 <cprintf+0x140>
  if (fmt == 0)
8010070a:	85 f6                	test   %esi,%esi
8010070c:	0f 84 e6 01 00 00    	je     801008f8 <cprintf+0x208>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100712:	0f b6 06             	movzbl (%esi),%eax
80100715:	85 c0                	test   %eax,%eax
80100717:	74 6b                	je     80100784 <cprintf+0x94>
80100719:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010071c:	89 5d f4             	mov    %ebx,-0xc(%ebp)
8010071f:	31 db                	xor    %ebx,%ebx
80100721:	89 7d fc             	mov    %edi,-0x4(%ebp)
  argp = (uint*)(void*)(&fmt + 1);
80100724:	8d 7d 0c             	lea    0xc(%ebp),%edi
    if(c != '%'){
80100727:	83 f8 25             	cmp    $0x25,%eax
8010072a:	75 64                	jne    80100790 <cprintf+0xa0>
    c = fmt[++i] & 0xff;
8010072c:	83 c3 01             	add    $0x1,%ebx
8010072f:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
80100733:	85 d2                	test   %edx,%edx
80100735:	74 3c                	je     80100773 <cprintf+0x83>
    switch(c){
80100737:	83 fa 70             	cmp    $0x70,%edx
8010073a:	0f 84 d2 00 00 00    	je     80100812 <cprintf+0x122>
80100740:	0f 8f 92 00 00 00    	jg     801007d8 <cprintf+0xe8>
80100746:	83 fa 25             	cmp    $0x25,%edx
80100749:	74 6c                	je     801007b7 <cprintf+0xc7>
8010074b:	83 fa 64             	cmp    $0x64,%edx
8010074e:	0f 85 92 00 00 00    	jne    801007e6 <cprintf+0xf6>
      printint(*argp++, 10, 1);
80100754:	8b 07                	mov    (%edi),%eax
80100756:	b9 01 00 00 00       	mov    $0x1,%ecx
8010075b:	ba 0a 00 00 00       	mov    $0xa,%edx
80100760:	83 c7 04             	add    $0x4,%edi
80100763:	e8 f8 fe ff ff       	call   80100660 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100768:	83 c3 01             	add    $0x1,%ebx
8010076b:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
8010076f:	85 c0                	test   %eax,%eax
80100771:	75 b4                	jne    80100727 <cprintf+0x37>
  if(locking)
80100773:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100776:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100779:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010077c:	85 c0                	test   %eax,%eax
8010077e:	0f 85 d5 00 00 00    	jne    80100859 <cprintf+0x169>
}
80100784:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100787:	c9                   	leave
80100788:	c3                   	ret
80100789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(panicked){
80100790:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
80100796:	85 c9                	test   %ecx,%ecx
80100798:	74 16                	je     801007b0 <cprintf+0xc0>
8010079a:	fa                   	cli
8010079b:	90                   	nop
8010079c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(;;)
801007a0:	eb fe                	jmp    801007a0 <cprintf+0xb0>
  if(c == BACKSPACE){
801007a2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007a5:	8d 76 00             	lea    0x0(%esi),%esi
801007a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801007af:	00 
801007b0:	e8 7b fc ff ff       	call   80100430 <consputc.part.0>
      break;
801007b5:	eb b1                	jmp    80100768 <cprintf+0x78>
  if(panicked){
801007b7:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
801007bc:	85 c0                	test   %eax,%eax
801007be:	0f 84 1e 01 00 00    	je     801008e2 <cprintf+0x1f2>
801007c4:	fa                   	cli
801007c5:	90                   	nop
801007c6:	66 90                	xchg   %ax,%ax
801007c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801007cf:	00 
    for(;;)
801007d0:	eb fe                	jmp    801007d0 <cprintf+0xe0>
801007d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
801007d8:	83 fa 73             	cmp    $0x73,%edx
801007db:	0f 84 8d 00 00 00    	je     8010086e <cprintf+0x17e>
801007e1:	83 fa 78             	cmp    $0x78,%edx
801007e4:	74 2c                	je     80100812 <cprintf+0x122>
  if(panicked){
801007e6:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
801007ec:	85 c9                	test   %ecx,%ecx
801007ee:	0f 85 e7 00 00 00    	jne    801008db <cprintf+0x1eb>
801007f4:	b8 25 00 00 00       	mov    $0x25,%eax
801007f9:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(c == BACKSPACE){
801007fc:	e8 2f fc ff ff       	call   80100430 <consputc.part.0>
  if(panicked){
80100801:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100807:	85 d2                	test   %edx,%edx
80100809:	74 97                	je     801007a2 <cprintf+0xb2>
8010080b:	fa                   	cli
8010080c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(;;)
80100810:	eb fe                	jmp    80100810 <cprintf+0x120>
      printint(*argp++, 16, 0);
80100812:	8b 07                	mov    (%edi),%eax
80100814:	31 c9                	xor    %ecx,%ecx
80100816:	ba 10 00 00 00       	mov    $0x10,%edx
8010081b:	83 c7 04             	add    $0x4,%edi
8010081e:	e8 3d fe ff ff       	call   80100660 <printint>
      break;
80100823:	e9 40 ff ff ff       	jmp    80100768 <cprintf+0x78>
80100828:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010082f:	00 
    acquire(&cons.lock);
80100830:	83 ec 0c             	sub    $0xc,%esp
80100833:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100836:	68 20 ff 10 80       	push   $0x8010ff20
8010083b:	e8 20 42 00 00       	call   80104a60 <acquire>
  if (fmt == 0)
80100840:	83 c4 10             	add    $0x10,%esp
80100843:	85 f6                	test   %esi,%esi
80100845:	0f 84 ad 00 00 00    	je     801008f8 <cprintf+0x208>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010084b:	0f b6 06             	movzbl (%esi),%eax
8010084e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100851:	85 c0                	test   %eax,%eax
80100853:	0f 85 c0 fe ff ff    	jne    80100719 <cprintf+0x29>
    release(&cons.lock);
80100859:	83 ec 0c             	sub    $0xc,%esp
8010085c:	68 20 ff 10 80       	push   $0x8010ff20
80100861:	e8 9a 41 00 00       	call   80104a00 <release>
80100866:	83 c4 10             	add    $0x10,%esp
}
80100869:	e9 16 ff ff ff       	jmp    80100784 <cprintf+0x94>
      if((s = (char*)*argp++) == 0)
8010086e:	8d 57 04             	lea    0x4(%edi),%edx
80100871:	8b 3f                	mov    (%edi),%edi
80100873:	85 ff                	test   %edi,%edi
80100875:	74 2b                	je     801008a2 <cprintf+0x1b2>
      for(; *s; s++)
80100877:	0f be 07             	movsbl (%edi),%eax
8010087a:	84 c0                	test   %al,%al
8010087c:	74 73                	je     801008f1 <cprintf+0x201>
8010087e:	89 5d e0             	mov    %ebx,-0x20(%ebp)
80100881:	89 fb                	mov    %edi,%ebx
80100883:	89 f7                	mov    %esi,%edi
80100885:	89 d6                	mov    %edx,%esi
  if(panicked){
80100887:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
8010088d:	85 d2                	test   %edx,%edx
8010088f:	74 2c                	je     801008bd <cprintf+0x1cd>
80100891:	fa                   	cli
80100892:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100898:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010089f:	00 
    for(;;)
801008a0:	eb fe                	jmp    801008a0 <cprintf+0x1b0>
        s = "(null)";
801008a2:	89 f7                	mov    %esi,%edi
801008a4:	89 d6                	mov    %edx,%esi
  if(panicked){
801008a6:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
        s = "(null)";
801008ac:	89 5d e0             	mov    %ebx,-0x20(%ebp)
      if((s = (char*)*argp++) == 0)
801008af:	b8 28 00 00 00       	mov    $0x28,%eax
        s = "(null)";
801008b4:	bb 58 79 10 80       	mov    $0x80107958,%ebx
  if(panicked){
801008b9:	85 d2                	test   %edx,%edx
801008bb:	75 d4                	jne    80100891 <cprintf+0x1a1>
  if(c == BACKSPACE){
801008bd:	e8 6e fb ff ff       	call   80100430 <consputc.part.0>
      for(; *s; s++)
801008c2:	0f be 43 01          	movsbl 0x1(%ebx),%eax
801008c6:	83 c3 01             	add    $0x1,%ebx
801008c9:	84 c0                	test   %al,%al
801008cb:	75 ba                	jne    80100887 <cprintf+0x197>
      if((s = (char*)*argp++) == 0)
801008cd:	89 f2                	mov    %esi,%edx
801008cf:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801008d2:	89 fe                	mov    %edi,%esi
801008d4:	89 d7                	mov    %edx,%edi
801008d6:	e9 8d fe ff ff       	jmp    80100768 <cprintf+0x78>
801008db:	fa                   	cli
801008dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(;;)
801008e0:	eb fe                	jmp    801008e0 <cprintf+0x1f0>
  if(c == BACKSPACE){
801008e2:	b8 25 00 00 00       	mov    $0x25,%eax
801008e7:	e8 44 fb ff ff       	call   80100430 <consputc.part.0>
      break;
801008ec:	e9 77 fe ff ff       	jmp    80100768 <cprintf+0x78>
      if((s = (char*)*argp++) == 0)
801008f1:	89 d7                	mov    %edx,%edi
801008f3:	e9 70 fe ff ff       	jmp    80100768 <cprintf+0x78>
    panic("null fmt");
801008f8:	83 ec 0c             	sub    $0xc,%esp
801008fb:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801008fe:	68 5f 79 10 80       	push   $0x8010795f
80100903:	89 7d fc             	mov    %edi,-0x4(%ebp)
80100906:	e8 95 fa ff ff       	call   801003a0 <panic>
8010090b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100910 <consoleintr>:
{
80100910:	55                   	push   %ebp
80100911:	89 e5                	mov    %esp,%ebp
80100913:	83 ec 34             	sub    $0x34,%esp
  acquire(&cons.lock);
80100916:	68 20 ff 10 80       	push   $0x8010ff20
{
8010091b:	89 5d f4             	mov    %ebx,-0xc(%ebp)
8010091e:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100921:	89 75 f8             	mov    %esi,-0x8(%ebp)
  int c, doprocdump = 0;
80100924:	31 f6                	xor    %esi,%esi
  acquire(&cons.lock);
80100926:	e8 35 41 00 00       	call   80104a60 <acquire>
  while((c = getc()) >= 0){
8010092b:	83 c4 10             	add    $0x10,%esp
8010092e:	ff d3                	call   *%ebx
80100930:	85 c0                	test   %eax,%eax
80100932:	78 20                	js     80100954 <consoleintr+0x44>
    switch(c){
80100934:	83 f8 15             	cmp    $0x15,%eax
80100937:	74 45                	je     8010097e <consoleintr+0x6e>
80100939:	7f 7d                	jg     801009b8 <consoleintr+0xa8>
8010093b:	83 f8 08             	cmp    $0x8,%eax
8010093e:	74 7d                	je     801009bd <consoleintr+0xad>
80100940:	83 f8 10             	cmp    $0x10,%eax
80100943:	0f 85 12 01 00 00    	jne    80100a5b <consoleintr+0x14b>
80100949:	be 01 00 00 00       	mov    $0x1,%esi
  while((c = getc()) >= 0){
8010094e:	ff d3                	call   *%ebx
80100950:	85 c0                	test   %eax,%eax
80100952:	79 e0                	jns    80100934 <consoleintr+0x24>
  release(&cons.lock);
80100954:	83 ec 0c             	sub    $0xc,%esp
80100957:	68 20 ff 10 80       	push   $0x8010ff20
8010095c:	e8 9f 40 00 00       	call   80104a00 <release>
  if(doprocdump) {
80100961:	83 c4 10             	add    $0x10,%esp
80100964:	85 f6                	test   %esi,%esi
80100966:	0f 85 6c 01 00 00    	jne    80100ad8 <consoleintr+0x1c8>
}
8010096c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010096f:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100972:	c9                   	leave
80100973:	c3                   	ret
  if(c == BACKSPACE){
80100974:	b8 00 01 00 00       	mov    $0x100,%eax
80100979:	e8 b2 fa ff ff       	call   80100430 <consputc.part.0>
      while(input.e != input.w &&
8010097e:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100983:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
80100989:	74 a3                	je     8010092e <consoleintr+0x1e>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
8010098b:	83 e8 01             	sub    $0x1,%eax
8010098e:	89 c2                	mov    %eax,%edx
80100990:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100993:	80 ba 80 fe 10 80 0a 	cmpb   $0xa,-0x7fef0180(%edx)
8010099a:	74 92                	je     8010092e <consoleintr+0x1e>
  if(panicked){
8010099c:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
        input.e--;
801009a2:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
801009a7:	85 d2                	test   %edx,%edx
801009a9:	74 c9                	je     80100974 <consoleintr+0x64>
801009ab:	fa                   	cli
801009ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(;;)
801009b0:	eb fe                	jmp    801009b0 <consoleintr+0xa0>
801009b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
801009b8:	83 f8 7f             	cmp    $0x7f,%eax
801009bb:	75 35                	jne    801009f2 <consoleintr+0xe2>
      if(input.e != input.w){
801009bd:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801009c2:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801009c8:	0f 84 60 ff ff ff    	je     8010092e <consoleintr+0x1e>
        input.e--;
801009ce:	83 e8 01             	sub    $0x1,%eax
801009d1:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
801009d6:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
801009db:	85 c0                	test   %eax,%eax
801009dd:	0f 84 e6 00 00 00    	je     80100ac9 <consoleintr+0x1b9>
801009e3:	fa                   	cli
801009e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801009e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801009ef:	00 
    for(;;)
801009f0:	eb fe                	jmp    801009f0 <consoleintr+0xe0>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801009f2:	8b 15 08 ff 10 80    	mov    0x8010ff08,%edx
801009f8:	89 d1                	mov    %edx,%ecx
801009fa:	2b 0d 00 ff 10 80    	sub    0x8010ff00,%ecx
80100a00:	83 f9 7f             	cmp    $0x7f,%ecx
80100a03:	0f 87 25 ff ff ff    	ja     8010092e <consoleintr+0x1e>
80100a09:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(panicked){
80100a0c:	8b 3d 58 ff 10 80    	mov    0x8010ff58,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100a12:	8d 4a 01             	lea    0x1(%edx),%ecx
80100a15:	83 e2 7f             	and    $0x7f,%edx
80100a18:	89 0d 08 ff 10 80    	mov    %ecx,0x8010ff08
80100a1e:	88 82 80 fe 10 80    	mov    %al,-0x7fef0180(%edx)
  if(panicked){
80100a24:	85 ff                	test   %edi,%edi
80100a26:	0f 85 b8 00 00 00    	jne    80100ae4 <consoleintr+0x1d4>
  if(c == BACKSPACE){
80100a2c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100a2f:	e8 fc f9 ff ff       	call   80100430 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100a34:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100a37:	8b 15 08 ff 10 80    	mov    0x8010ff08,%edx
80100a3d:	83 f8 0a             	cmp    $0xa,%eax
80100a40:	74 69                	je     80100aab <consoleintr+0x19b>
80100a42:	83 f8 04             	cmp    $0x4,%eax
80100a45:	74 64                	je     80100aab <consoleintr+0x19b>
80100a47:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
80100a4c:	83 e8 80             	sub    $0xffffff80,%eax
80100a4f:	39 d0                	cmp    %edx,%eax
80100a51:	74 58                	je     80100aab <consoleintr+0x19b>
80100a53:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100a56:	e9 d3 fe ff ff       	jmp    8010092e <consoleintr+0x1e>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100a5b:	85 c0                	test   %eax,%eax
80100a5d:	0f 84 cb fe ff ff    	je     8010092e <consoleintr+0x1e>
80100a63:	8b 15 08 ff 10 80    	mov    0x8010ff08,%edx
80100a69:	89 7d fc             	mov    %edi,-0x4(%ebp)
80100a6c:	89 d1                	mov    %edx,%ecx
80100a6e:	2b 0d 00 ff 10 80    	sub    0x8010ff00,%ecx
80100a74:	83 f9 7f             	cmp    $0x7f,%ecx
80100a77:	77 da                	ja     80100a53 <consoleintr+0x143>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a79:	8d 4a 01             	lea    0x1(%edx),%ecx
  if(panicked){
80100a7c:	8b 3d 58 ff 10 80    	mov    0x8010ff58,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100a82:	83 e2 7f             	and    $0x7f,%edx
        c = (c == '\r') ? '\n' : c;
80100a85:	83 f8 0d             	cmp    $0xd,%eax
80100a88:	75 8e                	jne    80100a18 <consoleintr+0x108>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a8a:	89 0d 08 ff 10 80    	mov    %ecx,0x8010ff08
80100a90:	c6 82 80 fe 10 80 0a 	movb   $0xa,-0x7fef0180(%edx)
  if(panicked){
80100a97:	85 ff                	test   %edi,%edi
80100a99:	75 49                	jne    80100ae4 <consoleintr+0x1d4>
  if(c == BACKSPACE){
80100a9b:	b8 0a 00 00 00       	mov    $0xa,%eax
80100aa0:	e8 8b f9 ff ff       	call   80100430 <consputc.part.0>
          input.w = input.e;
80100aa5:	8b 15 08 ff 10 80    	mov    0x8010ff08,%edx
          wakeup(&input.r);
80100aab:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100aae:	89 15 04 ff 10 80    	mov    %edx,0x8010ff04
          wakeup(&input.r);
80100ab4:	68 00 ff 10 80       	push   $0x8010ff00
80100ab9:	e8 b2 38 00 00       	call   80104370 <wakeup>
80100abe:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100ac1:	83 c4 10             	add    $0x10,%esp
80100ac4:	e9 65 fe ff ff       	jmp    8010092e <consoleintr+0x1e>
  if(c == BACKSPACE){
80100ac9:	b8 00 01 00 00       	mov    $0x100,%eax
80100ace:	e8 5d f9 ff ff       	call   80100430 <consputc.part.0>
80100ad3:	e9 56 fe ff ff       	jmp    8010092e <consoleintr+0x1e>
}
80100ad8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100adb:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100ade:	c9                   	leave
    procdump();  // now call procdump() wo. cons.lock held
80100adf:	e9 6c 39 00 00       	jmp    80104450 <procdump>
80100ae4:	fa                   	cli
80100ae5:	90                   	nop
80100ae6:	66 90                	xchg   %ax,%ax
80100ae8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100aef:	00 
    for(;;)
80100af0:	eb fe                	jmp    80100af0 <consoleintr+0x1e0>
80100af2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100af8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100aff:	00 

80100b00 <consoleinit>:

void
consoleinit(void)
{
80100b00:	55                   	push   %ebp
80100b01:	89 e5                	mov    %esp,%ebp
80100b03:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100b06:	68 68 79 10 80       	push   $0x80107968
80100b0b:	68 20 ff 10 80       	push   $0x8010ff20
80100b10:	e8 2b 3d 00 00       	call   80104840 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100b15:	58                   	pop    %eax
80100b16:	5a                   	pop    %edx
80100b17:	6a 00                	push   $0x0
80100b19:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100b1b:	c7 05 0c 09 11 80 e0 	movl   $0x801005e0,0x8011090c
80100b22:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100b25:	c7 05 08 09 11 80 a0 	movl   $0x801002a0,0x80110908
80100b2c:	02 10 80 
  cons.locking = 1;
80100b2f:	c7 05 54 ff 10 80 01 	movl   $0x1,0x8010ff54
80100b36:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100b39:	e8 c2 1a 00 00       	call   80102600 <ioapicenable>
}
80100b3e:	83 c4 10             	add    $0x10,%esp
80100b41:	c9                   	leave
80100b42:	c3                   	ret
80100b43:	66 90                	xchg   %ax,%ax
80100b45:	66 90                	xchg   %ax,%ax
80100b47:	66 90                	xchg   %ax,%ax
80100b49:	66 90                	xchg   %ax,%ax
80100b4b:	66 90                	xchg   %ax,%ax
80100b4d:	66 90                	xchg   %ax,%ax
80100b4f:	90                   	nop

80100b50 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100b50:	55                   	push   %ebp
80100b51:	89 e5                	mov    %esp,%ebp
80100b53:	81 ec 18 01 00 00    	sub    $0x118,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100b59:	e8 42 30 00 00       	call   80103ba0 <myproc>
80100b5e:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100b64:	e8 d7 23 00 00       	call   80102f40 <begin_op>

  if((ip = namei(path)) == 0){
80100b69:	83 ec 0c             	sub    $0xc,%esp
80100b6c:	ff 75 08             	push   0x8(%ebp)
80100b6f:	e8 7c 16 00 00       	call   801021f0 <namei>
80100b74:	83 c4 10             	add    $0x10,%esp
80100b77:	85 c0                	test   %eax,%eax
80100b79:	0f 84 19 03 00 00    	je     80100e98 <exec+0x348>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100b7f:	83 ec 0c             	sub    $0xc,%esp
80100b82:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80100b85:	89 c3                	mov    %eax,%ebx
80100b87:	50                   	push   %eax
80100b88:	e8 d3 0c 00 00       	call   80101860 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100b8d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100b93:	6a 34                	push   $0x34
80100b95:	6a 00                	push   $0x0
80100b97:	50                   	push   %eax
80100b98:	53                   	push   %ebx
80100b99:	e8 f2 0f 00 00       	call   80101b90 <readi>
80100b9e:	83 c4 20             	add    $0x20,%esp
80100ba1:	83 f8 34             	cmp    $0x34,%eax
80100ba4:	74 22                	je     80100bc8 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100ba6:	83 ec 0c             	sub    $0xc,%esp
80100ba9:	53                   	push   %ebx
80100baa:	e8 61 0f 00 00       	call   80101b10 <iunlockput>
    end_op();
80100baf:	e8 fc 23 00 00       	call   80102fb0 <end_op>
80100bb4:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100bb7:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
}
80100bba:	c9                   	leave
    return -1;
80100bbb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100bc0:	c3                   	ret
80100bc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100bc8:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100bcf:	45 4c 46 
80100bd2:	75 d2                	jne    80100ba6 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100bd4:	e8 c7 69 00 00       	call   801075a0 <setupkvm>
80100bd9:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100bdf:	85 c0                	test   %eax,%eax
80100be1:	74 c3                	je     80100ba6 <exec+0x56>
80100be3:	89 75 f8             	mov    %esi,-0x8(%ebp)
80100be6:	89 7d fc             	mov    %edi,-0x4(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100be9:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100bf0:	00 
80100bf1:	0f 84 bb 02 00 00    	je     80100eb2 <exec+0x362>
  sz = 0;
80100bf7:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100bfe:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c01:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100c07:	31 ff                	xor    %edi,%edi
80100c09:	e9 88 00 00 00       	jmp    80100c96 <exec+0x146>
80100c0e:	66 90                	xchg   %ax,%ax
    if(ph.type != ELF_PROG_LOAD)
80100c10:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100c17:	75 6c                	jne    80100c85 <exec+0x135>
    if(ph.memsz < ph.filesz)
80100c19:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100c1f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100c25:	0f 82 87 00 00 00    	jb     80100cb2 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100c2b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100c31:	72 7f                	jb     80100cb2 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100c33:	83 ec 04             	sub    $0x4,%esp
80100c36:	50                   	push   %eax
80100c37:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100c3d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c43:	e8 68 67 00 00       	call   801073b0 <allocuvm>
80100c48:	83 c4 10             	add    $0x10,%esp
80100c4b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100c51:	85 c0                	test   %eax,%eax
80100c53:	74 5d                	je     80100cb2 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80100c55:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100c5b:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100c60:	75 50                	jne    80100cb2 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c62:	83 ec 0c             	sub    $0xc,%esp
80100c65:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100c6b:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100c71:	53                   	push   %ebx
80100c72:	50                   	push   %eax
80100c73:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c79:	e8 52 66 00 00       	call   801072d0 <loaduvm>
80100c7e:	83 c4 20             	add    $0x20,%esp
80100c81:	85 c0                	test   %eax,%eax
80100c83:	78 2d                	js     80100cb2 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c85:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100c8c:	83 c7 01             	add    $0x1,%edi
80100c8f:	83 c6 20             	add    $0x20,%esi
80100c92:	39 f8                	cmp    %edi,%eax
80100c94:	7e 3a                	jle    80100cd0 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100c96:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100c9c:	6a 20                	push   $0x20
80100c9e:	56                   	push   %esi
80100c9f:	50                   	push   %eax
80100ca0:	53                   	push   %ebx
80100ca1:	e8 ea 0e 00 00       	call   80101b90 <readi>
80100ca6:	83 c4 10             	add    $0x10,%esp
80100ca9:	83 f8 20             	cmp    $0x20,%eax
80100cac:	0f 84 5e ff ff ff    	je     80100c10 <exec+0xc0>
    freevm(pgdir);
80100cb2:	83 ec 0c             	sub    $0xc,%esp
80100cb5:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100cbb:	e8 60 68 00 00       	call   80107520 <freevm>
  if(ip){
80100cc0:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100cc3:	8b 7d fc             	mov    -0x4(%ebp),%edi
    freevm(pgdir);
80100cc6:	83 c4 10             	add    $0x10,%esp
80100cc9:	e9 d8 fe ff ff       	jmp    80100ba6 <exec+0x56>
80100cce:	66 90                	xchg   %ax,%ax
  sz = PGROUNDUP(sz);
80100cd0:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100cd6:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100cdc:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100ce2:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100ce8:	83 ec 0c             	sub    $0xc,%esp
80100ceb:	53                   	push   %ebx
80100cec:	e8 1f 0e 00 00       	call   80101b10 <iunlockput>
  end_op();
80100cf1:	e8 ba 22 00 00       	call   80102fb0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100cf6:	83 c4 0c             	add    $0xc,%esp
80100cf9:	56                   	push   %esi
80100cfa:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100d00:	57                   	push   %edi
80100d01:	56                   	push   %esi
80100d02:	e8 a9 66 00 00       	call   801073b0 <allocuvm>
80100d07:	83 c4 10             	add    $0x10,%esp
80100d0a:	89 c7                	mov    %eax,%edi
80100d0c:	85 c0                	test   %eax,%eax
80100d0e:	0f 84 9c 00 00 00    	je     80100db0 <exec+0x260>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d14:	83 ec 08             	sub    $0x8,%esp
80100d17:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  sp = sz;
80100d1d:	89 fb                	mov    %edi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d1f:	50                   	push   %eax
80100d20:	56                   	push   %esi
  for(argc = 0; argv[argc]; argc++) {
80100d21:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d23:	e8 18 69 00 00       	call   80107640 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100d28:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d2b:	83 c4 10             	add    $0x10,%esp
80100d2e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100d34:	8b 00                	mov    (%eax),%eax
80100d36:	85 c0                	test   %eax,%eax
80100d38:	0f 84 99 00 00 00    	je     80100dd7 <exec+0x287>
80100d3e:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
80100d44:	89 f7                	mov    %esi,%edi
80100d46:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100d4c:	eb 21                	jmp    80100d6f <exec+0x21f>
80100d4e:	66 90                	xchg   %ax,%ax
80100d50:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100d53:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100d5a:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100d5d:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100d63:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100d66:	85 c0                	test   %eax,%eax
80100d68:	74 65                	je     80100dcf <exec+0x27f>
    if(argc >= MAXARG)
80100d6a:	83 ff 20             	cmp    $0x20,%edi
80100d6d:	74 41                	je     80100db0 <exec+0x260>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d6f:	83 ec 0c             	sub    $0xc,%esp
80100d72:	50                   	push   %eax
80100d73:	e8 28 40 00 00       	call   80104da0 <strlen>
80100d78:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d7a:	58                   	pop    %eax
80100d7b:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d7e:	83 eb 01             	sub    $0x1,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d81:	ff 34 b8             	push   (%eax,%edi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d84:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d87:	e8 14 40 00 00       	call   80104da0 <strlen>
80100d8c:	83 c0 01             	add    $0x1,%eax
80100d8f:	50                   	push   %eax
80100d90:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d93:	ff 34 b8             	push   (%eax,%edi,4)
80100d96:	53                   	push   %ebx
80100d97:	56                   	push   %esi
80100d98:	e8 73 6a 00 00       	call   80107810 <copyout>
80100d9d:	83 c4 20             	add    $0x20,%esp
80100da0:	85 c0                	test   %eax,%eax
80100da2:	79 ac                	jns    80100d50 <exec+0x200>
80100da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100da8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100daf:	00 
    freevm(pgdir);
80100db0:	83 ec 0c             	sub    $0xc,%esp
80100db3:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100db9:	e8 62 67 00 00       	call   80107520 <freevm>
  if(ip){
80100dbe:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100dc1:	8b 75 f8             	mov    -0x8(%ebp),%esi
    freevm(pgdir);
80100dc4:	83 c4 10             	add    $0x10,%esp
80100dc7:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100dca:	e9 eb fd ff ff       	jmp    80100bba <exec+0x6a>
80100dcf:	89 fe                	mov    %edi,%esi
80100dd1:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100dd7:	8d 04 b5 04 00 00 00 	lea    0x4(,%esi,4),%eax
80100dde:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100de0:	c7 84 b5 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%esi,4)
80100de7:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100deb:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100ded:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80100df0:	89 b5 5c ff ff ff    	mov    %esi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80100df6:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100df8:	50                   	push   %eax
80100df9:	52                   	push   %edx
80100dfa:	53                   	push   %ebx
80100dfb:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80100e01:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100e08:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e0b:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e11:	e8 fa 69 00 00       	call   80107810 <copyout>
80100e16:	83 c4 10             	add    $0x10,%esp
80100e19:	85 c0                	test   %eax,%eax
80100e1b:	78 93                	js     80100db0 <exec+0x260>
  for(last=s=path; *s; s++)
80100e1d:	8b 45 08             	mov    0x8(%ebp),%eax
80100e20:	8b 55 08             	mov    0x8(%ebp),%edx
80100e23:	0f b6 00             	movzbl (%eax),%eax
80100e26:	84 c0                	test   %al,%al
80100e28:	74 15                	je     80100e3f <exec+0x2ef>
80100e2a:	89 d1                	mov    %edx,%ecx
80100e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      last = s+1;
80100e30:	83 c1 01             	add    $0x1,%ecx
80100e33:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100e35:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80100e38:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100e3b:	84 c0                	test   %al,%al
80100e3d:	75 f1                	jne    80100e30 <exec+0x2e0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100e3f:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100e45:	83 ec 04             	sub    $0x4,%esp
80100e48:	6a 10                	push   $0x10
80100e4a:	8d 46 6c             	lea    0x6c(%esi),%eax
80100e4d:	52                   	push   %edx
80100e4e:	50                   	push   %eax
80100e4f:	e8 fc 3e 00 00       	call   80104d50 <safestrcpy>
  curproc->pgdir = pgdir;
80100e54:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100e5a:	89 f0                	mov    %esi,%eax
80100e5c:	8b 76 04             	mov    0x4(%esi),%esi
  curproc->sz = sz;
80100e5f:	89 38                	mov    %edi,(%eax)
  curproc->pgdir = pgdir;
80100e61:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100e64:	89 c1                	mov    %eax,%ecx
80100e66:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100e6c:	8b 40 18             	mov    0x18(%eax),%eax
80100e6f:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100e72:	8b 41 18             	mov    0x18(%ecx),%eax
80100e75:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100e78:	89 0c 24             	mov    %ecx,(%esp)
80100e7b:	e8 c0 62 00 00       	call   80107140 <switchuvm>
  freevm(oldpgdir);
80100e80:	89 34 24             	mov    %esi,(%esp)
80100e83:	e8 98 66 00 00       	call   80107520 <freevm>
  return 0;
80100e88:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100e8b:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100e8e:	83 c4 10             	add    $0x10,%esp
80100e91:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100e94:	31 c0                	xor    %eax,%eax
}
80100e96:	c9                   	leave
80100e97:	c3                   	ret
    end_op();
80100e98:	e8 13 21 00 00       	call   80102fb0 <end_op>
    cprintf("exec: fail\n");
80100e9d:	83 ec 0c             	sub    $0xc,%esp
80100ea0:	68 70 79 10 80       	push   $0x80107970
80100ea5:	e8 46 f8 ff ff       	call   801006f0 <cprintf>
    return -1;
80100eaa:	83 c4 10             	add    $0x10,%esp
80100ead:	e9 08 fd ff ff       	jmp    80100bba <exec+0x6a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100eb2:	be 00 20 00 00       	mov    $0x2000,%esi
80100eb7:	31 ff                	xor    %edi,%edi
80100eb9:	e9 2a fe ff ff       	jmp    80100ce8 <exec+0x198>
80100ebe:	66 90                	xchg   %ax,%ax

80100ec0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100ec0:	55                   	push   %ebp
80100ec1:	89 e5                	mov    %esp,%ebp
80100ec3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100ec6:	68 7c 79 10 80       	push   $0x8010797c
80100ecb:	68 60 ff 10 80       	push   $0x8010ff60
80100ed0:	e8 6b 39 00 00       	call   80104840 <initlock>
}
80100ed5:	83 c4 10             	add    $0x10,%esp
80100ed8:	c9                   	leave
80100ed9:	c3                   	ret
80100eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100ee0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100ee0:	55                   	push   %ebp
80100ee1:	89 e5                	mov    %esp,%ebp
80100ee3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100ee4:	bb 94 ff 10 80       	mov    $0x8010ff94,%ebx
{
80100ee9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100eec:	68 60 ff 10 80       	push   $0x8010ff60
80100ef1:	e8 6a 3b 00 00       	call   80104a60 <acquire>
80100ef6:	83 c4 10             	add    $0x10,%esp
80100ef9:	eb 10                	jmp    80100f0b <filealloc+0x2b>
80100efb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f00:	83 c3 18             	add    $0x18,%ebx
80100f03:	81 fb f4 08 11 80    	cmp    $0x801108f4,%ebx
80100f09:	74 25                	je     80100f30 <filealloc+0x50>
    if(f->ref == 0){
80100f0b:	8b 43 04             	mov    0x4(%ebx),%eax
80100f0e:	85 c0                	test   %eax,%eax
80100f10:	75 ee                	jne    80100f00 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100f12:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100f15:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100f1c:	68 60 ff 10 80       	push   $0x8010ff60
80100f21:	e8 da 3a 00 00       	call   80104a00 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100f26:	89 d8                	mov    %ebx,%eax
      return f;
80100f28:	83 c4 10             	add    $0x10,%esp
}
80100f2b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f2e:	c9                   	leave
80100f2f:	c3                   	ret
  release(&ftable.lock);
80100f30:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100f33:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100f35:	68 60 ff 10 80       	push   $0x8010ff60
80100f3a:	e8 c1 3a 00 00       	call   80104a00 <release>
}
80100f3f:	89 d8                	mov    %ebx,%eax
  return 0;
80100f41:	83 c4 10             	add    $0x10,%esp
}
80100f44:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f47:	c9                   	leave
80100f48:	c3                   	ret
80100f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100f50 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100f50:	55                   	push   %ebp
80100f51:	89 e5                	mov    %esp,%ebp
80100f53:	53                   	push   %ebx
80100f54:	83 ec 10             	sub    $0x10,%esp
80100f57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100f5a:	68 60 ff 10 80       	push   $0x8010ff60
80100f5f:	e8 fc 3a 00 00       	call   80104a60 <acquire>
  if(f->ref < 1)
80100f64:	8b 43 04             	mov    0x4(%ebx),%eax
80100f67:	83 c4 10             	add    $0x10,%esp
80100f6a:	85 c0                	test   %eax,%eax
80100f6c:	7e 1a                	jle    80100f88 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100f6e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100f71:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100f74:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100f77:	68 60 ff 10 80       	push   $0x8010ff60
80100f7c:	e8 7f 3a 00 00       	call   80104a00 <release>
  return f;
}
80100f81:	89 d8                	mov    %ebx,%eax
80100f83:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f86:	c9                   	leave
80100f87:	c3                   	ret
    panic("filedup");
80100f88:	83 ec 0c             	sub    $0xc,%esp
80100f8b:	68 83 79 10 80       	push   $0x80107983
80100f90:	e8 0b f4 ff ff       	call   801003a0 <panic>
80100f95:	8d 76 00             	lea    0x0(%esi),%esi
80100f98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100f9f:	00 

80100fa0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100fa0:	55                   	push   %ebp
80100fa1:	89 e5                	mov    %esp,%ebp
80100fa3:	83 ec 34             	sub    $0x34,%esp
  struct file ff;

  acquire(&ftable.lock);
80100fa6:	68 60 ff 10 80       	push   $0x8010ff60
{
80100fab:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80100fae:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100fb1:	e8 aa 3a 00 00       	call   80104a60 <acquire>
  if(f->ref < 1)
80100fb6:	8b 43 04             	mov    0x4(%ebx),%eax
80100fb9:	83 c4 10             	add    $0x10,%esp
80100fbc:	85 c0                	test   %eax,%eax
80100fbe:	0f 8e a3 00 00 00    	jle    80101067 <fileclose+0xc7>
    panic("fileclose");
  if(--f->ref > 0){
80100fc4:	83 e8 01             	sub    $0x1,%eax
80100fc7:	89 43 04             	mov    %eax,0x4(%ebx)
80100fca:	75 44                	jne    80101010 <fileclose+0x70>
80100fcc:	89 75 f8             	mov    %esi,-0x8(%ebp)
    return;
  }
  ff = *f;
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100fcf:	83 ec 0c             	sub    $0xc,%esp
80100fd2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  ff = *f;
80100fd5:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fd8:	8b 33                	mov    (%ebx),%esi
80100fda:	0f b6 7b 09          	movzbl 0x9(%ebx),%edi
  f->type = FD_NONE;
80100fde:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100fe4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100fe7:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100fea:	68 60 ff 10 80       	push   $0x8010ff60
  ff = *f;
80100fef:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100ff2:	e8 09 3a 00 00       	call   80104a00 <release>

  if(ff.type == FD_PIPE)
80100ff7:	83 c4 10             	add    $0x10,%esp
80100ffa:	83 fe 01             	cmp    $0x1,%esi
80100ffd:	74 49                	je     80101048 <fileclose+0xa8>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100fff:	83 fe 02             	cmp    $0x2,%esi
80101002:	74 1c                	je     80101020 <fileclose+0x80>
80101004:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101007:	8b 7d fc             	mov    -0x4(%ebp),%edi
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
8010100a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010100d:	c9                   	leave
8010100e:	c3                   	ret
8010100f:	90                   	nop
    release(&ftable.lock);
80101010:	c7 45 08 60 ff 10 80 	movl   $0x8010ff60,0x8(%ebp)
}
80101017:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010101a:	c9                   	leave
    release(&ftable.lock);
8010101b:	e9 e0 39 00 00       	jmp    80104a00 <release>
    begin_op();
80101020:	e8 1b 1f 00 00       	call   80102f40 <begin_op>
    iput(ff.ip);
80101025:	83 ec 0c             	sub    $0xc,%esp
80101028:	ff 75 e0             	push   -0x20(%ebp)
8010102b:	e8 60 09 00 00       	call   80101990 <iput>
    end_op();
80101030:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101033:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101036:	83 c4 10             	add    $0x10,%esp
}
80101039:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010103c:	c9                   	leave
    end_op();
8010103d:	e9 6e 1f 00 00       	jmp    80102fb0 <end_op>
80101042:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80101048:	89 f8                	mov    %edi,%eax
8010104a:	83 ec 08             	sub    $0x8,%esp
8010104d:	0f be c0             	movsbl %al,%eax
80101050:	50                   	push   %eax
80101051:	ff 75 e4             	push   -0x1c(%ebp)
80101054:	e8 a7 26 00 00       	call   80103700 <pipeclose>
80101059:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010105c:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010105f:	83 c4 10             	add    $0x10,%esp
}
80101062:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101065:	c9                   	leave
80101066:	c3                   	ret
    panic("fileclose");
80101067:	83 ec 0c             	sub    $0xc,%esp
8010106a:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010106d:	68 8b 79 10 80       	push   $0x8010798b
80101072:	89 7d fc             	mov    %edi,-0x4(%ebp)
80101075:	e8 26 f3 ff ff       	call   801003a0 <panic>
8010107a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101080 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101080:	55                   	push   %ebp
80101081:	89 e5                	mov    %esp,%ebp
80101083:	53                   	push   %ebx
80101084:	83 ec 04             	sub    $0x4,%esp
80101087:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010108a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010108d:	75 31                	jne    801010c0 <filestat+0x40>
    ilock(f->ip);
8010108f:	83 ec 0c             	sub    $0xc,%esp
80101092:	ff 73 10             	push   0x10(%ebx)
80101095:	e8 c6 07 00 00       	call   80101860 <ilock>
    stati(f->ip, st);
8010109a:	58                   	pop    %eax
8010109b:	5a                   	pop    %edx
8010109c:	ff 75 0c             	push   0xc(%ebp)
8010109f:	ff 73 10             	push   0x10(%ebx)
801010a2:	e8 b9 0a 00 00       	call   80101b60 <stati>
    iunlock(f->ip);
801010a7:	59                   	pop    %ecx
801010a8:	ff 73 10             	push   0x10(%ebx)
801010ab:	e8 90 08 00 00       	call   80101940 <iunlock>
    return 0;
  }
  return -1;
}
801010b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
801010b3:	83 c4 10             	add    $0x10,%esp
801010b6:	31 c0                	xor    %eax,%eax
}
801010b8:	c9                   	leave
801010b9:	c3                   	ret
801010ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801010c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801010c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801010c8:	c9                   	leave
801010c9:	c3                   	ret
801010ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801010d0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801010d0:	55                   	push   %ebp
801010d1:	89 e5                	mov    %esp,%ebp
801010d3:	57                   	push   %edi
801010d4:	56                   	push   %esi
801010d5:	53                   	push   %ebx
801010d6:	83 ec 0c             	sub    $0xc,%esp
801010d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801010dc:	8b 75 0c             	mov    0xc(%ebp),%esi
801010df:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
801010e2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801010e6:	74 60                	je     80101148 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
801010e8:	8b 03                	mov    (%ebx),%eax
801010ea:	83 f8 01             	cmp    $0x1,%eax
801010ed:	74 41                	je     80101130 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010ef:	83 f8 02             	cmp    $0x2,%eax
801010f2:	75 5b                	jne    8010114f <fileread+0x7f>
    ilock(f->ip);
801010f4:	83 ec 0c             	sub    $0xc,%esp
801010f7:	ff 73 10             	push   0x10(%ebx)
801010fa:	e8 61 07 00 00       	call   80101860 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801010ff:	57                   	push   %edi
80101100:	ff 73 14             	push   0x14(%ebx)
80101103:	56                   	push   %esi
80101104:	ff 73 10             	push   0x10(%ebx)
80101107:	e8 84 0a 00 00       	call   80101b90 <readi>
8010110c:	83 c4 20             	add    $0x20,%esp
8010110f:	89 c6                	mov    %eax,%esi
80101111:	85 c0                	test   %eax,%eax
80101113:	7e 03                	jle    80101118 <fileread+0x48>
      f->off += r;
80101115:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101118:	83 ec 0c             	sub    $0xc,%esp
8010111b:	ff 73 10             	push   0x10(%ebx)
8010111e:	e8 1d 08 00 00       	call   80101940 <iunlock>
    return r;
80101123:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101126:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101129:	89 f0                	mov    %esi,%eax
8010112b:	5b                   	pop    %ebx
8010112c:	5e                   	pop    %esi
8010112d:	5f                   	pop    %edi
8010112e:	5d                   	pop    %ebp
8010112f:	c3                   	ret
    return piperead(f->pipe, addr, n);
80101130:	8b 43 0c             	mov    0xc(%ebx),%eax
80101133:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101136:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101139:	5b                   	pop    %ebx
8010113a:	5e                   	pop    %esi
8010113b:	5f                   	pop    %edi
8010113c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010113d:	e9 7e 27 00 00       	jmp    801038c0 <piperead>
80101142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101148:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010114d:	eb d7                	jmp    80101126 <fileread+0x56>
  panic("fileread");
8010114f:	83 ec 0c             	sub    $0xc,%esp
80101152:	68 95 79 10 80       	push   $0x80107995
80101157:	e8 44 f2 ff ff       	call   801003a0 <panic>
8010115c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101160 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101160:	55                   	push   %ebp
80101161:	89 e5                	mov    %esp,%ebp
80101163:	83 ec 28             	sub    $0x28,%esp
80101166:	8b 45 0c             	mov    0xc(%ebp),%eax
80101169:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010116c:	8b 7d 08             	mov    0x8(%ebp),%edi
8010116f:	89 75 f8             	mov    %esi,-0x8(%ebp)
80101172:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101175:	8b 45 10             	mov    0x10(%ebp),%eax
80101178:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
8010117b:	80 7f 09 00          	cmpb   $0x0,0x9(%edi)
8010117f:	0f 84 e9 00 00 00    	je     8010126e <filewrite+0x10e>
    return -1;
  if(f->type == FD_PIPE)
80101185:	8b 17                	mov    (%edi),%edx
80101187:	83 fa 01             	cmp    $0x1,%edx
8010118a:	0f 84 c8 00 00 00    	je     80101258 <filewrite+0xf8>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101190:	83 fa 02             	cmp    $0x2,%edx
80101193:	0f 85 dc 00 00 00    	jne    80101275 <filewrite+0x115>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101199:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010119c:	85 d2                	test   %edx,%edx
8010119e:	0f 8e c6 00 00 00    	jle    8010126a <filewrite+0x10a>
801011a4:	89 5d f4             	mov    %ebx,-0xc(%ebp)
    int i = 0;
801011a7:	31 f6                	xor    %esi,%esi
801011a9:	eb 2a                	jmp    801011d5 <filewrite+0x75>
801011ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801011b0:	01 47 14             	add    %eax,0x14(%edi)
      iunlock(f->ip);
801011b3:	83 ec 0c             	sub    $0xc,%esp
801011b6:	51                   	push   %ecx
        f->off += r;
801011b7:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801011ba:	e8 81 07 00 00       	call   80101940 <iunlock>
      end_op();
801011bf:	e8 ec 1d 00 00       	call   80102fb0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
801011c4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801011c7:	83 c4 10             	add    $0x10,%esp
801011ca:	39 d8                	cmp    %ebx,%eax
801011cc:	75 5d                	jne    8010122b <filewrite+0xcb>
        panic("short filewrite");
      i += r;
801011ce:	01 c6                	add    %eax,%esi
    while(i < n){
801011d0:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801011d3:	7e 6b                	jle    80101240 <filewrite+0xe0>
      int n1 = n - i;
801011d5:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
      if(n1 > max)
801011d8:	b8 00 06 00 00       	mov    $0x600,%eax
      int n1 = n - i;
801011dd:	29 f3                	sub    %esi,%ebx
      if(n1 > max)
801011df:	39 c3                	cmp    %eax,%ebx
801011e1:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
801011e4:	e8 57 1d 00 00       	call   80102f40 <begin_op>
      ilock(f->ip);
801011e9:	83 ec 0c             	sub    $0xc,%esp
801011ec:	ff 77 10             	push   0x10(%edi)
801011ef:	e8 6c 06 00 00       	call   80101860 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801011f4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011f7:	53                   	push   %ebx
801011f8:	ff 77 14             	push   0x14(%edi)
801011fb:	01 f0                	add    %esi,%eax
801011fd:	50                   	push   %eax
801011fe:	ff 77 10             	push   0x10(%edi)
80101201:	e8 aa 0a 00 00       	call   80101cb0 <writei>
      iunlock(f->ip);
80101206:	8b 4f 10             	mov    0x10(%edi),%ecx
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101209:	83 c4 20             	add    $0x20,%esp
8010120c:	85 c0                	test   %eax,%eax
8010120e:	7f a0                	jg     801011b0 <filewrite+0x50>
      iunlock(f->ip);
80101210:	83 ec 0c             	sub    $0xc,%esp
80101213:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101216:	51                   	push   %ecx
80101217:	e8 24 07 00 00       	call   80101940 <iunlock>
      end_op();
8010121c:	e8 8f 1d 00 00       	call   80102fb0 <end_op>
      if(r < 0)
80101221:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101224:	83 c4 10             	add    $0x10,%esp
80101227:	85 c0                	test   %eax,%eax
80101229:	75 15                	jne    80101240 <filewrite+0xe0>
        panic("short filewrite");
8010122b:	83 ec 0c             	sub    $0xc,%esp
8010122e:	68 9e 79 10 80       	push   $0x8010799e
80101233:	e8 68 f1 ff ff       	call   801003a0 <panic>
80101238:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010123f:	00 
80101240:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    return -1;
80101243:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80101246:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010124b:	0f 45 f0             	cmovne %eax,%esi
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
8010124e:	89 f0                	mov    %esi,%eax
80101250:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101253:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101256:	c9                   	leave
80101257:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
80101258:	8b 47 0c             	mov    0xc(%edi),%eax
}
8010125b:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010125e:	8b 7d fc             	mov    -0x4(%ebp),%edi
    return pipewrite(f->pipe, addr, n);
80101261:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101264:	c9                   	leave
    return pipewrite(f->pipe, addr, n);
80101265:	e9 36 25 00 00       	jmp    801037a0 <pipewrite>
    int i = 0;
8010126a:	31 f6                	xor    %esi,%esi
8010126c:	eb d5                	jmp    80101243 <filewrite+0xe3>
    return -1;
8010126e:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101273:	eb d9                	jmp    8010124e <filewrite+0xee>
  panic("filewrite");
80101275:	83 ec 0c             	sub    $0xc,%esp
80101278:	89 5d f4             	mov    %ebx,-0xc(%ebp)
8010127b:	68 a4 79 10 80       	push   $0x801079a4
80101280:	e8 1b f1 ff ff       	call   801003a0 <panic>
80101285:	66 90                	xchg   %ax,%ax
80101287:	66 90                	xchg   %ax,%ax
80101289:	66 90                	xchg   %ax,%ax
8010128b:	66 90                	xchg   %ax,%ax
8010128d:	66 90                	xchg   %ax,%ax
8010128f:	90                   	nop

80101290 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101290:	55                   	push   %ebp
80101291:	89 e5                	mov    %esp,%ebp
80101293:	57                   	push   %edi
80101294:	56                   	push   %esi
80101295:	53                   	push   %ebx
80101296:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101299:	8b 0d b4 25 11 80    	mov    0x801125b4,%ecx
{
8010129f:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801012a2:	85 c9                	test   %ecx,%ecx
801012a4:	0f 84 8a 00 00 00    	je     80101334 <balloc+0xa4>
801012aa:	31 ff                	xor    %edi,%edi
    bp = bread(dev, BBLOCK(b, sb));
801012ac:	89 f8                	mov    %edi,%eax
801012ae:	83 ec 08             	sub    $0x8,%esp
801012b1:	89 fe                	mov    %edi,%esi
801012b3:	c1 f8 0c             	sar    $0xc,%eax
801012b6:	03 05 cc 25 11 80    	add    0x801125cc,%eax
801012bc:	50                   	push   %eax
801012bd:	ff 75 dc             	push   -0x24(%ebp)
801012c0:	e8 0b ee ff ff       	call   801000d0 <bread>
801012c5:	83 c4 10             	add    $0x10,%esp
801012c8:	89 7d d8             	mov    %edi,-0x28(%ebp)
801012cb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801012ce:	a1 b4 25 11 80       	mov    0x801125b4,%eax
801012d3:	89 45 e0             	mov    %eax,-0x20(%ebp)
801012d6:	31 c0                	xor    %eax,%eax
801012d8:	eb 32                	jmp    8010130c <balloc+0x7c>
801012da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801012e0:	89 c1                	mov    %eax,%ecx
801012e2:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801012e7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      m = 1 << (bi % 8);
801012ea:	83 e1 07             	and    $0x7,%ecx
801012ed:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801012ef:	89 c1                	mov    %eax,%ecx
801012f1:	c1 f9 03             	sar    $0x3,%ecx
801012f4:	0f b6 7c 0f 5c       	movzbl 0x5c(%edi,%ecx,1),%edi
801012f9:	89 fa                	mov    %edi,%edx
801012fb:	85 df                	test   %ebx,%edi
801012fd:	74 49                	je     80101348 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801012ff:	83 c0 01             	add    $0x1,%eax
80101302:	83 c6 01             	add    $0x1,%esi
80101305:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010130a:	74 05                	je     80101311 <balloc+0x81>
8010130c:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010130f:	72 cf                	jb     801012e0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101311:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101314:	83 ec 0c             	sub    $0xc,%esp
80101317:	ff 75 e4             	push   -0x1c(%ebp)
  for(b = 0; b < sb.size; b += BPB){
8010131a:	81 c7 00 10 00 00    	add    $0x1000,%edi
    brelse(bp);
80101320:	e8 db ee ff ff       	call   80100200 <brelse>
  for(b = 0; b < sb.size; b += BPB){
80101325:	83 c4 10             	add    $0x10,%esp
80101328:	3b 3d b4 25 11 80    	cmp    0x801125b4,%edi
8010132e:	0f 82 78 ff ff ff    	jb     801012ac <balloc+0x1c>
  }
  panic("balloc: out of blocks");
80101334:	83 ec 0c             	sub    $0xc,%esp
80101337:	68 ae 79 10 80       	push   $0x801079ae
8010133c:	e8 5f f0 ff ff       	call   801003a0 <panic>
80101341:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
80101348:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
8010134b:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
8010134e:	09 da                	or     %ebx,%edx
80101350:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
80101354:	57                   	push   %edi
80101355:	e8 c6 1d 00 00       	call   80103120 <log_write>
        brelse(bp);
8010135a:	89 3c 24             	mov    %edi,(%esp)
8010135d:	e8 9e ee ff ff       	call   80100200 <brelse>
  bp = bread(dev, bno);
80101362:	58                   	pop    %eax
80101363:	5a                   	pop    %edx
80101364:	56                   	push   %esi
80101365:	ff 75 dc             	push   -0x24(%ebp)
80101368:	e8 63 ed ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
8010136d:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101370:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101372:	8d 40 5c             	lea    0x5c(%eax),%eax
80101375:	68 00 02 00 00       	push   $0x200
8010137a:	6a 00                	push   $0x0
8010137c:	50                   	push   %eax
8010137d:	e8 fe 37 00 00       	call   80104b80 <memset>
  log_write(bp);
80101382:	89 1c 24             	mov    %ebx,(%esp)
80101385:	e8 96 1d 00 00       	call   80103120 <log_write>
  brelse(bp);
8010138a:	89 1c 24             	mov    %ebx,(%esp)
8010138d:	e8 6e ee ff ff       	call   80100200 <brelse>
}
80101392:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101395:	89 f0                	mov    %esi,%eax
80101397:	5b                   	pop    %ebx
80101398:	5e                   	pop    %esi
80101399:	5f                   	pop    %edi
8010139a:	5d                   	pop    %ebp
8010139b:	c3                   	ret
8010139c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801013a0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801013a0:	55                   	push   %ebp
801013a1:	89 e5                	mov    %esp,%ebp
801013a3:	57                   	push   %edi
801013a4:	89 d7                	mov    %edx,%edi
801013a6:	56                   	push   %esi
801013a7:	89 c6                	mov    %eax,%esi
801013a9:	53                   	push   %ebx
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801013aa:	31 db                	xor    %ebx,%ebx
{
801013ac:	83 ec 28             	sub    $0x28,%esp
  acquire(&icache.lock);
801013af:	68 60 09 11 80       	push   $0x80110960
801013b4:	e8 a7 36 00 00       	call   80104a60 <acquire>
801013b9:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013bc:	b8 94 09 11 80       	mov    $0x80110994,%eax
801013c1:	eb 15                	jmp    801013d8 <iget+0x38>
801013c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013c8:	39 30                	cmp    %esi,(%eax)
801013ca:	74 6c                	je     80101438 <iget+0x98>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013cc:	05 90 00 00 00       	add    $0x90,%eax
801013d1:	3d b4 25 11 80       	cmp    $0x801125b4,%eax
801013d6:	74 28                	je     80101400 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013d8:	8b 50 08             	mov    0x8(%eax),%edx
801013db:	85 d2                	test   %edx,%edx
801013dd:	7f e9                	jg     801013c8 <iget+0x28>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801013df:	85 db                	test   %ebx,%ebx
801013e1:	75 e9                	jne    801013cc <iget+0x2c>
801013e3:	85 d2                	test   %edx,%edx
801013e5:	75 7c                	jne    80101463 <iget+0xc3>
      empty = ip;
801013e7:	89 c3                	mov    %eax,%ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013e9:	05 90 00 00 00       	add    $0x90,%eax
801013ee:	3d b4 25 11 80       	cmp    $0x801125b4,%eax
801013f3:	75 e3                	jne    801013d8 <iget+0x38>
801013f5:	8d 76 00             	lea    0x0(%esi),%esi
801013f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801013ff:	00 
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101400:	85 db                	test   %ebx,%ebx
80101402:	74 7b                	je     8010147f <iget+0xdf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101404:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101407:	89 33                	mov    %esi,(%ebx)
  ip->inum = inum;
80101409:	89 7b 04             	mov    %edi,0x4(%ebx)
  ip->ref = 1;
8010140c:	c7 43 08 01 00 00 00 	movl   $0x1,0x8(%ebx)
  ip->valid = 0;
80101413:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
  release(&icache.lock);
8010141a:	68 60 09 11 80       	push   $0x80110960
8010141f:	e8 dc 35 00 00       	call   80104a00 <release>

  return ip;
80101424:	83 c4 10             	add    $0x10,%esp
}
80101427:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010142a:	89 d8                	mov    %ebx,%eax
8010142c:	5b                   	pop    %ebx
8010142d:	5e                   	pop    %esi
8010142e:	5f                   	pop    %edi
8010142f:	5d                   	pop    %ebp
80101430:	c3                   	ret
80101431:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101438:	39 78 04             	cmp    %edi,0x4(%eax)
8010143b:	75 8f                	jne    801013cc <iget+0x2c>
      release(&icache.lock);
8010143d:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101440:	83 c2 01             	add    $0x1,%edx
80101443:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101446:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
80101449:	68 60 09 11 80       	push   $0x80110960
8010144e:	e8 ad 35 00 00       	call   80104a00 <release>
      return ip;
80101453:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101456:	83 c4 10             	add    $0x10,%esp
}
80101459:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010145c:	89 d8                	mov    %ebx,%eax
8010145e:	5b                   	pop    %ebx
8010145f:	5e                   	pop    %esi
80101460:	5f                   	pop    %edi
80101461:	5d                   	pop    %ebp
80101462:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101463:	05 90 00 00 00       	add    $0x90,%eax
80101468:	3d b4 25 11 80       	cmp    $0x801125b4,%eax
8010146d:	74 10                	je     8010147f <iget+0xdf>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010146f:	8b 50 08             	mov    0x8(%eax),%edx
80101472:	85 d2                	test   %edx,%edx
80101474:	0f 8f 4e ff ff ff    	jg     801013c8 <iget+0x28>
8010147a:	e9 64 ff ff ff       	jmp    801013e3 <iget+0x43>
    panic("iget: no inodes");
8010147f:	83 ec 0c             	sub    $0xc,%esp
80101482:	68 c4 79 10 80       	push   $0x801079c4
80101487:	e8 14 ef ff ff       	call   801003a0 <panic>
8010148c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101490 <bfree>:
{
80101490:	55                   	push   %ebp
80101491:	89 c1                	mov    %eax,%ecx
  bp = bread(dev, BBLOCK(b, sb));
80101493:	89 d0                	mov    %edx,%eax
80101495:	c1 e8 0c             	shr    $0xc,%eax
{
80101498:	89 e5                	mov    %esp,%ebp
8010149a:	56                   	push   %esi
8010149b:	53                   	push   %ebx
  bp = bread(dev, BBLOCK(b, sb));
8010149c:	03 05 cc 25 11 80    	add    0x801125cc,%eax
{
801014a2:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
801014a4:	83 ec 08             	sub    $0x8,%esp
801014a7:	50                   	push   %eax
801014a8:	51                   	push   %ecx
801014a9:	e8 22 ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
801014ae:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801014b0:	c1 fb 03             	sar    $0x3,%ebx
801014b3:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
801014b6:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
801014b8:	83 e1 07             	and    $0x7,%ecx
801014bb:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
801014c0:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
801014c6:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
801014c8:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
801014cd:	85 c1                	test   %eax,%ecx
801014cf:	74 23                	je     801014f4 <bfree+0x64>
  bp->data[bi/8] &= ~m;
801014d1:	f7 d0                	not    %eax
  log_write(bp);
801014d3:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
801014d6:	21 c8                	and    %ecx,%eax
801014d8:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
801014dc:	56                   	push   %esi
801014dd:	e8 3e 1c 00 00       	call   80103120 <log_write>
  brelse(bp);
801014e2:	89 34 24             	mov    %esi,(%esp)
801014e5:	e8 16 ed ff ff       	call   80100200 <brelse>
}
801014ea:	83 c4 10             	add    $0x10,%esp
801014ed:	8d 65 f8             	lea    -0x8(%ebp),%esp
801014f0:	5b                   	pop    %ebx
801014f1:	5e                   	pop    %esi
801014f2:	5d                   	pop    %ebp
801014f3:	c3                   	ret
    panic("freeing free block");
801014f4:	83 ec 0c             	sub    $0xc,%esp
801014f7:	68 d4 79 10 80       	push   $0x801079d4
801014fc:	e8 9f ee ff ff       	call   801003a0 <panic>
80101501:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101508:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010150f:	00 

80101510 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101510:	55                   	push   %ebp
80101511:	89 e5                	mov    %esp,%ebp
80101513:	56                   	push   %esi
80101514:	89 c6                	mov    %eax,%esi
80101516:	53                   	push   %ebx
80101517:	83 ec 10             	sub    $0x10,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010151a:	83 fa 0b             	cmp    $0xb,%edx
8010151d:	0f 86 8d 00 00 00    	jbe    801015b0 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101523:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101526:	83 fb 7f             	cmp    $0x7f,%ebx
80101529:	0f 87 a8 00 00 00    	ja     801015d7 <bmap+0xc7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
8010152f:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101535:	85 c0                	test   %eax,%eax
80101537:	74 67                	je     801015a0 <bmap+0x90>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101539:	83 ec 08             	sub    $0x8,%esp
8010153c:	50                   	push   %eax
8010153d:	ff 36                	push   (%esi)
8010153f:	e8 8c eb ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101544:	83 c4 10             	add    $0x10,%esp
80101547:	8d 4c 98 5c          	lea    0x5c(%eax,%ebx,4),%ecx
    bp = bread(ip->dev, addr);
8010154b:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
8010154d:	8b 19                	mov    (%ecx),%ebx
8010154f:	85 db                	test   %ebx,%ebx
80101551:	74 1d                	je     80101570 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101553:	83 ec 0c             	sub    $0xc,%esp
80101556:	52                   	push   %edx
80101557:	e8 a4 ec ff ff       	call   80100200 <brelse>
8010155c:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
8010155f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101562:	89 d8                	mov    %ebx,%eax
80101564:	5b                   	pop    %ebx
80101565:	5e                   	pop    %esi
80101566:	5d                   	pop    %ebp
80101567:	c3                   	ret
80101568:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010156f:	00 
80101570:	89 45 f4             	mov    %eax,-0xc(%ebp)
      a[bn] = addr = balloc(ip->dev);
80101573:	8b 06                	mov    (%esi),%eax
80101575:	89 4d f0             	mov    %ecx,-0x10(%ebp)
80101578:	e8 13 fd ff ff       	call   80101290 <balloc>
8010157d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
      log_write(bp);
80101580:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101583:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101586:	89 c3                	mov    %eax,%ebx
80101588:	89 01                	mov    %eax,(%ecx)
      log_write(bp);
8010158a:	52                   	push   %edx
8010158b:	e8 90 1b 00 00       	call   80103120 <log_write>
80101590:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101593:	83 c4 10             	add    $0x10,%esp
80101596:	eb bb                	jmp    80101553 <bmap+0x43>
80101598:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010159f:	00 
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801015a0:	8b 06                	mov    (%esi),%eax
801015a2:	e8 e9 fc ff ff       	call   80101290 <balloc>
801015a7:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801015ad:	eb 8a                	jmp    80101539 <bmap+0x29>
801015af:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
801015b0:	83 c2 14             	add    $0x14,%edx
801015b3:	8b 5c 90 0c          	mov    0xc(%eax,%edx,4),%ebx
801015b7:	85 db                	test   %ebx,%ebx
801015b9:	75 a4                	jne    8010155f <bmap+0x4f>
      ip->addrs[bn] = addr = balloc(ip->dev);
801015bb:	8b 00                	mov    (%eax),%eax
801015bd:	89 55 f4             	mov    %edx,-0xc(%ebp)
801015c0:	e8 cb fc ff ff       	call   80101290 <balloc>
801015c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801015c8:	89 c3                	mov    %eax,%ebx
801015ca:	89 44 96 0c          	mov    %eax,0xc(%esi,%edx,4)
}
801015ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801015d1:	89 d8                	mov    %ebx,%eax
801015d3:	5b                   	pop    %ebx
801015d4:	5e                   	pop    %esi
801015d5:	5d                   	pop    %ebp
801015d6:	c3                   	ret
  panic("bmap: out of range");
801015d7:	83 ec 0c             	sub    $0xc,%esp
801015da:	68 e7 79 10 80       	push   $0x801079e7
801015df:	e8 bc ed ff ff       	call   801003a0 <panic>
801015e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801015e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801015ef:	00 

801015f0 <readsb>:
{
801015f0:	55                   	push   %ebp
801015f1:	89 e5                	mov    %esp,%ebp
801015f3:	56                   	push   %esi
801015f4:	53                   	push   %ebx
801015f5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801015f8:	83 ec 08             	sub    $0x8,%esp
801015fb:	6a 01                	push   $0x1
801015fd:	ff 75 08             	push   0x8(%ebp)
80101600:	e8 cb ea ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101605:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101608:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010160a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010160d:	6a 1c                	push   $0x1c
8010160f:	50                   	push   %eax
80101610:	56                   	push   %esi
80101611:	e8 0a 36 00 00       	call   80104c20 <memmove>
  brelse(bp);
80101616:	83 c4 10             	add    $0x10,%esp
80101619:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010161c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010161f:	5b                   	pop    %ebx
80101620:	5e                   	pop    %esi
80101621:	5d                   	pop    %ebp
  brelse(bp);
80101622:	e9 d9 eb ff ff       	jmp    80100200 <brelse>
80101627:	90                   	nop
80101628:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010162f:	00 

80101630 <iinit>:
{
80101630:	55                   	push   %ebp
80101631:	89 e5                	mov    %esp,%ebp
80101633:	53                   	push   %ebx
80101634:	bb a0 09 11 80       	mov    $0x801109a0,%ebx
80101639:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010163c:	68 fa 79 10 80       	push   $0x801079fa
80101641:	68 60 09 11 80       	push   $0x80110960
80101646:	e8 f5 31 00 00       	call   80104840 <initlock>
  for(i = 0; i < NINODE; i++) {
8010164b:	83 c4 10             	add    $0x10,%esp
8010164e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101650:	83 ec 08             	sub    $0x8,%esp
80101653:	68 01 7a 10 80       	push   $0x80107a01
80101658:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80101659:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010165f:	e8 9c 30 00 00       	call   80104700 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101664:	83 c4 10             	add    $0x10,%esp
80101667:	81 fb c0 25 11 80    	cmp    $0x801125c0,%ebx
8010166d:	75 e1                	jne    80101650 <iinit+0x20>
  bp = bread(dev, 1);
8010166f:	83 ec 08             	sub    $0x8,%esp
80101672:	6a 01                	push   $0x1
80101674:	ff 75 08             	push   0x8(%ebp)
80101677:	e8 54 ea ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
8010167c:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
8010167f:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101681:	8d 40 5c             	lea    0x5c(%eax),%eax
80101684:	6a 1c                	push   $0x1c
80101686:	50                   	push   %eax
80101687:	68 b4 25 11 80       	push   $0x801125b4
8010168c:	e8 8f 35 00 00       	call   80104c20 <memmove>
  brelse(bp);
80101691:	89 1c 24             	mov    %ebx,(%esp)
80101694:	e8 67 eb ff ff       	call   80100200 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101699:	ff 35 cc 25 11 80    	push   0x801125cc
8010169f:	ff 35 c8 25 11 80    	push   0x801125c8
801016a5:	ff 35 c4 25 11 80    	push   0x801125c4
801016ab:	ff 35 c0 25 11 80    	push   0x801125c0
801016b1:	ff 35 bc 25 11 80    	push   0x801125bc
801016b7:	ff 35 b8 25 11 80    	push   0x801125b8
801016bd:	ff 35 b4 25 11 80    	push   0x801125b4
801016c3:	68 20 7e 10 80       	push   $0x80107e20
801016c8:	e8 23 f0 ff ff       	call   801006f0 <cprintf>
}
801016cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801016d0:	83 c4 30             	add    $0x30,%esp
801016d3:	c9                   	leave
801016d4:	c3                   	ret
801016d5:	8d 76 00             	lea    0x0(%esi),%esi
801016d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801016df:	00 

801016e0 <ialloc>:
{
801016e0:	55                   	push   %ebp
801016e1:	89 e5                	mov    %esp,%ebp
801016e3:	57                   	push   %edi
801016e4:	56                   	push   %esi
801016e5:	53                   	push   %ebx
801016e6:	83 ec 1c             	sub    $0x1c,%esp
801016e9:	0f b7 45 0c          	movzwl 0xc(%ebp),%eax
801016ed:	8b 75 08             	mov    0x8(%ebp),%esi
801016f0:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
801016f4:	83 3d bc 25 11 80 01 	cmpl   $0x1,0x801125bc
801016fb:	0f 86 8f 00 00 00    	jbe    80101790 <ialloc+0xb0>
80101701:	bf 01 00 00 00       	mov    $0x1,%edi
80101706:	eb 1f                	jmp    80101727 <ialloc+0x47>
80101708:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010170f:	00 
    brelse(bp);
80101710:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101713:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101716:	53                   	push   %ebx
80101717:	e8 e4 ea ff ff       	call   80100200 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010171c:	83 c4 10             	add    $0x10,%esp
8010171f:	3b 3d bc 25 11 80    	cmp    0x801125bc,%edi
80101725:	73 69                	jae    80101790 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101727:	89 f8                	mov    %edi,%eax
80101729:	83 ec 08             	sub    $0x8,%esp
8010172c:	c1 e8 03             	shr    $0x3,%eax
8010172f:	03 05 c8 25 11 80    	add    0x801125c8,%eax
80101735:	50                   	push   %eax
80101736:	56                   	push   %esi
80101737:	e8 94 e9 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010173c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010173f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101741:	89 f8                	mov    %edi,%eax
80101743:	83 e0 07             	and    $0x7,%eax
80101746:	c1 e0 06             	shl    $0x6,%eax
80101749:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010174d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101751:	75 bd                	jne    80101710 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101753:	83 ec 04             	sub    $0x4,%esp
80101756:	6a 40                	push   $0x40
80101758:	6a 00                	push   $0x0
8010175a:	51                   	push   %ecx
8010175b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010175e:	e8 1d 34 00 00       	call   80104b80 <memset>
      dip->type = type;
80101763:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
80101767:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010176a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010176d:	89 1c 24             	mov    %ebx,(%esp)
80101770:	e8 ab 19 00 00       	call   80103120 <log_write>
      brelse(bp);
80101775:	89 1c 24             	mov    %ebx,(%esp)
80101778:	e8 83 ea ff ff       	call   80100200 <brelse>
      return iget(dev, inum);
8010177d:	83 c4 10             	add    $0x10,%esp
}
80101780:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101783:	89 fa                	mov    %edi,%edx
}
80101785:	5b                   	pop    %ebx
      return iget(dev, inum);
80101786:	89 f0                	mov    %esi,%eax
}
80101788:	5e                   	pop    %esi
80101789:	5f                   	pop    %edi
8010178a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010178b:	e9 10 fc ff ff       	jmp    801013a0 <iget>
  panic("ialloc: no inodes");
80101790:	83 ec 0c             	sub    $0xc,%esp
80101793:	68 07 7a 10 80       	push   $0x80107a07
80101798:	e8 03 ec ff ff       	call   801003a0 <panic>
8010179d:	8d 76 00             	lea    0x0(%esi),%esi

801017a0 <iupdate>:
{
801017a0:	55                   	push   %ebp
801017a1:	89 e5                	mov    %esp,%ebp
801017a3:	56                   	push   %esi
801017a4:	53                   	push   %ebx
801017a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017a8:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017ab:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017ae:	83 ec 08             	sub    $0x8,%esp
801017b1:	c1 e8 03             	shr    $0x3,%eax
801017b4:	03 05 c8 25 11 80    	add    0x801125c8,%eax
801017ba:	50                   	push   %eax
801017bb:	ff 73 a4             	push   -0x5c(%ebx)
801017be:	e8 0d e9 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
801017c3:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017c7:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017ca:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801017cc:	8b 43 a8             	mov    -0x58(%ebx),%eax
801017cf:	83 e0 07             	and    $0x7,%eax
801017d2:	c1 e0 06             	shl    $0x6,%eax
  dip->type = ip->type;
801017d5:	66 89 54 06 5c       	mov    %dx,0x5c(%esi,%eax,1)
  dip->major = ip->major;
801017da:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
801017de:	66 89 54 06 5e       	mov    %dx,0x5e(%esi,%eax,1)
  dip->minor = ip->minor;
801017e3:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801017e7:	66 89 54 06 60       	mov    %dx,0x60(%esi,%eax,1)
  dip->nlink = ip->nlink;
801017ec:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
801017f0:	66 89 54 06 62       	mov    %dx,0x62(%esi,%eax,1)
  dip->size = ip->size;
801017f5:	8b 53 fc             	mov    -0x4(%ebx),%edx
801017f8:	89 54 06 64          	mov    %edx,0x64(%esi,%eax,1)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017fc:	8d 44 06 68          	lea    0x68(%esi,%eax,1),%eax
80101800:	6a 34                	push   $0x34
80101802:	53                   	push   %ebx
80101803:	50                   	push   %eax
80101804:	e8 17 34 00 00       	call   80104c20 <memmove>
  log_write(bp);
80101809:	89 34 24             	mov    %esi,(%esp)
8010180c:	e8 0f 19 00 00       	call   80103120 <log_write>
  brelse(bp);
80101811:	83 c4 10             	add    $0x10,%esp
80101814:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101817:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010181a:	5b                   	pop    %ebx
8010181b:	5e                   	pop    %esi
8010181c:	5d                   	pop    %ebp
  brelse(bp);
8010181d:	e9 de e9 ff ff       	jmp    80100200 <brelse>
80101822:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101828:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010182f:	00 

80101830 <idup>:
{
80101830:	55                   	push   %ebp
80101831:	89 e5                	mov    %esp,%ebp
80101833:	53                   	push   %ebx
80101834:	83 ec 10             	sub    $0x10,%esp
80101837:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010183a:	68 60 09 11 80       	push   $0x80110960
8010183f:	e8 1c 32 00 00       	call   80104a60 <acquire>
  ip->ref++;
80101844:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101848:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010184f:	e8 ac 31 00 00       	call   80104a00 <release>
}
80101854:	89 d8                	mov    %ebx,%eax
80101856:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101859:	c9                   	leave
8010185a:	c3                   	ret
8010185b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101860 <ilock>:
{
80101860:	55                   	push   %ebp
80101861:	89 e5                	mov    %esp,%ebp
80101863:	53                   	push   %ebx
80101864:	83 ec 14             	sub    $0x14,%esp
80101867:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
8010186a:	85 db                	test   %ebx,%ebx
8010186c:	0f 84 bb 00 00 00    	je     8010192d <ilock+0xcd>
80101872:	8b 53 08             	mov    0x8(%ebx),%edx
80101875:	85 d2                	test   %edx,%edx
80101877:	0f 8e b0 00 00 00    	jle    8010192d <ilock+0xcd>
  acquiresleep(&ip->lock);
8010187d:	83 ec 0c             	sub    $0xc,%esp
80101880:	8d 43 0c             	lea    0xc(%ebx),%eax
80101883:	50                   	push   %eax
80101884:	e8 b7 2e 00 00       	call   80104740 <acquiresleep>
  if(ip->valid == 0){
80101889:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010188c:	83 c4 10             	add    $0x10,%esp
8010188f:	85 c0                	test   %eax,%eax
80101891:	74 0d                	je     801018a0 <ilock+0x40>
}
80101893:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101896:	c9                   	leave
80101897:	c3                   	ret
80101898:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010189f:	00 
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018a0:	8b 43 04             	mov    0x4(%ebx),%eax
801018a3:	83 ec 08             	sub    $0x8,%esp
801018a6:	c1 e8 03             	shr    $0x3,%eax
801018a9:	03 05 c8 25 11 80    	add    0x801125c8,%eax
801018af:	50                   	push   %eax
801018b0:	ff 33                	push   (%ebx)
801018b2:	e8 19 e8 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018b7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018ba:	89 c2                	mov    %eax,%edx
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801018bc:	8b 43 04             	mov    0x4(%ebx),%eax
801018bf:	89 55 f4             	mov    %edx,-0xc(%ebp)
801018c2:	83 e0 07             	and    $0x7,%eax
801018c5:	c1 e0 06             	shl    $0x6,%eax
801018c8:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    ip->type = dip->type;
801018cc:	0f b7 08             	movzwl (%eax),%ecx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018cf:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801018d2:	66 89 4b 50          	mov    %cx,0x50(%ebx)
    ip->major = dip->major;
801018d6:	0f b7 48 f6          	movzwl -0xa(%eax),%ecx
801018da:	66 89 4b 52          	mov    %cx,0x52(%ebx)
    ip->minor = dip->minor;
801018de:	0f b7 48 f8          	movzwl -0x8(%eax),%ecx
801018e2:	66 89 4b 54          	mov    %cx,0x54(%ebx)
    ip->nlink = dip->nlink;
801018e6:	0f b7 48 fa          	movzwl -0x6(%eax),%ecx
801018ea:	66 89 4b 56          	mov    %cx,0x56(%ebx)
    ip->size = dip->size;
801018ee:	8b 48 fc             	mov    -0x4(%eax),%ecx
801018f1:	89 4b 58             	mov    %ecx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018f4:	6a 34                	push   $0x34
801018f6:	50                   	push   %eax
801018f7:	8d 43 5c             	lea    0x5c(%ebx),%eax
801018fa:	50                   	push   %eax
801018fb:	e8 20 33 00 00       	call   80104c20 <memmove>
    brelse(bp);
80101900:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101903:	89 14 24             	mov    %edx,(%esp)
80101906:	e8 f5 e8 ff ff       	call   80100200 <brelse>
    ip->valid = 1;
8010190b:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101912:	83 c4 10             	add    $0x10,%esp
80101915:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
8010191a:	0f 85 73 ff ff ff    	jne    80101893 <ilock+0x33>
      panic("ilock: no type");
80101920:	83 ec 0c             	sub    $0xc,%esp
80101923:	68 1f 7a 10 80       	push   $0x80107a1f
80101928:	e8 73 ea ff ff       	call   801003a0 <panic>
    panic("ilock");
8010192d:	83 ec 0c             	sub    $0xc,%esp
80101930:	68 19 7a 10 80       	push   $0x80107a19
80101935:	e8 66 ea ff ff       	call   801003a0 <panic>
8010193a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101940 <iunlock>:
{
80101940:	55                   	push   %ebp
80101941:	89 e5                	mov    %esp,%ebp
80101943:	56                   	push   %esi
80101944:	53                   	push   %ebx
80101945:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101948:	85 db                	test   %ebx,%ebx
8010194a:	74 28                	je     80101974 <iunlock+0x34>
8010194c:	83 ec 0c             	sub    $0xc,%esp
8010194f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101952:	56                   	push   %esi
80101953:	e8 88 2e 00 00       	call   801047e0 <holdingsleep>
80101958:	83 c4 10             	add    $0x10,%esp
8010195b:	85 c0                	test   %eax,%eax
8010195d:	74 15                	je     80101974 <iunlock+0x34>
8010195f:	8b 43 08             	mov    0x8(%ebx),%eax
80101962:	85 c0                	test   %eax,%eax
80101964:	7e 0e                	jle    80101974 <iunlock+0x34>
  releasesleep(&ip->lock);
80101966:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101969:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010196c:	5b                   	pop    %ebx
8010196d:	5e                   	pop    %esi
8010196e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010196f:	e9 2c 2e 00 00       	jmp    801047a0 <releasesleep>
    panic("iunlock");
80101974:	83 ec 0c             	sub    $0xc,%esp
80101977:	68 2e 7a 10 80       	push   $0x80107a2e
8010197c:	e8 1f ea ff ff       	call   801003a0 <panic>
80101981:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101988:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010198f:	00 

80101990 <iput>:
{
80101990:	55                   	push   %ebp
80101991:	89 e5                	mov    %esp,%ebp
80101993:	83 ec 34             	sub    $0x34,%esp
80101996:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80101999:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010199c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  acquiresleep(&ip->lock);
8010199f:	8d 73 0c             	lea    0xc(%ebx),%esi
801019a2:	56                   	push   %esi
801019a3:	e8 98 2d 00 00       	call   80104740 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801019a8:	8b 53 4c             	mov    0x4c(%ebx),%edx
801019ab:	83 c4 10             	add    $0x10,%esp
801019ae:	85 d2                	test   %edx,%edx
801019b0:	74 07                	je     801019b9 <iput+0x29>
801019b2:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801019b7:	74 37                	je     801019f0 <iput+0x60>
  releasesleep(&ip->lock);
801019b9:	83 ec 0c             	sub    $0xc,%esp
801019bc:	56                   	push   %esi
801019bd:	e8 de 2d 00 00       	call   801047a0 <releasesleep>
  acquire(&icache.lock);
801019c2:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
801019c9:	e8 92 30 00 00       	call   80104a60 <acquire>
  ip->ref--;
801019ce:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801019d2:	83 c4 10             	add    $0x10,%esp
}
801019d5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  release(&icache.lock);
801019d8:	c7 45 08 60 09 11 80 	movl   $0x80110960,0x8(%ebp)
}
801019df:	8b 75 f8             	mov    -0x8(%ebp),%esi
801019e2:	c9                   	leave
  release(&icache.lock);
801019e3:	e9 18 30 00 00       	jmp    80104a00 <release>
801019e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801019ef:	00 
    acquire(&icache.lock);
801019f0:	83 ec 0c             	sub    $0xc,%esp
801019f3:	89 7d fc             	mov    %edi,-0x4(%ebp)
801019f6:	68 60 09 11 80       	push   $0x80110960
801019fb:	e8 60 30 00 00       	call   80104a60 <acquire>
    int r = ip->ref;
80101a00:	8b 7b 08             	mov    0x8(%ebx),%edi
    release(&icache.lock);
80101a03:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101a0a:	e8 f1 2f 00 00       	call   80104a00 <release>
    if(r == 1){
80101a0f:	83 c4 10             	add    $0x10,%esp
80101a12:	83 ff 01             	cmp    $0x1,%edi
80101a15:	74 09                	je     80101a20 <iput+0x90>
80101a17:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101a1a:	eb 9d                	jmp    801019b9 <iput+0x29>
80101a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a20:	89 f7                	mov    %esi,%edi
80101a22:	89 d9                	mov    %ebx,%ecx
80101a24:	8d b3 8c 00 00 00    	lea    0x8c(%ebx),%esi
80101a2a:	83 c3 5c             	add    $0x5c,%ebx
80101a2d:	eb 08                	jmp    80101a37 <iput+0xa7>
80101a2f:	90                   	nop
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101a30:	83 c3 04             	add    $0x4,%ebx
80101a33:	39 f3                	cmp    %esi,%ebx
80101a35:	74 21                	je     80101a58 <iput+0xc8>
    if(ip->addrs[i]){
80101a37:	8b 13                	mov    (%ebx),%edx
80101a39:	85 d2                	test   %edx,%edx
80101a3b:	74 f3                	je     80101a30 <iput+0xa0>
      bfree(ip->dev, ip->addrs[i]);
80101a3d:	8b 01                	mov    (%ecx),%eax
80101a3f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101a42:	e8 49 fa ff ff       	call   80101490 <bfree>
      ip->addrs[i] = 0;
80101a47:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80101a4d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101a50:	eb de                	jmp    80101a30 <iput+0xa0>
80101a52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101a58:	8b 81 8c 00 00 00    	mov    0x8c(%ecx),%eax
80101a5e:	89 fe                	mov    %edi,%esi
80101a60:	89 cb                	mov    %ecx,%ebx
80101a62:	85 c0                	test   %eax,%eax
80101a64:	75 30                	jne    80101a96 <iput+0x106>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101a66:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101a69:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101a70:	53                   	push   %ebx
80101a71:	e8 2a fd ff ff       	call   801017a0 <iupdate>
      ip->type = 0;
80101a76:	31 c0                	xor    %eax,%eax
80101a78:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101a7c:	89 1c 24             	mov    %ebx,(%esp)
80101a7f:	e8 1c fd ff ff       	call   801017a0 <iupdate>
      ip->valid = 0;
80101a84:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101a8b:	83 c4 10             	add    $0x10,%esp
80101a8e:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101a91:	e9 23 ff ff ff       	jmp    801019b9 <iput+0x29>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101a96:	83 ec 08             	sub    $0x8,%esp
80101a99:	50                   	push   %eax
80101a9a:	ff 31                	push   (%ecx)
80101a9c:	e8 2f e6 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
80101aa1:	83 c4 10             	add    $0x10,%esp
80101aa4:	89 d9                	mov    %ebx,%ecx
80101aa6:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101aa9:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101aac:	8d 70 5c             	lea    0x5c(%eax),%esi
80101aaf:	8d 98 5c 02 00 00    	lea    0x25c(%eax),%ebx
80101ab5:	eb 10                	jmp    80101ac7 <iput+0x137>
80101ab7:	90                   	nop
80101ab8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101abf:	00 
80101ac0:	83 c6 04             	add    $0x4,%esi
80101ac3:	39 de                	cmp    %ebx,%esi
80101ac5:	74 15                	je     80101adc <iput+0x14c>
      if(a[j])
80101ac7:	8b 16                	mov    (%esi),%edx
80101ac9:	85 d2                	test   %edx,%edx
80101acb:	74 f3                	je     80101ac0 <iput+0x130>
        bfree(ip->dev, a[j]);
80101acd:	8b 01                	mov    (%ecx),%eax
80101acf:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101ad2:	e8 b9 f9 ff ff       	call   80101490 <bfree>
80101ad7:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101ada:	eb e4                	jmp    80101ac0 <iput+0x130>
    brelse(bp);
80101adc:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101adf:	83 ec 0c             	sub    $0xc,%esp
80101ae2:	89 cb                	mov    %ecx,%ebx
80101ae4:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101ae7:	50                   	push   %eax
80101ae8:	e8 13 e7 ff ff       	call   80100200 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101aed:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101af3:	8b 03                	mov    (%ebx),%eax
80101af5:	e8 96 f9 ff ff       	call   80101490 <bfree>
    ip->addrs[NDIRECT] = 0;
80101afa:	83 c4 10             	add    $0x10,%esp
80101afd:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101b04:	00 00 00 
80101b07:	e9 5a ff ff ff       	jmp    80101a66 <iput+0xd6>
80101b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101b10 <iunlockput>:
{
80101b10:	55                   	push   %ebp
80101b11:	89 e5                	mov    %esp,%ebp
80101b13:	56                   	push   %esi
80101b14:	53                   	push   %ebx
80101b15:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101b18:	85 db                	test   %ebx,%ebx
80101b1a:	74 34                	je     80101b50 <iunlockput+0x40>
80101b1c:	83 ec 0c             	sub    $0xc,%esp
80101b1f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101b22:	56                   	push   %esi
80101b23:	e8 b8 2c 00 00       	call   801047e0 <holdingsleep>
80101b28:	83 c4 10             	add    $0x10,%esp
80101b2b:	85 c0                	test   %eax,%eax
80101b2d:	74 21                	je     80101b50 <iunlockput+0x40>
80101b2f:	8b 43 08             	mov    0x8(%ebx),%eax
80101b32:	85 c0                	test   %eax,%eax
80101b34:	7e 1a                	jle    80101b50 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101b36:	83 ec 0c             	sub    $0xc,%esp
80101b39:	56                   	push   %esi
80101b3a:	e8 61 2c 00 00       	call   801047a0 <releasesleep>
  iput(ip);
80101b3f:	83 c4 10             	add    $0x10,%esp
80101b42:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101b45:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101b48:	5b                   	pop    %ebx
80101b49:	5e                   	pop    %esi
80101b4a:	5d                   	pop    %ebp
  iput(ip);
80101b4b:	e9 40 fe ff ff       	jmp    80101990 <iput>
    panic("iunlock");
80101b50:	83 ec 0c             	sub    $0xc,%esp
80101b53:	68 2e 7a 10 80       	push   $0x80107a2e
80101b58:	e8 43 e8 ff ff       	call   801003a0 <panic>
80101b5d:	8d 76 00             	lea    0x0(%esi),%esi

80101b60 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101b60:	55                   	push   %ebp
80101b61:	89 e5                	mov    %esp,%ebp
80101b63:	8b 55 08             	mov    0x8(%ebp),%edx
80101b66:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101b69:	8b 0a                	mov    (%edx),%ecx
80101b6b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101b6e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101b71:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101b74:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101b78:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101b7b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101b7f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101b83:	8b 52 58             	mov    0x58(%edx),%edx
80101b86:	89 50 10             	mov    %edx,0x10(%eax)
}
80101b89:	5d                   	pop    %ebp
80101b8a:	c3                   	ret
80101b8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101b90 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101b90:	55                   	push   %ebp
80101b91:	89 e5                	mov    %esp,%ebp
80101b93:	83 ec 28             	sub    $0x28,%esp
80101b96:	89 75 f8             	mov    %esi,-0x8(%ebp)
80101b99:	8b 45 0c             	mov    0xc(%ebp),%eax
80101b9c:	8b 75 08             	mov    0x8(%ebp),%esi
80101b9f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80101ba2:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101ba5:	8b 7d 10             	mov    0x10(%ebp),%edi
80101ba8:	89 75 d8             	mov    %esi,-0x28(%ebp)
80101bab:	8b 45 14             	mov    0x14(%ebp),%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101bae:	66 83 7e 50 03       	cmpw   $0x3,0x50(%esi)
80101bb3:	0f 84 bf 00 00 00    	je     80101c78 <readi+0xe8>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101bb9:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101bbc:	8b 56 58             	mov    0x58(%esi),%edx
80101bbf:	39 fa                	cmp    %edi,%edx
80101bc1:	0f 82 e1 00 00 00    	jb     80101ca8 <readi+0x118>
80101bc7:	89 f9                	mov    %edi,%ecx
80101bc9:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80101bcc:	31 db                	xor    %ebx,%ebx
80101bce:	01 c1                	add    %eax,%ecx
80101bd0:	0f 92 c3             	setb   %bl
80101bd3:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80101bd6:	0f 82 c9 00 00 00    	jb     80101ca5 <readi+0x115>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101bdc:	89 d3                	mov    %edx,%ebx
80101bde:	29 fb                	sub    %edi,%ebx
80101be0:	39 ca                	cmp    %ecx,%edx
80101be2:	0f 42 c3             	cmovb  %ebx,%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101be5:	85 c0                	test   %eax,%eax
80101be7:	0f 84 b3 00 00 00    	je     80101ca0 <readi+0x110>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101bed:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101bf0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101bf3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80101bf8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101bff:	00 
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c00:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101c03:	89 fa                	mov    %edi,%edx
80101c05:	c1 ea 09             	shr    $0x9,%edx
80101c08:	89 d8                	mov    %ebx,%eax
80101c0a:	e8 01 f9 ff ff       	call   80101510 <bmap>
80101c0f:	83 ec 08             	sub    $0x8,%esp
80101c12:	50                   	push   %eax
80101c13:	ff 33                	push   (%ebx)
80101c15:	e8 b6 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c1a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101c1d:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c22:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101c24:	89 f8                	mov    %edi,%eax
80101c26:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c2b:	29 f3                	sub    %esi,%ebx
80101c2d:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101c2f:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c33:	39 d9                	cmp    %ebx,%ecx
80101c35:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101c38:	83 c4 0c             	add    $0xc,%esp
80101c3b:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c3c:	01 de                	add    %ebx,%esi
80101c3e:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101c40:	50                   	push   %eax
80101c41:	ff 75 e0             	push   -0x20(%ebp)
80101c44:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101c47:	e8 d4 2f 00 00       	call   80104c20 <memmove>
    brelse(bp);
80101c4c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101c4f:	89 14 24             	mov    %edx,(%esp)
80101c52:	e8 a9 e5 ff ff       	call   80100200 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c57:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101c5a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101c5d:	83 c4 10             	add    $0x10,%esp
80101c60:	39 de                	cmp    %ebx,%esi
80101c62:	72 9c                	jb     80101c00 <readi+0x70>
80101c64:	89 d8                	mov    %ebx,%eax
  }
  return n;
80101c66:	8b 5d f4             	mov    -0xc(%ebp),%ebx
}
80101c69:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101c6c:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101c6f:	c9                   	leave
80101c70:	c3                   	ret
80101c71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101c78:	0f bf 56 52          	movswl 0x52(%esi),%edx
80101c7c:	66 83 fa 09          	cmp    $0x9,%dx
80101c80:	77 26                	ja     80101ca8 <readi+0x118>
80101c82:	8b 14 d5 00 09 11 80 	mov    -0x7feef700(,%edx,8),%edx
80101c89:	85 d2                	test   %edx,%edx
80101c8b:	74 1b                	je     80101ca8 <readi+0x118>
}
80101c8d:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101c90:	8b 7d fc             	mov    -0x4(%ebp),%edi
    return devsw[ip->major].read(ip, dst, n);
80101c93:	89 45 10             	mov    %eax,0x10(%ebp)
}
80101c96:	c9                   	leave
    return devsw[ip->major].read(ip, dst, n);
80101c97:	ff e2                	jmp    *%edx
80101c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ca0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101ca3:	eb c4                	jmp    80101c69 <readi+0xd9>
80101ca5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
      return -1;
80101ca8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101cad:	eb ba                	jmp    80101c69 <readi+0xd9>
80101caf:	90                   	nop

80101cb0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101cb0:	55                   	push   %ebp
80101cb1:	89 e5                	mov    %esp,%ebp
80101cb3:	83 ec 28             	sub    $0x28,%esp
80101cb6:	89 75 f8             	mov    %esi,-0x8(%ebp)
80101cb9:	8b 45 08             	mov    0x8(%ebp),%eax
80101cbc:	89 7d fc             	mov    %edi,-0x4(%ebp)
80101cbf:	8b 75 14             	mov    0x14(%ebp),%esi
80101cc2:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101cc5:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101cc8:	89 7d dc             	mov    %edi,-0x24(%ebp)
80101ccb:	8b 7d 10             	mov    0x10(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101cce:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
80101cd3:	0f 84 b7 00 00 00    	je     80101d90 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101cd9:	39 78 58             	cmp    %edi,0x58(%eax)
80101cdc:	0f 82 ea 00 00 00    	jb     80101dcc <writei+0x11c>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101ce2:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101ce5:	89 f2                	mov    %esi,%edx
80101ce7:	01 fa                	add    %edi,%edx
80101ce9:	0f 82 dd 00 00 00    	jb     80101dcc <writei+0x11c>
80101cef:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
80101cf5:	0f 87 d1 00 00 00    	ja     80101dcc <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101cfb:	85 f6                	test   %esi,%esi
80101cfd:	0f 84 81 00 00 00    	je     80101d84 <writei+0xd4>
80101d03:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80101d06:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101d0d:	89 45 d8             	mov    %eax,-0x28(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d10:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101d13:	89 fa                	mov    %edi,%edx
80101d15:	c1 ea 09             	shr    $0x9,%edx
80101d18:	89 f0                	mov    %esi,%eax
80101d1a:	e8 f1 f7 ff ff       	call   80101510 <bmap>
80101d1f:	83 ec 08             	sub    $0x8,%esp
80101d22:	50                   	push   %eax
80101d23:	ff 36                	push   (%esi)
80101d25:	e8 a6 e3 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101d2a:	b9 00 02 00 00       	mov    $0x200,%ecx
80101d2f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101d32:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d35:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80101d37:	89 f8                	mov    %edi,%eax
80101d39:	25 ff 01 00 00       	and    $0x1ff,%eax
80101d3e:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101d40:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101d44:	39 d9                	cmp    %ebx,%ecx
80101d46:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101d49:	83 c4 0c             	add    $0xc,%esp
80101d4c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d4d:	01 df                	add    %ebx,%edi
    memmove(bp->data + off%BSIZE, src, m);
80101d4f:	ff 75 dc             	push   -0x24(%ebp)
80101d52:	50                   	push   %eax
80101d53:	e8 c8 2e 00 00       	call   80104c20 <memmove>
    log_write(bp);
80101d58:	89 34 24             	mov    %esi,(%esp)
80101d5b:	e8 c0 13 00 00       	call   80103120 <log_write>
    brelse(bp);
80101d60:	89 34 24             	mov    %esi,(%esp)
80101d63:	e8 98 e4 ff ff       	call   80100200 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d68:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101d6b:	83 c4 10             	add    $0x10,%esp
80101d6e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d71:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101d74:	3b 45 e0             	cmp    -0x20(%ebp),%eax
80101d77:	72 97                	jb     80101d10 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101d79:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101d7c:	39 78 58             	cmp    %edi,0x58(%eax)
80101d7f:	72 37                	jb     80101db8 <writei+0x108>
80101d81:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101d84:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101d87:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101d8a:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101d8d:	c9                   	leave
80101d8e:	c3                   	ret
80101d8f:	90                   	nop
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101d90:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101d94:	66 83 f8 09          	cmp    $0x9,%ax
80101d98:	77 32                	ja     80101dcc <writei+0x11c>
80101d9a:	8b 04 c5 04 09 11 80 	mov    -0x7feef6fc(,%eax,8),%eax
80101da1:	85 c0                	test   %eax,%eax
80101da3:	74 27                	je     80101dcc <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80101da5:	8b 7d e0             	mov    -0x20(%ebp),%edi
}
80101da8:	8b 75 f8             	mov    -0x8(%ebp),%esi
    return devsw[ip->major].write(ip, src, n);
80101dab:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101dae:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101db1:	c9                   	leave
    return devsw[ip->major].write(ip, src, n);
80101db2:	ff e0                	jmp    *%eax
80101db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iupdate(ip);
80101db8:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101dbb:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
80101dbe:	50                   	push   %eax
80101dbf:	e8 dc f9 ff ff       	call   801017a0 <iupdate>
80101dc4:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101dc7:	83 c4 10             	add    $0x10,%esp
80101dca:	eb b8                	jmp    80101d84 <writei+0xd4>
      return -1;
80101dcc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101dd1:	eb b4                	jmp    80101d87 <writei+0xd7>
80101dd3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80101dd8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101ddf:	00 

80101de0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101de0:	55                   	push   %ebp
80101de1:	89 e5                	mov    %esp,%ebp
80101de3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101de6:	6a 0e                	push   $0xe
80101de8:	ff 75 0c             	push   0xc(%ebp)
80101deb:	ff 75 08             	push   0x8(%ebp)
80101dee:	e8 ad 2e 00 00       	call   80104ca0 <strncmp>
}
80101df3:	c9                   	leave
80101df4:	c3                   	ret
80101df5:	8d 76 00             	lea    0x0(%esi),%esi
80101df8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101dff:	00 

80101e00 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101e00:	55                   	push   %ebp
80101e01:	89 e5                	mov    %esp,%ebp
80101e03:	57                   	push   %edi
80101e04:	56                   	push   %esi
80101e05:	53                   	push   %ebx
80101e06:	83 ec 1c             	sub    $0x1c,%esp
80101e09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101e0c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101e11:	0f 85 8d 00 00 00    	jne    80101ea4 <dirlookup+0xa4>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101e17:	8b 53 58             	mov    0x58(%ebx),%edx
80101e1a:	31 ff                	xor    %edi,%edi
80101e1c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e1f:	85 d2                	test   %edx,%edx
80101e21:	74 46                	je     80101e69 <dirlookup+0x69>
80101e23:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80101e28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101e2f:	00 
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e30:	6a 10                	push   $0x10
80101e32:	57                   	push   %edi
80101e33:	56                   	push   %esi
80101e34:	53                   	push   %ebx
80101e35:	e8 56 fd ff ff       	call   80101b90 <readi>
80101e3a:	83 c4 10             	add    $0x10,%esp
80101e3d:	83 f8 10             	cmp    $0x10,%eax
80101e40:	75 55                	jne    80101e97 <dirlookup+0x97>
      panic("dirlookup read");
    if(de.inum == 0)
80101e42:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e47:	74 18                	je     80101e61 <dirlookup+0x61>
  return strncmp(s, t, DIRSIZ);
80101e49:	83 ec 04             	sub    $0x4,%esp
80101e4c:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e4f:	6a 0e                	push   $0xe
80101e51:	50                   	push   %eax
80101e52:	ff 75 0c             	push   0xc(%ebp)
80101e55:	e8 46 2e 00 00       	call   80104ca0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101e5a:	83 c4 10             	add    $0x10,%esp
80101e5d:	85 c0                	test   %eax,%eax
80101e5f:	74 17                	je     80101e78 <dirlookup+0x78>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e61:	83 c7 10             	add    $0x10,%edi
80101e64:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e67:	72 c7                	jb     80101e30 <dirlookup+0x30>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101e69:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101e6c:	31 c0                	xor    %eax,%eax
}
80101e6e:	5b                   	pop    %ebx
80101e6f:	5e                   	pop    %esi
80101e70:	5f                   	pop    %edi
80101e71:	5d                   	pop    %ebp
80101e72:	c3                   	ret
80101e73:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(poff)
80101e78:	8b 45 10             	mov    0x10(%ebp),%eax
80101e7b:	85 c0                	test   %eax,%eax
80101e7d:	74 05                	je     80101e84 <dirlookup+0x84>
        *poff = off;
80101e7f:	8b 45 10             	mov    0x10(%ebp),%eax
80101e82:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101e84:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101e88:	8b 03                	mov    (%ebx),%eax
80101e8a:	e8 11 f5 ff ff       	call   801013a0 <iget>
}
80101e8f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e92:	5b                   	pop    %ebx
80101e93:	5e                   	pop    %esi
80101e94:	5f                   	pop    %edi
80101e95:	5d                   	pop    %ebp
80101e96:	c3                   	ret
      panic("dirlookup read");
80101e97:	83 ec 0c             	sub    $0xc,%esp
80101e9a:	68 48 7a 10 80       	push   $0x80107a48
80101e9f:	e8 fc e4 ff ff       	call   801003a0 <panic>
    panic("dirlookup not DIR");
80101ea4:	83 ec 0c             	sub    $0xc,%esp
80101ea7:	68 36 7a 10 80       	push   $0x80107a36
80101eac:	e8 ef e4 ff ff       	call   801003a0 <panic>
80101eb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101eb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101ebf:	00 

80101ec0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101ec0:	55                   	push   %ebp
80101ec1:	89 e5                	mov    %esp,%ebp
80101ec3:	57                   	push   %edi
80101ec4:	56                   	push   %esi
80101ec5:	53                   	push   %ebx
80101ec6:	89 c3                	mov    %eax,%ebx
80101ec8:	83 ec 1c             	sub    $0x1c,%esp
80101ecb:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101ece:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101ed1:	80 38 2f             	cmpb   $0x2f,(%eax)
80101ed4:	0f 84 6a 01 00 00    	je     80102044 <namex+0x184>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101eda:	e8 c1 1c 00 00       	call   80103ba0 <myproc>
  acquire(&icache.lock);
80101edf:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101ee2:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101ee5:	68 60 09 11 80       	push   $0x80110960
80101eea:	e8 71 2b 00 00       	call   80104a60 <acquire>
  ip->ref++;
80101eef:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101ef3:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101efa:	e8 01 2b 00 00       	call   80104a00 <release>
80101eff:	83 c4 10             	add    $0x10,%esp
80101f02:	eb 0f                	jmp    80101f13 <namex+0x53>
80101f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101f0f:	00 
    path++;
80101f10:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101f13:	0f b6 03             	movzbl (%ebx),%eax
80101f16:	3c 2f                	cmp    $0x2f,%al
80101f18:	74 f6                	je     80101f10 <namex+0x50>
  if(*path == 0)
80101f1a:	84 c0                	test   %al,%al
80101f1c:	0f 84 3e 01 00 00    	je     80102060 <namex+0x1a0>
  while(*path != '/' && *path != 0)
80101f22:	0f b6 03             	movzbl (%ebx),%eax
80101f25:	84 c0                	test   %al,%al
80101f27:	0f 84 0b 01 00 00    	je     80102038 <namex+0x178>
80101f2d:	3c 2f                	cmp    $0x2f,%al
80101f2f:	0f 84 03 01 00 00    	je     80102038 <namex+0x178>
80101f35:	89 df                	mov    %ebx,%edi
80101f37:	90                   	nop
80101f38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101f3f:	00 
80101f40:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80101f44:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80101f47:	3c 2f                	cmp    $0x2f,%al
80101f49:	74 04                	je     80101f4f <namex+0x8f>
80101f4b:	84 c0                	test   %al,%al
80101f4d:	75 f1                	jne    80101f40 <namex+0x80>
  len = path - s;
80101f4f:	89 f8                	mov    %edi,%eax
80101f51:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80101f53:	83 f8 0d             	cmp    $0xd,%eax
80101f56:	0f 8e b4 00 00 00    	jle    80102010 <namex+0x150>
    memmove(name, s, DIRSIZ);
80101f5c:	83 ec 04             	sub    $0x4,%esp
80101f5f:	6a 0e                	push   $0xe
80101f61:	53                   	push   %ebx
80101f62:	89 fb                	mov    %edi,%ebx
80101f64:	ff 75 e4             	push   -0x1c(%ebp)
80101f67:	e8 b4 2c 00 00       	call   80104c20 <memmove>
80101f6c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101f6f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101f72:	75 14                	jne    80101f88 <namex+0xc8>
80101f74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101f7f:	00 
    path++;
80101f80:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101f83:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101f86:	74 f8                	je     80101f80 <namex+0xc0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101f88:	83 ec 0c             	sub    $0xc,%esp
80101f8b:	56                   	push   %esi
80101f8c:	e8 cf f8 ff ff       	call   80101860 <ilock>
    if(ip->type != T_DIR){
80101f91:	83 c4 10             	add    $0x10,%esp
80101f94:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101f99:	0f 85 d6 00 00 00    	jne    80102075 <namex+0x1b5>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101f9f:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101fa2:	85 c0                	test   %eax,%eax
80101fa4:	74 09                	je     80101faf <namex+0xef>
80101fa6:	80 3b 00             	cmpb   $0x0,(%ebx)
80101fa9:	0f 84 2b 01 00 00    	je     801020da <namex+0x21a>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101faf:	83 ec 04             	sub    $0x4,%esp
80101fb2:	6a 00                	push   $0x0
80101fb4:	ff 75 e4             	push   -0x1c(%ebp)
80101fb7:	56                   	push   %esi
80101fb8:	e8 43 fe ff ff       	call   80101e00 <dirlookup>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101fbd:	8d 56 0c             	lea    0xc(%esi),%edx
    if((next = dirlookup(ip, name, 0)) == 0){
80101fc0:	83 c4 10             	add    $0x10,%esp
80101fc3:	89 c7                	mov    %eax,%edi
80101fc5:	85 c0                	test   %eax,%eax
80101fc7:	0f 84 ea 00 00 00    	je     801020b7 <namex+0x1f7>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101fcd:	83 ec 0c             	sub    $0xc,%esp
80101fd0:	52                   	push   %edx
80101fd1:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101fd4:	e8 07 28 00 00       	call   801047e0 <holdingsleep>
80101fd9:	83 c4 10             	add    $0x10,%esp
80101fdc:	85 c0                	test   %eax,%eax
80101fde:	0f 84 36 01 00 00    	je     8010211a <namex+0x25a>
80101fe4:	8b 56 08             	mov    0x8(%esi),%edx
80101fe7:	85 d2                	test   %edx,%edx
80101fe9:	0f 8e 2b 01 00 00    	jle    8010211a <namex+0x25a>
  releasesleep(&ip->lock);
80101fef:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101ff2:	83 ec 0c             	sub    $0xc,%esp
80101ff5:	52                   	push   %edx
80101ff6:	e8 a5 27 00 00       	call   801047a0 <releasesleep>
  iput(ip);
80101ffb:	89 34 24             	mov    %esi,(%esp)
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80101ffe:	89 fe                	mov    %edi,%esi
  iput(ip);
80102000:	e8 8b f9 ff ff       	call   80101990 <iput>
80102005:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80102008:	e9 06 ff ff ff       	jmp    80101f13 <namex+0x53>
8010200d:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80102010:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102013:	01 c1                	add    %eax,%ecx
80102015:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    memmove(name, s, len);
80102018:	83 ec 04             	sub    $0x4,%esp
8010201b:	50                   	push   %eax
8010201c:	53                   	push   %ebx
    name[len] = 0;
8010201d:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
8010201f:	ff 75 e4             	push   -0x1c(%ebp)
80102022:	e8 f9 2b 00 00       	call   80104c20 <memmove>
    name[len] = 0;
80102027:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010202a:	83 c4 10             	add    $0x10,%esp
8010202d:	c6 00 00             	movb   $0x0,(%eax)
80102030:	e9 3a ff ff ff       	jmp    80101f6f <namex+0xaf>
80102035:	8d 76 00             	lea    0x0(%esi),%esi
  while(*path != '/' && *path != 0)
80102038:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010203b:	89 df                	mov    %ebx,%edi
8010203d:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102040:	31 c0                	xor    %eax,%eax
80102042:	eb d4                	jmp    80102018 <namex+0x158>
    ip = iget(ROOTDEV, ROOTINO);
80102044:	ba 01 00 00 00       	mov    $0x1,%edx
80102049:	b8 01 00 00 00       	mov    $0x1,%eax
8010204e:	e8 4d f3 ff ff       	call   801013a0 <iget>
80102053:	89 c6                	mov    %eax,%esi
80102055:	e9 b9 fe ff ff       	jmp    80101f13 <namex+0x53>
8010205a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  if(nameiparent){
80102060:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102063:	85 c0                	test   %eax,%eax
80102065:	0f 85 9f 00 00 00    	jne    8010210a <namex+0x24a>
    iput(ip);
    return 0;
  }
  return ip;
}
8010206b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010206e:	89 f0                	mov    %esi,%eax
80102070:	5b                   	pop    %ebx
80102071:	5e                   	pop    %esi
80102072:	5f                   	pop    %edi
80102073:	5d                   	pop    %ebp
80102074:	c3                   	ret
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102075:	83 ec 0c             	sub    $0xc,%esp
80102078:	8d 5e 0c             	lea    0xc(%esi),%ebx
8010207b:	53                   	push   %ebx
8010207c:	e8 5f 27 00 00       	call   801047e0 <holdingsleep>
80102081:	83 c4 10             	add    $0x10,%esp
80102084:	85 c0                	test   %eax,%eax
80102086:	0f 84 8e 00 00 00    	je     8010211a <namex+0x25a>
8010208c:	8b 46 08             	mov    0x8(%esi),%eax
8010208f:	85 c0                	test   %eax,%eax
80102091:	0f 8e 83 00 00 00    	jle    8010211a <namex+0x25a>
  releasesleep(&ip->lock);
80102097:	83 ec 0c             	sub    $0xc,%esp
8010209a:	53                   	push   %ebx
8010209b:	e8 00 27 00 00       	call   801047a0 <releasesleep>
  iput(ip);
801020a0:	89 34 24             	mov    %esi,(%esp)
      return 0;
801020a3:	31 f6                	xor    %esi,%esi
  iput(ip);
801020a5:	e8 e6 f8 ff ff       	call   80101990 <iput>
      return 0;
801020aa:	83 c4 10             	add    $0x10,%esp
}
801020ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020b0:	89 f0                	mov    %esi,%eax
801020b2:	5b                   	pop    %ebx
801020b3:	5e                   	pop    %esi
801020b4:	5f                   	pop    %edi
801020b5:	5d                   	pop    %ebp
801020b6:	c3                   	ret
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801020b7:	83 ec 0c             	sub    $0xc,%esp
801020ba:	52                   	push   %edx
801020bb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801020be:	e8 1d 27 00 00       	call   801047e0 <holdingsleep>
801020c3:	83 c4 10             	add    $0x10,%esp
801020c6:	85 c0                	test   %eax,%eax
801020c8:	74 50                	je     8010211a <namex+0x25a>
801020ca:	8b 4e 08             	mov    0x8(%esi),%ecx
801020cd:	85 c9                	test   %ecx,%ecx
801020cf:	7e 49                	jle    8010211a <namex+0x25a>
  releasesleep(&ip->lock);
801020d1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801020d4:	83 ec 0c             	sub    $0xc,%esp
801020d7:	52                   	push   %edx
801020d8:	eb c1                	jmp    8010209b <namex+0x1db>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801020da:	83 ec 0c             	sub    $0xc,%esp
801020dd:	8d 5e 0c             	lea    0xc(%esi),%ebx
801020e0:	53                   	push   %ebx
801020e1:	e8 fa 26 00 00       	call   801047e0 <holdingsleep>
801020e6:	83 c4 10             	add    $0x10,%esp
801020e9:	85 c0                	test   %eax,%eax
801020eb:	74 2d                	je     8010211a <namex+0x25a>
801020ed:	8b 7e 08             	mov    0x8(%esi),%edi
801020f0:	85 ff                	test   %edi,%edi
801020f2:	7e 26                	jle    8010211a <namex+0x25a>
  releasesleep(&ip->lock);
801020f4:	83 ec 0c             	sub    $0xc,%esp
801020f7:	53                   	push   %ebx
801020f8:	e8 a3 26 00 00       	call   801047a0 <releasesleep>
      return ip;
801020fd:	83 c4 10             	add    $0x10,%esp
}
80102100:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102103:	89 f0                	mov    %esi,%eax
80102105:	5b                   	pop    %ebx
80102106:	5e                   	pop    %esi
80102107:	5f                   	pop    %edi
80102108:	5d                   	pop    %ebp
80102109:	c3                   	ret
    iput(ip);
8010210a:	83 ec 0c             	sub    $0xc,%esp
8010210d:	56                   	push   %esi
      return 0;
8010210e:	31 f6                	xor    %esi,%esi
    iput(ip);
80102110:	e8 7b f8 ff ff       	call   80101990 <iput>
    return 0;
80102115:	83 c4 10             	add    $0x10,%esp
80102118:	eb 93                	jmp    801020ad <namex+0x1ed>
    panic("iunlock");
8010211a:	83 ec 0c             	sub    $0xc,%esp
8010211d:	68 2e 7a 10 80       	push   $0x80107a2e
80102122:	e8 79 e2 ff ff       	call   801003a0 <panic>
80102127:	90                   	nop
80102128:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010212f:	00 

80102130 <dirlink>:
{
80102130:	55                   	push   %ebp
80102131:	89 e5                	mov    %esp,%ebp
80102133:	83 ec 2c             	sub    $0x2c,%esp
80102136:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80102139:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
8010213c:	6a 00                	push   $0x0
8010213e:	ff 75 0c             	push   0xc(%ebp)
80102141:	53                   	push   %ebx
80102142:	e8 b9 fc ff ff       	call   80101e00 <dirlookup>
80102147:	83 c4 10             	add    $0x10,%esp
8010214a:	85 c0                	test   %eax,%eax
8010214c:	75 72                	jne    801021c0 <dirlink+0x90>
8010214e:	89 75 f8             	mov    %esi,-0x8(%ebp)
80102151:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102154:	89 7d fc             	mov    %edi,-0x4(%ebp)
  for(off = 0; off < dp->size; off += sizeof(de)){
80102157:	8b 7b 58             	mov    0x58(%ebx),%edi
8010215a:	85 ff                	test   %edi,%edi
8010215c:	74 2b                	je     80102189 <dirlink+0x59>
8010215e:	31 ff                	xor    %edi,%edi
80102160:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102163:	eb 0b                	jmp    80102170 <dirlink+0x40>
80102165:	8d 76 00             	lea    0x0(%esi),%esi
80102168:	83 c7 10             	add    $0x10,%edi
8010216b:	3b 7b 58             	cmp    0x58(%ebx),%edi
8010216e:	73 19                	jae    80102189 <dirlink+0x59>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102170:	6a 10                	push   $0x10
80102172:	57                   	push   %edi
80102173:	56                   	push   %esi
80102174:	53                   	push   %ebx
80102175:	e8 16 fa ff ff       	call   80101b90 <readi>
8010217a:	83 c4 10             	add    $0x10,%esp
8010217d:	83 f8 10             	cmp    $0x10,%eax
80102180:	75 51                	jne    801021d3 <dirlink+0xa3>
    if(de.inum == 0)
80102182:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102187:	75 df                	jne    80102168 <dirlink+0x38>
  strncpy(de.name, name, DIRSIZ);
80102189:	83 ec 04             	sub    $0x4,%esp
8010218c:	8d 45 da             	lea    -0x26(%ebp),%eax
8010218f:	6a 0e                	push   $0xe
80102191:	ff 75 0c             	push   0xc(%ebp)
80102194:	50                   	push   %eax
80102195:	e8 56 2b 00 00       	call   80104cf0 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010219a:	6a 10                	push   $0x10
  de.inum = inum;
8010219c:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010219f:	57                   	push   %edi
801021a0:	56                   	push   %esi
801021a1:	53                   	push   %ebx
  de.inum = inum;
801021a2:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021a6:	e8 05 fb ff ff       	call   80101cb0 <writei>
801021ab:	83 c4 20             	add    $0x20,%esp
801021ae:	83 f8 10             	cmp    $0x10,%eax
801021b1:	75 2d                	jne    801021e0 <dirlink+0xb0>
  return 0;
801021b3:	8b 75 f8             	mov    -0x8(%ebp),%esi
801021b6:	8b 7d fc             	mov    -0x4(%ebp),%edi
801021b9:	31 c0                	xor    %eax,%eax
}
801021bb:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801021be:	c9                   	leave
801021bf:	c3                   	ret
    iput(ip);
801021c0:	83 ec 0c             	sub    $0xc,%esp
801021c3:	50                   	push   %eax
801021c4:	e8 c7 f7 ff ff       	call   80101990 <iput>
    return -1;
801021c9:	83 c4 10             	add    $0x10,%esp
801021cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801021d1:	eb e8                	jmp    801021bb <dirlink+0x8b>
      panic("dirlink read");
801021d3:	83 ec 0c             	sub    $0xc,%esp
801021d6:	68 57 7a 10 80       	push   $0x80107a57
801021db:	e8 c0 e1 ff ff       	call   801003a0 <panic>
    panic("dirlink");
801021e0:	83 ec 0c             	sub    $0xc,%esp
801021e3:	68 bc 7c 10 80       	push   $0x80107cbc
801021e8:	e8 b3 e1 ff ff       	call   801003a0 <panic>
801021ed:	8d 76 00             	lea    0x0(%esi),%esi

801021f0 <namei>:

struct inode*
namei(char *path)
{
801021f0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801021f1:	31 d2                	xor    %edx,%edx
{
801021f3:	89 e5                	mov    %esp,%ebp
801021f5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
801021f8:	8b 45 08             	mov    0x8(%ebp),%eax
801021fb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801021fe:	e8 bd fc ff ff       	call   80101ec0 <namex>
}
80102203:	c9                   	leave
80102204:	c3                   	ret
80102205:	8d 76 00             	lea    0x0(%esi),%esi
80102208:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010220f:	00 

80102210 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102210:	55                   	push   %ebp
  return namex(path, 1, name);
80102211:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102216:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102218:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010221b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010221e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010221f:	e9 9c fc ff ff       	jmp    80101ec0 <namex>
80102224:	66 90                	xchg   %ax,%ax
80102226:	66 90                	xchg   %ax,%ax
80102228:	66 90                	xchg   %ax,%ax
8010222a:	66 90                	xchg   %ax,%ax
8010222c:	66 90                	xchg   %ax,%ax
8010222e:	66 90                	xchg   %ax,%ax

80102230 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102230:	55                   	push   %ebp
80102231:	89 e5                	mov    %esp,%ebp
80102233:	83 ec 18             	sub    $0x18,%esp
80102236:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80102239:	89 75 f8             	mov    %esi,-0x8(%ebp)
  if(b == 0)
8010223c:	85 c0                	test   %eax,%eax
8010223e:	0f 84 ac 00 00 00    	je     801022f0 <idestart+0xc0>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102244:	8b 70 08             	mov    0x8(%eax),%esi
80102247:	89 c3                	mov    %eax,%ebx
80102249:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010224f:	0f 87 8b 00 00 00    	ja     801022e0 <idestart+0xb0>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102255:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
8010225a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102260:	89 ca                	mov    %ecx,%edx
80102262:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102263:	83 e0 c0             	and    $0xffffffc0,%eax
80102266:	3c 40                	cmp    $0x40,%al
80102268:	75 f6                	jne    80102260 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010226a:	ba f6 03 00 00       	mov    $0x3f6,%edx
8010226f:	31 c0                	xor    %eax,%eax
80102271:	ee                   	out    %al,(%dx)
80102272:	b8 01 00 00 00       	mov    $0x1,%eax
80102277:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010227c:	ee                   	out    %al,(%dx)
8010227d:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102282:	89 f0                	mov    %esi,%eax
80102284:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102285:	89 f0                	mov    %esi,%eax
80102287:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010228c:	c1 f8 08             	sar    $0x8,%eax
8010228f:	ee                   	out    %al,(%dx)
80102290:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102295:	31 c0                	xor    %eax,%eax
80102297:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102298:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010229c:	ba f6 01 00 00       	mov    $0x1f6,%edx
801022a1:	c1 e0 04             	shl    $0x4,%eax
801022a4:	83 e0 10             	and    $0x10,%eax
801022a7:	83 c8 e0             	or     $0xffffffe0,%eax
801022aa:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
801022ab:	f6 03 04             	testb  $0x4,(%ebx)
801022ae:	75 10                	jne    801022c0 <idestart+0x90>
801022b0:	b8 20 00 00 00       	mov    $0x20,%eax
801022b5:	89 ca                	mov    %ecx,%edx
801022b7:	ee                   	out    %al,(%dx)
801022b8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801022bb:	8b 75 f8             	mov    -0x8(%ebp),%esi
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801022be:	c9                   	leave
801022bf:	c3                   	ret
801022c0:	b8 30 00 00 00       	mov    $0x30,%eax
801022c5:	89 ca                	mov    %ecx,%edx
801022c7:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
801022c8:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
801022cd:	8d 73 5c             	lea    0x5c(%ebx),%esi
801022d0:	ba f0 01 00 00       	mov    $0x1f0,%edx
801022d5:	fc                   	cld
801022d6:	f3 6f                	rep outsl %ds:(%esi),(%dx)
801022d8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801022db:	8b 75 f8             	mov    -0x8(%ebp),%esi
}
801022de:	c9                   	leave
801022df:	c3                   	ret
    panic("incorrect blockno");
801022e0:	83 ec 0c             	sub    $0xc,%esp
801022e3:	89 7d fc             	mov    %edi,-0x4(%ebp)
801022e6:	68 6d 7a 10 80       	push   $0x80107a6d
801022eb:	e8 b0 e0 ff ff       	call   801003a0 <panic>
    panic("idestart");
801022f0:	83 ec 0c             	sub    $0xc,%esp
801022f3:	89 7d fc             	mov    %edi,-0x4(%ebp)
801022f6:	68 64 7a 10 80       	push   $0x80107a64
801022fb:	e8 a0 e0 ff ff       	call   801003a0 <panic>

80102300 <ideinit>:
{
80102300:	55                   	push   %ebp
80102301:	89 e5                	mov    %esp,%ebp
80102303:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102306:	68 7f 7a 10 80       	push   $0x80107a7f
8010230b:	68 00 26 11 80       	push   $0x80112600
80102310:	e8 2b 25 00 00       	call   80104840 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102315:	58                   	pop    %eax
80102316:	a1 84 27 11 80       	mov    0x80112784,%eax
8010231b:	5a                   	pop    %edx
8010231c:	83 e8 01             	sub    $0x1,%eax
8010231f:	50                   	push   %eax
80102320:	6a 0e                	push   $0xe
80102322:	e8 d9 02 00 00       	call   80102600 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102327:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010232a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010232f:	90                   	nop
80102330:	ec                   	in     (%dx),%al
80102331:	83 e0 c0             	and    $0xffffffc0,%eax
80102334:	3c 40                	cmp    $0x40,%al
80102336:	75 f8                	jne    80102330 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102338:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010233d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102342:	ee                   	out    %al,(%dx)
80102343:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102348:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010234d:	eb 06                	jmp    80102355 <ideinit+0x55>
8010234f:	90                   	nop
  for(i=0; i<1000; i++){
80102350:	83 e9 01             	sub    $0x1,%ecx
80102353:	74 0f                	je     80102364 <ideinit+0x64>
80102355:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102356:	84 c0                	test   %al,%al
80102358:	74 f6                	je     80102350 <ideinit+0x50>
      havedisk1 = 1;
8010235a:	c7 05 e0 25 11 80 01 	movl   $0x1,0x801125e0
80102361:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102364:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102369:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010236e:	ee                   	out    %al,(%dx)
}
8010236f:	c9                   	leave
80102370:	c3                   	ret
80102371:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102378:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010237f:	00 

80102380 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102380:	55                   	push   %ebp
80102381:	89 e5                	mov    %esp,%ebp
80102383:	83 ec 24             	sub    $0x24,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102386:	68 00 26 11 80       	push   $0x80112600
{
8010238b:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  acquire(&idelock);
8010238e:	e8 cd 26 00 00       	call   80104a60 <acquire>

  if((b = idequeue) == 0){
80102393:	8b 1d e4 25 11 80    	mov    0x801125e4,%ebx
80102399:	83 c4 10             	add    $0x10,%esp
8010239c:	85 db                	test   %ebx,%ebx
8010239e:	74 6c                	je     8010240c <ideintr+0x8c>
801023a0:	89 75 f8             	mov    %esi,-0x8(%ebp)
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801023a3:	8b 43 58             	mov    0x58(%ebx),%eax
801023a6:	a3 e4 25 11 80       	mov    %eax,0x801125e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801023ab:	8b 33                	mov    (%ebx),%esi
801023ad:	f7 c6 04 00 00 00    	test   $0x4,%esi
801023b3:	75 32                	jne    801023e7 <ideintr+0x67>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801023b5:	ba f7 01 00 00       	mov    $0x1f7,%edx
801023ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801023c0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801023c1:	89 c1                	mov    %eax,%ecx
801023c3:	83 e1 c0             	and    $0xffffffc0,%ecx
801023c6:	80 f9 40             	cmp    $0x40,%cl
801023c9:	75 f5                	jne    801023c0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801023cb:	a8 21                	test   $0x21,%al
801023cd:	75 18                	jne    801023e7 <ideintr+0x67>
801023cf:	89 7d fc             	mov    %edi,-0x4(%ebp)
  asm volatile("cld; rep insl" :
801023d2:	b9 80 00 00 00       	mov    $0x80,%ecx
801023d7:	ba f0 01 00 00       	mov    $0x1f0,%edx
801023dc:	8d 7b 5c             	lea    0x5c(%ebx),%edi
801023df:	fc                   	cld
801023e0:	f3 6d                	rep insl (%dx),%es:(%edi)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
801023e2:	8b 33                	mov    (%ebx),%esi
801023e4:	8b 7d fc             	mov    -0x4(%ebp),%edi
  b->flags &= ~B_DIRTY;
801023e7:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801023ea:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801023ed:	83 ce 02             	or     $0x2,%esi
801023f0:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801023f2:	53                   	push   %ebx
801023f3:	e8 78 1f 00 00       	call   80104370 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801023f8:	a1 e4 25 11 80       	mov    0x801125e4,%eax
801023fd:	83 c4 10             	add    $0x10,%esp
80102400:	85 c0                	test   %eax,%eax
80102402:	74 1c                	je     80102420 <ideintr+0xa0>
    idestart(idequeue);
80102404:	e8 27 fe ff ff       	call   80102230 <idestart>
80102409:	8b 75 f8             	mov    -0x8(%ebp),%esi
    release(&idelock);
8010240c:	83 ec 0c             	sub    $0xc,%esp
8010240f:	68 00 26 11 80       	push   $0x80112600
80102414:	e8 e7 25 00 00       	call   80104a00 <release>

  release(&idelock);
}
80102419:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010241c:	c9                   	leave
8010241d:	c3                   	ret
8010241e:	66 90                	xchg   %ax,%ax
80102420:	8b 75 f8             	mov    -0x8(%ebp),%esi
80102423:	eb e7                	jmp    8010240c <ideintr+0x8c>
80102425:	8d 76 00             	lea    0x0(%esi),%esi
80102428:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010242f:	00 

80102430 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102430:	55                   	push   %ebp
80102431:	89 e5                	mov    %esp,%ebp
80102433:	53                   	push   %ebx
80102434:	83 ec 10             	sub    $0x10,%esp
80102437:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010243a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010243d:	50                   	push   %eax
8010243e:	e8 9d 23 00 00       	call   801047e0 <holdingsleep>
80102443:	83 c4 10             	add    $0x10,%esp
80102446:	85 c0                	test   %eax,%eax
80102448:	0f 84 c3 00 00 00    	je     80102511 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010244e:	8b 03                	mov    (%ebx),%eax
80102450:	83 e0 06             	and    $0x6,%eax
80102453:	83 f8 02             	cmp    $0x2,%eax
80102456:	0f 84 a8 00 00 00    	je     80102504 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010245c:	8b 53 04             	mov    0x4(%ebx),%edx
8010245f:	85 d2                	test   %edx,%edx
80102461:	74 0d                	je     80102470 <iderw+0x40>
80102463:	a1 e0 25 11 80       	mov    0x801125e0,%eax
80102468:	85 c0                	test   %eax,%eax
8010246a:	0f 84 87 00 00 00    	je     801024f7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102470:	83 ec 0c             	sub    $0xc,%esp
80102473:	68 00 26 11 80       	push   $0x80112600
80102478:	e8 e3 25 00 00       	call   80104a60 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010247d:	a1 e4 25 11 80       	mov    0x801125e4,%eax
  b->qnext = 0;
80102482:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102489:	83 c4 10             	add    $0x10,%esp
8010248c:	85 c0                	test   %eax,%eax
8010248e:	74 60                	je     801024f0 <iderw+0xc0>
80102490:	89 c2                	mov    %eax,%edx
80102492:	8b 40 58             	mov    0x58(%eax),%eax
80102495:	85 c0                	test   %eax,%eax
80102497:	75 f7                	jne    80102490 <iderw+0x60>
80102499:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010249c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010249e:	39 1d e4 25 11 80    	cmp    %ebx,0x801125e4
801024a4:	74 3a                	je     801024e0 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801024a6:	8b 03                	mov    (%ebx),%eax
801024a8:	83 e0 06             	and    $0x6,%eax
801024ab:	83 f8 02             	cmp    $0x2,%eax
801024ae:	74 1b                	je     801024cb <iderw+0x9b>
    sleep(b, &idelock);
801024b0:	83 ec 08             	sub    $0x8,%esp
801024b3:	68 00 26 11 80       	push   $0x80112600
801024b8:	53                   	push   %ebx
801024b9:	e8 f2 1d 00 00       	call   801042b0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801024be:	8b 03                	mov    (%ebx),%eax
801024c0:	83 c4 10             	add    $0x10,%esp
801024c3:	83 e0 06             	and    $0x6,%eax
801024c6:	83 f8 02             	cmp    $0x2,%eax
801024c9:	75 e5                	jne    801024b0 <iderw+0x80>
  }


  release(&idelock);
801024cb:	c7 45 08 00 26 11 80 	movl   $0x80112600,0x8(%ebp)
}
801024d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024d5:	c9                   	leave
  release(&idelock);
801024d6:	e9 25 25 00 00       	jmp    80104a00 <release>
801024db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    idestart(b);
801024e0:	89 d8                	mov    %ebx,%eax
801024e2:	e8 49 fd ff ff       	call   80102230 <idestart>
801024e7:	eb bd                	jmp    801024a6 <iderw+0x76>
801024e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801024f0:	ba e4 25 11 80       	mov    $0x801125e4,%edx
801024f5:	eb a5                	jmp    8010249c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
801024f7:	83 ec 0c             	sub    $0xc,%esp
801024fa:	68 ae 7a 10 80       	push   $0x80107aae
801024ff:	e8 9c de ff ff       	call   801003a0 <panic>
    panic("iderw: nothing to do");
80102504:	83 ec 0c             	sub    $0xc,%esp
80102507:	68 99 7a 10 80       	push   $0x80107a99
8010250c:	e8 8f de ff ff       	call   801003a0 <panic>
    panic("iderw: buf not locked");
80102511:	83 ec 0c             	sub    $0xc,%esp
80102514:	68 83 7a 10 80       	push   $0x80107a83
80102519:	e8 82 de ff ff       	call   801003a0 <panic>
8010251e:	66 90                	xchg   %ax,%ax
80102520:	66 90                	xchg   %ax,%ax
80102522:	66 90                	xchg   %ax,%ax
80102524:	66 90                	xchg   %ax,%ax
80102526:	66 90                	xchg   %ax,%ax
80102528:	66 90                	xchg   %ax,%ax
8010252a:	66 90                	xchg   %ax,%ax
8010252c:	66 90                	xchg   %ax,%ax
8010252e:	66 90                	xchg   %ax,%ax
80102530:	66 90                	xchg   %ax,%ax
80102532:	66 90                	xchg   %ax,%ax
80102534:	66 90                	xchg   %ax,%ax
80102536:	66 90                	xchg   %ax,%ax
80102538:	66 90                	xchg   %ax,%ax
8010253a:	66 90                	xchg   %ax,%ax
8010253c:	66 90                	xchg   %ax,%ax
8010253e:	66 90                	xchg   %ax,%ax

80102540 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102540:	55                   	push   %ebp
80102541:	89 e5                	mov    %esp,%ebp
80102543:	56                   	push   %esi
80102544:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102545:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
8010254c:	00 c0 fe 
  ioapic->reg = reg;
8010254f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102556:	00 00 00 
  return ioapic->data;
80102559:	8b 15 34 26 11 80    	mov    0x80112634,%edx
8010255f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102562:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102568:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010256e:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102575:	c1 ee 10             	shr    $0x10,%esi
80102578:	89 f0                	mov    %esi,%eax
8010257a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010257d:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80102580:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102583:	39 c2                	cmp    %eax,%edx
80102585:	74 16                	je     8010259d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102587:	83 ec 0c             	sub    $0xc,%esp
8010258a:	68 74 7e 10 80       	push   $0x80107e74
8010258f:	e8 5c e1 ff ff       	call   801006f0 <cprintf>
  ioapic->reg = reg;
80102594:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010259a:	83 c4 10             	add    $0x10,%esp

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010259d:	83 c6 21             	add    $0x21,%esi
{
801025a0:	ba 10 00 00 00       	mov    $0x10,%edx
801025a5:	b8 20 00 00 00       	mov    $0x20,%eax
801025aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801025b0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801025b7:	00 
801025b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801025bf:	00 
  ioapic->reg = reg;
801025c0:	89 11                	mov    %edx,(%ecx)
801025c2:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
801025c4:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  for(i = 0; i <= maxintr; i++){
801025ca:	83 c0 01             	add    $0x1,%eax
801025cd:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
801025d3:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
801025d6:	8d 5a 01             	lea    0x1(%edx),%ebx
  for(i = 0; i <= maxintr; i++){
801025d9:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
801025dc:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
801025de:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
801025e4:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801025eb:	39 f0                	cmp    %esi,%eax
801025ed:	75 d1                	jne    801025c0 <ioapicinit+0x80>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801025ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025f2:	5b                   	pop    %ebx
801025f3:	5e                   	pop    %esi
801025f4:	5d                   	pop    %ebp
801025f5:	c3                   	ret
801025f6:	66 90                	xchg   %ax,%ax
801025f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801025ff:	00 

80102600 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102600:	55                   	push   %ebp
  ioapic->reg = reg;
80102601:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
80102607:	89 e5                	mov    %esp,%ebp
80102609:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010260c:	8d 50 20             	lea    0x20(%eax),%edx
8010260f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102613:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102615:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010261b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010261e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102621:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102624:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102626:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010262b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010262e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102631:	5d                   	pop    %ebp
80102632:	c3                   	ret
80102633:	66 90                	xchg   %ax,%ax
80102635:	66 90                	xchg   %ax,%ax
80102637:	66 90                	xchg   %ax,%ax
80102639:	66 90                	xchg   %ax,%ax
8010263b:	66 90                	xchg   %ax,%ax
8010263d:	66 90                	xchg   %ax,%ax
8010263f:	90                   	nop

80102640 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102640:	55                   	push   %ebp
80102641:	89 e5                	mov    %esp,%ebp
80102643:	53                   	push   %ebx
80102644:	83 ec 04             	sub    $0x4,%esp
80102647:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010264a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102650:	75 76                	jne    801026c8 <kfree+0x88>
80102652:	81 fb 50 65 11 80    	cmp    $0x80116550,%ebx
80102658:	72 6e                	jb     801026c8 <kfree+0x88>
8010265a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102660:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102665:	77 61                	ja     801026c8 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102667:	83 ec 04             	sub    $0x4,%esp
8010266a:	68 00 10 00 00       	push   $0x1000
8010266f:	6a 01                	push   $0x1
80102671:	53                   	push   %ebx
80102672:	e8 09 25 00 00       	call   80104b80 <memset>

  if(kmem.use_lock)
80102677:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010267d:	83 c4 10             	add    $0x10,%esp
80102680:	85 d2                	test   %edx,%edx
80102682:	75 1c                	jne    801026a0 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102684:	a1 78 26 11 80       	mov    0x80112678,%eax
80102689:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010268b:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80102690:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102696:	85 c0                	test   %eax,%eax
80102698:	75 1e                	jne    801026b8 <kfree+0x78>
    release(&kmem.lock);
}
8010269a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010269d:	c9                   	leave
8010269e:	c3                   	ret
8010269f:	90                   	nop
    acquire(&kmem.lock);
801026a0:	83 ec 0c             	sub    $0xc,%esp
801026a3:	68 40 26 11 80       	push   $0x80112640
801026a8:	e8 b3 23 00 00       	call   80104a60 <acquire>
801026ad:	83 c4 10             	add    $0x10,%esp
801026b0:	eb d2                	jmp    80102684 <kfree+0x44>
801026b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
801026b8:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
801026bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026c2:	c9                   	leave
    release(&kmem.lock);
801026c3:	e9 38 23 00 00       	jmp    80104a00 <release>
    panic("kfree");
801026c8:	83 ec 0c             	sub    $0xc,%esp
801026cb:	68 cc 7a 10 80       	push   $0x80107acc
801026d0:	e8 cb dc ff ff       	call   801003a0 <panic>
801026d5:	8d 76 00             	lea    0x0(%esi),%esi
801026d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801026df:	00 

801026e0 <freerange>:
{
801026e0:	55                   	push   %ebp
801026e1:	89 e5                	mov    %esp,%ebp
801026e3:	56                   	push   %esi
801026e4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801026e5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801026e8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801026eb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801026f1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026f7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801026fd:	39 de                	cmp    %ebx,%esi
801026ff:	72 2b                	jb     8010272c <freerange+0x4c>
80102701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102708:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010270f:	00 
    kfree(p);
80102710:	83 ec 0c             	sub    $0xc,%esp
80102713:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102719:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010271f:	50                   	push   %eax
80102720:	e8 1b ff ff ff       	call   80102640 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102725:	83 c4 10             	add    $0x10,%esp
80102728:	39 de                	cmp    %ebx,%esi
8010272a:	73 e4                	jae    80102710 <freerange+0x30>
}
8010272c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010272f:	5b                   	pop    %ebx
80102730:	5e                   	pop    %esi
80102731:	5d                   	pop    %ebp
80102732:	c3                   	ret
80102733:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102738:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010273f:	00 

80102740 <kinit2>:
{
80102740:	55                   	push   %ebp
80102741:	89 e5                	mov    %esp,%ebp
80102743:	56                   	push   %esi
80102744:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102745:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102748:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010274b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102751:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102757:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010275d:	39 de                	cmp    %ebx,%esi
8010275f:	72 2b                	jb     8010278c <kinit2+0x4c>
80102761:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102768:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010276f:	00 
    kfree(p);
80102770:	83 ec 0c             	sub    $0xc,%esp
80102773:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102779:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010277f:	50                   	push   %eax
80102780:	e8 bb fe ff ff       	call   80102640 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102785:	83 c4 10             	add    $0x10,%esp
80102788:	39 de                	cmp    %ebx,%esi
8010278a:	73 e4                	jae    80102770 <kinit2+0x30>
  kmem.use_lock = 1;
8010278c:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
80102793:	00 00 00 
}
80102796:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102799:	5b                   	pop    %ebx
8010279a:	5e                   	pop    %esi
8010279b:	5d                   	pop    %ebp
8010279c:	c3                   	ret
8010279d:	8d 76 00             	lea    0x0(%esi),%esi

801027a0 <kinit1>:
{
801027a0:	55                   	push   %ebp
801027a1:	89 e5                	mov    %esp,%ebp
801027a3:	56                   	push   %esi
801027a4:	53                   	push   %ebx
801027a5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801027a8:	83 ec 08             	sub    $0x8,%esp
801027ab:	68 d2 7a 10 80       	push   $0x80107ad2
801027b0:	68 40 26 11 80       	push   $0x80112640
801027b5:	e8 86 20 00 00       	call   80104840 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801027ba:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027bd:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
801027c0:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
801027c7:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
801027ca:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801027d0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027d6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801027dc:	39 de                	cmp    %ebx,%esi
801027de:	72 1c                	jb     801027fc <kinit1+0x5c>
    kfree(p);
801027e0:	83 ec 0c             	sub    $0xc,%esp
801027e3:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027e9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801027ef:	50                   	push   %eax
801027f0:	e8 4b fe ff ff       	call   80102640 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027f5:	83 c4 10             	add    $0x10,%esp
801027f8:	39 de                	cmp    %ebx,%esi
801027fa:	73 e4                	jae    801027e0 <kinit1+0x40>
}
801027fc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027ff:	5b                   	pop    %ebx
80102800:	5e                   	pop    %esi
80102801:	5d                   	pop    %ebp
80102802:	c3                   	ret
80102803:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102808:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010280f:	00 

80102810 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102810:	a1 74 26 11 80       	mov    0x80112674,%eax
80102815:	85 c0                	test   %eax,%eax
80102817:	75 1f                	jne    80102838 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102819:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
8010281e:	85 c0                	test   %eax,%eax
80102820:	74 0e                	je     80102830 <kalloc+0x20>
    kmem.freelist = r->next;
80102822:	8b 10                	mov    (%eax),%edx
80102824:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
8010282a:	c3                   	ret
8010282b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    release(&kmem.lock);
  return (char*)r;
}
80102830:	c3                   	ret
80102831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
80102838:	55                   	push   %ebp
80102839:	89 e5                	mov    %esp,%ebp
8010283b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010283e:	68 40 26 11 80       	push   $0x80112640
80102843:	e8 18 22 00 00       	call   80104a60 <acquire>
  r = kmem.freelist;
80102848:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(kmem.use_lock)
8010284d:	8b 15 74 26 11 80    	mov    0x80112674,%edx
  if(r)
80102853:	83 c4 10             	add    $0x10,%esp
80102856:	85 c0                	test   %eax,%eax
80102858:	74 08                	je     80102862 <kalloc+0x52>
    kmem.freelist = r->next;
8010285a:	8b 08                	mov    (%eax),%ecx
8010285c:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
  if(kmem.use_lock)
80102862:	85 d2                	test   %edx,%edx
80102864:	74 16                	je     8010287c <kalloc+0x6c>
    release(&kmem.lock);
80102866:	83 ec 0c             	sub    $0xc,%esp
80102869:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010286c:	68 40 26 11 80       	push   $0x80112640
80102871:	e8 8a 21 00 00       	call   80104a00 <release>
  return (char*)r;
80102876:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102879:	83 c4 10             	add    $0x10,%esp
}
8010287c:	c9                   	leave
8010287d:	c3                   	ret
8010287e:	66 90                	xchg   %ax,%ax

80102880 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102880:	ba 64 00 00 00       	mov    $0x64,%edx
80102885:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102886:	a8 01                	test   $0x1,%al
80102888:	74 6e                	je     801028f8 <kbdgetc+0x78>
8010288a:	ba 60 00 00 00       	mov    $0x60,%edx
8010288f:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102890:	8b 15 7c 26 11 80    	mov    0x8011267c,%edx
  data = inb(KBDATAP);
80102896:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80102899:	3c e0                	cmp    $0xe0,%al
8010289b:	74 63                	je     80102900 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
8010289d:	84 c0                	test   %al,%al
8010289f:	78 6f                	js     80102910 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
    shift &= ~E0ESC;
801028a1:	83 c8 80             	or     $0xffffff80,%eax
801028a4:	f6 c2 40             	test   $0x40,%dl
801028a7:	0f b6 c0             	movzbl %al,%eax
801028aa:	0f 45 c8             	cmovne %eax,%ecx
801028ad:	89 d0                	mov    %edx,%eax
801028af:	83 e0 bf             	and    $0xffffffbf,%eax
801028b2:	f6 c2 40             	test   $0x40,%dl
801028b5:	0f 45 d0             	cmovne %eax,%edx
  }

  shift |= shiftcode[data];
801028b8:	0f b6 81 c0 80 10 80 	movzbl -0x7fef7f40(%ecx),%eax
801028bf:	09 c2                	or     %eax,%edx
  shift ^= togglecode[data];
801028c1:	0f b6 81 c0 7f 10 80 	movzbl -0x7fef8040(%ecx),%eax
801028c8:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
801028ca:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
801028cc:	89 15 7c 26 11 80    	mov    %edx,0x8011267c
  c = charcode[shift & (CTL | SHIFT)][data];
801028d2:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801028d5:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
801028d8:	8b 04 85 a0 7f 10 80 	mov    -0x7fef8060(,%eax,4),%eax
801028df:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
801028e3:	74 18                	je     801028fd <kbdgetc+0x7d>
    if('a' <= c && c <= 'z')
801028e5:	8d 50 9f             	lea    -0x61(%eax),%edx
801028e8:	83 fa 19             	cmp    $0x19,%edx
801028eb:	77 4b                	ja     80102938 <kbdgetc+0xb8>
      c += 'A' - 'a';
801028ed:	83 e8 20             	sub    $0x20,%eax
801028f0:	c3                   	ret
801028f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801028f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801028fd:	c3                   	ret
801028fe:	66 90                	xchg   %ax,%ax
    shift |= E0ESC;
80102900:	83 ca 40             	or     $0x40,%edx
    return 0;
80102903:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102905:	89 15 7c 26 11 80    	mov    %edx,0x8011267c
    return 0;
8010290b:	c3                   	ret
8010290c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    data = (shift & E0ESC ? data : data & 0x7F);
80102910:	83 e0 7f             	and    $0x7f,%eax
80102913:	f6 c2 40             	test   $0x40,%dl
80102916:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102919:	0f b6 81 c0 80 10 80 	movzbl -0x7fef7f40(%ecx),%eax
80102920:	83 c8 40             	or     $0x40,%eax
80102923:	0f b6 c0             	movzbl %al,%eax
80102926:	f7 d0                	not    %eax
80102928:	21 d0                	and    %edx,%eax
8010292a:	a3 7c 26 11 80       	mov    %eax,0x8011267c
    return 0;
8010292f:	31 c0                	xor    %eax,%eax
80102931:	c3                   	ret
80102932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
80102938:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010293b:	8d 50 20             	lea    0x20(%eax),%edx
8010293e:	83 f9 1a             	cmp    $0x1a,%ecx
80102941:	0f 42 c2             	cmovb  %edx,%eax
  return c;
80102944:	c3                   	ret
80102945:	8d 76 00             	lea    0x0(%esi),%esi
80102948:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010294f:	00 

80102950 <kbdintr>:

void
kbdintr(void)
{
80102950:	55                   	push   %ebp
80102951:	89 e5                	mov    %esp,%ebp
80102953:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102956:	68 80 28 10 80       	push   $0x80102880
8010295b:	e8 b0 df ff ff       	call   80100910 <consoleintr>
}
80102960:	83 c4 10             	add    $0x10,%esp
80102963:	c9                   	leave
80102964:	c3                   	ret
80102965:	66 90                	xchg   %ax,%ax
80102967:	66 90                	xchg   %ax,%ax
80102969:	66 90                	xchg   %ax,%ax
8010296b:	66 90                	xchg   %ax,%ax
8010296d:	66 90                	xchg   %ax,%ax
8010296f:	90                   	nop

80102970 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102970:	a1 80 26 11 80       	mov    0x80112680,%eax
80102975:	85 c0                	test   %eax,%eax
80102977:	0f 84 cc 00 00 00    	je     80102a49 <lapicinit+0xd9>
  lapic[index] = value;
8010297d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102984:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102987:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010298a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102991:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102994:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102997:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010299e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801029a1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029a4:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801029ab:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801029ae:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029b1:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801029b8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801029bb:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029be:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801029c5:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801029c8:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801029cb:	f7 40 30 00 00 fc 00 	testl  $0xfc0000,0x30(%eax)
801029d2:	75 7c                	jne    80102a50 <lapicinit+0xe0>
  lapic[index] = value;
801029d4:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801029db:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029de:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029e1:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801029e8:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029eb:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029ee:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801029f5:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029f8:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029fb:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102a02:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a05:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a08:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102a0f:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a12:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a15:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102a1c:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102a1f:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102a22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102a28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102a2f:	00 
80102a30:	f7 80 00 03 00 00 00 	testl  $0x1000,0x300(%eax)
80102a37:	10 00 00 
80102a3a:	75 f4                	jne    80102a30 <lapicinit+0xc0>
  lapic[index] = value;
80102a3c:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102a43:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a46:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102a49:	c3                   	ret
80102a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102a50:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102a57:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a5a:	8b 50 20             	mov    0x20(%eax),%edx
80102a5d:	e9 72 ff ff ff       	jmp    801029d4 <lapicinit+0x64>
80102a62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102a68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102a6f:	00 

80102a70 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102a70:	a1 80 26 11 80       	mov    0x80112680,%eax
80102a75:	85 c0                	test   %eax,%eax
80102a77:	74 07                	je     80102a80 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102a79:	8b 40 20             	mov    0x20(%eax),%eax
80102a7c:	c1 e8 18             	shr    $0x18,%eax
80102a7f:	c3                   	ret
80102a80:	31 c0                	xor    %eax,%eax
}
80102a82:	c3                   	ret
80102a83:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102a88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102a8f:	00 

80102a90 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102a90:	a1 80 26 11 80       	mov    0x80112680,%eax
80102a95:	85 c0                	test   %eax,%eax
80102a97:	74 0d                	je     80102aa6 <lapiceoi+0x16>
  lapic[index] = value;
80102a99:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102aa0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102aa3:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102aa6:	c3                   	ret
80102aa7:	90                   	nop
80102aa8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102aaf:	00 

80102ab0 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102ab0:	c3                   	ret
80102ab1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ab8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102abf:	00 

80102ac0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102ac0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ac1:	ba 70 00 00 00       	mov    $0x70,%edx
80102ac6:	89 e5                	mov    %esp,%ebp
80102ac8:	56                   	push   %esi
80102ac9:	53                   	push   %ebx
80102aca:	83 ec 04             	sub    $0x4,%esp
80102acd:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
80102ad1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102ad4:	88 45 f4             	mov    %al,-0xc(%ebp)
80102ad7:	b8 0f 00 00 00       	mov    $0xf,%eax
80102adc:	ee                   	out    %al,(%dx)
80102add:	b8 0a 00 00 00       	mov    $0xa,%eax
80102ae2:	ba 71 00 00 00       	mov    $0x71,%edx
80102ae7:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102ae8:	31 c0                	xor    %eax,%eax
80102aea:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102af0:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102af2:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102af5:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102af8:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102afb:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102b01:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102b04:	a1 80 26 11 80       	mov    0x80112680,%eax
80102b09:	c1 e2 18             	shl    $0x18,%edx
80102b0c:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b12:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b15:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102b1c:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b1f:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b22:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102b29:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b2c:	8b 58 20             	mov    0x20(%eax),%ebx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102b2f:	bb 02 00 00 00       	mov    $0x2,%ebx
  lapic[index] = value;
80102b34:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b3a:	8b 70 20             	mov    0x20(%eax),%esi
  lapic[index] = value;
80102b3d:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b43:	8b 70 20             	mov    0x20(%eax),%esi
  for(i = 0; i < 2; i++){
80102b46:	83 fb 01             	cmp    $0x1,%ebx
80102b49:	75 0d                	jne    80102b58 <lapicstartap+0x98>
    microdelay(200);
  }
}
80102b4b:	83 c4 04             	add    $0x4,%esp
80102b4e:	5b                   	pop    %ebx
80102b4f:	5e                   	pop    %esi
80102b50:	5d                   	pop    %ebp
80102b51:	c3                   	ret
80102b52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(i = 0; i < 2; i++){
80102b58:	bb 01 00 00 00       	mov    $0x1,%ebx
80102b5d:	eb d5                	jmp    80102b34 <lapicstartap+0x74>
80102b5f:	90                   	nop

80102b60 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102b60:	55                   	push   %ebp
80102b61:	b8 0b 00 00 00       	mov    $0xb,%eax
80102b66:	ba 70 00 00 00       	mov    $0x70,%edx
80102b6b:	89 e5                	mov    %esp,%ebp
80102b6d:	83 ec 58             	sub    $0x58,%esp
80102b70:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80102b73:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b74:	ba 71 00 00 00       	mov    $0x71,%edx
80102b79:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b7a:	88 45 b7             	mov    %al,-0x49(%ebp)
80102b7d:	8d 76 00             	lea    0x0(%esi),%esi
80102b80:	31 c0                	xor    %eax,%eax
80102b82:	ba 70 00 00 00       	mov    $0x70,%edx
80102b87:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b88:	ba 71 00 00 00       	mov    $0x71,%edx
80102b8d:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
80102b8e:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b91:	ba 70 00 00 00       	mov    $0x70,%edx
80102b96:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102b99:	b8 02 00 00 00       	mov    $0x2,%eax
80102b9e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b9f:	ba 71 00 00 00       	mov    $0x71,%edx
80102ba4:	ec                   	in     (%dx),%al
80102ba5:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ba8:	ba 70 00 00 00       	mov    $0x70,%edx
80102bad:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102bb0:	b8 04 00 00 00       	mov    $0x4,%eax
80102bb5:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bb6:	ba 71 00 00 00       	mov    $0x71,%edx
80102bbb:	ec                   	in     (%dx),%al
80102bbc:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bbf:	ba 70 00 00 00       	mov    $0x70,%edx
80102bc4:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102bc7:	b8 07 00 00 00       	mov    $0x7,%eax
80102bcc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bcd:	ba 71 00 00 00       	mov    $0x71,%edx
80102bd2:	ec                   	in     (%dx),%al
80102bd3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bd6:	ba 70 00 00 00       	mov    $0x70,%edx
80102bdb:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102bde:	b8 08 00 00 00       	mov    $0x8,%eax
80102be3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102be4:	ba 71 00 00 00       	mov    $0x71,%edx
80102be9:	ec                   	in     (%dx),%al
80102bea:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bed:	ba 70 00 00 00       	mov    $0x70,%edx
80102bf2:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102bf5:	b8 09 00 00 00       	mov    $0x9,%eax
80102bfa:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bfb:	ba 71 00 00 00       	mov    $0x71,%edx
80102c00:	ec                   	in     (%dx),%al
80102c01:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c04:	ba 70 00 00 00       	mov    $0x70,%edx
80102c09:	89 45 cc             	mov    %eax,-0x34(%ebp)
80102c0c:	b8 0a 00 00 00       	mov    $0xa,%eax
80102c11:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c12:	ba 71 00 00 00       	mov    $0x71,%edx
80102c17:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102c18:	84 c0                	test   %al,%al
80102c1a:	0f 88 60 ff ff ff    	js     80102b80 <cmostime+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c20:	31 c0                	xor    %eax,%eax
80102c22:	ba 70 00 00 00       	mov    $0x70,%edx
80102c27:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c28:	ba 71 00 00 00       	mov    $0x71,%edx
80102c2d:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
80102c2e:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c31:	ba 70 00 00 00       	mov    $0x70,%edx
80102c36:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102c39:	b8 02 00 00 00       	mov    $0x2,%eax
80102c3e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c3f:	ba 71 00 00 00       	mov    $0x71,%edx
80102c44:	ec                   	in     (%dx),%al
80102c45:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c48:	ba 70 00 00 00       	mov    $0x70,%edx
80102c4d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102c50:	b8 04 00 00 00       	mov    $0x4,%eax
80102c55:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c56:	ba 71 00 00 00       	mov    $0x71,%edx
80102c5b:	ec                   	in     (%dx),%al
80102c5c:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c5f:	ba 70 00 00 00       	mov    $0x70,%edx
80102c64:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102c67:	b8 07 00 00 00       	mov    $0x7,%eax
80102c6c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c6d:	ba 71 00 00 00       	mov    $0x71,%edx
80102c72:	ec                   	in     (%dx),%al
80102c73:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c76:	ba 70 00 00 00       	mov    $0x70,%edx
80102c7b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102c7e:	b8 08 00 00 00       	mov    $0x8,%eax
80102c83:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c84:	ba 71 00 00 00       	mov    $0x71,%edx
80102c89:	ec                   	in     (%dx),%al
80102c8a:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c8d:	ba 70 00 00 00       	mov    $0x70,%edx
80102c92:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102c95:	b8 09 00 00 00       	mov    $0x9,%eax
80102c9a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c9b:	ba 71 00 00 00       	mov    $0x71,%edx
80102ca0:	ec                   	in     (%dx),%al
80102ca1:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102ca4:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102ca7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102caa:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102cad:	6a 18                	push   $0x18
80102caf:	50                   	push   %eax
80102cb0:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102cb3:	50                   	push   %eax
80102cb4:	e8 07 1f 00 00       	call   80104bc0 <memcmp>
80102cb9:	83 c4 10             	add    $0x10,%esp
80102cbc:	85 c0                	test   %eax,%eax
80102cbe:	0f 85 bc fe ff ff    	jne    80102b80 <cmostime+0x20>
      break;
  }

  // convert
  if(bcd) {
80102cc4:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102cc7:	f6 45 b7 04          	testb  $0x4,-0x49(%ebp)
80102ccb:	75 78                	jne    80102d45 <cmostime+0x1e5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102ccd:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102cd0:	89 c2                	mov    %eax,%edx
80102cd2:	83 e0 0f             	and    $0xf,%eax
80102cd5:	c1 ea 04             	shr    $0x4,%edx
80102cd8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102cdb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102cde:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102ce1:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ce4:	89 c2                	mov    %eax,%edx
80102ce6:	83 e0 0f             	and    $0xf,%eax
80102ce9:	c1 ea 04             	shr    $0x4,%edx
80102cec:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102cef:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102cf2:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102cf5:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102cf8:	89 c2                	mov    %eax,%edx
80102cfa:	83 e0 0f             	and    $0xf,%eax
80102cfd:	c1 ea 04             	shr    $0x4,%edx
80102d00:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d03:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d06:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102d09:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102d0c:	89 c2                	mov    %eax,%edx
80102d0e:	83 e0 0f             	and    $0xf,%eax
80102d11:	c1 ea 04             	shr    $0x4,%edx
80102d14:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d17:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d1a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102d1d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102d20:	89 c2                	mov    %eax,%edx
80102d22:	83 e0 0f             	and    $0xf,%eax
80102d25:	c1 ea 04             	shr    $0x4,%edx
80102d28:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d2b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d2e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102d31:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102d34:	89 c2                	mov    %eax,%edx
80102d36:	83 e0 0f             	and    $0xf,%eax
80102d39:	c1 ea 04             	shr    $0x4,%edx
80102d3c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d3f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d42:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102d45:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102d48:	89 03                	mov    %eax,(%ebx)
80102d4a:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102d4d:	89 43 04             	mov    %eax,0x4(%ebx)
80102d50:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102d53:	89 43 08             	mov    %eax,0x8(%ebx)
80102d56:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102d59:	89 43 0c             	mov    %eax,0xc(%ebx)
80102d5c:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102d5f:	89 43 10             	mov    %eax,0x10(%ebx)
80102d62:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102d65:	89 43 14             	mov    %eax,0x14(%ebx)
  r->year += 2000;
80102d68:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
80102d6f:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80102d72:	c9                   	leave
80102d73:	c3                   	ret
80102d74:	66 90                	xchg   %ax,%ax
80102d76:	66 90                	xchg   %ax,%ax
80102d78:	66 90                	xchg   %ax,%ax
80102d7a:	66 90                	xchg   %ax,%ax
80102d7c:	66 90                	xchg   %ax,%ax
80102d7e:	66 90                	xchg   %ax,%ax

80102d80 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d80:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102d86:	85 c9                	test   %ecx,%ecx
80102d88:	0f 8e 8a 00 00 00    	jle    80102e18 <install_trans+0x98>
{
80102d8e:	55                   	push   %ebp
80102d8f:	89 e5                	mov    %esp,%ebp
80102d91:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102d92:	31 ff                	xor    %edi,%edi
{
80102d94:	56                   	push   %esi
80102d95:	53                   	push   %ebx
80102d96:	83 ec 0c             	sub    $0xc,%esp
80102d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102da0:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102da5:	83 ec 08             	sub    $0x8,%esp
80102da8:	8d 44 38 01          	lea    0x1(%eax,%edi,1),%eax
80102dac:	50                   	push   %eax
80102dad:	ff 35 e4 26 11 80    	push   0x801126e4
80102db3:	e8 18 d3 ff ff       	call   801000d0 <bread>
80102db8:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102dba:	58                   	pop    %eax
80102dbb:	5a                   	pop    %edx
80102dbc:	ff 34 bd ec 26 11 80 	push   -0x7feed914(,%edi,4)
80102dc3:	ff 35 e4 26 11 80    	push   0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102dc9:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102dcc:	e8 ff d2 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102dd1:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102dd4:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102dd6:	8d 46 5c             	lea    0x5c(%esi),%eax
80102dd9:	68 00 02 00 00       	push   $0x200
80102dde:	50                   	push   %eax
80102ddf:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102de2:	50                   	push   %eax
80102de3:	e8 38 1e 00 00       	call   80104c20 <memmove>
    bwrite(dbuf);  // write dst to disk
80102de8:	89 1c 24             	mov    %ebx,(%esp)
80102deb:	e8 d0 d3 ff ff       	call   801001c0 <bwrite>
    brelse(lbuf);
80102df0:	89 34 24             	mov    %esi,(%esp)
80102df3:	e8 08 d4 ff ff       	call   80100200 <brelse>
    brelse(dbuf);
80102df8:	89 1c 24             	mov    %ebx,(%esp)
80102dfb:	e8 00 d4 ff ff       	call   80100200 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102e00:	83 c4 10             	add    $0x10,%esp
80102e03:	39 3d e8 26 11 80    	cmp    %edi,0x801126e8
80102e09:	7f 95                	jg     80102da0 <install_trans+0x20>
  }
}
80102e0b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e0e:	5b                   	pop    %ebx
80102e0f:	5e                   	pop    %esi
80102e10:	5f                   	pop    %edi
80102e11:	5d                   	pop    %ebp
80102e12:	c3                   	ret
80102e13:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e18:	c3                   	ret
80102e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102e20 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102e20:	55                   	push   %ebp
80102e21:	89 e5                	mov    %esp,%ebp
80102e23:	53                   	push   %ebx
80102e24:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102e27:	ff 35 d4 26 11 80    	push   0x801126d4
80102e2d:	ff 35 e4 26 11 80    	push   0x801126e4
80102e33:	e8 98 d2 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102e38:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102e3b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102e3d:	a1 e8 26 11 80       	mov    0x801126e8,%eax
80102e42:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102e45:	85 c0                	test   %eax,%eax
80102e47:	7e 29                	jle    80102e72 <write_head+0x52>
80102e49:	31 d2                	xor    %edx,%edx
80102e4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e50:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e57:	00 
80102e58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e5f:	00 
    hb->block[i] = log.lh.block[i];
80102e60:	8b 0c 95 ec 26 11 80 	mov    -0x7feed914(,%edx,4),%ecx
80102e67:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102e6b:	83 c2 01             	add    $0x1,%edx
80102e6e:	39 d0                	cmp    %edx,%eax
80102e70:	75 ee                	jne    80102e60 <write_head+0x40>
  }
  bwrite(buf);
80102e72:	83 ec 0c             	sub    $0xc,%esp
80102e75:	53                   	push   %ebx
80102e76:	e8 45 d3 ff ff       	call   801001c0 <bwrite>
  brelse(buf);
80102e7b:	89 1c 24             	mov    %ebx,(%esp)
80102e7e:	e8 7d d3 ff ff       	call   80100200 <brelse>
}
80102e83:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e86:	83 c4 10             	add    $0x10,%esp
80102e89:	c9                   	leave
80102e8a:	c3                   	ret
80102e8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102e90 <initlog>:
{
80102e90:	55                   	push   %ebp
80102e91:	89 e5                	mov    %esp,%ebp
80102e93:	53                   	push   %ebx
80102e94:	83 ec 2c             	sub    $0x2c,%esp
80102e97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102e9a:	68 d7 7a 10 80       	push   $0x80107ad7
80102e9f:	68 a0 26 11 80       	push   $0x801126a0
80102ea4:	e8 97 19 00 00       	call   80104840 <initlock>
  readsb(dev, &sb);
80102ea9:	58                   	pop    %eax
80102eaa:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102ead:	5a                   	pop    %edx
80102eae:	50                   	push   %eax
80102eaf:	53                   	push   %ebx
80102eb0:	e8 3b e7 ff ff       	call   801015f0 <readsb>
  log.start = sb.logstart;
80102eb5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102eb8:	59                   	pop    %ecx
  log.dev = dev;
80102eb9:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
  log.size = sb.nlog;
80102ebf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102ec2:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  log.size = sb.nlog;
80102ec7:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
  struct buf *buf = bread(log.dev, log.start);
80102ecd:	5a                   	pop    %edx
80102ece:	50                   	push   %eax
80102ecf:	53                   	push   %ebx
80102ed0:	e8 fb d1 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102ed5:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102ed8:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102edb:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102ee1:	85 db                	test   %ebx,%ebx
80102ee3:	7e 2d                	jle    80102f12 <initlog+0x82>
80102ee5:	31 d2                	xor    %edx,%edx
80102ee7:	eb 17                	jmp    80102f00 <initlog+0x70>
80102ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ef0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102ef7:	00 
80102ef8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102eff:	00 
    log.lh.block[i] = lh->block[i];
80102f00:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102f04:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102f0b:	83 c2 01             	add    $0x1,%edx
80102f0e:	39 d3                	cmp    %edx,%ebx
80102f10:	75 ee                	jne    80102f00 <initlog+0x70>
  brelse(buf);
80102f12:	83 ec 0c             	sub    $0xc,%esp
80102f15:	50                   	push   %eax
80102f16:	e8 e5 d2 ff ff       	call   80100200 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102f1b:	e8 60 fe ff ff       	call   80102d80 <install_trans>
  log.lh.n = 0;
80102f20:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102f27:	00 00 00 
  write_head(); // clear the log
80102f2a:	e8 f1 fe ff ff       	call   80102e20 <write_head>
}
80102f2f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f32:	83 c4 10             	add    $0x10,%esp
80102f35:	c9                   	leave
80102f36:	c3                   	ret
80102f37:	90                   	nop
80102f38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f3f:	00 

80102f40 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102f40:	55                   	push   %ebp
80102f41:	89 e5                	mov    %esp,%ebp
80102f43:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102f46:	68 a0 26 11 80       	push   $0x801126a0
80102f4b:	e8 10 1b 00 00       	call   80104a60 <acquire>
80102f50:	83 c4 10             	add    $0x10,%esp
80102f53:	eb 18                	jmp    80102f6d <begin_op+0x2d>
80102f55:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102f58:	83 ec 08             	sub    $0x8,%esp
80102f5b:	68 a0 26 11 80       	push   $0x801126a0
80102f60:	68 a0 26 11 80       	push   $0x801126a0
80102f65:	e8 46 13 00 00       	call   801042b0 <sleep>
80102f6a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102f6d:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102f72:	85 c0                	test   %eax,%eax
80102f74:	75 e2                	jne    80102f58 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102f76:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102f7b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102f81:	83 c0 01             	add    $0x1,%eax
80102f84:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102f87:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102f8a:	83 fa 1e             	cmp    $0x1e,%edx
80102f8d:	7f c9                	jg     80102f58 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102f8f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102f92:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102f97:	68 a0 26 11 80       	push   $0x801126a0
80102f9c:	e8 5f 1a 00 00       	call   80104a00 <release>
      break;
    }
  }
}
80102fa1:	83 c4 10             	add    $0x10,%esp
80102fa4:	c9                   	leave
80102fa5:	c3                   	ret
80102fa6:	66 90                	xchg   %ax,%ax
80102fa8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102faf:	00 

80102fb0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102fb0:	55                   	push   %ebp
80102fb1:	89 e5                	mov    %esp,%ebp
80102fb3:	83 ec 24             	sub    $0x24,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102fb6:	68 a0 26 11 80       	push   $0x801126a0
{
80102fbb:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  acquire(&log.lock);
80102fbe:	e8 9d 1a 00 00       	call   80104a60 <acquire>
  log.outstanding -= 1;
80102fc3:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102fc8:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102fcb:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102fce:	a1 e0 26 11 80       	mov    0x801126e0,%eax
  log.outstanding -= 1;
80102fd3:	89 1d dc 26 11 80    	mov    %ebx,0x801126dc
  if(log.committing)
80102fd9:	85 c0                	test   %eax,%eax
80102fdb:	0f 85 20 01 00 00    	jne    80103101 <end_op+0x151>
    panic("log.committing");
  if(log.outstanding == 0){
80102fe1:	85 db                	test   %ebx,%ebx
80102fe3:	0f 85 f7 00 00 00    	jne    801030e0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102fe9:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102ff0:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102ff3:	83 ec 0c             	sub    $0xc,%esp
80102ff6:	68 a0 26 11 80       	push   $0x801126a0
80102ffb:	e8 00 1a 00 00       	call   80104a00 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103000:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80103006:	83 c4 10             	add    $0x10,%esp
80103009:	85 c9                	test   %ecx,%ecx
8010300b:	7f 3b                	jg     80103048 <end_op+0x98>
    acquire(&log.lock);
8010300d:	83 ec 0c             	sub    $0xc,%esp
80103010:	68 a0 26 11 80       	push   $0x801126a0
80103015:	e8 46 1a 00 00       	call   80104a60 <acquire>
    wakeup(&log);
8010301a:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
    log.committing = 0;
80103021:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80103028:	00 00 00 
    wakeup(&log);
8010302b:	e8 40 13 00 00       	call   80104370 <wakeup>
    release(&log.lock);
80103030:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80103037:	e8 c4 19 00 00       	call   80104a00 <release>
}
8010303c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    release(&log.lock);
8010303f:	83 c4 10             	add    $0x10,%esp
}
80103042:	c9                   	leave
80103043:	c3                   	ret
80103044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103048:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010304b:	89 7d fc             	mov    %edi,-0x4(%ebp)
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
8010304e:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80103053:	83 ec 08             	sub    $0x8,%esp
80103056:	8d 44 18 01          	lea    0x1(%eax,%ebx,1),%eax
8010305a:	50                   	push   %eax
8010305b:	ff 35 e4 26 11 80    	push   0x801126e4
80103061:	e8 6a d0 ff ff       	call   801000d0 <bread>
80103066:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103068:	58                   	pop    %eax
80103069:	5a                   	pop    %edx
8010306a:	ff 34 9d ec 26 11 80 	push   -0x7feed914(,%ebx,4)
80103071:	ff 35 e4 26 11 80    	push   0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80103077:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010307a:	e8 51 d0 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
8010307f:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103082:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103084:	8d 40 5c             	lea    0x5c(%eax),%eax
80103087:	68 00 02 00 00       	push   $0x200
8010308c:	50                   	push   %eax
8010308d:	8d 46 5c             	lea    0x5c(%esi),%eax
80103090:	50                   	push   %eax
80103091:	e8 8a 1b 00 00       	call   80104c20 <memmove>
    bwrite(to);  // write the log
80103096:	89 34 24             	mov    %esi,(%esp)
80103099:	e8 22 d1 ff ff       	call   801001c0 <bwrite>
    brelse(from);
8010309e:	89 3c 24             	mov    %edi,(%esp)
801030a1:	e8 5a d1 ff ff       	call   80100200 <brelse>
    brelse(to);
801030a6:	89 34 24             	mov    %esi,(%esp)
801030a9:	e8 52 d1 ff ff       	call   80100200 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801030ae:	83 c4 10             	add    $0x10,%esp
801030b1:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
801030b7:	7c 95                	jl     8010304e <end_op+0x9e>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
801030b9:	e8 62 fd ff ff       	call   80102e20 <write_head>
    install_trans(); // Now install writes to home locations
801030be:	e8 bd fc ff ff       	call   80102d80 <install_trans>
    log.lh.n = 0;
801030c3:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
801030ca:	00 00 00 
    write_head();    // Erase the transaction from the log
801030cd:	e8 4e fd ff ff       	call   80102e20 <write_head>
801030d2:	8b 75 f8             	mov    -0x8(%ebp),%esi
801030d5:	8b 7d fc             	mov    -0x4(%ebp),%edi
801030d8:	e9 30 ff ff ff       	jmp    8010300d <end_op+0x5d>
801030dd:	8d 76 00             	lea    0x0(%esi),%esi
    wakeup(&log);
801030e0:	83 ec 0c             	sub    $0xc,%esp
801030e3:	68 a0 26 11 80       	push   $0x801126a0
801030e8:	e8 83 12 00 00       	call   80104370 <wakeup>
  release(&log.lock);
801030ed:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
801030f4:	e8 07 19 00 00       	call   80104a00 <release>
}
801030f9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  release(&log.lock);
801030fc:	83 c4 10             	add    $0x10,%esp
}
801030ff:	c9                   	leave
80103100:	c3                   	ret
    panic("log.committing");
80103101:	83 ec 0c             	sub    $0xc,%esp
80103104:	89 75 f8             	mov    %esi,-0x8(%ebp)
80103107:	68 db 7a 10 80       	push   $0x80107adb
8010310c:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010310f:	e8 8c d2 ff ff       	call   801003a0 <panic>
80103114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103118:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010311f:	00 

80103120 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103120:	55                   	push   %ebp
80103121:	89 e5                	mov    %esp,%ebp
80103123:	53                   	push   %ebx
80103124:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103127:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
{
8010312d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103130:	83 fa 1d             	cmp    $0x1d,%edx
80103133:	7f 7d                	jg     801031b2 <log_write+0x92>
80103135:	a1 d8 26 11 80       	mov    0x801126d8,%eax
8010313a:	83 e8 01             	sub    $0x1,%eax
8010313d:	39 c2                	cmp    %eax,%edx
8010313f:	7d 71                	jge    801031b2 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103141:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80103146:	85 c0                	test   %eax,%eax
80103148:	7e 75                	jle    801031bf <log_write+0x9f>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010314a:	83 ec 0c             	sub    $0xc,%esp
8010314d:	68 a0 26 11 80       	push   $0x801126a0
80103152:	e8 09 19 00 00       	call   80104a60 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80103157:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
8010315a:	83 c4 10             	add    $0x10,%esp
8010315d:	31 c0                	xor    %eax,%eax
8010315f:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80103165:	85 d2                	test   %edx,%edx
80103167:	7f 0e                	jg     80103177 <log_write+0x57>
80103169:	eb 15                	jmp    80103180 <log_write+0x60>
8010316b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103170:	83 c0 01             	add    $0x1,%eax
80103173:	39 d0                	cmp    %edx,%eax
80103175:	74 29                	je     801031a0 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103177:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
8010317e:	75 f0                	jne    80103170 <log_write+0x50>
  log.lh.block[i] = b->blockno;
80103180:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
  if (i == log.lh.n)
80103187:	39 c2                	cmp    %eax,%edx
80103189:	74 1c                	je     801031a7 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
8010318b:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
8010318e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80103191:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80103198:	c9                   	leave
  release(&log.lock);
80103199:	e9 62 18 00 00       	jmp    80104a00 <release>
8010319e:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
801031a0:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
    log.lh.n++;
801031a7:	83 c2 01             	add    $0x1,%edx
801031aa:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
801031b0:	eb d9                	jmp    8010318b <log_write+0x6b>
    panic("too big a transaction");
801031b2:	83 ec 0c             	sub    $0xc,%esp
801031b5:	68 ea 7a 10 80       	push   $0x80107aea
801031ba:	e8 e1 d1 ff ff       	call   801003a0 <panic>
    panic("log_write outside of trans");
801031bf:	83 ec 0c             	sub    $0xc,%esp
801031c2:	68 00 7b 10 80       	push   $0x80107b00
801031c7:	e8 d4 d1 ff ff       	call   801003a0 <panic>
801031cc:	66 90                	xchg   %ax,%ax
801031ce:	66 90                	xchg   %ax,%ax

801031d0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801031d0:	55                   	push   %ebp
801031d1:	89 e5                	mov    %esp,%ebp
801031d3:	53                   	push   %ebx
801031d4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801031d7:	e8 a4 09 00 00       	call   80103b80 <cpuid>
801031dc:	89 c3                	mov    %eax,%ebx
801031de:	e8 9d 09 00 00       	call   80103b80 <cpuid>
801031e3:	83 ec 04             	sub    $0x4,%esp
801031e6:	53                   	push   %ebx
801031e7:	50                   	push   %eax
801031e8:	68 1b 7b 10 80       	push   $0x80107b1b
801031ed:	e8 fe d4 ff ff       	call   801006f0 <cprintf>
  idtinit();       // load idt register
801031f2:	e8 f9 2d 00 00       	call   80105ff0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801031f7:	e8 04 09 00 00       	call   80103b00 <mycpu>
801031fc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801031fe:	b8 01 00 00 00       	mov    $0x1,%eax
80103203:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010320a:	e8 61 0c 00 00       	call   80103e70 <scheduler>
8010320f:	90                   	nop

80103210 <mpenter>:
{
80103210:	55                   	push   %ebp
80103211:	89 e5                	mov    %esp,%ebp
80103213:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103216:	e8 15 3f 00 00       	call   80107130 <switchkvm>
  seginit();
8010321b:	e8 80 3e 00 00       	call   801070a0 <seginit>
  lapicinit();
80103220:	e8 4b f7 ff ff       	call   80102970 <lapicinit>
  mpmain();
80103225:	e8 a6 ff ff ff       	call   801031d0 <mpmain>
8010322a:	66 90                	xchg   %ax,%ax
8010322c:	66 90                	xchg   %ax,%ax
8010322e:	66 90                	xchg   %ax,%ax

80103230 <main>:
{
80103230:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103234:	83 e4 f0             	and    $0xfffffff0,%esp
80103237:	ff 71 fc             	push   -0x4(%ecx)
8010323a:	55                   	push   %ebp
8010323b:	89 e5                	mov    %esp,%ebp
8010323d:	53                   	push   %ebx
8010323e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010323f:	83 ec 08             	sub    $0x8,%esp
80103242:	68 00 00 40 80       	push   $0x80400000
80103247:	68 50 65 11 80       	push   $0x80116550
8010324c:	e8 4f f5 ff ff       	call   801027a0 <kinit1>
  kvmalloc();      // kernel page table
80103251:	e8 ca 43 00 00       	call   80107620 <kvmalloc>
  mpinit();        // detect other processors
80103256:	e8 85 01 00 00       	call   801033e0 <mpinit>
  lapicinit();     // interrupt controller
8010325b:	e8 10 f7 ff ff       	call   80102970 <lapicinit>
  seginit();       // segment descriptors
80103260:	e8 3b 3e 00 00       	call   801070a0 <seginit>
  picinit();       // disable pic
80103265:	e8 66 03 00 00       	call   801035d0 <picinit>
  ioapicinit();    // another interrupt controller
8010326a:	e8 d1 f2 ff ff       	call   80102540 <ioapicinit>
  consoleinit();   // console hardware
8010326f:	e8 8c d8 ff ff       	call   80100b00 <consoleinit>
  uartinit();      // serial port
80103274:	e8 87 30 00 00       	call   80106300 <uartinit>
  pinit();         // process table
80103279:	e8 62 08 00 00       	call   80103ae0 <pinit>
  tvinit();        // trap vectors
8010327e:	e8 bd 2c 00 00       	call   80105f40 <tvinit>
  binit();         // buffer cache
80103283:	e8 b8 cd ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103288:	e8 33 dc ff ff       	call   80100ec0 <fileinit>
  seminit();       // semaphore table
8010328d:	e8 8e 12 00 00       	call   80104520 <seminit>
  ideinit();       // disk 
80103292:	e8 69 f0 ff ff       	call   80102300 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103297:	83 c4 0c             	add    $0xc,%esp
8010329a:	68 8a 00 00 00       	push   $0x8a
8010329f:	68 8c b4 10 80       	push   $0x8010b48c
801032a4:	68 00 70 00 80       	push   $0x80007000
801032a9:	e8 72 19 00 00       	call   80104c20 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801032ae:	83 c4 10             	add    $0x10,%esp
801032b1:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
801032b8:	00 00 00 
801032bb:	05 a0 27 11 80       	add    $0x801127a0,%eax
801032c0:	3d a0 27 11 80       	cmp    $0x801127a0,%eax
801032c5:	76 79                	jbe    80103340 <main+0x110>
801032c7:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
801032cc:	eb 1b                	jmp    801032e9 <main+0xb9>
801032ce:	66 90                	xchg   %ax,%ax
801032d0:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
801032d7:	00 00 00 
801032da:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801032e0:	05 a0 27 11 80       	add    $0x801127a0,%eax
801032e5:	39 c3                	cmp    %eax,%ebx
801032e7:	73 57                	jae    80103340 <main+0x110>
    if(c == mycpu())  // We've started already.
801032e9:	e8 12 08 00 00       	call   80103b00 <mycpu>
801032ee:	39 d8                	cmp    %ebx,%eax
801032f0:	74 de                	je     801032d0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801032f2:	e8 19 f5 ff ff       	call   80102810 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
801032f7:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
801032fa:	c7 05 f8 6f 00 80 10 	movl   $0x80103210,0x80006ff8
80103301:	32 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103304:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010330b:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010330e:	05 00 10 00 00       	add    $0x1000,%eax
80103313:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103318:	0f b6 03             	movzbl (%ebx),%eax
8010331b:	68 00 70 00 00       	push   $0x7000
80103320:	50                   	push   %eax
80103321:	e8 9a f7 ff ff       	call   80102ac0 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103326:	83 c4 10             	add    $0x10,%esp
80103329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103330:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103336:	85 c0                	test   %eax,%eax
80103338:	74 f6                	je     80103330 <main+0x100>
8010333a:	eb 94                	jmp    801032d0 <main+0xa0>
8010333c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103340:	83 ec 08             	sub    $0x8,%esp
80103343:	68 00 00 00 8e       	push   $0x8e000000
80103348:	68 00 00 40 80       	push   $0x80400000
8010334d:	e8 ee f3 ff ff       	call   80102740 <kinit2>
  userinit();      // first user process
80103352:	e8 79 08 00 00       	call   80103bd0 <userinit>
  mpmain();        // finish this processor's setup
80103357:	e8 74 fe ff ff       	call   801031d0 <mpmain>
8010335c:	66 90                	xchg   %ax,%ax
8010335e:	66 90                	xchg   %ax,%ax

80103360 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103360:	55                   	push   %ebp
80103361:	89 e5                	mov    %esp,%ebp
80103363:	83 ec 18             	sub    $0x18,%esp
80103366:	89 75 f8             	mov    %esi,-0x8(%ebp)
  uchar *e, *p, *addr;

  addr = P2V(a);
80103369:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010336f:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  e = addr+len;
80103372:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
  for(p = addr; p < e; p += sizeof(struct mp))
80103375:	39 de                	cmp    %ebx,%esi
80103377:	73 5a                	jae    801033d3 <mpsearch1+0x73>
80103379:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010337c:	eb 08                	jmp    80103386 <mpsearch1+0x26>
8010337e:	66 90                	xchg   %ax,%ax
80103380:	89 fe                	mov    %edi,%esi
80103382:	39 df                	cmp    %ebx,%edi
80103384:	73 4a                	jae    801033d0 <mpsearch1+0x70>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103386:	83 ec 04             	sub    $0x4,%esp
80103389:	8d 7e 10             	lea    0x10(%esi),%edi
8010338c:	6a 04                	push   $0x4
8010338e:	68 2f 7b 10 80       	push   $0x80107b2f
80103393:	56                   	push   %esi
80103394:	e8 27 18 00 00       	call   80104bc0 <memcmp>
80103399:	83 c4 10             	add    $0x10,%esp
8010339c:	85 c0                	test   %eax,%eax
8010339e:	75 e0                	jne    80103380 <mpsearch1+0x20>
801033a0:	89 f2                	mov    %esi,%edx
801033a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801033a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801033af:	00 
    sum += addr[i];
801033b0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801033b3:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801033b6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801033b8:	39 fa                	cmp    %edi,%edx
801033ba:	75 f4                	jne    801033b0 <mpsearch1+0x50>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033bc:	84 c0                	test   %al,%al
801033be:	75 c0                	jne    80103380 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801033c0:	89 f0                	mov    %esi,%eax
801033c2:	8b 7d fc             	mov    -0x4(%ebp),%edi
801033c5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801033c8:	8b 75 f8             	mov    -0x8(%ebp),%esi
801033cb:	c9                   	leave
801033cc:	c3                   	ret
801033cd:	8d 76 00             	lea    0x0(%esi),%esi
801033d0:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return 0;
801033d3:	31 f6                	xor    %esi,%esi
}
801033d5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801033d8:	89 f0                	mov    %esi,%eax
801033da:	8b 75 f8             	mov    -0x8(%ebp),%esi
801033dd:	c9                   	leave
801033de:	c3                   	ret
801033df:	90                   	nop

801033e0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801033e0:	55                   	push   %ebp
801033e1:	89 e5                	mov    %esp,%ebp
801033e3:	57                   	push   %edi
801033e4:	56                   	push   %esi
801033e5:	53                   	push   %ebx
801033e6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801033e9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801033f0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801033f7:	c1 e0 08             	shl    $0x8,%eax
801033fa:	09 d0                	or     %edx,%eax
801033fc:	c1 e0 04             	shl    $0x4,%eax
801033ff:	75 1b                	jne    8010341c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103401:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103408:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010340f:	c1 e0 08             	shl    $0x8,%eax
80103412:	09 d0                	or     %edx,%eax
80103414:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103417:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010341c:	ba 00 04 00 00       	mov    $0x400,%edx
80103421:	e8 3a ff ff ff       	call   80103360 <mpsearch1>
80103426:	89 c3                	mov    %eax,%ebx
80103428:	85 c0                	test   %eax,%eax
8010342a:	0f 84 48 01 00 00    	je     80103578 <mpinit+0x198>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103430:	8b 73 04             	mov    0x4(%ebx),%esi
80103433:	85 f6                	test   %esi,%esi
80103435:	0f 84 2d 01 00 00    	je     80103568 <mpinit+0x188>
  if(memcmp(conf, "PCMP", 4) != 0)
8010343b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010343e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80103444:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103447:	6a 04                	push   $0x4
80103449:	68 34 7b 10 80       	push   $0x80107b34
8010344e:	50                   	push   %eax
8010344f:	e8 6c 17 00 00       	call   80104bc0 <memcmp>
80103454:	83 c4 10             	add    $0x10,%esp
80103457:	89 c2                	mov    %eax,%edx
80103459:	85 c0                	test   %eax,%eax
8010345b:	0f 85 07 01 00 00    	jne    80103568 <mpinit+0x188>
  if(conf->version != 1 && conf->version != 4)
80103461:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103468:	3c 01                	cmp    $0x1,%al
8010346a:	74 08                	je     80103474 <mpinit+0x94>
8010346c:	3c 04                	cmp    $0x4,%al
8010346e:	0f 85 f4 00 00 00    	jne    80103568 <mpinit+0x188>
  if(sum((uchar*)conf, conf->length) != 0)
80103474:	0f b7 8e 04 00 00 80 	movzwl -0x7ffffffc(%esi),%ecx
  for(i=0; i<len; i++)
8010347b:	66 85 c9             	test   %cx,%cx
8010347e:	74 28                	je     801034a8 <mpinit+0xc8>
80103480:	89 f0                	mov    %esi,%eax
80103482:	8d 3c 31             	lea    (%ecx,%esi,1),%edi
80103485:	8d 76 00             	lea    0x0(%esi),%esi
80103488:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010348f:	00 
    sum += addr[i];
80103490:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
80103497:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
8010349a:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
8010349c:	39 c7                	cmp    %eax,%edi
8010349e:	75 f0                	jne    80103490 <mpinit+0xb0>
  if(sum((uchar*)conf, conf->length) != 0)
801034a0:	84 d2                	test   %dl,%dl
801034a2:	0f 85 c0 00 00 00    	jne    80103568 <mpinit+0x188>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801034a8:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801034ae:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  lapic = (uint*)conf->lapicaddr;
801034b1:	a3 80 26 11 80       	mov    %eax,0x80112680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801034b6:	0f b7 8e 04 00 00 80 	movzwl -0x7ffffffc(%esi),%ecx
801034bd:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
801034c3:	01 f9                	add    %edi,%ecx
801034c5:	39 c8                	cmp    %ecx,%eax
801034c7:	72 14                	jb     801034dd <mpinit+0xfd>
801034c9:	eb 2b                	jmp    801034f6 <mpinit+0x116>
801034cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    switch(*p){
801034d0:	77 7e                	ja     80103550 <mpinit+0x170>
801034d2:	84 d2                	test   %dl,%dl
801034d4:	74 4a                	je     80103520 <mpinit+0x140>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801034d6:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801034d9:	39 c8                	cmp    %ecx,%eax
801034db:	73 19                	jae    801034f6 <mpinit+0x116>
    switch(*p){
801034dd:	0f b6 10             	movzbl (%eax),%edx
801034e0:	80 fa 02             	cmp    $0x2,%dl
801034e3:	75 eb                	jne    801034d0 <mpinit+0xf0>
      ioapicid = ioapic->apicno;
801034e5:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801034e9:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801034ec:	88 15 80 27 11 80    	mov    %dl,0x80112780
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801034f2:	39 c8                	cmp    %ecx,%eax
801034f4:	72 e7                	jb     801034dd <mpinit+0xfd>
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801034f6:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
801034fa:	74 15                	je     80103511 <mpinit+0x131>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801034fc:	b8 70 00 00 00       	mov    $0x70,%eax
80103501:	ba 22 00 00 00       	mov    $0x22,%edx
80103506:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103507:	ba 23 00 00 00       	mov    $0x23,%edx
8010350c:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
8010350d:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103510:	ee                   	out    %al,(%dx)
  }
}
80103511:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103514:	5b                   	pop    %ebx
80103515:	5e                   	pop    %esi
80103516:	5f                   	pop    %edi
80103517:	5d                   	pop    %ebp
80103518:	c3                   	ret
80103519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
80103520:	8b 35 84 27 11 80    	mov    0x80112784,%esi
80103526:	83 fe 07             	cmp    $0x7,%esi
80103529:	7f 19                	jg     80103544 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010352b:	69 fe b0 00 00 00    	imul   $0xb0,%esi,%edi
80103531:	0f b6 50 01          	movzbl 0x1(%eax),%edx
        ncpu++;
80103535:	83 c6 01             	add    $0x1,%esi
80103538:	89 35 84 27 11 80    	mov    %esi,0x80112784
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010353e:	88 97 a0 27 11 80    	mov    %dl,-0x7feed860(%edi)
      p += sizeof(struct mpproc);
80103544:	83 c0 14             	add    $0x14,%eax
      continue;
80103547:	eb 90                	jmp    801034d9 <mpinit+0xf9>
80103549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(*p){
80103550:	83 ea 03             	sub    $0x3,%edx
80103553:	80 fa 01             	cmp    $0x1,%dl
80103556:	0f 86 7a ff ff ff    	jbe    801034d6 <mpinit+0xf6>
8010355c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103560:	eb fe                	jmp    80103560 <mpinit+0x180>
80103562:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103568:	83 ec 0c             	sub    $0xc,%esp
8010356b:	68 39 7b 10 80       	push   $0x80107b39
80103570:	e8 2b ce ff ff       	call   801003a0 <panic>
80103575:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = addr; p < e; p += sizeof(struct mp))
80103578:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
8010357d:	eb 0b                	jmp    8010358a <mpinit+0x1aa>
8010357f:	90                   	nop
80103580:	89 f3                	mov    %esi,%ebx
80103582:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103588:	74 de                	je     80103568 <mpinit+0x188>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010358a:	83 ec 04             	sub    $0x4,%esp
8010358d:	8d 73 10             	lea    0x10(%ebx),%esi
80103590:	6a 04                	push   $0x4
80103592:	68 2f 7b 10 80       	push   $0x80107b2f
80103597:	53                   	push   %ebx
80103598:	e8 23 16 00 00       	call   80104bc0 <memcmp>
8010359d:	83 c4 10             	add    $0x10,%esp
801035a0:	85 c0                	test   %eax,%eax
801035a2:	75 dc                	jne    80103580 <mpinit+0x1a0>
801035a4:	89 da                	mov    %ebx,%edx
801035a6:	66 90                	xchg   %ax,%ax
801035a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801035af:	00 
    sum += addr[i];
801035b0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801035b3:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801035b6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801035b8:	39 d6                	cmp    %edx,%esi
801035ba:	75 f4                	jne    801035b0 <mpinit+0x1d0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801035bc:	84 c0                	test   %al,%al
801035be:	75 c0                	jne    80103580 <mpinit+0x1a0>
801035c0:	e9 6b fe ff ff       	jmp    80103430 <mpinit+0x50>
801035c5:	66 90                	xchg   %ax,%ax
801035c7:	66 90                	xchg   %ax,%ax
801035c9:	66 90                	xchg   %ax,%ax
801035cb:	66 90                	xchg   %ax,%ax
801035cd:	66 90                	xchg   %ax,%ax
801035cf:	90                   	nop

801035d0 <picinit>:
801035d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801035d5:	ba 21 00 00 00       	mov    $0x21,%edx
801035da:	ee                   	out    %al,(%dx)
801035db:	ba a1 00 00 00       	mov    $0xa1,%edx
801035e0:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801035e1:	c3                   	ret
801035e2:	66 90                	xchg   %ax,%ax
801035e4:	66 90                	xchg   %ax,%ax
801035e6:	66 90                	xchg   %ax,%ax
801035e8:	66 90                	xchg   %ax,%ax
801035ea:	66 90                	xchg   %ax,%ax
801035ec:	66 90                	xchg   %ax,%ax
801035ee:	66 90                	xchg   %ax,%ax
801035f0:	66 90                	xchg   %ax,%ax
801035f2:	66 90                	xchg   %ax,%ax
801035f4:	66 90                	xchg   %ax,%ax
801035f6:	66 90                	xchg   %ax,%ax
801035f8:	66 90                	xchg   %ax,%ax
801035fa:	66 90                	xchg   %ax,%ax
801035fc:	66 90                	xchg   %ax,%ax
801035fe:	66 90                	xchg   %ax,%ax

80103600 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103600:	55                   	push   %ebp
80103601:	89 e5                	mov    %esp,%ebp
80103603:	56                   	push   %esi
80103604:	53                   	push   %ebx
80103605:	83 ec 10             	sub    $0x10,%esp
80103608:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010360b:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010360e:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103614:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010361a:	e8 c1 d8 ff ff       	call   80100ee0 <filealloc>
8010361f:	89 03                	mov    %eax,(%ebx)
80103621:	85 c0                	test   %eax,%eax
80103623:	0f 84 a9 00 00 00    	je     801036d2 <pipealloc+0xd2>
80103629:	e8 b2 d8 ff ff       	call   80100ee0 <filealloc>
8010362e:	89 06                	mov    %eax,(%esi)
80103630:	85 c0                	test   %eax,%eax
80103632:	0f 84 88 00 00 00    	je     801036c0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103638:	e8 d3 f1 ff ff       	call   80102810 <kalloc>
8010363d:	85 c0                	test   %eax,%eax
8010363f:	0f 84 ab 00 00 00    	je     801036f0 <pipealloc+0xf0>
    goto bad;
  p->readopen = 1;
80103645:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010364c:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
8010364f:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103652:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103659:	00 00 00 
  p->nwrite = 0;
8010365c:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103663:	00 00 00 
  p->nread = 0;
80103666:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
8010366d:	00 00 00 
  initlock(&p->lock, "pipe");
80103670:	68 51 7b 10 80       	push   $0x80107b51
80103675:	50                   	push   %eax
80103676:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103679:	e8 c2 11 00 00       	call   80104840 <initlock>
  (*f0)->type = FD_PIPE;
8010367e:	8b 13                	mov    (%ebx),%edx
  (*f0)->readable = 1;
  (*f0)->writable = 0;
  (*f0)->pipe = p;
80103680:	8b 45 f4             	mov    -0xc(%ebp),%eax
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103683:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103686:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
  (*f0)->readable = 1;
8010368c:	8b 13                	mov    (%ebx),%edx
8010368e:	c6 42 08 01          	movb   $0x1,0x8(%edx)
  (*f0)->writable = 0;
80103692:	8b 13                	mov    (%ebx),%edx
80103694:	c6 42 09 00          	movb   $0x0,0x9(%edx)
  (*f0)->pipe = p;
80103698:	8b 13                	mov    (%ebx),%edx
8010369a:	89 42 0c             	mov    %eax,0xc(%edx)
  (*f1)->type = FD_PIPE;
8010369d:	8b 16                	mov    (%esi),%edx
8010369f:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
  (*f1)->readable = 0;
801036a5:	8b 16                	mov    (%esi),%edx
801036a7:	c6 42 08 00          	movb   $0x0,0x8(%edx)
  (*f1)->writable = 1;
801036ab:	8b 16                	mov    (%esi),%edx
801036ad:	c6 42 09 01          	movb   $0x1,0x9(%edx)
  (*f1)->pipe = p;
801036b1:	8b 16                	mov    (%esi),%edx
801036b3:	89 42 0c             	mov    %eax,0xc(%edx)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801036b6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  return 0;
801036b9:	31 c0                	xor    %eax,%eax
}
801036bb:	5b                   	pop    %ebx
801036bc:	5e                   	pop    %esi
801036bd:	5d                   	pop    %ebp
801036be:	c3                   	ret
801036bf:	90                   	nop
  if(*f0)
801036c0:	8b 03                	mov    (%ebx),%eax
801036c2:	85 c0                	test   %eax,%eax
801036c4:	74 1e                	je     801036e4 <pipealloc+0xe4>
    fileclose(*f0);
801036c6:	83 ec 0c             	sub    $0xc,%esp
801036c9:	50                   	push   %eax
801036ca:	e8 d1 d8 ff ff       	call   80100fa0 <fileclose>
801036cf:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801036d2:	8b 06                	mov    (%esi),%eax
801036d4:	85 c0                	test   %eax,%eax
801036d6:	74 0c                	je     801036e4 <pipealloc+0xe4>
    fileclose(*f1);
801036d8:	83 ec 0c             	sub    $0xc,%esp
801036db:	50                   	push   %eax
801036dc:	e8 bf d8 ff ff       	call   80100fa0 <fileclose>
801036e1:	83 c4 10             	add    $0x10,%esp
}
801036e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  return -1;
801036e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801036ec:	5b                   	pop    %ebx
801036ed:	5e                   	pop    %esi
801036ee:	5d                   	pop    %ebp
801036ef:	c3                   	ret
  if(*f0)
801036f0:	8b 03                	mov    (%ebx),%eax
801036f2:	85 c0                	test   %eax,%eax
801036f4:	75 d0                	jne    801036c6 <pipealloc+0xc6>
801036f6:	eb da                	jmp    801036d2 <pipealloc+0xd2>
801036f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801036ff:	00 

80103700 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103700:	55                   	push   %ebp
80103701:	89 e5                	mov    %esp,%ebp
80103703:	56                   	push   %esi
80103704:	53                   	push   %ebx
80103705:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103708:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010370b:	83 ec 0c             	sub    $0xc,%esp
8010370e:	53                   	push   %ebx
8010370f:	e8 4c 13 00 00       	call   80104a60 <acquire>
  if(writable){
80103714:	83 c4 10             	add    $0x10,%esp
80103717:	85 f6                	test   %esi,%esi
80103719:	74 45                	je     80103760 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010371b:	83 ec 0c             	sub    $0xc,%esp
8010371e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103724:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010372b:	00 00 00 
    wakeup(&p->nread);
8010372e:	50                   	push   %eax
8010372f:	e8 3c 0c 00 00       	call   80104370 <wakeup>
80103734:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103737:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010373d:	85 d2                	test   %edx,%edx
8010373f:	75 0a                	jne    8010374b <pipeclose+0x4b>
80103741:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103747:	85 c0                	test   %eax,%eax
80103749:	74 35                	je     80103780 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010374b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010374e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103751:	5b                   	pop    %ebx
80103752:	5e                   	pop    %esi
80103753:	5d                   	pop    %ebp
    release(&p->lock);
80103754:	e9 a7 12 00 00       	jmp    80104a00 <release>
80103759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103760:	83 ec 0c             	sub    $0xc,%esp
80103763:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103769:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103770:	00 00 00 
    wakeup(&p->nwrite);
80103773:	50                   	push   %eax
80103774:	e8 f7 0b 00 00       	call   80104370 <wakeup>
80103779:	83 c4 10             	add    $0x10,%esp
8010377c:	eb b9                	jmp    80103737 <pipeclose+0x37>
8010377e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103780:	83 ec 0c             	sub    $0xc,%esp
80103783:	53                   	push   %ebx
80103784:	e8 77 12 00 00       	call   80104a00 <release>
    kfree((char*)p);
80103789:	83 c4 10             	add    $0x10,%esp
8010378c:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010378f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103792:	5b                   	pop    %ebx
80103793:	5e                   	pop    %esi
80103794:	5d                   	pop    %ebp
    kfree((char*)p);
80103795:	e9 a6 ee ff ff       	jmp    80102640 <kfree>
8010379a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801037a0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801037a0:	55                   	push   %ebp
801037a1:	89 e5                	mov    %esp,%ebp
801037a3:	83 ec 34             	sub    $0x34,%esp
801037a6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801037a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801037ac:	89 7d fc             	mov    %edi,-0x4(%ebp)
801037af:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
801037b2:	53                   	push   %ebx
801037b3:	e8 a8 12 00 00       	call   80104a60 <acquire>
  for(i = 0; i < n; i++){
801037b8:	83 c4 10             	add    $0x10,%esp
801037bb:	85 ff                	test   %edi,%edi
801037bd:	0f 8e d4 00 00 00    	jle    80103897 <pipewrite+0xf7>
801037c3:	89 75 f8             	mov    %esi,-0x8(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801037c6:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801037cc:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801037cf:	89 7d 10             	mov    %edi,0x10(%ebp)
801037d2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801037d5:	8d 34 39             	lea    (%ecx,%edi,1),%esi
801037d8:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801037db:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801037e1:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801037e7:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801037ed:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
801037f3:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
801037f6:	0f 85 b9 00 00 00    	jne    801038b5 <pipewrite+0x115>
801037fc:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801037ff:	eb 3d                	jmp    8010383e <pipewrite+0x9e>
80103801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80103808:	e8 93 03 00 00       	call   80103ba0 <myproc>
8010380d:	8b 48 24             	mov    0x24(%eax),%ecx
80103810:	85 c9                	test   %ecx,%ecx
80103812:	75 34                	jne    80103848 <pipewrite+0xa8>
      wakeup(&p->nread);
80103814:	83 ec 0c             	sub    $0xc,%esp
80103817:	56                   	push   %esi
80103818:	e8 53 0b 00 00       	call   80104370 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010381d:	58                   	pop    %eax
8010381e:	5a                   	pop    %edx
8010381f:	53                   	push   %ebx
80103820:	57                   	push   %edi
80103821:	e8 8a 0a 00 00       	call   801042b0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103826:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010382c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103832:	83 c4 10             	add    $0x10,%esp
80103835:	05 00 02 00 00       	add    $0x200,%eax
8010383a:	39 c2                	cmp    %eax,%edx
8010383c:	75 2a                	jne    80103868 <pipewrite+0xc8>
      if(p->readopen == 0 || myproc()->killed){
8010383e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103844:	85 c0                	test   %eax,%eax
80103846:	75 c0                	jne    80103808 <pipewrite+0x68>
        release(&p->lock);
80103848:	83 ec 0c             	sub    $0xc,%esp
8010384b:	53                   	push   %ebx
8010384c:	e8 af 11 00 00       	call   80104a00 <release>
        return -1;
80103851:	8b 75 f8             	mov    -0x8(%ebp),%esi
80103854:	83 c4 10             	add    $0x10,%esp
80103857:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
8010385c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010385f:	8b 7d fc             	mov    -0x4(%ebp),%edi
80103862:	c9                   	leave
80103863:	c3                   	ret
80103864:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103868:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010386b:	8d 42 01             	lea    0x1(%edx),%eax
8010386e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  for(i = 0; i < n; i++){
80103874:	83 c1 01             	add    $0x1,%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103877:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
8010387d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103880:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
80103884:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103888:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
8010388b:	0f 85 50 ff ff ff    	jne    801037e1 <pipewrite+0x41>
80103891:	8b 7d 10             	mov    0x10(%ebp),%edi
80103894:	8b 75 f8             	mov    -0x8(%ebp),%esi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103897:	83 ec 0c             	sub    $0xc,%esp
8010389a:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801038a0:	50                   	push   %eax
801038a1:	e8 ca 0a 00 00       	call   80104370 <wakeup>
  release(&p->lock);
801038a6:	89 1c 24             	mov    %ebx,(%esp)
801038a9:	e8 52 11 00 00       	call   80104a00 <release>
  return n;
801038ae:	83 c4 10             	add    $0x10,%esp
801038b1:	89 f8                	mov    %edi,%eax
801038b3:	eb a7                	jmp    8010385c <pipewrite+0xbc>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801038b5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801038b8:	eb b1                	jmp    8010386b <pipewrite+0xcb>
801038ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801038c0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801038c0:	55                   	push   %ebp
801038c1:	89 e5                	mov    %esp,%ebp
801038c3:	57                   	push   %edi
801038c4:	56                   	push   %esi
801038c5:	53                   	push   %ebx
801038c6:	83 ec 18             	sub    $0x18,%esp
801038c9:	8b 75 08             	mov    0x8(%ebp),%esi
801038cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801038cf:	56                   	push   %esi
801038d0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801038d6:	e8 85 11 00 00       	call   80104a60 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801038db:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801038e1:	83 c4 10             	add    $0x10,%esp
801038e4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801038ea:	74 2f                	je     8010391b <piperead+0x5b>
801038ec:	eb 37                	jmp    80103925 <piperead+0x65>
801038ee:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
801038f0:	e8 ab 02 00 00       	call   80103ba0 <myproc>
801038f5:	8b 48 24             	mov    0x24(%eax),%ecx
801038f8:	85 c9                	test   %ecx,%ecx
801038fa:	0f 85 90 00 00 00    	jne    80103990 <piperead+0xd0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103900:	83 ec 08             	sub    $0x8,%esp
80103903:	56                   	push   %esi
80103904:	53                   	push   %ebx
80103905:	e8 a6 09 00 00       	call   801042b0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010390a:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103910:	83 c4 10             	add    $0x10,%esp
80103913:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103919:	75 0a                	jne    80103925 <piperead+0x65>
8010391b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103921:	85 d2                	test   %edx,%edx
80103923:	75 cb                	jne    801038f0 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103925:	8b 55 10             	mov    0x10(%ebp),%edx
80103928:	31 db                	xor    %ebx,%ebx
8010392a:	85 d2                	test   %edx,%edx
8010392c:	7f 36                	jg     80103964 <piperead+0xa4>
8010392e:	eb 3c                	jmp    8010396c <piperead+0xac>
80103930:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103937:	00 
80103938:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010393f:	00 
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103940:	8d 48 01             	lea    0x1(%eax),%ecx
80103943:	25 ff 01 00 00       	and    $0x1ff,%eax
80103948:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010394e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103953:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103956:	83 c3 01             	add    $0x1,%ebx
80103959:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010395c:	74 0e                	je     8010396c <piperead+0xac>
8010395e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
    if(p->nread == p->nwrite)
80103964:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010396a:	75 d4                	jne    80103940 <piperead+0x80>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010396c:	83 ec 0c             	sub    $0xc,%esp
8010396f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103975:	50                   	push   %eax
80103976:	e8 f5 09 00 00       	call   80104370 <wakeup>
  release(&p->lock);
8010397b:	89 34 24             	mov    %esi,(%esp)
8010397e:	e8 7d 10 00 00       	call   80104a00 <release>
  return i;
80103983:	83 c4 10             	add    $0x10,%esp
}
80103986:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103989:	89 d8                	mov    %ebx,%eax
8010398b:	5b                   	pop    %ebx
8010398c:	5e                   	pop    %esi
8010398d:	5f                   	pop    %edi
8010398e:	5d                   	pop    %ebp
8010398f:	c3                   	ret
      release(&p->lock);
80103990:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103993:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103998:	56                   	push   %esi
80103999:	e8 62 10 00 00       	call   80104a00 <release>
      return -1;
8010399e:	83 c4 10             	add    $0x10,%esp
}
801039a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801039a4:	89 d8                	mov    %ebx,%eax
801039a6:	5b                   	pop    %ebx
801039a7:	5e                   	pop    %esi
801039a8:	5f                   	pop    %edi
801039a9:	5d                   	pop    %ebp
801039aa:	c3                   	ret
801039ab:	66 90                	xchg   %ax,%ax
801039ad:	66 90                	xchg   %ax,%ax
801039af:	66 90                	xchg   %ax,%ax
801039b1:	66 90                	xchg   %ax,%ax
801039b3:	66 90                	xchg   %ax,%ax
801039b5:	66 90                	xchg   %ax,%ax
801039b7:	66 90                	xchg   %ax,%ax
801039b9:	66 90                	xchg   %ax,%ax
801039bb:	66 90                	xchg   %ax,%ax
801039bd:	66 90                	xchg   %ax,%ax
801039bf:	90                   	nop

801039c0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801039c0:	55                   	push   %ebp
801039c1:	89 e5                	mov    %esp,%ebp
801039c3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801039c4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
801039c9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801039cc:	68 20 2d 11 80       	push   $0x80112d20
801039d1:	e8 8a 10 00 00       	call   80104a60 <acquire>
801039d6:	83 c4 10             	add    $0x10,%esp
801039d9:	eb 10                	jmp    801039eb <allocproc+0x2b>
801039db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801039e0:	83 c3 7c             	add    $0x7c,%ebx
801039e3:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
801039e9:	74 75                	je     80103a60 <allocproc+0xa0>
    if(p->state == UNUSED)
801039eb:	8b 43 0c             	mov    0xc(%ebx),%eax
801039ee:	85 c0                	test   %eax,%eax
801039f0:	75 ee                	jne    801039e0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801039f2:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
801039f7:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801039fa:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103a01:	89 43 10             	mov    %eax,0x10(%ebx)
80103a04:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80103a07:	68 20 2d 11 80       	push   $0x80112d20
  p->pid = nextpid++;
80103a0c:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80103a12:	e8 e9 0f 00 00       	call   80104a00 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103a17:	e8 f4 ed ff ff       	call   80102810 <kalloc>
80103a1c:	83 c4 10             	add    $0x10,%esp
80103a1f:	89 43 08             	mov    %eax,0x8(%ebx)
80103a22:	85 c0                	test   %eax,%eax
80103a24:	74 53                	je     80103a79 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103a26:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103a2c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103a2f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103a34:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103a37:	c7 40 14 1f 5f 10 80 	movl   $0x80105f1f,0x14(%eax)
  p->context = (struct context*)sp;
80103a3e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103a41:	6a 14                	push   $0x14
80103a43:	6a 00                	push   $0x0
80103a45:	50                   	push   %eax
80103a46:	e8 35 11 00 00       	call   80104b80 <memset>
  p->context->eip = (uint)forkret;
80103a4b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103a4e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103a51:	c7 40 10 90 3a 10 80 	movl   $0x80103a90,0x10(%eax)
}
80103a58:	89 d8                	mov    %ebx,%eax
80103a5a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a5d:	c9                   	leave
80103a5e:	c3                   	ret
80103a5f:	90                   	nop
  release(&ptable.lock);
80103a60:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103a63:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103a65:	68 20 2d 11 80       	push   $0x80112d20
80103a6a:	e8 91 0f 00 00       	call   80104a00 <release>
}
80103a6f:	89 d8                	mov    %ebx,%eax
  return 0;
80103a71:	83 c4 10             	add    $0x10,%esp
}
80103a74:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a77:	c9                   	leave
80103a78:	c3                   	ret
    p->state = UNUSED;
80103a79:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80103a80:	31 db                	xor    %ebx,%ebx
}
80103a82:	89 d8                	mov    %ebx,%eax
80103a84:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a87:	c9                   	leave
80103a88:	c3                   	ret
80103a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103a90 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103a90:	55                   	push   %ebp
80103a91:	89 e5                	mov    %esp,%ebp
80103a93:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103a96:	68 20 2d 11 80       	push   $0x80112d20
80103a9b:	e8 60 0f 00 00       	call   80104a00 <release>

  if (first) {
80103aa0:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103aa5:	83 c4 10             	add    $0x10,%esp
80103aa8:	85 c0                	test   %eax,%eax
80103aaa:	75 04                	jne    80103ab0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103aac:	c9                   	leave
80103aad:	c3                   	ret
80103aae:	66 90                	xchg   %ax,%ax
    first = 0;
80103ab0:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103ab7:	00 00 00 
    iinit(ROOTDEV);
80103aba:	83 ec 0c             	sub    $0xc,%esp
80103abd:	6a 01                	push   $0x1
80103abf:	e8 6c db ff ff       	call   80101630 <iinit>
    initlog(ROOTDEV);
80103ac4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103acb:	e8 c0 f3 ff ff       	call   80102e90 <initlog>
80103ad0:	83 c4 10             	add    $0x10,%esp
}
80103ad3:	c9                   	leave
80103ad4:	c3                   	ret
80103ad5:	8d 76 00             	lea    0x0(%esi),%esi
80103ad8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103adf:	00 

80103ae0 <pinit>:
{
80103ae0:	55                   	push   %ebp
80103ae1:	89 e5                	mov    %esp,%ebp
80103ae3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103ae6:	68 56 7b 10 80       	push   $0x80107b56
80103aeb:	68 20 2d 11 80       	push   $0x80112d20
80103af0:	e8 4b 0d 00 00       	call   80104840 <initlock>
}
80103af5:	83 c4 10             	add    $0x10,%esp
80103af8:	c9                   	leave
80103af9:	c3                   	ret
80103afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103b00 <mycpu>:
{
80103b00:	55                   	push   %ebp
80103b01:	89 e5                	mov    %esp,%ebp
80103b03:	56                   	push   %esi
80103b04:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103b05:	9c                   	pushf
80103b06:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103b07:	f6 c4 02             	test   $0x2,%ah
80103b0a:	75 65                	jne    80103b71 <mycpu+0x71>
  apicid = lapicid();
80103b0c:	e8 5f ef ff ff       	call   80102a70 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103b11:	8b 1d 84 27 11 80    	mov    0x80112784,%ebx
  apicid = lapicid();
80103b17:	89 c6                	mov    %eax,%esi
  for (i = 0; i < ncpu; ++i) {
80103b19:	85 db                	test   %ebx,%ebx
80103b1b:	7e 47                	jle    80103b64 <mycpu+0x64>
80103b1d:	31 d2                	xor    %edx,%edx
80103b1f:	eb 26                	jmp    80103b47 <mycpu+0x47>
80103b21:	eb 1d                	jmp    80103b40 <mycpu+0x40>
80103b23:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103b28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103b2f:	00 
80103b30:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103b37:	00 
80103b38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103b3f:	00 
80103b40:	83 c2 01             	add    $0x1,%edx
80103b43:	39 da                	cmp    %ebx,%edx
80103b45:	74 1d                	je     80103b64 <mycpu+0x64>
    if (cpus[i].apicid == apicid)
80103b47:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
80103b4d:	0f b6 88 a0 27 11 80 	movzbl -0x7feed860(%eax),%ecx
80103b54:	39 f1                	cmp    %esi,%ecx
80103b56:	75 e8                	jne    80103b40 <mycpu+0x40>
}
80103b58:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103b5b:	05 a0 27 11 80       	add    $0x801127a0,%eax
}
80103b60:	5b                   	pop    %ebx
80103b61:	5e                   	pop    %esi
80103b62:	5d                   	pop    %ebp
80103b63:	c3                   	ret
  panic("unknown apicid\n");
80103b64:	83 ec 0c             	sub    $0xc,%esp
80103b67:	68 5d 7b 10 80       	push   $0x80107b5d
80103b6c:	e8 2f c8 ff ff       	call   801003a0 <panic>
    panic("mycpu called with interrupts enabled\n");
80103b71:	83 ec 0c             	sub    $0xc,%esp
80103b74:	68 a8 7e 10 80       	push   $0x80107ea8
80103b79:	e8 22 c8 ff ff       	call   801003a0 <panic>
80103b7e:	66 90                	xchg   %ax,%ax

80103b80 <cpuid>:
cpuid() {
80103b80:	55                   	push   %ebp
80103b81:	89 e5                	mov    %esp,%ebp
80103b83:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103b86:	e8 75 ff ff ff       	call   80103b00 <mycpu>
}
80103b8b:	c9                   	leave
  return mycpu()-cpus;
80103b8c:	2d a0 27 11 80       	sub    $0x801127a0,%eax
80103b91:	c1 f8 04             	sar    $0x4,%eax
80103b94:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103b9a:	c3                   	ret
80103b9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103ba0 <myproc>:
myproc(void) {
80103ba0:	55                   	push   %ebp
80103ba1:	89 e5                	mov    %esp,%ebp
80103ba3:	53                   	push   %ebx
80103ba4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103ba7:	e8 54 0d 00 00       	call   80104900 <pushcli>
  c = mycpu();
80103bac:	e8 4f ff ff ff       	call   80103b00 <mycpu>
  p = c->proc;
80103bb1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103bb7:	e8 94 0d 00 00       	call   80104950 <popcli>
}
80103bbc:	89 d8                	mov    %ebx,%eax
80103bbe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103bc1:	c9                   	leave
80103bc2:	c3                   	ret
80103bc3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103bc8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103bcf:	00 

80103bd0 <userinit>:
{
80103bd0:	55                   	push   %ebp
80103bd1:	89 e5                	mov    %esp,%ebp
80103bd3:	53                   	push   %ebx
80103bd4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103bd7:	e8 e4 fd ff ff       	call   801039c0 <allocproc>
80103bdc:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103bde:	a3 54 4c 11 80       	mov    %eax,0x80114c54
  if((p->pgdir = setupkvm()) == 0)
80103be3:	e8 b8 39 00 00       	call   801075a0 <setupkvm>
80103be8:	89 43 04             	mov    %eax,0x4(%ebx)
80103beb:	85 c0                	test   %eax,%eax
80103bed:	0f 84 bd 00 00 00    	je     80103cb0 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103bf3:	83 ec 04             	sub    $0x4,%esp
80103bf6:	68 2c 00 00 00       	push   $0x2c
80103bfb:	68 60 b4 10 80       	push   $0x8010b460
80103c00:	50                   	push   %eax
80103c01:	e8 4a 36 00 00       	call   80107250 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103c06:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103c09:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103c0f:	6a 4c                	push   $0x4c
80103c11:	6a 00                	push   $0x0
80103c13:	ff 73 18             	push   0x18(%ebx)
80103c16:	e8 65 0f 00 00       	call   80104b80 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103c1b:	8b 43 18             	mov    0x18(%ebx),%eax
80103c1e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103c23:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103c26:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103c2b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103c2f:	8b 43 18             	mov    0x18(%ebx),%eax
80103c32:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103c36:	8b 43 18             	mov    0x18(%ebx),%eax
80103c39:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103c3d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103c41:	8b 43 18             	mov    0x18(%ebx),%eax
80103c44:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103c48:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103c4c:	8b 43 18             	mov    0x18(%ebx),%eax
80103c4f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103c56:	8b 43 18             	mov    0x18(%ebx),%eax
80103c59:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103c60:	8b 43 18             	mov    0x18(%ebx),%eax
80103c63:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103c6a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103c6d:	6a 10                	push   $0x10
80103c6f:	68 86 7b 10 80       	push   $0x80107b86
80103c74:	50                   	push   %eax
80103c75:	e8 d6 10 00 00       	call   80104d50 <safestrcpy>
  p->cwd = namei("/");
80103c7a:	c7 04 24 8f 7b 10 80 	movl   $0x80107b8f,(%esp)
80103c81:	e8 6a e5 ff ff       	call   801021f0 <namei>
80103c86:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103c89:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c90:	e8 cb 0d 00 00       	call   80104a60 <acquire>
  p->state = RUNNABLE;
80103c95:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103c9c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ca3:	e8 58 0d 00 00       	call   80104a00 <release>
}
80103ca8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103cab:	83 c4 10             	add    $0x10,%esp
80103cae:	c9                   	leave
80103caf:	c3                   	ret
    panic("userinit: out of memory?");
80103cb0:	83 ec 0c             	sub    $0xc,%esp
80103cb3:	68 6d 7b 10 80       	push   $0x80107b6d
80103cb8:	e8 e3 c6 ff ff       	call   801003a0 <panic>
80103cbd:	8d 76 00             	lea    0x0(%esi),%esi

80103cc0 <growproc>:
{
80103cc0:	55                   	push   %ebp
80103cc1:	89 e5                	mov    %esp,%ebp
80103cc3:	53                   	push   %ebx
80103cc4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103cc7:	e8 34 0c 00 00       	call   80104900 <pushcli>
  c = mycpu();
80103ccc:	e8 2f fe ff ff       	call   80103b00 <mycpu>
  p = c->proc;
80103cd1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103cd7:	e8 74 0c 00 00       	call   80104950 <popcli>
  if(n > 0){
80103cdc:	8b 55 08             	mov    0x8(%ebp),%edx
  sz = curproc->sz;
80103cdf:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103ce1:	85 d2                	test   %edx,%edx
80103ce3:	7f 1b                	jg     80103d00 <growproc+0x40>
  } else if(n < 0){
80103ce5:	75 39                	jne    80103d20 <growproc+0x60>
  switchuvm(curproc);
80103ce7:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103cea:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103cec:	53                   	push   %ebx
80103ced:	e8 4e 34 00 00       	call   80107140 <switchuvm>
  return 0;
80103cf2:	83 c4 10             	add    $0x10,%esp
80103cf5:	31 c0                	xor    %eax,%eax
}
80103cf7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103cfa:	c9                   	leave
80103cfb:	c3                   	ret
80103cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103d00:	8b 55 08             	mov    0x8(%ebp),%edx
80103d03:	83 ec 04             	sub    $0x4,%esp
80103d06:	01 c2                	add    %eax,%edx
80103d08:	52                   	push   %edx
80103d09:	50                   	push   %eax
80103d0a:	ff 73 04             	push   0x4(%ebx)
80103d0d:	e8 9e 36 00 00       	call   801073b0 <allocuvm>
80103d12:	83 c4 10             	add    $0x10,%esp
80103d15:	85 c0                	test   %eax,%eax
80103d17:	75 ce                	jne    80103ce7 <growproc+0x27>
      return -1;
80103d19:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103d1e:	eb d7                	jmp    80103cf7 <growproc+0x37>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103d20:	8b 55 08             	mov    0x8(%ebp),%edx
80103d23:	83 ec 04             	sub    $0x4,%esp
80103d26:	01 c2                	add    %eax,%edx
80103d28:	52                   	push   %edx
80103d29:	50                   	push   %eax
80103d2a:	ff 73 04             	push   0x4(%ebx)
80103d2d:	e8 be 37 00 00       	call   801074f0 <deallocuvm>
80103d32:	83 c4 10             	add    $0x10,%esp
80103d35:	85 c0                	test   %eax,%eax
80103d37:	75 ae                	jne    80103ce7 <growproc+0x27>
80103d39:	eb de                	jmp    80103d19 <growproc+0x59>
80103d3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103d40 <fork>:
{
80103d40:	55                   	push   %ebp
80103d41:	89 e5                	mov    %esp,%ebp
80103d43:	83 ec 28             	sub    $0x28,%esp
80103d46:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  pushcli();
80103d49:	e8 b2 0b 00 00       	call   80104900 <pushcli>
  c = mycpu();
80103d4e:	e8 ad fd ff ff       	call   80103b00 <mycpu>
  p = c->proc;
80103d53:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d59:	e8 f2 0b 00 00       	call   80104950 <popcli>
  if((np = allocproc()) == 0){
80103d5e:	e8 5d fc ff ff       	call   801039c0 <allocproc>
80103d63:	85 c0                	test   %eax,%eax
80103d65:	0f 84 f6 00 00 00    	je     80103e61 <fork+0x121>
80103d6b:	89 75 f8             	mov    %esi,-0x8(%ebp)
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103d6e:	83 ec 08             	sub    $0x8,%esp
80103d71:	89 c6                	mov    %eax,%esi
80103d73:	ff 33                	push   (%ebx)
80103d75:	ff 73 04             	push   0x4(%ebx)
80103d78:	e8 13 39 00 00       	call   80107690 <copyuvm>
80103d7d:	83 c4 10             	add    $0x10,%esp
80103d80:	89 46 04             	mov    %eax,0x4(%esi)
80103d83:	85 c0                	test   %eax,%eax
80103d85:	0f 84 b7 00 00 00    	je     80103e42 <fork+0x102>
80103d8b:	89 7d fc             	mov    %edi,-0x4(%ebp)
  np->sz = curproc->sz;
80103d8e:	8b 03                	mov    (%ebx),%eax
  *np->tf = *curproc->tf;
80103d90:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80103d93:	8b 56 18             	mov    0x18(%esi),%edx
  np->sz = curproc->sz;
80103d96:	89 06                	mov    %eax,(%esi)
  *np->tf = *curproc->tf;
80103d98:	31 c0                	xor    %eax,%eax
  np->parent = curproc;
80103d9a:	89 5e 14             	mov    %ebx,0x14(%esi)
  *np->tf = *curproc->tf;
80103d9d:	8b 4b 18             	mov    0x18(%ebx),%ecx
80103da0:	8b 7c 01 04          	mov    0x4(%ecx,%eax,1),%edi
80103da4:	8b 1c 01             	mov    (%ecx,%eax,1),%ebx
80103da7:	89 7c 02 04          	mov    %edi,0x4(%edx,%eax,1)
80103dab:	89 1c 02             	mov    %ebx,(%edx,%eax,1)
80103dae:	83 c0 08             	add    $0x8,%eax
80103db1:	83 f8 48             	cmp    $0x48,%eax
80103db4:	72 ea                	jb     80103da0 <fork+0x60>
80103db6:	8b 0c 01             	mov    (%ecx,%eax,1),%ecx
80103db9:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  for(i = 0; i < NOFILE; i++)
80103dbc:	31 ff                	xor    %edi,%edi
  *np->tf = *curproc->tf;
80103dbe:	89 0c 02             	mov    %ecx,(%edx,%eax,1)
  np->tf->eax = 0;
80103dc1:	8b 46 18             	mov    0x18(%esi),%eax
80103dc4:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80103dcb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80103dd0:	8b 44 bb 28          	mov    0x28(%ebx,%edi,4),%eax
80103dd4:	85 c0                	test   %eax,%eax
80103dd6:	74 10                	je     80103de8 <fork+0xa8>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103dd8:	83 ec 0c             	sub    $0xc,%esp
80103ddb:	50                   	push   %eax
80103ddc:	e8 6f d1 ff ff       	call   80100f50 <filedup>
80103de1:	83 c4 10             	add    $0x10,%esp
80103de4:	89 44 be 28          	mov    %eax,0x28(%esi,%edi,4)
  for(i = 0; i < NOFILE; i++)
80103de8:	83 c7 01             	add    $0x1,%edi
80103deb:	83 ff 10             	cmp    $0x10,%edi
80103dee:	75 e0                	jne    80103dd0 <fork+0x90>
  np->cwd = idup(curproc->cwd);
80103df0:	83 ec 0c             	sub    $0xc,%esp
80103df3:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103df6:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103df9:	e8 32 da ff ff       	call   80101830 <idup>
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103dfe:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103e01:	89 46 68             	mov    %eax,0x68(%esi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e04:	8d 46 6c             	lea    0x6c(%esi),%eax
80103e07:	6a 10                	push   $0x10
80103e09:	53                   	push   %ebx
80103e0a:	50                   	push   %eax
80103e0b:	e8 40 0f 00 00       	call   80104d50 <safestrcpy>
  pid = np->pid;
80103e10:	8b 5e 10             	mov    0x10(%esi),%ebx
  acquire(&ptable.lock);
80103e13:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e1a:	e8 41 0c 00 00       	call   80104a60 <acquire>
  np->state = RUNNABLE;
80103e1f:	c7 46 0c 03 00 00 00 	movl   $0x3,0xc(%esi)
  release(&ptable.lock);
80103e26:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e2d:	e8 ce 0b 00 00       	call   80104a00 <release>
  return pid;
80103e32:	8b 75 f8             	mov    -0x8(%ebp),%esi
80103e35:	8b 7d fc             	mov    -0x4(%ebp),%edi
80103e38:	83 c4 10             	add    $0x10,%esp
}
80103e3b:	89 d8                	mov    %ebx,%eax
80103e3d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80103e40:	c9                   	leave
80103e41:	c3                   	ret
    kfree(np->kstack);
80103e42:	83 ec 0c             	sub    $0xc,%esp
80103e45:	ff 76 08             	push   0x8(%esi)
80103e48:	e8 f3 e7 ff ff       	call   80102640 <kfree>
    np->kstack = 0;
80103e4d:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
    return -1;
80103e54:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103e57:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    return -1;
80103e5e:	8b 75 f8             	mov    -0x8(%ebp),%esi
    return -1;
80103e61:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103e66:	eb d3                	jmp    80103e3b <fork+0xfb>
80103e68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103e6f:	00 

80103e70 <scheduler>:
{
80103e70:	55                   	push   %ebp
80103e71:	89 e5                	mov    %esp,%ebp
80103e73:	57                   	push   %edi
80103e74:	56                   	push   %esi
80103e75:	53                   	push   %ebx
80103e76:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103e79:	e8 82 fc ff ff       	call   80103b00 <mycpu>
  c->proc = 0;
80103e7e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103e85:	00 00 00 
  struct cpu *c = mycpu();
80103e88:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103e8a:	8d 78 04             	lea    0x4(%eax),%edi
80103e8d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103e90:	fb                   	sti
    acquire(&ptable.lock);
80103e91:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e94:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
    acquire(&ptable.lock);
80103e99:	68 20 2d 11 80       	push   $0x80112d20
80103e9e:	e8 bd 0b 00 00       	call   80104a60 <acquire>
80103ea3:	83 c4 10             	add    $0x10,%esp
80103ea6:	66 90                	xchg   %ax,%ax
80103ea8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103eaf:	00 
      if(p->state != RUNNABLE)
80103eb0:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103eb4:	75 33                	jne    80103ee9 <scheduler+0x79>
      switchuvm(p);
80103eb6:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103eb9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103ebf:	53                   	push   %ebx
80103ec0:	e8 7b 32 00 00       	call   80107140 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103ec5:	58                   	pop    %eax
80103ec6:	5a                   	pop    %edx
80103ec7:	ff 73 1c             	push   0x1c(%ebx)
80103eca:	57                   	push   %edi
      p->state = RUNNING;
80103ecb:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103ed2:	e8 e4 0e 00 00       	call   80104dbb <swtch>
      switchkvm();
80103ed7:	e8 54 32 00 00       	call   80107130 <switchkvm>
      c->proc = 0;
80103edc:	83 c4 10             	add    $0x10,%esp
80103edf:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103ee6:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ee9:	83 c3 7c             	add    $0x7c,%ebx
80103eec:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103ef2:	75 bc                	jne    80103eb0 <scheduler+0x40>
    release(&ptable.lock);
80103ef4:	83 ec 0c             	sub    $0xc,%esp
80103ef7:	68 20 2d 11 80       	push   $0x80112d20
80103efc:	e8 ff 0a 00 00       	call   80104a00 <release>
    sti();
80103f01:	83 c4 10             	add    $0x10,%esp
80103f04:	eb 8a                	jmp    80103e90 <scheduler+0x20>
80103f06:	66 90                	xchg   %ax,%ax
80103f08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f0f:	00 

80103f10 <sched>:
{
80103f10:	55                   	push   %ebp
80103f11:	89 e5                	mov    %esp,%ebp
80103f13:	56                   	push   %esi
80103f14:	53                   	push   %ebx
  pushcli();
80103f15:	e8 e6 09 00 00       	call   80104900 <pushcli>
  c = mycpu();
80103f1a:	e8 e1 fb ff ff       	call   80103b00 <mycpu>
  p = c->proc;
80103f1f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f25:	e8 26 0a 00 00       	call   80104950 <popcli>
  if(!holding(&ptable.lock))
80103f2a:	83 ec 0c             	sub    $0xc,%esp
80103f2d:	68 20 2d 11 80       	push   $0x80112d20
80103f32:	e8 79 0a 00 00       	call   801049b0 <holding>
80103f37:	83 c4 10             	add    $0x10,%esp
80103f3a:	85 c0                	test   %eax,%eax
80103f3c:	74 4f                	je     80103f8d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103f3e:	e8 bd fb ff ff       	call   80103b00 <mycpu>
80103f43:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103f4a:	75 68                	jne    80103fb4 <sched+0xa4>
  if(p->state == RUNNING)
80103f4c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103f50:	74 55                	je     80103fa7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103f52:	9c                   	pushf
80103f53:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103f54:	f6 c4 02             	test   $0x2,%ah
80103f57:	75 41                	jne    80103f9a <sched+0x8a>
  intena = mycpu()->intena;
80103f59:	e8 a2 fb ff ff       	call   80103b00 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103f5e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103f61:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103f67:	e8 94 fb ff ff       	call   80103b00 <mycpu>
80103f6c:	83 ec 08             	sub    $0x8,%esp
80103f6f:	ff 70 04             	push   0x4(%eax)
80103f72:	53                   	push   %ebx
80103f73:	e8 43 0e 00 00       	call   80104dbb <swtch>
  mycpu()->intena = intena;
80103f78:	e8 83 fb ff ff       	call   80103b00 <mycpu>
}
80103f7d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103f80:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103f86:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103f89:	5b                   	pop    %ebx
80103f8a:	5e                   	pop    %esi
80103f8b:	5d                   	pop    %ebp
80103f8c:	c3                   	ret
    panic("sched ptable.lock");
80103f8d:	83 ec 0c             	sub    $0xc,%esp
80103f90:	68 91 7b 10 80       	push   $0x80107b91
80103f95:	e8 06 c4 ff ff       	call   801003a0 <panic>
    panic("sched interruptible");
80103f9a:	83 ec 0c             	sub    $0xc,%esp
80103f9d:	68 bd 7b 10 80       	push   $0x80107bbd
80103fa2:	e8 f9 c3 ff ff       	call   801003a0 <panic>
    panic("sched running");
80103fa7:	83 ec 0c             	sub    $0xc,%esp
80103faa:	68 af 7b 10 80       	push   $0x80107baf
80103faf:	e8 ec c3 ff ff       	call   801003a0 <panic>
    panic("sched locks");
80103fb4:	83 ec 0c             	sub    $0xc,%esp
80103fb7:	68 a3 7b 10 80       	push   $0x80107ba3
80103fbc:	e8 df c3 ff ff       	call   801003a0 <panic>
80103fc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103fc8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103fcf:	00 

80103fd0 <exit>:
{
80103fd0:	55                   	push   %ebp
80103fd1:	89 e5                	mov    %esp,%ebp
80103fd3:	83 ec 18             	sub    $0x18,%esp
80103fd6:	89 75 f8             	mov    %esi,-0x8(%ebp)
  pushcli();
80103fd9:	e8 22 09 00 00       	call   80104900 <pushcli>
  c = mycpu();
80103fde:	e8 1d fb ff ff       	call   80103b00 <mycpu>
  p = c->proc;
80103fe3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103fe9:	e8 62 09 00 00       	call   80104950 <popcli>
  if(curproc == initproc)
80103fee:	39 35 54 4c 11 80    	cmp    %esi,0x80114c54
80103ff4:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80103ff7:	89 7d fc             	mov    %edi,-0x4(%ebp)
80103ffa:	0f 84 07 01 00 00    	je     80104107 <exit+0x137>
80104000:	8d 5e 28             	lea    0x28(%esi),%ebx
80104003:	8d 7e 68             	lea    0x68(%esi),%edi
80104006:	66 90                	xchg   %ax,%ax
80104008:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010400f:	00 
    if(curproc->ofile[fd]){
80104010:	8b 03                	mov    (%ebx),%eax
80104012:	85 c0                	test   %eax,%eax
80104014:	74 12                	je     80104028 <exit+0x58>
      fileclose(curproc->ofile[fd]);
80104016:	83 ec 0c             	sub    $0xc,%esp
80104019:	50                   	push   %eax
8010401a:	e8 81 cf ff ff       	call   80100fa0 <fileclose>
      curproc->ofile[fd] = 0;
8010401f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104025:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104028:	83 c3 04             	add    $0x4,%ebx
8010402b:	39 df                	cmp    %ebx,%edi
8010402d:	75 e1                	jne    80104010 <exit+0x40>
  begin_op();
8010402f:	e8 0c ef ff ff       	call   80102f40 <begin_op>
  iput(curproc->cwd);
80104034:	83 ec 0c             	sub    $0xc,%esp
80104037:	ff 76 68             	push   0x68(%esi)
8010403a:	e8 51 d9 ff ff       	call   80101990 <iput>
  end_op();
8010403f:	e8 6c ef ff ff       	call   80102fb0 <end_op>
  curproc->cwd = 0;
80104044:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
8010404b:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104052:	e8 09 0a 00 00       	call   80104a60 <acquire>
  wakeup1(curproc->parent);
80104057:	8b 56 14             	mov    0x14(%esi),%edx
8010405a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010405d:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80104062:	eb 16                	jmp    8010407a <exit+0xaa>
80104064:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104068:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010406f:	00 
80104070:	83 c0 7c             	add    $0x7c,%eax
80104073:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104078:	74 1c                	je     80104096 <exit+0xc6>
    if(p->state == SLEEPING && p->chan == chan)
8010407a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010407e:	75 f0                	jne    80104070 <exit+0xa0>
80104080:	3b 50 20             	cmp    0x20(%eax),%edx
80104083:	75 eb                	jne    80104070 <exit+0xa0>
      p->state = RUNNABLE;
80104085:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010408c:	83 c0 7c             	add    $0x7c,%eax
8010408f:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104094:	75 e4                	jne    8010407a <exit+0xaa>
      p->parent = initproc;
80104096:	8b 0d 54 4c 11 80    	mov    0x80114c54,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010409c:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
801040a1:	eb 18                	jmp    801040bb <exit+0xeb>
801040a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801040a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801040af:	00 
801040b0:	83 c2 7c             	add    $0x7c,%edx
801040b3:	81 fa 54 4c 11 80    	cmp    $0x80114c54,%edx
801040b9:	74 33                	je     801040ee <exit+0x11e>
    if(p->parent == curproc){
801040bb:	39 72 14             	cmp    %esi,0x14(%edx)
801040be:	75 f0                	jne    801040b0 <exit+0xe0>
      p->parent = initproc;
801040c0:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
801040c3:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
801040c7:	75 e7                	jne    801040b0 <exit+0xe0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040c9:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
801040ce:	eb 0a                	jmp    801040da <exit+0x10a>
801040d0:	83 c0 7c             	add    $0x7c,%eax
801040d3:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
801040d8:	74 d6                	je     801040b0 <exit+0xe0>
    if(p->state == SLEEPING && p->chan == chan)
801040da:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801040de:	75 f0                	jne    801040d0 <exit+0x100>
801040e0:	3b 48 20             	cmp    0x20(%eax),%ecx
801040e3:	75 eb                	jne    801040d0 <exit+0x100>
      p->state = RUNNABLE;
801040e5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801040ec:	eb e2                	jmp    801040d0 <exit+0x100>
  curproc->state = ZOMBIE;
801040ee:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
801040f5:	e8 16 fe ff ff       	call   80103f10 <sched>
  panic("zombie exit");
801040fa:	83 ec 0c             	sub    $0xc,%esp
801040fd:	68 de 7b 10 80       	push   $0x80107bde
80104102:	e8 99 c2 ff ff       	call   801003a0 <panic>
    panic("init exiting");
80104107:	83 ec 0c             	sub    $0xc,%esp
8010410a:	68 d1 7b 10 80       	push   $0x80107bd1
8010410f:	e8 8c c2 ff ff       	call   801003a0 <panic>
80104114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104118:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010411f:	00 

80104120 <wait>:
{
80104120:	55                   	push   %ebp
80104121:	89 e5                	mov    %esp,%ebp
80104123:	56                   	push   %esi
80104124:	53                   	push   %ebx
  pushcli();
80104125:	e8 d6 07 00 00       	call   80104900 <pushcli>
  c = mycpu();
8010412a:	e8 d1 f9 ff ff       	call   80103b00 <mycpu>
  p = c->proc;
8010412f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104135:	e8 16 08 00 00       	call   80104950 <popcli>
  acquire(&ptable.lock);
8010413a:	83 ec 0c             	sub    $0xc,%esp
8010413d:	68 20 2d 11 80       	push   $0x80112d20
80104142:	e8 19 09 00 00       	call   80104a60 <acquire>
80104147:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010414a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010414c:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80104151:	eb 18                	jmp    8010416b <wait+0x4b>
80104153:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104158:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010415f:	00 
80104160:	83 c3 7c             	add    $0x7c,%ebx
80104163:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80104169:	74 1b                	je     80104186 <wait+0x66>
      if(p->parent != curproc)
8010416b:	39 73 14             	cmp    %esi,0x14(%ebx)
8010416e:	75 f0                	jne    80104160 <wait+0x40>
      if(p->state == ZOMBIE){
80104170:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104174:	74 62                	je     801041d8 <wait+0xb8>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104176:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80104179:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010417e:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80104184:	75 e5                	jne    8010416b <wait+0x4b>
    if(!havekids || curproc->killed){
80104186:	85 c0                	test   %eax,%eax
80104188:	0f 84 a0 00 00 00    	je     8010422e <wait+0x10e>
8010418e:	8b 46 24             	mov    0x24(%esi),%eax
80104191:	85 c0                	test   %eax,%eax
80104193:	0f 85 95 00 00 00    	jne    8010422e <wait+0x10e>
  pushcli();
80104199:	e8 62 07 00 00       	call   80104900 <pushcli>
  c = mycpu();
8010419e:	e8 5d f9 ff ff       	call   80103b00 <mycpu>
  p = c->proc;
801041a3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801041a9:	e8 a2 07 00 00       	call   80104950 <popcli>
  if(p == 0)
801041ae:	85 db                	test   %ebx,%ebx
801041b0:	0f 84 8f 00 00 00    	je     80104245 <wait+0x125>
  p->chan = chan;
801041b6:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
801041b9:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801041c0:	e8 4b fd ff ff       	call   80103f10 <sched>
  p->chan = 0;
801041c5:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    havekids = 0;
801041cc:	e9 79 ff ff ff       	jmp    8010414a <wait+0x2a>
801041d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
801041d8:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
801041db:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801041de:	ff 73 08             	push   0x8(%ebx)
801041e1:	e8 5a e4 ff ff       	call   80102640 <kfree>
        p->kstack = 0;
801041e6:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801041ed:	5a                   	pop    %edx
801041ee:	ff 73 04             	push   0x4(%ebx)
801041f1:	e8 2a 33 00 00       	call   80107520 <freevm>
        p->pid = 0;
801041f6:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801041fd:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104204:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104208:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
8010420f:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104216:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010421d:	e8 de 07 00 00       	call   80104a00 <release>
        return pid;
80104222:	83 c4 10             	add    $0x10,%esp
}
80104225:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104228:	89 f0                	mov    %esi,%eax
8010422a:	5b                   	pop    %ebx
8010422b:	5e                   	pop    %esi
8010422c:	5d                   	pop    %ebp
8010422d:	c3                   	ret
      release(&ptable.lock);
8010422e:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104231:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104236:	68 20 2d 11 80       	push   $0x80112d20
8010423b:	e8 c0 07 00 00       	call   80104a00 <release>
      return -1;
80104240:	83 c4 10             	add    $0x10,%esp
80104243:	eb e0                	jmp    80104225 <wait+0x105>
    panic("sleep");
80104245:	83 ec 0c             	sub    $0xc,%esp
80104248:	68 ea 7b 10 80       	push   $0x80107bea
8010424d:	e8 4e c1 ff ff       	call   801003a0 <panic>
80104252:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104258:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010425f:	00 

80104260 <yield>:
{
80104260:	55                   	push   %ebp
80104261:	89 e5                	mov    %esp,%ebp
80104263:	53                   	push   %ebx
80104264:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104267:	68 20 2d 11 80       	push   $0x80112d20
8010426c:	e8 ef 07 00 00       	call   80104a60 <acquire>
  pushcli();
80104271:	e8 8a 06 00 00       	call   80104900 <pushcli>
  c = mycpu();
80104276:	e8 85 f8 ff ff       	call   80103b00 <mycpu>
  p = c->proc;
8010427b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104281:	e8 ca 06 00 00       	call   80104950 <popcli>
  myproc()->state = RUNNABLE;
80104286:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010428d:	e8 7e fc ff ff       	call   80103f10 <sched>
  release(&ptable.lock);
80104292:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104299:	e8 62 07 00 00       	call   80104a00 <release>
}
8010429e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042a1:	83 c4 10             	add    $0x10,%esp
801042a4:	c9                   	leave
801042a5:	c3                   	ret
801042a6:	66 90                	xchg   %ax,%ax
801042a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801042af:	00 

801042b0 <sleep>:
{
801042b0:	55                   	push   %ebp
801042b1:	89 e5                	mov    %esp,%ebp
801042b3:	57                   	push   %edi
801042b4:	56                   	push   %esi
801042b5:	53                   	push   %ebx
801042b6:	83 ec 0c             	sub    $0xc,%esp
801042b9:	8b 7d 08             	mov    0x8(%ebp),%edi
801042bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
801042bf:	e8 3c 06 00 00       	call   80104900 <pushcli>
  c = mycpu();
801042c4:	e8 37 f8 ff ff       	call   80103b00 <mycpu>
  p = c->proc;
801042c9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801042cf:	e8 7c 06 00 00       	call   80104950 <popcli>
  if(p == 0)
801042d4:	85 db                	test   %ebx,%ebx
801042d6:	0f 84 87 00 00 00    	je     80104363 <sleep+0xb3>
  if(lk == 0)
801042dc:	85 f6                	test   %esi,%esi
801042de:	74 76                	je     80104356 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801042e0:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
801042e6:	74 50                	je     80104338 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
801042e8:	83 ec 0c             	sub    $0xc,%esp
801042eb:	68 20 2d 11 80       	push   $0x80112d20
801042f0:	e8 6b 07 00 00       	call   80104a60 <acquire>
    release(lk);
801042f5:	89 34 24             	mov    %esi,(%esp)
801042f8:	e8 03 07 00 00       	call   80104a00 <release>
  p->chan = chan;
801042fd:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104300:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104307:	e8 04 fc ff ff       	call   80103f10 <sched>
  p->chan = 0;
8010430c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104313:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010431a:	e8 e1 06 00 00       	call   80104a00 <release>
    acquire(lk);
8010431f:	83 c4 10             	add    $0x10,%esp
80104322:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104325:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104328:	5b                   	pop    %ebx
80104329:	5e                   	pop    %esi
8010432a:	5f                   	pop    %edi
8010432b:	5d                   	pop    %ebp
    acquire(lk);
8010432c:	e9 2f 07 00 00       	jmp    80104a60 <acquire>
80104331:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104338:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010433b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104342:	e8 c9 fb ff ff       	call   80103f10 <sched>
  p->chan = 0;
80104347:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010434e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104351:	5b                   	pop    %ebx
80104352:	5e                   	pop    %esi
80104353:	5f                   	pop    %edi
80104354:	5d                   	pop    %ebp
80104355:	c3                   	ret
    panic("sleep without lk");
80104356:	83 ec 0c             	sub    $0xc,%esp
80104359:	68 f0 7b 10 80       	push   $0x80107bf0
8010435e:	e8 3d c0 ff ff       	call   801003a0 <panic>
    panic("sleep");
80104363:	83 ec 0c             	sub    $0xc,%esp
80104366:	68 ea 7b 10 80       	push   $0x80107bea
8010436b:	e8 30 c0 ff ff       	call   801003a0 <panic>

80104370 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104370:	55                   	push   %ebp
80104371:	89 e5                	mov    %esp,%ebp
80104373:	53                   	push   %ebx
80104374:	83 ec 10             	sub    $0x10,%esp
80104377:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010437a:	68 20 2d 11 80       	push   $0x80112d20
8010437f:	e8 dc 06 00 00       	call   80104a60 <acquire>
80104384:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104387:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010438c:	eb 0c                	jmp    8010439a <wakeup+0x2a>
8010438e:	66 90                	xchg   %ax,%ax
80104390:	83 c0 7c             	add    $0x7c,%eax
80104393:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104398:	74 1c                	je     801043b6 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010439a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010439e:	75 f0                	jne    80104390 <wakeup+0x20>
801043a0:	3b 58 20             	cmp    0x20(%eax),%ebx
801043a3:	75 eb                	jne    80104390 <wakeup+0x20>
      p->state = RUNNABLE;
801043a5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801043ac:	83 c0 7c             	add    $0x7c,%eax
801043af:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
801043b4:	75 e4                	jne    8010439a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
801043b6:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
801043bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043c0:	c9                   	leave
  release(&ptable.lock);
801043c1:	e9 3a 06 00 00       	jmp    80104a00 <release>
801043c6:	66 90                	xchg   %ax,%ax
801043c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801043cf:	00 

801043d0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801043d0:	55                   	push   %ebp
801043d1:	89 e5                	mov    %esp,%ebp
801043d3:	53                   	push   %ebx
801043d4:	83 ec 10             	sub    $0x10,%esp
801043d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801043da:	68 20 2d 11 80       	push   $0x80112d20
801043df:	e8 7c 06 00 00       	call   80104a60 <acquire>
801043e4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043e7:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
801043ec:	eb 0c                	jmp    801043fa <kill+0x2a>
801043ee:	66 90                	xchg   %ax,%ax
801043f0:	83 c0 7c             	add    $0x7c,%eax
801043f3:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
801043f8:	74 36                	je     80104430 <kill+0x60>
    if(p->pid == pid){
801043fa:	39 58 10             	cmp    %ebx,0x10(%eax)
801043fd:	75 f1                	jne    801043f0 <kill+0x20>
      p->killed = 1;
801043ff:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104406:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010440a:	75 07                	jne    80104413 <kill+0x43>
        p->state = RUNNABLE;
8010440c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104413:	83 ec 0c             	sub    $0xc,%esp
80104416:	68 20 2d 11 80       	push   $0x80112d20
8010441b:	e8 e0 05 00 00       	call   80104a00 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104420:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104423:	83 c4 10             	add    $0x10,%esp
80104426:	31 c0                	xor    %eax,%eax
}
80104428:	c9                   	leave
80104429:	c3                   	ret
8010442a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104430:	83 ec 0c             	sub    $0xc,%esp
80104433:	68 20 2d 11 80       	push   $0x80112d20
80104438:	e8 c3 05 00 00       	call   80104a00 <release>
}
8010443d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104440:	83 c4 10             	add    $0x10,%esp
80104443:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104448:	c9                   	leave
80104449:	c3                   	ret
8010444a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104450 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104450:	55                   	push   %ebp
80104451:	89 e5                	mov    %esp,%ebp
80104453:	57                   	push   %edi
80104454:	56                   	push   %esi
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104455:	8d 75 c0             	lea    -0x40(%ebp),%esi
{
80104458:	53                   	push   %ebx
80104459:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
8010445e:	83 ec 3c             	sub    $0x3c,%esp
80104461:	eb 20                	jmp    80104483 <procdump+0x33>
80104463:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104468:	83 ec 0c             	sub    $0xc,%esp
8010446b:	68 b8 7d 10 80       	push   $0x80107db8
80104470:	e8 7b c2 ff ff       	call   801006f0 <cprintf>
80104475:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104478:	83 c3 7c             	add    $0x7c,%ebx
8010447b:	81 fb c0 4c 11 80    	cmp    $0x80114cc0,%ebx
80104481:	74 7d                	je     80104500 <procdump+0xb0>
    if(p->state == UNUSED)
80104483:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104486:	85 c0                	test   %eax,%eax
80104488:	74 ee                	je     80104478 <procdump+0x28>
      state = "???";
8010448a:	ba 01 7c 10 80       	mov    $0x80107c01,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010448f:	83 f8 05             	cmp    $0x5,%eax
80104492:	77 07                	ja     8010449b <procdump+0x4b>
80104494:	8b 14 85 c0 81 10 80 	mov    -0x7fef7e40(,%eax,4),%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010449b:	53                   	push   %ebx
8010449c:	52                   	push   %edx
8010449d:	ff 73 a4             	push   -0x5c(%ebx)
801044a0:	68 05 7c 10 80       	push   $0x80107c05
801044a5:	e8 46 c2 ff ff       	call   801006f0 <cprintf>
    if(p->state == SLEEPING){
801044aa:	83 c4 10             	add    $0x10,%esp
801044ad:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801044b1:	75 b5                	jne    80104468 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801044b3:	83 ec 08             	sub    $0x8,%esp
801044b6:	89 f7                	mov    %esi,%edi
801044b8:	56                   	push   %esi
801044b9:	8b 43 b0             	mov    -0x50(%ebx),%eax
801044bc:	8b 40 0c             	mov    0xc(%eax),%eax
801044bf:	83 c0 08             	add    $0x8,%eax
801044c2:	50                   	push   %eax
801044c3:	e8 98 03 00 00       	call   80104860 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
801044c8:	83 c4 10             	add    $0x10,%esp
801044cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801044d0:	8b 07                	mov    (%edi),%eax
801044d2:	85 c0                	test   %eax,%eax
801044d4:	74 92                	je     80104468 <procdump+0x18>
        cprintf(" %p", pc[i]);
801044d6:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801044d9:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
801044dc:	50                   	push   %eax
801044dd:	68 41 79 10 80       	push   $0x80107941
801044e2:	e8 09 c2 ff ff       	call   801006f0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801044e7:	8d 45 e8             	lea    -0x18(%ebp),%eax
801044ea:	83 c4 10             	add    $0x10,%esp
801044ed:	39 c7                	cmp    %eax,%edi
801044ef:	75 df                	jne    801044d0 <procdump+0x80>
801044f1:	e9 72 ff ff ff       	jmp    80104468 <procdump+0x18>
801044f6:	66 90                	xchg   %ax,%ax
801044f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801044ff:	00 
  }
}
80104500:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104503:	5b                   	pop    %ebx
80104504:	5e                   	pop    %esi
80104505:	5f                   	pop    %edi
80104506:	5d                   	pop    %ebp
80104507:	c3                   	ret
80104508:	66 90                	xchg   %ax,%ax
8010450a:	66 90                	xchg   %ax,%ax
8010450c:	66 90                	xchg   %ax,%ax
8010450e:	66 90                	xchg   %ax,%ax
80104510:	66 90                	xchg   %ax,%ax
80104512:	66 90                	xchg   %ax,%ax
80104514:	66 90                	xchg   %ax,%ax
80104516:	66 90                	xchg   %ax,%ax
80104518:	66 90                	xchg   %ax,%ax
8010451a:	66 90                	xchg   %ax,%ax
8010451c:	66 90                	xchg   %ax,%ax
8010451e:	66 90                	xchg   %ax,%ax

80104520 <seminit>:
} semtable;

// Called once from main() at kernel start.
void
seminit(void)
{
80104520:	55                   	push   %ebp
80104521:	89 e5                	mov    %esp,%ebp
80104523:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&semtable.lock, "semtable");
80104526:	68 38 7c 10 80       	push   $0x80107c38
8010452b:	68 60 4c 11 80       	push   $0x80114c60
80104530:	e8 0b 03 00 00       	call   80104840 <initlock>
80104535:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NSEM; i++){
80104538:	31 c0                	xor    %eax,%eax
8010453a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    semtable.sem[i].value = 0;
80104540:	c7 04 c5 94 4c 11 80 	movl   $0x0,-0x7feeb36c(,%eax,8)
80104547:	00 00 00 00 
    semtable.sem[i].inuse = 0;
8010454b:	c7 04 c5 98 4c 11 80 	movl   $0x0,-0x7feeb368(,%eax,8)
80104552:	00 00 00 00 
  for(i = 0; i < NSEM; i++){
80104556:	83 c0 01             	add    $0x1,%eax
80104559:	83 f8 08             	cmp    $0x8,%eax
8010455c:	75 e2                	jne    80104540 <seminit+0x20>
  }
}
8010455e:	c9                   	leave
8010455f:	c3                   	ret

80104560 <semcreate>:

int
semcreate(int id, int value)
{
80104560:	55                   	push   %ebp
80104561:	89 e5                	mov    %esp,%ebp
80104563:	83 ec 08             	sub    $0x8,%esp
  if(id < 0 || id >= NSEM || value < 0)
80104566:	83 7d 08 07          	cmpl   $0x7,0x8(%ebp)
8010456a:	77 44                	ja     801045b0 <semcreate+0x50>
8010456c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010456f:	85 c0                	test   %eax,%eax
80104571:	78 3d                	js     801045b0 <semcreate+0x50>
    return -1;
  acquire(&semtable.lock);
80104573:	83 ec 0c             	sub    $0xc,%esp
80104576:	68 60 4c 11 80       	push   $0x80114c60
8010457b:	e8 e0 04 00 00       	call   80104a60 <acquire>
  semtable.sem[id].value = value;
80104580:	8b 45 08             	mov    0x8(%ebp),%eax
80104583:	8b 55 0c             	mov    0xc(%ebp),%edx
80104586:	83 c0 06             	add    $0x6,%eax
80104589:	89 14 c5 64 4c 11 80 	mov    %edx,-0x7feeb39c(,%eax,8)
  semtable.sem[id].inuse = 1;
80104590:	c7 04 c5 68 4c 11 80 	movl   $0x1,-0x7feeb398(,%eax,8)
80104597:	01 00 00 00 
  release(&semtable.lock);
8010459b:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
801045a2:	e8 59 04 00 00       	call   80104a00 <release>
  return 0;
801045a7:	83 c4 10             	add    $0x10,%esp
801045aa:	31 c0                	xor    %eax,%eax
}
801045ac:	c9                   	leave
801045ad:	c3                   	ret
801045ae:	66 90                	xchg   %ax,%ax
801045b0:	c9                   	leave
    return -1;
801045b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801045b6:	c3                   	ret
801045b7:	90                   	nop
801045b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801045bf:	00 

801045c0 <semwait>:

int
semwait(int id)
{
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	83 ec 08             	sub    $0x8,%esp
801045c6:	89 75 fc             	mov    %esi,-0x4(%ebp)
801045c9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(id < 0 || id >= NSEM)
801045cc:	83 fe 07             	cmp    $0x7,%esi
801045cf:	77 7a                	ja     8010464b <semwait+0x8b>
    return -1;
  acquire(&semtable.lock);
801045d1:	83 ec 0c             	sub    $0xc,%esp
801045d4:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  if(!semtable.sem[id].inuse){
801045d7:	8d 5e 06             	lea    0x6(%esi),%ebx
  acquire(&semtable.lock);
801045da:	68 60 4c 11 80       	push   $0x80114c60
801045df:	e8 7c 04 00 00       	call   80104a60 <acquire>
  if(!semtable.sem[id].inuse){
801045e4:	8b 14 f5 98 4c 11 80 	mov    -0x7feeb368(,%esi,8),%edx
801045eb:	83 c4 10             	add    $0x10,%esp
801045ee:	85 d2                	test   %edx,%edx
801045f0:	74 46                	je     80104638 <semwait+0x78>
    release(&semtable.lock);
    return -1;
  }
  // Re-check the value after every wake-up (several waiters may be woken
  // by one post, only some of them can proceed).
  while(semtable.sem[id].value == 0){
801045f2:	8b 04 dd 64 4c 11 80 	mov    -0x7feeb39c(,%ebx,8),%eax
    if(myproc()->killed){
      release(&semtable.lock);
      return -1;
    }
    sleep(&semtable.sem[id], &semtable.lock);
801045f9:	8d 34 f5 94 4c 11 80 	lea    -0x7feeb36c(,%esi,8),%esi
  while(semtable.sem[id].value == 0){
80104600:	85 c0                	test   %eax,%eax
80104602:	74 28                	je     8010462c <semwait+0x6c>
80104604:	eb 52                	jmp    80104658 <semwait+0x98>
80104606:	66 90                	xchg   %ax,%ax
80104608:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010460f:	00 
    sleep(&semtable.sem[id], &semtable.lock);
80104610:	83 ec 08             	sub    $0x8,%esp
80104613:	68 60 4c 11 80       	push   $0x80114c60
80104618:	56                   	push   %esi
80104619:	e8 92 fc ff ff       	call   801042b0 <sleep>
  while(semtable.sem[id].value == 0){
8010461e:	8b 04 dd 64 4c 11 80 	mov    -0x7feeb39c(,%ebx,8),%eax
80104625:	83 c4 10             	add    $0x10,%esp
80104628:	85 c0                	test   %eax,%eax
8010462a:	75 2c                	jne    80104658 <semwait+0x98>
    if(myproc()->killed){
8010462c:	e8 6f f5 ff ff       	call   80103ba0 <myproc>
80104631:	8b 40 24             	mov    0x24(%eax),%eax
80104634:	85 c0                	test   %eax,%eax
80104636:	74 d8                	je     80104610 <semwait+0x50>
    release(&semtable.lock);
80104638:	83 ec 0c             	sub    $0xc,%esp
8010463b:	68 60 4c 11 80       	push   $0x80114c60
80104640:	e8 bb 03 00 00       	call   80104a00 <release>
    return -1;
80104645:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104648:	83 c4 10             	add    $0x10,%esp
  }
  semtable.sem[id].value--;
  release(&semtable.lock);
  return 0;
}
8010464b:	8b 75 fc             	mov    -0x4(%ebp),%esi
    return -1;
8010464e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104653:	c9                   	leave
80104654:	c3                   	ret
80104655:	8d 76 00             	lea    0x0(%esi),%esi
  semtable.sem[id].value--;
80104658:	83 e8 01             	sub    $0x1,%eax
  release(&semtable.lock);
8010465b:	83 ec 0c             	sub    $0xc,%esp
  semtable.sem[id].value--;
8010465e:	89 04 dd 64 4c 11 80 	mov    %eax,-0x7feeb39c(,%ebx,8)
  release(&semtable.lock);
80104665:	68 60 4c 11 80       	push   $0x80114c60
8010466a:	e8 91 03 00 00       	call   80104a00 <release>
  return 0;
8010466f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
}
80104672:	8b 75 fc             	mov    -0x4(%ebp),%esi
  return 0;
80104675:	83 c4 10             	add    $0x10,%esp
}
80104678:	c9                   	leave
  return 0;
80104679:	31 c0                	xor    %eax,%eax
}
8010467b:	c3                   	ret
8010467c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104680 <sempost>:

int
sempost(int id)
{
80104680:	55                   	push   %ebp
80104681:	89 e5                	mov    %esp,%ebp
80104683:	53                   	push   %ebx
80104684:	83 ec 04             	sub    $0x4,%esp
80104687:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(id < 0 || id >= NSEM)
8010468a:	83 fb 07             	cmp    $0x7,%ebx
8010468d:	77 61                	ja     801046f0 <sempost+0x70>
    return -1;
  acquire(&semtable.lock);
8010468f:	83 ec 0c             	sub    $0xc,%esp
80104692:	68 60 4c 11 80       	push   $0x80114c60
80104697:	e8 c4 03 00 00       	call   80104a60 <acquire>
  if(!semtable.sem[id].inuse){
8010469c:	8b 14 dd 98 4c 11 80 	mov    -0x7feeb368(,%ebx,8),%edx
801046a3:	8d 43 06             	lea    0x6(%ebx),%eax
801046a6:	83 c4 10             	add    $0x10,%esp
801046a9:	85 d2                	test   %edx,%edx
801046ab:	74 33                	je     801046e0 <sempost+0x60>
    release(&semtable.lock);
    return -1;
  }
  semtable.sem[id].value++;
  wakeup(&semtable.sem[id]);
801046ad:	83 ec 0c             	sub    $0xc,%esp
  semtable.sem[id].value++;
801046b0:	83 04 c5 64 4c 11 80 	addl   $0x1,-0x7feeb39c(,%eax,8)
801046b7:	01 
  wakeup(&semtable.sem[id]);
801046b8:	8d 04 dd 94 4c 11 80 	lea    -0x7feeb36c(,%ebx,8),%eax
801046bf:	50                   	push   %eax
801046c0:	e8 ab fc ff ff       	call   80104370 <wakeup>
  release(&semtable.lock);
801046c5:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
801046cc:	e8 2f 03 00 00       	call   80104a00 <release>
  return 0;
801046d1:	83 c4 10             	add    $0x10,%esp
801046d4:	31 c0                	xor    %eax,%eax
}
801046d6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046d9:	c9                   	leave
801046da:	c3                   	ret
801046db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    release(&semtable.lock);
801046e0:	83 ec 0c             	sub    $0xc,%esp
801046e3:	68 60 4c 11 80       	push   $0x80114c60
801046e8:	e8 13 03 00 00       	call   80104a00 <release>
    return -1;
801046ed:	83 c4 10             	add    $0x10,%esp
    return -1;
801046f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801046f5:	eb df                	jmp    801046d6 <sempost+0x56>
801046f7:	66 90                	xchg   %ax,%ax
801046f9:	66 90                	xchg   %ax,%ax
801046fb:	66 90                	xchg   %ax,%ax
801046fd:	66 90                	xchg   %ax,%ax
801046ff:	90                   	nop

80104700 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104700:	55                   	push   %ebp
80104701:	89 e5                	mov    %esp,%ebp
80104703:	53                   	push   %ebx
80104704:	83 ec 0c             	sub    $0xc,%esp
80104707:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010470a:	68 41 7c 10 80       	push   $0x80107c41
8010470f:	8d 43 04             	lea    0x4(%ebx),%eax
80104712:	50                   	push   %eax
80104713:	e8 28 01 00 00       	call   80104840 <initlock>
  lk->name = name;
80104718:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010471b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104721:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104724:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010472b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010472e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104731:	c9                   	leave
80104732:	c3                   	ret
80104733:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104738:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010473f:	00 

80104740 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	56                   	push   %esi
80104744:	53                   	push   %ebx
80104745:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104748:	8d 73 04             	lea    0x4(%ebx),%esi
8010474b:	83 ec 0c             	sub    $0xc,%esp
8010474e:	56                   	push   %esi
8010474f:	e8 0c 03 00 00       	call   80104a60 <acquire>
  while (lk->locked) {
80104754:	8b 13                	mov    (%ebx),%edx
80104756:	83 c4 10             	add    $0x10,%esp
80104759:	85 d2                	test   %edx,%edx
8010475b:	74 16                	je     80104773 <acquiresleep+0x33>
8010475d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104760:	83 ec 08             	sub    $0x8,%esp
80104763:	56                   	push   %esi
80104764:	53                   	push   %ebx
80104765:	e8 46 fb ff ff       	call   801042b0 <sleep>
  while (lk->locked) {
8010476a:	8b 03                	mov    (%ebx),%eax
8010476c:	83 c4 10             	add    $0x10,%esp
8010476f:	85 c0                	test   %eax,%eax
80104771:	75 ed                	jne    80104760 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104773:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104779:	e8 22 f4 ff ff       	call   80103ba0 <myproc>
8010477e:	8b 40 10             	mov    0x10(%eax),%eax
80104781:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104784:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104787:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010478a:	5b                   	pop    %ebx
8010478b:	5e                   	pop    %esi
8010478c:	5d                   	pop    %ebp
  release(&lk->lk);
8010478d:	e9 6e 02 00 00       	jmp    80104a00 <release>
80104792:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104798:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010479f:	00 

801047a0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	56                   	push   %esi
801047a4:	53                   	push   %ebx
801047a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801047a8:	8d 73 04             	lea    0x4(%ebx),%esi
801047ab:	83 ec 0c             	sub    $0xc,%esp
801047ae:	56                   	push   %esi
801047af:	e8 ac 02 00 00       	call   80104a60 <acquire>
  lk->locked = 0;
801047b4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801047ba:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801047c1:	89 1c 24             	mov    %ebx,(%esp)
801047c4:	e8 a7 fb ff ff       	call   80104370 <wakeup>
  release(&lk->lk);
801047c9:	83 c4 10             	add    $0x10,%esp
801047cc:	89 75 08             	mov    %esi,0x8(%ebp)
}
801047cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801047d2:	5b                   	pop    %ebx
801047d3:	5e                   	pop    %esi
801047d4:	5d                   	pop    %ebp
  release(&lk->lk);
801047d5:	e9 26 02 00 00       	jmp    80104a00 <release>
801047da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801047e0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	57                   	push   %edi
801047e4:	31 ff                	xor    %edi,%edi
801047e6:	56                   	push   %esi
801047e7:	53                   	push   %ebx
801047e8:	83 ec 18             	sub    $0x18,%esp
801047eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801047ee:	8d 73 04             	lea    0x4(%ebx),%esi
801047f1:	56                   	push   %esi
801047f2:	e8 69 02 00 00       	call   80104a60 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801047f7:	8b 03                	mov    (%ebx),%eax
801047f9:	83 c4 10             	add    $0x10,%esp
801047fc:	85 c0                	test   %eax,%eax
801047fe:	75 18                	jne    80104818 <holdingsleep+0x38>
  release(&lk->lk);
80104800:	83 ec 0c             	sub    $0xc,%esp
80104803:	56                   	push   %esi
80104804:	e8 f7 01 00 00       	call   80104a00 <release>
  return r;
}
80104809:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010480c:	89 f8                	mov    %edi,%eax
8010480e:	5b                   	pop    %ebx
8010480f:	5e                   	pop    %esi
80104810:	5f                   	pop    %edi
80104811:	5d                   	pop    %ebp
80104812:	c3                   	ret
80104813:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
80104818:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
8010481b:	e8 80 f3 ff ff       	call   80103ba0 <myproc>
80104820:	39 58 10             	cmp    %ebx,0x10(%eax)
80104823:	0f 94 c0             	sete   %al
80104826:	0f b6 c0             	movzbl %al,%eax
80104829:	89 c7                	mov    %eax,%edi
8010482b:	eb d3                	jmp    80104800 <holdingsleep+0x20>
8010482d:	66 90                	xchg   %ax,%ax
8010482f:	66 90                	xchg   %ax,%ax
80104831:	66 90                	xchg   %ax,%ax
80104833:	66 90                	xchg   %ax,%ax
80104835:	66 90                	xchg   %ax,%ax
80104837:	66 90                	xchg   %ax,%ax
80104839:	66 90                	xchg   %ax,%ax
8010483b:	66 90                	xchg   %ax,%ax
8010483d:	66 90                	xchg   %ax,%ax
8010483f:	90                   	nop

80104840 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104840:	55                   	push   %ebp
80104841:	89 e5                	mov    %esp,%ebp
80104843:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104846:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104849:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010484f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104852:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104859:	5d                   	pop    %ebp
8010485a:	c3                   	ret
8010485b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104860 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104860:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104861:	31 d2                	xor    %edx,%edx
{
80104863:	89 e5                	mov    %esp,%ebp
80104865:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104866:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104869:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010486c:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
8010486f:	90                   	nop
80104870:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104877:	00 
80104878:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010487f:	00 
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104880:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104886:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010488c:	77 1a                	ja     801048a8 <getcallerpcs+0x48>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010488e:	8b 58 04             	mov    0x4(%eax),%ebx
80104891:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104894:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104897:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104899:	83 fa 0a             	cmp    $0xa,%edx
8010489c:	75 e2                	jne    80104880 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010489e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048a1:	c9                   	leave
801048a2:	c3                   	ret
801048a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
801048a8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801048ab:	83 c1 28             	add    $0x28,%ecx
801048ae:	89 ca                	mov    %ecx,%edx
801048b0:	29 c2                	sub    %eax,%edx
801048b2:	83 e2 04             	and    $0x4,%edx
801048b5:	74 29                	je     801048e0 <getcallerpcs+0x80>
    pcs[i] = 0;
801048b7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801048bd:	83 c0 04             	add    $0x4,%eax
801048c0:	39 c8                	cmp    %ecx,%eax
801048c2:	74 da                	je     8010489e <getcallerpcs+0x3e>
801048c4:	eb 1a                	jmp    801048e0 <getcallerpcs+0x80>
801048c6:	66 90                	xchg   %ax,%ax
801048c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801048cf:	00 
801048d0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801048d7:	00 
801048d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801048df:	00 
    pcs[i] = 0;
801048e0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801048e6:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
801048e9:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
801048f0:	39 c8                	cmp    %ecx,%eax
801048f2:	75 ec                	jne    801048e0 <getcallerpcs+0x80>
801048f4:	eb a8                	jmp    8010489e <getcallerpcs+0x3e>
801048f6:	66 90                	xchg   %ax,%ax
801048f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801048ff:	00 

80104900 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	53                   	push   %ebx
80104904:	83 ec 04             	sub    $0x4,%esp
80104907:	9c                   	pushf
80104908:	5b                   	pop    %ebx
  asm volatile("cli");
80104909:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010490a:	e8 f1 f1 ff ff       	call   80103b00 <mycpu>
8010490f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104915:	85 c0                	test   %eax,%eax
80104917:	74 17                	je     80104930 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104919:	e8 e2 f1 ff ff       	call   80103b00 <mycpu>
8010491e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104925:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104928:	c9                   	leave
80104929:	c3                   	ret
8010492a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104930:	e8 cb f1 ff ff       	call   80103b00 <mycpu>
80104935:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010493b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104941:	eb d6                	jmp    80104919 <pushcli+0x19>
80104943:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104948:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010494f:	00 

80104950 <popcli>:

void
popcli(void)
{
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104956:	9c                   	pushf
80104957:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104958:	f6 c4 02             	test   $0x2,%ah
8010495b:	75 35                	jne    80104992 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010495d:	e8 9e f1 ff ff       	call   80103b00 <mycpu>
80104962:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104969:	78 34                	js     8010499f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010496b:	e8 90 f1 ff ff       	call   80103b00 <mycpu>
80104970:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104976:	85 d2                	test   %edx,%edx
80104978:	74 06                	je     80104980 <popcli+0x30>
    sti();
}
8010497a:	c9                   	leave
8010497b:	c3                   	ret
8010497c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104980:	e8 7b f1 ff ff       	call   80103b00 <mycpu>
80104985:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010498b:	85 c0                	test   %eax,%eax
8010498d:	74 eb                	je     8010497a <popcli+0x2a>
  asm volatile("sti");
8010498f:	fb                   	sti
}
80104990:	c9                   	leave
80104991:	c3                   	ret
    panic("popcli - interruptible");
80104992:	83 ec 0c             	sub    $0xc,%esp
80104995:	68 4c 7c 10 80       	push   $0x80107c4c
8010499a:	e8 01 ba ff ff       	call   801003a0 <panic>
    panic("popcli");
8010499f:	83 ec 0c             	sub    $0xc,%esp
801049a2:	68 63 7c 10 80       	push   $0x80107c63
801049a7:	e8 f4 b9 ff ff       	call   801003a0 <panic>
801049ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801049b0 <holding>:
{
801049b0:	55                   	push   %ebp
801049b1:	89 e5                	mov    %esp,%ebp
801049b3:	53                   	push   %ebx
801049b4:	31 db                	xor    %ebx,%ebx
801049b6:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801049b9:	e8 42 ff ff ff       	call   80104900 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801049be:	8b 45 08             	mov    0x8(%ebp),%eax
801049c1:	8b 10                	mov    (%eax),%edx
801049c3:	85 d2                	test   %edx,%edx
801049c5:	75 11                	jne    801049d8 <holding+0x28>
  popcli();
801049c7:	e8 84 ff ff ff       	call   80104950 <popcli>
}
801049cc:	89 d8                	mov    %ebx,%eax
801049ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049d1:	c9                   	leave
801049d2:	c3                   	ret
801049d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lock->locked && lock->cpu == mycpu();
801049d8:	8b 58 08             	mov    0x8(%eax),%ebx
801049db:	e8 20 f1 ff ff       	call   80103b00 <mycpu>
801049e0:	39 c3                	cmp    %eax,%ebx
801049e2:	0f 94 c3             	sete   %bl
  popcli();
801049e5:	e8 66 ff ff ff       	call   80104950 <popcli>
  r = lock->locked && lock->cpu == mycpu();
801049ea:	0f b6 db             	movzbl %bl,%ebx
}
801049ed:	89 d8                	mov    %ebx,%eax
801049ef:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049f2:	c9                   	leave
801049f3:	c3                   	ret
801049f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801049ff:	00 

80104a00 <release>:
{
80104a00:	55                   	push   %ebp
80104a01:	89 e5                	mov    %esp,%ebp
80104a03:	56                   	push   %esi
80104a04:	53                   	push   %ebx
80104a05:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104a08:	e8 f3 fe ff ff       	call   80104900 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104a0d:	8b 03                	mov    (%ebx),%eax
80104a0f:	85 c0                	test   %eax,%eax
80104a11:	75 15                	jne    80104a28 <release+0x28>
  popcli();
80104a13:	e8 38 ff ff ff       	call   80104950 <popcli>
    panic("release");
80104a18:	83 ec 0c             	sub    $0xc,%esp
80104a1b:	68 6a 7c 10 80       	push   $0x80107c6a
80104a20:	e8 7b b9 ff ff       	call   801003a0 <panic>
80104a25:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104a28:	8b 73 08             	mov    0x8(%ebx),%esi
80104a2b:	e8 d0 f0 ff ff       	call   80103b00 <mycpu>
80104a30:	39 c6                	cmp    %eax,%esi
80104a32:	75 df                	jne    80104a13 <release+0x13>
  popcli();
80104a34:	e8 17 ff ff ff       	call   80104950 <popcli>
  lk->pcs[0] = 0;
80104a39:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104a40:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104a47:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104a4c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104a52:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a55:	5b                   	pop    %ebx
80104a56:	5e                   	pop    %esi
80104a57:	5d                   	pop    %ebp
  popcli();
80104a58:	e9 f3 fe ff ff       	jmp    80104950 <popcli>
80104a5d:	8d 76 00             	lea    0x0(%esi),%esi

80104a60 <acquire>:
{
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	83 ec 08             	sub    $0x8,%esp
80104a66:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  pushcli(); // disable interrupts to avoid deadlock.
80104a69:	e8 92 fe ff ff       	call   80104900 <pushcli>
  if(holding(lk))
80104a6e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104a71:	e8 8a fe ff ff       	call   80104900 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104a76:	8b 03                	mov    (%ebx),%eax
80104a78:	85 c0                	test   %eax,%eax
80104a7a:	0f 85 c0 00 00 00    	jne    80104b40 <acquire+0xe0>
  popcli();
80104a80:	e8 cb fe ff ff       	call   80104950 <popcli>
  asm volatile("lock; xchgl %0, %1" :
80104a85:	b8 01 00 00 00       	mov    $0x1,%eax
80104a8a:	f0 87 03             	lock xchg %eax,(%ebx)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80104a8d:	8b 55 08             	mov    0x8(%ebp),%edx
  while(xchg(&lk->locked, 1) != 0)
80104a90:	85 c0                	test   %eax,%eax
80104a92:	74 18                	je     80104aac <acquire+0x4c>
80104a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a9f:	00 
  asm volatile("lock; xchgl %0, %1" :
80104aa0:	b8 01 00 00 00       	mov    $0x1,%eax
80104aa5:	f0 87 02             	lock xchg %eax,(%edx)
80104aa8:	85 c0                	test   %eax,%eax
80104aaa:	75 f4                	jne    80104aa0 <acquire+0x40>
  __sync_synchronize();
80104aac:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104ab1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104ab4:	e8 47 f0 ff ff       	call   80103b00 <mycpu>
  ebp = (uint*)v - 2;
80104ab9:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
80104abb:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
80104abe:	31 c0                	xor    %eax,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104ac0:	8d 8a 00 00 00 80    	lea    -0x80000000(%edx),%ecx
80104ac6:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104acc:	77 1a                	ja     80104ae8 <acquire+0x88>
    pcs[i] = ebp[1];     // saved %eip
80104ace:	8b 4a 04             	mov    0x4(%edx),%ecx
80104ad1:	89 4c 83 0c          	mov    %ecx,0xc(%ebx,%eax,4)
  for(i = 0; i < 10; i++){
80104ad5:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104ad8:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104ada:	83 f8 0a             	cmp    $0xa,%eax
80104add:	75 e1                	jne    80104ac0 <acquire+0x60>
}
80104adf:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104ae2:	c9                   	leave
80104ae3:	c3                   	ret
80104ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104ae8:	8d 44 83 0c          	lea    0xc(%ebx,%eax,4),%eax
80104aec:	83 c3 34             	add    $0x34,%ebx
80104aef:	89 da                	mov    %ebx,%edx
80104af1:	29 c2                	sub    %eax,%edx
80104af3:	83 e2 04             	and    $0x4,%edx
80104af6:	74 28                	je     80104b20 <acquire+0xc0>
    pcs[i] = 0;
80104af8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104afe:	83 c0 04             	add    $0x4,%eax
80104b01:	39 d8                	cmp    %ebx,%eax
80104b03:	74 da                	je     80104adf <acquire+0x7f>
80104b05:	eb 19                	jmp    80104b20 <acquire+0xc0>
80104b07:	90                   	nop
80104b08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b0f:	00 
80104b10:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b17:	00 
80104b18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b1f:	00 
    pcs[i] = 0;
80104b20:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104b26:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80104b29:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80104b30:	39 d8                	cmp    %ebx,%eax
80104b32:	75 ec                	jne    80104b20 <acquire+0xc0>
80104b34:	eb a9                	jmp    80104adf <acquire+0x7f>
80104b36:	66 90                	xchg   %ax,%ax
80104b38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b3f:	00 
80104b40:	89 75 fc             	mov    %esi,-0x4(%ebp)
  r = lock->locked && lock->cpu == mycpu();
80104b43:	8b 73 08             	mov    0x8(%ebx),%esi
80104b46:	e8 b5 ef ff ff       	call   80103b00 <mycpu>
80104b4b:	39 c6                	cmp    %eax,%esi
80104b4d:	74 11                	je     80104b60 <acquire+0x100>
80104b4f:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104b52:	e9 29 ff ff ff       	jmp    80104a80 <acquire+0x20>
80104b57:	90                   	nop
80104b58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b5f:	00 
  popcli();
80104b60:	e8 eb fd ff ff       	call   80104950 <popcli>
    panic("acquire");
80104b65:	83 ec 0c             	sub    $0xc,%esp
80104b68:	68 72 7c 10 80       	push   $0x80107c72
80104b6d:	e8 2e b8 ff ff       	call   801003a0 <panic>
80104b72:	66 90                	xchg   %ax,%ax
80104b74:	66 90                	xchg   %ax,%ax
80104b76:	66 90                	xchg   %ax,%ax
80104b78:	66 90                	xchg   %ax,%ax
80104b7a:	66 90                	xchg   %ax,%ax
80104b7c:	66 90                	xchg   %ax,%ax
80104b7e:	66 90                	xchg   %ax,%ax

80104b80 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104b80:	55                   	push   %ebp
80104b81:	89 e5                	mov    %esp,%ebp
80104b83:	57                   	push   %edi
80104b84:	8b 55 08             	mov    0x8(%ebp),%edx
80104b87:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104b8a:	89 d0                	mov    %edx,%eax
80104b8c:	09 c8                	or     %ecx,%eax
80104b8e:	a8 03                	test   $0x3,%al
80104b90:	75 1e                	jne    80104bb0 <memset+0x30>
    c &= 0xFF;
80104b92:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104b96:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
80104b99:	89 d7                	mov    %edx,%edi
80104b9b:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
80104ba1:	fc                   	cld
80104ba2:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104ba4:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104ba7:	89 d0                	mov    %edx,%eax
80104ba9:	c9                   	leave
80104baa:	c3                   	ret
80104bab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80104bb0:	8b 45 0c             	mov    0xc(%ebp),%eax
80104bb3:	89 d7                	mov    %edx,%edi
80104bb5:	fc                   	cld
80104bb6:	f3 aa                	rep stos %al,%es:(%edi)
80104bb8:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104bbb:	89 d0                	mov    %edx,%eax
80104bbd:	c9                   	leave
80104bbe:	c3                   	ret
80104bbf:	90                   	nop

80104bc0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104bc0:	55                   	push   %ebp
80104bc1:	89 e5                	mov    %esp,%ebp
80104bc3:	83 ec 08             	sub    $0x8,%esp
80104bc6:	8b 45 08             	mov    0x8(%ebp),%eax
80104bc9:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104bcc:	89 75 fc             	mov    %esi,-0x4(%ebp)
80104bcf:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104bd2:	8d 34 08             	lea    (%eax,%ecx,1),%esi
80104bd5:	85 c9                	test   %ecx,%ecx
80104bd7:	74 32                	je     80104c0b <memcmp+0x4b>
80104bd9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104bdc:	eb 0c                	jmp    80104bea <memcmp+0x2a>
80104bde:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104be0:	83 c0 01             	add    $0x1,%eax
80104be3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104be6:	39 f0                	cmp    %esi,%eax
80104be8:	74 1e                	je     80104c08 <memcmp+0x48>
    if(*s1 != *s2)
80104bea:	0f b6 08             	movzbl (%eax),%ecx
80104bed:	0f b6 1a             	movzbl (%edx),%ebx
80104bf0:	38 d9                	cmp    %bl,%cl
80104bf2:	74 ec                	je     80104be0 <memcmp+0x20>
      return *s1 - *s2;
80104bf4:	0f b6 c1             	movzbl %cl,%eax
  }

  return 0;
}
80104bf7:	8b 75 fc             	mov    -0x4(%ebp),%esi
      return *s1 - *s2;
80104bfa:	29 d8                	sub    %ebx,%eax
80104bfc:	8b 5d f8             	mov    -0x8(%ebp),%ebx
}
80104bff:	c9                   	leave
80104c00:	c3                   	ret
80104c01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c08:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104c0b:	8b 75 fc             	mov    -0x4(%ebp),%esi
  return 0;
80104c0e:	31 c0                	xor    %eax,%eax
}
80104c10:	c9                   	leave
80104c11:	c3                   	ret
80104c12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c1f:	00 

80104c20 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104c20:	55                   	push   %ebp
80104c21:	89 e5                	mov    %esp,%ebp
80104c23:	57                   	push   %edi
80104c24:	8b 55 08             	mov    0x8(%ebp),%edx
80104c27:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104c2a:	56                   	push   %esi
80104c2b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104c2e:	39 d6                	cmp    %edx,%esi
80104c30:	73 36                	jae    80104c68 <memmove+0x48>
80104c32:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104c35:	39 fa                	cmp    %edi,%edx
80104c37:	73 2f                	jae    80104c68 <memmove+0x48>
    s += n;
    d += n;
    while(n-- > 0)
80104c39:	85 c9                	test   %ecx,%ecx
80104c3b:	74 1f                	je     80104c5c <memmove+0x3c>
      *--d = *--s;
80104c3d:	29 cf                	sub    %ecx,%edi
    while(n-- > 0)
80104c3f:	8d 41 ff             	lea    -0x1(%ecx),%eax
      *--d = *--s;
80104c42:	89 fe                	mov    %edi,%esi
80104c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c4f:	00 
80104c50:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104c54:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104c57:	83 e8 01             	sub    $0x1,%eax
80104c5a:	73 f4                	jae    80104c50 <memmove+0x30>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104c5c:	5e                   	pop    %esi
80104c5d:	89 d0                	mov    %edx,%eax
80104c5f:	5f                   	pop    %edi
80104c60:	5d                   	pop    %ebp
80104c61:	c3                   	ret
80104c62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104c68:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80104c6b:	89 d7                	mov    %edx,%edi
80104c6d:	85 c9                	test   %ecx,%ecx
80104c6f:	74 eb                	je     80104c5c <memmove+0x3c>
80104c71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c7f:	00 
      *d++ = *s++;
80104c80:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104c81:	39 f0                	cmp    %esi,%eax
80104c83:	75 fb                	jne    80104c80 <memmove+0x60>
}
80104c85:	5e                   	pop    %esi
80104c86:	89 d0                	mov    %edx,%eax
80104c88:	5f                   	pop    %edi
80104c89:	5d                   	pop    %ebp
80104c8a:	c3                   	ret
80104c8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104c90 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104c90:	eb 8e                	jmp    80104c20 <memmove>
80104c92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c9f:	00 

80104ca0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104ca0:	55                   	push   %ebp
80104ca1:	89 e5                	mov    %esp,%ebp
80104ca3:	53                   	push   %ebx
80104ca4:	8b 55 10             	mov    0x10(%ebp),%edx
80104ca7:	8b 45 08             	mov    0x8(%ebp),%eax
80104caa:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
80104cad:	85 d2                	test   %edx,%edx
80104caf:	75 16                	jne    80104cc7 <strncmp+0x27>
80104cb1:	eb 2d                	jmp    80104ce0 <strncmp+0x40>
80104cb3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104cb8:	3a 19                	cmp    (%ecx),%bl
80104cba:	75 12                	jne    80104cce <strncmp+0x2e>
    n--, p++, q++;
80104cbc:	83 c0 01             	add    $0x1,%eax
80104cbf:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104cc2:	83 ea 01             	sub    $0x1,%edx
80104cc5:	74 19                	je     80104ce0 <strncmp+0x40>
80104cc7:	0f b6 18             	movzbl (%eax),%ebx
80104cca:	84 db                	test   %bl,%bl
80104ccc:	75 ea                	jne    80104cb8 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104cce:	0f b6 00             	movzbl (%eax),%eax
80104cd1:	0f b6 11             	movzbl (%ecx),%edx
}
80104cd4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104cd7:	c9                   	leave
  return (uchar)*p - (uchar)*q;
80104cd8:	29 d0                	sub    %edx,%eax
}
80104cda:	c3                   	ret
80104cdb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104ce0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80104ce3:	31 c0                	xor    %eax,%eax
}
80104ce5:	c9                   	leave
80104ce6:	c3                   	ret
80104ce7:	90                   	nop
80104ce8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104cef:	00 

80104cf0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104cf0:	55                   	push   %ebp
80104cf1:	89 e5                	mov    %esp,%ebp
80104cf3:	53                   	push   %ebx
80104cf4:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104cf7:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104cfa:	8b 45 08             	mov    0x8(%ebp),%eax
80104cfd:	eb 14                	jmp    80104d13 <strncpy+0x23>
80104cff:	90                   	nop
80104d00:	0f b6 19             	movzbl (%ecx),%ebx
80104d03:	83 c1 01             	add    $0x1,%ecx
80104d06:	83 c0 01             	add    $0x1,%eax
80104d09:	88 58 ff             	mov    %bl,-0x1(%eax)
80104d0c:	84 db                	test   %bl,%bl
80104d0e:	74 10                	je     80104d20 <strncpy+0x30>
80104d10:	83 ea 01             	sub    $0x1,%edx
80104d13:	85 d2                	test   %edx,%edx
80104d15:	7f e9                	jg     80104d00 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
80104d17:	8b 45 08             	mov    0x8(%ebp),%eax
80104d1a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d1d:	c9                   	leave
80104d1e:	c3                   	ret
80104d1f:	90                   	nop
  while(n-- > 0)
80104d20:	8d 4c 10 ff          	lea    -0x1(%eax,%edx,1),%ecx
80104d24:	83 fa 01             	cmp    $0x1,%edx
80104d27:	74 ee                	je     80104d17 <strncpy+0x27>
80104d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104d30:	83 c0 01             	add    $0x1,%eax
80104d33:	89 ca                	mov    %ecx,%edx
80104d35:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
80104d39:	29 c2                	sub    %eax,%edx
80104d3b:	85 d2                	test   %edx,%edx
80104d3d:	7f f1                	jg     80104d30 <strncpy+0x40>
}
80104d3f:	8b 45 08             	mov    0x8(%ebp),%eax
80104d42:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d45:	c9                   	leave
80104d46:	c3                   	ret
80104d47:	90                   	nop
80104d48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d4f:	00 

80104d50 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104d50:	55                   	push   %ebp
80104d51:	89 e5                	mov    %esp,%ebp
80104d53:	53                   	push   %ebx
80104d54:	8b 55 10             	mov    0x10(%ebp),%edx
80104d57:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104d5a:	85 d2                	test   %edx,%edx
80104d5c:	7e 39                	jle    80104d97 <safestrcpy+0x47>
80104d5e:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104d62:	8b 55 08             	mov    0x8(%ebp),%edx
80104d65:	eb 29                	jmp    80104d90 <safestrcpy+0x40>
80104d67:	eb 17                	jmp    80104d80 <safestrcpy+0x30>
80104d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d70:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d77:	00 
80104d78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d7f:	00 
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104d80:	0f b6 08             	movzbl (%eax),%ecx
80104d83:	83 c0 01             	add    $0x1,%eax
80104d86:	83 c2 01             	add    $0x1,%edx
80104d89:	88 4a ff             	mov    %cl,-0x1(%edx)
80104d8c:	84 c9                	test   %cl,%cl
80104d8e:	74 04                	je     80104d94 <safestrcpy+0x44>
80104d90:	39 d8                	cmp    %ebx,%eax
80104d92:	75 ec                	jne    80104d80 <safestrcpy+0x30>
    ;
  *s = 0;
80104d94:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104d97:	8b 45 08             	mov    0x8(%ebp),%eax
80104d9a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d9d:	c9                   	leave
80104d9e:	c3                   	ret
80104d9f:	90                   	nop

80104da0 <strlen>:

int
strlen(const char *s)
{
80104da0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104da1:	31 c0                	xor    %eax,%eax
{
80104da3:	89 e5                	mov    %esp,%ebp
80104da5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104da8:	80 3a 00             	cmpb   $0x0,(%edx)
80104dab:	74 0c                	je     80104db9 <strlen+0x19>
80104dad:	8d 76 00             	lea    0x0(%esi),%esi
80104db0:	83 c0 01             	add    $0x1,%eax
80104db3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104db7:	75 f7                	jne    80104db0 <strlen+0x10>
    ;
  return n;
}
80104db9:	5d                   	pop    %ebp
80104dba:	c3                   	ret

80104dbb <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104dbb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104dbf:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104dc3:	55                   	push   %ebp
  pushl %ebx
80104dc4:	53                   	push   %ebx
  pushl %esi
80104dc5:	56                   	push   %esi
  pushl %edi
80104dc6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104dc7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104dc9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104dcb:	5f                   	pop    %edi
  popl %esi
80104dcc:	5e                   	pop    %esi
  popl %ebx
80104dcd:	5b                   	pop    %ebx
  popl %ebp
80104dce:	5d                   	pop    %ebp
  ret
80104dcf:	c3                   	ret

80104dd0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104dd0:	55                   	push   %ebp
80104dd1:	89 e5                	mov    %esp,%ebp
80104dd3:	53                   	push   %ebx
80104dd4:	83 ec 04             	sub    $0x4,%esp
80104dd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104dda:	e8 c1 ed ff ff       	call   80103ba0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104ddf:	8b 00                	mov    (%eax),%eax
80104de1:	39 c3                	cmp    %eax,%ebx
80104de3:	73 1b                	jae    80104e00 <fetchint+0x30>
80104de5:	8d 53 04             	lea    0x4(%ebx),%edx
80104de8:	39 d0                	cmp    %edx,%eax
80104dea:	72 14                	jb     80104e00 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104dec:	8b 45 0c             	mov    0xc(%ebp),%eax
80104def:	8b 13                	mov    (%ebx),%edx
80104df1:	89 10                	mov    %edx,(%eax)
  return 0;
80104df3:	31 c0                	xor    %eax,%eax
}
80104df5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104df8:	c9                   	leave
80104df9:	c3                   	ret
80104dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104e00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e05:	eb ee                	jmp    80104df5 <fetchint+0x25>
80104e07:	90                   	nop
80104e08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e0f:	00 

80104e10 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104e10:	55                   	push   %ebp
80104e11:	89 e5                	mov    %esp,%ebp
80104e13:	53                   	push   %ebx
80104e14:	83 ec 04             	sub    $0x4,%esp
80104e17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104e1a:	e8 81 ed ff ff       	call   80103ba0 <myproc>

  if(addr >= curproc->sz)
80104e1f:	3b 18                	cmp    (%eax),%ebx
80104e21:	73 35                	jae    80104e58 <fetchstr+0x48>
    return -1;
  *pp = (char*)addr;
80104e23:	8b 55 0c             	mov    0xc(%ebp),%edx
80104e26:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104e28:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104e2a:	39 d3                	cmp    %edx,%ebx
80104e2c:	73 2a                	jae    80104e58 <fetchstr+0x48>
80104e2e:	89 d8                	mov    %ebx,%eax
80104e30:	eb 15                	jmp    80104e47 <fetchstr+0x37>
80104e32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e3f:	00 
80104e40:	83 c0 01             	add    $0x1,%eax
80104e43:	39 d0                	cmp    %edx,%eax
80104e45:	73 11                	jae    80104e58 <fetchstr+0x48>
    if(*s == 0)
80104e47:	80 38 00             	cmpb   $0x0,(%eax)
80104e4a:	75 f4                	jne    80104e40 <fetchstr+0x30>
      return s - *pp;
80104e4c:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104e4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e51:	c9                   	leave
80104e52:	c3                   	ret
80104e53:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e58:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80104e5b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e60:	c9                   	leave
80104e61:	c3                   	ret
80104e62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e6f:	00 

80104e70 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104e70:	55                   	push   %ebp
80104e71:	89 e5                	mov    %esp,%ebp
80104e73:	56                   	push   %esi
80104e74:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104e75:	e8 26 ed ff ff       	call   80103ba0 <myproc>
80104e7a:	8b 55 08             	mov    0x8(%ebp),%edx
80104e7d:	8b 40 18             	mov    0x18(%eax),%eax
80104e80:	8b 40 44             	mov    0x44(%eax),%eax
80104e83:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104e86:	e8 15 ed ff ff       	call   80103ba0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104e8b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104e8e:	8b 00                	mov    (%eax),%eax
80104e90:	39 c6                	cmp    %eax,%esi
80104e92:	73 1c                	jae    80104eb0 <argint+0x40>
80104e94:	8d 53 08             	lea    0x8(%ebx),%edx
80104e97:	39 d0                	cmp    %edx,%eax
80104e99:	72 15                	jb     80104eb0 <argint+0x40>
  *ip = *(int*)(addr);
80104e9b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e9e:	8b 53 04             	mov    0x4(%ebx),%edx
80104ea1:	89 10                	mov    %edx,(%eax)
  return 0;
80104ea3:	31 c0                	xor    %eax,%eax
}
80104ea5:	5b                   	pop    %ebx
80104ea6:	5e                   	pop    %esi
80104ea7:	5d                   	pop    %ebp
80104ea8:	c3                   	ret
80104ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104eb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104eb5:	eb ee                	jmp    80104ea5 <argint+0x35>
80104eb7:	90                   	nop
80104eb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104ebf:	00 

80104ec0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104ec0:	55                   	push   %ebp
80104ec1:	89 e5                	mov    %esp,%ebp
80104ec3:	57                   	push   %edi
80104ec4:	56                   	push   %esi
80104ec5:	53                   	push   %ebx
80104ec6:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80104ec9:	e8 d2 ec ff ff       	call   80103ba0 <myproc>
80104ece:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ed0:	e8 cb ec ff ff       	call   80103ba0 <myproc>
80104ed5:	8b 55 08             	mov    0x8(%ebp),%edx
80104ed8:	8b 40 18             	mov    0x18(%eax),%eax
80104edb:	8b 40 44             	mov    0x44(%eax),%eax
80104ede:	8d 3c 90             	lea    (%eax,%edx,4),%edi
  struct proc *curproc = myproc();
80104ee1:	e8 ba ec ff ff       	call   80103ba0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ee6:	8d 5f 04             	lea    0x4(%edi),%ebx
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104ee9:	8b 00                	mov    (%eax),%eax
80104eeb:	39 c3                	cmp    %eax,%ebx
80104eed:	73 31                	jae    80104f20 <argptr+0x60>
80104eef:	8d 57 08             	lea    0x8(%edi),%edx
80104ef2:	39 d0                	cmp    %edx,%eax
80104ef4:	72 2a                	jb     80104f20 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104ef6:	8b 45 10             	mov    0x10(%ebp),%eax
80104ef9:	85 c0                	test   %eax,%eax
80104efb:	78 23                	js     80104f20 <argptr+0x60>
  *ip = *(int*)(addr);
80104efd:	8b 57 04             	mov    0x4(%edi),%edx
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104f00:	8b 0e                	mov    (%esi),%ecx
80104f02:	39 ca                	cmp    %ecx,%edx
80104f04:	73 1a                	jae    80104f20 <argptr+0x60>
80104f06:	8b 45 10             	mov    0x10(%ebp),%eax
80104f09:	01 d0                	add    %edx,%eax
80104f0b:	39 c1                	cmp    %eax,%ecx
80104f0d:	72 11                	jb     80104f20 <argptr+0x60>
    return -1;
  *pp = (char*)i;
80104f0f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f12:	89 10                	mov    %edx,(%eax)
  return 0;
80104f14:	31 c0                	xor    %eax,%eax
}
80104f16:	83 c4 0c             	add    $0xc,%esp
80104f19:	5b                   	pop    %ebx
80104f1a:	5e                   	pop    %esi
80104f1b:	5f                   	pop    %edi
80104f1c:	5d                   	pop    %ebp
80104f1d:	c3                   	ret
80104f1e:	66 90                	xchg   %ax,%ax
    return -1;
80104f20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f25:	eb ef                	jmp    80104f16 <argptr+0x56>
80104f27:	90                   	nop
80104f28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f2f:	00 

80104f30 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104f30:	55                   	push   %ebp
80104f31:	89 e5                	mov    %esp,%ebp
80104f33:	56                   	push   %esi
80104f34:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104f35:	e8 66 ec ff ff       	call   80103ba0 <myproc>
80104f3a:	8b 55 08             	mov    0x8(%ebp),%edx
80104f3d:	8b 40 18             	mov    0x18(%eax),%eax
80104f40:	8b 40 44             	mov    0x44(%eax),%eax
80104f43:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104f46:	e8 55 ec ff ff       	call   80103ba0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104f4b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104f4e:	8b 00                	mov    (%eax),%eax
80104f50:	39 c6                	cmp    %eax,%esi
80104f52:	73 44                	jae    80104f98 <argstr+0x68>
80104f54:	8d 53 08             	lea    0x8(%ebx),%edx
80104f57:	39 d0                	cmp    %edx,%eax
80104f59:	72 3d                	jb     80104f98 <argstr+0x68>
  *ip = *(int*)(addr);
80104f5b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80104f5e:	e8 3d ec ff ff       	call   80103ba0 <myproc>
  if(addr >= curproc->sz)
80104f63:	3b 18                	cmp    (%eax),%ebx
80104f65:	73 31                	jae    80104f98 <argstr+0x68>
  *pp = (char*)addr;
80104f67:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f6a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104f6c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104f6e:	39 d3                	cmp    %edx,%ebx
80104f70:	73 26                	jae    80104f98 <argstr+0x68>
80104f72:	89 d8                	mov    %ebx,%eax
80104f74:	eb 11                	jmp    80104f87 <argstr+0x57>
80104f76:	66 90                	xchg   %ax,%ax
80104f78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f7f:	00 
80104f80:	83 c0 01             	add    $0x1,%eax
80104f83:	39 d0                	cmp    %edx,%eax
80104f85:	73 11                	jae    80104f98 <argstr+0x68>
    if(*s == 0)
80104f87:	80 38 00             	cmpb   $0x0,(%eax)
80104f8a:	75 f4                	jne    80104f80 <argstr+0x50>
      return s - *pp;
80104f8c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104f8e:	5b                   	pop    %ebx
80104f8f:	5e                   	pop    %esi
80104f90:	5d                   	pop    %ebp
80104f91:	c3                   	ret
80104f92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f98:	5b                   	pop    %ebx
    return -1;
80104f99:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f9e:	5e                   	pop    %esi
80104f9f:	5d                   	pop    %ebp
80104fa0:	c3                   	ret
80104fa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fa8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104faf:	00 

80104fb0 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80104fb0:	55                   	push   %ebp
80104fb1:	89 e5                	mov    %esp,%ebp
80104fb3:	53                   	push   %ebx
80104fb4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104fb7:	e8 e4 eb ff ff       	call   80103ba0 <myproc>
80104fbc:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104fbe:	8b 40 18             	mov    0x18(%eax),%eax
80104fc1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104fc4:	8d 50 ff             	lea    -0x1(%eax),%edx
80104fc7:	83 fa 17             	cmp    $0x17,%edx
80104fca:	77 24                	ja     80104ff0 <syscall+0x40>
80104fcc:	8b 14 85 e0 81 10 80 	mov    -0x7fef7e20(,%eax,4),%edx
80104fd3:	85 d2                	test   %edx,%edx
80104fd5:	74 19                	je     80104ff0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104fd7:	ff d2                	call   *%edx
80104fd9:	89 c2                	mov    %eax,%edx
80104fdb:	8b 43 18             	mov    0x18(%ebx),%eax
80104fde:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104fe1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104fe4:	c9                   	leave
80104fe5:	c3                   	ret
80104fe6:	66 90                	xchg   %ax,%ax
80104fe8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104fef:	00 
    cprintf("%d %s: unknown sys call %d\n",
80104ff0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104ff1:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104ff4:	50                   	push   %eax
80104ff5:	ff 73 10             	push   0x10(%ebx)
80104ff8:	68 7a 7c 10 80       	push   $0x80107c7a
80104ffd:	e8 ee b6 ff ff       	call   801006f0 <cprintf>
    curproc->tf->eax = -1;
80105002:	8b 43 18             	mov    0x18(%ebx),%eax
80105005:	83 c4 10             	add    $0x10,%esp
80105008:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
8010500f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105012:	c9                   	leave
80105013:	c3                   	ret
80105014:	66 90                	xchg   %ax,%ax
80105016:	66 90                	xchg   %ax,%ax
80105018:	66 90                	xchg   %ax,%ax
8010501a:	66 90                	xchg   %ax,%ax
8010501c:	66 90                	xchg   %ax,%ax
8010501e:	66 90                	xchg   %ax,%ax

80105020 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105020:	55                   	push   %ebp
80105021:	89 e5                	mov    %esp,%ebp
80105023:	83 ec 40             	sub    $0x40,%esp
80105026:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105029:	8d 5d da             	lea    -0x26(%ebp),%ebx
8010502c:	53                   	push   %ebx
8010502d:	50                   	push   %eax
{
8010502e:	89 7d fc             	mov    %edi,-0x4(%ebp)
80105031:	66 89 55 d6          	mov    %dx,-0x2a(%ebp)
80105035:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105039:	e8 d2 d1 ff ff       	call   80102210 <nameiparent>
8010503e:	83 c4 10             	add    $0x10,%esp
80105041:	85 c0                	test   %eax,%eax
80105043:	0f 84 47 01 00 00    	je     80105190 <create+0x170>
    return 0;
  ilock(dp);
80105049:	83 ec 0c             	sub    $0xc,%esp
8010504c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010504f:	89 c6                	mov    %eax,%esi
80105051:	50                   	push   %eax
80105052:	e8 09 c8 ff ff       	call   80101860 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80105057:	83 c4 0c             	add    $0xc,%esp
8010505a:	6a 00                	push   $0x0
8010505c:	53                   	push   %ebx
8010505d:	56                   	push   %esi
8010505e:	e8 9d cd ff ff       	call   80101e00 <dirlookup>
80105063:	83 c4 10             	add    $0x10,%esp
80105066:	89 c7                	mov    %eax,%edi
80105068:	85 c0                	test   %eax,%eax
8010506a:	74 54                	je     801050c0 <create+0xa0>
    iunlockput(dp);
8010506c:	83 ec 0c             	sub    $0xc,%esp
8010506f:	56                   	push   %esi
80105070:	e8 9b ca ff ff       	call   80101b10 <iunlockput>
    ilock(ip);
80105075:	89 3c 24             	mov    %edi,(%esp)
80105078:	e8 e3 c7 ff ff       	call   80101860 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010507d:	83 c4 10             	add    $0x10,%esp
80105080:	66 83 7d d6 02       	cmpw   $0x2,-0x2a(%ebp)
80105085:	75 19                	jne    801050a0 <create+0x80>
80105087:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
8010508c:	75 12                	jne    801050a0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010508e:	89 f8                	mov    %edi,%eax
80105090:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105093:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105096:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105099:	c9                   	leave
8010509a:	c3                   	ret
8010509b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
801050a0:	83 ec 0c             	sub    $0xc,%esp
801050a3:	57                   	push   %edi
    return 0;
801050a4:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
801050a6:	e8 65 ca ff ff       	call   80101b10 <iunlockput>
}
801050ab:	89 f8                	mov    %edi,%eax
    return 0;
801050ad:	8b 75 f8             	mov    -0x8(%ebp),%esi
}
801050b0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801050b3:	8b 7d fc             	mov    -0x4(%ebp),%edi
    return 0;
801050b6:	83 c4 10             	add    $0x10,%esp
}
801050b9:	c9                   	leave
801050ba:	c3                   	ret
801050bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  if((ip = ialloc(dp->dev, type)) == 0)
801050c0:	0f bf 45 d6          	movswl -0x2a(%ebp),%eax
801050c4:	83 ec 08             	sub    $0x8,%esp
801050c7:	50                   	push   %eax
801050c8:	ff 36                	push   (%esi)
801050ca:	e8 11 c6 ff ff       	call   801016e0 <ialloc>
801050cf:	83 c4 10             	add    $0x10,%esp
801050d2:	89 c7                	mov    %eax,%edi
801050d4:	85 c0                	test   %eax,%eax
801050d6:	0f 84 cd 00 00 00    	je     801051a9 <create+0x189>
  ilock(ip);
801050dc:	83 ec 0c             	sub    $0xc,%esp
801050df:	50                   	push   %eax
801050e0:	e8 7b c7 ff ff       	call   80101860 <ilock>
  ip->major = major;
801050e5:	0f b7 45 d4          	movzwl -0x2c(%ebp),%eax
801050e9:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
801050ed:	0f b7 45 08          	movzwl 0x8(%ebp),%eax
801050f1:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
801050f5:	b8 01 00 00 00       	mov    $0x1,%eax
801050fa:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
801050fe:	89 3c 24             	mov    %edi,(%esp)
80105101:	e8 9a c6 ff ff       	call   801017a0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105106:	83 c4 10             	add    $0x10,%esp
80105109:	66 83 7d d6 01       	cmpw   $0x1,-0x2a(%ebp)
8010510e:	74 30                	je     80105140 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105110:	83 ec 04             	sub    $0x4,%esp
80105113:	ff 77 04             	push   0x4(%edi)
80105116:	53                   	push   %ebx
80105117:	56                   	push   %esi
80105118:	e8 13 d0 ff ff       	call   80102130 <dirlink>
8010511d:	83 c4 10             	add    $0x10,%esp
80105120:	85 c0                	test   %eax,%eax
80105122:	78 78                	js     8010519c <create+0x17c>
  iunlockput(dp);
80105124:	83 ec 0c             	sub    $0xc,%esp
80105127:	56                   	push   %esi
80105128:	e8 e3 c9 ff ff       	call   80101b10 <iunlockput>
}
8010512d:	89 f8                	mov    %edi,%eax
  return ip;
8010512f:	8b 75 f8             	mov    -0x8(%ebp),%esi
}
80105132:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105135:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return ip;
80105138:	83 c4 10             	add    $0x10,%esp
}
8010513b:	c9                   	leave
8010513c:	c3                   	ret
8010513d:	8d 76 00             	lea    0x0(%esi),%esi
    iupdate(dp);
80105140:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80105143:	66 83 46 56 01       	addw   $0x1,0x56(%esi)
    iupdate(dp);
80105148:	56                   	push   %esi
80105149:	e8 52 c6 ff ff       	call   801017a0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010514e:	83 c4 0c             	add    $0xc,%esp
80105151:	ff 77 04             	push   0x4(%edi)
80105154:	68 b2 7c 10 80       	push   $0x80107cb2
80105159:	57                   	push   %edi
8010515a:	e8 d1 cf ff ff       	call   80102130 <dirlink>
8010515f:	83 c4 10             	add    $0x10,%esp
80105162:	85 c0                	test   %eax,%eax
80105164:	78 18                	js     8010517e <create+0x15e>
80105166:	83 ec 04             	sub    $0x4,%esp
80105169:	ff 76 04             	push   0x4(%esi)
8010516c:	68 b1 7c 10 80       	push   $0x80107cb1
80105171:	57                   	push   %edi
80105172:	e8 b9 cf ff ff       	call   80102130 <dirlink>
80105177:	83 c4 10             	add    $0x10,%esp
8010517a:	85 c0                	test   %eax,%eax
8010517c:	79 92                	jns    80105110 <create+0xf0>
      panic("create dots");
8010517e:	83 ec 0c             	sub    $0xc,%esp
80105181:	68 a5 7c 10 80       	push   $0x80107ca5
80105186:	e8 15 b2 ff ff       	call   801003a0 <panic>
8010518b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return 0;
80105190:	31 ff                	xor    %edi,%edi
}
80105192:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105195:	89 f8                	mov    %edi,%eax
80105197:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010519a:	c9                   	leave
8010519b:	c3                   	ret
    panic("create: dirlink");
8010519c:	83 ec 0c             	sub    $0xc,%esp
8010519f:	68 b4 7c 10 80       	push   $0x80107cb4
801051a4:	e8 f7 b1 ff ff       	call   801003a0 <panic>
    panic("create: ialloc");
801051a9:	83 ec 0c             	sub    $0xc,%esp
801051ac:	68 96 7c 10 80       	push   $0x80107c96
801051b1:	e8 ea b1 ff ff       	call   801003a0 <panic>
801051b6:	66 90                	xchg   %ax,%ax
801051b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801051bf:	00 

801051c0 <sys_dup>:
{
801051c0:	55                   	push   %ebp
801051c1:	89 e5                	mov    %esp,%ebp
801051c3:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
801051c6:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801051c9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  if(argint(n, &fd) < 0)
801051cc:	50                   	push   %eax
801051cd:	6a 00                	push   $0x0
801051cf:	e8 9c fc ff ff       	call   80104e70 <argint>
801051d4:	83 c4 10             	add    $0x10,%esp
801051d7:	85 c0                	test   %eax,%eax
801051d9:	78 38                	js     80105213 <sys_dup+0x53>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801051db:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801051df:	77 32                	ja     80105213 <sys_dup+0x53>
801051e1:	89 75 fc             	mov    %esi,-0x4(%ebp)
801051e4:	e8 b7 e9 ff ff       	call   80103ba0 <myproc>
801051e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801051ec:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801051f0:	85 f6                	test   %esi,%esi
801051f2:	74 1c                	je     80105210 <sys_dup+0x50>
  struct proc *curproc = myproc();
801051f4:	e8 a7 e9 ff ff       	call   80103ba0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801051f9:	31 db                	xor    %ebx,%ebx
801051fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105200:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105204:	85 d2                	test   %edx,%edx
80105206:	74 18                	je     80105220 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80105208:	83 c3 01             	add    $0x1,%ebx
8010520b:	83 fb 10             	cmp    $0x10,%ebx
8010520e:	75 f0                	jne    80105200 <sys_dup+0x40>
80105210:	8b 75 fc             	mov    -0x4(%ebp),%esi
    return -1;
80105213:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105218:	89 d8                	mov    %ebx,%eax
8010521a:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010521d:	c9                   	leave
8010521e:	c3                   	ret
8010521f:	90                   	nop
  filedup(f);
80105220:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105223:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105227:	56                   	push   %esi
80105228:	e8 23 bd ff ff       	call   80100f50 <filedup>
}
8010522d:	89 d8                	mov    %ebx,%eax
  return fd;
8010522f:	8b 75 fc             	mov    -0x4(%ebp),%esi
}
80105232:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  return fd;
80105235:	83 c4 10             	add    $0x10,%esp
}
80105238:	c9                   	leave
80105239:	c3                   	ret
8010523a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105240 <sys_read>:
{
80105240:	55                   	push   %ebp
80105241:	89 e5                	mov    %esp,%ebp
80105243:	83 ec 20             	sub    $0x20,%esp
80105246:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  if(argint(n, &fd) < 0)
80105249:	8d 5d f4             	lea    -0xc(%ebp),%ebx
8010524c:	53                   	push   %ebx
8010524d:	6a 00                	push   $0x0
8010524f:	e8 1c fc ff ff       	call   80104e70 <argint>
80105254:	83 c4 10             	add    $0x10,%esp
80105257:	85 c0                	test   %eax,%eax
80105259:	78 68                	js     801052c3 <sys_read+0x83>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010525b:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010525f:	77 62                	ja     801052c3 <sys_read+0x83>
80105261:	89 75 fc             	mov    %esi,-0x4(%ebp)
80105264:	e8 37 e9 ff ff       	call   80103ba0 <myproc>
80105269:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010526c:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105270:	85 f6                	test   %esi,%esi
80105272:	74 4c                	je     801052c0 <sys_read+0x80>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105274:	83 ec 08             	sub    $0x8,%esp
80105277:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010527a:	50                   	push   %eax
8010527b:	6a 02                	push   $0x2
8010527d:	e8 ee fb ff ff       	call   80104e70 <argint>
80105282:	83 c4 10             	add    $0x10,%esp
80105285:	85 c0                	test   %eax,%eax
80105287:	78 37                	js     801052c0 <sys_read+0x80>
80105289:	83 ec 04             	sub    $0x4,%esp
8010528c:	ff 75 f0             	push   -0x10(%ebp)
8010528f:	53                   	push   %ebx
80105290:	6a 01                	push   $0x1
80105292:	e8 29 fc ff ff       	call   80104ec0 <argptr>
80105297:	83 c4 10             	add    $0x10,%esp
8010529a:	85 c0                	test   %eax,%eax
8010529c:	78 22                	js     801052c0 <sys_read+0x80>
  return fileread(f, p, n);
8010529e:	83 ec 04             	sub    $0x4,%esp
801052a1:	ff 75 f0             	push   -0x10(%ebp)
801052a4:	ff 75 f4             	push   -0xc(%ebp)
801052a7:	56                   	push   %esi
801052a8:	e8 23 be ff ff       	call   801010d0 <fileread>
801052ad:	8b 75 fc             	mov    -0x4(%ebp),%esi
801052b0:	83 c4 10             	add    $0x10,%esp
}
801052b3:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801052b6:	c9                   	leave
801052b7:	c3                   	ret
801052b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801052bf:	00 
801052c0:	8b 75 fc             	mov    -0x4(%ebp),%esi
    return -1;
801052c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052c8:	eb e9                	jmp    801052b3 <sys_read+0x73>
801052ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801052d0 <sys_write>:
{
801052d0:	55                   	push   %ebp
801052d1:	89 e5                	mov    %esp,%ebp
801052d3:	83 ec 20             	sub    $0x20,%esp
801052d6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  if(argint(n, &fd) < 0)
801052d9:	8d 5d f4             	lea    -0xc(%ebp),%ebx
801052dc:	53                   	push   %ebx
801052dd:	6a 00                	push   $0x0
801052df:	e8 8c fb ff ff       	call   80104e70 <argint>
801052e4:	83 c4 10             	add    $0x10,%esp
801052e7:	85 c0                	test   %eax,%eax
801052e9:	78 68                	js     80105353 <sys_write+0x83>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801052eb:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801052ef:	77 62                	ja     80105353 <sys_write+0x83>
801052f1:	89 75 fc             	mov    %esi,-0x4(%ebp)
801052f4:	e8 a7 e8 ff ff       	call   80103ba0 <myproc>
801052f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801052fc:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105300:	85 f6                	test   %esi,%esi
80105302:	74 4c                	je     80105350 <sys_write+0x80>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105304:	83 ec 08             	sub    $0x8,%esp
80105307:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010530a:	50                   	push   %eax
8010530b:	6a 02                	push   $0x2
8010530d:	e8 5e fb ff ff       	call   80104e70 <argint>
80105312:	83 c4 10             	add    $0x10,%esp
80105315:	85 c0                	test   %eax,%eax
80105317:	78 37                	js     80105350 <sys_write+0x80>
80105319:	83 ec 04             	sub    $0x4,%esp
8010531c:	ff 75 f0             	push   -0x10(%ebp)
8010531f:	53                   	push   %ebx
80105320:	6a 01                	push   $0x1
80105322:	e8 99 fb ff ff       	call   80104ec0 <argptr>
80105327:	83 c4 10             	add    $0x10,%esp
8010532a:	85 c0                	test   %eax,%eax
8010532c:	78 22                	js     80105350 <sys_write+0x80>
  return filewrite(f, p, n);
8010532e:	83 ec 04             	sub    $0x4,%esp
80105331:	ff 75 f0             	push   -0x10(%ebp)
80105334:	ff 75 f4             	push   -0xc(%ebp)
80105337:	56                   	push   %esi
80105338:	e8 23 be ff ff       	call   80101160 <filewrite>
8010533d:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105340:	83 c4 10             	add    $0x10,%esp
}
80105343:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105346:	c9                   	leave
80105347:	c3                   	ret
80105348:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010534f:	00 
80105350:	8b 75 fc             	mov    -0x4(%ebp),%esi
    return -1;
80105353:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105358:	eb e9                	jmp    80105343 <sys_write+0x73>
8010535a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105360 <sys_close>:
{
80105360:	55                   	push   %ebp
80105361:	89 e5                	mov    %esp,%ebp
80105363:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
80105366:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105369:	50                   	push   %eax
8010536a:	6a 00                	push   $0x0
8010536c:	e8 ff fa ff ff       	call   80104e70 <argint>
80105371:	83 c4 10             	add    $0x10,%esp
80105374:	85 c0                	test   %eax,%eax
80105376:	78 48                	js     801053c0 <sys_close+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105378:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010537c:	77 42                	ja     801053c0 <sys_close+0x60>
8010537e:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105381:	89 75 fc             	mov    %esi,-0x4(%ebp)
80105384:	e8 17 e8 ff ff       	call   80103ba0 <myproc>
80105389:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010538c:	8d 5a 08             	lea    0x8(%edx),%ebx
8010538f:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
80105393:	85 f6                	test   %esi,%esi
80105395:	74 23                	je     801053ba <sys_close+0x5a>
  myproc()->ofile[fd] = 0;
80105397:	e8 04 e8 ff ff       	call   80103ba0 <myproc>
  fileclose(f);
8010539c:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
8010539f:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
801053a6:	00 
  fileclose(f);
801053a7:	56                   	push   %esi
801053a8:	e8 f3 bb ff ff       	call   80100fa0 <fileclose>
  return 0;
801053ad:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801053b0:	8b 75 fc             	mov    -0x4(%ebp),%esi
801053b3:	83 c4 10             	add    $0x10,%esp
}
801053b6:	c9                   	leave
  return 0;
801053b7:	31 c0                	xor    %eax,%eax
}
801053b9:	c3                   	ret
801053ba:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801053bd:	8b 75 fc             	mov    -0x4(%ebp),%esi
801053c0:	c9                   	leave
    return -1;
801053c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053c6:	c3                   	ret
801053c7:	90                   	nop
801053c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801053cf:	00 

801053d0 <sys_fstat>:
{
801053d0:	55                   	push   %ebp
801053d1:	89 e5                	mov    %esp,%ebp
801053d3:	83 ec 20             	sub    $0x20,%esp
801053d6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  if(argint(n, &fd) < 0)
801053d9:	8d 5d f4             	lea    -0xc(%ebp),%ebx
801053dc:	53                   	push   %ebx
801053dd:	6a 00                	push   $0x0
801053df:	e8 8c fa ff ff       	call   80104e70 <argint>
801053e4:	83 c4 10             	add    $0x10,%esp
801053e7:	85 c0                	test   %eax,%eax
801053e9:	78 48                	js     80105433 <sys_fstat+0x63>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801053eb:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801053ef:	77 42                	ja     80105433 <sys_fstat+0x63>
801053f1:	89 75 fc             	mov    %esi,-0x4(%ebp)
801053f4:	e8 a7 e7 ff ff       	call   80103ba0 <myproc>
801053f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801053fc:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105400:	85 f6                	test   %esi,%esi
80105402:	74 2c                	je     80105430 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105404:	83 ec 04             	sub    $0x4,%esp
80105407:	6a 14                	push   $0x14
80105409:	53                   	push   %ebx
8010540a:	6a 01                	push   $0x1
8010540c:	e8 af fa ff ff       	call   80104ec0 <argptr>
80105411:	83 c4 10             	add    $0x10,%esp
80105414:	85 c0                	test   %eax,%eax
80105416:	78 18                	js     80105430 <sys_fstat+0x60>
  return filestat(f, st);
80105418:	83 ec 08             	sub    $0x8,%esp
8010541b:	ff 75 f4             	push   -0xc(%ebp)
8010541e:	56                   	push   %esi
8010541f:	e8 5c bc ff ff       	call   80101080 <filestat>
80105424:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105427:	83 c4 10             	add    $0x10,%esp
}
8010542a:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010542d:	c9                   	leave
8010542e:	c3                   	ret
8010542f:	90                   	nop
80105430:	8b 75 fc             	mov    -0x4(%ebp),%esi
    return -1;
80105433:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105438:	eb f0                	jmp    8010542a <sys_fstat+0x5a>
8010543a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105440 <sys_link>:
{
80105440:	55                   	push   %ebp
80105441:	89 e5                	mov    %esp,%ebp
80105443:	83 ec 40             	sub    $0x40,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105446:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105449:	50                   	push   %eax
8010544a:	6a 00                	push   $0x0
8010544c:	e8 df fa ff ff       	call   80104f30 <argstr>
80105451:	83 c4 10             	add    $0x10,%esp
80105454:	85 c0                	test   %eax,%eax
80105456:	0f 88 0f 01 00 00    	js     8010556b <sys_link+0x12b>
8010545c:	83 ec 08             	sub    $0x8,%esp
8010545f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105462:	50                   	push   %eax
80105463:	6a 01                	push   $0x1
80105465:	e8 c6 fa ff ff       	call   80104f30 <argstr>
8010546a:	83 c4 10             	add    $0x10,%esp
8010546d:	85 c0                	test   %eax,%eax
8010546f:	0f 88 f6 00 00 00    	js     8010556b <sys_link+0x12b>
80105475:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  begin_op();
80105478:	e8 c3 da ff ff       	call   80102f40 <begin_op>
  if((ip = namei(old)) == 0){
8010547d:	83 ec 0c             	sub    $0xc,%esp
80105480:	ff 75 d4             	push   -0x2c(%ebp)
80105483:	e8 68 cd ff ff       	call   801021f0 <namei>
80105488:	83 c4 10             	add    $0x10,%esp
8010548b:	89 c3                	mov    %eax,%ebx
8010548d:	85 c0                	test   %eax,%eax
8010548f:	0f 84 f3 00 00 00    	je     80105588 <sys_link+0x148>
  ilock(ip);
80105495:	83 ec 0c             	sub    $0xc,%esp
80105498:	50                   	push   %eax
80105499:	e8 c2 c3 ff ff       	call   80101860 <ilock>
  if(ip->type == T_DIR){
8010549e:	83 c4 10             	add    $0x10,%esp
801054a1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801054a6:	0f 84 c6 00 00 00    	je     80105572 <sys_link+0x132>
  iupdate(ip);
801054ac:	83 ec 0c             	sub    $0xc,%esp
801054af:	89 75 f8             	mov    %esi,-0x8(%ebp)
801054b2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if((dp = nameiparent(new, name)) == 0)
801054b5:	8d 7d da             	lea    -0x26(%ebp),%edi
  ip->nlink++;
801054b8:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
801054bd:	53                   	push   %ebx
801054be:	e8 dd c2 ff ff       	call   801017a0 <iupdate>
  iunlock(ip);
801054c3:	89 1c 24             	mov    %ebx,(%esp)
801054c6:	e8 75 c4 ff ff       	call   80101940 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801054cb:	58                   	pop    %eax
801054cc:	5a                   	pop    %edx
801054cd:	57                   	push   %edi
801054ce:	ff 75 d0             	push   -0x30(%ebp)
801054d1:	e8 3a cd ff ff       	call   80102210 <nameiparent>
801054d6:	83 c4 10             	add    $0x10,%esp
801054d9:	89 c6                	mov    %eax,%esi
801054db:	85 c0                	test   %eax,%eax
801054dd:	74 5d                	je     8010553c <sys_link+0xfc>
  ilock(dp);
801054df:	83 ec 0c             	sub    $0xc,%esp
801054e2:	50                   	push   %eax
801054e3:	e8 78 c3 ff ff       	call   80101860 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801054e8:	8b 03                	mov    (%ebx),%eax
801054ea:	83 c4 10             	add    $0x10,%esp
801054ed:	39 06                	cmp    %eax,(%esi)
801054ef:	75 3f                	jne    80105530 <sys_link+0xf0>
801054f1:	83 ec 04             	sub    $0x4,%esp
801054f4:	ff 73 04             	push   0x4(%ebx)
801054f7:	57                   	push   %edi
801054f8:	56                   	push   %esi
801054f9:	e8 32 cc ff ff       	call   80102130 <dirlink>
801054fe:	83 c4 10             	add    $0x10,%esp
80105501:	85 c0                	test   %eax,%eax
80105503:	78 2b                	js     80105530 <sys_link+0xf0>
  iunlockput(dp);
80105505:	83 ec 0c             	sub    $0xc,%esp
80105508:	56                   	push   %esi
80105509:	e8 02 c6 ff ff       	call   80101b10 <iunlockput>
  iput(ip);
8010550e:	89 1c 24             	mov    %ebx,(%esp)
80105511:	e8 7a c4 ff ff       	call   80101990 <iput>
  end_op();
80105516:	e8 95 da ff ff       	call   80102fb0 <end_op>
  return 0;
8010551b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010551e:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105521:	83 c4 10             	add    $0x10,%esp
80105524:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105527:	31 c0                	xor    %eax,%eax
}
80105529:	c9                   	leave
8010552a:	c3                   	ret
8010552b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    iunlockput(dp);
80105530:	83 ec 0c             	sub    $0xc,%esp
80105533:	56                   	push   %esi
80105534:	e8 d7 c5 ff ff       	call   80101b10 <iunlockput>
    goto bad;
80105539:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
8010553c:	83 ec 0c             	sub    $0xc,%esp
8010553f:	53                   	push   %ebx
80105540:	e8 1b c3 ff ff       	call   80101860 <ilock>
  ip->nlink--;
80105545:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010554a:	89 1c 24             	mov    %ebx,(%esp)
8010554d:	e8 4e c2 ff ff       	call   801017a0 <iupdate>
  iunlockput(ip);
80105552:	89 1c 24             	mov    %ebx,(%esp)
80105555:	e8 b6 c5 ff ff       	call   80101b10 <iunlockput>
  end_op();
8010555a:	e8 51 da ff ff       	call   80102fb0 <end_op>
  return -1;
8010555f:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105562:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105565:	83 c4 10             	add    $0x10,%esp
80105568:	8b 7d fc             	mov    -0x4(%ebp),%edi
}
8010556b:	c9                   	leave
    return -1;
8010556c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105571:	c3                   	ret
    iunlockput(ip);
80105572:	83 ec 0c             	sub    $0xc,%esp
80105575:	53                   	push   %ebx
80105576:	e8 95 c5 ff ff       	call   80101b10 <iunlockput>
    end_op();
8010557b:	e8 30 da ff ff       	call   80102fb0 <end_op>
    return -1;
80105580:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105583:	83 c4 10             	add    $0x10,%esp
80105586:	eb e3                	jmp    8010556b <sys_link+0x12b>
    end_op();
80105588:	e8 23 da ff ff       	call   80102fb0 <end_op>
    return -1;
8010558d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105590:	eb d9                	jmp    8010556b <sys_link+0x12b>
80105592:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105598:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010559f:	00 

801055a0 <sys_unlink>:
{
801055a0:	55                   	push   %ebp
801055a1:	89 e5                	mov    %esp,%ebp
801055a3:	83 ec 60             	sub    $0x60,%esp
  if(argstr(0, &path) < 0)
801055a6:	8d 45 c0             	lea    -0x40(%ebp),%eax
801055a9:	50                   	push   %eax
801055aa:	6a 00                	push   $0x0
801055ac:	e8 7f f9 ff ff       	call   80104f30 <argstr>
801055b1:	83 c4 10             	add    $0x10,%esp
801055b4:	85 c0                	test   %eax,%eax
801055b6:	0f 88 6d 01 00 00    	js     80105729 <sys_unlink+0x189>
801055bc:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  if((dp = nameiparent(path, name)) == 0){
801055bf:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
801055c2:	e8 79 d9 ff ff       	call   80102f40 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801055c7:	83 ec 08             	sub    $0x8,%esp
801055ca:	53                   	push   %ebx
801055cb:	ff 75 c0             	push   -0x40(%ebp)
801055ce:	e8 3d cc ff ff       	call   80102210 <nameiparent>
801055d3:	83 c4 10             	add    $0x10,%esp
801055d6:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801055d9:	85 c0                	test   %eax,%eax
801055db:	0f 84 77 01 00 00    	je     80105758 <sys_unlink+0x1b8>
801055e1:	89 7d fc             	mov    %edi,-0x4(%ebp)
  ilock(dp);
801055e4:	8b 7d b4             	mov    -0x4c(%ebp),%edi
801055e7:	83 ec 0c             	sub    $0xc,%esp
801055ea:	57                   	push   %edi
801055eb:	e8 70 c2 ff ff       	call   80101860 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801055f0:	58                   	pop    %eax
801055f1:	5a                   	pop    %edx
801055f2:	68 b2 7c 10 80       	push   $0x80107cb2
801055f7:	53                   	push   %ebx
801055f8:	e8 e3 c7 ff ff       	call   80101de0 <namecmp>
801055fd:	83 c4 10             	add    $0x10,%esp
80105600:	85 c0                	test   %eax,%eax
80105602:	0f 84 08 01 00 00    	je     80105710 <sys_unlink+0x170>
80105608:	83 ec 08             	sub    $0x8,%esp
8010560b:	68 b1 7c 10 80       	push   $0x80107cb1
80105610:	53                   	push   %ebx
80105611:	e8 ca c7 ff ff       	call   80101de0 <namecmp>
80105616:	83 c4 10             	add    $0x10,%esp
80105619:	85 c0                	test   %eax,%eax
8010561b:	0f 84 ef 00 00 00    	je     80105710 <sys_unlink+0x170>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105621:	83 ec 04             	sub    $0x4,%esp
80105624:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105627:	50                   	push   %eax
80105628:	53                   	push   %ebx
80105629:	57                   	push   %edi
8010562a:	e8 d1 c7 ff ff       	call   80101e00 <dirlookup>
8010562f:	83 c4 10             	add    $0x10,%esp
80105632:	89 c3                	mov    %eax,%ebx
80105634:	85 c0                	test   %eax,%eax
80105636:	0f 84 d4 00 00 00    	je     80105710 <sys_unlink+0x170>
  ilock(ip);
8010563c:	83 ec 0c             	sub    $0xc,%esp
8010563f:	50                   	push   %eax
80105640:	e8 1b c2 ff ff       	call   80101860 <ilock>
  if(ip->nlink < 1)
80105645:	83 c4 10             	add    $0x10,%esp
80105648:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010564d:	0f 8e 2c 01 00 00    	jle    8010577f <sys_unlink+0x1df>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105653:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105656:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010565b:	74 6b                	je     801056c8 <sys_unlink+0x128>
  memset(&de, 0, sizeof(de));
8010565d:	83 ec 04             	sub    $0x4,%esp
80105660:	6a 10                	push   $0x10
80105662:	6a 00                	push   $0x0
80105664:	57                   	push   %edi
80105665:	e8 16 f5 ff ff       	call   80104b80 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010566a:	6a 10                	push   $0x10
8010566c:	ff 75 c4             	push   -0x3c(%ebp)
8010566f:	57                   	push   %edi
80105670:	ff 75 b4             	push   -0x4c(%ebp)
80105673:	e8 38 c6 ff ff       	call   80101cb0 <writei>
80105678:	83 c4 20             	add    $0x20,%esp
8010567b:	83 f8 10             	cmp    $0x10,%eax
8010567e:	0f 85 eb 00 00 00    	jne    8010576f <sys_unlink+0x1cf>
  if(ip->type == T_DIR){
80105684:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105689:	0f 84 a1 00 00 00    	je     80105730 <sys_unlink+0x190>
  iunlockput(dp);
8010568f:	83 ec 0c             	sub    $0xc,%esp
80105692:	ff 75 b4             	push   -0x4c(%ebp)
80105695:	e8 76 c4 ff ff       	call   80101b10 <iunlockput>
  ip->nlink--;
8010569a:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010569f:	89 1c 24             	mov    %ebx,(%esp)
801056a2:	e8 f9 c0 ff ff       	call   801017a0 <iupdate>
  iunlockput(ip);
801056a7:	89 1c 24             	mov    %ebx,(%esp)
801056aa:	e8 61 c4 ff ff       	call   80101b10 <iunlockput>
  end_op();
801056af:	e8 fc d8 ff ff       	call   80102fb0 <end_op>
  return 0;
801056b4:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801056b7:	8b 7d fc             	mov    -0x4(%ebp),%edi
801056ba:	83 c4 10             	add    $0x10,%esp
}
801056bd:	c9                   	leave
  return 0;
801056be:	31 c0                	xor    %eax,%eax
}
801056c0:	c3                   	ret
801056c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801056c8:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801056cc:	76 8f                	jbe    8010565d <sys_unlink+0xbd>
801056ce:	89 75 f8             	mov    %esi,-0x8(%ebp)
801056d1:	be 20 00 00 00       	mov    $0x20,%esi
801056d6:	eb 10                	jmp    801056e8 <sys_unlink+0x148>
801056d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801056df:	00 
801056e0:	83 c6 10             	add    $0x10,%esi
801056e3:	3b 73 58             	cmp    0x58(%ebx),%esi
801056e6:	73 68                	jae    80105750 <sys_unlink+0x1b0>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801056e8:	6a 10                	push   $0x10
801056ea:	56                   	push   %esi
801056eb:	57                   	push   %edi
801056ec:	53                   	push   %ebx
801056ed:	e8 9e c4 ff ff       	call   80101b90 <readi>
801056f2:	83 c4 10             	add    $0x10,%esp
801056f5:	83 f8 10             	cmp    $0x10,%eax
801056f8:	75 68                	jne    80105762 <sys_unlink+0x1c2>
    if(de.inum != 0)
801056fa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801056ff:	74 df                	je     801056e0 <sys_unlink+0x140>
    iunlockput(ip);
80105701:	83 ec 0c             	sub    $0xc,%esp
80105704:	53                   	push   %ebx
80105705:	e8 06 c4 ff ff       	call   80101b10 <iunlockput>
    goto bad;
8010570a:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010570d:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105710:	83 ec 0c             	sub    $0xc,%esp
80105713:	ff 75 b4             	push   -0x4c(%ebp)
80105716:	e8 f5 c3 ff ff       	call   80101b10 <iunlockput>
  end_op();
8010571b:	e8 90 d8 ff ff       	call   80102fb0 <end_op>
  return -1;
80105720:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105723:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105726:	83 c4 10             	add    $0x10,%esp
}
80105729:	c9                   	leave
    return -1;
8010572a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010572f:	c3                   	ret
    dp->nlink--;
80105730:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105733:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105736:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
8010573b:	50                   	push   %eax
8010573c:	e8 5f c0 ff ff       	call   801017a0 <iupdate>
80105741:	83 c4 10             	add    $0x10,%esp
80105744:	e9 46 ff ff ff       	jmp    8010568f <sys_unlink+0xef>
80105749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105750:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105753:	e9 05 ff ff ff       	jmp    8010565d <sys_unlink+0xbd>
    end_op();
80105758:	e8 53 d8 ff ff       	call   80102fb0 <end_op>
8010575d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    return -1;
80105760:	eb c7                	jmp    80105729 <sys_unlink+0x189>
      panic("isdirempty: readi");
80105762:	83 ec 0c             	sub    $0xc,%esp
80105765:	68 d6 7c 10 80       	push   $0x80107cd6
8010576a:	e8 31 ac ff ff       	call   801003a0 <panic>
    panic("unlink: writei");
8010576f:	83 ec 0c             	sub    $0xc,%esp
80105772:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105775:	68 e8 7c 10 80       	push   $0x80107ce8
8010577a:	e8 21 ac ff ff       	call   801003a0 <panic>
    panic("unlink: nlink < 1");
8010577f:	83 ec 0c             	sub    $0xc,%esp
80105782:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105785:	68 c4 7c 10 80       	push   $0x80107cc4
8010578a:	e8 11 ac ff ff       	call   801003a0 <panic>
8010578f:	90                   	nop

80105790 <sys_open>:

int
sys_open(void)
{
80105790:	55                   	push   %ebp
80105791:	89 e5                	mov    %esp,%ebp
80105793:	83 ec 30             	sub    $0x30,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105796:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105799:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010579c:	50                   	push   %eax
8010579d:	6a 00                	push   $0x0
8010579f:	e8 8c f7 ff ff       	call   80104f30 <argstr>
801057a4:	83 c4 10             	add    $0x10,%esp
801057a7:	85 c0                	test   %eax,%eax
801057a9:	0f 88 a4 00 00 00    	js     80105853 <sys_open+0xc3>
801057af:	83 ec 08             	sub    $0x8,%esp
801057b2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801057b5:	50                   	push   %eax
801057b6:	6a 01                	push   $0x1
801057b8:	e8 b3 f6 ff ff       	call   80104e70 <argint>
801057bd:	83 c4 10             	add    $0x10,%esp
801057c0:	85 c0                	test   %eax,%eax
801057c2:	0f 88 8b 00 00 00    	js     80105853 <sys_open+0xc3>
801057c8:	89 7d fc             	mov    %edi,-0x4(%ebp)
    return -1;

  begin_op();
801057cb:	e8 70 d7 ff ff       	call   80102f40 <begin_op>

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
801057d0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  if(omode & O_CREATE){
801057d3:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801057d7:	0f 85 83 00 00 00    	jne    80105860 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801057dd:	83 ec 0c             	sub    $0xc,%esp
801057e0:	50                   	push   %eax
801057e1:	e8 0a ca ff ff       	call   801021f0 <namei>
801057e6:	83 c4 10             	add    $0x10,%esp
801057e9:	89 c7                	mov    %eax,%edi
801057eb:	85 c0                	test   %eax,%eax
801057ed:	0f 84 87 00 00 00    	je     8010587a <sys_open+0xea>
      end_op();
      return -1;
    }
    ilock(ip);
801057f3:	83 ec 0c             	sub    $0xc,%esp
801057f6:	50                   	push   %eax
801057f7:	e8 64 c0 ff ff       	call   80101860 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801057fc:	83 c4 10             	add    $0x10,%esp
801057ff:	66 83 7f 50 01       	cmpw   $0x1,0x50(%edi)
80105804:	0f 84 c6 00 00 00    	je     801058d0 <sys_open+0x140>
8010580a:	89 75 f8             	mov    %esi,-0x8(%ebp)
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010580d:	e8 ce b6 ff ff       	call   80100ee0 <filealloc>
80105812:	89 c6                	mov    %eax,%esi
80105814:	85 c0                	test   %eax,%eax
80105816:	74 24                	je     8010583c <sys_open+0xac>
  struct proc *curproc = myproc();
80105818:	e8 83 e3 ff ff       	call   80103ba0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010581d:	31 db                	xor    %ebx,%ebx
8010581f:	90                   	nop
    if(curproc->ofile[fd] == 0){
80105820:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105824:	85 d2                	test   %edx,%edx
80105826:	74 60                	je     80105888 <sys_open+0xf8>
  for(fd = 0; fd < NOFILE; fd++){
80105828:	83 c3 01             	add    $0x1,%ebx
8010582b:	83 fb 10             	cmp    $0x10,%ebx
8010582e:	75 f0                	jne    80105820 <sys_open+0x90>
    if(f)
      fileclose(f);
80105830:	83 ec 0c             	sub    $0xc,%esp
80105833:	56                   	push   %esi
80105834:	e8 67 b7 ff ff       	call   80100fa0 <fileclose>
80105839:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010583c:	83 ec 0c             	sub    $0xc,%esp
8010583f:	57                   	push   %edi
80105840:	e8 cb c2 ff ff       	call   80101b10 <iunlockput>
    end_op();
80105845:	e8 66 d7 ff ff       	call   80102fb0 <end_op>
    return -1;
8010584a:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010584d:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105850:	83 c4 10             	add    $0x10,%esp
    return -1;
80105853:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105858:	eb 6d                	jmp    801058c7 <sys_open+0x137>
8010585a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ip = create(path, T_FILE, 0, 0);
80105860:	83 ec 0c             	sub    $0xc,%esp
80105863:	31 c9                	xor    %ecx,%ecx
80105865:	ba 02 00 00 00       	mov    $0x2,%edx
8010586a:	6a 00                	push   $0x0
8010586c:	e8 af f7 ff ff       	call   80105020 <create>
    if(ip == 0){
80105871:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80105874:	89 c7                	mov    %eax,%edi
    if(ip == 0){
80105876:	85 c0                	test   %eax,%eax
80105878:	75 90                	jne    8010580a <sys_open+0x7a>
      end_op();
8010587a:	e8 31 d7 ff ff       	call   80102fb0 <end_op>
8010587f:	8b 7d fc             	mov    -0x4(%ebp),%edi
      return -1;
80105882:	eb cf                	jmp    80105853 <sys_open+0xc3>
80105884:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105888:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
8010588b:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010588f:	57                   	push   %edi
80105890:	e8 ab c0 ff ff       	call   80101940 <iunlock>
  end_op();
80105895:	e8 16 d7 ff ff       	call   80102fb0 <end_op>

  f->type = FD_INODE;
8010589a:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801058a0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801058a3:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801058a6:	89 7e 10             	mov    %edi,0x10(%esi)
  f->readable = !(omode & O_WRONLY);
801058a9:	89 d0                	mov    %edx,%eax
  f->off = 0;
801058ab:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
801058b2:	f7 d0                	not    %eax
801058b4:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801058b7:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801058ba:	88 46 08             	mov    %al,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801058bd:	0f 95 46 09          	setne  0x9(%esi)
  return fd;
801058c1:	8b 75 f8             	mov    -0x8(%ebp),%esi
801058c4:	8b 7d fc             	mov    -0x4(%ebp),%edi
}
801058c7:	89 d8                	mov    %ebx,%eax
801058c9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801058cc:	c9                   	leave
801058cd:	c3                   	ret
801058ce:	66 90                	xchg   %ax,%ax
    if(ip->type == T_DIR && omode != O_RDONLY){
801058d0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801058d3:	85 c9                	test   %ecx,%ecx
801058d5:	0f 84 2f ff ff ff    	je     8010580a <sys_open+0x7a>
      iunlockput(ip);
801058db:	83 ec 0c             	sub    $0xc,%esp
801058de:	57                   	push   %edi
801058df:	e8 2c c2 ff ff       	call   80101b10 <iunlockput>
      end_op();
801058e4:	e8 c7 d6 ff ff       	call   80102fb0 <end_op>
      return -1;
801058e9:	8b 7d fc             	mov    -0x4(%ebp),%edi
801058ec:	83 c4 10             	add    $0x10,%esp
801058ef:	e9 5f ff ff ff       	jmp    80105853 <sys_open+0xc3>
801058f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801058f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801058ff:	00 

80105900 <sys_mkdir>:

int
sys_mkdir(void)
{
80105900:	55                   	push   %ebp
80105901:	89 e5                	mov    %esp,%ebp
80105903:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105906:	e8 35 d6 ff ff       	call   80102f40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010590b:	83 ec 08             	sub    $0x8,%esp
8010590e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105911:	50                   	push   %eax
80105912:	6a 00                	push   $0x0
80105914:	e8 17 f6 ff ff       	call   80104f30 <argstr>
80105919:	83 c4 10             	add    $0x10,%esp
8010591c:	85 c0                	test   %eax,%eax
8010591e:	78 30                	js     80105950 <sys_mkdir+0x50>
80105920:	83 ec 0c             	sub    $0xc,%esp
80105923:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105926:	31 c9                	xor    %ecx,%ecx
80105928:	ba 01 00 00 00       	mov    $0x1,%edx
8010592d:	6a 00                	push   $0x0
8010592f:	e8 ec f6 ff ff       	call   80105020 <create>
80105934:	83 c4 10             	add    $0x10,%esp
80105937:	85 c0                	test   %eax,%eax
80105939:	74 15                	je     80105950 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010593b:	83 ec 0c             	sub    $0xc,%esp
8010593e:	50                   	push   %eax
8010593f:	e8 cc c1 ff ff       	call   80101b10 <iunlockput>
  end_op();
80105944:	e8 67 d6 ff ff       	call   80102fb0 <end_op>
  return 0;
80105949:	83 c4 10             	add    $0x10,%esp
8010594c:	31 c0                	xor    %eax,%eax
}
8010594e:	c9                   	leave
8010594f:	c3                   	ret
    end_op();
80105950:	e8 5b d6 ff ff       	call   80102fb0 <end_op>
    return -1;
80105955:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010595a:	c9                   	leave
8010595b:	c3                   	ret
8010595c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105960 <sys_mknod>:

int
sys_mknod(void)
{
80105960:	55                   	push   %ebp
80105961:	89 e5                	mov    %esp,%ebp
80105963:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105966:	e8 d5 d5 ff ff       	call   80102f40 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010596b:	83 ec 08             	sub    $0x8,%esp
8010596e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105971:	50                   	push   %eax
80105972:	6a 00                	push   $0x0
80105974:	e8 b7 f5 ff ff       	call   80104f30 <argstr>
80105979:	83 c4 10             	add    $0x10,%esp
8010597c:	85 c0                	test   %eax,%eax
8010597e:	78 60                	js     801059e0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105980:	83 ec 08             	sub    $0x8,%esp
80105983:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105986:	50                   	push   %eax
80105987:	6a 01                	push   $0x1
80105989:	e8 e2 f4 ff ff       	call   80104e70 <argint>
  if((argstr(0, &path)) < 0 ||
8010598e:	83 c4 10             	add    $0x10,%esp
80105991:	85 c0                	test   %eax,%eax
80105993:	78 4b                	js     801059e0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105995:	83 ec 08             	sub    $0x8,%esp
80105998:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010599b:	50                   	push   %eax
8010599c:	6a 02                	push   $0x2
8010599e:	e8 cd f4 ff ff       	call   80104e70 <argint>
     argint(1, &major) < 0 ||
801059a3:	83 c4 10             	add    $0x10,%esp
801059a6:	85 c0                	test   %eax,%eax
801059a8:	78 36                	js     801059e0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801059aa:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801059ae:	83 ec 0c             	sub    $0xc,%esp
801059b1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801059b5:	ba 03 00 00 00       	mov    $0x3,%edx
801059ba:	50                   	push   %eax
801059bb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801059be:	e8 5d f6 ff ff       	call   80105020 <create>
     argint(2, &minor) < 0 ||
801059c3:	83 c4 10             	add    $0x10,%esp
801059c6:	85 c0                	test   %eax,%eax
801059c8:	74 16                	je     801059e0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801059ca:	83 ec 0c             	sub    $0xc,%esp
801059cd:	50                   	push   %eax
801059ce:	e8 3d c1 ff ff       	call   80101b10 <iunlockput>
  end_op();
801059d3:	e8 d8 d5 ff ff       	call   80102fb0 <end_op>
  return 0;
801059d8:	83 c4 10             	add    $0x10,%esp
801059db:	31 c0                	xor    %eax,%eax
}
801059dd:	c9                   	leave
801059de:	c3                   	ret
801059df:	90                   	nop
    end_op();
801059e0:	e8 cb d5 ff ff       	call   80102fb0 <end_op>
    return -1;
801059e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059ea:	c9                   	leave
801059eb:	c3                   	ret
801059ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801059f0 <sys_chdir>:

int
sys_chdir(void)
{
801059f0:	55                   	push   %ebp
801059f1:	89 e5                	mov    %esp,%ebp
801059f3:	83 ec 18             	sub    $0x18,%esp
801059f6:	89 75 fc             	mov    %esi,-0x4(%ebp)
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801059f9:	e8 a2 e1 ff ff       	call   80103ba0 <myproc>
801059fe:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105a00:	e8 3b d5 ff ff       	call   80102f40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105a05:	83 ec 08             	sub    $0x8,%esp
80105a08:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a0b:	50                   	push   %eax
80105a0c:	6a 00                	push   $0x0
80105a0e:	e8 1d f5 ff ff       	call   80104f30 <argstr>
80105a13:	83 c4 10             	add    $0x10,%esp
80105a16:	85 c0                	test   %eax,%eax
80105a18:	78 74                	js     80105a8e <sys_chdir+0x9e>
80105a1a:	83 ec 0c             	sub    $0xc,%esp
80105a1d:	ff 75 f4             	push   -0xc(%ebp)
80105a20:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105a23:	e8 c8 c7 ff ff       	call   801021f0 <namei>
80105a28:	83 c4 10             	add    $0x10,%esp
80105a2b:	89 c3                	mov    %eax,%ebx
80105a2d:	85 c0                	test   %eax,%eax
80105a2f:	74 5a                	je     80105a8b <sys_chdir+0x9b>
    end_op();
    return -1;
  }
  ilock(ip);
80105a31:	83 ec 0c             	sub    $0xc,%esp
80105a34:	50                   	push   %eax
80105a35:	e8 26 be ff ff       	call   80101860 <ilock>
  if(ip->type != T_DIR){
80105a3a:	83 c4 10             	add    $0x10,%esp
80105a3d:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105a42:	75 2c                	jne    80105a70 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105a44:	83 ec 0c             	sub    $0xc,%esp
80105a47:	53                   	push   %ebx
80105a48:	e8 f3 be ff ff       	call   80101940 <iunlock>
  iput(curproc->cwd);
80105a4d:	58                   	pop    %eax
80105a4e:	ff 76 68             	push   0x68(%esi)
80105a51:	e8 3a bf ff ff       	call   80101990 <iput>
  end_op();
80105a56:	e8 55 d5 ff ff       	call   80102fb0 <end_op>
  curproc->cwd = ip;
80105a5b:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105a5e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105a61:	83 c4 10             	add    $0x10,%esp
80105a64:	31 c0                	xor    %eax,%eax
}
80105a66:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105a69:	c9                   	leave
80105a6a:	c3                   	ret
80105a6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80105a70:	83 ec 0c             	sub    $0xc,%esp
80105a73:	53                   	push   %ebx
80105a74:	e8 97 c0 ff ff       	call   80101b10 <iunlockput>
    end_op();
80105a79:	e8 32 d5 ff ff       	call   80102fb0 <end_op>
    return -1;
80105a7e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105a81:	83 c4 10             	add    $0x10,%esp
    return -1;
80105a84:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a89:	eb db                	jmp    80105a66 <sys_chdir+0x76>
80105a8b:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    end_op();
80105a8e:	e8 1d d5 ff ff       	call   80102fb0 <end_op>
    return -1;
80105a93:	eb ef                	jmp    80105a84 <sys_chdir+0x94>
80105a95:	8d 76 00             	lea    0x0(%esi),%esi
80105a98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a9f:	00 

80105aa0 <sys_exec>:

int
sys_exec(void)
{
80105aa0:	55                   	push   %ebp
80105aa1:	89 e5                	mov    %esp,%ebp
80105aa3:	81 ec b0 00 00 00    	sub    $0xb0,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105aa9:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80105aaf:	50                   	push   %eax
80105ab0:	6a 00                	push   $0x0
80105ab2:	e8 79 f4 ff ff       	call   80104f30 <argstr>
80105ab7:	83 c4 10             	add    $0x10,%esp
80105aba:	85 c0                	test   %eax,%eax
80105abc:	0f 88 8e 00 00 00    	js     80105b50 <sys_exec+0xb0>
80105ac2:	83 ec 08             	sub    $0x8,%esp
80105ac5:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105acb:	50                   	push   %eax
80105acc:	6a 01                	push   $0x1
80105ace:	e8 9d f3 ff ff       	call   80104e70 <argint>
80105ad3:	83 c4 10             	add    $0x10,%esp
80105ad6:	85 c0                	test   %eax,%eax
80105ad8:	78 76                	js     80105b50 <sys_exec+0xb0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105ada:	83 ec 04             	sub    $0x4,%esp
80105add:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105ae0:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105ae6:	68 80 00 00 00       	push   $0x80
80105aeb:	6a 00                	push   $0x0
80105aed:	56                   	push   %esi
80105aee:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  for(i=0;; i++){
80105af1:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105af3:	e8 88 f0 ff ff       	call   80104b80 <memset>
80105af8:	83 c4 10             	add    $0x10,%esp
80105afb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105b00:	83 ec 08             	sub    $0x8,%esp
80105b03:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105b09:	50                   	push   %eax
80105b0a:	8d 04 9d 00 00 00 00 	lea    0x0(,%ebx,4),%eax
80105b11:	03 85 60 ff ff ff    	add    -0xa0(%ebp),%eax
80105b17:	50                   	push   %eax
80105b18:	e8 b3 f2 ff ff       	call   80104dd0 <fetchint>
80105b1d:	83 c4 10             	add    $0x10,%esp
80105b20:	85 c0                	test   %eax,%eax
80105b22:	78 26                	js     80105b4a <sys_exec+0xaa>
      return -1;
    if(uarg == 0){
80105b24:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105b2a:	85 c0                	test   %eax,%eax
80105b2c:	74 32                	je     80105b60 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105b2e:	83 ec 08             	sub    $0x8,%esp
80105b31:	8d 14 9e             	lea    (%esi,%ebx,4),%edx
80105b34:	52                   	push   %edx
80105b35:	50                   	push   %eax
80105b36:	e8 d5 f2 ff ff       	call   80104e10 <fetchstr>
80105b3b:	83 c4 10             	add    $0x10,%esp
80105b3e:	85 c0                	test   %eax,%eax
80105b40:	78 08                	js     80105b4a <sys_exec+0xaa>
  for(i=0;; i++){
80105b42:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105b45:	83 fb 20             	cmp    $0x20,%ebx
80105b48:	75 b6                	jne    80105b00 <sys_exec+0x60>
80105b4a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105b4d:	8b 75 f8             	mov    -0x8(%ebp),%esi
      return -1;
  }
  return exec(path, argv);
}
80105b50:	c9                   	leave
    return -1;
80105b51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b56:	c3                   	ret
80105b57:	90                   	nop
80105b58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105b5f:	00 
      argv[i] = 0;
80105b60:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105b67:	00 00 00 00 
  return exec(path, argv);
80105b6b:	83 ec 08             	sub    $0x8,%esp
80105b6e:	56                   	push   %esi
80105b6f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105b75:	e8 d6 af ff ff       	call   80100b50 <exec>
80105b7a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105b7d:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105b80:	83 c4 10             	add    $0x10,%esp
}
80105b83:	c9                   	leave
80105b84:	c3                   	ret
80105b85:	8d 76 00             	lea    0x0(%esi),%esi
80105b88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105b8f:	00 

80105b90 <sys_pipe>:

int
sys_pipe(void)
{
80105b90:	55                   	push   %ebp
80105b91:	89 e5                	mov    %esp,%ebp
80105b93:	83 ec 2c             	sub    $0x2c,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105b96:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105b99:	6a 08                	push   $0x8
80105b9b:	50                   	push   %eax
80105b9c:	6a 00                	push   $0x0
80105b9e:	e8 1d f3 ff ff       	call   80104ec0 <argptr>
80105ba3:	83 c4 10             	add    $0x10,%esp
80105ba6:	85 c0                	test   %eax,%eax
80105ba8:	0f 88 af 00 00 00    	js     80105c5d <sys_pipe+0xcd>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105bae:	83 ec 08             	sub    $0x8,%esp
80105bb1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105bb4:	50                   	push   %eax
80105bb5:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105bb8:	50                   	push   %eax
80105bb9:	e8 42 da ff ff       	call   80103600 <pipealloc>
80105bbe:	83 c4 10             	add    $0x10,%esp
80105bc1:	85 c0                	test   %eax,%eax
80105bc3:	0f 88 94 00 00 00    	js     80105c5d <sys_pipe+0xcd>
80105bc9:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  for(fd = 0; fd < NOFILE; fd++){
80105bcc:	31 db                	xor    %ebx,%ebx
80105bce:	89 7d fc             	mov    %edi,-0x4(%ebp)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105bd1:	8b 7d e0             	mov    -0x20(%ebp),%edi
  struct proc *curproc = myproc();
80105bd4:	e8 c7 df ff ff       	call   80103ba0 <myproc>
    if(curproc->ofile[fd] == 0){
80105bd9:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105bdd:	85 d2                	test   %edx,%edx
80105bdf:	74 1f                	je     80105c00 <sys_pipe+0x70>
80105be1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105be8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105bef:	00 
  for(fd = 0; fd < NOFILE; fd++){
80105bf0:	83 c3 01             	add    $0x1,%ebx
80105bf3:	83 fb 10             	cmp    $0x10,%ebx
80105bf6:	74 48                	je     80105c40 <sys_pipe+0xb0>
    if(curproc->ofile[fd] == 0){
80105bf8:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105bfc:	85 d2                	test   %edx,%edx
80105bfe:	75 f0                	jne    80105bf0 <sys_pipe+0x60>
80105c00:	89 75 f8             	mov    %esi,-0x8(%ebp)
      curproc->ofile[fd] = f;
80105c03:	8d 73 08             	lea    0x8(%ebx),%esi
80105c06:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105c0a:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105c0d:	e8 8e df ff ff       	call   80103ba0 <myproc>
80105c12:	89 c2                	mov    %eax,%edx
  for(fd = 0; fd < NOFILE; fd++){
80105c14:	31 c0                	xor    %eax,%eax
80105c16:	66 90                	xchg   %ax,%ax
80105c18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105c1f:	00 
    if(curproc->ofile[fd] == 0){
80105c20:	8b 4c 82 28          	mov    0x28(%edx,%eax,4),%ecx
80105c24:	85 c9                	test   %ecx,%ecx
80105c26:	74 40                	je     80105c68 <sys_pipe+0xd8>
  for(fd = 0; fd < NOFILE; fd++){
80105c28:	83 c0 01             	add    $0x1,%eax
80105c2b:	83 f8 10             	cmp    $0x10,%eax
80105c2e:	75 f0                	jne    80105c20 <sys_pipe+0x90>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105c30:	e8 6b df ff ff       	call   80103ba0 <myproc>
80105c35:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105c3c:	00 
80105c3d:	8b 75 f8             	mov    -0x8(%ebp),%esi
    fileclose(rf);
80105c40:	83 ec 0c             	sub    $0xc,%esp
80105c43:	ff 75 e0             	push   -0x20(%ebp)
80105c46:	e8 55 b3 ff ff       	call   80100fa0 <fileclose>
    fileclose(wf);
80105c4b:	58                   	pop    %eax
80105c4c:	ff 75 e4             	push   -0x1c(%ebp)
80105c4f:	e8 4c b3 ff ff       	call   80100fa0 <fileclose>
    return -1;
80105c54:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105c57:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105c5a:	83 c4 10             	add    $0x10,%esp
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80105c5d:	c9                   	leave
    return -1;
80105c5e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c63:	c3                   	ret
80105c64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80105c68:	89 7c 82 28          	mov    %edi,0x28(%edx,%eax,4)
  fd[0] = fd0;
80105c6c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105c6f:	89 1a                	mov    %ebx,(%edx)
  fd[1] = fd1;
80105c71:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105c74:	89 42 04             	mov    %eax,0x4(%edx)
  return 0;
80105c77:	31 c0                	xor    %eax,%eax
80105c79:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105c7c:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105c7f:	8b 7d fc             	mov    -0x4(%ebp),%edi
}
80105c82:	c9                   	leave
80105c83:	c3                   	ret
80105c84:	66 90                	xchg   %ax,%ax
80105c86:	66 90                	xchg   %ax,%ax
80105c88:	66 90                	xchg   %ax,%ax
80105c8a:	66 90                	xchg   %ax,%ax
80105c8c:	66 90                	xchg   %ax,%ax
80105c8e:	66 90                	xchg   %ax,%ax

80105c90 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105c90:	e9 ab e0 ff ff       	jmp    80103d40 <fork>
80105c95:	8d 76 00             	lea    0x0(%esi),%esi
80105c98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105c9f:	00 

80105ca0 <sys_exit>:
}

int
sys_exit(void)
{
80105ca0:	55                   	push   %ebp
80105ca1:	89 e5                	mov    %esp,%ebp
80105ca3:	83 ec 08             	sub    $0x8,%esp
  exit();
80105ca6:	e8 25 e3 ff ff       	call   80103fd0 <exit>
  return 0;  // not reached
}
80105cab:	31 c0                	xor    %eax,%eax
80105cad:	c9                   	leave
80105cae:	c3                   	ret
80105caf:	90                   	nop

80105cb0 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105cb0:	e9 6b e4 ff ff       	jmp    80104120 <wait>
80105cb5:	8d 76 00             	lea    0x0(%esi),%esi
80105cb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105cbf:	00 

80105cc0 <sys_kill>:
}

int
sys_kill(void)
{
80105cc0:	55                   	push   %ebp
80105cc1:	89 e5                	mov    %esp,%ebp
80105cc3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105cc6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105cc9:	50                   	push   %eax
80105cca:	6a 00                	push   $0x0
80105ccc:	e8 9f f1 ff ff       	call   80104e70 <argint>
80105cd1:	83 c4 10             	add    $0x10,%esp
80105cd4:	85 c0                	test   %eax,%eax
80105cd6:	78 18                	js     80105cf0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105cd8:	83 ec 0c             	sub    $0xc,%esp
80105cdb:	ff 75 f4             	push   -0xc(%ebp)
80105cde:	e8 ed e6 ff ff       	call   801043d0 <kill>
80105ce3:	83 c4 10             	add    $0x10,%esp
}
80105ce6:	c9                   	leave
80105ce7:	c3                   	ret
80105ce8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105cef:	00 
80105cf0:	c9                   	leave
    return -1;
80105cf1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105cf6:	c3                   	ret
80105cf7:	90                   	nop
80105cf8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105cff:	00 

80105d00 <sys_getpid>:

int
sys_getpid(void)
{
80105d00:	55                   	push   %ebp
80105d01:	89 e5                	mov    %esp,%ebp
80105d03:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105d06:	e8 95 de ff ff       	call   80103ba0 <myproc>
80105d0b:	8b 40 10             	mov    0x10(%eax),%eax
}
80105d0e:	c9                   	leave
80105d0f:	c3                   	ret

80105d10 <sys_sbrk>:

int
sys_sbrk(void)
{
80105d10:	55                   	push   %ebp
80105d11:	89 e5                	mov    %esp,%ebp
80105d13:	83 ec 20             	sub    $0x20,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105d16:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d19:	50                   	push   %eax
80105d1a:	6a 00                	push   $0x0
80105d1c:	e8 4f f1 ff ff       	call   80104e70 <argint>
80105d21:	83 c4 10             	add    $0x10,%esp
80105d24:	85 c0                	test   %eax,%eax
80105d26:	78 26                	js     80105d4e <sys_sbrk+0x3e>
80105d28:	89 5d fc             	mov    %ebx,-0x4(%ebp)
    return -1;
  addr = myproc()->sz;
80105d2b:	e8 70 de ff ff       	call   80103ba0 <myproc>
  if(growproc(n) < 0)
80105d30:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105d33:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105d35:	ff 75 f4             	push   -0xc(%ebp)
80105d38:	e8 83 df ff ff       	call   80103cc0 <growproc>
80105d3d:	83 c4 10             	add    $0x10,%esp
80105d40:	85 c0                	test   %eax,%eax
80105d42:	78 07                	js     80105d4b <sys_sbrk+0x3b>
  addr = myproc()->sz;
80105d44:	89 d8                	mov    %ebx,%eax
80105d46:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
  return addr;
}
80105d49:	c9                   	leave
80105d4a:	c3                   	ret
80105d4b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105d4e:	c9                   	leave
    return -1;
80105d4f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d54:	c3                   	ret
80105d55:	8d 76 00             	lea    0x0(%esi),%esi
80105d58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d5f:	00 

80105d60 <sys_sleep>:

int
sys_sleep(void)
{
80105d60:	55                   	push   %ebp
80105d61:	89 e5                	mov    %esp,%ebp
80105d63:	83 ec 20             	sub    $0x20,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105d66:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d69:	50                   	push   %eax
80105d6a:	6a 00                	push   $0x0
80105d6c:	e8 ff f0 ff ff       	call   80104e70 <argint>
80105d71:	83 c4 10             	add    $0x10,%esp
80105d74:	85 c0                	test   %eax,%eax
80105d76:	78 68                	js     80105de0 <sys_sleep+0x80>
    return -1;
  acquire(&tickslock);
80105d78:	83 ec 0c             	sub    $0xc,%esp
80105d7b:	68 00 4d 11 80       	push   $0x80114d00
80105d80:	e8 db ec ff ff       	call   80104a60 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105d85:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105d88:	83 c4 10             	add    $0x10,%esp
80105d8b:	85 d2                	test   %edx,%edx
80105d8d:	74 64                	je     80105df3 <sys_sleep+0x93>
80105d8f:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  ticks0 = ticks;
80105d92:	8b 1d e0 4c 11 80    	mov    0x80114ce0,%ebx
80105d98:	eb 27                	jmp    80105dc1 <sys_sleep+0x61>
80105d9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105da0:	83 ec 08             	sub    $0x8,%esp
80105da3:	68 00 4d 11 80       	push   $0x80114d00
80105da8:	68 e0 4c 11 80       	push   $0x80114ce0
80105dad:	e8 fe e4 ff ff       	call   801042b0 <sleep>
  while(ticks - ticks0 < n){
80105db2:	a1 e0 4c 11 80       	mov    0x80114ce0,%eax
80105db7:	83 c4 10             	add    $0x10,%esp
80105dba:	29 d8                	sub    %ebx,%eax
80105dbc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105dbf:	73 2f                	jae    80105df0 <sys_sleep+0x90>
    if(myproc()->killed){
80105dc1:	e8 da dd ff ff       	call   80103ba0 <myproc>
80105dc6:	8b 40 24             	mov    0x24(%eax),%eax
80105dc9:	85 c0                	test   %eax,%eax
80105dcb:	74 d3                	je     80105da0 <sys_sleep+0x40>
      release(&tickslock);
80105dcd:	83 ec 0c             	sub    $0xc,%esp
80105dd0:	68 00 4d 11 80       	push   $0x80114d00
80105dd5:	e8 26 ec ff ff       	call   80104a00 <release>
      return -1;
80105dda:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ddd:	83 c4 10             	add    $0x10,%esp
  }
  release(&tickslock);
  return 0;
}
80105de0:	c9                   	leave
    return -1;
80105de1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105de6:	c3                   	ret
80105de7:	90                   	nop
80105de8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105def:	00 
80105df0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&tickslock);
80105df3:	83 ec 0c             	sub    $0xc,%esp
80105df6:	68 00 4d 11 80       	push   $0x80114d00
80105dfb:	e8 00 ec ff ff       	call   80104a00 <release>
  return 0;
80105e00:	83 c4 10             	add    $0x10,%esp
80105e03:	31 c0                	xor    %eax,%eax
}
80105e05:	c9                   	leave
80105e06:	c3                   	ret
80105e07:	90                   	nop
80105e08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e0f:	00 

80105e10 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105e10:	55                   	push   %ebp
80105e11:	89 e5                	mov    %esp,%ebp
80105e13:	53                   	push   %ebx
80105e14:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105e17:	68 00 4d 11 80       	push   $0x80114d00
80105e1c:	e8 3f ec ff ff       	call   80104a60 <acquire>
  xticks = ticks;
  release(&tickslock);
80105e21:	c7 04 24 00 4d 11 80 	movl   $0x80114d00,(%esp)
  xticks = ticks;
80105e28:	8b 1d e0 4c 11 80    	mov    0x80114ce0,%ebx
  release(&tickslock);
80105e2e:	e8 cd eb ff ff       	call   80104a00 <release>
  return xticks;
}
80105e33:	89 d8                	mov    %ebx,%eax
80105e35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105e38:	c9                   	leave
80105e39:	c3                   	ret
80105e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105e40 <sys_sem_init>:

int
sys_sem_init(void)
{
80105e40:	55                   	push   %ebp
80105e41:	89 e5                	mov    %esp,%ebp
80105e43:	83 ec 20             	sub    $0x20,%esp
  int id, value;

  if(argint(0, &id) < 0 || argint(1, &value) < 0)
80105e46:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105e49:	50                   	push   %eax
80105e4a:	6a 00                	push   $0x0
80105e4c:	e8 1f f0 ff ff       	call   80104e70 <argint>
80105e51:	83 c4 10             	add    $0x10,%esp
80105e54:	85 c0                	test   %eax,%eax
80105e56:	78 28                	js     80105e80 <sys_sem_init+0x40>
80105e58:	83 ec 08             	sub    $0x8,%esp
80105e5b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e5e:	50                   	push   %eax
80105e5f:	6a 01                	push   $0x1
80105e61:	e8 0a f0 ff ff       	call   80104e70 <argint>
80105e66:	83 c4 10             	add    $0x10,%esp
80105e69:	85 c0                	test   %eax,%eax
80105e6b:	78 13                	js     80105e80 <sys_sem_init+0x40>
    return -1;
  return semcreate(id, value);
80105e6d:	83 ec 08             	sub    $0x8,%esp
80105e70:	ff 75 f4             	push   -0xc(%ebp)
80105e73:	ff 75 f0             	push   -0x10(%ebp)
80105e76:	e8 e5 e6 ff ff       	call   80104560 <semcreate>
80105e7b:	83 c4 10             	add    $0x10,%esp
}
80105e7e:	c9                   	leave
80105e7f:	c3                   	ret
80105e80:	c9                   	leave
    return -1;
80105e81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e86:	c3                   	ret
80105e87:	90                   	nop
80105e88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e8f:	00 

80105e90 <sys_sem_wait>:

int
sys_sem_wait(void)
{
80105e90:	55                   	push   %ebp
80105e91:	89 e5                	mov    %esp,%ebp
80105e93:	83 ec 20             	sub    $0x20,%esp
  int id;

  if(argint(0, &id) < 0)
80105e96:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e99:	50                   	push   %eax
80105e9a:	6a 00                	push   $0x0
80105e9c:	e8 cf ef ff ff       	call   80104e70 <argint>
80105ea1:	83 c4 10             	add    $0x10,%esp
80105ea4:	85 c0                	test   %eax,%eax
80105ea6:	78 18                	js     80105ec0 <sys_sem_wait+0x30>
    return -1;
  return semwait(id);
80105ea8:	83 ec 0c             	sub    $0xc,%esp
80105eab:	ff 75 f4             	push   -0xc(%ebp)
80105eae:	e8 0d e7 ff ff       	call   801045c0 <semwait>
80105eb3:	83 c4 10             	add    $0x10,%esp
}
80105eb6:	c9                   	leave
80105eb7:	c3                   	ret
80105eb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105ebf:	00 
80105ec0:	c9                   	leave
    return -1;
80105ec1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ec6:	c3                   	ret
80105ec7:	90                   	nop
80105ec8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105ecf:	00 

80105ed0 <sys_sem_post>:

int
sys_sem_post(void)
{
80105ed0:	55                   	push   %ebp
80105ed1:	89 e5                	mov    %esp,%ebp
80105ed3:	83 ec 20             	sub    $0x20,%esp
  int id;

  if(argint(0, &id) < 0)
80105ed6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ed9:	50                   	push   %eax
80105eda:	6a 00                	push   $0x0
80105edc:	e8 8f ef ff ff       	call   80104e70 <argint>
80105ee1:	83 c4 10             	add    $0x10,%esp
80105ee4:	85 c0                	test   %eax,%eax
80105ee6:	78 18                	js     80105f00 <sys_sem_post+0x30>
    return -1;
  return sempost(id);
80105ee8:	83 ec 0c             	sub    $0xc,%esp
80105eeb:	ff 75 f4             	push   -0xc(%ebp)
80105eee:	e8 8d e7 ff ff       	call   80104680 <sempost>
80105ef3:	83 c4 10             	add    $0x10,%esp
}
80105ef6:	c9                   	leave
80105ef7:	c3                   	ret
80105ef8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105eff:	00 
80105f00:	c9                   	leave
    return -1;
80105f01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f06:	c3                   	ret

80105f07 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105f07:	1e                   	push   %ds
  pushl %es
80105f08:	06                   	push   %es
  pushl %fs
80105f09:	0f a0                	push   %fs
  pushl %gs
80105f0b:	0f a8                	push   %gs
  pushal
80105f0d:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105f0e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105f12:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105f14:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105f16:	54                   	push   %esp
  call trap
80105f17:	e8 04 01 00 00       	call   80106020 <trap>
  addl $4, %esp
80105f1c:	83 c4 04             	add    $0x4,%esp

80105f1f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105f1f:	61                   	popa
  popl %gs
80105f20:	0f a9                	pop    %gs
  popl %fs
80105f22:	0f a1                	pop    %fs
  popl %es
80105f24:	07                   	pop    %es
  popl %ds
80105f25:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105f26:	83 c4 08             	add    $0x8,%esp
  iret
80105f29:	cf                   	iret
80105f2a:	66 90                	xchg   %ax,%ax
80105f2c:	66 90                	xchg   %ax,%ax
80105f2e:	66 90                	xchg   %ax,%ax
80105f30:	66 90                	xchg   %ax,%ax
80105f32:	66 90                	xchg   %ax,%ax
80105f34:	66 90                	xchg   %ax,%ax
80105f36:	66 90                	xchg   %ax,%ax
80105f38:	66 90                	xchg   %ax,%ax
80105f3a:	66 90                	xchg   %ax,%ax
80105f3c:	66 90                	xchg   %ax,%ax
80105f3e:	66 90                	xchg   %ax,%ax

80105f40 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105f40:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105f41:	31 c0                	xor    %eax,%eax
{
80105f43:	89 e5                	mov    %esp,%ebp
80105f45:	83 ec 08             	sub    $0x8,%esp
80105f48:	eb 36                	jmp    80105f80 <tvinit+0x40>
80105f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105f50:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105f57:	00 
80105f58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105f5f:	00 
80105f60:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105f67:	00 
80105f68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105f6f:	00 
80105f70:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105f77:	00 
80105f78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105f7f:	00 
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105f80:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80105f87:	c7 04 c5 42 4d 11 80 	movl   $0x8e000008,-0x7feeb2be(,%eax,8)
80105f8e:	08 00 00 8e 
80105f92:	66 89 14 c5 40 4d 11 	mov    %dx,-0x7feeb2c0(,%eax,8)
80105f99:	80 
80105f9a:	c1 ea 10             	shr    $0x10,%edx
80105f9d:	66 89 14 c5 46 4d 11 	mov    %dx,-0x7feeb2ba(,%eax,8)
80105fa4:	80 
  for(i = 0; i < 256; i++)
80105fa5:	83 c0 01             	add    $0x1,%eax
80105fa8:	3d 00 01 00 00       	cmp    $0x100,%eax
80105fad:	75 d1                	jne    80105f80 <tvinit+0x40>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80105faf:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105fb2:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80105fb7:	c7 05 42 4f 11 80 08 	movl   $0xef000008,0x80114f42
80105fbe:	00 00 ef 
  initlock(&tickslock, "time");
80105fc1:	68 f7 7c 10 80       	push   $0x80107cf7
80105fc6:	68 00 4d 11 80       	push   $0x80114d00
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105fcb:	66 a3 40 4f 11 80    	mov    %ax,0x80114f40
80105fd1:	c1 e8 10             	shr    $0x10,%eax
80105fd4:	66 a3 46 4f 11 80    	mov    %ax,0x80114f46
  initlock(&tickslock, "time");
80105fda:	e8 61 e8 ff ff       	call   80104840 <initlock>
}
80105fdf:	83 c4 10             	add    $0x10,%esp
80105fe2:	c9                   	leave
80105fe3:	c3                   	ret
80105fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105fe8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105fef:	00 

80105ff0 <idtinit>:

void
idtinit(void)
{
80105ff0:	55                   	push   %ebp
  pd[0] = size-1;
80105ff1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105ff6:	89 e5                	mov    %esp,%ebp
80105ff8:	83 ec 10             	sub    $0x10,%esp
80105ffb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105fff:	b8 40 4d 11 80       	mov    $0x80114d40,%eax
80106004:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106008:	c1 e8 10             	shr    $0x10,%eax
8010600b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010600f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106012:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106015:	c9                   	leave
80106016:	c3                   	ret
80106017:	90                   	nop
80106018:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010601f:	00 

80106020 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106020:	55                   	push   %ebp
80106021:	89 e5                	mov    %esp,%ebp
80106023:	83 ec 28             	sub    $0x28,%esp
80106026:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80106029:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
8010602c:	8b 43 30             	mov    0x30(%ebx),%eax
8010602f:	83 f8 40             	cmp    $0x40,%eax
80106032:	0f 84 78 01 00 00    	je     801061b0 <trap+0x190>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106038:	83 e8 20             	sub    $0x20,%eax
8010603b:	83 f8 1f             	cmp    $0x1f,%eax
8010603e:	0f 87 7c 00 00 00    	ja     801060c0 <trap+0xa0>
80106044:	ff 24 85 44 82 10 80 	jmp    *-0x7fef7dbc(,%eax,4)
8010604b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106050:	e8 2b c3 ff ff       	call   80102380 <ideintr>
    lapiceoi();
80106055:	e8 36 ca ff ff       	call   80102a90 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010605a:	e8 41 db ff ff       	call   80103ba0 <myproc>
8010605f:	85 c0                	test   %eax,%eax
80106061:	74 1a                	je     8010607d <trap+0x5d>
80106063:	e8 38 db ff ff       	call   80103ba0 <myproc>
80106068:	8b 50 24             	mov    0x24(%eax),%edx
8010606b:	85 d2                	test   %edx,%edx
8010606d:	74 0e                	je     8010607d <trap+0x5d>
8010606f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106073:	f7 d0                	not    %eax
80106075:	a8 03                	test   $0x3,%al
80106077:	0f 84 fb 01 00 00    	je     80106278 <trap+0x258>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
8010607d:	e8 1e db ff ff       	call   80103ba0 <myproc>
80106082:	85 c0                	test   %eax,%eax
80106084:	74 0f                	je     80106095 <trap+0x75>
80106086:	e8 15 db ff ff       	call   80103ba0 <myproc>
8010608b:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
8010608f:	0f 84 bb 00 00 00    	je     80106150 <trap+0x130>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106095:	e8 06 db ff ff       	call   80103ba0 <myproc>
8010609a:	85 c0                	test   %eax,%eax
8010609c:	74 1a                	je     801060b8 <trap+0x98>
8010609e:	e8 fd da ff ff       	call   80103ba0 <myproc>
801060a3:	8b 40 24             	mov    0x24(%eax),%eax
801060a6:	85 c0                	test   %eax,%eax
801060a8:	74 0e                	je     801060b8 <trap+0x98>
801060aa:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801060ae:	f7 d0                	not    %eax
801060b0:	a8 03                	test   $0x3,%al
801060b2:	0f 84 25 01 00 00    	je     801061dd <trap+0x1bd>
    exit();
}
801060b8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801060bb:	c9                   	leave
801060bc:	c3                   	ret
801060bd:	8d 76 00             	lea    0x0(%esi),%esi
801060c0:	89 75 f8             	mov    %esi,-0x8(%ebp)
801060c3:	89 7d fc             	mov    %edi,-0x4(%ebp)
    if(myproc() == 0 || (tf->cs&3) == 0){
801060c6:	e8 d5 da ff ff       	call   80103ba0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801060cb:	8b 73 38             	mov    0x38(%ebx),%esi
801060ce:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    if(myproc() == 0 || (tf->cs&3) == 0){
801060d1:	85 c0                	test   %eax,%eax
801060d3:	0f 84 b9 01 00 00    	je     80106292 <trap+0x272>
801060d9:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801060dd:	0f 84 af 01 00 00    	je     80106292 <trap+0x272>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801060e3:	0f 20 d7             	mov    %cr2,%edi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801060e6:	e8 95 da ff ff       	call   80103b80 <cpuid>
801060eb:	8b 4b 30             	mov    0x30(%ebx),%ecx
801060ee:	89 45 d8             	mov    %eax,-0x28(%ebp)
801060f1:	8b 43 34             	mov    0x34(%ebx),%eax
801060f4:	89 4d dc             	mov    %ecx,-0x24(%ebp)
801060f7:	89 45 e0             	mov    %eax,-0x20(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
801060fa:	e8 a1 da ff ff       	call   80103ba0 <myproc>
801060ff:	8d 70 6c             	lea    0x6c(%eax),%esi
80106102:	e8 99 da ff ff       	call   80103ba0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106107:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010610a:	8b 4d dc             	mov    -0x24(%ebp),%ecx
8010610d:	57                   	push   %edi
8010610e:	ff 75 e4             	push   -0x1c(%ebp)
80106111:	52                   	push   %edx
80106112:	ff 75 e0             	push   -0x20(%ebp)
80106115:	51                   	push   %ecx
80106116:	56                   	push   %esi
80106117:	ff 70 10             	push   0x10(%eax)
8010611a:	68 28 7f 10 80       	push   $0x80107f28
8010611f:	e8 cc a5 ff ff       	call   801006f0 <cprintf>
    myproc()->killed = 1;
80106124:	83 c4 20             	add    $0x20,%esp
80106127:	e8 74 da ff ff       	call   80103ba0 <myproc>
8010612c:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106133:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106136:	8b 7d fc             	mov    -0x4(%ebp),%edi
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106139:	e8 62 da ff ff       	call   80103ba0 <myproc>
8010613e:	85 c0                	test   %eax,%eax
80106140:	0f 85 1d ff ff ff    	jne    80106063 <trap+0x43>
80106146:	e9 32 ff ff ff       	jmp    8010607d <trap+0x5d>
8010614b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->state == RUNNING &&
80106150:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106154:	0f 85 3b ff ff ff    	jne    80106095 <trap+0x75>
    yield();
8010615a:	e8 01 e1 ff ff       	call   80104260 <yield>
8010615f:	e9 31 ff ff ff       	jmp    80106095 <trap+0x75>
80106164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106168:	8b 4b 38             	mov    0x38(%ebx),%ecx
8010616b:	0f b7 53 3c          	movzwl 0x3c(%ebx),%edx
8010616f:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80106172:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80106175:	e8 06 da ff ff       	call   80103b80 <cpuid>
8010617a:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010617d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106180:	51                   	push   %ecx
80106181:	52                   	push   %edx
80106182:	50                   	push   %eax
80106183:	68 d0 7e 10 80       	push   $0x80107ed0
80106188:	e8 63 a5 ff ff       	call   801006f0 <cprintf>
    lapiceoi();
8010618d:	e8 fe c8 ff ff       	call   80102a90 <lapiceoi>
    break;
80106192:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106195:	e8 06 da ff ff       	call   80103ba0 <myproc>
8010619a:	85 c0                	test   %eax,%eax
8010619c:	0f 85 c1 fe ff ff    	jne    80106063 <trap+0x43>
801061a2:	e9 d6 fe ff ff       	jmp    8010607d <trap+0x5d>
801061a7:	90                   	nop
801061a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801061af:	00 
    if(myproc()->killed)
801061b0:	e8 eb d9 ff ff       	call   80103ba0 <myproc>
801061b5:	8b 40 24             	mov    0x24(%eax),%eax
801061b8:	85 c0                	test   %eax,%eax
801061ba:	0f 85 c8 00 00 00    	jne    80106288 <trap+0x268>
    myproc()->tf = tf;
801061c0:	e8 db d9 ff ff       	call   80103ba0 <myproc>
801061c5:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
801061c8:	e8 e3 ed ff ff       	call   80104fb0 <syscall>
    if(myproc()->killed)
801061cd:	e8 ce d9 ff ff       	call   80103ba0 <myproc>
801061d2:	8b 48 24             	mov    0x24(%eax),%ecx
801061d5:	85 c9                	test   %ecx,%ecx
801061d7:	0f 84 db fe ff ff    	je     801060b8 <trap+0x98>
}
801061dd:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801061e0:	c9                   	leave
      exit();
801061e1:	e9 ea dd ff ff       	jmp    80103fd0 <exit>
801061e6:	66 90                	xchg   %ax,%ax
801061e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801061ef:	00 
    uartintr();
801061f0:	e8 5b 02 00 00       	call   80106450 <uartintr>
    lapiceoi();
801061f5:	e8 96 c8 ff ff       	call   80102a90 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801061fa:	e8 a1 d9 ff ff       	call   80103ba0 <myproc>
801061ff:	85 c0                	test   %eax,%eax
80106201:	0f 85 5c fe ff ff    	jne    80106063 <trap+0x43>
80106207:	e9 71 fe ff ff       	jmp    8010607d <trap+0x5d>
8010620c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106210:	e8 3b c7 ff ff       	call   80102950 <kbdintr>
    lapiceoi();
80106215:	e8 76 c8 ff ff       	call   80102a90 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010621a:	e8 81 d9 ff ff       	call   80103ba0 <myproc>
8010621f:	85 c0                	test   %eax,%eax
80106221:	0f 85 3c fe ff ff    	jne    80106063 <trap+0x43>
80106227:	e9 51 fe ff ff       	jmp    8010607d <trap+0x5d>
8010622c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80106230:	e8 4b d9 ff ff       	call   80103b80 <cpuid>
80106235:	85 c0                	test   %eax,%eax
80106237:	0f 85 18 fe ff ff    	jne    80106055 <trap+0x35>
      acquire(&tickslock);
8010623d:	83 ec 0c             	sub    $0xc,%esp
80106240:	68 00 4d 11 80       	push   $0x80114d00
80106245:	e8 16 e8 ff ff       	call   80104a60 <acquire>
      wakeup(&ticks);
8010624a:	c7 04 24 e0 4c 11 80 	movl   $0x80114ce0,(%esp)
      ticks++;
80106251:	83 05 e0 4c 11 80 01 	addl   $0x1,0x80114ce0
      wakeup(&ticks);
80106258:	e8 13 e1 ff ff       	call   80104370 <wakeup>
      release(&tickslock);
8010625d:	c7 04 24 00 4d 11 80 	movl   $0x80114d00,(%esp)
80106264:	e8 97 e7 ff ff       	call   80104a00 <release>
80106269:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
8010626c:	e9 e4 fd ff ff       	jmp    80106055 <trap+0x35>
80106271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80106278:	e8 53 dd ff ff       	call   80103fd0 <exit>
8010627d:	e9 fb fd ff ff       	jmp    8010607d <trap+0x5d>
80106282:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106288:	e8 43 dd ff ff       	call   80103fd0 <exit>
8010628d:	e9 2e ff ff ff       	jmp    801061c0 <trap+0x1a0>
80106292:	0f 20 d2             	mov    %cr2,%edx
80106295:	89 55 e0             	mov    %edx,-0x20(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106298:	e8 e3 d8 ff ff       	call   80103b80 <cpuid>
8010629d:	8b 55 e0             	mov    -0x20(%ebp),%edx
801062a0:	83 ec 0c             	sub    $0xc,%esp
801062a3:	52                   	push   %edx
801062a4:	ff 75 e4             	push   -0x1c(%ebp)
801062a7:	50                   	push   %eax
801062a8:	ff 73 30             	push   0x30(%ebx)
801062ab:	68 f4 7e 10 80       	push   $0x80107ef4
801062b0:	e8 3b a4 ff ff       	call   801006f0 <cprintf>
      panic("trap");
801062b5:	83 c4 14             	add    $0x14,%esp
801062b8:	68 fc 7c 10 80       	push   $0x80107cfc
801062bd:	e8 de a0 ff ff       	call   801003a0 <panic>
801062c2:	66 90                	xchg   %ax,%ax
801062c4:	66 90                	xchg   %ax,%ax
801062c6:	66 90                	xchg   %ax,%ax
801062c8:	66 90                	xchg   %ax,%ax
801062ca:	66 90                	xchg   %ax,%ax
801062cc:	66 90                	xchg   %ax,%ax
801062ce:	66 90                	xchg   %ax,%ax

801062d0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801062d0:	a1 40 55 11 80       	mov    0x80115540,%eax
801062d5:	85 c0                	test   %eax,%eax
801062d7:	74 17                	je     801062f0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801062d9:	ba fd 03 00 00       	mov    $0x3fd,%edx
801062de:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801062df:	a8 01                	test   $0x1,%al
801062e1:	74 0d                	je     801062f0 <uartgetc+0x20>
801062e3:	ba f8 03 00 00       	mov    $0x3f8,%edx
801062e8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801062e9:	0f b6 c0             	movzbl %al,%eax
}
801062ec:	c3                   	ret
801062ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801062f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062f5:	c3                   	ret
801062f6:	66 90                	xchg   %ax,%ax
801062f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801062ff:	00 

80106300 <uartinit>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106300:	31 c0                	xor    %eax,%eax
80106302:	ba fa 03 00 00       	mov    $0x3fa,%edx
80106307:	ee                   	out    %al,(%dx)
80106308:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010630d:	ba fb 03 00 00       	mov    $0x3fb,%edx
80106312:	ee                   	out    %al,(%dx)
80106313:	b8 0c 00 00 00       	mov    $0xc,%eax
80106318:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010631d:	ee                   	out    %al,(%dx)
8010631e:	31 c0                	xor    %eax,%eax
80106320:	ba f9 03 00 00       	mov    $0x3f9,%edx
80106325:	ee                   	out    %al,(%dx)
80106326:	b8 03 00 00 00       	mov    $0x3,%eax
8010632b:	ba fb 03 00 00       	mov    $0x3fb,%edx
80106330:	ee                   	out    %al,(%dx)
80106331:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106336:	31 c0                	xor    %eax,%eax
80106338:	ee                   	out    %al,(%dx)
80106339:	b8 01 00 00 00       	mov    $0x1,%eax
8010633e:	ba f9 03 00 00       	mov    $0x3f9,%edx
80106343:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106344:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106349:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
8010634a:	3c ff                	cmp    $0xff,%al
8010634c:	0f 84 8e 00 00 00    	je     801063e0 <uartinit+0xe0>
{
80106352:	55                   	push   %ebp
80106353:	ba fa 03 00 00       	mov    $0x3fa,%edx
80106358:	89 e5                	mov    %esp,%ebp
8010635a:	83 ec 30             	sub    $0x30,%esp
  uart = 1;
8010635d:	c7 05 40 55 11 80 01 	movl   $0x1,0x80115540
80106364:	00 00 00 
{
80106367:	89 5d f4             	mov    %ebx,-0xc(%ebp)
8010636a:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010636d:	ec                   	in     (%dx),%al
8010636e:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106373:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106374:	6a 00                	push   $0x0
  for(p="xv6...\n"; *p; p++)
80106376:	bf 01 7d 10 80       	mov    $0x80107d01,%edi
  ioapicenable(IRQ_COM1, 0);
8010637b:	6a 04                	push   $0x4
8010637d:	e8 7e c2 ff ff       	call   80102600 <ioapicenable>
80106382:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106385:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
80106389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
80106390:	a1 40 55 11 80       	mov    0x80115540,%eax
80106395:	bb 80 00 00 00       	mov    $0x80,%ebx
8010639a:	85 c0                	test   %eax,%eax
8010639c:	75 14                	jne    801063b2 <uartinit+0xb2>
8010639e:	eb 26                	jmp    801063c6 <uartinit+0xc6>
    microdelay(10);
801063a0:	83 ec 0c             	sub    $0xc,%esp
801063a3:	6a 0a                	push   $0xa
801063a5:	e8 06 c7 ff ff       	call   80102ab0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801063aa:	83 c4 10             	add    $0x10,%esp
801063ad:	83 eb 01             	sub    $0x1,%ebx
801063b0:	74 0a                	je     801063bc <uartinit+0xbc>
801063b2:	ba fd 03 00 00       	mov    $0x3fd,%edx
801063b7:	ec                   	in     (%dx),%al
801063b8:	a8 20                	test   $0x20,%al
801063ba:	74 e4                	je     801063a0 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801063bc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801063c0:	ba f8 03 00 00       	mov    $0x3f8,%edx
801063c5:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
801063c6:	0f b6 47 01          	movzbl 0x1(%edi),%eax
801063ca:	83 c7 01             	add    $0x1,%edi
801063cd:	88 45 e7             	mov    %al,-0x19(%ebp)
801063d0:	81 ff 08 7d 10 80    	cmp    $0x80107d08,%edi
801063d6:	75 b8                	jne    80106390 <uartinit+0x90>
}
801063d8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801063db:	8b 7d fc             	mov    -0x4(%ebp),%edi
801063de:	c9                   	leave
801063df:	c3                   	ret
801063e0:	c3                   	ret
801063e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801063ef:	00 

801063f0 <uartputc>:
  if(!uart)
801063f0:	a1 40 55 11 80       	mov    0x80115540,%eax
801063f5:	85 c0                	test   %eax,%eax
801063f7:	74 47                	je     80106440 <uartputc+0x50>
{
801063f9:	55                   	push   %ebp
801063fa:	89 e5                	mov    %esp,%ebp
801063fc:	83 ec 08             	sub    $0x8,%esp
801063ff:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  if(!uart)
80106402:	bb 80 00 00 00       	mov    $0x80,%ebx
80106407:	eb 19                	jmp    80106422 <uartputc+0x32>
80106409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    microdelay(10);
80106410:	83 ec 0c             	sub    $0xc,%esp
80106413:	6a 0a                	push   $0xa
80106415:	e8 96 c6 ff ff       	call   80102ab0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010641a:	83 c4 10             	add    $0x10,%esp
8010641d:	83 eb 01             	sub    $0x1,%ebx
80106420:	74 0a                	je     8010642c <uartputc+0x3c>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106422:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106427:	ec                   	in     (%dx),%al
80106428:	a8 20                	test   $0x20,%al
8010642a:	74 e4                	je     80106410 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010642c:	8b 45 08             	mov    0x8(%ebp),%eax
8010642f:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106434:	ee                   	out    %al,(%dx)
}
80106435:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80106438:	c9                   	leave
80106439:	c3                   	ret
8010643a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106440:	c3                   	ret
80106441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106448:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010644f:	00 

80106450 <uartintr>:

void
uartintr(void)
{
80106450:	55                   	push   %ebp
80106451:	89 e5                	mov    %esp,%ebp
80106453:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106456:	68 d0 62 10 80       	push   $0x801062d0
8010645b:	e8 b0 a4 ff ff       	call   80100910 <consoleintr>
}
80106460:	83 c4 10             	add    $0x10,%esp
80106463:	c9                   	leave
80106464:	c3                   	ret

80106465 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106465:	6a 00                	push   $0x0
  pushl $0
80106467:	6a 00                	push   $0x0
  jmp alltraps
80106469:	e9 99 fa ff ff       	jmp    80105f07 <alltraps>

8010646e <vector1>:
.globl vector1
vector1:
  pushl $0
8010646e:	6a 00                	push   $0x0
  pushl $1
80106470:	6a 01                	push   $0x1
  jmp alltraps
80106472:	e9 90 fa ff ff       	jmp    80105f07 <alltraps>

80106477 <vector2>:
.globl vector2
vector2:
  pushl $0
80106477:	6a 00                	push   $0x0
  pushl $2
80106479:	6a 02                	push   $0x2
  jmp alltraps
8010647b:	e9 87 fa ff ff       	jmp    80105f07 <alltraps>

80106480 <vector3>:
.globl vector3
vector3:
  pushl $0
80106480:	6a 00                	push   $0x0
  pushl $3
80106482:	6a 03                	push   $0x3
  jmp alltraps
80106484:	e9 7e fa ff ff       	jmp    80105f07 <alltraps>

80106489 <vector4>:
.globl vector4
vector4:
  pushl $0
80106489:	6a 00                	push   $0x0
  pushl $4
8010648b:	6a 04                	push   $0x4
  jmp alltraps
8010648d:	e9 75 fa ff ff       	jmp    80105f07 <alltraps>

80106492 <vector5>:
.globl vector5
vector5:
  pushl $0
80106492:	6a 00                	push   $0x0
  pushl $5
80106494:	6a 05                	push   $0x5
  jmp alltraps
80106496:	e9 6c fa ff ff       	jmp    80105f07 <alltraps>

8010649b <vector6>:
.globl vector6
vector6:
  pushl $0
8010649b:	6a 00                	push   $0x0
  pushl $6
8010649d:	6a 06                	push   $0x6
  jmp alltraps
8010649f:	e9 63 fa ff ff       	jmp    80105f07 <alltraps>

801064a4 <vector7>:
.globl vector7
vector7:
  pushl $0
801064a4:	6a 00                	push   $0x0
  pushl $7
801064a6:	6a 07                	push   $0x7
  jmp alltraps
801064a8:	e9 5a fa ff ff       	jmp    80105f07 <alltraps>

801064ad <vector8>:
.globl vector8
vector8:
  pushl $8
801064ad:	6a 08                	push   $0x8
  jmp alltraps
801064af:	e9 53 fa ff ff       	jmp    80105f07 <alltraps>

801064b4 <vector9>:
.globl vector9
vector9:
  pushl $0
801064b4:	6a 00                	push   $0x0
  pushl $9
801064b6:	6a 09                	push   $0x9
  jmp alltraps
801064b8:	e9 4a fa ff ff       	jmp    80105f07 <alltraps>

801064bd <vector10>:
.globl vector10
vector10:
  pushl $10
801064bd:	6a 0a                	push   $0xa
  jmp alltraps
801064bf:	e9 43 fa ff ff       	jmp    80105f07 <alltraps>

801064c4 <vector11>:
.globl vector11
vector11:
  pushl $11
801064c4:	6a 0b                	push   $0xb
  jmp alltraps
801064c6:	e9 3c fa ff ff       	jmp    80105f07 <alltraps>

801064cb <vector12>:
.globl vector12
vector12:
  pushl $12
801064cb:	6a 0c                	push   $0xc
  jmp alltraps
801064cd:	e9 35 fa ff ff       	jmp    80105f07 <alltraps>

801064d2 <vector13>:
.globl vector13
vector13:
  pushl $13
801064d2:	6a 0d                	push   $0xd
  jmp alltraps
801064d4:	e9 2e fa ff ff       	jmp    80105f07 <alltraps>

801064d9 <vector14>:
.globl vector14
vector14:
  pushl $14
801064d9:	6a 0e                	push   $0xe
  jmp alltraps
801064db:	e9 27 fa ff ff       	jmp    80105f07 <alltraps>

801064e0 <vector15>:
.globl vector15
vector15:
  pushl $0
801064e0:	6a 00                	push   $0x0
  pushl $15
801064e2:	6a 0f                	push   $0xf
  jmp alltraps
801064e4:	e9 1e fa ff ff       	jmp    80105f07 <alltraps>

801064e9 <vector16>:
.globl vector16
vector16:
  pushl $0
801064e9:	6a 00                	push   $0x0
  pushl $16
801064eb:	6a 10                	push   $0x10
  jmp alltraps
801064ed:	e9 15 fa ff ff       	jmp    80105f07 <alltraps>

801064f2 <vector17>:
.globl vector17
vector17:
  pushl $17
801064f2:	6a 11                	push   $0x11
  jmp alltraps
801064f4:	e9 0e fa ff ff       	jmp    80105f07 <alltraps>

801064f9 <vector18>:
.globl vector18
vector18:
  pushl $0
801064f9:	6a 00                	push   $0x0
  pushl $18
801064fb:	6a 12                	push   $0x12
  jmp alltraps
801064fd:	e9 05 fa ff ff       	jmp    80105f07 <alltraps>

80106502 <vector19>:
.globl vector19
vector19:
  pushl $0
80106502:	6a 00                	push   $0x0
  pushl $19
80106504:	6a 13                	push   $0x13
  jmp alltraps
80106506:	e9 fc f9 ff ff       	jmp    80105f07 <alltraps>

8010650b <vector20>:
.globl vector20
vector20:
  pushl $0
8010650b:	6a 00                	push   $0x0
  pushl $20
8010650d:	6a 14                	push   $0x14
  jmp alltraps
8010650f:	e9 f3 f9 ff ff       	jmp    80105f07 <alltraps>

80106514 <vector21>:
.globl vector21
vector21:
  pushl $0
80106514:	6a 00                	push   $0x0
  pushl $21
80106516:	6a 15                	push   $0x15
  jmp alltraps
80106518:	e9 ea f9 ff ff       	jmp    80105f07 <alltraps>

8010651d <vector22>:
.globl vector22
vector22:
  pushl $0
8010651d:	6a 00                	push   $0x0
  pushl $22
8010651f:	6a 16                	push   $0x16
  jmp alltraps
80106521:	e9 e1 f9 ff ff       	jmp    80105f07 <alltraps>

80106526 <vector23>:
.globl vector23
vector23:
  pushl $0
80106526:	6a 00                	push   $0x0
  pushl $23
80106528:	6a 17                	push   $0x17
  jmp alltraps
8010652a:	e9 d8 f9 ff ff       	jmp    80105f07 <alltraps>

8010652f <vector24>:
.globl vector24
vector24:
  pushl $0
8010652f:	6a 00                	push   $0x0
  pushl $24
80106531:	6a 18                	push   $0x18
  jmp alltraps
80106533:	e9 cf f9 ff ff       	jmp    80105f07 <alltraps>

80106538 <vector25>:
.globl vector25
vector25:
  pushl $0
80106538:	6a 00                	push   $0x0
  pushl $25
8010653a:	6a 19                	push   $0x19
  jmp alltraps
8010653c:	e9 c6 f9 ff ff       	jmp    80105f07 <alltraps>

80106541 <vector26>:
.globl vector26
vector26:
  pushl $0
80106541:	6a 00                	push   $0x0
  pushl $26
80106543:	6a 1a                	push   $0x1a
  jmp alltraps
80106545:	e9 bd f9 ff ff       	jmp    80105f07 <alltraps>

8010654a <vector27>:
.globl vector27
vector27:
  pushl $0
8010654a:	6a 00                	push   $0x0
  pushl $27
8010654c:	6a 1b                	push   $0x1b
  jmp alltraps
8010654e:	e9 b4 f9 ff ff       	jmp    80105f07 <alltraps>

80106553 <vector28>:
.globl vector28
vector28:
  pushl $0
80106553:	6a 00                	push   $0x0
  pushl $28
80106555:	6a 1c                	push   $0x1c
  jmp alltraps
80106557:	e9 ab f9 ff ff       	jmp    80105f07 <alltraps>

8010655c <vector29>:
.globl vector29
vector29:
  pushl $0
8010655c:	6a 00                	push   $0x0
  pushl $29
8010655e:	6a 1d                	push   $0x1d
  jmp alltraps
80106560:	e9 a2 f9 ff ff       	jmp    80105f07 <alltraps>

80106565 <vector30>:
.globl vector30
vector30:
  pushl $0
80106565:	6a 00                	push   $0x0
  pushl $30
80106567:	6a 1e                	push   $0x1e
  jmp alltraps
80106569:	e9 99 f9 ff ff       	jmp    80105f07 <alltraps>

8010656e <vector31>:
.globl vector31
vector31:
  pushl $0
8010656e:	6a 00                	push   $0x0
  pushl $31
80106570:	6a 1f                	push   $0x1f
  jmp alltraps
80106572:	e9 90 f9 ff ff       	jmp    80105f07 <alltraps>

80106577 <vector32>:
.globl vector32
vector32:
  pushl $0
80106577:	6a 00                	push   $0x0
  pushl $32
80106579:	6a 20                	push   $0x20
  jmp alltraps
8010657b:	e9 87 f9 ff ff       	jmp    80105f07 <alltraps>

80106580 <vector33>:
.globl vector33
vector33:
  pushl $0
80106580:	6a 00                	push   $0x0
  pushl $33
80106582:	6a 21                	push   $0x21
  jmp alltraps
80106584:	e9 7e f9 ff ff       	jmp    80105f07 <alltraps>

80106589 <vector34>:
.globl vector34
vector34:
  pushl $0
80106589:	6a 00                	push   $0x0
  pushl $34
8010658b:	6a 22                	push   $0x22
  jmp alltraps
8010658d:	e9 75 f9 ff ff       	jmp    80105f07 <alltraps>

80106592 <vector35>:
.globl vector35
vector35:
  pushl $0
80106592:	6a 00                	push   $0x0
  pushl $35
80106594:	6a 23                	push   $0x23
  jmp alltraps
80106596:	e9 6c f9 ff ff       	jmp    80105f07 <alltraps>

8010659b <vector36>:
.globl vector36
vector36:
  pushl $0
8010659b:	6a 00                	push   $0x0
  pushl $36
8010659d:	6a 24                	push   $0x24
  jmp alltraps
8010659f:	e9 63 f9 ff ff       	jmp    80105f07 <alltraps>

801065a4 <vector37>:
.globl vector37
vector37:
  pushl $0
801065a4:	6a 00                	push   $0x0
  pushl $37
801065a6:	6a 25                	push   $0x25
  jmp alltraps
801065a8:	e9 5a f9 ff ff       	jmp    80105f07 <alltraps>

801065ad <vector38>:
.globl vector38
vector38:
  pushl $0
801065ad:	6a 00                	push   $0x0
  pushl $38
801065af:	6a 26                	push   $0x26
  jmp alltraps
801065b1:	e9 51 f9 ff ff       	jmp    80105f07 <alltraps>

801065b6 <vector39>:
.globl vector39
vector39:
  pushl $0
801065b6:	6a 00                	push   $0x0
  pushl $39
801065b8:	6a 27                	push   $0x27
  jmp alltraps
801065ba:	e9 48 f9 ff ff       	jmp    80105f07 <alltraps>

801065bf <vector40>:
.globl vector40
vector40:
  pushl $0
801065bf:	6a 00                	push   $0x0
  pushl $40
801065c1:	6a 28                	push   $0x28
  jmp alltraps
801065c3:	e9 3f f9 ff ff       	jmp    80105f07 <alltraps>

801065c8 <vector41>:
.globl vector41
vector41:
  pushl $0
801065c8:	6a 00                	push   $0x0
  pushl $41
801065ca:	6a 29                	push   $0x29
  jmp alltraps
801065cc:	e9 36 f9 ff ff       	jmp    80105f07 <alltraps>

801065d1 <vector42>:
.globl vector42
vector42:
  pushl $0
801065d1:	6a 00                	push   $0x0
  pushl $42
801065d3:	6a 2a                	push   $0x2a
  jmp alltraps
801065d5:	e9 2d f9 ff ff       	jmp    80105f07 <alltraps>

801065da <vector43>:
.globl vector43
vector43:
  pushl $0
801065da:	6a 00                	push   $0x0
  pushl $43
801065dc:	6a 2b                	push   $0x2b
  jmp alltraps
801065de:	e9 24 f9 ff ff       	jmp    80105f07 <alltraps>

801065e3 <vector44>:
.globl vector44
vector44:
  pushl $0
801065e3:	6a 00                	push   $0x0
  pushl $44
801065e5:	6a 2c                	push   $0x2c
  jmp alltraps
801065e7:	e9 1b f9 ff ff       	jmp    80105f07 <alltraps>

801065ec <vector45>:
.globl vector45
vector45:
  pushl $0
801065ec:	6a 00                	push   $0x0
  pushl $45
801065ee:	6a 2d                	push   $0x2d
  jmp alltraps
801065f0:	e9 12 f9 ff ff       	jmp    80105f07 <alltraps>

801065f5 <vector46>:
.globl vector46
vector46:
  pushl $0
801065f5:	6a 00                	push   $0x0
  pushl $46
801065f7:	6a 2e                	push   $0x2e
  jmp alltraps
801065f9:	e9 09 f9 ff ff       	jmp    80105f07 <alltraps>

801065fe <vector47>:
.globl vector47
vector47:
  pushl $0
801065fe:	6a 00                	push   $0x0
  pushl $47
80106600:	6a 2f                	push   $0x2f
  jmp alltraps
80106602:	e9 00 f9 ff ff       	jmp    80105f07 <alltraps>

80106607 <vector48>:
.globl vector48
vector48:
  pushl $0
80106607:	6a 00                	push   $0x0
  pushl $48
80106609:	6a 30                	push   $0x30
  jmp alltraps
8010660b:	e9 f7 f8 ff ff       	jmp    80105f07 <alltraps>

80106610 <vector49>:
.globl vector49
vector49:
  pushl $0
80106610:	6a 00                	push   $0x0
  pushl $49
80106612:	6a 31                	push   $0x31
  jmp alltraps
80106614:	e9 ee f8 ff ff       	jmp    80105f07 <alltraps>

80106619 <vector50>:
.globl vector50
vector50:
  pushl $0
80106619:	6a 00                	push   $0x0
  pushl $50
8010661b:	6a 32                	push   $0x32
  jmp alltraps
8010661d:	e9 e5 f8 ff ff       	jmp    80105f07 <alltraps>

80106622 <vector51>:
.globl vector51
vector51:
  pushl $0
80106622:	6a 00                	push   $0x0
  pushl $51
80106624:	6a 33                	push   $0x33
  jmp alltraps
80106626:	e9 dc f8 ff ff       	jmp    80105f07 <alltraps>

8010662b <vector52>:
.globl vector52
vector52:
  pushl $0
8010662b:	6a 00                	push   $0x0
  pushl $52
8010662d:	6a 34                	push   $0x34
  jmp alltraps
8010662f:	e9 d3 f8 ff ff       	jmp    80105f07 <alltraps>

80106634 <vector53>:
.globl vector53
vector53:
  pushl $0
80106634:	6a 00                	push   $0x0
  pushl $53
80106636:	6a 35                	push   $0x35
  jmp alltraps
80106638:	e9 ca f8 ff ff       	jmp    80105f07 <alltraps>

8010663d <vector54>:
.globl vector54
vector54:
  pushl $0
8010663d:	6a 00                	push   $0x0
  pushl $54
8010663f:	6a 36                	push   $0x36
  jmp alltraps
80106641:	e9 c1 f8 ff ff       	jmp    80105f07 <alltraps>

80106646 <vector55>:
.globl vector55
vector55:
  pushl $0
80106646:	6a 00                	push   $0x0
  pushl $55
80106648:	6a 37                	push   $0x37
  jmp alltraps
8010664a:	e9 b8 f8 ff ff       	jmp    80105f07 <alltraps>

8010664f <vector56>:
.globl vector56
vector56:
  pushl $0
8010664f:	6a 00                	push   $0x0
  pushl $56
80106651:	6a 38                	push   $0x38
  jmp alltraps
80106653:	e9 af f8 ff ff       	jmp    80105f07 <alltraps>

80106658 <vector57>:
.globl vector57
vector57:
  pushl $0
80106658:	6a 00                	push   $0x0
  pushl $57
8010665a:	6a 39                	push   $0x39
  jmp alltraps
8010665c:	e9 a6 f8 ff ff       	jmp    80105f07 <alltraps>

80106661 <vector58>:
.globl vector58
vector58:
  pushl $0
80106661:	6a 00                	push   $0x0
  pushl $58
80106663:	6a 3a                	push   $0x3a
  jmp alltraps
80106665:	e9 9d f8 ff ff       	jmp    80105f07 <alltraps>

8010666a <vector59>:
.globl vector59
vector59:
  pushl $0
8010666a:	6a 00                	push   $0x0
  pushl $59
8010666c:	6a 3b                	push   $0x3b
  jmp alltraps
8010666e:	e9 94 f8 ff ff       	jmp    80105f07 <alltraps>

80106673 <vector60>:
.globl vector60
vector60:
  pushl $0
80106673:	6a 00                	push   $0x0
  pushl $60
80106675:	6a 3c                	push   $0x3c
  jmp alltraps
80106677:	e9 8b f8 ff ff       	jmp    80105f07 <alltraps>

8010667c <vector61>:
.globl vector61
vector61:
  pushl $0
8010667c:	6a 00                	push   $0x0
  pushl $61
8010667e:	6a 3d                	push   $0x3d
  jmp alltraps
80106680:	e9 82 f8 ff ff       	jmp    80105f07 <alltraps>

80106685 <vector62>:
.globl vector62
vector62:
  pushl $0
80106685:	6a 00                	push   $0x0
  pushl $62
80106687:	6a 3e                	push   $0x3e
  jmp alltraps
80106689:	e9 79 f8 ff ff       	jmp    80105f07 <alltraps>

8010668e <vector63>:
.globl vector63
vector63:
  pushl $0
8010668e:	6a 00                	push   $0x0
  pushl $63
80106690:	6a 3f                	push   $0x3f
  jmp alltraps
80106692:	e9 70 f8 ff ff       	jmp    80105f07 <alltraps>

80106697 <vector64>:
.globl vector64
vector64:
  pushl $0
80106697:	6a 00                	push   $0x0
  pushl $64
80106699:	6a 40                	push   $0x40
  jmp alltraps
8010669b:	e9 67 f8 ff ff       	jmp    80105f07 <alltraps>

801066a0 <vector65>:
.globl vector65
vector65:
  pushl $0
801066a0:	6a 00                	push   $0x0
  pushl $65
801066a2:	6a 41                	push   $0x41
  jmp alltraps
801066a4:	e9 5e f8 ff ff       	jmp    80105f07 <alltraps>

801066a9 <vector66>:
.globl vector66
vector66:
  pushl $0
801066a9:	6a 00                	push   $0x0
  pushl $66
801066ab:	6a 42                	push   $0x42
  jmp alltraps
801066ad:	e9 55 f8 ff ff       	jmp    80105f07 <alltraps>

801066b2 <vector67>:
.globl vector67
vector67:
  pushl $0
801066b2:	6a 00                	push   $0x0
  pushl $67
801066b4:	6a 43                	push   $0x43
  jmp alltraps
801066b6:	e9 4c f8 ff ff       	jmp    80105f07 <alltraps>

801066bb <vector68>:
.globl vector68
vector68:
  pushl $0
801066bb:	6a 00                	push   $0x0
  pushl $68
801066bd:	6a 44                	push   $0x44
  jmp alltraps
801066bf:	e9 43 f8 ff ff       	jmp    80105f07 <alltraps>

801066c4 <vector69>:
.globl vector69
vector69:
  pushl $0
801066c4:	6a 00                	push   $0x0
  pushl $69
801066c6:	6a 45                	push   $0x45
  jmp alltraps
801066c8:	e9 3a f8 ff ff       	jmp    80105f07 <alltraps>

801066cd <vector70>:
.globl vector70
vector70:
  pushl $0
801066cd:	6a 00                	push   $0x0
  pushl $70
801066cf:	6a 46                	push   $0x46
  jmp alltraps
801066d1:	e9 31 f8 ff ff       	jmp    80105f07 <alltraps>

801066d6 <vector71>:
.globl vector71
vector71:
  pushl $0
801066d6:	6a 00                	push   $0x0
  pushl $71
801066d8:	6a 47                	push   $0x47
  jmp alltraps
801066da:	e9 28 f8 ff ff       	jmp    80105f07 <alltraps>

801066df <vector72>:
.globl vector72
vector72:
  pushl $0
801066df:	6a 00                	push   $0x0
  pushl $72
801066e1:	6a 48                	push   $0x48
  jmp alltraps
801066e3:	e9 1f f8 ff ff       	jmp    80105f07 <alltraps>

801066e8 <vector73>:
.globl vector73
vector73:
  pushl $0
801066e8:	6a 00                	push   $0x0
  pushl $73
801066ea:	6a 49                	push   $0x49
  jmp alltraps
801066ec:	e9 16 f8 ff ff       	jmp    80105f07 <alltraps>

801066f1 <vector74>:
.globl vector74
vector74:
  pushl $0
801066f1:	6a 00                	push   $0x0
  pushl $74
801066f3:	6a 4a                	push   $0x4a
  jmp alltraps
801066f5:	e9 0d f8 ff ff       	jmp    80105f07 <alltraps>

801066fa <vector75>:
.globl vector75
vector75:
  pushl $0
801066fa:	6a 00                	push   $0x0
  pushl $75
801066fc:	6a 4b                	push   $0x4b
  jmp alltraps
801066fe:	e9 04 f8 ff ff       	jmp    80105f07 <alltraps>

80106703 <vector76>:
.globl vector76
vector76:
  pushl $0
80106703:	6a 00                	push   $0x0
  pushl $76
80106705:	6a 4c                	push   $0x4c
  jmp alltraps
80106707:	e9 fb f7 ff ff       	jmp    80105f07 <alltraps>

8010670c <vector77>:
.globl vector77
vector77:
  pushl $0
8010670c:	6a 00                	push   $0x0
  pushl $77
8010670e:	6a 4d                	push   $0x4d
  jmp alltraps
80106710:	e9 f2 f7 ff ff       	jmp    80105f07 <alltraps>

80106715 <vector78>:
.globl vector78
vector78:
  pushl $0
80106715:	6a 00                	push   $0x0
  pushl $78
80106717:	6a 4e                	push   $0x4e
  jmp alltraps
80106719:	e9 e9 f7 ff ff       	jmp    80105f07 <alltraps>

8010671e <vector79>:
.globl vector79
vector79:
  pushl $0
8010671e:	6a 00                	push   $0x0
  pushl $79
80106720:	6a 4f                	push   $0x4f
  jmp alltraps
80106722:	e9 e0 f7 ff ff       	jmp    80105f07 <alltraps>

80106727 <vector80>:
.globl vector80
vector80:
  pushl $0
80106727:	6a 00                	push   $0x0
  pushl $80
80106729:	6a 50                	push   $0x50
  jmp alltraps
8010672b:	e9 d7 f7 ff ff       	jmp    80105f07 <alltraps>

80106730 <vector81>:
.globl vector81
vector81:
  pushl $0
80106730:	6a 00                	push   $0x0
  pushl $81
80106732:	6a 51                	push   $0x51
  jmp alltraps
80106734:	e9 ce f7 ff ff       	jmp    80105f07 <alltraps>

80106739 <vector82>:
.globl vector82
vector82:
  pushl $0
80106739:	6a 00                	push   $0x0
  pushl $82
8010673b:	6a 52                	push   $0x52
  jmp alltraps
8010673d:	e9 c5 f7 ff ff       	jmp    80105f07 <alltraps>

80106742 <vector83>:
.globl vector83
vector83:
  pushl $0
80106742:	6a 00                	push   $0x0
  pushl $83
80106744:	6a 53                	push   $0x53
  jmp alltraps
80106746:	e9 bc f7 ff ff       	jmp    80105f07 <alltraps>

8010674b <vector84>:
.globl vector84
vector84:
  pushl $0
8010674b:	6a 00                	push   $0x0
  pushl $84
8010674d:	6a 54                	push   $0x54
  jmp alltraps
8010674f:	e9 b3 f7 ff ff       	jmp    80105f07 <alltraps>

80106754 <vector85>:
.globl vector85
vector85:
  pushl $0
80106754:	6a 00                	push   $0x0
  pushl $85
80106756:	6a 55                	push   $0x55
  jmp alltraps
80106758:	e9 aa f7 ff ff       	jmp    80105f07 <alltraps>

8010675d <vector86>:
.globl vector86
vector86:
  pushl $0
8010675d:	6a 00                	push   $0x0
  pushl $86
8010675f:	6a 56                	push   $0x56
  jmp alltraps
80106761:	e9 a1 f7 ff ff       	jmp    80105f07 <alltraps>

80106766 <vector87>:
.globl vector87
vector87:
  pushl $0
80106766:	6a 00                	push   $0x0
  pushl $87
80106768:	6a 57                	push   $0x57
  jmp alltraps
8010676a:	e9 98 f7 ff ff       	jmp    80105f07 <alltraps>

8010676f <vector88>:
.globl vector88
vector88:
  pushl $0
8010676f:	6a 00                	push   $0x0
  pushl $88
80106771:	6a 58                	push   $0x58
  jmp alltraps
80106773:	e9 8f f7 ff ff       	jmp    80105f07 <alltraps>

80106778 <vector89>:
.globl vector89
vector89:
  pushl $0
80106778:	6a 00                	push   $0x0
  pushl $89
8010677a:	6a 59                	push   $0x59
  jmp alltraps
8010677c:	e9 86 f7 ff ff       	jmp    80105f07 <alltraps>

80106781 <vector90>:
.globl vector90
vector90:
  pushl $0
80106781:	6a 00                	push   $0x0
  pushl $90
80106783:	6a 5a                	push   $0x5a
  jmp alltraps
80106785:	e9 7d f7 ff ff       	jmp    80105f07 <alltraps>

8010678a <vector91>:
.globl vector91
vector91:
  pushl $0
8010678a:	6a 00                	push   $0x0
  pushl $91
8010678c:	6a 5b                	push   $0x5b
  jmp alltraps
8010678e:	e9 74 f7 ff ff       	jmp    80105f07 <alltraps>

80106793 <vector92>:
.globl vector92
vector92:
  pushl $0
80106793:	6a 00                	push   $0x0
  pushl $92
80106795:	6a 5c                	push   $0x5c
  jmp alltraps
80106797:	e9 6b f7 ff ff       	jmp    80105f07 <alltraps>

8010679c <vector93>:
.globl vector93
vector93:
  pushl $0
8010679c:	6a 00                	push   $0x0
  pushl $93
8010679e:	6a 5d                	push   $0x5d
  jmp alltraps
801067a0:	e9 62 f7 ff ff       	jmp    80105f07 <alltraps>

801067a5 <vector94>:
.globl vector94
vector94:
  pushl $0
801067a5:	6a 00                	push   $0x0
  pushl $94
801067a7:	6a 5e                	push   $0x5e
  jmp alltraps
801067a9:	e9 59 f7 ff ff       	jmp    80105f07 <alltraps>

801067ae <vector95>:
.globl vector95
vector95:
  pushl $0
801067ae:	6a 00                	push   $0x0
  pushl $95
801067b0:	6a 5f                	push   $0x5f
  jmp alltraps
801067b2:	e9 50 f7 ff ff       	jmp    80105f07 <alltraps>

801067b7 <vector96>:
.globl vector96
vector96:
  pushl $0
801067b7:	6a 00                	push   $0x0
  pushl $96
801067b9:	6a 60                	push   $0x60
  jmp alltraps
801067bb:	e9 47 f7 ff ff       	jmp    80105f07 <alltraps>

801067c0 <vector97>:
.globl vector97
vector97:
  pushl $0
801067c0:	6a 00                	push   $0x0
  pushl $97
801067c2:	6a 61                	push   $0x61
  jmp alltraps
801067c4:	e9 3e f7 ff ff       	jmp    80105f07 <alltraps>

801067c9 <vector98>:
.globl vector98
vector98:
  pushl $0
801067c9:	6a 00                	push   $0x0
  pushl $98
801067cb:	6a 62                	push   $0x62
  jmp alltraps
801067cd:	e9 35 f7 ff ff       	jmp    80105f07 <alltraps>

801067d2 <vector99>:
.globl vector99
vector99:
  pushl $0
801067d2:	6a 00                	push   $0x0
  pushl $99
801067d4:	6a 63                	push   $0x63
  jmp alltraps
801067d6:	e9 2c f7 ff ff       	jmp    80105f07 <alltraps>

801067db <vector100>:
.globl vector100
vector100:
  pushl $0
801067db:	6a 00                	push   $0x0
  pushl $100
801067dd:	6a 64                	push   $0x64
  jmp alltraps
801067df:	e9 23 f7 ff ff       	jmp    80105f07 <alltraps>

801067e4 <vector101>:
.globl vector101
vector101:
  pushl $0
801067e4:	6a 00                	push   $0x0
  pushl $101
801067e6:	6a 65                	push   $0x65
  jmp alltraps
801067e8:	e9 1a f7 ff ff       	jmp    80105f07 <alltraps>

801067ed <vector102>:
.globl vector102
vector102:
  pushl $0
801067ed:	6a 00                	push   $0x0
  pushl $102
801067ef:	6a 66                	push   $0x66
  jmp alltraps
801067f1:	e9 11 f7 ff ff       	jmp    80105f07 <alltraps>

801067f6 <vector103>:
.globl vector103
vector103:
  pushl $0
801067f6:	6a 00                	push   $0x0
  pushl $103
801067f8:	6a 67                	push   $0x67
  jmp alltraps
801067fa:	e9 08 f7 ff ff       	jmp    80105f07 <alltraps>

801067ff <vector104>:
.globl vector104
vector104:
  pushl $0
801067ff:	6a 00                	push   $0x0
  pushl $104
80106801:	6a 68                	push   $0x68
  jmp alltraps
80106803:	e9 ff f6 ff ff       	jmp    80105f07 <alltraps>

80106808 <vector105>:
.globl vector105
vector105:
  pushl $0
80106808:	6a 00                	push   $0x0
  pushl $105
8010680a:	6a 69                	push   $0x69
  jmp alltraps
8010680c:	e9 f6 f6 ff ff       	jmp    80105f07 <alltraps>

80106811 <vector106>:
.globl vector106
vector106:
  pushl $0
80106811:	6a 00                	push   $0x0
  pushl $106
80106813:	6a 6a                	push   $0x6a
  jmp alltraps
80106815:	e9 ed f6 ff ff       	jmp    80105f07 <alltraps>

8010681a <vector107>:
.globl vector107
vector107:
  pushl $0
8010681a:	6a 00                	push   $0x0
  pushl $107
8010681c:	6a 6b                	push   $0x6b
  jmp alltraps
8010681e:	e9 e4 f6 ff ff       	jmp    80105f07 <alltraps>

80106823 <vector108>:
.globl vector108
vector108:
  pushl $0
80106823:	6a 00                	push   $0x0
  pushl $108
80106825:	6a 6c                	push   $0x6c
  jmp alltraps
80106827:	e9 db f6 ff ff       	jmp    80105f07 <alltraps>

8010682c <vector109>:
.globl vector109
vector109:
  pushl $0
8010682c:	6a 00                	push   $0x0
  pushl $109
8010682e:	6a 6d                	push   $0x6d
  jmp alltraps
80106830:	e9 d2 f6 ff ff       	jmp    80105f07 <alltraps>

80106835 <vector110>:
.globl vector110
vector110:
  pushl $0
80106835:	6a 00                	push   $0x0
  pushl $110
80106837:	6a 6e                	push   $0x6e
  jmp alltraps
80106839:	e9 c9 f6 ff ff       	jmp    80105f07 <alltraps>

8010683e <vector111>:
.globl vector111
vector111:
  pushl $0
8010683e:	6a 00                	push   $0x0
  pushl $111
80106840:	6a 6f                	push   $0x6f
  jmp alltraps
80106842:	e9 c0 f6 ff ff       	jmp    80105f07 <alltraps>

80106847 <vector112>:
.globl vector112
vector112:
  pushl $0
80106847:	6a 00                	push   $0x0
  pushl $112
80106849:	6a 70                	push   $0x70
  jmp alltraps
8010684b:	e9 b7 f6 ff ff       	jmp    80105f07 <alltraps>

80106850 <vector113>:
.globl vector113
vector113:
  pushl $0
80106850:	6a 00                	push   $0x0
  pushl $113
80106852:	6a 71                	push   $0x71
  jmp alltraps
80106854:	e9 ae f6 ff ff       	jmp    80105f07 <alltraps>

80106859 <vector114>:
.globl vector114
vector114:
  pushl $0
80106859:	6a 00                	push   $0x0
  pushl $114
8010685b:	6a 72                	push   $0x72
  jmp alltraps
8010685d:	e9 a5 f6 ff ff       	jmp    80105f07 <alltraps>

80106862 <vector115>:
.globl vector115
vector115:
  pushl $0
80106862:	6a 00                	push   $0x0
  pushl $115
80106864:	6a 73                	push   $0x73
  jmp alltraps
80106866:	e9 9c f6 ff ff       	jmp    80105f07 <alltraps>

8010686b <vector116>:
.globl vector116
vector116:
  pushl $0
8010686b:	6a 00                	push   $0x0
  pushl $116
8010686d:	6a 74                	push   $0x74
  jmp alltraps
8010686f:	e9 93 f6 ff ff       	jmp    80105f07 <alltraps>

80106874 <vector117>:
.globl vector117
vector117:
  pushl $0
80106874:	6a 00                	push   $0x0
  pushl $117
80106876:	6a 75                	push   $0x75
  jmp alltraps
80106878:	e9 8a f6 ff ff       	jmp    80105f07 <alltraps>

8010687d <vector118>:
.globl vector118
vector118:
  pushl $0
8010687d:	6a 00                	push   $0x0
  pushl $118
8010687f:	6a 76                	push   $0x76
  jmp alltraps
80106881:	e9 81 f6 ff ff       	jmp    80105f07 <alltraps>

80106886 <vector119>:
.globl vector119
vector119:
  pushl $0
80106886:	6a 00                	push   $0x0
  pushl $119
80106888:	6a 77                	push   $0x77
  jmp alltraps
8010688a:	e9 78 f6 ff ff       	jmp    80105f07 <alltraps>

8010688f <vector120>:
.globl vector120
vector120:
  pushl $0
8010688f:	6a 00                	push   $0x0
  pushl $120
80106891:	6a 78                	push   $0x78
  jmp alltraps
80106893:	e9 6f f6 ff ff       	jmp    80105f07 <alltraps>

80106898 <vector121>:
.globl vector121
vector121:
  pushl $0
80106898:	6a 00                	push   $0x0
  pushl $121
8010689a:	6a 79                	push   $0x79
  jmp alltraps
8010689c:	e9 66 f6 ff ff       	jmp    80105f07 <alltraps>

801068a1 <vector122>:
.globl vector122
vector122:
  pushl $0
801068a1:	6a 00                	push   $0x0
  pushl $122
801068a3:	6a 7a                	push   $0x7a
  jmp alltraps
801068a5:	e9 5d f6 ff ff       	jmp    80105f07 <alltraps>

801068aa <vector123>:
.globl vector123
vector123:
  pushl $0
801068aa:	6a 00                	push   $0x0
  pushl $123
801068ac:	6a 7b                	push   $0x7b
  jmp alltraps
801068ae:	e9 54 f6 ff ff       	jmp    80105f07 <alltraps>

801068b3 <vector124>:
.globl vector124
vector124:
  pushl $0
801068b3:	6a 00                	push   $0x0
  pushl $124
801068b5:	6a 7c                	push   $0x7c
  jmp alltraps
801068b7:	e9 4b f6 ff ff       	jmp    80105f07 <alltraps>

801068bc <vector125>:
.globl vector125
vector125:
  pushl $0
801068bc:	6a 00                	push   $0x0
  pushl $125
801068be:	6a 7d                	push   $0x7d
  jmp alltraps
801068c0:	e9 42 f6 ff ff       	jmp    80105f07 <alltraps>

801068c5 <vector126>:
.globl vector126
vector126:
  pushl $0
801068c5:	6a 00                	push   $0x0
  pushl $126
801068c7:	6a 7e                	push   $0x7e
  jmp alltraps
801068c9:	e9 39 f6 ff ff       	jmp    80105f07 <alltraps>

801068ce <vector127>:
.globl vector127
vector127:
  pushl $0
801068ce:	6a 00                	push   $0x0
  pushl $127
801068d0:	6a 7f                	push   $0x7f
  jmp alltraps
801068d2:	e9 30 f6 ff ff       	jmp    80105f07 <alltraps>

801068d7 <vector128>:
.globl vector128
vector128:
  pushl $0
801068d7:	6a 00                	push   $0x0
  pushl $128
801068d9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801068de:	e9 24 f6 ff ff       	jmp    80105f07 <alltraps>

801068e3 <vector129>:
.globl vector129
vector129:
  pushl $0
801068e3:	6a 00                	push   $0x0
  pushl $129
801068e5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801068ea:	e9 18 f6 ff ff       	jmp    80105f07 <alltraps>

801068ef <vector130>:
.globl vector130
vector130:
  pushl $0
801068ef:	6a 00                	push   $0x0
  pushl $130
801068f1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801068f6:	e9 0c f6 ff ff       	jmp    80105f07 <alltraps>

801068fb <vector131>:
.globl vector131
vector131:
  pushl $0
801068fb:	6a 00                	push   $0x0
  pushl $131
801068fd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106902:	e9 00 f6 ff ff       	jmp    80105f07 <alltraps>

80106907 <vector132>:
.globl vector132
vector132:
  pushl $0
80106907:	6a 00                	push   $0x0
  pushl $132
80106909:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010690e:	e9 f4 f5 ff ff       	jmp    80105f07 <alltraps>

80106913 <vector133>:
.globl vector133
vector133:
  pushl $0
80106913:	6a 00                	push   $0x0
  pushl $133
80106915:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010691a:	e9 e8 f5 ff ff       	jmp    80105f07 <alltraps>

8010691f <vector134>:
.globl vector134
vector134:
  pushl $0
8010691f:	6a 00                	push   $0x0
  pushl $134
80106921:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106926:	e9 dc f5 ff ff       	jmp    80105f07 <alltraps>

8010692b <vector135>:
.globl vector135
vector135:
  pushl $0
8010692b:	6a 00                	push   $0x0
  pushl $135
8010692d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106932:	e9 d0 f5 ff ff       	jmp    80105f07 <alltraps>

80106937 <vector136>:
.globl vector136
vector136:
  pushl $0
80106937:	6a 00                	push   $0x0
  pushl $136
80106939:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010693e:	e9 c4 f5 ff ff       	jmp    80105f07 <alltraps>

80106943 <vector137>:
.globl vector137
vector137:
  pushl $0
80106943:	6a 00                	push   $0x0
  pushl $137
80106945:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010694a:	e9 b8 f5 ff ff       	jmp    80105f07 <alltraps>

8010694f <vector138>:
.globl vector138
vector138:
  pushl $0
8010694f:	6a 00                	push   $0x0
  pushl $138
80106951:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106956:	e9 ac f5 ff ff       	jmp    80105f07 <alltraps>

8010695b <vector139>:
.globl vector139
vector139:
  pushl $0
8010695b:	6a 00                	push   $0x0
  pushl $139
8010695d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106962:	e9 a0 f5 ff ff       	jmp    80105f07 <alltraps>

80106967 <vector140>:
.globl vector140
vector140:
  pushl $0
80106967:	6a 00                	push   $0x0
  pushl $140
80106969:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010696e:	e9 94 f5 ff ff       	jmp    80105f07 <alltraps>

80106973 <vector141>:
.globl vector141
vector141:
  pushl $0
80106973:	6a 00                	push   $0x0
  pushl $141
80106975:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010697a:	e9 88 f5 ff ff       	jmp    80105f07 <alltraps>

8010697f <vector142>:
.globl vector142
vector142:
  pushl $0
8010697f:	6a 00                	push   $0x0
  pushl $142
80106981:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106986:	e9 7c f5 ff ff       	jmp    80105f07 <alltraps>

8010698b <vector143>:
.globl vector143
vector143:
  pushl $0
8010698b:	6a 00                	push   $0x0
  pushl $143
8010698d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106992:	e9 70 f5 ff ff       	jmp    80105f07 <alltraps>

80106997 <vector144>:
.globl vector144
vector144:
  pushl $0
80106997:	6a 00                	push   $0x0
  pushl $144
80106999:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010699e:	e9 64 f5 ff ff       	jmp    80105f07 <alltraps>

801069a3 <vector145>:
.globl vector145
vector145:
  pushl $0
801069a3:	6a 00                	push   $0x0
  pushl $145
801069a5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801069aa:	e9 58 f5 ff ff       	jmp    80105f07 <alltraps>

801069af <vector146>:
.globl vector146
vector146:
  pushl $0
801069af:	6a 00                	push   $0x0
  pushl $146
801069b1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801069b6:	e9 4c f5 ff ff       	jmp    80105f07 <alltraps>

801069bb <vector147>:
.globl vector147
vector147:
  pushl $0
801069bb:	6a 00                	push   $0x0
  pushl $147
801069bd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801069c2:	e9 40 f5 ff ff       	jmp    80105f07 <alltraps>

801069c7 <vector148>:
.globl vector148
vector148:
  pushl $0
801069c7:	6a 00                	push   $0x0
  pushl $148
801069c9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801069ce:	e9 34 f5 ff ff       	jmp    80105f07 <alltraps>

801069d3 <vector149>:
.globl vector149
vector149:
  pushl $0
801069d3:	6a 00                	push   $0x0
  pushl $149
801069d5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801069da:	e9 28 f5 ff ff       	jmp    80105f07 <alltraps>

801069df <vector150>:
.globl vector150
vector150:
  pushl $0
801069df:	6a 00                	push   $0x0
  pushl $150
801069e1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801069e6:	e9 1c f5 ff ff       	jmp    80105f07 <alltraps>

801069eb <vector151>:
.globl vector151
vector151:
  pushl $0
801069eb:	6a 00                	push   $0x0
  pushl $151
801069ed:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801069f2:	e9 10 f5 ff ff       	jmp    80105f07 <alltraps>

801069f7 <vector152>:
.globl vector152
vector152:
  pushl $0
801069f7:	6a 00                	push   $0x0
  pushl $152
801069f9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801069fe:	e9 04 f5 ff ff       	jmp    80105f07 <alltraps>

80106a03 <vector153>:
.globl vector153
vector153:
  pushl $0
80106a03:	6a 00                	push   $0x0
  pushl $153
80106a05:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106a0a:	e9 f8 f4 ff ff       	jmp    80105f07 <alltraps>

80106a0f <vector154>:
.globl vector154
vector154:
  pushl $0
80106a0f:	6a 00                	push   $0x0
  pushl $154
80106a11:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106a16:	e9 ec f4 ff ff       	jmp    80105f07 <alltraps>

80106a1b <vector155>:
.globl vector155
vector155:
  pushl $0
80106a1b:	6a 00                	push   $0x0
  pushl $155
80106a1d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106a22:	e9 e0 f4 ff ff       	jmp    80105f07 <alltraps>

80106a27 <vector156>:
.globl vector156
vector156:
  pushl $0
80106a27:	6a 00                	push   $0x0
  pushl $156
80106a29:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106a2e:	e9 d4 f4 ff ff       	jmp    80105f07 <alltraps>

80106a33 <vector157>:
.globl vector157
vector157:
  pushl $0
80106a33:	6a 00                	push   $0x0
  pushl $157
80106a35:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106a3a:	e9 c8 f4 ff ff       	jmp    80105f07 <alltraps>

80106a3f <vector158>:
.globl vector158
vector158:
  pushl $0
80106a3f:	6a 00                	push   $0x0
  pushl $158
80106a41:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106a46:	e9 bc f4 ff ff       	jmp    80105f07 <alltraps>

80106a4b <vector159>:
.globl vector159
vector159:
  pushl $0
80106a4b:	6a 00                	push   $0x0
  pushl $159
80106a4d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106a52:	e9 b0 f4 ff ff       	jmp    80105f07 <alltraps>

80106a57 <vector160>:
.globl vector160
vector160:
  pushl $0
80106a57:	6a 00                	push   $0x0
  pushl $160
80106a59:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106a5e:	e9 a4 f4 ff ff       	jmp    80105f07 <alltraps>

80106a63 <vector161>:
.globl vector161
vector161:
  pushl $0
80106a63:	6a 00                	push   $0x0
  pushl $161
80106a65:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106a6a:	e9 98 f4 ff ff       	jmp    80105f07 <alltraps>

80106a6f <vector162>:
.globl vector162
vector162:
  pushl $0
80106a6f:	6a 00                	push   $0x0
  pushl $162
80106a71:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106a76:	e9 8c f4 ff ff       	jmp    80105f07 <alltraps>

80106a7b <vector163>:
.globl vector163
vector163:
  pushl $0
80106a7b:	6a 00                	push   $0x0
  pushl $163
80106a7d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106a82:	e9 80 f4 ff ff       	jmp    80105f07 <alltraps>

80106a87 <vector164>:
.globl vector164
vector164:
  pushl $0
80106a87:	6a 00                	push   $0x0
  pushl $164
80106a89:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106a8e:	e9 74 f4 ff ff       	jmp    80105f07 <alltraps>

80106a93 <vector165>:
.globl vector165
vector165:
  pushl $0
80106a93:	6a 00                	push   $0x0
  pushl $165
80106a95:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106a9a:	e9 68 f4 ff ff       	jmp    80105f07 <alltraps>

80106a9f <vector166>:
.globl vector166
vector166:
  pushl $0
80106a9f:	6a 00                	push   $0x0
  pushl $166
80106aa1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106aa6:	e9 5c f4 ff ff       	jmp    80105f07 <alltraps>

80106aab <vector167>:
.globl vector167
vector167:
  pushl $0
80106aab:	6a 00                	push   $0x0
  pushl $167
80106aad:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106ab2:	e9 50 f4 ff ff       	jmp    80105f07 <alltraps>

80106ab7 <vector168>:
.globl vector168
vector168:
  pushl $0
80106ab7:	6a 00                	push   $0x0
  pushl $168
80106ab9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106abe:	e9 44 f4 ff ff       	jmp    80105f07 <alltraps>

80106ac3 <vector169>:
.globl vector169
vector169:
  pushl $0
80106ac3:	6a 00                	push   $0x0
  pushl $169
80106ac5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106aca:	e9 38 f4 ff ff       	jmp    80105f07 <alltraps>

80106acf <vector170>:
.globl vector170
vector170:
  pushl $0
80106acf:	6a 00                	push   $0x0
  pushl $170
80106ad1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106ad6:	e9 2c f4 ff ff       	jmp    80105f07 <alltraps>

80106adb <vector171>:
.globl vector171
vector171:
  pushl $0
80106adb:	6a 00                	push   $0x0
  pushl $171
80106add:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106ae2:	e9 20 f4 ff ff       	jmp    80105f07 <alltraps>

80106ae7 <vector172>:
.globl vector172
vector172:
  pushl $0
80106ae7:	6a 00                	push   $0x0
  pushl $172
80106ae9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106aee:	e9 14 f4 ff ff       	jmp    80105f07 <alltraps>

80106af3 <vector173>:
.globl vector173
vector173:
  pushl $0
80106af3:	6a 00                	push   $0x0
  pushl $173
80106af5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106afa:	e9 08 f4 ff ff       	jmp    80105f07 <alltraps>

80106aff <vector174>:
.globl vector174
vector174:
  pushl $0
80106aff:	6a 00                	push   $0x0
  pushl $174
80106b01:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106b06:	e9 fc f3 ff ff       	jmp    80105f07 <alltraps>

80106b0b <vector175>:
.globl vector175
vector175:
  pushl $0
80106b0b:	6a 00                	push   $0x0
  pushl $175
80106b0d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106b12:	e9 f0 f3 ff ff       	jmp    80105f07 <alltraps>

80106b17 <vector176>:
.globl vector176
vector176:
  pushl $0
80106b17:	6a 00                	push   $0x0
  pushl $176
80106b19:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106b1e:	e9 e4 f3 ff ff       	jmp    80105f07 <alltraps>

80106b23 <vector177>:
.globl vector177
vector177:
  pushl $0
80106b23:	6a 00                	push   $0x0
  pushl $177
80106b25:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106b2a:	e9 d8 f3 ff ff       	jmp    80105f07 <alltraps>

80106b2f <vector178>:
.globl vector178
vector178:
  pushl $0
80106b2f:	6a 00                	push   $0x0
  pushl $178
80106b31:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106b36:	e9 cc f3 ff ff       	jmp    80105f07 <alltraps>

80106b3b <vector179>:
.globl vector179
vector179:
  pushl $0
80106b3b:	6a 00                	push   $0x0
  pushl $179
80106b3d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106b42:	e9 c0 f3 ff ff       	jmp    80105f07 <alltraps>

80106b47 <vector180>:
.globl vector180
vector180:
  pushl $0
80106b47:	6a 00                	push   $0x0
  pushl $180
80106b49:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106b4e:	e9 b4 f3 ff ff       	jmp    80105f07 <alltraps>

80106b53 <vector181>:
.globl vector181
vector181:
  pushl $0
80106b53:	6a 00                	push   $0x0
  pushl $181
80106b55:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106b5a:	e9 a8 f3 ff ff       	jmp    80105f07 <alltraps>

80106b5f <vector182>:
.globl vector182
vector182:
  pushl $0
80106b5f:	6a 00                	push   $0x0
  pushl $182
80106b61:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106b66:	e9 9c f3 ff ff       	jmp    80105f07 <alltraps>

80106b6b <vector183>:
.globl vector183
vector183:
  pushl $0
80106b6b:	6a 00                	push   $0x0
  pushl $183
80106b6d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106b72:	e9 90 f3 ff ff       	jmp    80105f07 <alltraps>

80106b77 <vector184>:
.globl vector184
vector184:
  pushl $0
80106b77:	6a 00                	push   $0x0
  pushl $184
80106b79:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106b7e:	e9 84 f3 ff ff       	jmp    80105f07 <alltraps>

80106b83 <vector185>:
.globl vector185
vector185:
  pushl $0
80106b83:	6a 00                	push   $0x0
  pushl $185
80106b85:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106b8a:	e9 78 f3 ff ff       	jmp    80105f07 <alltraps>

80106b8f <vector186>:
.globl vector186
vector186:
  pushl $0
80106b8f:	6a 00                	push   $0x0
  pushl $186
80106b91:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106b96:	e9 6c f3 ff ff       	jmp    80105f07 <alltraps>

80106b9b <vector187>:
.globl vector187
vector187:
  pushl $0
80106b9b:	6a 00                	push   $0x0
  pushl $187
80106b9d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106ba2:	e9 60 f3 ff ff       	jmp    80105f07 <alltraps>

80106ba7 <vector188>:
.globl vector188
vector188:
  pushl $0
80106ba7:	6a 00                	push   $0x0
  pushl $188
80106ba9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106bae:	e9 54 f3 ff ff       	jmp    80105f07 <alltraps>

80106bb3 <vector189>:
.globl vector189
vector189:
  pushl $0
80106bb3:	6a 00                	push   $0x0
  pushl $189
80106bb5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106bba:	e9 48 f3 ff ff       	jmp    80105f07 <alltraps>

80106bbf <vector190>:
.globl vector190
vector190:
  pushl $0
80106bbf:	6a 00                	push   $0x0
  pushl $190
80106bc1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106bc6:	e9 3c f3 ff ff       	jmp    80105f07 <alltraps>

80106bcb <vector191>:
.globl vector191
vector191:
  pushl $0
80106bcb:	6a 00                	push   $0x0
  pushl $191
80106bcd:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106bd2:	e9 30 f3 ff ff       	jmp    80105f07 <alltraps>

80106bd7 <vector192>:
.globl vector192
vector192:
  pushl $0
80106bd7:	6a 00                	push   $0x0
  pushl $192
80106bd9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106bde:	e9 24 f3 ff ff       	jmp    80105f07 <alltraps>

80106be3 <vector193>:
.globl vector193
vector193:
  pushl $0
80106be3:	6a 00                	push   $0x0
  pushl $193
80106be5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106bea:	e9 18 f3 ff ff       	jmp    80105f07 <alltraps>

80106bef <vector194>:
.globl vector194
vector194:
  pushl $0
80106bef:	6a 00                	push   $0x0
  pushl $194
80106bf1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106bf6:	e9 0c f3 ff ff       	jmp    80105f07 <alltraps>

80106bfb <vector195>:
.globl vector195
vector195:
  pushl $0
80106bfb:	6a 00                	push   $0x0
  pushl $195
80106bfd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106c02:	e9 00 f3 ff ff       	jmp    80105f07 <alltraps>

80106c07 <vector196>:
.globl vector196
vector196:
  pushl $0
80106c07:	6a 00                	push   $0x0
  pushl $196
80106c09:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106c0e:	e9 f4 f2 ff ff       	jmp    80105f07 <alltraps>

80106c13 <vector197>:
.globl vector197
vector197:
  pushl $0
80106c13:	6a 00                	push   $0x0
  pushl $197
80106c15:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106c1a:	e9 e8 f2 ff ff       	jmp    80105f07 <alltraps>

80106c1f <vector198>:
.globl vector198
vector198:
  pushl $0
80106c1f:	6a 00                	push   $0x0
  pushl $198
80106c21:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106c26:	e9 dc f2 ff ff       	jmp    80105f07 <alltraps>

80106c2b <vector199>:
.globl vector199
vector199:
  pushl $0
80106c2b:	6a 00                	push   $0x0
  pushl $199
80106c2d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106c32:	e9 d0 f2 ff ff       	jmp    80105f07 <alltraps>

80106c37 <vector200>:
.globl vector200
vector200:
  pushl $0
80106c37:	6a 00                	push   $0x0
  pushl $200
80106c39:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106c3e:	e9 c4 f2 ff ff       	jmp    80105f07 <alltraps>

80106c43 <vector201>:
.globl vector201
vector201:
  pushl $0
80106c43:	6a 00                	push   $0x0
  pushl $201
80106c45:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106c4a:	e9 b8 f2 ff ff       	jmp    80105f07 <alltraps>

80106c4f <vector202>:
.globl vector202
vector202:
  pushl $0
80106c4f:	6a 00                	push   $0x0
  pushl $202
80106c51:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106c56:	e9 ac f2 ff ff       	jmp    80105f07 <alltraps>

80106c5b <vector203>:
.globl vector203
vector203:
  pushl $0
80106c5b:	6a 00                	push   $0x0
  pushl $203
80106c5d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106c62:	e9 a0 f2 ff ff       	jmp    80105f07 <alltraps>

80106c67 <vector204>:
.globl vector204
vector204:
  pushl $0
80106c67:	6a 00                	push   $0x0
  pushl $204
80106c69:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106c6e:	e9 94 f2 ff ff       	jmp    80105f07 <alltraps>

80106c73 <vector205>:
.globl vector205
vector205:
  pushl $0
80106c73:	6a 00                	push   $0x0
  pushl $205
80106c75:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106c7a:	e9 88 f2 ff ff       	jmp    80105f07 <alltraps>

80106c7f <vector206>:
.globl vector206
vector206:
  pushl $0
80106c7f:	6a 00                	push   $0x0
  pushl $206
80106c81:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106c86:	e9 7c f2 ff ff       	jmp    80105f07 <alltraps>

80106c8b <vector207>:
.globl vector207
vector207:
  pushl $0
80106c8b:	6a 00                	push   $0x0
  pushl $207
80106c8d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106c92:	e9 70 f2 ff ff       	jmp    80105f07 <alltraps>

80106c97 <vector208>:
.globl vector208
vector208:
  pushl $0
80106c97:	6a 00                	push   $0x0
  pushl $208
80106c99:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106c9e:	e9 64 f2 ff ff       	jmp    80105f07 <alltraps>

80106ca3 <vector209>:
.globl vector209
vector209:
  pushl $0
80106ca3:	6a 00                	push   $0x0
  pushl $209
80106ca5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106caa:	e9 58 f2 ff ff       	jmp    80105f07 <alltraps>

80106caf <vector210>:
.globl vector210
vector210:
  pushl $0
80106caf:	6a 00                	push   $0x0
  pushl $210
80106cb1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106cb6:	e9 4c f2 ff ff       	jmp    80105f07 <alltraps>

80106cbb <vector211>:
.globl vector211
vector211:
  pushl $0
80106cbb:	6a 00                	push   $0x0
  pushl $211
80106cbd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106cc2:	e9 40 f2 ff ff       	jmp    80105f07 <alltraps>

80106cc7 <vector212>:
.globl vector212
vector212:
  pushl $0
80106cc7:	6a 00                	push   $0x0
  pushl $212
80106cc9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106cce:	e9 34 f2 ff ff       	jmp    80105f07 <alltraps>

80106cd3 <vector213>:
.globl vector213
vector213:
  pushl $0
80106cd3:	6a 00                	push   $0x0
  pushl $213
80106cd5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106cda:	e9 28 f2 ff ff       	jmp    80105f07 <alltraps>

80106cdf <vector214>:
.globl vector214
vector214:
  pushl $0
80106cdf:	6a 00                	push   $0x0
  pushl $214
80106ce1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106ce6:	e9 1c f2 ff ff       	jmp    80105f07 <alltraps>

80106ceb <vector215>:
.globl vector215
vector215:
  pushl $0
80106ceb:	6a 00                	push   $0x0
  pushl $215
80106ced:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106cf2:	e9 10 f2 ff ff       	jmp    80105f07 <alltraps>

80106cf7 <vector216>:
.globl vector216
vector216:
  pushl $0
80106cf7:	6a 00                	push   $0x0
  pushl $216
80106cf9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106cfe:	e9 04 f2 ff ff       	jmp    80105f07 <alltraps>

80106d03 <vector217>:
.globl vector217
vector217:
  pushl $0
80106d03:	6a 00                	push   $0x0
  pushl $217
80106d05:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106d0a:	e9 f8 f1 ff ff       	jmp    80105f07 <alltraps>

80106d0f <vector218>:
.globl vector218
vector218:
  pushl $0
80106d0f:	6a 00                	push   $0x0
  pushl $218
80106d11:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106d16:	e9 ec f1 ff ff       	jmp    80105f07 <alltraps>

80106d1b <vector219>:
.globl vector219
vector219:
  pushl $0
80106d1b:	6a 00                	push   $0x0
  pushl $219
80106d1d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106d22:	e9 e0 f1 ff ff       	jmp    80105f07 <alltraps>

80106d27 <vector220>:
.globl vector220
vector220:
  pushl $0
80106d27:	6a 00                	push   $0x0
  pushl $220
80106d29:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106d2e:	e9 d4 f1 ff ff       	jmp    80105f07 <alltraps>

80106d33 <vector221>:
.globl vector221
vector221:
  pushl $0
80106d33:	6a 00                	push   $0x0
  pushl $221
80106d35:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106d3a:	e9 c8 f1 ff ff       	jmp    80105f07 <alltraps>

80106d3f <vector222>:
.globl vector222
vector222:
  pushl $0
80106d3f:	6a 00                	push   $0x0
  pushl $222
80106d41:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106d46:	e9 bc f1 ff ff       	jmp    80105f07 <alltraps>

80106d4b <vector223>:
.globl vector223
vector223:
  pushl $0
80106d4b:	6a 00                	push   $0x0
  pushl $223
80106d4d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106d52:	e9 b0 f1 ff ff       	jmp    80105f07 <alltraps>

80106d57 <vector224>:
.globl vector224
vector224:
  pushl $0
80106d57:	6a 00                	push   $0x0
  pushl $224
80106d59:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106d5e:	e9 a4 f1 ff ff       	jmp    80105f07 <alltraps>

80106d63 <vector225>:
.globl vector225
vector225:
  pushl $0
80106d63:	6a 00                	push   $0x0
  pushl $225
80106d65:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106d6a:	e9 98 f1 ff ff       	jmp    80105f07 <alltraps>

80106d6f <vector226>:
.globl vector226
vector226:
  pushl $0
80106d6f:	6a 00                	push   $0x0
  pushl $226
80106d71:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106d76:	e9 8c f1 ff ff       	jmp    80105f07 <alltraps>

80106d7b <vector227>:
.globl vector227
vector227:
  pushl $0
80106d7b:	6a 00                	push   $0x0
  pushl $227
80106d7d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106d82:	e9 80 f1 ff ff       	jmp    80105f07 <alltraps>

80106d87 <vector228>:
.globl vector228
vector228:
  pushl $0
80106d87:	6a 00                	push   $0x0
  pushl $228
80106d89:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106d8e:	e9 74 f1 ff ff       	jmp    80105f07 <alltraps>

80106d93 <vector229>:
.globl vector229
vector229:
  pushl $0
80106d93:	6a 00                	push   $0x0
  pushl $229
80106d95:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106d9a:	e9 68 f1 ff ff       	jmp    80105f07 <alltraps>

80106d9f <vector230>:
.globl vector230
vector230:
  pushl $0
80106d9f:	6a 00                	push   $0x0
  pushl $230
80106da1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106da6:	e9 5c f1 ff ff       	jmp    80105f07 <alltraps>

80106dab <vector231>:
.globl vector231
vector231:
  pushl $0
80106dab:	6a 00                	push   $0x0
  pushl $231
80106dad:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106db2:	e9 50 f1 ff ff       	jmp    80105f07 <alltraps>

80106db7 <vector232>:
.globl vector232
vector232:
  pushl $0
80106db7:	6a 00                	push   $0x0
  pushl $232
80106db9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106dbe:	e9 44 f1 ff ff       	jmp    80105f07 <alltraps>

80106dc3 <vector233>:
.globl vector233
vector233:
  pushl $0
80106dc3:	6a 00                	push   $0x0
  pushl $233
80106dc5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106dca:	e9 38 f1 ff ff       	jmp    80105f07 <alltraps>

80106dcf <vector234>:
.globl vector234
vector234:
  pushl $0
80106dcf:	6a 00                	push   $0x0
  pushl $234
80106dd1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106dd6:	e9 2c f1 ff ff       	jmp    80105f07 <alltraps>

80106ddb <vector235>:
.globl vector235
vector235:
  pushl $0
80106ddb:	6a 00                	push   $0x0
  pushl $235
80106ddd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106de2:	e9 20 f1 ff ff       	jmp    80105f07 <alltraps>

80106de7 <vector236>:
.globl vector236
vector236:
  pushl $0
80106de7:	6a 00                	push   $0x0
  pushl $236
80106de9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106dee:	e9 14 f1 ff ff       	jmp    80105f07 <alltraps>

80106df3 <vector237>:
.globl vector237
vector237:
  pushl $0
80106df3:	6a 00                	push   $0x0
  pushl $237
80106df5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106dfa:	e9 08 f1 ff ff       	jmp    80105f07 <alltraps>

80106dff <vector238>:
.globl vector238
vector238:
  pushl $0
80106dff:	6a 00                	push   $0x0
  pushl $238
80106e01:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106e06:	e9 fc f0 ff ff       	jmp    80105f07 <alltraps>

80106e0b <vector239>:
.globl vector239
vector239:
  pushl $0
80106e0b:	6a 00                	push   $0x0
  pushl $239
80106e0d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106e12:	e9 f0 f0 ff ff       	jmp    80105f07 <alltraps>

80106e17 <vector240>:
.globl vector240
vector240:
  pushl $0
80106e17:	6a 00                	push   $0x0
  pushl $240
80106e19:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106e1e:	e9 e4 f0 ff ff       	jmp    80105f07 <alltraps>

80106e23 <vector241>:
.globl vector241
vector241:
  pushl $0
80106e23:	6a 00                	push   $0x0
  pushl $241
80106e25:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106e2a:	e9 d8 f0 ff ff       	jmp    80105f07 <alltraps>

80106e2f <vector242>:
.globl vector242
vector242:
  pushl $0
80106e2f:	6a 00                	push   $0x0
  pushl $242
80106e31:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106e36:	e9 cc f0 ff ff       	jmp    80105f07 <alltraps>

80106e3b <vector243>:
.globl vector243
vector243:
  pushl $0
80106e3b:	6a 00                	push   $0x0
  pushl $243
80106e3d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106e42:	e9 c0 f0 ff ff       	jmp    80105f07 <alltraps>

80106e47 <vector244>:
.globl vector244
vector244:
  pushl $0
80106e47:	6a 00                	push   $0x0
  pushl $244
80106e49:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106e4e:	e9 b4 f0 ff ff       	jmp    80105f07 <alltraps>

80106e53 <vector245>:
.globl vector245
vector245:
  pushl $0
80106e53:	6a 00                	push   $0x0
  pushl $245
80106e55:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106e5a:	e9 a8 f0 ff ff       	jmp    80105f07 <alltraps>

80106e5f <vector246>:
.globl vector246
vector246:
  pushl $0
80106e5f:	6a 00                	push   $0x0
  pushl $246
80106e61:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106e66:	e9 9c f0 ff ff       	jmp    80105f07 <alltraps>

80106e6b <vector247>:
.globl vector247
vector247:
  pushl $0
80106e6b:	6a 00                	push   $0x0
  pushl $247
80106e6d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106e72:	e9 90 f0 ff ff       	jmp    80105f07 <alltraps>

80106e77 <vector248>:
.globl vector248
vector248:
  pushl $0
80106e77:	6a 00                	push   $0x0
  pushl $248
80106e79:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106e7e:	e9 84 f0 ff ff       	jmp    80105f07 <alltraps>

80106e83 <vector249>:
.globl vector249
vector249:
  pushl $0
80106e83:	6a 00                	push   $0x0
  pushl $249
80106e85:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106e8a:	e9 78 f0 ff ff       	jmp    80105f07 <alltraps>

80106e8f <vector250>:
.globl vector250
vector250:
  pushl $0
80106e8f:	6a 00                	push   $0x0
  pushl $250
80106e91:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106e96:	e9 6c f0 ff ff       	jmp    80105f07 <alltraps>

80106e9b <vector251>:
.globl vector251
vector251:
  pushl $0
80106e9b:	6a 00                	push   $0x0
  pushl $251
80106e9d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106ea2:	e9 60 f0 ff ff       	jmp    80105f07 <alltraps>

80106ea7 <vector252>:
.globl vector252
vector252:
  pushl $0
80106ea7:	6a 00                	push   $0x0
  pushl $252
80106ea9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106eae:	e9 54 f0 ff ff       	jmp    80105f07 <alltraps>

80106eb3 <vector253>:
.globl vector253
vector253:
  pushl $0
80106eb3:	6a 00                	push   $0x0
  pushl $253
80106eb5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106eba:	e9 48 f0 ff ff       	jmp    80105f07 <alltraps>

80106ebf <vector254>:
.globl vector254
vector254:
  pushl $0
80106ebf:	6a 00                	push   $0x0
  pushl $254
80106ec1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106ec6:	e9 3c f0 ff ff       	jmp    80105f07 <alltraps>

80106ecb <vector255>:
.globl vector255
vector255:
  pushl $0
80106ecb:	6a 00                	push   $0x0
  pushl $255
80106ecd:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106ed2:	e9 30 f0 ff ff       	jmp    80105f07 <alltraps>
80106ed7:	66 90                	xchg   %ax,%ax
80106ed9:	66 90                	xchg   %ax,%ax
80106edb:	66 90                	xchg   %ax,%ax
80106edd:	66 90                	xchg   %ax,%ax
80106edf:	90                   	nop

80106ee0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106ee0:	55                   	push   %ebp
80106ee1:	89 e5                	mov    %esp,%ebp
80106ee3:	83 ec 28             	sub    $0x28,%esp
80106ee6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106ee9:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106eef:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106ef5:	39 d3                	cmp    %edx,%ebx
80106ef7:	73 72                	jae    80106f6b <deallocuvm.part.0+0x8b>
80106ef9:	89 75 f8             	mov    %esi,-0x8(%ebp)
80106efc:	89 c6                	mov    %eax,%esi
80106efe:	89 7d fc             	mov    %edi,-0x4(%ebp)
80106f01:	89 d7                	mov    %edx,%edi
80106f03:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80106f06:	eb 22                	jmp    80106f2a <deallocuvm.part.0+0x4a>
80106f08:	eb 16                	jmp    80106f20 <deallocuvm.part.0+0x40>
80106f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106f10:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106f17:	00 
80106f18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106f1f:	00 
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106f20:	8d 5a 01             	lea    0x1(%edx),%ebx
80106f23:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106f26:	39 fb                	cmp    %edi,%ebx
80106f28:	73 38                	jae    80106f62 <deallocuvm.part.0+0x82>
  pde = &pgdir[PDX(va)];
80106f2a:	89 da                	mov    %ebx,%edx
80106f2c:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80106f2f:	8b 04 96             	mov    (%esi,%edx,4),%eax
80106f32:	a8 01                	test   $0x1,%al
80106f34:	74 ea                	je     80106f20 <deallocuvm.part.0+0x40>
  return &pgtab[PTX(va)];
80106f36:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106f38:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106f3d:	c1 e9 0a             	shr    $0xa,%ecx
80106f40:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
80106f46:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
80106f4d:	85 c0                	test   %eax,%eax
80106f4f:	74 cf                	je     80106f20 <deallocuvm.part.0+0x40>
    else if((*pte & PTE_P) != 0){
80106f51:	8b 10                	mov    (%eax),%edx
80106f53:	f6 c2 01             	test   $0x1,%dl
80106f56:	75 20                	jne    80106f78 <deallocuvm.part.0+0x98>
  for(; a  < oldsz; a += PGSIZE){
80106f58:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106f5e:	39 fb                	cmp    %edi,%ebx
80106f60:	72 c8                	jb     80106f2a <deallocuvm.part.0+0x4a>
80106f62:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80106f65:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106f68:	8b 7d fc             	mov    -0x4(%ebp),%edi
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106f6b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80106f6e:	89 c8                	mov    %ecx,%eax
80106f70:	c9                   	leave
80106f71:	c3                   	ret
80106f72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(pa == 0)
80106f78:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106f7e:	74 26                	je     80106fa6 <deallocuvm.part.0+0xc6>
      kfree(v);
80106f80:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106f83:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106f89:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106f8c:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80106f92:	52                   	push   %edx
80106f93:	e8 a8 b6 ff ff       	call   80102640 <kfree>
      *pte = 0;
80106f98:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(; a  < oldsz; a += PGSIZE){
80106f9b:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80106f9e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80106fa4:	eb 80                	jmp    80106f26 <deallocuvm.part.0+0x46>
        panic("kfree");
80106fa6:	83 ec 0c             	sub    $0xc,%esp
80106fa9:	68 cc 7a 10 80       	push   $0x80107acc
80106fae:	e8 ed 93 ff ff       	call   801003a0 <panic>
80106fb3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80106fb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106fbf:	00 

80106fc0 <mappages>:
{
80106fc0:	55                   	push   %ebp
80106fc1:	89 e5                	mov    %esp,%ebp
80106fc3:	57                   	push   %edi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106fc4:	8d 7c 0a ff          	lea    -0x1(%edx,%ecx,1),%edi
{
80106fc8:	56                   	push   %esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106fc9:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80106fcf:	89 c6                	mov    %eax,%esi
{
80106fd1:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106fd2:	89 d3                	mov    %edx,%ebx
80106fd4:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106fda:	83 ec 1c             	sub    $0x1c,%esp
80106fdd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106fe0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106fe3:	29 d9                	sub    %ebx,%ecx
80106fe5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80106fe8:	eb 42                	jmp    8010702c <mappages+0x6c>
80106fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106ff0:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106ff2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106ff7:	c1 ea 0a             	shr    $0xa,%edx
80106ffa:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107000:	8d 94 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%edx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107007:	85 d2                	test   %edx,%edx
80107009:	74 6d                	je     80107078 <mappages+0xb8>
    if(*pte & PTE_P)
8010700b:	f6 02 01             	testb  $0x1,(%edx)
8010700e:	0f 85 7e 00 00 00    	jne    80107092 <mappages+0xd2>
    *pte = pa | perm | PTE_P;
80107014:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107017:	01 d8                	add    %ebx,%eax
80107019:	0b 45 0c             	or     0xc(%ebp),%eax
8010701c:	83 c8 01             	or     $0x1,%eax
8010701f:	89 02                	mov    %eax,(%edx)
    if(a == last)
80107021:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
80107024:	74 62                	je     80107088 <mappages+0xc8>
    a += PGSIZE;
80107026:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pde = &pgdir[PDX(va)];
8010702c:	89 d8                	mov    %ebx,%eax
8010702e:	c1 e8 16             	shr    $0x16,%eax
80107031:	8d 3c 86             	lea    (%esi,%eax,4),%edi
  if(*pde & PTE_P){
80107034:	8b 07                	mov    (%edi),%eax
80107036:	a8 01                	test   $0x1,%al
80107038:	75 b6                	jne    80106ff0 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
8010703a:	e8 d1 b7 ff ff       	call   80102810 <kalloc>
8010703f:	85 c0                	test   %eax,%eax
80107041:	74 35                	je     80107078 <mappages+0xb8>
    memset(pgtab, 0, PGSIZE);
80107043:	83 ec 04             	sub    $0x4,%esp
80107046:	68 00 10 00 00       	push   $0x1000
8010704b:	6a 00                	push   $0x0
8010704d:	50                   	push   %eax
8010704e:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107051:	e8 2a db ff ff       	call   80104b80 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107056:	8b 55 dc             	mov    -0x24(%ebp),%edx
  return &pgtab[PTX(va)];
80107059:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010705c:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80107062:	83 c8 07             	or     $0x7,%eax
80107065:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80107067:	89 d8                	mov    %ebx,%eax
80107069:	c1 e8 0a             	shr    $0xa,%eax
8010706c:	25 fc 0f 00 00       	and    $0xffc,%eax
80107071:	01 c2                	add    %eax,%edx
80107073:	eb 96                	jmp    8010700b <mappages+0x4b>
80107075:	8d 76 00             	lea    0x0(%esi),%esi
}
80107078:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010707b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107080:	5b                   	pop    %ebx
80107081:	5e                   	pop    %esi
80107082:	5f                   	pop    %edi
80107083:	5d                   	pop    %ebp
80107084:	c3                   	ret
80107085:	8d 76 00             	lea    0x0(%esi),%esi
80107088:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010708b:	31 c0                	xor    %eax,%eax
}
8010708d:	5b                   	pop    %ebx
8010708e:	5e                   	pop    %esi
8010708f:	5f                   	pop    %edi
80107090:	5d                   	pop    %ebp
80107091:	c3                   	ret
      panic("remap");
80107092:	83 ec 0c             	sub    $0xc,%esp
80107095:	68 09 7d 10 80       	push   $0x80107d09
8010709a:	e8 01 93 ff ff       	call   801003a0 <panic>
8010709f:	90                   	nop

801070a0 <seginit>:
{
801070a0:	55                   	push   %ebp
801070a1:	89 e5                	mov    %esp,%ebp
801070a3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801070a6:	e8 d5 ca ff ff       	call   80103b80 <cpuid>
  pd[0] = size-1;
801070ab:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801070b0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801070b6:	c7 80 18 28 11 80 ff 	movl   $0xffff,-0x7feed7e8(%eax)
801070bd:	ff 00 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801070c0:	c7 80 20 28 11 80 ff 	movl   $0xffff,-0x7feed7e0(%eax)
801070c7:	ff 00 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801070ca:	c7 80 28 28 11 80 ff 	movl   $0xffff,-0x7feed7d8(%eax)
801070d1:	ff 00 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801070d4:	c7 80 30 28 11 80 ff 	movl   $0xffff,-0x7feed7d0(%eax)
801070db:	ff 00 00 
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801070de:	c7 80 1c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7e4(%eax)
801070e5:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801070e8:	c7 80 24 28 11 80 00 	movl   $0xcf9200,-0x7feed7dc(%eax)
801070ef:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801070f2:	c7 80 2c 28 11 80 00 	movl   $0xcffa00,-0x7feed7d4(%eax)
801070f9:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801070fc:	c7 80 34 28 11 80 00 	movl   $0xcff200,-0x7feed7cc(%eax)
80107103:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80107106:	05 10 28 11 80       	add    $0x80112810,%eax
8010710b:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
8010710f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107113:	c1 e8 10             	shr    $0x10,%eax
80107116:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010711a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010711d:	0f 01 10             	lgdtl  (%eax)
}
80107120:	c9                   	leave
80107121:	c3                   	ret
80107122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107128:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010712f:	00 

80107130 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107130:	a1 44 55 11 80       	mov    0x80115544,%eax
80107135:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010713a:	0f 22 d8             	mov    %eax,%cr3
}
8010713d:	c3                   	ret
8010713e:	66 90                	xchg   %ax,%ax

80107140 <switchuvm>:
{
80107140:	55                   	push   %ebp
80107141:	89 e5                	mov    %esp,%ebp
80107143:	57                   	push   %edi
80107144:	56                   	push   %esi
80107145:	53                   	push   %ebx
80107146:	83 ec 1c             	sub    $0x1c,%esp
80107149:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
8010714c:	85 db                	test   %ebx,%ebx
8010714e:	0f 84 c9 00 00 00    	je     8010721d <switchuvm+0xdd>
  if(p->kstack == 0)
80107154:	8b 43 08             	mov    0x8(%ebx),%eax
80107157:	85 c0                	test   %eax,%eax
80107159:	0f 84 d8 00 00 00    	je     80107237 <switchuvm+0xf7>
  if(p->pgdir == 0)
8010715f:	8b 43 04             	mov    0x4(%ebx),%eax
80107162:	85 c0                	test   %eax,%eax
80107164:	0f 84 c0 00 00 00    	je     8010722a <switchuvm+0xea>
  pushcli();
8010716a:	e8 91 d7 ff ff       	call   80104900 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010716f:	e8 8c c9 ff ff       	call   80103b00 <mycpu>
80107174:	89 c6                	mov    %eax,%esi
80107176:	e8 85 c9 ff ff       	call   80103b00 <mycpu>
8010717b:	8d 78 08             	lea    0x8(%eax),%edi
8010717e:	e8 7d c9 ff ff       	call   80103b00 <mycpu>
80107183:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107186:	e8 75 c9 ff ff       	call   80103b00 <mycpu>
8010718b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010718e:	ba 67 00 00 00       	mov    $0x67,%edx
80107193:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
8010719a:	83 c0 08             	add    $0x8,%eax
8010719d:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801071a4:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801071a9:	83 c1 08             	add    $0x8,%ecx
801071ac:	c1 e8 18             	shr    $0x18,%eax
801071af:	c1 e9 10             	shr    $0x10,%ecx
801071b2:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
801071b8:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
801071be:	b9 99 40 00 00       	mov    $0x4099,%ecx
801071c3:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801071ca:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
801071cf:	e8 2c c9 ff ff       	call   80103b00 <mycpu>
801071d4:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801071db:	e8 20 c9 ff ff       	call   80103b00 <mycpu>
801071e0:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801071e4:	8b 73 08             	mov    0x8(%ebx),%esi
801071e7:	81 c6 00 10 00 00    	add    $0x1000,%esi
801071ed:	e8 0e c9 ff ff       	call   80103b00 <mycpu>
801071f2:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801071f5:	e8 06 c9 ff ff       	call   80103b00 <mycpu>
801071fa:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801071fe:	b8 28 00 00 00       	mov    $0x28,%eax
80107203:	0f 00 d8             	ltr    %eax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107206:	8b 43 04             	mov    0x4(%ebx),%eax
80107209:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010720e:	0f 22 d8             	mov    %eax,%cr3
}
80107211:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107214:	5b                   	pop    %ebx
80107215:	5e                   	pop    %esi
80107216:	5f                   	pop    %edi
80107217:	5d                   	pop    %ebp
  popcli();
80107218:	e9 33 d7 ff ff       	jmp    80104950 <popcli>
    panic("switchuvm: no process");
8010721d:	83 ec 0c             	sub    $0xc,%esp
80107220:	68 0f 7d 10 80       	push   $0x80107d0f
80107225:	e8 76 91 ff ff       	call   801003a0 <panic>
    panic("switchuvm: no pgdir");
8010722a:	83 ec 0c             	sub    $0xc,%esp
8010722d:	68 3a 7d 10 80       	push   $0x80107d3a
80107232:	e8 69 91 ff ff       	call   801003a0 <panic>
    panic("switchuvm: no kstack");
80107237:	83 ec 0c             	sub    $0xc,%esp
8010723a:	68 25 7d 10 80       	push   $0x80107d25
8010723f:	e8 5c 91 ff ff       	call   801003a0 <panic>
80107244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107248:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010724f:	00 

80107250 <inituvm>:
{
80107250:	55                   	push   %ebp
80107251:	89 e5                	mov    %esp,%ebp
80107253:	57                   	push   %edi
80107254:	56                   	push   %esi
80107255:	53                   	push   %ebx
80107256:	83 ec 1c             	sub    $0x1c,%esp
80107259:	8b 45 08             	mov    0x8(%ebp),%eax
8010725c:	8b 75 10             	mov    0x10(%ebp),%esi
8010725f:	8b 7d 0c             	mov    0xc(%ebp),%edi
80107262:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107265:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010726b:	77 49                	ja     801072b6 <inituvm+0x66>
  mem = kalloc();
8010726d:	e8 9e b5 ff ff       	call   80102810 <kalloc>
  memset(mem, 0, PGSIZE);
80107272:	83 ec 04             	sub    $0x4,%esp
80107275:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010727a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
8010727c:	6a 00                	push   $0x0
8010727e:	50                   	push   %eax
8010727f:	e8 fc d8 ff ff       	call   80104b80 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107284:	58                   	pop    %eax
80107285:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010728b:	5a                   	pop    %edx
8010728c:	6a 06                	push   $0x6
8010728e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107293:	31 d2                	xor    %edx,%edx
80107295:	50                   	push   %eax
80107296:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107299:	e8 22 fd ff ff       	call   80106fc0 <mappages>
  memmove(mem, init, sz);
8010729e:	83 c4 10             	add    $0x10,%esp
801072a1:	89 75 10             	mov    %esi,0x10(%ebp)
801072a4:	89 7d 0c             	mov    %edi,0xc(%ebp)
801072a7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801072aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072ad:	5b                   	pop    %ebx
801072ae:	5e                   	pop    %esi
801072af:	5f                   	pop    %edi
801072b0:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801072b1:	e9 6a d9 ff ff       	jmp    80104c20 <memmove>
    panic("inituvm: more than a page");
801072b6:	83 ec 0c             	sub    $0xc,%esp
801072b9:	68 4e 7d 10 80       	push   $0x80107d4e
801072be:	e8 dd 90 ff ff       	call   801003a0 <panic>
801072c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801072c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801072cf:	00 

801072d0 <loaduvm>:
{
801072d0:	55                   	push   %ebp
801072d1:	89 e5                	mov    %esp,%ebp
801072d3:	83 ec 18             	sub    $0x18,%esp
801072d6:	89 75 f8             	mov    %esi,-0x8(%ebp)
  if((uint) addr % PGSIZE != 0)
801072d9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
801072dc:	89 7d fc             	mov    %edi,-0x4(%ebp)
801072df:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
801072e2:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
801072e8:	0f 85 b2 00 00 00    	jne    801073a0 <loaduvm+0xd0>
  for(i = 0; i < sz; i += PGSIZE){
801072ee:	85 ff                	test   %edi,%edi
801072f0:	0f 84 89 00 00 00    	je     8010737f <loaduvm+0xaf>
801072f6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801072f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
80107300:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107303:	8b 55 08             	mov    0x8(%ebp),%edx
80107306:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
80107308:	89 c1                	mov    %eax,%ecx
8010730a:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010730d:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
80107310:	f6 c1 01             	test   $0x1,%cl
80107313:	75 13                	jne    80107328 <loaduvm+0x58>
      panic("loaduvm: address should exist");
80107315:	83 ec 0c             	sub    $0xc,%esp
80107318:	68 68 7d 10 80       	push   $0x80107d68
8010731d:	e8 7e 90 ff ff       	call   801003a0 <panic>
80107322:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107328:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010732b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107331:	25 fc 0f 00 00       	and    $0xffc,%eax
80107336:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010733d:	85 c9                	test   %ecx,%ecx
8010733f:	74 d4                	je     80107315 <loaduvm+0x45>
    if(sz - i < PGSIZE)
80107341:	89 fb                	mov    %edi,%ebx
80107343:	b8 00 10 00 00       	mov    $0x1000,%eax
80107348:	29 f3                	sub    %esi,%ebx
8010734a:	39 c3                	cmp    %eax,%ebx
8010734c:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010734f:	8b 45 14             	mov    0x14(%ebp),%eax
80107352:	01 f0                	add    %esi,%eax
80107354:	53                   	push   %ebx
80107355:	50                   	push   %eax
    pa = PTE_ADDR(*pte);
80107356:	8b 01                	mov    (%ecx),%eax
80107358:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010735d:	05 00 00 00 80       	add    $0x80000000,%eax
80107362:	50                   	push   %eax
80107363:	ff 75 10             	push   0x10(%ebp)
80107366:	e8 25 a8 ff ff       	call   80101b90 <readi>
8010736b:	83 c4 10             	add    $0x10,%esp
8010736e:	39 d8                	cmp    %ebx,%eax
80107370:	75 1e                	jne    80107390 <loaduvm+0xc0>
  for(i = 0; i < sz; i += PGSIZE){
80107372:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107378:	39 fe                	cmp    %edi,%esi
8010737a:	72 84                	jb     80107300 <loaduvm+0x30>
8010737c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
}
8010737f:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107382:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return 0;
80107385:	31 c0                	xor    %eax,%eax
}
80107387:	c9                   	leave
80107388:	c3                   	ret
80107389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80107390:	8b 5d f4             	mov    -0xc(%ebp),%ebx
}
80107393:	8b 75 f8             	mov    -0x8(%ebp),%esi
      return -1;
80107396:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010739b:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010739e:	c9                   	leave
8010739f:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
801073a0:	83 ec 0c             	sub    $0xc,%esp
801073a3:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801073a6:	68 6c 7f 10 80       	push   $0x80107f6c
801073ab:	e8 f0 8f ff ff       	call   801003a0 <panic>

801073b0 <allocuvm>:
{
801073b0:	55                   	push   %ebp
801073b1:	89 e5                	mov    %esp,%ebp
801073b3:	83 ec 28             	sub    $0x28,%esp
801073b6:	89 75 f8             	mov    %esi,-0x8(%ebp)
801073b9:	8b 75 10             	mov    0x10(%ebp),%esi
  if(newsz >= KERNBASE)
801073bc:	85 f6                	test   %esi,%esi
801073be:	0f 88 ac 00 00 00    	js     80107470 <allocuvm+0xc0>
801073c4:	89 f2                	mov    %esi,%edx
  if(newsz < oldsz)
801073c6:	3b 75 0c             	cmp    0xc(%ebp),%esi
801073c9:	0f 82 b1 00 00 00    	jb     80107480 <allocuvm+0xd0>
  a = PGROUNDUP(oldsz);
801073cf:	8b 45 0c             	mov    0xc(%ebp),%eax
801073d2:	89 7d fc             	mov    %edi,-0x4(%ebp)
801073d5:	05 ff 0f 00 00       	add    $0xfff,%eax
801073da:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801073df:	89 c7                	mov    %eax,%edi
  for(; a < newsz; a += PGSIZE){
801073e1:	39 f0                	cmp    %esi,%eax
801073e3:	0f 83 ff 00 00 00    	jae    801074e8 <allocuvm+0x138>
801073e9:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801073ec:	89 75 e4             	mov    %esi,-0x1c(%ebp)
801073ef:	eb 47                	jmp    80107438 <allocuvm+0x88>
801073f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
801073f8:	83 ec 04             	sub    $0x4,%esp
801073fb:	68 00 10 00 00       	push   $0x1000
80107400:	6a 00                	push   $0x0
80107402:	50                   	push   %eax
80107403:	e8 78 d7 ff ff       	call   80104b80 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107408:	58                   	pop    %eax
80107409:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010740f:	5a                   	pop    %edx
80107410:	6a 06                	push   $0x6
80107412:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107417:	89 fa                	mov    %edi,%edx
80107419:	50                   	push   %eax
8010741a:	8b 45 08             	mov    0x8(%ebp),%eax
8010741d:	e8 9e fb ff ff       	call   80106fc0 <mappages>
80107422:	83 c4 10             	add    $0x10,%esp
80107425:	83 f8 ff             	cmp    $0xffffffff,%eax
80107428:	74 66                	je     80107490 <allocuvm+0xe0>
  for(; a < newsz; a += PGSIZE){
8010742a:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107430:	39 f7                	cmp    %esi,%edi
80107432:	0f 83 98 00 00 00    	jae    801074d0 <allocuvm+0x120>
    mem = kalloc();
80107438:	e8 d3 b3 ff ff       	call   80102810 <kalloc>
8010743d:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
8010743f:	85 c0                	test   %eax,%eax
80107441:	75 b5                	jne    801073f8 <allocuvm+0x48>
      cprintf("allocuvm out of memory\n");
80107443:	83 ec 0c             	sub    $0xc,%esp
80107446:	68 86 7d 10 80       	push   $0x80107d86
8010744b:	e8 a0 92 ff ff       	call   801006f0 <cprintf>
  if(newsz >= oldsz)
80107450:	83 c4 10             	add    $0x10,%esp
80107453:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107456:	0f 84 84 00 00 00    	je     801074e0 <allocuvm+0x130>
  a = PGROUNDUP(newsz);
8010745c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010745f:	8b 45 08             	mov    0x8(%ebp),%eax
80107462:	89 f2                	mov    %esi,%edx
80107464:	e8 77 fa ff ff       	call   80106ee0 <deallocuvm.part.0>
80107469:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010746c:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010746f:	90                   	nop
    return 0;
80107470:	31 d2                	xor    %edx,%edx
}
80107472:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107475:	89 d0                	mov    %edx,%eax
80107477:	c9                   	leave
80107478:	c3                   	ret
80107479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107480:	8b 55 0c             	mov    0xc(%ebp),%edx
}
80107483:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107486:	c9                   	leave
80107487:	89 d0                	mov    %edx,%eax
80107489:	c3                   	ret
8010748a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107490:	83 ec 0c             	sub    $0xc,%esp
80107493:	68 9e 7d 10 80       	push   $0x80107d9e
80107498:	e8 53 92 ff ff       	call   801006f0 <cprintf>
  if(newsz >= oldsz)
8010749d:	83 c4 10             	add    $0x10,%esp
801074a0:	3b 75 0c             	cmp    0xc(%ebp),%esi
801074a3:	74 0d                	je     801074b2 <allocuvm+0x102>
  a = PGROUNDUP(newsz);
801074a5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801074a8:	8b 45 08             	mov    0x8(%ebp),%eax
801074ab:	89 f2                	mov    %esi,%edx
801074ad:	e8 2e fa ff ff       	call   80106ee0 <deallocuvm.part.0>
      kfree(mem);
801074b2:	83 ec 0c             	sub    $0xc,%esp
801074b5:	53                   	push   %ebx
801074b6:	e8 85 b1 ff ff       	call   80102640 <kfree>
      return 0;
801074bb:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801074be:	8b 7d fc             	mov    -0x4(%ebp),%edi
801074c1:	83 c4 10             	add    $0x10,%esp
801074c4:	eb aa                	jmp    80107470 <allocuvm+0xc0>
801074c6:	66 90                	xchg   %ax,%ax
801074c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801074cf:	00 
801074d0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801074d3:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801074d6:	8b 7d fc             	mov    -0x4(%ebp),%edi
}
801074d9:	8b 75 f8             	mov    -0x8(%ebp),%esi
801074dc:	c9                   	leave
801074dd:	89 d0                	mov    %edx,%eax
801074df:	c3                   	ret
801074e0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801074e3:	8b 7d fc             	mov    -0x4(%ebp),%edi
801074e6:	eb 88                	jmp    80107470 <allocuvm+0xc0>
801074e8:	8b 7d fc             	mov    -0x4(%ebp),%edi
801074eb:	eb 85                	jmp    80107472 <allocuvm+0xc2>
801074ed:	8d 76 00             	lea    0x0(%esi),%esi

801074f0 <deallocuvm>:
{
801074f0:	55                   	push   %ebp
801074f1:	89 e5                	mov    %esp,%ebp
801074f3:	8b 55 0c             	mov    0xc(%ebp),%edx
801074f6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801074f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801074fc:	39 d1                	cmp    %edx,%ecx
801074fe:	73 10                	jae    80107510 <deallocuvm+0x20>
}
80107500:	5d                   	pop    %ebp
80107501:	e9 da f9 ff ff       	jmp    80106ee0 <deallocuvm.part.0>
80107506:	66 90                	xchg   %ax,%ax
80107508:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010750f:	00 
80107510:	89 d0                	mov    %edx,%eax
80107512:	5d                   	pop    %ebp
80107513:	c3                   	ret
80107514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107518:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010751f:	00 

80107520 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107520:	55                   	push   %ebp
80107521:	89 e5                	mov    %esp,%ebp
80107523:	57                   	push   %edi
80107524:	56                   	push   %esi
80107525:	53                   	push   %ebx
80107526:	83 ec 0c             	sub    $0xc,%esp
80107529:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010752c:	85 f6                	test   %esi,%esi
8010752e:	74 59                	je     80107589 <freevm+0x69>
  a = PGROUNDUP(newsz);
80107530:	31 c9                	xor    %ecx,%ecx
80107532:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107537:	89 f0                	mov    %esi,%eax
80107539:	89 f3                	mov    %esi,%ebx
8010753b:	e8 a0 f9 ff ff       	call   80106ee0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107540:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107546:	eb 0f                	jmp    80107557 <freevm+0x37>
80107548:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010754f:	00 
80107550:	83 c3 04             	add    $0x4,%ebx
80107553:	39 fb                	cmp    %edi,%ebx
80107555:	74 23                	je     8010757a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107557:	8b 03                	mov    (%ebx),%eax
80107559:	a8 01                	test   $0x1,%al
8010755b:	74 f3                	je     80107550 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010755d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107562:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107565:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107568:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010756d:	50                   	push   %eax
8010756e:	e8 cd b0 ff ff       	call   80102640 <kfree>
80107573:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107576:	39 fb                	cmp    %edi,%ebx
80107578:	75 dd                	jne    80107557 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010757a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010757d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107580:	5b                   	pop    %ebx
80107581:	5e                   	pop    %esi
80107582:	5f                   	pop    %edi
80107583:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107584:	e9 b7 b0 ff ff       	jmp    80102640 <kfree>
    panic("freevm: no pgdir");
80107589:	83 ec 0c             	sub    $0xc,%esp
8010758c:	68 ba 7d 10 80       	push   $0x80107dba
80107591:	e8 0a 8e ff ff       	call   801003a0 <panic>
80107596:	66 90                	xchg   %ax,%ax
80107598:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010759f:	00 

801075a0 <setupkvm>:
{
801075a0:	55                   	push   %ebp
801075a1:	89 e5                	mov    %esp,%ebp
801075a3:	83 ec 08             	sub    $0x8,%esp
801075a6:	89 75 fc             	mov    %esi,-0x4(%ebp)
  if((pgdir = (pde_t*)kalloc()) == 0)
801075a9:	e8 62 b2 ff ff       	call   80102810 <kalloc>
801075ae:	89 c6                	mov    %eax,%esi
801075b0:	85 c0                	test   %eax,%eax
801075b2:	74 49                	je     801075fd <setupkvm+0x5d>
  memset(pgdir, 0, PGSIZE);
801075b4:	83 ec 04             	sub    $0x4,%esp
801075b7:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801075ba:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
801075bf:	68 00 10 00 00       	push   $0x1000
801075c4:	6a 00                	push   $0x0
801075c6:	50                   	push   %eax
801075c7:	e8 b4 d5 ff ff       	call   80104b80 <memset>
801075cc:	83 c4 10             	add    $0x10,%esp
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801075cf:	8b 43 04             	mov    0x4(%ebx),%eax
801075d2:	83 ec 08             	sub    $0x8,%esp
801075d5:	8b 4b 08             	mov    0x8(%ebx),%ecx
801075d8:	8b 13                	mov    (%ebx),%edx
801075da:	ff 73 0c             	push   0xc(%ebx)
801075dd:	50                   	push   %eax
801075de:	29 c1                	sub    %eax,%ecx
801075e0:	89 f0                	mov    %esi,%eax
801075e2:	e8 d9 f9 ff ff       	call   80106fc0 <mappages>
801075e7:	83 c4 10             	add    $0x10,%esp
801075ea:	83 f8 ff             	cmp    $0xffffffff,%eax
801075ed:	74 19                	je     80107608 <setupkvm+0x68>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801075ef:	83 c3 10             	add    $0x10,%ebx
801075f2:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
801075f8:	75 d5                	jne    801075cf <setupkvm+0x2f>
801075fa:	8b 5d f8             	mov    -0x8(%ebp),%ebx
}
801075fd:	89 f0                	mov    %esi,%eax
801075ff:	8b 75 fc             	mov    -0x4(%ebp),%esi
80107602:	c9                   	leave
80107603:	c3                   	ret
80107604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107608:	83 ec 0c             	sub    $0xc,%esp
8010760b:	56                   	push   %esi
    return 0;
8010760c:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
8010760e:	e8 0d ff ff ff       	call   80107520 <freevm>
}
80107613:	89 f0                	mov    %esi,%eax
      return 0;
80107615:	8b 5d f8             	mov    -0x8(%ebp),%ebx
}
80107618:	8b 75 fc             	mov    -0x4(%ebp),%esi
      return 0;
8010761b:	83 c4 10             	add    $0x10,%esp
}
8010761e:	c9                   	leave
8010761f:	c3                   	ret

80107620 <kvmalloc>:
{
80107620:	55                   	push   %ebp
80107621:	89 e5                	mov    %esp,%ebp
80107623:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107626:	e8 75 ff ff ff       	call   801075a0 <setupkvm>
8010762b:	a3 44 55 11 80       	mov    %eax,0x80115544
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107630:	05 00 00 00 80       	add    $0x80000000,%eax
80107635:	0f 22 d8             	mov    %eax,%cr3
}
80107638:	c9                   	leave
80107639:	c3                   	ret
8010763a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107640 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107640:	55                   	push   %ebp
80107641:	89 e5                	mov    %esp,%ebp
80107643:	83 ec 08             	sub    $0x8,%esp
80107646:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107649:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
8010764c:	89 c1                	mov    %eax,%ecx
8010764e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107651:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107654:	f6 c2 01             	test   $0x1,%dl
80107657:	75 17                	jne    80107670 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107659:	83 ec 0c             	sub    $0xc,%esp
8010765c:	68 cb 7d 10 80       	push   $0x80107dcb
80107661:	e8 3a 8d ff ff       	call   801003a0 <panic>
80107666:	66 90                	xchg   %ax,%ax
80107668:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010766f:	00 
  return &pgtab[PTX(va)];
80107670:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107673:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107679:	25 fc 0f 00 00       	and    $0xffc,%eax
8010767e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107685:	85 c0                	test   %eax,%eax
80107687:	74 d0                	je     80107659 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107689:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010768c:	c9                   	leave
8010768d:	c3                   	ret
8010768e:	66 90                	xchg   %ax,%ax

80107690 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107690:	55                   	push   %ebp
80107691:	89 e5                	mov    %esp,%ebp
80107693:	83 ec 28             	sub    $0x28,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107696:	e8 05 ff ff ff       	call   801075a0 <setupkvm>
8010769b:	89 c2                	mov    %eax,%edx
8010769d:	85 c0                	test   %eax,%eax
8010769f:	0f 84 cc 00 00 00    	je     80107771 <copyuvm+0xe1>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801076a5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801076a8:	85 c9                	test   %ecx,%ecx
801076aa:	0f 84 c1 00 00 00    	je     80107771 <copyuvm+0xe1>
801076b0:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801076b3:	89 75 f8             	mov    %esi,-0x8(%ebp)
801076b6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801076b9:	89 7d fc             	mov    %edi,-0x4(%ebp)
801076bc:	31 ff                	xor    %edi,%edi
801076be:	66 90                	xchg   %ax,%ax
  if(*pde & PTE_P){
801076c0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
801076c3:	89 f8                	mov    %edi,%eax
801076c5:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
801076c8:	8b 04 81             	mov    (%ecx,%eax,4),%eax
801076cb:	a8 01                	test   $0x1,%al
801076cd:	75 11                	jne    801076e0 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801076cf:	83 ec 0c             	sub    $0xc,%esp
801076d2:	68 d5 7d 10 80       	push   $0x80107dd5
801076d7:	e8 c4 8c ff ff       	call   801003a0 <panic>
801076dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
801076e0:	89 fa                	mov    %edi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801076e2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801076e7:	c1 ea 0a             	shr    $0xa,%edx
801076ea:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801076f0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801076f7:	85 c0                	test   %eax,%eax
801076f9:	74 d4                	je     801076cf <copyuvm+0x3f>
    if(!(*pte & PTE_P))
801076fb:	8b 30                	mov    (%eax),%esi
801076fd:	f7 c6 01 00 00 00    	test   $0x1,%esi
80107703:	0f 84 a8 00 00 00    	je     801077b1 <copyuvm+0x121>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
80107709:	e8 02 b1 ff ff       	call   80102810 <kalloc>
8010770e:	89 c3                	mov    %eax,%ebx
80107710:	85 c0                	test   %eax,%eax
80107712:	74 64                	je     80107778 <copyuvm+0xe8>
    pa = PTE_ADDR(*pte);
80107714:	89 f0                	mov    %esi,%eax
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107716:	83 ec 04             	sub    $0x4,%esp
    flags = PTE_FLAGS(*pte);
80107719:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
    pa = PTE_ADDR(*pte);
8010771f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107724:	68 00 10 00 00       	push   $0x1000
80107729:	05 00 00 00 80       	add    $0x80000000,%eax
8010772e:	50                   	push   %eax
8010772f:	53                   	push   %ebx
80107730:	e8 eb d4 ff ff       	call   80104c20 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107735:	58                   	pop    %eax
80107736:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010773c:	5a                   	pop    %edx
8010773d:	56                   	push   %esi
8010773e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107743:	89 fa                	mov    %edi,%edx
80107745:	50                   	push   %eax
80107746:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107749:	e8 72 f8 ff ff       	call   80106fc0 <mappages>
8010774e:	83 c4 10             	add    $0x10,%esp
80107751:	83 f8 ff             	cmp    $0xffffffff,%eax
80107754:	74 4a                	je     801077a0 <copyuvm+0x110>
  for(i = 0; i < sz; i += PGSIZE){
80107756:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010775c:	3b 7d 0c             	cmp    0xc(%ebp),%edi
8010775f:	0f 82 5b ff ff ff    	jb     801076c0 <copyuvm+0x30>
80107765:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107768:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010776b:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010776e:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return d;

bad:
  freevm(d);
  return 0;
}
80107771:	c9                   	leave
80107772:	89 d0                	mov    %edx,%eax
80107774:	c3                   	ret
80107775:	8d 76 00             	lea    0x0(%esi),%esi
80107778:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  freevm(d);
8010777b:	83 ec 0c             	sub    $0xc,%esp
8010777e:	52                   	push   %edx
8010777f:	e8 9c fd ff ff       	call   80107520 <freevm>
    return 0;
80107784:	31 d2                	xor    %edx,%edx
80107786:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107789:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010778c:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return 0;
8010778f:	83 c4 10             	add    $0x10,%esp
}
80107792:	89 d0                	mov    %edx,%eax
80107794:	c9                   	leave
80107795:	c3                   	ret
80107796:	66 90                	xchg   %ax,%ax
80107798:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010779f:	00 
      kfree(mem);
801077a0:	83 ec 0c             	sub    $0xc,%esp
801077a3:	53                   	push   %ebx
801077a4:	e8 97 ae ff ff       	call   80102640 <kfree>
      goto bad;
801077a9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801077ac:	83 c4 10             	add    $0x10,%esp
801077af:	eb ca                	jmp    8010777b <copyuvm+0xeb>
      panic("copyuvm: page not present");
801077b1:	83 ec 0c             	sub    $0xc,%esp
801077b4:	68 ef 7d 10 80       	push   $0x80107def
801077b9:	e8 e2 8b ff ff       	call   801003a0 <panic>
801077be:	66 90                	xchg   %ax,%ax

801077c0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801077c0:	55                   	push   %ebp
801077c1:	89 e5                	mov    %esp,%ebp
801077c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801077c6:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801077c9:	89 c1                	mov    %eax,%ecx
801077cb:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801077ce:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801077d1:	f6 c2 01             	test   $0x1,%dl
801077d4:	0f 84 fb 00 00 00    	je     801078d5 <uva2ka.cold>
  return &pgtab[PTX(va)];
801077da:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801077dd:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801077e3:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
801077e4:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
801077e9:	8b 94 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%edx
  return (char*)P2V(PTE_ADDR(*pte));
801077f0:	89 d0                	mov    %edx,%eax
801077f2:	f7 d2                	not    %edx
801077f4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801077f9:	05 00 00 00 80       	add    $0x80000000,%eax
801077fe:	83 e2 05             	and    $0x5,%edx
80107801:	ba 00 00 00 00       	mov    $0x0,%edx
80107806:	0f 45 c2             	cmovne %edx,%eax
}
80107809:	c3                   	ret
8010780a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107810 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107810:	55                   	push   %ebp
80107811:	89 e5                	mov    %esp,%ebp
80107813:	83 ec 18             	sub    $0x18,%esp
80107816:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107819:	8b 55 10             	mov    0x10(%ebp),%edx
8010781c:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010781f:	8b 7d 14             	mov    0x14(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107822:	85 ff                	test   %edi,%edi
80107824:	0f 84 a4 00 00 00    	je     801078ce <copyout+0xbe>
8010782a:	89 5d f4             	mov    %ebx,-0xc(%ebp)
8010782d:	89 75 f8             	mov    %esi,-0x8(%ebp)
80107830:	eb 47                	jmp    80107879 <copyout+0x69>
80107832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (char*)P2V(PTE_ADDR(*pte));
80107838:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
8010783d:	05 00 00 00 80       	add    $0x80000000,%eax
80107842:	74 6f                	je     801078b3 <copyout+0xa3>
      return -1;
    n = PGSIZE - (va - va0);
80107844:	8d 9e 00 10 00 00    	lea    0x1000(%esi),%ebx
8010784a:	29 cb                	sub    %ecx,%ebx
    if(n > len)
8010784c:	39 fb                	cmp    %edi,%ebx
8010784e:	0f 47 df             	cmova  %edi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107851:	81 e1 ff 0f 00 00    	and    $0xfff,%ecx
80107857:	83 ec 04             	sub    $0x4,%esp
8010785a:	01 c8                	add    %ecx,%eax
8010785c:	53                   	push   %ebx
8010785d:	52                   	push   %edx
8010785e:	50                   	push   %eax
8010785f:	89 55 10             	mov    %edx,0x10(%ebp)
80107862:	e8 b9 d3 ff ff       	call   80104c20 <memmove>
    len -= n;
    buf += n;
80107867:	8b 55 10             	mov    0x10(%ebp),%edx
  while(len > 0){
8010786a:	83 c4 10             	add    $0x10,%esp
    buf += n;
8010786d:	01 da                	add    %ebx,%edx
  while(len > 0){
8010786f:	29 df                	sub    %ebx,%edi
80107871:	74 55                	je     801078c8 <copyout+0xb8>
80107873:	8d 8e 00 10 00 00    	lea    0x1000(%esi),%ecx
  if(*pde & PTE_P){
80107879:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
8010787c:	89 c8                	mov    %ecx,%eax
    va0 = (uint)PGROUNDDOWN(va);
8010787e:	89 ce                	mov    %ecx,%esi
  pde = &pgdir[PDX(va)];
80107880:	c1 e8 16             	shr    $0x16,%eax
    va0 = (uint)PGROUNDDOWN(va);
80107883:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if(*pde & PTE_P){
80107889:	8b 04 83             	mov    (%ebx,%eax,4),%eax
8010788c:	a8 01                	test   $0x1,%al
8010788e:	0f 84 48 00 00 00    	je     801078dc <copyout.cold>
  return &pgtab[PTX(va)];
80107894:	89 f3                	mov    %esi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107896:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
8010789b:	c1 eb 0c             	shr    $0xc,%ebx
8010789e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
801078a4:	8b 84 98 00 00 00 80 	mov    -0x80000000(%eax,%ebx,4),%eax
801078ab:	a8 01                	test   $0x1,%al
801078ad:	74 04                	je     801078b3 <copyout+0xa3>
  if((*pte & PTE_U) == 0)
801078af:	a8 04                	test   $0x4,%al
801078b1:	75 85                	jne    80107838 <copyout+0x28>
801078b3:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801078b6:	8b 75 f8             	mov    -0x8(%ebp),%esi
      return -1;
801078b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    va = va0 + PGSIZE;
  }
  return 0;
}
801078be:	8b 7d fc             	mov    -0x4(%ebp),%edi
801078c1:	c9                   	leave
801078c2:	c3                   	ret
801078c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801078c8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801078cb:	8b 75 f8             	mov    -0x8(%ebp),%esi
801078ce:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return 0;
801078d1:	31 c0                	xor    %eax,%eax
}
801078d3:	c9                   	leave
801078d4:	c3                   	ret

801078d5 <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
801078d5:	a1 00 00 00 00       	mov    0x0,%eax
801078da:	0f 0b                	ud2

801078dc <copyout.cold>:
801078dc:	a1 00 00 00 00       	mov    0x0,%eax
801078e1:	0f 0b                	ud2
