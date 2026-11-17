
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
80100028:	bc d0 64 11 80       	mov    $0x801164d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 b0 32 10 80       	mov    $0x801032b0,%eax
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
8010004c:	68 60 77 10 80       	push   $0x80107760
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 65 46 00 00       	call   801046c0 <initlock>
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
80100096:	68 67 77 10 80       	push   $0x80107767
8010009b:	50                   	push   %eax
8010009c:	e8 ef 44 00 00       	call   80104590 <initsleeplock>
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
801000e4:	e8 f7 47 00 00       	call   801048e0 <acquire>
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
80100172:	e8 09 47 00 00       	call   80104880 <release>
      acquiresleep(&b->lock);
80100177:	8d 43 0c             	lea    0xc(%ebx),%eax
8010017a:	89 04 24             	mov    %eax,(%esp)
8010017d:	e8 4e 44 00 00       	call   801045d0 <acquiresleep>
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
801001b1:	68 6e 77 10 80       	push   $0x8010776e
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
801001ce:	e8 9d 44 00 00       	call   80104670 <holdingsleep>
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
801001ec:	68 7f 77 10 80       	push   $0x8010777f
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
8010020f:	e8 5c 44 00 00       	call   80104670 <holdingsleep>
80100214:	83 c4 10             	add    $0x10,%esp
80100217:	85 c0                	test   %eax,%eax
80100219:	74 63                	je     8010027e <brelse+0x7e>
    panic("brelse");

  releasesleep(&b->lock);
8010021b:	83 ec 0c             	sub    $0xc,%esp
8010021e:	56                   	push   %esi
8010021f:	e8 0c 44 00 00       	call   80104630 <releasesleep>

  acquire(&bcache.lock);
80100224:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010022b:	e8 b0 46 00 00       	call   801048e0 <acquire>
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
80100279:	e9 02 46 00 00       	jmp    80104880 <release>
    panic("brelse");
8010027e:	83 ec 0c             	sub    $0xc,%esp
80100281:	68 86 77 10 80       	push   $0x80107786
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
801002c0:	e8 1b 46 00 00       	call   801048e0 <acquire>
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
801002ed:	e8 3e 40 00 00       	call   80104330 <sleep>
    while(input.r == input.w){
801002f2:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002f7:	83 c4 10             	add    $0x10,%esp
801002fa:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
80100300:	75 36                	jne    80100338 <consoleread+0x98>
      if(myproc()->killed){
80100302:	e8 19 39 00 00       	call   80103c20 <myproc>
80100307:	8b 48 24             	mov    0x24(%eax),%ecx
8010030a:	85 c9                	test   %ecx,%ecx
8010030c:	74 d2                	je     801002e0 <consoleread+0x40>
        release(&cons.lock);
8010030e:	83 ec 0c             	sub    $0xc,%esp
80100311:	68 20 ff 10 80       	push   $0x8010ff20
80100316:	e8 65 45 00 00       	call   80104880 <release>
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
8010036c:	e8 0f 45 00 00       	call   80104880 <release>
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
801003b5:	e8 26 27 00 00       	call   80102ae0 <lapicid>
801003ba:	83 ec 08             	sub    $0x8,%esp
801003bd:	50                   	push   %eax
801003be:	68 8d 77 10 80       	push   $0x8010778d
801003c3:	e8 28 03 00 00       	call   801006f0 <cprintf>
  cprintf(s);
801003c8:	58                   	pop    %eax
801003c9:	ff 75 08             	push   0x8(%ebp)
801003cc:	e8 1f 03 00 00       	call   801006f0 <cprintf>
  cprintf("\n");
801003d1:	c7 04 24 0f 7c 10 80 	movl   $0x80107c0f,(%esp)
801003d8:	e8 13 03 00 00       	call   801006f0 <cprintf>
  getcallerpcs(&s, pcs);
801003dd:	8d 45 08             	lea    0x8(%ebp),%eax
801003e0:	5a                   	pop    %edx
801003e1:	59                   	pop    %ecx
801003e2:	53                   	push   %ebx
801003e3:	50                   	push   %eax
801003e4:	e8 f7 42 00 00       	call   801046e0 <getcallerpcs>
  for(i=0; i<10; i++)
801003e9:	83 c4 10             	add    $0x10,%esp
801003ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf(" %p", pcs[i]);
801003f0:	83 ec 08             	sub    $0x8,%esp
801003f3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003f5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003f8:	68 a1 77 10 80       	push   $0x801077a1
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
8010044a:	e8 a1 5d 00 00       	call   801061f0 <uartputc>
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
80100515:	e8 d6 5c 00 00       	call   801061f0 <uartputc>
8010051a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100521:	e8 ca 5c 00 00       	call   801061f0 <uartputc>
80100526:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010052d:	e8 be 5c 00 00       	call   801061f0 <uartputc>
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
80100591:	e8 0a 45 00 00       	call   80104aa0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100596:	b8 80 07 00 00       	mov    $0x780,%eax
8010059b:	83 c4 0c             	add    $0xc,%esp
8010059e:	29 d8                	sub    %ebx,%eax
801005a0:	01 c0                	add    %eax,%eax
801005a2:	50                   	push   %eax
801005a3:	6a 00                	push   $0x0
801005a5:	57                   	push   %edi
801005a6:	e8 55 44 00 00       	call   80104a00 <memset>
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
801005c9:	68 a5 77 10 80       	push   $0x801077a5
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
801005fb:	e8 e0 42 00 00       	call   801048e0 <acquire>
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
8010063f:	e8 3c 42 00 00       	call   80104880 <release>
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
8010068d:	0f b6 92 60 7c 10 80 	movzbl -0x7fef83a0(%edx),%edx
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
8010083b:	e8 a0 40 00 00       	call   801048e0 <acquire>
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
80100861:	e8 1a 40 00 00       	call   80104880 <release>
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
801008b4:	bb b8 77 10 80       	mov    $0x801077b8,%ebx
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
801008fe:	68 bf 77 10 80       	push   $0x801077bf
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
80100926:	e8 b5 3f 00 00       	call   801048e0 <acquire>
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
8010095c:	e8 1f 3f 00 00       	call   80104880 <release>
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
80100ab9:	e8 32 39 00 00       	call   801043f0 <wakeup>
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
80100adf:	e9 ec 39 00 00       	jmp    801044d0 <procdump>
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
80100b06:	68 c8 77 10 80       	push   $0x801077c8
80100b0b:	68 20 ff 10 80       	push   $0x8010ff20
80100b10:	e8 ab 3b 00 00       	call   801046c0 <initlock>

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
80100b59:	e8 c2 30 00 00       	call   80103c20 <myproc>
80100b5e:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100b64:	e8 57 24 00 00       	call   80102fc0 <begin_op>

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
80100baf:	e8 7c 24 00 00       	call   80103030 <end_op>
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
80100bd4:	e8 c7 67 00 00       	call   801073a0 <setupkvm>
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
80100c43:	e8 68 65 00 00       	call   801071b0 <allocuvm>
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
80100c79:	e8 52 64 00 00       	call   801070d0 <loaduvm>
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
80100cbb:	e8 60 66 00 00       	call   80107320 <freevm>
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
80100cf1:	e8 3a 23 00 00       	call   80103030 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100cf6:	83 c4 0c             	add    $0xc,%esp
80100cf9:	56                   	push   %esi
80100cfa:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100d00:	57                   	push   %edi
80100d01:	56                   	push   %esi
80100d02:	e8 a9 64 00 00       	call   801071b0 <allocuvm>
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
80100d23:	e8 18 67 00 00       	call   80107440 <clearpteu>
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
80100d73:	e8 a8 3e 00 00       	call   80104c20 <strlen>
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
80100d87:	e8 94 3e 00 00       	call   80104c20 <strlen>
80100d8c:	83 c0 01             	add    $0x1,%eax
80100d8f:	50                   	push   %eax
80100d90:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d93:	ff 34 b8             	push   (%eax,%edi,4)
80100d96:	53                   	push   %ebx
80100d97:	56                   	push   %esi
80100d98:	e8 73 68 00 00       	call   80107610 <copyout>
80100d9d:	83 c4 20             	add    $0x20,%esp
80100da0:	85 c0                	test   %eax,%eax
80100da2:	79 ac                	jns    80100d50 <exec+0x200>
80100da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100da8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100daf:	00 
    freevm(pgdir);
80100db0:	83 ec 0c             	sub    $0xc,%esp
80100db3:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100db9:	e8 62 65 00 00       	call   80107320 <freevm>
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
80100e11:	e8 fa 67 00 00       	call   80107610 <copyout>
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
80100e4f:	e8 7c 3d 00 00       	call   80104bd0 <safestrcpy>
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
80100e7b:	e8 c0 60 00 00       	call   80106f40 <switchuvm>
  freevm(oldpgdir);
80100e80:	89 34 24             	mov    %esi,(%esp)
80100e83:	e8 98 64 00 00       	call   80107320 <freevm>
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
80100e98:	e8 93 21 00 00       	call   80103030 <end_op>
    cprintf("exec: fail\n");
80100e9d:	83 ec 0c             	sub    $0xc,%esp
80100ea0:	68 d0 77 10 80       	push   $0x801077d0
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
80100ec6:	68 dc 77 10 80       	push   $0x801077dc
80100ecb:	68 60 ff 10 80       	push   $0x8010ff60
80100ed0:	e8 eb 37 00 00       	call   801046c0 <initlock>
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
80100ef1:	e8 ea 39 00 00       	call   801048e0 <acquire>
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
80100f21:	e8 5a 39 00 00       	call   80104880 <release>
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
80100f3a:	e8 41 39 00 00       	call   80104880 <release>
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
80100f5f:	e8 7c 39 00 00       	call   801048e0 <acquire>
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
80100f7c:	e8 ff 38 00 00       	call   80104880 <release>
  return f;
}
80100f81:	89 d8                	mov    %ebx,%eax
80100f83:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f86:	c9                   	leave
80100f87:	c3                   	ret
    panic("filedup");
80100f88:	83 ec 0c             	sub    $0xc,%esp
80100f8b:	68 e3 77 10 80       	push   $0x801077e3
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
80100fb1:	e8 2a 39 00 00       	call   801048e0 <acquire>
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
80100ff2:	e8 89 38 00 00       	call   80104880 <release>

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
8010101b:	e9 60 38 00 00       	jmp    80104880 <release>
    begin_op();
80101020:	e8 9b 1f 00 00       	call   80102fc0 <begin_op>
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
8010103d:	e9 ee 1f 00 00       	jmp    80103030 <end_op>
80101042:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80101048:	89 f8                	mov    %edi,%eax
8010104a:	83 ec 08             	sub    $0x8,%esp
8010104d:	0f be c0             	movsbl %al,%eax
80101050:	50                   	push   %eax
80101051:	ff 75 e4             	push   -0x1c(%ebp)
80101054:	e8 27 27 00 00       	call   80103780 <pipeclose>
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
8010106d:	68 eb 77 10 80       	push   $0x801077eb
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
8010113d:	e9 fe 27 00 00       	jmp    80103940 <piperead>
80101142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101148:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010114d:	eb d7                	jmp    80101126 <fileread+0x56>
  panic("fileread");
8010114f:	83 ec 0c             	sub    $0xc,%esp
80101152:	68 f5 77 10 80       	push   $0x801077f5
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
801011bf:	e8 6c 1e 00 00       	call   80103030 <end_op>

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
801011e4:	e8 d7 1d 00 00       	call   80102fc0 <begin_op>
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
8010121c:	e8 0f 1e 00 00       	call   80103030 <end_op>
      if(r < 0)
80101221:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101224:	83 c4 10             	add    $0x10,%esp
80101227:	85 c0                	test   %eax,%eax
80101229:	75 15                	jne    80101240 <filewrite+0xe0>
        panic("short filewrite");
8010122b:	83 ec 0c             	sub    $0xc,%esp
8010122e:	68 fe 77 10 80       	push   $0x801077fe
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
80101265:	e9 b6 25 00 00       	jmp    80103820 <pipewrite>
    int i = 0;
8010126a:	31 f6                	xor    %esi,%esi
8010126c:	eb d5                	jmp    80101243 <filewrite+0xe3>
    return -1;
8010126e:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101273:	eb d9                	jmp    8010124e <filewrite+0xee>
  panic("filewrite");
80101275:	83 ec 0c             	sub    $0xc,%esp
80101278:	89 5d f4             	mov    %ebx,-0xc(%ebp)
8010127b:	68 04 78 10 80       	push   $0x80107804
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
80101337:	68 0e 78 10 80       	push   $0x8010780e
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
80101355:	e8 46 1e 00 00       	call   801031a0 <log_write>
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
8010137d:	e8 7e 36 00 00       	call   80104a00 <memset>
  log_write(bp);
80101382:	89 1c 24             	mov    %ebx,(%esp)
80101385:	e8 16 1e 00 00       	call   801031a0 <log_write>
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
801013b4:	e8 27 35 00 00       	call   801048e0 <acquire>
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
8010141f:	e8 5c 34 00 00       	call   80104880 <release>

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
8010144e:	e8 2d 34 00 00       	call   80104880 <release>
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
80101482:	68 24 78 10 80       	push   $0x80107824
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
801014dd:	e8 be 1c 00 00       	call   801031a0 <log_write>
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
801014f7:	68 34 78 10 80       	push   $0x80107834
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
8010158b:	e8 10 1c 00 00       	call   801031a0 <log_write>
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
801015da:	68 47 78 10 80       	push   $0x80107847
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
80101611:	e8 8a 34 00 00       	call   80104aa0 <memmove>
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
8010163c:	68 5a 78 10 80       	push   $0x8010785a
80101641:	68 60 09 11 80       	push   $0x80110960
80101646:	e8 75 30 00 00       	call   801046c0 <initlock>
  for(i = 0; i < NINODE; i++) {
8010164b:	83 c4 10             	add    $0x10,%esp
8010164e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101650:	83 ec 08             	sub    $0x8,%esp
80101653:	68 61 78 10 80       	push   $0x80107861
80101658:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80101659:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010165f:	e8 2c 2f 00 00       	call   80104590 <initsleeplock>
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
8010168c:	e8 0f 34 00 00       	call   80104aa0 <memmove>
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
801016c3:	68 74 7c 10 80       	push   $0x80107c74
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
8010175e:	e8 9d 32 00 00       	call   80104a00 <memset>
      dip->type = type;
80101763:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
80101767:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010176a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010176d:	89 1c 24             	mov    %ebx,(%esp)
80101770:	e8 2b 1a 00 00       	call   801031a0 <log_write>
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
80101793:	68 67 78 10 80       	push   $0x80107867
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
80101804:	e8 97 32 00 00       	call   80104aa0 <memmove>
  log_write(bp);
80101809:	89 34 24             	mov    %esi,(%esp)
8010180c:	e8 8f 19 00 00       	call   801031a0 <log_write>
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
8010183f:	e8 9c 30 00 00       	call   801048e0 <acquire>
  ip->ref++;
80101844:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101848:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010184f:	e8 2c 30 00 00       	call   80104880 <release>
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
80101884:	e8 47 2d 00 00       	call   801045d0 <acquiresleep>
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
801018fb:	e8 a0 31 00 00       	call   80104aa0 <memmove>
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
80101923:	68 7f 78 10 80       	push   $0x8010787f
80101928:	e8 73 ea ff ff       	call   801003a0 <panic>
    panic("ilock");
8010192d:	83 ec 0c             	sub    $0xc,%esp
80101930:	68 79 78 10 80       	push   $0x80107879
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
80101953:	e8 18 2d 00 00       	call   80104670 <holdingsleep>
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
8010196f:	e9 bc 2c 00 00       	jmp    80104630 <releasesleep>
    panic("iunlock");
80101974:	83 ec 0c             	sub    $0xc,%esp
80101977:	68 8e 78 10 80       	push   $0x8010788e
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
801019a3:	e8 28 2c 00 00       	call   801045d0 <acquiresleep>
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
801019bd:	e8 6e 2c 00 00       	call   80104630 <releasesleep>
  acquire(&icache.lock);
801019c2:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
801019c9:	e8 12 2f 00 00       	call   801048e0 <acquire>
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
801019e3:	e9 98 2e 00 00       	jmp    80104880 <release>
801019e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801019ef:	00 
    acquire(&icache.lock);
801019f0:	83 ec 0c             	sub    $0xc,%esp
801019f3:	89 7d fc             	mov    %edi,-0x4(%ebp)
801019f6:	68 60 09 11 80       	push   $0x80110960
801019fb:	e8 e0 2e 00 00       	call   801048e0 <acquire>
    int r = ip->ref;
80101a00:	8b 7b 08             	mov    0x8(%ebx),%edi
    release(&icache.lock);
80101a03:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101a0a:	e8 71 2e 00 00       	call   80104880 <release>
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
80101b23:	e8 48 2b 00 00       	call   80104670 <holdingsleep>
80101b28:	83 c4 10             	add    $0x10,%esp
80101b2b:	85 c0                	test   %eax,%eax
80101b2d:	74 21                	je     80101b50 <iunlockput+0x40>
80101b2f:	8b 43 08             	mov    0x8(%ebx),%eax
80101b32:	85 c0                	test   %eax,%eax
80101b34:	7e 1a                	jle    80101b50 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101b36:	83 ec 0c             	sub    $0xc,%esp
80101b39:	56                   	push   %esi
80101b3a:	e8 f1 2a 00 00       	call   80104630 <releasesleep>
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
80101b53:	68 8e 78 10 80       	push   $0x8010788e
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
80101c47:	e8 54 2e 00 00       	call   80104aa0 <memmove>
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
80101d53:	e8 48 2d 00 00       	call   80104aa0 <memmove>
    log_write(bp);
80101d58:	89 34 24             	mov    %esi,(%esp)
80101d5b:	e8 40 14 00 00       	call   801031a0 <log_write>
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
80101dee:	e8 2d 2d 00 00       	call   80104b20 <strncmp>
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
80101e55:	e8 c6 2c 00 00       	call   80104b20 <strncmp>
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
80101e9a:	68 a8 78 10 80       	push   $0x801078a8
80101e9f:	e8 fc e4 ff ff       	call   801003a0 <panic>
    panic("dirlookup not DIR");
80101ea4:	83 ec 0c             	sub    $0xc,%esp
80101ea7:	68 96 78 10 80       	push   $0x80107896
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
80101eda:	e8 41 1d 00 00       	call   80103c20 <myproc>
  acquire(&icache.lock);
80101edf:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101ee2:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101ee5:	68 60 09 11 80       	push   $0x80110960
80101eea:	e8 f1 29 00 00       	call   801048e0 <acquire>
  ip->ref++;
80101eef:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101ef3:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101efa:	e8 81 29 00 00       	call   80104880 <release>
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
80101f67:	e8 34 2b 00 00       	call   80104aa0 <memmove>
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
80101fd4:	e8 97 26 00 00       	call   80104670 <holdingsleep>
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
80101ff6:	e8 35 26 00 00       	call   80104630 <releasesleep>
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
80102022:	e8 79 2a 00 00       	call   80104aa0 <memmove>
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
8010207c:	e8 ef 25 00 00       	call   80104670 <holdingsleep>
80102081:	83 c4 10             	add    $0x10,%esp
80102084:	85 c0                	test   %eax,%eax
80102086:	0f 84 8e 00 00 00    	je     8010211a <namex+0x25a>
8010208c:	8b 46 08             	mov    0x8(%esi),%eax
8010208f:	85 c0                	test   %eax,%eax
80102091:	0f 8e 83 00 00 00    	jle    8010211a <namex+0x25a>
  releasesleep(&ip->lock);
80102097:	83 ec 0c             	sub    $0xc,%esp
8010209a:	53                   	push   %ebx
8010209b:	e8 90 25 00 00       	call   80104630 <releasesleep>
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
801020be:	e8 ad 25 00 00       	call   80104670 <holdingsleep>
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
801020e1:	e8 8a 25 00 00       	call   80104670 <holdingsleep>
801020e6:	83 c4 10             	add    $0x10,%esp
801020e9:	85 c0                	test   %eax,%eax
801020eb:	74 2d                	je     8010211a <namex+0x25a>
801020ed:	8b 7e 08             	mov    0x8(%esi),%edi
801020f0:	85 ff                	test   %edi,%edi
801020f2:	7e 26                	jle    8010211a <namex+0x25a>
  releasesleep(&ip->lock);
801020f4:	83 ec 0c             	sub    $0xc,%esp
801020f7:	53                   	push   %ebx
801020f8:	e8 33 25 00 00       	call   80104630 <releasesleep>
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
8010211d:	68 8e 78 10 80       	push   $0x8010788e
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
80102195:	e8 d6 29 00 00       	call   80104b70 <strncpy>
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
801021d6:	68 b7 78 10 80       	push   $0x801078b7
801021db:	e8 c0 e1 ff ff       	call   801003a0 <panic>
    panic("dirlink");
801021e0:	83 ec 0c             	sub    $0xc,%esp
801021e3:	68 13 7b 10 80       	push   $0x80107b13
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
801022e6:	68 cd 78 10 80       	push   $0x801078cd
801022eb:	e8 b0 e0 ff ff       	call   801003a0 <panic>
    panic("idestart");
801022f0:	83 ec 0c             	sub    $0xc,%esp
801022f3:	89 7d fc             	mov    %edi,-0x4(%ebp)
801022f6:	68 c4 78 10 80       	push   $0x801078c4
801022fb:	e8 a0 e0 ff ff       	call   801003a0 <panic>

80102300 <ideinit>:
{
80102300:	55                   	push   %ebp
80102301:	89 e5                	mov    %esp,%ebp
80102303:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102306:	68 df 78 10 80       	push   $0x801078df
8010230b:	68 00 26 11 80       	push   $0x80112600
80102310:	e8 ab 23 00 00       	call   801046c0 <initlock>
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
8010238e:	e8 4d 25 00 00       	call   801048e0 <acquire>

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
801023f3:	e8 f8 1f 00 00       	call   801043f0 <wakeup>

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
80102414:	e8 67 24 00 00       	call   80104880 <release>

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
8010243e:	e8 2d 22 00 00       	call   80104670 <holdingsleep>
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
80102478:	e8 63 24 00 00       	call   801048e0 <acquire>

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
801024b9:	e8 72 1e 00 00       	call   80104330 <sleep>
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
801024d6:	e9 a5 23 00 00       	jmp    80104880 <release>
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
801024fa:	68 0e 79 10 80       	push   $0x8010790e
801024ff:	e8 9c de ff ff       	call   801003a0 <panic>
    panic("iderw: nothing to do");
80102504:	83 ec 0c             	sub    $0xc,%esp
80102507:	68 f9 78 10 80       	push   $0x801078f9
8010250c:	e8 8f de ff ff       	call   801003a0 <panic>
    panic("iderw: buf not locked");
80102511:	83 ec 0c             	sub    $0xc,%esp
80102514:	68 e3 78 10 80       	push   $0x801078e3
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
8010258a:	68 c8 7c 10 80       	push   $0x80107cc8
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
80102650:	0f 85 82 00 00 00    	jne    801026d8 <kfree+0x98>
80102656:	81 fb d0 64 11 80    	cmp    $0x801164d0,%ebx
8010265c:	72 7a                	jb     801026d8 <kfree+0x98>
8010265e:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102664:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102669:	77 6d                	ja     801026d8 <kfree+0x98>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
8010266b:	83 ec 04             	sub    $0x4,%esp
8010266e:	68 00 10 00 00       	push   $0x1000
80102673:	6a 01                	push   $0x1
80102675:	53                   	push   %ebx
80102676:	e8 85 23 00 00       	call   80104a00 <memset>

  if(kmem.use_lock)
8010267b:	8b 15 74 26 11 80    	mov    0x80112674,%edx
80102681:	83 c4 10             	add    $0x10,%esp
80102684:	85 d2                	test   %edx,%edx
80102686:	75 28                	jne    801026b0 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102688:	a1 7c 26 11 80       	mov    0x8011267c,%eax
8010268d:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  kmem.nfree++;
  if(kmem.use_lock)
8010268f:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.nfree++;
80102694:	83 05 78 26 11 80 01 	addl   $0x1,0x80112678
  kmem.freelist = r;
8010269b:	89 1d 7c 26 11 80    	mov    %ebx,0x8011267c
  if(kmem.use_lock)
801026a1:	85 c0                	test   %eax,%eax
801026a3:	75 23                	jne    801026c8 <kfree+0x88>
    release(&kmem.lock);
}
801026a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026a8:	c9                   	leave
801026a9:	c3                   	ret
801026aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
801026b0:	83 ec 0c             	sub    $0xc,%esp
801026b3:	68 40 26 11 80       	push   $0x80112640
801026b8:	e8 23 22 00 00       	call   801048e0 <acquire>
801026bd:	83 c4 10             	add    $0x10,%esp
801026c0:	eb c6                	jmp    80102688 <kfree+0x48>
801026c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
801026c8:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
801026cf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026d2:	c9                   	leave
    release(&kmem.lock);
801026d3:	e9 a8 21 00 00       	jmp    80104880 <release>
    panic("kfree");
801026d8:	83 ec 0c             	sub    $0xc,%esp
801026db:	68 2c 79 10 80       	push   $0x8010792c
801026e0:	e8 bb dc ff ff       	call   801003a0 <panic>
801026e5:	8d 76 00             	lea    0x0(%esi),%esi
801026e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801026ef:	00 

801026f0 <freerange>:
{
801026f0:	55                   	push   %ebp
801026f1:	89 e5                	mov    %esp,%ebp
801026f3:	56                   	push   %esi
801026f4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801026f5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801026f8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801026fb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102701:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102707:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010270d:	39 de                	cmp    %ebx,%esi
8010270f:	72 2b                	jb     8010273c <freerange+0x4c>
80102711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102718:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010271f:	00 
    kfree(p);
80102720:	83 ec 0c             	sub    $0xc,%esp
80102723:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102729:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010272f:	50                   	push   %eax
80102730:	e8 0b ff ff ff       	call   80102640 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102735:	83 c4 10             	add    $0x10,%esp
80102738:	39 de                	cmp    %ebx,%esi
8010273a:	73 e4                	jae    80102720 <freerange+0x30>
}
8010273c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010273f:	5b                   	pop    %ebx
80102740:	5e                   	pop    %esi
80102741:	5d                   	pop    %ebp
80102742:	c3                   	ret
80102743:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102748:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010274f:	00 

80102750 <kinit2>:
{
80102750:	55                   	push   %ebp
80102751:	89 e5                	mov    %esp,%ebp
80102753:	56                   	push   %esi
80102754:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102755:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102758:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010275b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102761:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102767:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010276d:	39 de                	cmp    %ebx,%esi
8010276f:	72 2b                	jb     8010279c <kinit2+0x4c>
80102771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102778:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010277f:	00 
    kfree(p);
80102780:	83 ec 0c             	sub    $0xc,%esp
80102783:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102789:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010278f:	50                   	push   %eax
80102790:	e8 ab fe ff ff       	call   80102640 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102795:	83 c4 10             	add    $0x10,%esp
80102798:	39 de                	cmp    %ebx,%esi
8010279a:	73 e4                	jae    80102780 <kinit2+0x30>
  kmem.use_lock = 1;
8010279c:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
801027a3:	00 00 00 
}
801027a6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027a9:	5b                   	pop    %ebx
801027aa:	5e                   	pop    %esi
801027ab:	5d                   	pop    %ebp
801027ac:	c3                   	ret
801027ad:	8d 76 00             	lea    0x0(%esi),%esi

801027b0 <kinit1>:
{
801027b0:	55                   	push   %ebp
801027b1:	89 e5                	mov    %esp,%ebp
801027b3:	56                   	push   %esi
801027b4:	53                   	push   %ebx
801027b5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801027b8:	83 ec 08             	sub    $0x8,%esp
801027bb:	68 32 79 10 80       	push   $0x80107932
801027c0:	68 40 26 11 80       	push   $0x80112640
801027c5:	e8 f6 1e 00 00       	call   801046c0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801027ca:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027cd:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
801027d0:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
801027d7:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
801027da:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801027e0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027e6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801027ec:	39 de                	cmp    %ebx,%esi
801027ee:	72 1c                	jb     8010280c <kinit1+0x5c>
    kfree(p);
801027f0:	83 ec 0c             	sub    $0xc,%esp
801027f3:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027f9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801027ff:	50                   	push   %eax
80102800:	e8 3b fe ff ff       	call   80102640 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102805:	83 c4 10             	add    $0x10,%esp
80102808:	39 de                	cmp    %ebx,%esi
8010280a:	73 e4                	jae    801027f0 <kinit1+0x40>
}
8010280c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010280f:	5b                   	pop    %ebx
80102810:	5e                   	pop    %esi
80102811:	5d                   	pop    %ebp
80102812:	c3                   	ret
80102813:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102818:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010281f:	00 

80102820 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102820:	a1 74 26 11 80       	mov    0x80112674,%eax
80102825:	85 c0                	test   %eax,%eax
80102827:	75 27                	jne    80102850 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102829:	a1 7c 26 11 80       	mov    0x8011267c,%eax
  if(r){
8010282e:	85 c0                	test   %eax,%eax
80102830:	74 16                	je     80102848 <kalloc+0x28>
    kmem.freelist = r->next;
80102832:	8b 10                	mov    (%eax),%edx
    kmem.nfree--;
80102834:	83 2d 78 26 11 80 01 	subl   $0x1,0x80112678
    kmem.freelist = r->next;
8010283b:	89 15 7c 26 11 80    	mov    %edx,0x8011267c
  }
  if(kmem.use_lock)
80102841:	c3                   	ret
80102842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
  return (char*)r;
}
80102848:	c3                   	ret
80102849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
80102850:	55                   	push   %ebp
80102851:	89 e5                	mov    %esp,%ebp
80102853:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
80102856:	68 40 26 11 80       	push   $0x80112640
8010285b:	e8 80 20 00 00       	call   801048e0 <acquire>
  r = kmem.freelist;
80102860:	a1 7c 26 11 80       	mov    0x8011267c,%eax
  if(kmem.use_lock)
80102865:	8b 15 74 26 11 80    	mov    0x80112674,%edx
  if(r){
8010286b:	83 c4 10             	add    $0x10,%esp
8010286e:	85 c0                	test   %eax,%eax
80102870:	74 0f                	je     80102881 <kalloc+0x61>
    kmem.freelist = r->next;
80102872:	8b 08                	mov    (%eax),%ecx
    kmem.nfree--;
80102874:	83 2d 78 26 11 80 01 	subl   $0x1,0x80112678
    kmem.freelist = r->next;
8010287b:	89 0d 7c 26 11 80    	mov    %ecx,0x8011267c
  if(kmem.use_lock)
80102881:	85 d2                	test   %edx,%edx
80102883:	74 16                	je     8010289b <kalloc+0x7b>
    release(&kmem.lock);
80102885:	83 ec 0c             	sub    $0xc,%esp
80102888:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010288b:	68 40 26 11 80       	push   $0x80112640
80102890:	e8 eb 1f 00 00       	call   80104880 <release>
  return (char*)r;
80102895:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102898:	83 c4 10             	add    $0x10,%esp
}
8010289b:	c9                   	leave
8010289c:	c3                   	ret
8010289d:	8d 76 00             	lea    0x0(%esi),%esi

801028a0 <countfreepages>:
int
countfreepages(void)
{
  int n;

  if(kmem.use_lock)
801028a0:	8b 0d 74 26 11 80    	mov    0x80112674,%ecx
    acquire(&kmem.lock);
  n = kmem.nfree;
801028a6:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(kmem.use_lock)
801028ab:	85 c9                	test   %ecx,%ecx
801028ad:	75 01                	jne    801028b0 <countfreepages+0x10>
  if(kmem.use_lock)
    release(&kmem.lock);
  return n;
}
801028af:	c3                   	ret
{
801028b0:	55                   	push   %ebp
801028b1:	89 e5                	mov    %esp,%ebp
801028b3:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801028b6:	68 40 26 11 80       	push   $0x80112640
801028bb:	e8 20 20 00 00       	call   801048e0 <acquire>
  if(kmem.use_lock)
801028c0:	8b 15 74 26 11 80    	mov    0x80112674,%edx
  n = kmem.nfree;
801028c6:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(kmem.use_lock)
801028cb:	83 c4 10             	add    $0x10,%esp
801028ce:	85 d2                	test   %edx,%edx
801028d0:	74 16                	je     801028e8 <countfreepages+0x48>
    release(&kmem.lock);
801028d2:	83 ec 0c             	sub    $0xc,%esp
801028d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
801028d8:	68 40 26 11 80       	push   $0x80112640
801028dd:	e8 9e 1f 00 00       	call   80104880 <release>
801028e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028e5:	83 c4 10             	add    $0x10,%esp
}
801028e8:	c9                   	leave
801028e9:	c3                   	ret
801028ea:	66 90                	xchg   %ax,%ax
801028ec:	66 90                	xchg   %ax,%ax
801028ee:	66 90                	xchg   %ax,%ax

801028f0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028f0:	ba 64 00 00 00       	mov    $0x64,%edx
801028f5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801028f6:	a8 01                	test   $0x1,%al
801028f8:	74 6e                	je     80102968 <kbdgetc+0x78>
801028fa:	ba 60 00 00 00       	mov    $0x60,%edx
801028ff:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102900:	8b 15 80 26 11 80    	mov    0x80112680,%edx
  data = inb(KBDATAP);
80102906:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80102909:	3c e0                	cmp    $0xe0,%al
8010290b:	74 63                	je     80102970 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
8010290d:	84 c0                	test   %al,%al
8010290f:	78 6f                	js     80102980 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
    shift &= ~E0ESC;
80102911:	83 c8 80             	or     $0xffffff80,%eax
80102914:	f6 c2 40             	test   $0x40,%dl
80102917:	0f b6 c0             	movzbl %al,%eax
8010291a:	0f 45 c8             	cmovne %eax,%ecx
8010291d:	89 d0                	mov    %edx,%eax
8010291f:	83 e0 bf             	and    $0xffffffbf,%eax
80102922:	f6 c2 40             	test   $0x40,%dl
80102925:	0f 45 d0             	cmovne %eax,%edx
  }

  shift |= shiftcode[data];
80102928:	0f b6 81 20 7f 10 80 	movzbl -0x7fef80e0(%ecx),%eax
8010292f:	09 c2                	or     %eax,%edx
  shift ^= togglecode[data];
80102931:	0f b6 81 20 7e 10 80 	movzbl -0x7fef81e0(%ecx),%eax
80102938:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010293a:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
8010293c:	89 15 80 26 11 80    	mov    %edx,0x80112680
  c = charcode[shift & (CTL | SHIFT)][data];
80102942:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102945:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
80102948:	8b 04 85 00 7e 10 80 	mov    -0x7fef8200(,%eax,4),%eax
8010294f:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102953:	74 18                	je     8010296d <kbdgetc+0x7d>
    if('a' <= c && c <= 'z')
80102955:	8d 50 9f             	lea    -0x61(%eax),%edx
80102958:	83 fa 19             	cmp    $0x19,%edx
8010295b:	77 4b                	ja     801029a8 <kbdgetc+0xb8>
      c += 'A' - 'a';
8010295d:	83 e8 20             	sub    $0x20,%eax
80102960:	c3                   	ret
80102961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80102968:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010296d:	c3                   	ret
8010296e:	66 90                	xchg   %ax,%ax
    shift |= E0ESC;
80102970:	83 ca 40             	or     $0x40,%edx
    return 0;
80102973:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102975:	89 15 80 26 11 80    	mov    %edx,0x80112680
    return 0;
8010297b:	c3                   	ret
8010297c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    data = (shift & E0ESC ? data : data & 0x7F);
80102980:	83 e0 7f             	and    $0x7f,%eax
80102983:	f6 c2 40             	test   $0x40,%dl
80102986:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102989:	0f b6 81 20 7f 10 80 	movzbl -0x7fef80e0(%ecx),%eax
80102990:	83 c8 40             	or     $0x40,%eax
80102993:	0f b6 c0             	movzbl %al,%eax
80102996:	f7 d0                	not    %eax
80102998:	21 d0                	and    %edx,%eax
8010299a:	a3 80 26 11 80       	mov    %eax,0x80112680
    return 0;
8010299f:	31 c0                	xor    %eax,%eax
801029a1:	c3                   	ret
801029a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
801029a8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801029ab:	8d 50 20             	lea    0x20(%eax),%edx
801029ae:	83 f9 1a             	cmp    $0x1a,%ecx
801029b1:	0f 42 c2             	cmovb  %edx,%eax
  return c;
801029b4:	c3                   	ret
801029b5:	8d 76 00             	lea    0x0(%esi),%esi
801029b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801029bf:	00 

801029c0 <kbdintr>:

void
kbdintr(void)
{
801029c0:	55                   	push   %ebp
801029c1:	89 e5                	mov    %esp,%ebp
801029c3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801029c6:	68 f0 28 10 80       	push   $0x801028f0
801029cb:	e8 40 df ff ff       	call   80100910 <consoleintr>
}
801029d0:	83 c4 10             	add    $0x10,%esp
801029d3:	c9                   	leave
801029d4:	c3                   	ret
801029d5:	66 90                	xchg   %ax,%ax
801029d7:	66 90                	xchg   %ax,%ax
801029d9:	66 90                	xchg   %ax,%ax
801029db:	66 90                	xchg   %ax,%ax
801029dd:	66 90                	xchg   %ax,%ax
801029df:	90                   	nop

801029e0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801029e0:	a1 84 26 11 80       	mov    0x80112684,%eax
801029e5:	85 c0                	test   %eax,%eax
801029e7:	0f 84 cc 00 00 00    	je     80102ab9 <lapicinit+0xd9>
  lapic[index] = value;
801029ed:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801029f4:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029f7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029fa:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102a01:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a04:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a07:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102a0e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102a11:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a14:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102a1b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102a1e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a21:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102a28:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a2b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a2e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102a35:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a38:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102a3b:	f7 40 30 00 00 fc 00 	testl  $0xfc0000,0x30(%eax)
80102a42:	75 7c                	jne    80102ac0 <lapicinit+0xe0>
  lapic[index] = value;
80102a44:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102a4b:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a4e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a51:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102a58:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a5b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a5e:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102a65:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a68:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a6b:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102a72:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a75:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a78:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102a7f:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a82:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a85:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102a8c:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102a8f:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102a92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102a98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102a9f:	00 
80102aa0:	f7 80 00 03 00 00 00 	testl  $0x1000,0x300(%eax)
80102aa7:	10 00 00 
80102aaa:	75 f4                	jne    80102aa0 <lapicinit+0xc0>
  lapic[index] = value;
80102aac:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102ab3:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ab6:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102ab9:	c3                   	ret
80102aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102ac0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102ac7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102aca:	8b 50 20             	mov    0x20(%eax),%edx
80102acd:	e9 72 ff ff ff       	jmp    80102a44 <lapicinit+0x64>
80102ad2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102ad8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102adf:	00 

80102ae0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102ae0:	a1 84 26 11 80       	mov    0x80112684,%eax
80102ae5:	85 c0                	test   %eax,%eax
80102ae7:	74 07                	je     80102af0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102ae9:	8b 40 20             	mov    0x20(%eax),%eax
80102aec:	c1 e8 18             	shr    $0x18,%eax
80102aef:	c3                   	ret
80102af0:	31 c0                	xor    %eax,%eax
}
80102af2:	c3                   	ret
80102af3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102af8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102aff:	00 

80102b00 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102b00:	a1 84 26 11 80       	mov    0x80112684,%eax
80102b05:	85 c0                	test   %eax,%eax
80102b07:	74 0d                	je     80102b16 <lapiceoi+0x16>
  lapic[index] = value;
80102b09:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102b10:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b13:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102b16:	c3                   	ret
80102b17:	90                   	nop
80102b18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102b1f:	00 

80102b20 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102b20:	c3                   	ret
80102b21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102b2f:	00 

80102b30 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102b30:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b31:	ba 70 00 00 00       	mov    $0x70,%edx
80102b36:	89 e5                	mov    %esp,%ebp
80102b38:	56                   	push   %esi
80102b39:	53                   	push   %ebx
80102b3a:	83 ec 04             	sub    $0x4,%esp
80102b3d:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
80102b41:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102b44:	88 45 f4             	mov    %al,-0xc(%ebp)
80102b47:	b8 0f 00 00 00       	mov    $0xf,%eax
80102b4c:	ee                   	out    %al,(%dx)
80102b4d:	b8 0a 00 00 00       	mov    $0xa,%eax
80102b52:	ba 71 00 00 00       	mov    $0x71,%edx
80102b57:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102b58:	31 c0                	xor    %eax,%eax
80102b5a:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102b60:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102b62:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102b65:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102b68:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102b6b:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102b71:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102b74:	a1 84 26 11 80       	mov    0x80112684,%eax
80102b79:	c1 e2 18             	shl    $0x18,%edx
80102b7c:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b82:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b85:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102b8c:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b8f:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b92:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102b99:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b9c:	8b 58 20             	mov    0x20(%eax),%ebx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102b9f:	bb 02 00 00 00       	mov    $0x2,%ebx
  lapic[index] = value;
80102ba4:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102baa:	8b 70 20             	mov    0x20(%eax),%esi
  lapic[index] = value;
80102bad:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102bb3:	8b 70 20             	mov    0x20(%eax),%esi
  for(i = 0; i < 2; i++){
80102bb6:	83 fb 01             	cmp    $0x1,%ebx
80102bb9:	75 0d                	jne    80102bc8 <lapicstartap+0x98>
    microdelay(200);
  }
}
80102bbb:	83 c4 04             	add    $0x4,%esp
80102bbe:	5b                   	pop    %ebx
80102bbf:	5e                   	pop    %esi
80102bc0:	5d                   	pop    %ebp
80102bc1:	c3                   	ret
80102bc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(i = 0; i < 2; i++){
80102bc8:	bb 01 00 00 00       	mov    $0x1,%ebx
80102bcd:	eb d5                	jmp    80102ba4 <lapicstartap+0x74>
80102bcf:	90                   	nop

80102bd0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102bd0:	55                   	push   %ebp
80102bd1:	b8 0b 00 00 00       	mov    $0xb,%eax
80102bd6:	ba 70 00 00 00       	mov    $0x70,%edx
80102bdb:	89 e5                	mov    %esp,%ebp
80102bdd:	83 ec 58             	sub    $0x58,%esp
80102be0:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80102be3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102be4:	ba 71 00 00 00       	mov    $0x71,%edx
80102be9:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bea:	88 45 b7             	mov    %al,-0x49(%ebp)
80102bed:	8d 76 00             	lea    0x0(%esi),%esi
80102bf0:	31 c0                	xor    %eax,%eax
80102bf2:	ba 70 00 00 00       	mov    $0x70,%edx
80102bf7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bf8:	ba 71 00 00 00       	mov    $0x71,%edx
80102bfd:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
80102bfe:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c01:	ba 70 00 00 00       	mov    $0x70,%edx
80102c06:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102c09:	b8 02 00 00 00       	mov    $0x2,%eax
80102c0e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c0f:	ba 71 00 00 00       	mov    $0x71,%edx
80102c14:	ec                   	in     (%dx),%al
80102c15:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c18:	ba 70 00 00 00       	mov    $0x70,%edx
80102c1d:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102c20:	b8 04 00 00 00       	mov    $0x4,%eax
80102c25:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c26:	ba 71 00 00 00       	mov    $0x71,%edx
80102c2b:	ec                   	in     (%dx),%al
80102c2c:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c2f:	ba 70 00 00 00       	mov    $0x70,%edx
80102c34:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102c37:	b8 07 00 00 00       	mov    $0x7,%eax
80102c3c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c3d:	ba 71 00 00 00       	mov    $0x71,%edx
80102c42:	ec                   	in     (%dx),%al
80102c43:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c46:	ba 70 00 00 00       	mov    $0x70,%edx
80102c4b:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102c4e:	b8 08 00 00 00       	mov    $0x8,%eax
80102c53:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c54:	ba 71 00 00 00       	mov    $0x71,%edx
80102c59:	ec                   	in     (%dx),%al
80102c5a:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c5d:	ba 70 00 00 00       	mov    $0x70,%edx
80102c62:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102c65:	b8 09 00 00 00       	mov    $0x9,%eax
80102c6a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c6b:	ba 71 00 00 00       	mov    $0x71,%edx
80102c70:	ec                   	in     (%dx),%al
80102c71:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c74:	ba 70 00 00 00       	mov    $0x70,%edx
80102c79:	89 45 cc             	mov    %eax,-0x34(%ebp)
80102c7c:	b8 0a 00 00 00       	mov    $0xa,%eax
80102c81:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c82:	ba 71 00 00 00       	mov    $0x71,%edx
80102c87:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102c88:	84 c0                	test   %al,%al
80102c8a:	0f 88 60 ff ff ff    	js     80102bf0 <cmostime+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c90:	31 c0                	xor    %eax,%eax
80102c92:	ba 70 00 00 00       	mov    $0x70,%edx
80102c97:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c98:	ba 71 00 00 00       	mov    $0x71,%edx
80102c9d:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
80102c9e:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ca1:	ba 70 00 00 00       	mov    $0x70,%edx
80102ca6:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102ca9:	b8 02 00 00 00       	mov    $0x2,%eax
80102cae:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102caf:	ba 71 00 00 00       	mov    $0x71,%edx
80102cb4:	ec                   	in     (%dx),%al
80102cb5:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cb8:	ba 70 00 00 00       	mov    $0x70,%edx
80102cbd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102cc0:	b8 04 00 00 00       	mov    $0x4,%eax
80102cc5:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cc6:	ba 71 00 00 00       	mov    $0x71,%edx
80102ccb:	ec                   	in     (%dx),%al
80102ccc:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ccf:	ba 70 00 00 00       	mov    $0x70,%edx
80102cd4:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102cd7:	b8 07 00 00 00       	mov    $0x7,%eax
80102cdc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cdd:	ba 71 00 00 00       	mov    $0x71,%edx
80102ce2:	ec                   	in     (%dx),%al
80102ce3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ce6:	ba 70 00 00 00       	mov    $0x70,%edx
80102ceb:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102cee:	b8 08 00 00 00       	mov    $0x8,%eax
80102cf3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cf4:	ba 71 00 00 00       	mov    $0x71,%edx
80102cf9:	ec                   	in     (%dx),%al
80102cfa:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cfd:	ba 70 00 00 00       	mov    $0x70,%edx
80102d02:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102d05:	b8 09 00 00 00       	mov    $0x9,%eax
80102d0a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d0b:	ba 71 00 00 00       	mov    $0x71,%edx
80102d10:	ec                   	in     (%dx),%al
80102d11:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102d14:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102d17:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102d1a:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102d1d:	6a 18                	push   $0x18
80102d1f:	50                   	push   %eax
80102d20:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102d23:	50                   	push   %eax
80102d24:	e8 17 1d 00 00       	call   80104a40 <memcmp>
80102d29:	83 c4 10             	add    $0x10,%esp
80102d2c:	85 c0                	test   %eax,%eax
80102d2e:	0f 85 bc fe ff ff    	jne    80102bf0 <cmostime+0x20>
      break;
  }

  // convert
  if(bcd) {
80102d34:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102d37:	f6 45 b7 04          	testb  $0x4,-0x49(%ebp)
80102d3b:	75 78                	jne    80102db5 <cmostime+0x1e5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102d3d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102d40:	89 c2                	mov    %eax,%edx
80102d42:	83 e0 0f             	and    $0xf,%eax
80102d45:	c1 ea 04             	shr    $0x4,%edx
80102d48:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d4b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d4e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102d51:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102d54:	89 c2                	mov    %eax,%edx
80102d56:	83 e0 0f             	and    $0xf,%eax
80102d59:	c1 ea 04             	shr    $0x4,%edx
80102d5c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d5f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d62:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102d65:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102d68:	89 c2                	mov    %eax,%edx
80102d6a:	83 e0 0f             	and    $0xf,%eax
80102d6d:	c1 ea 04             	shr    $0x4,%edx
80102d70:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d73:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d76:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102d79:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102d7c:	89 c2                	mov    %eax,%edx
80102d7e:	83 e0 0f             	and    $0xf,%eax
80102d81:	c1 ea 04             	shr    $0x4,%edx
80102d84:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d87:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d8a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102d8d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102d90:	89 c2                	mov    %eax,%edx
80102d92:	83 e0 0f             	and    $0xf,%eax
80102d95:	c1 ea 04             	shr    $0x4,%edx
80102d98:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d9b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d9e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102da1:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102da4:	89 c2                	mov    %eax,%edx
80102da6:	83 e0 0f             	and    $0xf,%eax
80102da9:	c1 ea 04             	shr    $0x4,%edx
80102dac:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102daf:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102db2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102db5:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102db8:	89 03                	mov    %eax,(%ebx)
80102dba:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102dbd:	89 43 04             	mov    %eax,0x4(%ebx)
80102dc0:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102dc3:	89 43 08             	mov    %eax,0x8(%ebx)
80102dc6:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102dc9:	89 43 0c             	mov    %eax,0xc(%ebx)
80102dcc:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102dcf:	89 43 10             	mov    %eax,0x10(%ebx)
80102dd2:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102dd5:	89 43 14             	mov    %eax,0x14(%ebx)
  r->year += 2000;
80102dd8:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
80102ddf:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80102de2:	c9                   	leave
80102de3:	c3                   	ret
80102de4:	66 90                	xchg   %ax,%ax
80102de6:	66 90                	xchg   %ax,%ax
80102de8:	66 90                	xchg   %ax,%ax
80102dea:	66 90                	xchg   %ax,%ax
80102dec:	66 90                	xchg   %ax,%ax
80102dee:	66 90                	xchg   %ax,%ax
80102df0:	66 90                	xchg   %ax,%ax
80102df2:	66 90                	xchg   %ax,%ax
80102df4:	66 90                	xchg   %ax,%ax
80102df6:	66 90                	xchg   %ax,%ax
80102df8:	66 90                	xchg   %ax,%ax
80102dfa:	66 90                	xchg   %ax,%ax
80102dfc:	66 90                	xchg   %ax,%ax
80102dfe:	66 90                	xchg   %ax,%ax

80102e00 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102e00:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102e06:	85 c9                	test   %ecx,%ecx
80102e08:	0f 8e 8a 00 00 00    	jle    80102e98 <install_trans+0x98>
{
80102e0e:	55                   	push   %ebp
80102e0f:	89 e5                	mov    %esp,%ebp
80102e11:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102e12:	31 ff                	xor    %edi,%edi
{
80102e14:	56                   	push   %esi
80102e15:	53                   	push   %ebx
80102e16:	83 ec 0c             	sub    $0xc,%esp
80102e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102e20:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102e25:	83 ec 08             	sub    $0x8,%esp
80102e28:	8d 44 38 01          	lea    0x1(%eax,%edi,1),%eax
80102e2c:	50                   	push   %eax
80102e2d:	ff 35 e4 26 11 80    	push   0x801126e4
80102e33:	e8 98 d2 ff ff       	call   801000d0 <bread>
80102e38:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102e3a:	58                   	pop    %eax
80102e3b:	5a                   	pop    %edx
80102e3c:	ff 34 bd ec 26 11 80 	push   -0x7feed914(,%edi,4)
80102e43:	ff 35 e4 26 11 80    	push   0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102e49:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102e4c:	e8 7f d2 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102e51:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102e54:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102e56:	8d 46 5c             	lea    0x5c(%esi),%eax
80102e59:	68 00 02 00 00       	push   $0x200
80102e5e:	50                   	push   %eax
80102e5f:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102e62:	50                   	push   %eax
80102e63:	e8 38 1c 00 00       	call   80104aa0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102e68:	89 1c 24             	mov    %ebx,(%esp)
80102e6b:	e8 50 d3 ff ff       	call   801001c0 <bwrite>
    brelse(lbuf);
80102e70:	89 34 24             	mov    %esi,(%esp)
80102e73:	e8 88 d3 ff ff       	call   80100200 <brelse>
    brelse(dbuf);
80102e78:	89 1c 24             	mov    %ebx,(%esp)
80102e7b:	e8 80 d3 ff ff       	call   80100200 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102e80:	83 c4 10             	add    $0x10,%esp
80102e83:	39 3d e8 26 11 80    	cmp    %edi,0x801126e8
80102e89:	7f 95                	jg     80102e20 <install_trans+0x20>
  }
}
80102e8b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e8e:	5b                   	pop    %ebx
80102e8f:	5e                   	pop    %esi
80102e90:	5f                   	pop    %edi
80102e91:	5d                   	pop    %ebp
80102e92:	c3                   	ret
80102e93:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e98:	c3                   	ret
80102e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ea0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102ea0:	55                   	push   %ebp
80102ea1:	89 e5                	mov    %esp,%ebp
80102ea3:	53                   	push   %ebx
80102ea4:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ea7:	ff 35 d4 26 11 80    	push   0x801126d4
80102ead:	ff 35 e4 26 11 80    	push   0x801126e4
80102eb3:	e8 18 d2 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102eb8:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ebb:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102ebd:	a1 e8 26 11 80       	mov    0x801126e8,%eax
80102ec2:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102ec5:	85 c0                	test   %eax,%eax
80102ec7:	7e 29                	jle    80102ef2 <write_head+0x52>
80102ec9:	31 d2                	xor    %edx,%edx
80102ecb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102ed0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102ed7:	00 
80102ed8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102edf:	00 
    hb->block[i] = log.lh.block[i];
80102ee0:	8b 0c 95 ec 26 11 80 	mov    -0x7feed914(,%edx,4),%ecx
80102ee7:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102eeb:	83 c2 01             	add    $0x1,%edx
80102eee:	39 d0                	cmp    %edx,%eax
80102ef0:	75 ee                	jne    80102ee0 <write_head+0x40>
  }
  bwrite(buf);
80102ef2:	83 ec 0c             	sub    $0xc,%esp
80102ef5:	53                   	push   %ebx
80102ef6:	e8 c5 d2 ff ff       	call   801001c0 <bwrite>
  brelse(buf);
80102efb:	89 1c 24             	mov    %ebx,(%esp)
80102efe:	e8 fd d2 ff ff       	call   80100200 <brelse>
}
80102f03:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f06:	83 c4 10             	add    $0x10,%esp
80102f09:	c9                   	leave
80102f0a:	c3                   	ret
80102f0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102f10 <initlog>:
{
80102f10:	55                   	push   %ebp
80102f11:	89 e5                	mov    %esp,%ebp
80102f13:	53                   	push   %ebx
80102f14:	83 ec 2c             	sub    $0x2c,%esp
80102f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102f1a:	68 37 79 10 80       	push   $0x80107937
80102f1f:	68 a0 26 11 80       	push   $0x801126a0
80102f24:	e8 97 17 00 00       	call   801046c0 <initlock>
  readsb(dev, &sb);
80102f29:	58                   	pop    %eax
80102f2a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102f2d:	5a                   	pop    %edx
80102f2e:	50                   	push   %eax
80102f2f:	53                   	push   %ebx
80102f30:	e8 bb e6 ff ff       	call   801015f0 <readsb>
  log.start = sb.logstart;
80102f35:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102f38:	59                   	pop    %ecx
  log.dev = dev;
80102f39:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
  log.size = sb.nlog;
80102f3f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102f42:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  log.size = sb.nlog;
80102f47:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
  struct buf *buf = bread(log.dev, log.start);
80102f4d:	5a                   	pop    %edx
80102f4e:	50                   	push   %eax
80102f4f:	53                   	push   %ebx
80102f50:	e8 7b d1 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102f55:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102f58:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102f5b:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102f61:	85 db                	test   %ebx,%ebx
80102f63:	7e 2d                	jle    80102f92 <initlog+0x82>
80102f65:	31 d2                	xor    %edx,%edx
80102f67:	eb 17                	jmp    80102f80 <initlog+0x70>
80102f69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f70:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f77:	00 
80102f78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f7f:	00 
    log.lh.block[i] = lh->block[i];
80102f80:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102f84:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102f8b:	83 c2 01             	add    $0x1,%edx
80102f8e:	39 d3                	cmp    %edx,%ebx
80102f90:	75 ee                	jne    80102f80 <initlog+0x70>
  brelse(buf);
80102f92:	83 ec 0c             	sub    $0xc,%esp
80102f95:	50                   	push   %eax
80102f96:	e8 65 d2 ff ff       	call   80100200 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102f9b:	e8 60 fe ff ff       	call   80102e00 <install_trans>
  log.lh.n = 0;
80102fa0:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102fa7:	00 00 00 
  write_head(); // clear the log
80102faa:	e8 f1 fe ff ff       	call   80102ea0 <write_head>
}
80102faf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102fb2:	83 c4 10             	add    $0x10,%esp
80102fb5:	c9                   	leave
80102fb6:	c3                   	ret
80102fb7:	90                   	nop
80102fb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102fbf:	00 

80102fc0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102fc0:	55                   	push   %ebp
80102fc1:	89 e5                	mov    %esp,%ebp
80102fc3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102fc6:	68 a0 26 11 80       	push   $0x801126a0
80102fcb:	e8 10 19 00 00       	call   801048e0 <acquire>
80102fd0:	83 c4 10             	add    $0x10,%esp
80102fd3:	eb 18                	jmp    80102fed <begin_op+0x2d>
80102fd5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102fd8:	83 ec 08             	sub    $0x8,%esp
80102fdb:	68 a0 26 11 80       	push   $0x801126a0
80102fe0:	68 a0 26 11 80       	push   $0x801126a0
80102fe5:	e8 46 13 00 00       	call   80104330 <sleep>
80102fea:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102fed:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102ff2:	85 c0                	test   %eax,%eax
80102ff4:	75 e2                	jne    80102fd8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102ff6:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102ffb:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80103001:	83 c0 01             	add    $0x1,%eax
80103004:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103007:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
8010300a:	83 fa 1e             	cmp    $0x1e,%edx
8010300d:	7f c9                	jg     80102fd8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
8010300f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80103012:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80103017:	68 a0 26 11 80       	push   $0x801126a0
8010301c:	e8 5f 18 00 00       	call   80104880 <release>
      break;
    }
  }
}
80103021:	83 c4 10             	add    $0x10,%esp
80103024:	c9                   	leave
80103025:	c3                   	ret
80103026:	66 90                	xchg   %ax,%ax
80103028:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010302f:	00 

80103030 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103030:	55                   	push   %ebp
80103031:	89 e5                	mov    %esp,%ebp
80103033:	83 ec 24             	sub    $0x24,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103036:	68 a0 26 11 80       	push   $0x801126a0
{
8010303b:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  acquire(&log.lock);
8010303e:	e8 9d 18 00 00       	call   801048e0 <acquire>
  log.outstanding -= 1;
80103043:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80103048:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
8010304b:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
8010304e:	a1 e0 26 11 80       	mov    0x801126e0,%eax
  log.outstanding -= 1;
80103053:	89 1d dc 26 11 80    	mov    %ebx,0x801126dc
  if(log.committing)
80103059:	85 c0                	test   %eax,%eax
8010305b:	0f 85 20 01 00 00    	jne    80103181 <end_op+0x151>
    panic("log.committing");
  if(log.outstanding == 0){
80103061:	85 db                	test   %ebx,%ebx
80103063:	0f 85 f7 00 00 00    	jne    80103160 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80103069:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80103070:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80103073:	83 ec 0c             	sub    $0xc,%esp
80103076:	68 a0 26 11 80       	push   $0x801126a0
8010307b:	e8 00 18 00 00       	call   80104880 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103080:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80103086:	83 c4 10             	add    $0x10,%esp
80103089:	85 c9                	test   %ecx,%ecx
8010308b:	7f 3b                	jg     801030c8 <end_op+0x98>
    acquire(&log.lock);
8010308d:	83 ec 0c             	sub    $0xc,%esp
80103090:	68 a0 26 11 80       	push   $0x801126a0
80103095:	e8 46 18 00 00       	call   801048e0 <acquire>
    wakeup(&log);
8010309a:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
    log.committing = 0;
801030a1:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
801030a8:	00 00 00 
    wakeup(&log);
801030ab:	e8 40 13 00 00       	call   801043f0 <wakeup>
    release(&log.lock);
801030b0:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
801030b7:	e8 c4 17 00 00       	call   80104880 <release>
}
801030bc:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    release(&log.lock);
801030bf:	83 c4 10             	add    $0x10,%esp
}
801030c2:	c9                   	leave
801030c3:	c3                   	ret
801030c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801030c8:	89 75 f8             	mov    %esi,-0x8(%ebp)
801030cb:	89 7d fc             	mov    %edi,-0x4(%ebp)
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
801030ce:	a1 d4 26 11 80       	mov    0x801126d4,%eax
801030d3:	83 ec 08             	sub    $0x8,%esp
801030d6:	8d 44 18 01          	lea    0x1(%eax,%ebx,1),%eax
801030da:	50                   	push   %eax
801030db:	ff 35 e4 26 11 80    	push   0x801126e4
801030e1:	e8 ea cf ff ff       	call   801000d0 <bread>
801030e6:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801030e8:	58                   	pop    %eax
801030e9:	5a                   	pop    %edx
801030ea:	ff 34 9d ec 26 11 80 	push   -0x7feed914(,%ebx,4)
801030f1:	ff 35 e4 26 11 80    	push   0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
801030f7:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801030fa:	e8 d1 cf ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
801030ff:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103102:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103104:	8d 40 5c             	lea    0x5c(%eax),%eax
80103107:	68 00 02 00 00       	push   $0x200
8010310c:	50                   	push   %eax
8010310d:	8d 46 5c             	lea    0x5c(%esi),%eax
80103110:	50                   	push   %eax
80103111:	e8 8a 19 00 00       	call   80104aa0 <memmove>
    bwrite(to);  // write the log
80103116:	89 34 24             	mov    %esi,(%esp)
80103119:	e8 a2 d0 ff ff       	call   801001c0 <bwrite>
    brelse(from);
8010311e:	89 3c 24             	mov    %edi,(%esp)
80103121:	e8 da d0 ff ff       	call   80100200 <brelse>
    brelse(to);
80103126:	89 34 24             	mov    %esi,(%esp)
80103129:	e8 d2 d0 ff ff       	call   80100200 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
8010312e:	83 c4 10             	add    $0x10,%esp
80103131:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80103137:	7c 95                	jl     801030ce <end_op+0x9e>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80103139:	e8 62 fd ff ff       	call   80102ea0 <write_head>
    install_trans(); // Now install writes to home locations
8010313e:	e8 bd fc ff ff       	call   80102e00 <install_trans>
    log.lh.n = 0;
80103143:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
8010314a:	00 00 00 
    write_head();    // Erase the transaction from the log
8010314d:	e8 4e fd ff ff       	call   80102ea0 <write_head>
80103152:	8b 75 f8             	mov    -0x8(%ebp),%esi
80103155:	8b 7d fc             	mov    -0x4(%ebp),%edi
80103158:	e9 30 ff ff ff       	jmp    8010308d <end_op+0x5d>
8010315d:	8d 76 00             	lea    0x0(%esi),%esi
    wakeup(&log);
80103160:	83 ec 0c             	sub    $0xc,%esp
80103163:	68 a0 26 11 80       	push   $0x801126a0
80103168:	e8 83 12 00 00       	call   801043f0 <wakeup>
  release(&log.lock);
8010316d:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80103174:	e8 07 17 00 00       	call   80104880 <release>
}
80103179:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  release(&log.lock);
8010317c:	83 c4 10             	add    $0x10,%esp
}
8010317f:	c9                   	leave
80103180:	c3                   	ret
    panic("log.committing");
80103181:	83 ec 0c             	sub    $0xc,%esp
80103184:	89 75 f8             	mov    %esi,-0x8(%ebp)
80103187:	68 3b 79 10 80       	push   $0x8010793b
8010318c:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010318f:	e8 0c d2 ff ff       	call   801003a0 <panic>
80103194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103198:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010319f:	00 

801031a0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801031a0:	55                   	push   %ebp
801031a1:	89 e5                	mov    %esp,%ebp
801031a3:	53                   	push   %ebx
801031a4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801031a7:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
{
801031ad:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801031b0:	83 fa 1d             	cmp    $0x1d,%edx
801031b3:	7f 7d                	jg     80103232 <log_write+0x92>
801031b5:	a1 d8 26 11 80       	mov    0x801126d8,%eax
801031ba:	83 e8 01             	sub    $0x1,%eax
801031bd:	39 c2                	cmp    %eax,%edx
801031bf:	7d 71                	jge    80103232 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
801031c1:	a1 dc 26 11 80       	mov    0x801126dc,%eax
801031c6:	85 c0                	test   %eax,%eax
801031c8:	7e 75                	jle    8010323f <log_write+0x9f>
    panic("log_write outside of trans");

  acquire(&log.lock);
801031ca:	83 ec 0c             	sub    $0xc,%esp
801031cd:	68 a0 26 11 80       	push   $0x801126a0
801031d2:	e8 09 17 00 00       	call   801048e0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
801031d7:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
801031da:	83 c4 10             	add    $0x10,%esp
801031dd:	31 c0                	xor    %eax,%eax
801031df:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
801031e5:	85 d2                	test   %edx,%edx
801031e7:	7f 0e                	jg     801031f7 <log_write+0x57>
801031e9:	eb 15                	jmp    80103200 <log_write+0x60>
801031eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801031f0:	83 c0 01             	add    $0x1,%eax
801031f3:	39 d0                	cmp    %edx,%eax
801031f5:	74 29                	je     80103220 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801031f7:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
801031fe:	75 f0                	jne    801031f0 <log_write+0x50>
  log.lh.block[i] = b->blockno;
80103200:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
  if (i == log.lh.n)
80103207:	39 c2                	cmp    %eax,%edx
80103209:	74 1c                	je     80103227 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
8010320b:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
8010320e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80103211:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80103218:	c9                   	leave
  release(&log.lock);
80103219:	e9 62 16 00 00       	jmp    80104880 <release>
8010321e:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
80103220:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
    log.lh.n++;
80103227:	83 c2 01             	add    $0x1,%edx
8010322a:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
80103230:	eb d9                	jmp    8010320b <log_write+0x6b>
    panic("too big a transaction");
80103232:	83 ec 0c             	sub    $0xc,%esp
80103235:	68 4a 79 10 80       	push   $0x8010794a
8010323a:	e8 61 d1 ff ff       	call   801003a0 <panic>
    panic("log_write outside of trans");
8010323f:	83 ec 0c             	sub    $0xc,%esp
80103242:	68 60 79 10 80       	push   $0x80107960
80103247:	e8 54 d1 ff ff       	call   801003a0 <panic>
8010324c:	66 90                	xchg   %ax,%ax
8010324e:	66 90                	xchg   %ax,%ax

80103250 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103250:	55                   	push   %ebp
80103251:	89 e5                	mov    %esp,%ebp
80103253:	53                   	push   %ebx
80103254:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103257:	e8 a4 09 00 00       	call   80103c00 <cpuid>
8010325c:	89 c3                	mov    %eax,%ebx
8010325e:	e8 9d 09 00 00       	call   80103c00 <cpuid>
80103263:	83 ec 04             	sub    $0x4,%esp
80103266:	53                   	push   %ebx
80103267:	50                   	push   %eax
80103268:	68 7b 79 10 80       	push   $0x8010797b
8010326d:	e8 7e d4 ff ff       	call   801006f0 <cprintf>
  idtinit();       // load idt register
80103272:	e8 79 2b 00 00       	call   80105df0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103277:	e8 04 09 00 00       	call   80103b80 <mycpu>
8010327c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010327e:	b8 01 00 00 00       	mov    $0x1,%eax
80103283:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010328a:	e8 61 0c 00 00       	call   80103ef0 <scheduler>
8010328f:	90                   	nop

80103290 <mpenter>:
{
80103290:	55                   	push   %ebp
80103291:	89 e5                	mov    %esp,%ebp
80103293:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103296:	e8 95 3c 00 00       	call   80106f30 <switchkvm>
  seginit();
8010329b:	e8 00 3c 00 00       	call   80106ea0 <seginit>
  lapicinit();
801032a0:	e8 3b f7 ff ff       	call   801029e0 <lapicinit>
  mpmain();
801032a5:	e8 a6 ff ff ff       	call   80103250 <mpmain>
801032aa:	66 90                	xchg   %ax,%ax
801032ac:	66 90                	xchg   %ax,%ax
801032ae:	66 90                	xchg   %ax,%ax

801032b0 <main>:
{
801032b0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801032b4:	83 e4 f0             	and    $0xfffffff0,%esp
801032b7:	ff 71 fc             	push   -0x4(%ecx)
801032ba:	55                   	push   %ebp
801032bb:	89 e5                	mov    %esp,%ebp
801032bd:	53                   	push   %ebx
801032be:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801032bf:	83 ec 08             	sub    $0x8,%esp
801032c2:	68 00 00 40 80       	push   $0x80400000
801032c7:	68 d0 64 11 80       	push   $0x801164d0
801032cc:	e8 df f4 ff ff       	call   801027b0 <kinit1>
  kvmalloc();      // kernel page table
801032d1:	e8 4a 41 00 00       	call   80107420 <kvmalloc>
  mpinit();        // detect other processors
801032d6:	e8 85 01 00 00       	call   80103460 <mpinit>
  lapicinit();     // interrupt controller
801032db:	e8 00 f7 ff ff       	call   801029e0 <lapicinit>
  seginit();       // segment descriptors
801032e0:	e8 bb 3b 00 00       	call   80106ea0 <seginit>
  picinit();       // disable pic
801032e5:	e8 66 03 00 00       	call   80103650 <picinit>
  ioapicinit();    // another interrupt controller
801032ea:	e8 51 f2 ff ff       	call   80102540 <ioapicinit>
  consoleinit();   // console hardware
801032ef:	e8 0c d8 ff ff       	call   80100b00 <consoleinit>
  uartinit();      // serial port
801032f4:	e8 07 2e 00 00       	call   80106100 <uartinit>
  pinit();         // process table
801032f9:	e8 62 08 00 00       	call   80103b60 <pinit>
  tvinit();        // trap vectors
801032fe:	e8 3d 2a 00 00       	call   80105d40 <tvinit>
  binit();         // buffer cache
80103303:	e8 38 cd ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103308:	e8 b3 db ff ff       	call   80100ec0 <fileinit>
  ideinit();       // disk 
8010330d:	e8 ee ef ff ff       	call   80102300 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103312:	83 c4 0c             	add    $0xc,%esp
80103315:	68 8a 00 00 00       	push   $0x8a
8010331a:	68 8c b4 10 80       	push   $0x8010b48c
8010331f:	68 00 70 00 80       	push   $0x80007000
80103324:	e8 77 17 00 00       	call   80104aa0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103329:	83 c4 10             	add    $0x10,%esp
8010332c:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
80103333:	00 00 00 
80103336:	05 a0 27 11 80       	add    $0x801127a0,%eax
8010333b:	3d a0 27 11 80       	cmp    $0x801127a0,%eax
80103340:	76 7e                	jbe    801033c0 <main+0x110>
80103342:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
80103347:	eb 20                	jmp    80103369 <main+0xb9>
80103349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103350:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
80103357:	00 00 00 
8010335a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103360:	05 a0 27 11 80       	add    $0x801127a0,%eax
80103365:	39 c3                	cmp    %eax,%ebx
80103367:	73 57                	jae    801033c0 <main+0x110>
    if(c == mycpu())  // We've started already.
80103369:	e8 12 08 00 00       	call   80103b80 <mycpu>
8010336e:	39 d8                	cmp    %ebx,%eax
80103370:	74 de                	je     80103350 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103372:	e8 a9 f4 ff ff       	call   80102820 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103377:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
8010337a:	c7 05 f8 6f 00 80 90 	movl   $0x80103290,0x80006ff8
80103381:	32 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103384:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010338b:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010338e:	05 00 10 00 00       	add    $0x1000,%eax
80103393:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103398:	0f b6 03             	movzbl (%ebx),%eax
8010339b:	68 00 70 00 00       	push   $0x7000
801033a0:	50                   	push   %eax
801033a1:	e8 8a f7 ff ff       	call   80102b30 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801033a6:	83 c4 10             	add    $0x10,%esp
801033a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033b0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801033b6:	85 c0                	test   %eax,%eax
801033b8:	74 f6                	je     801033b0 <main+0x100>
801033ba:	eb 94                	jmp    80103350 <main+0xa0>
801033bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801033c0:	83 ec 08             	sub    $0x8,%esp
801033c3:	68 00 00 00 8e       	push   $0x8e000000
801033c8:	68 00 00 40 80       	push   $0x80400000
801033cd:	e8 7e f3 ff ff       	call   80102750 <kinit2>
  userinit();      // first user process
801033d2:	e8 79 08 00 00       	call   80103c50 <userinit>
  mpmain();        // finish this processor's setup
801033d7:	e8 74 fe ff ff       	call   80103250 <mpmain>
801033dc:	66 90                	xchg   %ax,%ax
801033de:	66 90                	xchg   %ax,%ax

801033e0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801033e0:	55                   	push   %ebp
801033e1:	89 e5                	mov    %esp,%ebp
801033e3:	83 ec 18             	sub    $0x18,%esp
801033e6:	89 75 f8             	mov    %esi,-0x8(%ebp)
  uchar *e, *p, *addr;

  addr = P2V(a);
801033e9:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801033ef:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  e = addr+len;
801033f2:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
  for(p = addr; p < e; p += sizeof(struct mp))
801033f5:	39 de                	cmp    %ebx,%esi
801033f7:	73 5a                	jae    80103453 <mpsearch1+0x73>
801033f9:	89 7d fc             	mov    %edi,-0x4(%ebp)
801033fc:	eb 08                	jmp    80103406 <mpsearch1+0x26>
801033fe:	66 90                	xchg   %ax,%ax
80103400:	89 fe                	mov    %edi,%esi
80103402:	39 df                	cmp    %ebx,%edi
80103404:	73 4a                	jae    80103450 <mpsearch1+0x70>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103406:	83 ec 04             	sub    $0x4,%esp
80103409:	8d 7e 10             	lea    0x10(%esi),%edi
8010340c:	6a 04                	push   $0x4
8010340e:	68 8f 79 10 80       	push   $0x8010798f
80103413:	56                   	push   %esi
80103414:	e8 27 16 00 00       	call   80104a40 <memcmp>
80103419:	83 c4 10             	add    $0x10,%esp
8010341c:	85 c0                	test   %eax,%eax
8010341e:	75 e0                	jne    80103400 <mpsearch1+0x20>
80103420:	89 f2                	mov    %esi,%edx
80103422:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103428:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010342f:	00 
    sum += addr[i];
80103430:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103433:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103436:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103438:	39 fa                	cmp    %edi,%edx
8010343a:	75 f4                	jne    80103430 <mpsearch1+0x50>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010343c:	84 c0                	test   %al,%al
8010343e:	75 c0                	jne    80103400 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103440:	89 f0                	mov    %esi,%eax
80103442:	8b 7d fc             	mov    -0x4(%ebp),%edi
80103445:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80103448:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010344b:	c9                   	leave
8010344c:	c3                   	ret
8010344d:	8d 76 00             	lea    0x0(%esi),%esi
80103450:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return 0;
80103453:	31 f6                	xor    %esi,%esi
}
80103455:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80103458:	89 f0                	mov    %esi,%eax
8010345a:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010345d:	c9                   	leave
8010345e:	c3                   	ret
8010345f:	90                   	nop

80103460 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103460:	55                   	push   %ebp
80103461:	89 e5                	mov    %esp,%ebp
80103463:	57                   	push   %edi
80103464:	56                   	push   %esi
80103465:	53                   	push   %ebx
80103466:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103469:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103470:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103477:	c1 e0 08             	shl    $0x8,%eax
8010347a:	09 d0                	or     %edx,%eax
8010347c:	c1 e0 04             	shl    $0x4,%eax
8010347f:	75 1b                	jne    8010349c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103481:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103488:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010348f:	c1 e0 08             	shl    $0x8,%eax
80103492:	09 d0                	or     %edx,%eax
80103494:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103497:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010349c:	ba 00 04 00 00       	mov    $0x400,%edx
801034a1:	e8 3a ff ff ff       	call   801033e0 <mpsearch1>
801034a6:	89 c3                	mov    %eax,%ebx
801034a8:	85 c0                	test   %eax,%eax
801034aa:	0f 84 48 01 00 00    	je     801035f8 <mpinit+0x198>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801034b0:	8b 73 04             	mov    0x4(%ebx),%esi
801034b3:	85 f6                	test   %esi,%esi
801034b5:	0f 84 2d 01 00 00    	je     801035e8 <mpinit+0x188>
  if(memcmp(conf, "PCMP", 4) != 0)
801034bb:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801034be:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801034c4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801034c7:	6a 04                	push   $0x4
801034c9:	68 94 79 10 80       	push   $0x80107994
801034ce:	50                   	push   %eax
801034cf:	e8 6c 15 00 00       	call   80104a40 <memcmp>
801034d4:	83 c4 10             	add    $0x10,%esp
801034d7:	89 c2                	mov    %eax,%edx
801034d9:	85 c0                	test   %eax,%eax
801034db:	0f 85 07 01 00 00    	jne    801035e8 <mpinit+0x188>
  if(conf->version != 1 && conf->version != 4)
801034e1:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
801034e8:	3c 01                	cmp    $0x1,%al
801034ea:	74 08                	je     801034f4 <mpinit+0x94>
801034ec:	3c 04                	cmp    $0x4,%al
801034ee:	0f 85 f4 00 00 00    	jne    801035e8 <mpinit+0x188>
  if(sum((uchar*)conf, conf->length) != 0)
801034f4:	0f b7 8e 04 00 00 80 	movzwl -0x7ffffffc(%esi),%ecx
  for(i=0; i<len; i++)
801034fb:	66 85 c9             	test   %cx,%cx
801034fe:	74 28                	je     80103528 <mpinit+0xc8>
80103500:	89 f0                	mov    %esi,%eax
80103502:	8d 3c 31             	lea    (%ecx,%esi,1),%edi
80103505:	8d 76 00             	lea    0x0(%esi),%esi
80103508:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010350f:	00 
    sum += addr[i];
80103510:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
80103517:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
8010351a:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
8010351c:	39 c7                	cmp    %eax,%edi
8010351e:	75 f0                	jne    80103510 <mpinit+0xb0>
  if(sum((uchar*)conf, conf->length) != 0)
80103520:	84 d2                	test   %dl,%dl
80103522:	0f 85 c0 00 00 00    	jne    801035e8 <mpinit+0x188>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103528:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010352e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  lapic = (uint*)conf->lapicaddr;
80103531:	a3 84 26 11 80       	mov    %eax,0x80112684
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103536:	0f b7 8e 04 00 00 80 	movzwl -0x7ffffffc(%esi),%ecx
8010353d:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
80103543:	01 f9                	add    %edi,%ecx
80103545:	39 c8                	cmp    %ecx,%eax
80103547:	72 14                	jb     8010355d <mpinit+0xfd>
80103549:	eb 2b                	jmp    80103576 <mpinit+0x116>
8010354b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    switch(*p){
80103550:	77 7e                	ja     801035d0 <mpinit+0x170>
80103552:	84 d2                	test   %dl,%dl
80103554:	74 4a                	je     801035a0 <mpinit+0x140>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103556:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103559:	39 c8                	cmp    %ecx,%eax
8010355b:	73 19                	jae    80103576 <mpinit+0x116>
    switch(*p){
8010355d:	0f b6 10             	movzbl (%eax),%edx
80103560:	80 fa 02             	cmp    $0x2,%dl
80103563:	75 eb                	jne    80103550 <mpinit+0xf0>
      ioapicid = ioapic->apicno;
80103565:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
80103569:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010356c:	88 15 80 27 11 80    	mov    %dl,0x80112780
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103572:	39 c8                	cmp    %ecx,%eax
80103574:	72 e7                	jb     8010355d <mpinit+0xfd>
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103576:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
8010357a:	74 15                	je     80103591 <mpinit+0x131>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010357c:	b8 70 00 00 00       	mov    $0x70,%eax
80103581:	ba 22 00 00 00       	mov    $0x22,%edx
80103586:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103587:	ba 23 00 00 00       	mov    $0x23,%edx
8010358c:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
8010358d:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103590:	ee                   	out    %al,(%dx)
  }
}
80103591:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103594:	5b                   	pop    %ebx
80103595:	5e                   	pop    %esi
80103596:	5f                   	pop    %edi
80103597:	5d                   	pop    %ebp
80103598:	c3                   	ret
80103599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
801035a0:	8b 35 84 27 11 80    	mov    0x80112784,%esi
801035a6:	83 fe 07             	cmp    $0x7,%esi
801035a9:	7f 19                	jg     801035c4 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801035ab:	69 fe b0 00 00 00    	imul   $0xb0,%esi,%edi
801035b1:	0f b6 50 01          	movzbl 0x1(%eax),%edx
        ncpu++;
801035b5:	83 c6 01             	add    $0x1,%esi
801035b8:	89 35 84 27 11 80    	mov    %esi,0x80112784
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801035be:	88 97 a0 27 11 80    	mov    %dl,-0x7feed860(%edi)
      p += sizeof(struct mpproc);
801035c4:	83 c0 14             	add    $0x14,%eax
      continue;
801035c7:	eb 90                	jmp    80103559 <mpinit+0xf9>
801035c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(*p){
801035d0:	83 ea 03             	sub    $0x3,%edx
801035d3:	80 fa 01             	cmp    $0x1,%dl
801035d6:	0f 86 7a ff ff ff    	jbe    80103556 <mpinit+0xf6>
801035dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035e0:	eb fe                	jmp    801035e0 <mpinit+0x180>
801035e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
801035e8:	83 ec 0c             	sub    $0xc,%esp
801035eb:	68 99 79 10 80       	push   $0x80107999
801035f0:	e8 ab cd ff ff       	call   801003a0 <panic>
801035f5:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = addr; p < e; p += sizeof(struct mp))
801035f8:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
801035fd:	eb 0b                	jmp    8010360a <mpinit+0x1aa>
801035ff:	90                   	nop
80103600:	89 f3                	mov    %esi,%ebx
80103602:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103608:	74 de                	je     801035e8 <mpinit+0x188>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010360a:	83 ec 04             	sub    $0x4,%esp
8010360d:	8d 73 10             	lea    0x10(%ebx),%esi
80103610:	6a 04                	push   $0x4
80103612:	68 8f 79 10 80       	push   $0x8010798f
80103617:	53                   	push   %ebx
80103618:	e8 23 14 00 00       	call   80104a40 <memcmp>
8010361d:	83 c4 10             	add    $0x10,%esp
80103620:	85 c0                	test   %eax,%eax
80103622:	75 dc                	jne    80103600 <mpinit+0x1a0>
80103624:	89 da                	mov    %ebx,%edx
80103626:	66 90                	xchg   %ax,%ax
80103628:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010362f:	00 
    sum += addr[i];
80103630:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103633:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103636:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103638:	39 d6                	cmp    %edx,%esi
8010363a:	75 f4                	jne    80103630 <mpinit+0x1d0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010363c:	84 c0                	test   %al,%al
8010363e:	75 c0                	jne    80103600 <mpinit+0x1a0>
80103640:	e9 6b fe ff ff       	jmp    801034b0 <mpinit+0x50>
80103645:	66 90                	xchg   %ax,%ax
80103647:	66 90                	xchg   %ax,%ax
80103649:	66 90                	xchg   %ax,%ax
8010364b:	66 90                	xchg   %ax,%ax
8010364d:	66 90                	xchg   %ax,%ax
8010364f:	90                   	nop

80103650 <picinit>:
80103650:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103655:	ba 21 00 00 00       	mov    $0x21,%edx
8010365a:	ee                   	out    %al,(%dx)
8010365b:	ba a1 00 00 00       	mov    $0xa1,%edx
80103660:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103661:	c3                   	ret
80103662:	66 90                	xchg   %ax,%ax
80103664:	66 90                	xchg   %ax,%ax
80103666:	66 90                	xchg   %ax,%ax
80103668:	66 90                	xchg   %ax,%ax
8010366a:	66 90                	xchg   %ax,%ax
8010366c:	66 90                	xchg   %ax,%ax
8010366e:	66 90                	xchg   %ax,%ax
80103670:	66 90                	xchg   %ax,%ax
80103672:	66 90                	xchg   %ax,%ax
80103674:	66 90                	xchg   %ax,%ax
80103676:	66 90                	xchg   %ax,%ax
80103678:	66 90                	xchg   %ax,%ax
8010367a:	66 90                	xchg   %ax,%ax
8010367c:	66 90                	xchg   %ax,%ax
8010367e:	66 90                	xchg   %ax,%ax

80103680 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103680:	55                   	push   %ebp
80103681:	89 e5                	mov    %esp,%ebp
80103683:	56                   	push   %esi
80103684:	53                   	push   %ebx
80103685:	83 ec 10             	sub    $0x10,%esp
80103688:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010368b:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010368e:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103694:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010369a:	e8 41 d8 ff ff       	call   80100ee0 <filealloc>
8010369f:	89 03                	mov    %eax,(%ebx)
801036a1:	85 c0                	test   %eax,%eax
801036a3:	0f 84 a9 00 00 00    	je     80103752 <pipealloc+0xd2>
801036a9:	e8 32 d8 ff ff       	call   80100ee0 <filealloc>
801036ae:	89 06                	mov    %eax,(%esi)
801036b0:	85 c0                	test   %eax,%eax
801036b2:	0f 84 88 00 00 00    	je     80103740 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801036b8:	e8 63 f1 ff ff       	call   80102820 <kalloc>
801036bd:	85 c0                	test   %eax,%eax
801036bf:	0f 84 ab 00 00 00    	je     80103770 <pipealloc+0xf0>
    goto bad;
  p->readopen = 1;
801036c5:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801036cc:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
801036cf:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
801036d2:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801036d9:	00 00 00 
  p->nwrite = 0;
801036dc:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801036e3:	00 00 00 
  p->nread = 0;
801036e6:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801036ed:	00 00 00 
  initlock(&p->lock, "pipe");
801036f0:	68 b1 79 10 80       	push   $0x801079b1
801036f5:	50                   	push   %eax
801036f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
801036f9:	e8 c2 0f 00 00       	call   801046c0 <initlock>
  (*f0)->type = FD_PIPE;
801036fe:	8b 13                	mov    (%ebx),%edx
  (*f0)->readable = 1;
  (*f0)->writable = 0;
  (*f0)->pipe = p;
80103700:	8b 45 f4             	mov    -0xc(%ebp),%eax
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103703:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103706:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
  (*f0)->readable = 1;
8010370c:	8b 13                	mov    (%ebx),%edx
8010370e:	c6 42 08 01          	movb   $0x1,0x8(%edx)
  (*f0)->writable = 0;
80103712:	8b 13                	mov    (%ebx),%edx
80103714:	c6 42 09 00          	movb   $0x0,0x9(%edx)
  (*f0)->pipe = p;
80103718:	8b 13                	mov    (%ebx),%edx
8010371a:	89 42 0c             	mov    %eax,0xc(%edx)
  (*f1)->type = FD_PIPE;
8010371d:	8b 16                	mov    (%esi),%edx
8010371f:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
  (*f1)->readable = 0;
80103725:	8b 16                	mov    (%esi),%edx
80103727:	c6 42 08 00          	movb   $0x0,0x8(%edx)
  (*f1)->writable = 1;
8010372b:	8b 16                	mov    (%esi),%edx
8010372d:	c6 42 09 01          	movb   $0x1,0x9(%edx)
  (*f1)->pipe = p;
80103731:	8b 16                	mov    (%esi),%edx
80103733:	89 42 0c             	mov    %eax,0xc(%edx)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103736:	8d 65 f8             	lea    -0x8(%ebp),%esp
  return 0;
80103739:	31 c0                	xor    %eax,%eax
}
8010373b:	5b                   	pop    %ebx
8010373c:	5e                   	pop    %esi
8010373d:	5d                   	pop    %ebp
8010373e:	c3                   	ret
8010373f:	90                   	nop
  if(*f0)
80103740:	8b 03                	mov    (%ebx),%eax
80103742:	85 c0                	test   %eax,%eax
80103744:	74 1e                	je     80103764 <pipealloc+0xe4>
    fileclose(*f0);
80103746:	83 ec 0c             	sub    $0xc,%esp
80103749:	50                   	push   %eax
8010374a:	e8 51 d8 ff ff       	call   80100fa0 <fileclose>
8010374f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103752:	8b 06                	mov    (%esi),%eax
80103754:	85 c0                	test   %eax,%eax
80103756:	74 0c                	je     80103764 <pipealloc+0xe4>
    fileclose(*f1);
80103758:	83 ec 0c             	sub    $0xc,%esp
8010375b:	50                   	push   %eax
8010375c:	e8 3f d8 ff ff       	call   80100fa0 <fileclose>
80103761:	83 c4 10             	add    $0x10,%esp
}
80103764:	8d 65 f8             	lea    -0x8(%ebp),%esp
  return -1;
80103767:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010376c:	5b                   	pop    %ebx
8010376d:	5e                   	pop    %esi
8010376e:	5d                   	pop    %ebp
8010376f:	c3                   	ret
  if(*f0)
80103770:	8b 03                	mov    (%ebx),%eax
80103772:	85 c0                	test   %eax,%eax
80103774:	75 d0                	jne    80103746 <pipealloc+0xc6>
80103776:	eb da                	jmp    80103752 <pipealloc+0xd2>
80103778:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010377f:	00 

80103780 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103780:	55                   	push   %ebp
80103781:	89 e5                	mov    %esp,%ebp
80103783:	56                   	push   %esi
80103784:	53                   	push   %ebx
80103785:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103788:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010378b:	83 ec 0c             	sub    $0xc,%esp
8010378e:	53                   	push   %ebx
8010378f:	e8 4c 11 00 00       	call   801048e0 <acquire>
  if(writable){
80103794:	83 c4 10             	add    $0x10,%esp
80103797:	85 f6                	test   %esi,%esi
80103799:	74 45                	je     801037e0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010379b:	83 ec 0c             	sub    $0xc,%esp
8010379e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
801037a4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801037ab:	00 00 00 
    wakeup(&p->nread);
801037ae:	50                   	push   %eax
801037af:	e8 3c 0c 00 00       	call   801043f0 <wakeup>
801037b4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801037b7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801037bd:	85 d2                	test   %edx,%edx
801037bf:	75 0a                	jne    801037cb <pipeclose+0x4b>
801037c1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801037c7:	85 c0                	test   %eax,%eax
801037c9:	74 35                	je     80103800 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801037cb:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801037ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801037d1:	5b                   	pop    %ebx
801037d2:	5e                   	pop    %esi
801037d3:	5d                   	pop    %ebp
    release(&p->lock);
801037d4:	e9 a7 10 00 00       	jmp    80104880 <release>
801037d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801037e0:	83 ec 0c             	sub    $0xc,%esp
801037e3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801037e9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801037f0:	00 00 00 
    wakeup(&p->nwrite);
801037f3:	50                   	push   %eax
801037f4:	e8 f7 0b 00 00       	call   801043f0 <wakeup>
801037f9:	83 c4 10             	add    $0x10,%esp
801037fc:	eb b9                	jmp    801037b7 <pipeclose+0x37>
801037fe:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103800:	83 ec 0c             	sub    $0xc,%esp
80103803:	53                   	push   %ebx
80103804:	e8 77 10 00 00       	call   80104880 <release>
    kfree((char*)p);
80103809:	83 c4 10             	add    $0x10,%esp
8010380c:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010380f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103812:	5b                   	pop    %ebx
80103813:	5e                   	pop    %esi
80103814:	5d                   	pop    %ebp
    kfree((char*)p);
80103815:	e9 26 ee ff ff       	jmp    80102640 <kfree>
8010381a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103820 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103820:	55                   	push   %ebp
80103821:	89 e5                	mov    %esp,%ebp
80103823:	83 ec 34             	sub    $0x34,%esp
80103826:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80103829:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010382c:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010382f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
80103832:	53                   	push   %ebx
80103833:	e8 a8 10 00 00       	call   801048e0 <acquire>
  for(i = 0; i < n; i++){
80103838:	83 c4 10             	add    $0x10,%esp
8010383b:	85 ff                	test   %edi,%edi
8010383d:	0f 8e d4 00 00 00    	jle    80103917 <pipewrite+0xf7>
80103843:	89 75 f8             	mov    %esi,-0x8(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103846:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
8010384c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010384f:	89 7d 10             	mov    %edi,0x10(%ebp)
80103852:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103855:	8d 34 39             	lea    (%ecx,%edi,1),%esi
80103858:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
8010385b:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103861:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103867:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010386d:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
80103873:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
80103876:	0f 85 b9 00 00 00    	jne    80103935 <pipewrite+0x115>
8010387c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010387f:	eb 3d                	jmp    801038be <pipewrite+0x9e>
80103881:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80103888:	e8 93 03 00 00       	call   80103c20 <myproc>
8010388d:	8b 48 24             	mov    0x24(%eax),%ecx
80103890:	85 c9                	test   %ecx,%ecx
80103892:	75 34                	jne    801038c8 <pipewrite+0xa8>
      wakeup(&p->nread);
80103894:	83 ec 0c             	sub    $0xc,%esp
80103897:	56                   	push   %esi
80103898:	e8 53 0b 00 00       	call   801043f0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010389d:	58                   	pop    %eax
8010389e:	5a                   	pop    %edx
8010389f:	53                   	push   %ebx
801038a0:	57                   	push   %edi
801038a1:	e8 8a 0a 00 00       	call   80104330 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801038a6:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801038ac:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801038b2:	83 c4 10             	add    $0x10,%esp
801038b5:	05 00 02 00 00       	add    $0x200,%eax
801038ba:	39 c2                	cmp    %eax,%edx
801038bc:	75 2a                	jne    801038e8 <pipewrite+0xc8>
      if(p->readopen == 0 || myproc()->killed){
801038be:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801038c4:	85 c0                	test   %eax,%eax
801038c6:	75 c0                	jne    80103888 <pipewrite+0x68>
        release(&p->lock);
801038c8:	83 ec 0c             	sub    $0xc,%esp
801038cb:	53                   	push   %ebx
801038cc:	e8 af 0f 00 00       	call   80104880 <release>
        return -1;
801038d1:	8b 75 f8             	mov    -0x8(%ebp),%esi
801038d4:	83 c4 10             	add    $0x10,%esp
801038d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801038dc:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801038df:	8b 7d fc             	mov    -0x4(%ebp),%edi
801038e2:	c9                   	leave
801038e3:	c3                   	ret
801038e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038e8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801038eb:	8d 42 01             	lea    0x1(%edx),%eax
801038ee:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  for(i = 0; i < n; i++){
801038f4:	83 c1 01             	add    $0x1,%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801038f7:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801038fd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103900:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
80103904:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103908:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
8010390b:	0f 85 50 ff ff ff    	jne    80103861 <pipewrite+0x41>
80103911:	8b 7d 10             	mov    0x10(%ebp),%edi
80103914:	8b 75 f8             	mov    -0x8(%ebp),%esi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103917:	83 ec 0c             	sub    $0xc,%esp
8010391a:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103920:	50                   	push   %eax
80103921:	e8 ca 0a 00 00       	call   801043f0 <wakeup>
  release(&p->lock);
80103926:	89 1c 24             	mov    %ebx,(%esp)
80103929:	e8 52 0f 00 00       	call   80104880 <release>
  return n;
8010392e:	83 c4 10             	add    $0x10,%esp
80103931:	89 f8                	mov    %edi,%eax
80103933:	eb a7                	jmp    801038dc <pipewrite+0xbc>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103935:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103938:	eb b1                	jmp    801038eb <pipewrite+0xcb>
8010393a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103940 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	57                   	push   %edi
80103944:	56                   	push   %esi
80103945:	53                   	push   %ebx
80103946:	83 ec 18             	sub    $0x18,%esp
80103949:	8b 75 08             	mov    0x8(%ebp),%esi
8010394c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010394f:	56                   	push   %esi
80103950:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103956:	e8 85 0f 00 00       	call   801048e0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010395b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103961:	83 c4 10             	add    $0x10,%esp
80103964:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010396a:	74 2f                	je     8010399b <piperead+0x5b>
8010396c:	eb 37                	jmp    801039a5 <piperead+0x65>
8010396e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80103970:	e8 ab 02 00 00       	call   80103c20 <myproc>
80103975:	8b 48 24             	mov    0x24(%eax),%ecx
80103978:	85 c9                	test   %ecx,%ecx
8010397a:	0f 85 90 00 00 00    	jne    80103a10 <piperead+0xd0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103980:	83 ec 08             	sub    $0x8,%esp
80103983:	56                   	push   %esi
80103984:	53                   	push   %ebx
80103985:	e8 a6 09 00 00       	call   80104330 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010398a:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103990:	83 c4 10             	add    $0x10,%esp
80103993:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103999:	75 0a                	jne    801039a5 <piperead+0x65>
8010399b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801039a1:	85 d2                	test   %edx,%edx
801039a3:	75 cb                	jne    80103970 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801039a5:	8b 55 10             	mov    0x10(%ebp),%edx
801039a8:	31 db                	xor    %ebx,%ebx
801039aa:	85 d2                	test   %edx,%edx
801039ac:	7f 36                	jg     801039e4 <piperead+0xa4>
801039ae:	eb 3c                	jmp    801039ec <piperead+0xac>
801039b0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801039b7:	00 
801039b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801039bf:	00 
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801039c0:	8d 48 01             	lea    0x1(%eax),%ecx
801039c3:	25 ff 01 00 00       	and    $0x1ff,%eax
801039c8:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
801039ce:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
801039d3:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801039d6:	83 c3 01             	add    $0x1,%ebx
801039d9:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801039dc:	74 0e                	je     801039ec <piperead+0xac>
801039de:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
    if(p->nread == p->nwrite)
801039e4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801039ea:	75 d4                	jne    801039c0 <piperead+0x80>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801039ec:	83 ec 0c             	sub    $0xc,%esp
801039ef:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801039f5:	50                   	push   %eax
801039f6:	e8 f5 09 00 00       	call   801043f0 <wakeup>
  release(&p->lock);
801039fb:	89 34 24             	mov    %esi,(%esp)
801039fe:	e8 7d 0e 00 00       	call   80104880 <release>
  return i;
80103a03:	83 c4 10             	add    $0x10,%esp
}
80103a06:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a09:	89 d8                	mov    %ebx,%eax
80103a0b:	5b                   	pop    %ebx
80103a0c:	5e                   	pop    %esi
80103a0d:	5f                   	pop    %edi
80103a0e:	5d                   	pop    %ebp
80103a0f:	c3                   	ret
      release(&p->lock);
80103a10:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103a13:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103a18:	56                   	push   %esi
80103a19:	e8 62 0e 00 00       	call   80104880 <release>
      return -1;
80103a1e:	83 c4 10             	add    $0x10,%esp
}
80103a21:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a24:	89 d8                	mov    %ebx,%eax
80103a26:	5b                   	pop    %ebx
80103a27:	5e                   	pop    %esi
80103a28:	5f                   	pop    %edi
80103a29:	5d                   	pop    %ebp
80103a2a:	c3                   	ret
80103a2b:	66 90                	xchg   %ax,%ax
80103a2d:	66 90                	xchg   %ax,%ax
80103a2f:	66 90                	xchg   %ax,%ax
80103a31:	66 90                	xchg   %ax,%ax
80103a33:	66 90                	xchg   %ax,%ax
80103a35:	66 90                	xchg   %ax,%ax
80103a37:	66 90                	xchg   %ax,%ax
80103a39:	66 90                	xchg   %ax,%ax
80103a3b:	66 90                	xchg   %ax,%ax
80103a3d:	66 90                	xchg   %ax,%ax
80103a3f:	90                   	nop

80103a40 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103a40:	55                   	push   %ebp
80103a41:	89 e5                	mov    %esp,%ebp
80103a43:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a44:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
80103a49:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103a4c:	68 20 2d 11 80       	push   $0x80112d20
80103a51:	e8 8a 0e 00 00       	call   801048e0 <acquire>
80103a56:	83 c4 10             	add    $0x10,%esp
80103a59:	eb 10                	jmp    80103a6b <allocproc+0x2b>
80103a5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a60:	83 c3 7c             	add    $0x7c,%ebx
80103a63:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103a69:	74 75                	je     80103ae0 <allocproc+0xa0>
    if(p->state == UNUSED)
80103a6b:	8b 43 0c             	mov    0xc(%ebx),%eax
80103a6e:	85 c0                	test   %eax,%eax
80103a70:	75 ee                	jne    80103a60 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103a72:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
80103a77:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103a7a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103a81:	89 43 10             	mov    %eax,0x10(%ebx)
80103a84:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80103a87:	68 20 2d 11 80       	push   $0x80112d20
  p->pid = nextpid++;
80103a8c:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80103a92:	e8 e9 0d 00 00       	call   80104880 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103a97:	e8 84 ed ff ff       	call   80102820 <kalloc>
80103a9c:	83 c4 10             	add    $0x10,%esp
80103a9f:	89 43 08             	mov    %eax,0x8(%ebx)
80103aa2:	85 c0                	test   %eax,%eax
80103aa4:	74 53                	je     80103af9 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103aa6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103aac:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103aaf:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103ab4:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103ab7:	c7 40 14 2f 5d 10 80 	movl   $0x80105d2f,0x14(%eax)
  p->context = (struct context*)sp;
80103abe:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103ac1:	6a 14                	push   $0x14
80103ac3:	6a 00                	push   $0x0
80103ac5:	50                   	push   %eax
80103ac6:	e8 35 0f 00 00       	call   80104a00 <memset>
  p->context->eip = (uint)forkret;
80103acb:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103ace:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103ad1:	c7 40 10 10 3b 10 80 	movl   $0x80103b10,0x10(%eax)
}
80103ad8:	89 d8                	mov    %ebx,%eax
80103ada:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103add:	c9                   	leave
80103ade:	c3                   	ret
80103adf:	90                   	nop
  release(&ptable.lock);
80103ae0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103ae3:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103ae5:	68 20 2d 11 80       	push   $0x80112d20
80103aea:	e8 91 0d 00 00       	call   80104880 <release>
}
80103aef:	89 d8                	mov    %ebx,%eax
  return 0;
80103af1:	83 c4 10             	add    $0x10,%esp
}
80103af4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103af7:	c9                   	leave
80103af8:	c3                   	ret
    p->state = UNUSED;
80103af9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80103b00:	31 db                	xor    %ebx,%ebx
}
80103b02:	89 d8                	mov    %ebx,%eax
80103b04:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b07:	c9                   	leave
80103b08:	c3                   	ret
80103b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103b10 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103b10:	55                   	push   %ebp
80103b11:	89 e5                	mov    %esp,%ebp
80103b13:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103b16:	68 20 2d 11 80       	push   $0x80112d20
80103b1b:	e8 60 0d 00 00       	call   80104880 <release>

  if (first) {
80103b20:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103b25:	83 c4 10             	add    $0x10,%esp
80103b28:	85 c0                	test   %eax,%eax
80103b2a:	75 04                	jne    80103b30 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103b2c:	c9                   	leave
80103b2d:	c3                   	ret
80103b2e:	66 90                	xchg   %ax,%ax
    first = 0;
80103b30:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103b37:	00 00 00 
    iinit(ROOTDEV);
80103b3a:	83 ec 0c             	sub    $0xc,%esp
80103b3d:	6a 01                	push   $0x1
80103b3f:	e8 ec da ff ff       	call   80101630 <iinit>
    initlog(ROOTDEV);
80103b44:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103b4b:	e8 c0 f3 ff ff       	call   80102f10 <initlog>
80103b50:	83 c4 10             	add    $0x10,%esp
}
80103b53:	c9                   	leave
80103b54:	c3                   	ret
80103b55:	8d 76 00             	lea    0x0(%esi),%esi
80103b58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103b5f:	00 

80103b60 <pinit>:
{
80103b60:	55                   	push   %ebp
80103b61:	89 e5                	mov    %esp,%ebp
80103b63:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103b66:	68 b6 79 10 80       	push   $0x801079b6
80103b6b:	68 20 2d 11 80       	push   $0x80112d20
80103b70:	e8 4b 0b 00 00       	call   801046c0 <initlock>
}
80103b75:	83 c4 10             	add    $0x10,%esp
80103b78:	c9                   	leave
80103b79:	c3                   	ret
80103b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103b80 <mycpu>:
{
80103b80:	55                   	push   %ebp
80103b81:	89 e5                	mov    %esp,%ebp
80103b83:	56                   	push   %esi
80103b84:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103b85:	9c                   	pushf
80103b86:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103b87:	f6 c4 02             	test   $0x2,%ah
80103b8a:	75 65                	jne    80103bf1 <mycpu+0x71>
  apicid = lapicid();
80103b8c:	e8 4f ef ff ff       	call   80102ae0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103b91:	8b 1d 84 27 11 80    	mov    0x80112784,%ebx
  apicid = lapicid();
80103b97:	89 c6                	mov    %eax,%esi
  for (i = 0; i < ncpu; ++i) {
80103b99:	85 db                	test   %ebx,%ebx
80103b9b:	7e 47                	jle    80103be4 <mycpu+0x64>
80103b9d:	31 d2                	xor    %edx,%edx
80103b9f:	eb 26                	jmp    80103bc7 <mycpu+0x47>
80103ba1:	eb 1d                	jmp    80103bc0 <mycpu+0x40>
80103ba3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103ba8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103baf:	00 
80103bb0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103bb7:	00 
80103bb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103bbf:	00 
80103bc0:	83 c2 01             	add    $0x1,%edx
80103bc3:	39 da                	cmp    %ebx,%edx
80103bc5:	74 1d                	je     80103be4 <mycpu+0x64>
    if (cpus[i].apicid == apicid)
80103bc7:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
80103bcd:	0f b6 88 a0 27 11 80 	movzbl -0x7feed860(%eax),%ecx
80103bd4:	39 f1                	cmp    %esi,%ecx
80103bd6:	75 e8                	jne    80103bc0 <mycpu+0x40>
}
80103bd8:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103bdb:	05 a0 27 11 80       	add    $0x801127a0,%eax
}
80103be0:	5b                   	pop    %ebx
80103be1:	5e                   	pop    %esi
80103be2:	5d                   	pop    %ebp
80103be3:	c3                   	ret
  panic("unknown apicid\n");
80103be4:	83 ec 0c             	sub    $0xc,%esp
80103be7:	68 bd 79 10 80       	push   $0x801079bd
80103bec:	e8 af c7 ff ff       	call   801003a0 <panic>
    panic("mycpu called with interrupts enabled\n");
80103bf1:	83 ec 0c             	sub    $0xc,%esp
80103bf4:	68 fc 7c 10 80       	push   $0x80107cfc
80103bf9:	e8 a2 c7 ff ff       	call   801003a0 <panic>
80103bfe:	66 90                	xchg   %ax,%ax

80103c00 <cpuid>:
cpuid() {
80103c00:	55                   	push   %ebp
80103c01:	89 e5                	mov    %esp,%ebp
80103c03:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103c06:	e8 75 ff ff ff       	call   80103b80 <mycpu>
}
80103c0b:	c9                   	leave
  return mycpu()-cpus;
80103c0c:	2d a0 27 11 80       	sub    $0x801127a0,%eax
80103c11:	c1 f8 04             	sar    $0x4,%eax
80103c14:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103c1a:	c3                   	ret
80103c1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103c20 <myproc>:
myproc(void) {
80103c20:	55                   	push   %ebp
80103c21:	89 e5                	mov    %esp,%ebp
80103c23:	53                   	push   %ebx
80103c24:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103c27:	e8 54 0b 00 00       	call   80104780 <pushcli>
  c = mycpu();
80103c2c:	e8 4f ff ff ff       	call   80103b80 <mycpu>
  p = c->proc;
80103c31:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c37:	e8 94 0b 00 00       	call   801047d0 <popcli>
}
80103c3c:	89 d8                	mov    %ebx,%eax
80103c3e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c41:	c9                   	leave
80103c42:	c3                   	ret
80103c43:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103c48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103c4f:	00 

80103c50 <userinit>:
{
80103c50:	55                   	push   %ebp
80103c51:	89 e5                	mov    %esp,%ebp
80103c53:	53                   	push   %ebx
80103c54:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103c57:	e8 e4 fd ff ff       	call   80103a40 <allocproc>
80103c5c:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103c5e:	a3 54 4c 11 80       	mov    %eax,0x80114c54
  if((p->pgdir = setupkvm()) == 0)
80103c63:	e8 38 37 00 00       	call   801073a0 <setupkvm>
80103c68:	89 43 04             	mov    %eax,0x4(%ebx)
80103c6b:	85 c0                	test   %eax,%eax
80103c6d:	0f 84 bd 00 00 00    	je     80103d30 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103c73:	83 ec 04             	sub    $0x4,%esp
80103c76:	68 2c 00 00 00       	push   $0x2c
80103c7b:	68 60 b4 10 80       	push   $0x8010b460
80103c80:	50                   	push   %eax
80103c81:	e8 ca 33 00 00       	call   80107050 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103c86:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103c89:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103c8f:	6a 4c                	push   $0x4c
80103c91:	6a 00                	push   $0x0
80103c93:	ff 73 18             	push   0x18(%ebx)
80103c96:	e8 65 0d 00 00       	call   80104a00 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103c9b:	8b 43 18             	mov    0x18(%ebx),%eax
80103c9e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103ca3:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103ca6:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103cab:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103caf:	8b 43 18             	mov    0x18(%ebx),%eax
80103cb2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103cb6:	8b 43 18             	mov    0x18(%ebx),%eax
80103cb9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103cbd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103cc1:	8b 43 18             	mov    0x18(%ebx),%eax
80103cc4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103cc8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103ccc:	8b 43 18             	mov    0x18(%ebx),%eax
80103ccf:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103cd6:	8b 43 18             	mov    0x18(%ebx),%eax
80103cd9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103ce0:	8b 43 18             	mov    0x18(%ebx),%eax
80103ce3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103cea:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103ced:	6a 10                	push   $0x10
80103cef:	68 e6 79 10 80       	push   $0x801079e6
80103cf4:	50                   	push   %eax
80103cf5:	e8 d6 0e 00 00       	call   80104bd0 <safestrcpy>
  p->cwd = namei("/");
80103cfa:	c7 04 24 ef 79 10 80 	movl   $0x801079ef,(%esp)
80103d01:	e8 ea e4 ff ff       	call   801021f0 <namei>
80103d06:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103d09:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d10:	e8 cb 0b 00 00       	call   801048e0 <acquire>
  p->state = RUNNABLE;
80103d15:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103d1c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d23:	e8 58 0b 00 00       	call   80104880 <release>
}
80103d28:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d2b:	83 c4 10             	add    $0x10,%esp
80103d2e:	c9                   	leave
80103d2f:	c3                   	ret
    panic("userinit: out of memory?");
80103d30:	83 ec 0c             	sub    $0xc,%esp
80103d33:	68 cd 79 10 80       	push   $0x801079cd
80103d38:	e8 63 c6 ff ff       	call   801003a0 <panic>
80103d3d:	8d 76 00             	lea    0x0(%esi),%esi

80103d40 <growproc>:
{
80103d40:	55                   	push   %ebp
80103d41:	89 e5                	mov    %esp,%ebp
80103d43:	53                   	push   %ebx
80103d44:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103d47:	e8 34 0a 00 00       	call   80104780 <pushcli>
  c = mycpu();
80103d4c:	e8 2f fe ff ff       	call   80103b80 <mycpu>
  p = c->proc;
80103d51:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d57:	e8 74 0a 00 00       	call   801047d0 <popcli>
  if(n > 0){
80103d5c:	8b 55 08             	mov    0x8(%ebp),%edx
  sz = curproc->sz;
80103d5f:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103d61:	85 d2                	test   %edx,%edx
80103d63:	7f 1b                	jg     80103d80 <growproc+0x40>
  } else if(n < 0){
80103d65:	75 39                	jne    80103da0 <growproc+0x60>
  switchuvm(curproc);
80103d67:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103d6a:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103d6c:	53                   	push   %ebx
80103d6d:	e8 ce 31 00 00       	call   80106f40 <switchuvm>
  return 0;
80103d72:	83 c4 10             	add    $0x10,%esp
80103d75:	31 c0                	xor    %eax,%eax
}
80103d77:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d7a:	c9                   	leave
80103d7b:	c3                   	ret
80103d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103d80:	8b 55 08             	mov    0x8(%ebp),%edx
80103d83:	83 ec 04             	sub    $0x4,%esp
80103d86:	01 c2                	add    %eax,%edx
80103d88:	52                   	push   %edx
80103d89:	50                   	push   %eax
80103d8a:	ff 73 04             	push   0x4(%ebx)
80103d8d:	e8 1e 34 00 00       	call   801071b0 <allocuvm>
80103d92:	83 c4 10             	add    $0x10,%esp
80103d95:	85 c0                	test   %eax,%eax
80103d97:	75 ce                	jne    80103d67 <growproc+0x27>
      return -1;
80103d99:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103d9e:	eb d7                	jmp    80103d77 <growproc+0x37>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103da0:	8b 55 08             	mov    0x8(%ebp),%edx
80103da3:	83 ec 04             	sub    $0x4,%esp
80103da6:	01 c2                	add    %eax,%edx
80103da8:	52                   	push   %edx
80103da9:	50                   	push   %eax
80103daa:	ff 73 04             	push   0x4(%ebx)
80103dad:	e8 3e 35 00 00       	call   801072f0 <deallocuvm>
80103db2:	83 c4 10             	add    $0x10,%esp
80103db5:	85 c0                	test   %eax,%eax
80103db7:	75 ae                	jne    80103d67 <growproc+0x27>
80103db9:	eb de                	jmp    80103d99 <growproc+0x59>
80103dbb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103dc0 <fork>:
{
80103dc0:	55                   	push   %ebp
80103dc1:	89 e5                	mov    %esp,%ebp
80103dc3:	83 ec 28             	sub    $0x28,%esp
80103dc6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  pushcli();
80103dc9:	e8 b2 09 00 00       	call   80104780 <pushcli>
  c = mycpu();
80103dce:	e8 ad fd ff ff       	call   80103b80 <mycpu>
  p = c->proc;
80103dd3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103dd9:	e8 f2 09 00 00       	call   801047d0 <popcli>
  if((np = allocproc()) == 0){
80103dde:	e8 5d fc ff ff       	call   80103a40 <allocproc>
80103de3:	85 c0                	test   %eax,%eax
80103de5:	0f 84 f6 00 00 00    	je     80103ee1 <fork+0x121>
80103deb:	89 75 f8             	mov    %esi,-0x8(%ebp)
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103dee:	83 ec 08             	sub    $0x8,%esp
80103df1:	89 c6                	mov    %eax,%esi
80103df3:	ff 33                	push   (%ebx)
80103df5:	ff 73 04             	push   0x4(%ebx)
80103df8:	e8 93 36 00 00       	call   80107490 <copyuvm>
80103dfd:	83 c4 10             	add    $0x10,%esp
80103e00:	89 46 04             	mov    %eax,0x4(%esi)
80103e03:	85 c0                	test   %eax,%eax
80103e05:	0f 84 b7 00 00 00    	je     80103ec2 <fork+0x102>
80103e0b:	89 7d fc             	mov    %edi,-0x4(%ebp)
  np->sz = curproc->sz;
80103e0e:	8b 03                	mov    (%ebx),%eax
  *np->tf = *curproc->tf;
80103e10:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80103e13:	8b 56 18             	mov    0x18(%esi),%edx
  np->sz = curproc->sz;
80103e16:	89 06                	mov    %eax,(%esi)
  *np->tf = *curproc->tf;
80103e18:	31 c0                	xor    %eax,%eax
  np->parent = curproc;
80103e1a:	89 5e 14             	mov    %ebx,0x14(%esi)
  *np->tf = *curproc->tf;
80103e1d:	8b 4b 18             	mov    0x18(%ebx),%ecx
80103e20:	8b 7c 01 04          	mov    0x4(%ecx,%eax,1),%edi
80103e24:	8b 1c 01             	mov    (%ecx,%eax,1),%ebx
80103e27:	89 7c 02 04          	mov    %edi,0x4(%edx,%eax,1)
80103e2b:	89 1c 02             	mov    %ebx,(%edx,%eax,1)
80103e2e:	83 c0 08             	add    $0x8,%eax
80103e31:	83 f8 48             	cmp    $0x48,%eax
80103e34:	72 ea                	jb     80103e20 <fork+0x60>
80103e36:	8b 0c 01             	mov    (%ecx,%eax,1),%ecx
80103e39:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  for(i = 0; i < NOFILE; i++)
80103e3c:	31 ff                	xor    %edi,%edi
  *np->tf = *curproc->tf;
80103e3e:	89 0c 02             	mov    %ecx,(%edx,%eax,1)
  np->tf->eax = 0;
80103e41:	8b 46 18             	mov    0x18(%esi),%eax
80103e44:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80103e4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80103e50:	8b 44 bb 28          	mov    0x28(%ebx,%edi,4),%eax
80103e54:	85 c0                	test   %eax,%eax
80103e56:	74 10                	je     80103e68 <fork+0xa8>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103e58:	83 ec 0c             	sub    $0xc,%esp
80103e5b:	50                   	push   %eax
80103e5c:	e8 ef d0 ff ff       	call   80100f50 <filedup>
80103e61:	83 c4 10             	add    $0x10,%esp
80103e64:	89 44 be 28          	mov    %eax,0x28(%esi,%edi,4)
  for(i = 0; i < NOFILE; i++)
80103e68:	83 c7 01             	add    $0x1,%edi
80103e6b:	83 ff 10             	cmp    $0x10,%edi
80103e6e:	75 e0                	jne    80103e50 <fork+0x90>
  np->cwd = idup(curproc->cwd);
80103e70:	83 ec 0c             	sub    $0xc,%esp
80103e73:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e76:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103e79:	e8 b2 d9 ff ff       	call   80101830 <idup>
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e7e:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103e81:	89 46 68             	mov    %eax,0x68(%esi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e84:	8d 46 6c             	lea    0x6c(%esi),%eax
80103e87:	6a 10                	push   $0x10
80103e89:	53                   	push   %ebx
80103e8a:	50                   	push   %eax
80103e8b:	e8 40 0d 00 00       	call   80104bd0 <safestrcpy>
  pid = np->pid;
80103e90:	8b 5e 10             	mov    0x10(%esi),%ebx
  acquire(&ptable.lock);
80103e93:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e9a:	e8 41 0a 00 00       	call   801048e0 <acquire>
  np->state = RUNNABLE;
80103e9f:	c7 46 0c 03 00 00 00 	movl   $0x3,0xc(%esi)
  release(&ptable.lock);
80103ea6:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ead:	e8 ce 09 00 00       	call   80104880 <release>
  return pid;
80103eb2:	8b 75 f8             	mov    -0x8(%ebp),%esi
80103eb5:	8b 7d fc             	mov    -0x4(%ebp),%edi
80103eb8:	83 c4 10             	add    $0x10,%esp
}
80103ebb:	89 d8                	mov    %ebx,%eax
80103ebd:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80103ec0:	c9                   	leave
80103ec1:	c3                   	ret
    kfree(np->kstack);
80103ec2:	83 ec 0c             	sub    $0xc,%esp
80103ec5:	ff 76 08             	push   0x8(%esi)
80103ec8:	e8 73 e7 ff ff       	call   80102640 <kfree>
    np->kstack = 0;
80103ecd:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
    return -1;
80103ed4:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103ed7:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    return -1;
80103ede:	8b 75 f8             	mov    -0x8(%ebp),%esi
    return -1;
80103ee1:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103ee6:	eb d3                	jmp    80103ebb <fork+0xfb>
80103ee8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103eef:	00 

80103ef0 <scheduler>:
{
80103ef0:	55                   	push   %ebp
80103ef1:	89 e5                	mov    %esp,%ebp
80103ef3:	57                   	push   %edi
80103ef4:	56                   	push   %esi
80103ef5:	53                   	push   %ebx
80103ef6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103ef9:	e8 82 fc ff ff       	call   80103b80 <mycpu>
  c->proc = 0;
80103efe:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103f05:	00 00 00 
  struct cpu *c = mycpu();
80103f08:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103f0a:	8d 78 04             	lea    0x4(%eax),%edi
80103f0d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103f10:	fb                   	sti
    acquire(&ptable.lock);
80103f11:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f14:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
    acquire(&ptable.lock);
80103f19:	68 20 2d 11 80       	push   $0x80112d20
80103f1e:	e8 bd 09 00 00       	call   801048e0 <acquire>
80103f23:	83 c4 10             	add    $0x10,%esp
80103f26:	66 90                	xchg   %ax,%ax
80103f28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f2f:	00 
      if(p->state != RUNNABLE)
80103f30:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103f34:	75 33                	jne    80103f69 <scheduler+0x79>
      switchuvm(p);
80103f36:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103f39:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103f3f:	53                   	push   %ebx
80103f40:	e8 fb 2f 00 00       	call   80106f40 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103f45:	58                   	pop    %eax
80103f46:	5a                   	pop    %edx
80103f47:	ff 73 1c             	push   0x1c(%ebx)
80103f4a:	57                   	push   %edi
      p->state = RUNNING;
80103f4b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103f52:	e8 e4 0c 00 00       	call   80104c3b <swtch>
      switchkvm();
80103f57:	e8 d4 2f 00 00       	call   80106f30 <switchkvm>
      c->proc = 0;
80103f5c:	83 c4 10             	add    $0x10,%esp
80103f5f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103f66:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f69:	83 c3 7c             	add    $0x7c,%ebx
80103f6c:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103f72:	75 bc                	jne    80103f30 <scheduler+0x40>
    release(&ptable.lock);
80103f74:	83 ec 0c             	sub    $0xc,%esp
80103f77:	68 20 2d 11 80       	push   $0x80112d20
80103f7c:	e8 ff 08 00 00       	call   80104880 <release>
    sti();
80103f81:	83 c4 10             	add    $0x10,%esp
80103f84:	eb 8a                	jmp    80103f10 <scheduler+0x20>
80103f86:	66 90                	xchg   %ax,%ax
80103f88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f8f:	00 

80103f90 <sched>:
{
80103f90:	55                   	push   %ebp
80103f91:	89 e5                	mov    %esp,%ebp
80103f93:	56                   	push   %esi
80103f94:	53                   	push   %ebx
  pushcli();
80103f95:	e8 e6 07 00 00       	call   80104780 <pushcli>
  c = mycpu();
80103f9a:	e8 e1 fb ff ff       	call   80103b80 <mycpu>
  p = c->proc;
80103f9f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fa5:	e8 26 08 00 00       	call   801047d0 <popcli>
  if(!holding(&ptable.lock))
80103faa:	83 ec 0c             	sub    $0xc,%esp
80103fad:	68 20 2d 11 80       	push   $0x80112d20
80103fb2:	e8 79 08 00 00       	call   80104830 <holding>
80103fb7:	83 c4 10             	add    $0x10,%esp
80103fba:	85 c0                	test   %eax,%eax
80103fbc:	74 4f                	je     8010400d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103fbe:	e8 bd fb ff ff       	call   80103b80 <mycpu>
80103fc3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103fca:	75 68                	jne    80104034 <sched+0xa4>
  if(p->state == RUNNING)
80103fcc:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103fd0:	74 55                	je     80104027 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103fd2:	9c                   	pushf
80103fd3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103fd4:	f6 c4 02             	test   $0x2,%ah
80103fd7:	75 41                	jne    8010401a <sched+0x8a>
  intena = mycpu()->intena;
80103fd9:	e8 a2 fb ff ff       	call   80103b80 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103fde:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103fe1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103fe7:	e8 94 fb ff ff       	call   80103b80 <mycpu>
80103fec:	83 ec 08             	sub    $0x8,%esp
80103fef:	ff 70 04             	push   0x4(%eax)
80103ff2:	53                   	push   %ebx
80103ff3:	e8 43 0c 00 00       	call   80104c3b <swtch>
  mycpu()->intena = intena;
80103ff8:	e8 83 fb ff ff       	call   80103b80 <mycpu>
}
80103ffd:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104000:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104006:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104009:	5b                   	pop    %ebx
8010400a:	5e                   	pop    %esi
8010400b:	5d                   	pop    %ebp
8010400c:	c3                   	ret
    panic("sched ptable.lock");
8010400d:	83 ec 0c             	sub    $0xc,%esp
80104010:	68 f1 79 10 80       	push   $0x801079f1
80104015:	e8 86 c3 ff ff       	call   801003a0 <panic>
    panic("sched interruptible");
8010401a:	83 ec 0c             	sub    $0xc,%esp
8010401d:	68 1d 7a 10 80       	push   $0x80107a1d
80104022:	e8 79 c3 ff ff       	call   801003a0 <panic>
    panic("sched running");
80104027:	83 ec 0c             	sub    $0xc,%esp
8010402a:	68 0f 7a 10 80       	push   $0x80107a0f
8010402f:	e8 6c c3 ff ff       	call   801003a0 <panic>
    panic("sched locks");
80104034:	83 ec 0c             	sub    $0xc,%esp
80104037:	68 03 7a 10 80       	push   $0x80107a03
8010403c:	e8 5f c3 ff ff       	call   801003a0 <panic>
80104041:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104048:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010404f:	00 

80104050 <exit>:
{
80104050:	55                   	push   %ebp
80104051:	89 e5                	mov    %esp,%ebp
80104053:	83 ec 18             	sub    $0x18,%esp
80104056:	89 75 f8             	mov    %esi,-0x8(%ebp)
  pushcli();
80104059:	e8 22 07 00 00       	call   80104780 <pushcli>
  c = mycpu();
8010405e:	e8 1d fb ff ff       	call   80103b80 <mycpu>
  p = c->proc;
80104063:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104069:	e8 62 07 00 00       	call   801047d0 <popcli>
  if(curproc == initproc)
8010406e:	39 35 54 4c 11 80    	cmp    %esi,0x80114c54
80104074:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104077:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010407a:	0f 84 07 01 00 00    	je     80104187 <exit+0x137>
80104080:	8d 5e 28             	lea    0x28(%esi),%ebx
80104083:	8d 7e 68             	lea    0x68(%esi),%edi
80104086:	66 90                	xchg   %ax,%ax
80104088:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010408f:	00 
    if(curproc->ofile[fd]){
80104090:	8b 03                	mov    (%ebx),%eax
80104092:	85 c0                	test   %eax,%eax
80104094:	74 12                	je     801040a8 <exit+0x58>
      fileclose(curproc->ofile[fd]);
80104096:	83 ec 0c             	sub    $0xc,%esp
80104099:	50                   	push   %eax
8010409a:	e8 01 cf ff ff       	call   80100fa0 <fileclose>
      curproc->ofile[fd] = 0;
8010409f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801040a5:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
801040a8:	83 c3 04             	add    $0x4,%ebx
801040ab:	39 df                	cmp    %ebx,%edi
801040ad:	75 e1                	jne    80104090 <exit+0x40>
  begin_op();
801040af:	e8 0c ef ff ff       	call   80102fc0 <begin_op>
  iput(curproc->cwd);
801040b4:	83 ec 0c             	sub    $0xc,%esp
801040b7:	ff 76 68             	push   0x68(%esi)
801040ba:	e8 d1 d8 ff ff       	call   80101990 <iput>
  end_op();
801040bf:	e8 6c ef ff ff       	call   80103030 <end_op>
  curproc->cwd = 0;
801040c4:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
801040cb:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801040d2:	e8 09 08 00 00       	call   801048e0 <acquire>
  wakeup1(curproc->parent);
801040d7:	8b 56 14             	mov    0x14(%esi),%edx
801040da:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040dd:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
801040e2:	eb 16                	jmp    801040fa <exit+0xaa>
801040e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801040e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801040ef:	00 
801040f0:	83 c0 7c             	add    $0x7c,%eax
801040f3:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
801040f8:	74 1c                	je     80104116 <exit+0xc6>
    if(p->state == SLEEPING && p->chan == chan)
801040fa:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801040fe:	75 f0                	jne    801040f0 <exit+0xa0>
80104100:	3b 50 20             	cmp    0x20(%eax),%edx
80104103:	75 eb                	jne    801040f0 <exit+0xa0>
      p->state = RUNNABLE;
80104105:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010410c:	83 c0 7c             	add    $0x7c,%eax
8010410f:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104114:	75 e4                	jne    801040fa <exit+0xaa>
      p->parent = initproc;
80104116:	8b 0d 54 4c 11 80    	mov    0x80114c54,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010411c:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80104121:	eb 18                	jmp    8010413b <exit+0xeb>
80104123:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104128:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010412f:	00 
80104130:	83 c2 7c             	add    $0x7c,%edx
80104133:	81 fa 54 4c 11 80    	cmp    $0x80114c54,%edx
80104139:	74 33                	je     8010416e <exit+0x11e>
    if(p->parent == curproc){
8010413b:	39 72 14             	cmp    %esi,0x14(%edx)
8010413e:	75 f0                	jne    80104130 <exit+0xe0>
      p->parent = initproc;
80104140:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80104143:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
80104147:	75 e7                	jne    80104130 <exit+0xe0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104149:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010414e:	eb 0a                	jmp    8010415a <exit+0x10a>
80104150:	83 c0 7c             	add    $0x7c,%eax
80104153:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104158:	74 d6                	je     80104130 <exit+0xe0>
    if(p->state == SLEEPING && p->chan == chan)
8010415a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010415e:	75 f0                	jne    80104150 <exit+0x100>
80104160:	3b 48 20             	cmp    0x20(%eax),%ecx
80104163:	75 eb                	jne    80104150 <exit+0x100>
      p->state = RUNNABLE;
80104165:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010416c:	eb e2                	jmp    80104150 <exit+0x100>
  curproc->state = ZOMBIE;
8010416e:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80104175:	e8 16 fe ff ff       	call   80103f90 <sched>
  panic("zombie exit");
8010417a:	83 ec 0c             	sub    $0xc,%esp
8010417d:	68 3e 7a 10 80       	push   $0x80107a3e
80104182:	e8 19 c2 ff ff       	call   801003a0 <panic>
    panic("init exiting");
80104187:	83 ec 0c             	sub    $0xc,%esp
8010418a:	68 31 7a 10 80       	push   $0x80107a31
8010418f:	e8 0c c2 ff ff       	call   801003a0 <panic>
80104194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104198:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010419f:	00 

801041a0 <wait>:
{
801041a0:	55                   	push   %ebp
801041a1:	89 e5                	mov    %esp,%ebp
801041a3:	56                   	push   %esi
801041a4:	53                   	push   %ebx
  pushcli();
801041a5:	e8 d6 05 00 00       	call   80104780 <pushcli>
  c = mycpu();
801041aa:	e8 d1 f9 ff ff       	call   80103b80 <mycpu>
  p = c->proc;
801041af:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801041b5:	e8 16 06 00 00       	call   801047d0 <popcli>
  acquire(&ptable.lock);
801041ba:	83 ec 0c             	sub    $0xc,%esp
801041bd:	68 20 2d 11 80       	push   $0x80112d20
801041c2:	e8 19 07 00 00       	call   801048e0 <acquire>
801041c7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
801041ca:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041cc:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
801041d1:	eb 18                	jmp    801041eb <wait+0x4b>
801041d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801041d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801041df:	00 
801041e0:	83 c3 7c             	add    $0x7c,%ebx
801041e3:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
801041e9:	74 1b                	je     80104206 <wait+0x66>
      if(p->parent != curproc)
801041eb:	39 73 14             	cmp    %esi,0x14(%ebx)
801041ee:	75 f0                	jne    801041e0 <wait+0x40>
      if(p->state == ZOMBIE){
801041f0:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801041f4:	74 62                	je     80104258 <wait+0xb8>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041f6:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
801041f9:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041fe:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80104204:	75 e5                	jne    801041eb <wait+0x4b>
    if(!havekids || curproc->killed){
80104206:	85 c0                	test   %eax,%eax
80104208:	0f 84 a0 00 00 00    	je     801042ae <wait+0x10e>
8010420e:	8b 46 24             	mov    0x24(%esi),%eax
80104211:	85 c0                	test   %eax,%eax
80104213:	0f 85 95 00 00 00    	jne    801042ae <wait+0x10e>
  pushcli();
80104219:	e8 62 05 00 00       	call   80104780 <pushcli>
  c = mycpu();
8010421e:	e8 5d f9 ff ff       	call   80103b80 <mycpu>
  p = c->proc;
80104223:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104229:	e8 a2 05 00 00       	call   801047d0 <popcli>
  if(p == 0)
8010422e:	85 db                	test   %ebx,%ebx
80104230:	0f 84 8f 00 00 00    	je     801042c5 <wait+0x125>
  p->chan = chan;
80104236:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104239:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104240:	e8 4b fd ff ff       	call   80103f90 <sched>
  p->chan = 0;
80104245:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    havekids = 0;
8010424c:	e9 79 ff ff ff       	jmp    801041ca <wait+0x2a>
80104251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80104258:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
8010425b:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
8010425e:	ff 73 08             	push   0x8(%ebx)
80104261:	e8 da e3 ff ff       	call   80102640 <kfree>
        p->kstack = 0;
80104266:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
8010426d:	5a                   	pop    %edx
8010426e:	ff 73 04             	push   0x4(%ebx)
80104271:	e8 aa 30 00 00       	call   80107320 <freevm>
        p->pid = 0;
80104276:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
8010427d:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104284:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104288:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
8010428f:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104296:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010429d:	e8 de 05 00 00       	call   80104880 <release>
        return pid;
801042a2:	83 c4 10             	add    $0x10,%esp
}
801042a5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042a8:	89 f0                	mov    %esi,%eax
801042aa:	5b                   	pop    %ebx
801042ab:	5e                   	pop    %esi
801042ac:	5d                   	pop    %ebp
801042ad:	c3                   	ret
      release(&ptable.lock);
801042ae:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801042b1:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801042b6:	68 20 2d 11 80       	push   $0x80112d20
801042bb:	e8 c0 05 00 00       	call   80104880 <release>
      return -1;
801042c0:	83 c4 10             	add    $0x10,%esp
801042c3:	eb e0                	jmp    801042a5 <wait+0x105>
    panic("sleep");
801042c5:	83 ec 0c             	sub    $0xc,%esp
801042c8:	68 4a 7a 10 80       	push   $0x80107a4a
801042cd:	e8 ce c0 ff ff       	call   801003a0 <panic>
801042d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801042d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801042df:	00 

801042e0 <yield>:
{
801042e0:	55                   	push   %ebp
801042e1:	89 e5                	mov    %esp,%ebp
801042e3:	53                   	push   %ebx
801042e4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801042e7:	68 20 2d 11 80       	push   $0x80112d20
801042ec:	e8 ef 05 00 00       	call   801048e0 <acquire>
  pushcli();
801042f1:	e8 8a 04 00 00       	call   80104780 <pushcli>
  c = mycpu();
801042f6:	e8 85 f8 ff ff       	call   80103b80 <mycpu>
  p = c->proc;
801042fb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104301:	e8 ca 04 00 00       	call   801047d0 <popcli>
  myproc()->state = RUNNABLE;
80104306:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010430d:	e8 7e fc ff ff       	call   80103f90 <sched>
  release(&ptable.lock);
80104312:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104319:	e8 62 05 00 00       	call   80104880 <release>
}
8010431e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104321:	83 c4 10             	add    $0x10,%esp
80104324:	c9                   	leave
80104325:	c3                   	ret
80104326:	66 90                	xchg   %ax,%ax
80104328:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010432f:	00 

80104330 <sleep>:
{
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	57                   	push   %edi
80104334:	56                   	push   %esi
80104335:	53                   	push   %ebx
80104336:	83 ec 0c             	sub    $0xc,%esp
80104339:	8b 7d 08             	mov    0x8(%ebp),%edi
8010433c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010433f:	e8 3c 04 00 00       	call   80104780 <pushcli>
  c = mycpu();
80104344:	e8 37 f8 ff ff       	call   80103b80 <mycpu>
  p = c->proc;
80104349:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010434f:	e8 7c 04 00 00       	call   801047d0 <popcli>
  if(p == 0)
80104354:	85 db                	test   %ebx,%ebx
80104356:	0f 84 87 00 00 00    	je     801043e3 <sleep+0xb3>
  if(lk == 0)
8010435c:	85 f6                	test   %esi,%esi
8010435e:	74 76                	je     801043d6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104360:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80104366:	74 50                	je     801043b8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104368:	83 ec 0c             	sub    $0xc,%esp
8010436b:	68 20 2d 11 80       	push   $0x80112d20
80104370:	e8 6b 05 00 00       	call   801048e0 <acquire>
    release(lk);
80104375:	89 34 24             	mov    %esi,(%esp)
80104378:	e8 03 05 00 00       	call   80104880 <release>
  p->chan = chan;
8010437d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104380:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104387:	e8 04 fc ff ff       	call   80103f90 <sched>
  p->chan = 0;
8010438c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104393:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010439a:	e8 e1 04 00 00       	call   80104880 <release>
    acquire(lk);
8010439f:	83 c4 10             	add    $0x10,%esp
801043a2:	89 75 08             	mov    %esi,0x8(%ebp)
}
801043a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043a8:	5b                   	pop    %ebx
801043a9:	5e                   	pop    %esi
801043aa:	5f                   	pop    %edi
801043ab:	5d                   	pop    %ebp
    acquire(lk);
801043ac:	e9 2f 05 00 00       	jmp    801048e0 <acquire>
801043b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
801043b8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801043bb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801043c2:	e8 c9 fb ff ff       	call   80103f90 <sched>
  p->chan = 0;
801043c7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801043ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043d1:	5b                   	pop    %ebx
801043d2:	5e                   	pop    %esi
801043d3:	5f                   	pop    %edi
801043d4:	5d                   	pop    %ebp
801043d5:	c3                   	ret
    panic("sleep without lk");
801043d6:	83 ec 0c             	sub    $0xc,%esp
801043d9:	68 50 7a 10 80       	push   $0x80107a50
801043de:	e8 bd bf ff ff       	call   801003a0 <panic>
    panic("sleep");
801043e3:	83 ec 0c             	sub    $0xc,%esp
801043e6:	68 4a 7a 10 80       	push   $0x80107a4a
801043eb:	e8 b0 bf ff ff       	call   801003a0 <panic>

801043f0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801043f0:	55                   	push   %ebp
801043f1:	89 e5                	mov    %esp,%ebp
801043f3:	53                   	push   %ebx
801043f4:	83 ec 10             	sub    $0x10,%esp
801043f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801043fa:	68 20 2d 11 80       	push   $0x80112d20
801043ff:	e8 dc 04 00 00       	call   801048e0 <acquire>
80104404:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104407:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010440c:	eb 0c                	jmp    8010441a <wakeup+0x2a>
8010440e:	66 90                	xchg   %ax,%ax
80104410:	83 c0 7c             	add    $0x7c,%eax
80104413:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104418:	74 1c                	je     80104436 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010441a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010441e:	75 f0                	jne    80104410 <wakeup+0x20>
80104420:	3b 58 20             	cmp    0x20(%eax),%ebx
80104423:	75 eb                	jne    80104410 <wakeup+0x20>
      p->state = RUNNABLE;
80104425:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010442c:	83 c0 7c             	add    $0x7c,%eax
8010442f:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104434:	75 e4                	jne    8010441a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104436:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
8010443d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104440:	c9                   	leave
  release(&ptable.lock);
80104441:	e9 3a 04 00 00       	jmp    80104880 <release>
80104446:	66 90                	xchg   %ax,%ax
80104448:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010444f:	00 

80104450 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104450:	55                   	push   %ebp
80104451:	89 e5                	mov    %esp,%ebp
80104453:	53                   	push   %ebx
80104454:	83 ec 10             	sub    $0x10,%esp
80104457:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010445a:	68 20 2d 11 80       	push   $0x80112d20
8010445f:	e8 7c 04 00 00       	call   801048e0 <acquire>
80104464:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104467:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010446c:	eb 0c                	jmp    8010447a <kill+0x2a>
8010446e:	66 90                	xchg   %ax,%ax
80104470:	83 c0 7c             	add    $0x7c,%eax
80104473:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104478:	74 36                	je     801044b0 <kill+0x60>
    if(p->pid == pid){
8010447a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010447d:	75 f1                	jne    80104470 <kill+0x20>
      p->killed = 1;
8010447f:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104486:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010448a:	75 07                	jne    80104493 <kill+0x43>
        p->state = RUNNABLE;
8010448c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104493:	83 ec 0c             	sub    $0xc,%esp
80104496:	68 20 2d 11 80       	push   $0x80112d20
8010449b:	e8 e0 03 00 00       	call   80104880 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
801044a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
801044a3:	83 c4 10             	add    $0x10,%esp
801044a6:	31 c0                	xor    %eax,%eax
}
801044a8:	c9                   	leave
801044a9:	c3                   	ret
801044aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
801044b0:	83 ec 0c             	sub    $0xc,%esp
801044b3:	68 20 2d 11 80       	push   $0x80112d20
801044b8:	e8 c3 03 00 00       	call   80104880 <release>
}
801044bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801044c0:	83 c4 10             	add    $0x10,%esp
801044c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801044c8:	c9                   	leave
801044c9:	c3                   	ret
801044ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801044d0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	57                   	push   %edi
801044d4:	56                   	push   %esi
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
801044d5:	8d 75 c0             	lea    -0x40(%ebp),%esi
{
801044d8:	53                   	push   %ebx
801044d9:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
801044de:	83 ec 3c             	sub    $0x3c,%esp
801044e1:	eb 20                	jmp    80104503 <procdump+0x33>
801044e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801044e8:	83 ec 0c             	sub    $0xc,%esp
801044eb:	68 0f 7c 10 80       	push   $0x80107c0f
801044f0:	e8 fb c1 ff ff       	call   801006f0 <cprintf>
801044f5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044f8:	83 c3 7c             	add    $0x7c,%ebx
801044fb:	81 fb c0 4c 11 80    	cmp    $0x80114cc0,%ebx
80104501:	74 7d                	je     80104580 <procdump+0xb0>
    if(p->state == UNUSED)
80104503:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104506:	85 c0                	test   %eax,%eax
80104508:	74 ee                	je     801044f8 <procdump+0x28>
      state = "???";
8010450a:	ba 61 7a 10 80       	mov    $0x80107a61,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010450f:	83 f8 05             	cmp    $0x5,%eax
80104512:	77 07                	ja     8010451b <procdump+0x4b>
80104514:	8b 14 85 20 80 10 80 	mov    -0x7fef7fe0(,%eax,4),%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010451b:	53                   	push   %ebx
8010451c:	52                   	push   %edx
8010451d:	ff 73 a4             	push   -0x5c(%ebx)
80104520:	68 65 7a 10 80       	push   $0x80107a65
80104525:	e8 c6 c1 ff ff       	call   801006f0 <cprintf>
    if(p->state == SLEEPING){
8010452a:	83 c4 10             	add    $0x10,%esp
8010452d:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104531:	75 b5                	jne    801044e8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104533:	83 ec 08             	sub    $0x8,%esp
80104536:	89 f7                	mov    %esi,%edi
80104538:	56                   	push   %esi
80104539:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010453c:	8b 40 0c             	mov    0xc(%eax),%eax
8010453f:	83 c0 08             	add    $0x8,%eax
80104542:	50                   	push   %eax
80104543:	e8 98 01 00 00       	call   801046e0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104548:	83 c4 10             	add    $0x10,%esp
8010454b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104550:	8b 07                	mov    (%edi),%eax
80104552:	85 c0                	test   %eax,%eax
80104554:	74 92                	je     801044e8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104556:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104559:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010455c:	50                   	push   %eax
8010455d:	68 a1 77 10 80       	push   $0x801077a1
80104562:	e8 89 c1 ff ff       	call   801006f0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104567:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010456a:	83 c4 10             	add    $0x10,%esp
8010456d:	39 c7                	cmp    %eax,%edi
8010456f:	75 df                	jne    80104550 <procdump+0x80>
80104571:	e9 72 ff ff ff       	jmp    801044e8 <procdump+0x18>
80104576:	66 90                	xchg   %ax,%ax
80104578:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010457f:	00 
  }
}
80104580:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104583:	5b                   	pop    %ebx
80104584:	5e                   	pop    %esi
80104585:	5f                   	pop    %edi
80104586:	5d                   	pop    %ebp
80104587:	c3                   	ret
80104588:	66 90                	xchg   %ax,%ax
8010458a:	66 90                	xchg   %ax,%ax
8010458c:	66 90                	xchg   %ax,%ax
8010458e:	66 90                	xchg   %ax,%ax

80104590 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104590:	55                   	push   %ebp
80104591:	89 e5                	mov    %esp,%ebp
80104593:	53                   	push   %ebx
80104594:	83 ec 0c             	sub    $0xc,%esp
80104597:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010459a:	68 98 7a 10 80       	push   $0x80107a98
8010459f:	8d 43 04             	lea    0x4(%ebx),%eax
801045a2:	50                   	push   %eax
801045a3:	e8 18 01 00 00       	call   801046c0 <initlock>
  lk->name = name;
801045a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801045ab:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801045b1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801045b4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801045bb:	89 43 38             	mov    %eax,0x38(%ebx)
}
801045be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045c1:	c9                   	leave
801045c2:	c3                   	ret
801045c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801045c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801045cf:	00 

801045d0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801045d0:	55                   	push   %ebp
801045d1:	89 e5                	mov    %esp,%ebp
801045d3:	56                   	push   %esi
801045d4:	53                   	push   %ebx
801045d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801045d8:	8d 73 04             	lea    0x4(%ebx),%esi
801045db:	83 ec 0c             	sub    $0xc,%esp
801045de:	56                   	push   %esi
801045df:	e8 fc 02 00 00       	call   801048e0 <acquire>
  while (lk->locked) {
801045e4:	8b 13                	mov    (%ebx),%edx
801045e6:	83 c4 10             	add    $0x10,%esp
801045e9:	85 d2                	test   %edx,%edx
801045eb:	74 16                	je     80104603 <acquiresleep+0x33>
801045ed:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801045f0:	83 ec 08             	sub    $0x8,%esp
801045f3:	56                   	push   %esi
801045f4:	53                   	push   %ebx
801045f5:	e8 36 fd ff ff       	call   80104330 <sleep>
  while (lk->locked) {
801045fa:	8b 03                	mov    (%ebx),%eax
801045fc:	83 c4 10             	add    $0x10,%esp
801045ff:	85 c0                	test   %eax,%eax
80104601:	75 ed                	jne    801045f0 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104603:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104609:	e8 12 f6 ff ff       	call   80103c20 <myproc>
8010460e:	8b 40 10             	mov    0x10(%eax),%eax
80104611:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104614:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104617:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010461a:	5b                   	pop    %ebx
8010461b:	5e                   	pop    %esi
8010461c:	5d                   	pop    %ebp
  release(&lk->lk);
8010461d:	e9 5e 02 00 00       	jmp    80104880 <release>
80104622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104628:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010462f:	00 

80104630 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	56                   	push   %esi
80104634:	53                   	push   %ebx
80104635:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104638:	8d 73 04             	lea    0x4(%ebx),%esi
8010463b:	83 ec 0c             	sub    $0xc,%esp
8010463e:	56                   	push   %esi
8010463f:	e8 9c 02 00 00       	call   801048e0 <acquire>
  lk->locked = 0;
80104644:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010464a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104651:	89 1c 24             	mov    %ebx,(%esp)
80104654:	e8 97 fd ff ff       	call   801043f0 <wakeup>
  release(&lk->lk);
80104659:	83 c4 10             	add    $0x10,%esp
8010465c:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010465f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104662:	5b                   	pop    %ebx
80104663:	5e                   	pop    %esi
80104664:	5d                   	pop    %ebp
  release(&lk->lk);
80104665:	e9 16 02 00 00       	jmp    80104880 <release>
8010466a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104670 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	57                   	push   %edi
80104674:	31 ff                	xor    %edi,%edi
80104676:	56                   	push   %esi
80104677:	53                   	push   %ebx
80104678:	83 ec 18             	sub    $0x18,%esp
8010467b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010467e:	8d 73 04             	lea    0x4(%ebx),%esi
80104681:	56                   	push   %esi
80104682:	e8 59 02 00 00       	call   801048e0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104687:	8b 03                	mov    (%ebx),%eax
80104689:	83 c4 10             	add    $0x10,%esp
8010468c:	85 c0                	test   %eax,%eax
8010468e:	75 18                	jne    801046a8 <holdingsleep+0x38>
  release(&lk->lk);
80104690:	83 ec 0c             	sub    $0xc,%esp
80104693:	56                   	push   %esi
80104694:	e8 e7 01 00 00       	call   80104880 <release>
  return r;
}
80104699:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010469c:	89 f8                	mov    %edi,%eax
8010469e:	5b                   	pop    %ebx
8010469f:	5e                   	pop    %esi
801046a0:	5f                   	pop    %edi
801046a1:	5d                   	pop    %ebp
801046a2:	c3                   	ret
801046a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
801046a8:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801046ab:	e8 70 f5 ff ff       	call   80103c20 <myproc>
801046b0:	39 58 10             	cmp    %ebx,0x10(%eax)
801046b3:	0f 94 c0             	sete   %al
801046b6:	0f b6 c0             	movzbl %al,%eax
801046b9:	89 c7                	mov    %eax,%edi
801046bb:	eb d3                	jmp    80104690 <holdingsleep+0x20>
801046bd:	66 90                	xchg   %ax,%ax
801046bf:	90                   	nop

801046c0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801046c0:	55                   	push   %ebp
801046c1:	89 e5                	mov    %esp,%ebp
801046c3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801046c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801046c9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801046cf:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801046d2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801046d9:	5d                   	pop    %ebp
801046da:	c3                   	ret
801046db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801046e0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801046e0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801046e1:	31 d2                	xor    %edx,%edx
{
801046e3:	89 e5                	mov    %esp,%ebp
801046e5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801046e6:	8b 45 08             	mov    0x8(%ebp),%eax
{
801046e9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801046ec:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
801046ef:	90                   	nop
801046f0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801046f7:	00 
801046f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801046ff:	00 
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104700:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104706:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010470c:	77 1a                	ja     80104728 <getcallerpcs+0x48>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010470e:	8b 58 04             	mov    0x4(%eax),%ebx
80104711:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104714:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104717:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104719:	83 fa 0a             	cmp    $0xa,%edx
8010471c:	75 e2                	jne    80104700 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010471e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104721:	c9                   	leave
80104722:	c3                   	ret
80104723:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104728:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010472b:	83 c1 28             	add    $0x28,%ecx
8010472e:	89 ca                	mov    %ecx,%edx
80104730:	29 c2                	sub    %eax,%edx
80104732:	83 e2 04             	and    $0x4,%edx
80104735:	74 29                	je     80104760 <getcallerpcs+0x80>
    pcs[i] = 0;
80104737:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
8010473d:	83 c0 04             	add    $0x4,%eax
80104740:	39 c8                	cmp    %ecx,%eax
80104742:	74 da                	je     8010471e <getcallerpcs+0x3e>
80104744:	eb 1a                	jmp    80104760 <getcallerpcs+0x80>
80104746:	66 90                	xchg   %ax,%ax
80104748:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010474f:	00 
80104750:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104757:	00 
80104758:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010475f:	00 
    pcs[i] = 0;
80104760:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104766:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80104769:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80104770:	39 c8                	cmp    %ecx,%eax
80104772:	75 ec                	jne    80104760 <getcallerpcs+0x80>
80104774:	eb a8                	jmp    8010471e <getcallerpcs+0x3e>
80104776:	66 90                	xchg   %ax,%ax
80104778:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010477f:	00 

80104780 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	53                   	push   %ebx
80104784:	83 ec 04             	sub    $0x4,%esp
80104787:	9c                   	pushf
80104788:	5b                   	pop    %ebx
  asm volatile("cli");
80104789:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010478a:	e8 f1 f3 ff ff       	call   80103b80 <mycpu>
8010478f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104795:	85 c0                	test   %eax,%eax
80104797:	74 17                	je     801047b0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104799:	e8 e2 f3 ff ff       	call   80103b80 <mycpu>
8010479e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801047a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047a8:	c9                   	leave
801047a9:	c3                   	ret
801047aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
801047b0:	e8 cb f3 ff ff       	call   80103b80 <mycpu>
801047b5:	81 e3 00 02 00 00    	and    $0x200,%ebx
801047bb:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
801047c1:	eb d6                	jmp    80104799 <pushcli+0x19>
801047c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801047c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801047cf:	00 

801047d0 <popcli>:

void
popcli(void)
{
801047d0:	55                   	push   %ebp
801047d1:	89 e5                	mov    %esp,%ebp
801047d3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801047d6:	9c                   	pushf
801047d7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801047d8:	f6 c4 02             	test   $0x2,%ah
801047db:	75 35                	jne    80104812 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801047dd:	e8 9e f3 ff ff       	call   80103b80 <mycpu>
801047e2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801047e9:	78 34                	js     8010481f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801047eb:	e8 90 f3 ff ff       	call   80103b80 <mycpu>
801047f0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801047f6:	85 d2                	test   %edx,%edx
801047f8:	74 06                	je     80104800 <popcli+0x30>
    sti();
}
801047fa:	c9                   	leave
801047fb:	c3                   	ret
801047fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104800:	e8 7b f3 ff ff       	call   80103b80 <mycpu>
80104805:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010480b:	85 c0                	test   %eax,%eax
8010480d:	74 eb                	je     801047fa <popcli+0x2a>
  asm volatile("sti");
8010480f:	fb                   	sti
}
80104810:	c9                   	leave
80104811:	c3                   	ret
    panic("popcli - interruptible");
80104812:	83 ec 0c             	sub    $0xc,%esp
80104815:	68 a3 7a 10 80       	push   $0x80107aa3
8010481a:	e8 81 bb ff ff       	call   801003a0 <panic>
    panic("popcli");
8010481f:	83 ec 0c             	sub    $0xc,%esp
80104822:	68 ba 7a 10 80       	push   $0x80107aba
80104827:	e8 74 bb ff ff       	call   801003a0 <panic>
8010482c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104830 <holding>:
{
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	53                   	push   %ebx
80104834:	31 db                	xor    %ebx,%ebx
80104836:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104839:	e8 42 ff ff ff       	call   80104780 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010483e:	8b 45 08             	mov    0x8(%ebp),%eax
80104841:	8b 10                	mov    (%eax),%edx
80104843:	85 d2                	test   %edx,%edx
80104845:	75 11                	jne    80104858 <holding+0x28>
  popcli();
80104847:	e8 84 ff ff ff       	call   801047d0 <popcli>
}
8010484c:	89 d8                	mov    %ebx,%eax
8010484e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104851:	c9                   	leave
80104852:	c3                   	ret
80104853:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lock->locked && lock->cpu == mycpu();
80104858:	8b 58 08             	mov    0x8(%eax),%ebx
8010485b:	e8 20 f3 ff ff       	call   80103b80 <mycpu>
80104860:	39 c3                	cmp    %eax,%ebx
80104862:	0f 94 c3             	sete   %bl
  popcli();
80104865:	e8 66 ff ff ff       	call   801047d0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
8010486a:	0f b6 db             	movzbl %bl,%ebx
}
8010486d:	89 d8                	mov    %ebx,%eax
8010486f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104872:	c9                   	leave
80104873:	c3                   	ret
80104874:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104878:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010487f:	00 

80104880 <release>:
{
80104880:	55                   	push   %ebp
80104881:	89 e5                	mov    %esp,%ebp
80104883:	56                   	push   %esi
80104884:	53                   	push   %ebx
80104885:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104888:	e8 f3 fe ff ff       	call   80104780 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010488d:	8b 03                	mov    (%ebx),%eax
8010488f:	85 c0                	test   %eax,%eax
80104891:	75 15                	jne    801048a8 <release+0x28>
  popcli();
80104893:	e8 38 ff ff ff       	call   801047d0 <popcli>
    panic("release");
80104898:	83 ec 0c             	sub    $0xc,%esp
8010489b:	68 c1 7a 10 80       	push   $0x80107ac1
801048a0:	e8 fb ba ff ff       	call   801003a0 <panic>
801048a5:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
801048a8:	8b 73 08             	mov    0x8(%ebx),%esi
801048ab:	e8 d0 f2 ff ff       	call   80103b80 <mycpu>
801048b0:	39 c6                	cmp    %eax,%esi
801048b2:	75 df                	jne    80104893 <release+0x13>
  popcli();
801048b4:	e8 17 ff ff ff       	call   801047d0 <popcli>
  lk->pcs[0] = 0;
801048b9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801048c0:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801048c7:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801048cc:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801048d2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048d5:	5b                   	pop    %ebx
801048d6:	5e                   	pop    %esi
801048d7:	5d                   	pop    %ebp
  popcli();
801048d8:	e9 f3 fe ff ff       	jmp    801047d0 <popcli>
801048dd:	8d 76 00             	lea    0x0(%esi),%esi

801048e0 <acquire>:
{
801048e0:	55                   	push   %ebp
801048e1:	89 e5                	mov    %esp,%ebp
801048e3:	83 ec 08             	sub    $0x8,%esp
801048e6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  pushcli(); // disable interrupts to avoid deadlock.
801048e9:	e8 92 fe ff ff       	call   80104780 <pushcli>
  if(holding(lk))
801048ee:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801048f1:	e8 8a fe ff ff       	call   80104780 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801048f6:	8b 03                	mov    (%ebx),%eax
801048f8:	85 c0                	test   %eax,%eax
801048fa:	0f 85 c0 00 00 00    	jne    801049c0 <acquire+0xe0>
  popcli();
80104900:	e8 cb fe ff ff       	call   801047d0 <popcli>
  asm volatile("lock; xchgl %0, %1" :
80104905:	b8 01 00 00 00       	mov    $0x1,%eax
8010490a:	f0 87 03             	lock xchg %eax,(%ebx)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
8010490d:	8b 55 08             	mov    0x8(%ebp),%edx
  while(xchg(&lk->locked, 1) != 0)
80104910:	85 c0                	test   %eax,%eax
80104912:	74 18                	je     8010492c <acquire+0x4c>
80104914:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104918:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010491f:	00 
  asm volatile("lock; xchgl %0, %1" :
80104920:	b8 01 00 00 00       	mov    $0x1,%eax
80104925:	f0 87 02             	lock xchg %eax,(%edx)
80104928:	85 c0                	test   %eax,%eax
8010492a:	75 f4                	jne    80104920 <acquire+0x40>
  __sync_synchronize();
8010492c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104931:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104934:	e8 47 f2 ff ff       	call   80103b80 <mycpu>
  ebp = (uint*)v - 2;
80104939:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
8010493b:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
8010493e:	31 c0                	xor    %eax,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104940:	8d 8a 00 00 00 80    	lea    -0x80000000(%edx),%ecx
80104946:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
8010494c:	77 1a                	ja     80104968 <acquire+0x88>
    pcs[i] = ebp[1];     // saved %eip
8010494e:	8b 4a 04             	mov    0x4(%edx),%ecx
80104951:	89 4c 83 0c          	mov    %ecx,0xc(%ebx,%eax,4)
  for(i = 0; i < 10; i++){
80104955:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104958:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
8010495a:	83 f8 0a             	cmp    $0xa,%eax
8010495d:	75 e1                	jne    80104940 <acquire+0x60>
}
8010495f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104962:	c9                   	leave
80104963:	c3                   	ret
80104964:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104968:	8d 44 83 0c          	lea    0xc(%ebx,%eax,4),%eax
8010496c:	83 c3 34             	add    $0x34,%ebx
8010496f:	89 da                	mov    %ebx,%edx
80104971:	29 c2                	sub    %eax,%edx
80104973:	83 e2 04             	and    $0x4,%edx
80104976:	74 28                	je     801049a0 <acquire+0xc0>
    pcs[i] = 0;
80104978:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
8010497e:	83 c0 04             	add    $0x4,%eax
80104981:	39 d8                	cmp    %ebx,%eax
80104983:	74 da                	je     8010495f <acquire+0x7f>
80104985:	eb 19                	jmp    801049a0 <acquire+0xc0>
80104987:	90                   	nop
80104988:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010498f:	00 
80104990:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104997:	00 
80104998:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010499f:	00 
    pcs[i] = 0;
801049a0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801049a6:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
801049a9:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
801049b0:	39 d8                	cmp    %ebx,%eax
801049b2:	75 ec                	jne    801049a0 <acquire+0xc0>
801049b4:	eb a9                	jmp    8010495f <acquire+0x7f>
801049b6:	66 90                	xchg   %ax,%ax
801049b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801049bf:	00 
801049c0:	89 75 fc             	mov    %esi,-0x4(%ebp)
  r = lock->locked && lock->cpu == mycpu();
801049c3:	8b 73 08             	mov    0x8(%ebx),%esi
801049c6:	e8 b5 f1 ff ff       	call   80103b80 <mycpu>
801049cb:	39 c6                	cmp    %eax,%esi
801049cd:	74 11                	je     801049e0 <acquire+0x100>
801049cf:	8b 75 fc             	mov    -0x4(%ebp),%esi
801049d2:	e9 29 ff ff ff       	jmp    80104900 <acquire+0x20>
801049d7:	90                   	nop
801049d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801049df:	00 
  popcli();
801049e0:	e8 eb fd ff ff       	call   801047d0 <popcli>
    panic("acquire");
801049e5:	83 ec 0c             	sub    $0xc,%esp
801049e8:	68 c9 7a 10 80       	push   $0x80107ac9
801049ed:	e8 ae b9 ff ff       	call   801003a0 <panic>
801049f2:	66 90                	xchg   %ax,%ax
801049f4:	66 90                	xchg   %ax,%ax
801049f6:	66 90                	xchg   %ax,%ax
801049f8:	66 90                	xchg   %ax,%ax
801049fa:	66 90                	xchg   %ax,%ax
801049fc:	66 90                	xchg   %ax,%ax
801049fe:	66 90                	xchg   %ax,%ax

80104a00 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104a00:	55                   	push   %ebp
80104a01:	89 e5                	mov    %esp,%ebp
80104a03:	57                   	push   %edi
80104a04:	8b 55 08             	mov    0x8(%ebp),%edx
80104a07:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104a0a:	89 d0                	mov    %edx,%eax
80104a0c:	09 c8                	or     %ecx,%eax
80104a0e:	a8 03                	test   $0x3,%al
80104a10:	75 1e                	jne    80104a30 <memset+0x30>
    c &= 0xFF;
80104a12:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104a16:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
80104a19:	89 d7                	mov    %edx,%edi
80104a1b:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
80104a21:	fc                   	cld
80104a22:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104a24:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104a27:	89 d0                	mov    %edx,%eax
80104a29:	c9                   	leave
80104a2a:	c3                   	ret
80104a2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80104a30:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a33:	89 d7                	mov    %edx,%edi
80104a35:	fc                   	cld
80104a36:	f3 aa                	rep stos %al,%es:(%edi)
80104a38:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104a3b:	89 d0                	mov    %edx,%eax
80104a3d:	c9                   	leave
80104a3e:	c3                   	ret
80104a3f:	90                   	nop

80104a40 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104a40:	55                   	push   %ebp
80104a41:	89 e5                	mov    %esp,%ebp
80104a43:	83 ec 08             	sub    $0x8,%esp
80104a46:	8b 45 08             	mov    0x8(%ebp),%eax
80104a49:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104a4c:	89 75 fc             	mov    %esi,-0x4(%ebp)
80104a4f:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104a52:	8d 34 08             	lea    (%eax,%ecx,1),%esi
80104a55:	85 c9                	test   %ecx,%ecx
80104a57:	74 32                	je     80104a8b <memcmp+0x4b>
80104a59:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104a5c:	eb 0c                	jmp    80104a6a <memcmp+0x2a>
80104a5e:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104a60:	83 c0 01             	add    $0x1,%eax
80104a63:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104a66:	39 f0                	cmp    %esi,%eax
80104a68:	74 1e                	je     80104a88 <memcmp+0x48>
    if(*s1 != *s2)
80104a6a:	0f b6 08             	movzbl (%eax),%ecx
80104a6d:	0f b6 1a             	movzbl (%edx),%ebx
80104a70:	38 d9                	cmp    %bl,%cl
80104a72:	74 ec                	je     80104a60 <memcmp+0x20>
      return *s1 - *s2;
80104a74:	0f b6 c1             	movzbl %cl,%eax
  }

  return 0;
}
80104a77:	8b 75 fc             	mov    -0x4(%ebp),%esi
      return *s1 - *s2;
80104a7a:	29 d8                	sub    %ebx,%eax
80104a7c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
}
80104a7f:	c9                   	leave
80104a80:	c3                   	ret
80104a81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a88:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104a8b:	8b 75 fc             	mov    -0x4(%ebp),%esi
  return 0;
80104a8e:	31 c0                	xor    %eax,%eax
}
80104a90:	c9                   	leave
80104a91:	c3                   	ret
80104a92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a9f:	00 

80104aa0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104aa0:	55                   	push   %ebp
80104aa1:	89 e5                	mov    %esp,%ebp
80104aa3:	57                   	push   %edi
80104aa4:	8b 55 08             	mov    0x8(%ebp),%edx
80104aa7:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104aaa:	56                   	push   %esi
80104aab:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104aae:	39 d6                	cmp    %edx,%esi
80104ab0:	73 36                	jae    80104ae8 <memmove+0x48>
80104ab2:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104ab5:	39 fa                	cmp    %edi,%edx
80104ab7:	73 2f                	jae    80104ae8 <memmove+0x48>
    s += n;
    d += n;
    while(n-- > 0)
80104ab9:	85 c9                	test   %ecx,%ecx
80104abb:	74 1f                	je     80104adc <memmove+0x3c>
      *--d = *--s;
80104abd:	29 cf                	sub    %ecx,%edi
    while(n-- > 0)
80104abf:	8d 41 ff             	lea    -0x1(%ecx),%eax
      *--d = *--s;
80104ac2:	89 fe                	mov    %edi,%esi
80104ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ac8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104acf:	00 
80104ad0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104ad4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104ad7:	83 e8 01             	sub    $0x1,%eax
80104ada:	73 f4                	jae    80104ad0 <memmove+0x30>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104adc:	5e                   	pop    %esi
80104add:	89 d0                	mov    %edx,%eax
80104adf:	5f                   	pop    %edi
80104ae0:	5d                   	pop    %ebp
80104ae1:	c3                   	ret
80104ae2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104ae8:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80104aeb:	89 d7                	mov    %edx,%edi
80104aed:	85 c9                	test   %ecx,%ecx
80104aef:	74 eb                	je     80104adc <memmove+0x3c>
80104af1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104af8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104aff:	00 
      *d++ = *s++;
80104b00:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104b01:	39 f0                	cmp    %esi,%eax
80104b03:	75 fb                	jne    80104b00 <memmove+0x60>
}
80104b05:	5e                   	pop    %esi
80104b06:	89 d0                	mov    %edx,%eax
80104b08:	5f                   	pop    %edi
80104b09:	5d                   	pop    %ebp
80104b0a:	c3                   	ret
80104b0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104b10 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104b10:	eb 8e                	jmp    80104aa0 <memmove>
80104b12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b1f:	00 

80104b20 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104b20:	55                   	push   %ebp
80104b21:	89 e5                	mov    %esp,%ebp
80104b23:	53                   	push   %ebx
80104b24:	8b 55 10             	mov    0x10(%ebp),%edx
80104b27:	8b 45 08             	mov    0x8(%ebp),%eax
80104b2a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
80104b2d:	85 d2                	test   %edx,%edx
80104b2f:	75 16                	jne    80104b47 <strncmp+0x27>
80104b31:	eb 2d                	jmp    80104b60 <strncmp+0x40>
80104b33:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b38:	3a 19                	cmp    (%ecx),%bl
80104b3a:	75 12                	jne    80104b4e <strncmp+0x2e>
    n--, p++, q++;
80104b3c:	83 c0 01             	add    $0x1,%eax
80104b3f:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104b42:	83 ea 01             	sub    $0x1,%edx
80104b45:	74 19                	je     80104b60 <strncmp+0x40>
80104b47:	0f b6 18             	movzbl (%eax),%ebx
80104b4a:	84 db                	test   %bl,%bl
80104b4c:	75 ea                	jne    80104b38 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104b4e:	0f b6 00             	movzbl (%eax),%eax
80104b51:	0f b6 11             	movzbl (%ecx),%edx
}
80104b54:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b57:	c9                   	leave
  return (uchar)*p - (uchar)*q;
80104b58:	29 d0                	sub    %edx,%eax
}
80104b5a:	c3                   	ret
80104b5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b60:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80104b63:	31 c0                	xor    %eax,%eax
}
80104b65:	c9                   	leave
80104b66:	c3                   	ret
80104b67:	90                   	nop
80104b68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b6f:	00 

80104b70 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104b70:	55                   	push   %ebp
80104b71:	89 e5                	mov    %esp,%ebp
80104b73:	53                   	push   %ebx
80104b74:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104b77:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104b7a:	8b 45 08             	mov    0x8(%ebp),%eax
80104b7d:	eb 14                	jmp    80104b93 <strncpy+0x23>
80104b7f:	90                   	nop
80104b80:	0f b6 19             	movzbl (%ecx),%ebx
80104b83:	83 c1 01             	add    $0x1,%ecx
80104b86:	83 c0 01             	add    $0x1,%eax
80104b89:	88 58 ff             	mov    %bl,-0x1(%eax)
80104b8c:	84 db                	test   %bl,%bl
80104b8e:	74 10                	je     80104ba0 <strncpy+0x30>
80104b90:	83 ea 01             	sub    $0x1,%edx
80104b93:	85 d2                	test   %edx,%edx
80104b95:	7f e9                	jg     80104b80 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
80104b97:	8b 45 08             	mov    0x8(%ebp),%eax
80104b9a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b9d:	c9                   	leave
80104b9e:	c3                   	ret
80104b9f:	90                   	nop
  while(n-- > 0)
80104ba0:	8d 4c 10 ff          	lea    -0x1(%eax,%edx,1),%ecx
80104ba4:	83 fa 01             	cmp    $0x1,%edx
80104ba7:	74 ee                	je     80104b97 <strncpy+0x27>
80104ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104bb0:	83 c0 01             	add    $0x1,%eax
80104bb3:	89 ca                	mov    %ecx,%edx
80104bb5:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
80104bb9:	29 c2                	sub    %eax,%edx
80104bbb:	85 d2                	test   %edx,%edx
80104bbd:	7f f1                	jg     80104bb0 <strncpy+0x40>
}
80104bbf:	8b 45 08             	mov    0x8(%ebp),%eax
80104bc2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104bc5:	c9                   	leave
80104bc6:	c3                   	ret
80104bc7:	90                   	nop
80104bc8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104bcf:	00 

80104bd0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	53                   	push   %ebx
80104bd4:	8b 55 10             	mov    0x10(%ebp),%edx
80104bd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104bda:	85 d2                	test   %edx,%edx
80104bdc:	7e 39                	jle    80104c17 <safestrcpy+0x47>
80104bde:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104be2:	8b 55 08             	mov    0x8(%ebp),%edx
80104be5:	eb 29                	jmp    80104c10 <safestrcpy+0x40>
80104be7:	eb 17                	jmp    80104c00 <safestrcpy+0x30>
80104be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bf0:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104bf7:	00 
80104bf8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104bff:	00 
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104c00:	0f b6 08             	movzbl (%eax),%ecx
80104c03:	83 c0 01             	add    $0x1,%eax
80104c06:	83 c2 01             	add    $0x1,%edx
80104c09:	88 4a ff             	mov    %cl,-0x1(%edx)
80104c0c:	84 c9                	test   %cl,%cl
80104c0e:	74 04                	je     80104c14 <safestrcpy+0x44>
80104c10:	39 d8                	cmp    %ebx,%eax
80104c12:	75 ec                	jne    80104c00 <safestrcpy+0x30>
    ;
  *s = 0;
80104c14:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104c17:	8b 45 08             	mov    0x8(%ebp),%eax
80104c1a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c1d:	c9                   	leave
80104c1e:	c3                   	ret
80104c1f:	90                   	nop

80104c20 <strlen>:

int
strlen(const char *s)
{
80104c20:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104c21:	31 c0                	xor    %eax,%eax
{
80104c23:	89 e5                	mov    %esp,%ebp
80104c25:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104c28:	80 3a 00             	cmpb   $0x0,(%edx)
80104c2b:	74 0c                	je     80104c39 <strlen+0x19>
80104c2d:	8d 76 00             	lea    0x0(%esi),%esi
80104c30:	83 c0 01             	add    $0x1,%eax
80104c33:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104c37:	75 f7                	jne    80104c30 <strlen+0x10>
    ;
  return n;
}
80104c39:	5d                   	pop    %ebp
80104c3a:	c3                   	ret

80104c3b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104c3b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104c3f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104c43:	55                   	push   %ebp
  pushl %ebx
80104c44:	53                   	push   %ebx
  pushl %esi
80104c45:	56                   	push   %esi
  pushl %edi
80104c46:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104c47:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104c49:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104c4b:	5f                   	pop    %edi
  popl %esi
80104c4c:	5e                   	pop    %esi
  popl %ebx
80104c4d:	5b                   	pop    %ebx
  popl %ebp
80104c4e:	5d                   	pop    %ebp
  ret
80104c4f:	c3                   	ret

80104c50 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104c50:	55                   	push   %ebp
80104c51:	89 e5                	mov    %esp,%ebp
80104c53:	53                   	push   %ebx
80104c54:	83 ec 04             	sub    $0x4,%esp
80104c57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104c5a:	e8 c1 ef ff ff       	call   80103c20 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104c5f:	8b 00                	mov    (%eax),%eax
80104c61:	39 c3                	cmp    %eax,%ebx
80104c63:	73 1b                	jae    80104c80 <fetchint+0x30>
80104c65:	8d 53 04             	lea    0x4(%ebx),%edx
80104c68:	39 d0                	cmp    %edx,%eax
80104c6a:	72 14                	jb     80104c80 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104c6c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c6f:	8b 13                	mov    (%ebx),%edx
80104c71:	89 10                	mov    %edx,(%eax)
  return 0;
80104c73:	31 c0                	xor    %eax,%eax
}
80104c75:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c78:	c9                   	leave
80104c79:	c3                   	ret
80104c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104c80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c85:	eb ee                	jmp    80104c75 <fetchint+0x25>
80104c87:	90                   	nop
80104c88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c8f:	00 

80104c90 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104c90:	55                   	push   %ebp
80104c91:	89 e5                	mov    %esp,%ebp
80104c93:	53                   	push   %ebx
80104c94:	83 ec 04             	sub    $0x4,%esp
80104c97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104c9a:	e8 81 ef ff ff       	call   80103c20 <myproc>

  if(addr >= curproc->sz)
80104c9f:	3b 18                	cmp    (%eax),%ebx
80104ca1:	73 35                	jae    80104cd8 <fetchstr+0x48>
    return -1;
  *pp = (char*)addr;
80104ca3:	8b 55 0c             	mov    0xc(%ebp),%edx
80104ca6:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104ca8:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104caa:	39 d3                	cmp    %edx,%ebx
80104cac:	73 2a                	jae    80104cd8 <fetchstr+0x48>
80104cae:	89 d8                	mov    %ebx,%eax
80104cb0:	eb 15                	jmp    80104cc7 <fetchstr+0x37>
80104cb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104cb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104cbf:	00 
80104cc0:	83 c0 01             	add    $0x1,%eax
80104cc3:	39 d0                	cmp    %edx,%eax
80104cc5:	73 11                	jae    80104cd8 <fetchstr+0x48>
    if(*s == 0)
80104cc7:	80 38 00             	cmpb   $0x0,(%eax)
80104cca:	75 f4                	jne    80104cc0 <fetchstr+0x30>
      return s - *pp;
80104ccc:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104cce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104cd1:	c9                   	leave
80104cd2:	c3                   	ret
80104cd3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104cd8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80104cdb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ce0:	c9                   	leave
80104ce1:	c3                   	ret
80104ce2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ce8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104cef:	00 

80104cf0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104cf0:	55                   	push   %ebp
80104cf1:	89 e5                	mov    %esp,%ebp
80104cf3:	56                   	push   %esi
80104cf4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104cf5:	e8 26 ef ff ff       	call   80103c20 <myproc>
80104cfa:	8b 55 08             	mov    0x8(%ebp),%edx
80104cfd:	8b 40 18             	mov    0x18(%eax),%eax
80104d00:	8b 40 44             	mov    0x44(%eax),%eax
80104d03:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104d06:	e8 15 ef ff ff       	call   80103c20 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d0b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104d0e:	8b 00                	mov    (%eax),%eax
80104d10:	39 c6                	cmp    %eax,%esi
80104d12:	73 1c                	jae    80104d30 <argint+0x40>
80104d14:	8d 53 08             	lea    0x8(%ebx),%edx
80104d17:	39 d0                	cmp    %edx,%eax
80104d19:	72 15                	jb     80104d30 <argint+0x40>
  *ip = *(int*)(addr);
80104d1b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d1e:	8b 53 04             	mov    0x4(%ebx),%edx
80104d21:	89 10                	mov    %edx,(%eax)
  return 0;
80104d23:	31 c0                	xor    %eax,%eax
}
80104d25:	5b                   	pop    %ebx
80104d26:	5e                   	pop    %esi
80104d27:	5d                   	pop    %ebp
80104d28:	c3                   	ret
80104d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104d30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d35:	eb ee                	jmp    80104d25 <argint+0x35>
80104d37:	90                   	nop
80104d38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d3f:	00 

80104d40 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104d40:	55                   	push   %ebp
80104d41:	89 e5                	mov    %esp,%ebp
80104d43:	57                   	push   %edi
80104d44:	56                   	push   %esi
80104d45:	53                   	push   %ebx
80104d46:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80104d49:	e8 d2 ee ff ff       	call   80103c20 <myproc>
80104d4e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d50:	e8 cb ee ff ff       	call   80103c20 <myproc>
80104d55:	8b 55 08             	mov    0x8(%ebp),%edx
80104d58:	8b 40 18             	mov    0x18(%eax),%eax
80104d5b:	8b 40 44             	mov    0x44(%eax),%eax
80104d5e:	8d 3c 90             	lea    (%eax,%edx,4),%edi
  struct proc *curproc = myproc();
80104d61:	e8 ba ee ff ff       	call   80103c20 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d66:	8d 5f 04             	lea    0x4(%edi),%ebx
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104d69:	8b 00                	mov    (%eax),%eax
80104d6b:	39 c3                	cmp    %eax,%ebx
80104d6d:	73 31                	jae    80104da0 <argptr+0x60>
80104d6f:	8d 57 08             	lea    0x8(%edi),%edx
80104d72:	39 d0                	cmp    %edx,%eax
80104d74:	72 2a                	jb     80104da0 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104d76:	8b 45 10             	mov    0x10(%ebp),%eax
80104d79:	85 c0                	test   %eax,%eax
80104d7b:	78 23                	js     80104da0 <argptr+0x60>
  *ip = *(int*)(addr);
80104d7d:	8b 57 04             	mov    0x4(%edi),%edx
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104d80:	8b 0e                	mov    (%esi),%ecx
80104d82:	39 ca                	cmp    %ecx,%edx
80104d84:	73 1a                	jae    80104da0 <argptr+0x60>
80104d86:	8b 45 10             	mov    0x10(%ebp),%eax
80104d89:	01 d0                	add    %edx,%eax
80104d8b:	39 c1                	cmp    %eax,%ecx
80104d8d:	72 11                	jb     80104da0 <argptr+0x60>
    return -1;
  *pp = (char*)i;
80104d8f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d92:	89 10                	mov    %edx,(%eax)
  return 0;
80104d94:	31 c0                	xor    %eax,%eax
}
80104d96:	83 c4 0c             	add    $0xc,%esp
80104d99:	5b                   	pop    %ebx
80104d9a:	5e                   	pop    %esi
80104d9b:	5f                   	pop    %edi
80104d9c:	5d                   	pop    %ebp
80104d9d:	c3                   	ret
80104d9e:	66 90                	xchg   %ax,%ax
    return -1;
80104da0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104da5:	eb ef                	jmp    80104d96 <argptr+0x56>
80104da7:	90                   	nop
80104da8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104daf:	00 

80104db0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104db0:	55                   	push   %ebp
80104db1:	89 e5                	mov    %esp,%ebp
80104db3:	56                   	push   %esi
80104db4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104db5:	e8 66 ee ff ff       	call   80103c20 <myproc>
80104dba:	8b 55 08             	mov    0x8(%ebp),%edx
80104dbd:	8b 40 18             	mov    0x18(%eax),%eax
80104dc0:	8b 40 44             	mov    0x44(%eax),%eax
80104dc3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104dc6:	e8 55 ee ff ff       	call   80103c20 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104dcb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104dce:	8b 00                	mov    (%eax),%eax
80104dd0:	39 c6                	cmp    %eax,%esi
80104dd2:	73 44                	jae    80104e18 <argstr+0x68>
80104dd4:	8d 53 08             	lea    0x8(%ebx),%edx
80104dd7:	39 d0                	cmp    %edx,%eax
80104dd9:	72 3d                	jb     80104e18 <argstr+0x68>
  *ip = *(int*)(addr);
80104ddb:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80104dde:	e8 3d ee ff ff       	call   80103c20 <myproc>
  if(addr >= curproc->sz)
80104de3:	3b 18                	cmp    (%eax),%ebx
80104de5:	73 31                	jae    80104e18 <argstr+0x68>
  *pp = (char*)addr;
80104de7:	8b 55 0c             	mov    0xc(%ebp),%edx
80104dea:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104dec:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104dee:	39 d3                	cmp    %edx,%ebx
80104df0:	73 26                	jae    80104e18 <argstr+0x68>
80104df2:	89 d8                	mov    %ebx,%eax
80104df4:	eb 11                	jmp    80104e07 <argstr+0x57>
80104df6:	66 90                	xchg   %ax,%ax
80104df8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104dff:	00 
80104e00:	83 c0 01             	add    $0x1,%eax
80104e03:	39 d0                	cmp    %edx,%eax
80104e05:	73 11                	jae    80104e18 <argstr+0x68>
    if(*s == 0)
80104e07:	80 38 00             	cmpb   $0x0,(%eax)
80104e0a:	75 f4                	jne    80104e00 <argstr+0x50>
      return s - *pp;
80104e0c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104e0e:	5b                   	pop    %ebx
80104e0f:	5e                   	pop    %esi
80104e10:	5d                   	pop    %ebp
80104e11:	c3                   	ret
80104e12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e18:	5b                   	pop    %ebx
    return -1;
80104e19:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e1e:	5e                   	pop    %esi
80104e1f:	5d                   	pop    %ebp
80104e20:	c3                   	ret
80104e21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e2f:	00 

80104e30 <syscall>:
[SYS_va2pa]   sys_va2pa,
};

void
syscall(void)
{
80104e30:	55                   	push   %ebp
80104e31:	89 e5                	mov    %esp,%ebp
80104e33:	53                   	push   %ebx
80104e34:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104e37:	e8 e4 ed ff ff       	call   80103c20 <myproc>
80104e3c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104e3e:	8b 40 18             	mov    0x18(%eax),%eax
80104e41:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104e44:	8d 50 ff             	lea    -0x1(%eax),%edx
80104e47:	83 fa 16             	cmp    $0x16,%edx
80104e4a:	77 24                	ja     80104e70 <syscall+0x40>
80104e4c:	8b 14 85 40 80 10 80 	mov    -0x7fef7fc0(,%eax,4),%edx
80104e53:	85 d2                	test   %edx,%edx
80104e55:	74 19                	je     80104e70 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104e57:	ff d2                	call   *%edx
80104e59:	89 c2                	mov    %eax,%edx
80104e5b:	8b 43 18             	mov    0x18(%ebx),%eax
80104e5e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104e61:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e64:	c9                   	leave
80104e65:	c3                   	ret
80104e66:	66 90                	xchg   %ax,%ax
80104e68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e6f:	00 
    cprintf("%d %s: unknown sys call %d\n",
80104e70:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104e71:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104e74:	50                   	push   %eax
80104e75:	ff 73 10             	push   0x10(%ebx)
80104e78:	68 d1 7a 10 80       	push   $0x80107ad1
80104e7d:	e8 6e b8 ff ff       	call   801006f0 <cprintf>
    curproc->tf->eax = -1;
80104e82:	8b 43 18             	mov    0x18(%ebx),%eax
80104e85:	83 c4 10             	add    $0x10,%esp
80104e88:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104e8f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e92:	c9                   	leave
80104e93:	c3                   	ret
80104e94:	66 90                	xchg   %ax,%ax
80104e96:	66 90                	xchg   %ax,%ax
80104e98:	66 90                	xchg   %ax,%ax
80104e9a:	66 90                	xchg   %ax,%ax
80104e9c:	66 90                	xchg   %ax,%ax
80104e9e:	66 90                	xchg   %ax,%ax

80104ea0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104ea0:	55                   	push   %ebp
80104ea1:	89 e5                	mov    %esp,%ebp
80104ea3:	83 ec 40             	sub    $0x40,%esp
80104ea6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104ea9:	8d 5d da             	lea    -0x26(%ebp),%ebx
80104eac:	53                   	push   %ebx
80104ead:	50                   	push   %eax
{
80104eae:	89 7d fc             	mov    %edi,-0x4(%ebp)
80104eb1:	66 89 55 d6          	mov    %dx,-0x2a(%ebp)
80104eb5:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104eb9:	e8 52 d3 ff ff       	call   80102210 <nameiparent>
80104ebe:	83 c4 10             	add    $0x10,%esp
80104ec1:	85 c0                	test   %eax,%eax
80104ec3:	0f 84 47 01 00 00    	je     80105010 <create+0x170>
    return 0;
  ilock(dp);
80104ec9:	83 ec 0c             	sub    $0xc,%esp
80104ecc:	89 75 f8             	mov    %esi,-0x8(%ebp)
80104ecf:	89 c6                	mov    %eax,%esi
80104ed1:	50                   	push   %eax
80104ed2:	e8 89 c9 ff ff       	call   80101860 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104ed7:	83 c4 0c             	add    $0xc,%esp
80104eda:	6a 00                	push   $0x0
80104edc:	53                   	push   %ebx
80104edd:	56                   	push   %esi
80104ede:	e8 1d cf ff ff       	call   80101e00 <dirlookup>
80104ee3:	83 c4 10             	add    $0x10,%esp
80104ee6:	89 c7                	mov    %eax,%edi
80104ee8:	85 c0                	test   %eax,%eax
80104eea:	74 54                	je     80104f40 <create+0xa0>
    iunlockput(dp);
80104eec:	83 ec 0c             	sub    $0xc,%esp
80104eef:	56                   	push   %esi
80104ef0:	e8 1b cc ff ff       	call   80101b10 <iunlockput>
    ilock(ip);
80104ef5:	89 3c 24             	mov    %edi,(%esp)
80104ef8:	e8 63 c9 ff ff       	call   80101860 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104efd:	83 c4 10             	add    $0x10,%esp
80104f00:	66 83 7d d6 02       	cmpw   $0x2,-0x2a(%ebp)
80104f05:	75 19                	jne    80104f20 <create+0x80>
80104f07:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104f0c:	75 12                	jne    80104f20 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104f0e:	89 f8                	mov    %edi,%eax
80104f10:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104f13:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104f16:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104f19:	c9                   	leave
80104f1a:	c3                   	ret
80104f1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80104f20:	83 ec 0c             	sub    $0xc,%esp
80104f23:	57                   	push   %edi
    return 0;
80104f24:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104f26:	e8 e5 cb ff ff       	call   80101b10 <iunlockput>
}
80104f2b:	89 f8                	mov    %edi,%eax
    return 0;
80104f2d:	8b 75 f8             	mov    -0x8(%ebp),%esi
}
80104f30:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104f33:	8b 7d fc             	mov    -0x4(%ebp),%edi
    return 0;
80104f36:	83 c4 10             	add    $0x10,%esp
}
80104f39:	c9                   	leave
80104f3a:	c3                   	ret
80104f3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  if((ip = ialloc(dp->dev, type)) == 0)
80104f40:	0f bf 45 d6          	movswl -0x2a(%ebp),%eax
80104f44:	83 ec 08             	sub    $0x8,%esp
80104f47:	50                   	push   %eax
80104f48:	ff 36                	push   (%esi)
80104f4a:	e8 91 c7 ff ff       	call   801016e0 <ialloc>
80104f4f:	83 c4 10             	add    $0x10,%esp
80104f52:	89 c7                	mov    %eax,%edi
80104f54:	85 c0                	test   %eax,%eax
80104f56:	0f 84 cd 00 00 00    	je     80105029 <create+0x189>
  ilock(ip);
80104f5c:	83 ec 0c             	sub    $0xc,%esp
80104f5f:	50                   	push   %eax
80104f60:	e8 fb c8 ff ff       	call   80101860 <ilock>
  ip->major = major;
80104f65:	0f b7 45 d4          	movzwl -0x2c(%ebp),%eax
80104f69:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104f6d:	0f b7 45 08          	movzwl 0x8(%ebp),%eax
80104f71:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104f75:	b8 01 00 00 00       	mov    $0x1,%eax
80104f7a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104f7e:	89 3c 24             	mov    %edi,(%esp)
80104f81:	e8 1a c8 ff ff       	call   801017a0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104f86:	83 c4 10             	add    $0x10,%esp
80104f89:	66 83 7d d6 01       	cmpw   $0x1,-0x2a(%ebp)
80104f8e:	74 30                	je     80104fc0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104f90:	83 ec 04             	sub    $0x4,%esp
80104f93:	ff 77 04             	push   0x4(%edi)
80104f96:	53                   	push   %ebx
80104f97:	56                   	push   %esi
80104f98:	e8 93 d1 ff ff       	call   80102130 <dirlink>
80104f9d:	83 c4 10             	add    $0x10,%esp
80104fa0:	85 c0                	test   %eax,%eax
80104fa2:	78 78                	js     8010501c <create+0x17c>
  iunlockput(dp);
80104fa4:	83 ec 0c             	sub    $0xc,%esp
80104fa7:	56                   	push   %esi
80104fa8:	e8 63 cb ff ff       	call   80101b10 <iunlockput>
}
80104fad:	89 f8                	mov    %edi,%eax
  return ip;
80104faf:	8b 75 f8             	mov    -0x8(%ebp),%esi
}
80104fb2:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104fb5:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return ip;
80104fb8:	83 c4 10             	add    $0x10,%esp
}
80104fbb:	c9                   	leave
80104fbc:	c3                   	ret
80104fbd:	8d 76 00             	lea    0x0(%esi),%esi
    iupdate(dp);
80104fc0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104fc3:	66 83 46 56 01       	addw   $0x1,0x56(%esi)
    iupdate(dp);
80104fc8:	56                   	push   %esi
80104fc9:	e8 d2 c7 ff ff       	call   801017a0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104fce:	83 c4 0c             	add    $0xc,%esp
80104fd1:	ff 77 04             	push   0x4(%edi)
80104fd4:	68 09 7b 10 80       	push   $0x80107b09
80104fd9:	57                   	push   %edi
80104fda:	e8 51 d1 ff ff       	call   80102130 <dirlink>
80104fdf:	83 c4 10             	add    $0x10,%esp
80104fe2:	85 c0                	test   %eax,%eax
80104fe4:	78 18                	js     80104ffe <create+0x15e>
80104fe6:	83 ec 04             	sub    $0x4,%esp
80104fe9:	ff 76 04             	push   0x4(%esi)
80104fec:	68 08 7b 10 80       	push   $0x80107b08
80104ff1:	57                   	push   %edi
80104ff2:	e8 39 d1 ff ff       	call   80102130 <dirlink>
80104ff7:	83 c4 10             	add    $0x10,%esp
80104ffa:	85 c0                	test   %eax,%eax
80104ffc:	79 92                	jns    80104f90 <create+0xf0>
      panic("create dots");
80104ffe:	83 ec 0c             	sub    $0xc,%esp
80105001:	68 fc 7a 10 80       	push   $0x80107afc
80105006:	e8 95 b3 ff ff       	call   801003a0 <panic>
8010500b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return 0;
80105010:	31 ff                	xor    %edi,%edi
}
80105012:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105015:	89 f8                	mov    %edi,%eax
80105017:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010501a:	c9                   	leave
8010501b:	c3                   	ret
    panic("create: dirlink");
8010501c:	83 ec 0c             	sub    $0xc,%esp
8010501f:	68 0b 7b 10 80       	push   $0x80107b0b
80105024:	e8 77 b3 ff ff       	call   801003a0 <panic>
    panic("create: ialloc");
80105029:	83 ec 0c             	sub    $0xc,%esp
8010502c:	68 ed 7a 10 80       	push   $0x80107aed
80105031:	e8 6a b3 ff ff       	call   801003a0 <panic>
80105036:	66 90                	xchg   %ax,%ax
80105038:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010503f:	00 

80105040 <sys_dup>:
{
80105040:	55                   	push   %ebp
80105041:	89 e5                	mov    %esp,%ebp
80105043:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
80105046:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105049:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  if(argint(n, &fd) < 0)
8010504c:	50                   	push   %eax
8010504d:	6a 00                	push   $0x0
8010504f:	e8 9c fc ff ff       	call   80104cf0 <argint>
80105054:	83 c4 10             	add    $0x10,%esp
80105057:	85 c0                	test   %eax,%eax
80105059:	78 38                	js     80105093 <sys_dup+0x53>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010505b:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010505f:	77 32                	ja     80105093 <sys_dup+0x53>
80105061:	89 75 fc             	mov    %esi,-0x4(%ebp)
80105064:	e8 b7 eb ff ff       	call   80103c20 <myproc>
80105069:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010506c:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105070:	85 f6                	test   %esi,%esi
80105072:	74 1c                	je     80105090 <sys_dup+0x50>
  struct proc *curproc = myproc();
80105074:	e8 a7 eb ff ff       	call   80103c20 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105079:	31 db                	xor    %ebx,%ebx
8010507b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105080:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105084:	85 d2                	test   %edx,%edx
80105086:	74 18                	je     801050a0 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80105088:	83 c3 01             	add    $0x1,%ebx
8010508b:	83 fb 10             	cmp    $0x10,%ebx
8010508e:	75 f0                	jne    80105080 <sys_dup+0x40>
80105090:	8b 75 fc             	mov    -0x4(%ebp),%esi
    return -1;
80105093:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105098:	89 d8                	mov    %ebx,%eax
8010509a:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010509d:	c9                   	leave
8010509e:	c3                   	ret
8010509f:	90                   	nop
  filedup(f);
801050a0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801050a3:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
801050a7:	56                   	push   %esi
801050a8:	e8 a3 be ff ff       	call   80100f50 <filedup>
}
801050ad:	89 d8                	mov    %ebx,%eax
  return fd;
801050af:	8b 75 fc             	mov    -0x4(%ebp),%esi
}
801050b2:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  return fd;
801050b5:	83 c4 10             	add    $0x10,%esp
}
801050b8:	c9                   	leave
801050b9:	c3                   	ret
801050ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801050c0 <sys_read>:
{
801050c0:	55                   	push   %ebp
801050c1:	89 e5                	mov    %esp,%ebp
801050c3:	83 ec 20             	sub    $0x20,%esp
801050c6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  if(argint(n, &fd) < 0)
801050c9:	8d 5d f4             	lea    -0xc(%ebp),%ebx
801050cc:	53                   	push   %ebx
801050cd:	6a 00                	push   $0x0
801050cf:	e8 1c fc ff ff       	call   80104cf0 <argint>
801050d4:	83 c4 10             	add    $0x10,%esp
801050d7:	85 c0                	test   %eax,%eax
801050d9:	78 68                	js     80105143 <sys_read+0x83>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801050db:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801050df:	77 62                	ja     80105143 <sys_read+0x83>
801050e1:	89 75 fc             	mov    %esi,-0x4(%ebp)
801050e4:	e8 37 eb ff ff       	call   80103c20 <myproc>
801050e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801050ec:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801050f0:	85 f6                	test   %esi,%esi
801050f2:	74 4c                	je     80105140 <sys_read+0x80>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801050f4:	83 ec 08             	sub    $0x8,%esp
801050f7:	8d 45 f0             	lea    -0x10(%ebp),%eax
801050fa:	50                   	push   %eax
801050fb:	6a 02                	push   $0x2
801050fd:	e8 ee fb ff ff       	call   80104cf0 <argint>
80105102:	83 c4 10             	add    $0x10,%esp
80105105:	85 c0                	test   %eax,%eax
80105107:	78 37                	js     80105140 <sys_read+0x80>
80105109:	83 ec 04             	sub    $0x4,%esp
8010510c:	ff 75 f0             	push   -0x10(%ebp)
8010510f:	53                   	push   %ebx
80105110:	6a 01                	push   $0x1
80105112:	e8 29 fc ff ff       	call   80104d40 <argptr>
80105117:	83 c4 10             	add    $0x10,%esp
8010511a:	85 c0                	test   %eax,%eax
8010511c:	78 22                	js     80105140 <sys_read+0x80>
  return fileread(f, p, n);
8010511e:	83 ec 04             	sub    $0x4,%esp
80105121:	ff 75 f0             	push   -0x10(%ebp)
80105124:	ff 75 f4             	push   -0xc(%ebp)
80105127:	56                   	push   %esi
80105128:	e8 a3 bf ff ff       	call   801010d0 <fileread>
8010512d:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105130:	83 c4 10             	add    $0x10,%esp
}
80105133:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105136:	c9                   	leave
80105137:	c3                   	ret
80105138:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010513f:	00 
80105140:	8b 75 fc             	mov    -0x4(%ebp),%esi
    return -1;
80105143:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105148:	eb e9                	jmp    80105133 <sys_read+0x73>
8010514a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105150 <sys_write>:
{
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	83 ec 20             	sub    $0x20,%esp
80105156:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  if(argint(n, &fd) < 0)
80105159:	8d 5d f4             	lea    -0xc(%ebp),%ebx
8010515c:	53                   	push   %ebx
8010515d:	6a 00                	push   $0x0
8010515f:	e8 8c fb ff ff       	call   80104cf0 <argint>
80105164:	83 c4 10             	add    $0x10,%esp
80105167:	85 c0                	test   %eax,%eax
80105169:	78 68                	js     801051d3 <sys_write+0x83>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010516b:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010516f:	77 62                	ja     801051d3 <sys_write+0x83>
80105171:	89 75 fc             	mov    %esi,-0x4(%ebp)
80105174:	e8 a7 ea ff ff       	call   80103c20 <myproc>
80105179:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010517c:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105180:	85 f6                	test   %esi,%esi
80105182:	74 4c                	je     801051d0 <sys_write+0x80>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105184:	83 ec 08             	sub    $0x8,%esp
80105187:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010518a:	50                   	push   %eax
8010518b:	6a 02                	push   $0x2
8010518d:	e8 5e fb ff ff       	call   80104cf0 <argint>
80105192:	83 c4 10             	add    $0x10,%esp
80105195:	85 c0                	test   %eax,%eax
80105197:	78 37                	js     801051d0 <sys_write+0x80>
80105199:	83 ec 04             	sub    $0x4,%esp
8010519c:	ff 75 f0             	push   -0x10(%ebp)
8010519f:	53                   	push   %ebx
801051a0:	6a 01                	push   $0x1
801051a2:	e8 99 fb ff ff       	call   80104d40 <argptr>
801051a7:	83 c4 10             	add    $0x10,%esp
801051aa:	85 c0                	test   %eax,%eax
801051ac:	78 22                	js     801051d0 <sys_write+0x80>
  return filewrite(f, p, n);
801051ae:	83 ec 04             	sub    $0x4,%esp
801051b1:	ff 75 f0             	push   -0x10(%ebp)
801051b4:	ff 75 f4             	push   -0xc(%ebp)
801051b7:	56                   	push   %esi
801051b8:	e8 a3 bf ff ff       	call   80101160 <filewrite>
801051bd:	8b 75 fc             	mov    -0x4(%ebp),%esi
801051c0:	83 c4 10             	add    $0x10,%esp
}
801051c3:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801051c6:	c9                   	leave
801051c7:	c3                   	ret
801051c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801051cf:	00 
801051d0:	8b 75 fc             	mov    -0x4(%ebp),%esi
    return -1;
801051d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051d8:	eb e9                	jmp    801051c3 <sys_write+0x73>
801051da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801051e0 <sys_close>:
{
801051e0:	55                   	push   %ebp
801051e1:	89 e5                	mov    %esp,%ebp
801051e3:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
801051e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801051e9:	50                   	push   %eax
801051ea:	6a 00                	push   $0x0
801051ec:	e8 ff fa ff ff       	call   80104cf0 <argint>
801051f1:	83 c4 10             	add    $0x10,%esp
801051f4:	85 c0                	test   %eax,%eax
801051f6:	78 48                	js     80105240 <sys_close+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801051f8:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801051fc:	77 42                	ja     80105240 <sys_close+0x60>
801051fe:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105201:	89 75 fc             	mov    %esi,-0x4(%ebp)
80105204:	e8 17 ea ff ff       	call   80103c20 <myproc>
80105209:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010520c:	8d 5a 08             	lea    0x8(%edx),%ebx
8010520f:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
80105213:	85 f6                	test   %esi,%esi
80105215:	74 23                	je     8010523a <sys_close+0x5a>
  myproc()->ofile[fd] = 0;
80105217:	e8 04 ea ff ff       	call   80103c20 <myproc>
  fileclose(f);
8010521c:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
8010521f:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80105226:	00 
  fileclose(f);
80105227:	56                   	push   %esi
80105228:	e8 73 bd ff ff       	call   80100fa0 <fileclose>
  return 0;
8010522d:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105230:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105233:	83 c4 10             	add    $0x10,%esp
}
80105236:	c9                   	leave
  return 0;
80105237:	31 c0                	xor    %eax,%eax
}
80105239:	c3                   	ret
8010523a:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010523d:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105240:	c9                   	leave
    return -1;
80105241:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105246:	c3                   	ret
80105247:	90                   	nop
80105248:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010524f:	00 

80105250 <sys_fstat>:
{
80105250:	55                   	push   %ebp
80105251:	89 e5                	mov    %esp,%ebp
80105253:	83 ec 20             	sub    $0x20,%esp
80105256:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  if(argint(n, &fd) < 0)
80105259:	8d 5d f4             	lea    -0xc(%ebp),%ebx
8010525c:	53                   	push   %ebx
8010525d:	6a 00                	push   $0x0
8010525f:	e8 8c fa ff ff       	call   80104cf0 <argint>
80105264:	83 c4 10             	add    $0x10,%esp
80105267:	85 c0                	test   %eax,%eax
80105269:	78 48                	js     801052b3 <sys_fstat+0x63>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010526b:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010526f:	77 42                	ja     801052b3 <sys_fstat+0x63>
80105271:	89 75 fc             	mov    %esi,-0x4(%ebp)
80105274:	e8 a7 e9 ff ff       	call   80103c20 <myproc>
80105279:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010527c:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105280:	85 f6                	test   %esi,%esi
80105282:	74 2c                	je     801052b0 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105284:	83 ec 04             	sub    $0x4,%esp
80105287:	6a 14                	push   $0x14
80105289:	53                   	push   %ebx
8010528a:	6a 01                	push   $0x1
8010528c:	e8 af fa ff ff       	call   80104d40 <argptr>
80105291:	83 c4 10             	add    $0x10,%esp
80105294:	85 c0                	test   %eax,%eax
80105296:	78 18                	js     801052b0 <sys_fstat+0x60>
  return filestat(f, st);
80105298:	83 ec 08             	sub    $0x8,%esp
8010529b:	ff 75 f4             	push   -0xc(%ebp)
8010529e:	56                   	push   %esi
8010529f:	e8 dc bd ff ff       	call   80101080 <filestat>
801052a4:	8b 75 fc             	mov    -0x4(%ebp),%esi
801052a7:	83 c4 10             	add    $0x10,%esp
}
801052aa:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801052ad:	c9                   	leave
801052ae:	c3                   	ret
801052af:	90                   	nop
801052b0:	8b 75 fc             	mov    -0x4(%ebp),%esi
    return -1;
801052b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052b8:	eb f0                	jmp    801052aa <sys_fstat+0x5a>
801052ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801052c0 <sys_link>:
{
801052c0:	55                   	push   %ebp
801052c1:	89 e5                	mov    %esp,%ebp
801052c3:	83 ec 40             	sub    $0x40,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801052c6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801052c9:	50                   	push   %eax
801052ca:	6a 00                	push   $0x0
801052cc:	e8 df fa ff ff       	call   80104db0 <argstr>
801052d1:	83 c4 10             	add    $0x10,%esp
801052d4:	85 c0                	test   %eax,%eax
801052d6:	0f 88 0f 01 00 00    	js     801053eb <sys_link+0x12b>
801052dc:	83 ec 08             	sub    $0x8,%esp
801052df:	8d 45 d0             	lea    -0x30(%ebp),%eax
801052e2:	50                   	push   %eax
801052e3:	6a 01                	push   $0x1
801052e5:	e8 c6 fa ff ff       	call   80104db0 <argstr>
801052ea:	83 c4 10             	add    $0x10,%esp
801052ed:	85 c0                	test   %eax,%eax
801052ef:	0f 88 f6 00 00 00    	js     801053eb <sys_link+0x12b>
801052f5:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  begin_op();
801052f8:	e8 c3 dc ff ff       	call   80102fc0 <begin_op>
  if((ip = namei(old)) == 0){
801052fd:	83 ec 0c             	sub    $0xc,%esp
80105300:	ff 75 d4             	push   -0x2c(%ebp)
80105303:	e8 e8 ce ff ff       	call   801021f0 <namei>
80105308:	83 c4 10             	add    $0x10,%esp
8010530b:	89 c3                	mov    %eax,%ebx
8010530d:	85 c0                	test   %eax,%eax
8010530f:	0f 84 f3 00 00 00    	je     80105408 <sys_link+0x148>
  ilock(ip);
80105315:	83 ec 0c             	sub    $0xc,%esp
80105318:	50                   	push   %eax
80105319:	e8 42 c5 ff ff       	call   80101860 <ilock>
  if(ip->type == T_DIR){
8010531e:	83 c4 10             	add    $0x10,%esp
80105321:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105326:	0f 84 c6 00 00 00    	je     801053f2 <sys_link+0x132>
  iupdate(ip);
8010532c:	83 ec 0c             	sub    $0xc,%esp
8010532f:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105332:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if((dp = nameiparent(new, name)) == 0)
80105335:	8d 7d da             	lea    -0x26(%ebp),%edi
  ip->nlink++;
80105338:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
8010533d:	53                   	push   %ebx
8010533e:	e8 5d c4 ff ff       	call   801017a0 <iupdate>
  iunlock(ip);
80105343:	89 1c 24             	mov    %ebx,(%esp)
80105346:	e8 f5 c5 ff ff       	call   80101940 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
8010534b:	58                   	pop    %eax
8010534c:	5a                   	pop    %edx
8010534d:	57                   	push   %edi
8010534e:	ff 75 d0             	push   -0x30(%ebp)
80105351:	e8 ba ce ff ff       	call   80102210 <nameiparent>
80105356:	83 c4 10             	add    $0x10,%esp
80105359:	89 c6                	mov    %eax,%esi
8010535b:	85 c0                	test   %eax,%eax
8010535d:	74 5d                	je     801053bc <sys_link+0xfc>
  ilock(dp);
8010535f:	83 ec 0c             	sub    $0xc,%esp
80105362:	50                   	push   %eax
80105363:	e8 f8 c4 ff ff       	call   80101860 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105368:	8b 03                	mov    (%ebx),%eax
8010536a:	83 c4 10             	add    $0x10,%esp
8010536d:	39 06                	cmp    %eax,(%esi)
8010536f:	75 3f                	jne    801053b0 <sys_link+0xf0>
80105371:	83 ec 04             	sub    $0x4,%esp
80105374:	ff 73 04             	push   0x4(%ebx)
80105377:	57                   	push   %edi
80105378:	56                   	push   %esi
80105379:	e8 b2 cd ff ff       	call   80102130 <dirlink>
8010537e:	83 c4 10             	add    $0x10,%esp
80105381:	85 c0                	test   %eax,%eax
80105383:	78 2b                	js     801053b0 <sys_link+0xf0>
  iunlockput(dp);
80105385:	83 ec 0c             	sub    $0xc,%esp
80105388:	56                   	push   %esi
80105389:	e8 82 c7 ff ff       	call   80101b10 <iunlockput>
  iput(ip);
8010538e:	89 1c 24             	mov    %ebx,(%esp)
80105391:	e8 fa c5 ff ff       	call   80101990 <iput>
  end_op();
80105396:	e8 95 dc ff ff       	call   80103030 <end_op>
  return 0;
8010539b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010539e:	8b 75 f8             	mov    -0x8(%ebp),%esi
801053a1:	83 c4 10             	add    $0x10,%esp
801053a4:	8b 7d fc             	mov    -0x4(%ebp),%edi
801053a7:	31 c0                	xor    %eax,%eax
}
801053a9:	c9                   	leave
801053aa:	c3                   	ret
801053ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    iunlockput(dp);
801053b0:	83 ec 0c             	sub    $0xc,%esp
801053b3:	56                   	push   %esi
801053b4:	e8 57 c7 ff ff       	call   80101b10 <iunlockput>
    goto bad;
801053b9:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801053bc:	83 ec 0c             	sub    $0xc,%esp
801053bf:	53                   	push   %ebx
801053c0:	e8 9b c4 ff ff       	call   80101860 <ilock>
  ip->nlink--;
801053c5:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801053ca:	89 1c 24             	mov    %ebx,(%esp)
801053cd:	e8 ce c3 ff ff       	call   801017a0 <iupdate>
  iunlockput(ip);
801053d2:	89 1c 24             	mov    %ebx,(%esp)
801053d5:	e8 36 c7 ff ff       	call   80101b10 <iunlockput>
  end_op();
801053da:	e8 51 dc ff ff       	call   80103030 <end_op>
  return -1;
801053df:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801053e2:	8b 75 f8             	mov    -0x8(%ebp),%esi
801053e5:	83 c4 10             	add    $0x10,%esp
801053e8:	8b 7d fc             	mov    -0x4(%ebp),%edi
}
801053eb:	c9                   	leave
    return -1;
801053ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053f1:	c3                   	ret
    iunlockput(ip);
801053f2:	83 ec 0c             	sub    $0xc,%esp
801053f5:	53                   	push   %ebx
801053f6:	e8 15 c7 ff ff       	call   80101b10 <iunlockput>
    end_op();
801053fb:	e8 30 dc ff ff       	call   80103030 <end_op>
    return -1;
80105400:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105403:	83 c4 10             	add    $0x10,%esp
80105406:	eb e3                	jmp    801053eb <sys_link+0x12b>
    end_op();
80105408:	e8 23 dc ff ff       	call   80103030 <end_op>
    return -1;
8010540d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105410:	eb d9                	jmp    801053eb <sys_link+0x12b>
80105412:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105418:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010541f:	00 

80105420 <sys_unlink>:
{
80105420:	55                   	push   %ebp
80105421:	89 e5                	mov    %esp,%ebp
80105423:	83 ec 60             	sub    $0x60,%esp
  if(argstr(0, &path) < 0)
80105426:	8d 45 c0             	lea    -0x40(%ebp),%eax
80105429:	50                   	push   %eax
8010542a:	6a 00                	push   $0x0
8010542c:	e8 7f f9 ff ff       	call   80104db0 <argstr>
80105431:	83 c4 10             	add    $0x10,%esp
80105434:	85 c0                	test   %eax,%eax
80105436:	0f 88 6d 01 00 00    	js     801055a9 <sys_unlink+0x189>
8010543c:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  if((dp = nameiparent(path, name)) == 0){
8010543f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105442:	e8 79 db ff ff       	call   80102fc0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105447:	83 ec 08             	sub    $0x8,%esp
8010544a:	53                   	push   %ebx
8010544b:	ff 75 c0             	push   -0x40(%ebp)
8010544e:	e8 bd cd ff ff       	call   80102210 <nameiparent>
80105453:	83 c4 10             	add    $0x10,%esp
80105456:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105459:	85 c0                	test   %eax,%eax
8010545b:	0f 84 77 01 00 00    	je     801055d8 <sys_unlink+0x1b8>
80105461:	89 7d fc             	mov    %edi,-0x4(%ebp)
  ilock(dp);
80105464:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105467:	83 ec 0c             	sub    $0xc,%esp
8010546a:	57                   	push   %edi
8010546b:	e8 f0 c3 ff ff       	call   80101860 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105470:	58                   	pop    %eax
80105471:	5a                   	pop    %edx
80105472:	68 09 7b 10 80       	push   $0x80107b09
80105477:	53                   	push   %ebx
80105478:	e8 63 c9 ff ff       	call   80101de0 <namecmp>
8010547d:	83 c4 10             	add    $0x10,%esp
80105480:	85 c0                	test   %eax,%eax
80105482:	0f 84 08 01 00 00    	je     80105590 <sys_unlink+0x170>
80105488:	83 ec 08             	sub    $0x8,%esp
8010548b:	68 08 7b 10 80       	push   $0x80107b08
80105490:	53                   	push   %ebx
80105491:	e8 4a c9 ff ff       	call   80101de0 <namecmp>
80105496:	83 c4 10             	add    $0x10,%esp
80105499:	85 c0                	test   %eax,%eax
8010549b:	0f 84 ef 00 00 00    	je     80105590 <sys_unlink+0x170>
  if((ip = dirlookup(dp, name, &off)) == 0)
801054a1:	83 ec 04             	sub    $0x4,%esp
801054a4:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801054a7:	50                   	push   %eax
801054a8:	53                   	push   %ebx
801054a9:	57                   	push   %edi
801054aa:	e8 51 c9 ff ff       	call   80101e00 <dirlookup>
801054af:	83 c4 10             	add    $0x10,%esp
801054b2:	89 c3                	mov    %eax,%ebx
801054b4:	85 c0                	test   %eax,%eax
801054b6:	0f 84 d4 00 00 00    	je     80105590 <sys_unlink+0x170>
  ilock(ip);
801054bc:	83 ec 0c             	sub    $0xc,%esp
801054bf:	50                   	push   %eax
801054c0:	e8 9b c3 ff ff       	call   80101860 <ilock>
  if(ip->nlink < 1)
801054c5:	83 c4 10             	add    $0x10,%esp
801054c8:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801054cd:	0f 8e 2c 01 00 00    	jle    801055ff <sys_unlink+0x1df>
  if(ip->type == T_DIR && !isdirempty(ip)){
801054d3:	8d 7d d8             	lea    -0x28(%ebp),%edi
801054d6:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801054db:	74 6b                	je     80105548 <sys_unlink+0x128>
  memset(&de, 0, sizeof(de));
801054dd:	83 ec 04             	sub    $0x4,%esp
801054e0:	6a 10                	push   $0x10
801054e2:	6a 00                	push   $0x0
801054e4:	57                   	push   %edi
801054e5:	e8 16 f5 ff ff       	call   80104a00 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801054ea:	6a 10                	push   $0x10
801054ec:	ff 75 c4             	push   -0x3c(%ebp)
801054ef:	57                   	push   %edi
801054f0:	ff 75 b4             	push   -0x4c(%ebp)
801054f3:	e8 b8 c7 ff ff       	call   80101cb0 <writei>
801054f8:	83 c4 20             	add    $0x20,%esp
801054fb:	83 f8 10             	cmp    $0x10,%eax
801054fe:	0f 85 eb 00 00 00    	jne    801055ef <sys_unlink+0x1cf>
  if(ip->type == T_DIR){
80105504:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105509:	0f 84 a1 00 00 00    	je     801055b0 <sys_unlink+0x190>
  iunlockput(dp);
8010550f:	83 ec 0c             	sub    $0xc,%esp
80105512:	ff 75 b4             	push   -0x4c(%ebp)
80105515:	e8 f6 c5 ff ff       	call   80101b10 <iunlockput>
  ip->nlink--;
8010551a:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010551f:	89 1c 24             	mov    %ebx,(%esp)
80105522:	e8 79 c2 ff ff       	call   801017a0 <iupdate>
  iunlockput(ip);
80105527:	89 1c 24             	mov    %ebx,(%esp)
8010552a:	e8 e1 c5 ff ff       	call   80101b10 <iunlockput>
  end_op();
8010552f:	e8 fc da ff ff       	call   80103030 <end_op>
  return 0;
80105534:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105537:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010553a:	83 c4 10             	add    $0x10,%esp
}
8010553d:	c9                   	leave
  return 0;
8010553e:	31 c0                	xor    %eax,%eax
}
80105540:	c3                   	ret
80105541:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105548:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
8010554c:	76 8f                	jbe    801054dd <sys_unlink+0xbd>
8010554e:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105551:	be 20 00 00 00       	mov    $0x20,%esi
80105556:	eb 10                	jmp    80105568 <sys_unlink+0x148>
80105558:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010555f:	00 
80105560:	83 c6 10             	add    $0x10,%esi
80105563:	3b 73 58             	cmp    0x58(%ebx),%esi
80105566:	73 68                	jae    801055d0 <sys_unlink+0x1b0>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105568:	6a 10                	push   $0x10
8010556a:	56                   	push   %esi
8010556b:	57                   	push   %edi
8010556c:	53                   	push   %ebx
8010556d:	e8 1e c6 ff ff       	call   80101b90 <readi>
80105572:	83 c4 10             	add    $0x10,%esp
80105575:	83 f8 10             	cmp    $0x10,%eax
80105578:	75 68                	jne    801055e2 <sys_unlink+0x1c2>
    if(de.inum != 0)
8010557a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010557f:	74 df                	je     80105560 <sys_unlink+0x140>
    iunlockput(ip);
80105581:	83 ec 0c             	sub    $0xc,%esp
80105584:	53                   	push   %ebx
80105585:	e8 86 c5 ff ff       	call   80101b10 <iunlockput>
    goto bad;
8010558a:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010558d:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105590:	83 ec 0c             	sub    $0xc,%esp
80105593:	ff 75 b4             	push   -0x4c(%ebp)
80105596:	e8 75 c5 ff ff       	call   80101b10 <iunlockput>
  end_op();
8010559b:	e8 90 da ff ff       	call   80103030 <end_op>
  return -1;
801055a0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801055a3:	8b 7d fc             	mov    -0x4(%ebp),%edi
801055a6:	83 c4 10             	add    $0x10,%esp
}
801055a9:	c9                   	leave
    return -1;
801055aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055af:	c3                   	ret
    dp->nlink--;
801055b0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
801055b3:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
801055b6:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
801055bb:	50                   	push   %eax
801055bc:	e8 df c1 ff ff       	call   801017a0 <iupdate>
801055c1:	83 c4 10             	add    $0x10,%esp
801055c4:	e9 46 ff ff ff       	jmp    8010550f <sys_unlink+0xef>
801055c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055d0:	8b 75 f8             	mov    -0x8(%ebp),%esi
801055d3:	e9 05 ff ff ff       	jmp    801054dd <sys_unlink+0xbd>
    end_op();
801055d8:	e8 53 da ff ff       	call   80103030 <end_op>
801055dd:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    return -1;
801055e0:	eb c7                	jmp    801055a9 <sys_unlink+0x189>
      panic("isdirempty: readi");
801055e2:	83 ec 0c             	sub    $0xc,%esp
801055e5:	68 2d 7b 10 80       	push   $0x80107b2d
801055ea:	e8 b1 ad ff ff       	call   801003a0 <panic>
    panic("unlink: writei");
801055ef:	83 ec 0c             	sub    $0xc,%esp
801055f2:	89 75 f8             	mov    %esi,-0x8(%ebp)
801055f5:	68 3f 7b 10 80       	push   $0x80107b3f
801055fa:	e8 a1 ad ff ff       	call   801003a0 <panic>
    panic("unlink: nlink < 1");
801055ff:	83 ec 0c             	sub    $0xc,%esp
80105602:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105605:	68 1b 7b 10 80       	push   $0x80107b1b
8010560a:	e8 91 ad ff ff       	call   801003a0 <panic>
8010560f:	90                   	nop

80105610 <sys_open>:

int
sys_open(void)
{
80105610:	55                   	push   %ebp
80105611:	89 e5                	mov    %esp,%ebp
80105613:	83 ec 30             	sub    $0x30,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105616:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105619:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010561c:	50                   	push   %eax
8010561d:	6a 00                	push   $0x0
8010561f:	e8 8c f7 ff ff       	call   80104db0 <argstr>
80105624:	83 c4 10             	add    $0x10,%esp
80105627:	85 c0                	test   %eax,%eax
80105629:	0f 88 a4 00 00 00    	js     801056d3 <sys_open+0xc3>
8010562f:	83 ec 08             	sub    $0x8,%esp
80105632:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105635:	50                   	push   %eax
80105636:	6a 01                	push   $0x1
80105638:	e8 b3 f6 ff ff       	call   80104cf0 <argint>
8010563d:	83 c4 10             	add    $0x10,%esp
80105640:	85 c0                	test   %eax,%eax
80105642:	0f 88 8b 00 00 00    	js     801056d3 <sys_open+0xc3>
80105648:	89 7d fc             	mov    %edi,-0x4(%ebp)
    return -1;

  begin_op();
8010564b:	e8 70 d9 ff ff       	call   80102fc0 <begin_op>

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105650:	8b 45 e0             	mov    -0x20(%ebp),%eax
  if(omode & O_CREATE){
80105653:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105657:	0f 85 83 00 00 00    	jne    801056e0 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010565d:	83 ec 0c             	sub    $0xc,%esp
80105660:	50                   	push   %eax
80105661:	e8 8a cb ff ff       	call   801021f0 <namei>
80105666:	83 c4 10             	add    $0x10,%esp
80105669:	89 c7                	mov    %eax,%edi
8010566b:	85 c0                	test   %eax,%eax
8010566d:	0f 84 87 00 00 00    	je     801056fa <sys_open+0xea>
      end_op();
      return -1;
    }
    ilock(ip);
80105673:	83 ec 0c             	sub    $0xc,%esp
80105676:	50                   	push   %eax
80105677:	e8 e4 c1 ff ff       	call   80101860 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
8010567c:	83 c4 10             	add    $0x10,%esp
8010567f:	66 83 7f 50 01       	cmpw   $0x1,0x50(%edi)
80105684:	0f 84 c6 00 00 00    	je     80105750 <sys_open+0x140>
8010568a:	89 75 f8             	mov    %esi,-0x8(%ebp)
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010568d:	e8 4e b8 ff ff       	call   80100ee0 <filealloc>
80105692:	89 c6                	mov    %eax,%esi
80105694:	85 c0                	test   %eax,%eax
80105696:	74 24                	je     801056bc <sys_open+0xac>
  struct proc *curproc = myproc();
80105698:	e8 83 e5 ff ff       	call   80103c20 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010569d:	31 db                	xor    %ebx,%ebx
8010569f:	90                   	nop
    if(curproc->ofile[fd] == 0){
801056a0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801056a4:	85 d2                	test   %edx,%edx
801056a6:	74 60                	je     80105708 <sys_open+0xf8>
  for(fd = 0; fd < NOFILE; fd++){
801056a8:	83 c3 01             	add    $0x1,%ebx
801056ab:	83 fb 10             	cmp    $0x10,%ebx
801056ae:	75 f0                	jne    801056a0 <sys_open+0x90>
    if(f)
      fileclose(f);
801056b0:	83 ec 0c             	sub    $0xc,%esp
801056b3:	56                   	push   %esi
801056b4:	e8 e7 b8 ff ff       	call   80100fa0 <fileclose>
801056b9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801056bc:	83 ec 0c             	sub    $0xc,%esp
801056bf:	57                   	push   %edi
801056c0:	e8 4b c4 ff ff       	call   80101b10 <iunlockput>
    end_op();
801056c5:	e8 66 d9 ff ff       	call   80103030 <end_op>
    return -1;
801056ca:	8b 75 f8             	mov    -0x8(%ebp),%esi
801056cd:	8b 7d fc             	mov    -0x4(%ebp),%edi
801056d0:	83 c4 10             	add    $0x10,%esp
    return -1;
801056d3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801056d8:	eb 6d                	jmp    80105747 <sys_open+0x137>
801056da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ip = create(path, T_FILE, 0, 0);
801056e0:	83 ec 0c             	sub    $0xc,%esp
801056e3:	31 c9                	xor    %ecx,%ecx
801056e5:	ba 02 00 00 00       	mov    $0x2,%edx
801056ea:	6a 00                	push   $0x0
801056ec:	e8 af f7 ff ff       	call   80104ea0 <create>
    if(ip == 0){
801056f1:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
801056f4:	89 c7                	mov    %eax,%edi
    if(ip == 0){
801056f6:	85 c0                	test   %eax,%eax
801056f8:	75 90                	jne    8010568a <sys_open+0x7a>
      end_op();
801056fa:	e8 31 d9 ff ff       	call   80103030 <end_op>
801056ff:	8b 7d fc             	mov    -0x4(%ebp),%edi
      return -1;
80105702:	eb cf                	jmp    801056d3 <sys_open+0xc3>
80105704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105708:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
8010570b:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010570f:	57                   	push   %edi
80105710:	e8 2b c2 ff ff       	call   80101940 <iunlock>
  end_op();
80105715:	e8 16 d9 ff ff       	call   80103030 <end_op>

  f->type = FD_INODE;
8010571a:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105720:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105723:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105726:	89 7e 10             	mov    %edi,0x10(%esi)
  f->readable = !(omode & O_WRONLY);
80105729:	89 d0                	mov    %edx,%eax
  f->off = 0;
8010572b:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
80105732:	f7 d0                	not    %eax
80105734:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105737:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
8010573a:	88 46 08             	mov    %al,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010573d:	0f 95 46 09          	setne  0x9(%esi)
  return fd;
80105741:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105744:	8b 7d fc             	mov    -0x4(%ebp),%edi
}
80105747:	89 d8                	mov    %ebx,%eax
80105749:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010574c:	c9                   	leave
8010574d:	c3                   	ret
8010574e:	66 90                	xchg   %ax,%ax
    if(ip->type == T_DIR && omode != O_RDONLY){
80105750:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105753:	85 c9                	test   %ecx,%ecx
80105755:	0f 84 2f ff ff ff    	je     8010568a <sys_open+0x7a>
      iunlockput(ip);
8010575b:	83 ec 0c             	sub    $0xc,%esp
8010575e:	57                   	push   %edi
8010575f:	e8 ac c3 ff ff       	call   80101b10 <iunlockput>
      end_op();
80105764:	e8 c7 d8 ff ff       	call   80103030 <end_op>
      return -1;
80105769:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010576c:	83 c4 10             	add    $0x10,%esp
8010576f:	e9 5f ff ff ff       	jmp    801056d3 <sys_open+0xc3>
80105774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105778:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010577f:	00 

80105780 <sys_mkdir>:

int
sys_mkdir(void)
{
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
80105783:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105786:	e8 35 d8 ff ff       	call   80102fc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010578b:	83 ec 08             	sub    $0x8,%esp
8010578e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105791:	50                   	push   %eax
80105792:	6a 00                	push   $0x0
80105794:	e8 17 f6 ff ff       	call   80104db0 <argstr>
80105799:	83 c4 10             	add    $0x10,%esp
8010579c:	85 c0                	test   %eax,%eax
8010579e:	78 30                	js     801057d0 <sys_mkdir+0x50>
801057a0:	83 ec 0c             	sub    $0xc,%esp
801057a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057a6:	31 c9                	xor    %ecx,%ecx
801057a8:	ba 01 00 00 00       	mov    $0x1,%edx
801057ad:	6a 00                	push   $0x0
801057af:	e8 ec f6 ff ff       	call   80104ea0 <create>
801057b4:	83 c4 10             	add    $0x10,%esp
801057b7:	85 c0                	test   %eax,%eax
801057b9:	74 15                	je     801057d0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801057bb:	83 ec 0c             	sub    $0xc,%esp
801057be:	50                   	push   %eax
801057bf:	e8 4c c3 ff ff       	call   80101b10 <iunlockput>
  end_op();
801057c4:	e8 67 d8 ff ff       	call   80103030 <end_op>
  return 0;
801057c9:	83 c4 10             	add    $0x10,%esp
801057cc:	31 c0                	xor    %eax,%eax
}
801057ce:	c9                   	leave
801057cf:	c3                   	ret
    end_op();
801057d0:	e8 5b d8 ff ff       	call   80103030 <end_op>
    return -1;
801057d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801057da:	c9                   	leave
801057db:	c3                   	ret
801057dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801057e0 <sys_mknod>:

int
sys_mknod(void)
{
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
801057e3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801057e6:	e8 d5 d7 ff ff       	call   80102fc0 <begin_op>
  if((argstr(0, &path)) < 0 ||
801057eb:	83 ec 08             	sub    $0x8,%esp
801057ee:	8d 45 ec             	lea    -0x14(%ebp),%eax
801057f1:	50                   	push   %eax
801057f2:	6a 00                	push   $0x0
801057f4:	e8 b7 f5 ff ff       	call   80104db0 <argstr>
801057f9:	83 c4 10             	add    $0x10,%esp
801057fc:	85 c0                	test   %eax,%eax
801057fe:	78 60                	js     80105860 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105800:	83 ec 08             	sub    $0x8,%esp
80105803:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105806:	50                   	push   %eax
80105807:	6a 01                	push   $0x1
80105809:	e8 e2 f4 ff ff       	call   80104cf0 <argint>
  if((argstr(0, &path)) < 0 ||
8010580e:	83 c4 10             	add    $0x10,%esp
80105811:	85 c0                	test   %eax,%eax
80105813:	78 4b                	js     80105860 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105815:	83 ec 08             	sub    $0x8,%esp
80105818:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010581b:	50                   	push   %eax
8010581c:	6a 02                	push   $0x2
8010581e:	e8 cd f4 ff ff       	call   80104cf0 <argint>
     argint(1, &major) < 0 ||
80105823:	83 c4 10             	add    $0x10,%esp
80105826:	85 c0                	test   %eax,%eax
80105828:	78 36                	js     80105860 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010582a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010582e:	83 ec 0c             	sub    $0xc,%esp
80105831:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105835:	ba 03 00 00 00       	mov    $0x3,%edx
8010583a:	50                   	push   %eax
8010583b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010583e:	e8 5d f6 ff ff       	call   80104ea0 <create>
     argint(2, &minor) < 0 ||
80105843:	83 c4 10             	add    $0x10,%esp
80105846:	85 c0                	test   %eax,%eax
80105848:	74 16                	je     80105860 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010584a:	83 ec 0c             	sub    $0xc,%esp
8010584d:	50                   	push   %eax
8010584e:	e8 bd c2 ff ff       	call   80101b10 <iunlockput>
  end_op();
80105853:	e8 d8 d7 ff ff       	call   80103030 <end_op>
  return 0;
80105858:	83 c4 10             	add    $0x10,%esp
8010585b:	31 c0                	xor    %eax,%eax
}
8010585d:	c9                   	leave
8010585e:	c3                   	ret
8010585f:	90                   	nop
    end_op();
80105860:	e8 cb d7 ff ff       	call   80103030 <end_op>
    return -1;
80105865:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010586a:	c9                   	leave
8010586b:	c3                   	ret
8010586c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105870 <sys_chdir>:

int
sys_chdir(void)
{
80105870:	55                   	push   %ebp
80105871:	89 e5                	mov    %esp,%ebp
80105873:	83 ec 18             	sub    $0x18,%esp
80105876:	89 75 fc             	mov    %esi,-0x4(%ebp)
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105879:	e8 a2 e3 ff ff       	call   80103c20 <myproc>
8010587e:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105880:	e8 3b d7 ff ff       	call   80102fc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105885:	83 ec 08             	sub    $0x8,%esp
80105888:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010588b:	50                   	push   %eax
8010588c:	6a 00                	push   $0x0
8010588e:	e8 1d f5 ff ff       	call   80104db0 <argstr>
80105893:	83 c4 10             	add    $0x10,%esp
80105896:	85 c0                	test   %eax,%eax
80105898:	78 74                	js     8010590e <sys_chdir+0x9e>
8010589a:	83 ec 0c             	sub    $0xc,%esp
8010589d:	ff 75 f4             	push   -0xc(%ebp)
801058a0:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801058a3:	e8 48 c9 ff ff       	call   801021f0 <namei>
801058a8:	83 c4 10             	add    $0x10,%esp
801058ab:	89 c3                	mov    %eax,%ebx
801058ad:	85 c0                	test   %eax,%eax
801058af:	74 5a                	je     8010590b <sys_chdir+0x9b>
    end_op();
    return -1;
  }
  ilock(ip);
801058b1:	83 ec 0c             	sub    $0xc,%esp
801058b4:	50                   	push   %eax
801058b5:	e8 a6 bf ff ff       	call   80101860 <ilock>
  if(ip->type != T_DIR){
801058ba:	83 c4 10             	add    $0x10,%esp
801058bd:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801058c2:	75 2c                	jne    801058f0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801058c4:	83 ec 0c             	sub    $0xc,%esp
801058c7:	53                   	push   %ebx
801058c8:	e8 73 c0 ff ff       	call   80101940 <iunlock>
  iput(curproc->cwd);
801058cd:	58                   	pop    %eax
801058ce:	ff 76 68             	push   0x68(%esi)
801058d1:	e8 ba c0 ff ff       	call   80101990 <iput>
  end_op();
801058d6:	e8 55 d7 ff ff       	call   80103030 <end_op>
  curproc->cwd = ip;
801058db:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
801058de:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801058e1:	83 c4 10             	add    $0x10,%esp
801058e4:	31 c0                	xor    %eax,%eax
}
801058e6:	8b 75 fc             	mov    -0x4(%ebp),%esi
801058e9:	c9                   	leave
801058ea:	c3                   	ret
801058eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
801058f0:	83 ec 0c             	sub    $0xc,%esp
801058f3:	53                   	push   %ebx
801058f4:	e8 17 c2 ff ff       	call   80101b10 <iunlockput>
    end_op();
801058f9:	e8 32 d7 ff ff       	call   80103030 <end_op>
    return -1;
801058fe:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105901:	83 c4 10             	add    $0x10,%esp
    return -1;
80105904:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105909:	eb db                	jmp    801058e6 <sys_chdir+0x76>
8010590b:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    end_op();
8010590e:	e8 1d d7 ff ff       	call   80103030 <end_op>
    return -1;
80105913:	eb ef                	jmp    80105904 <sys_chdir+0x94>
80105915:	8d 76 00             	lea    0x0(%esi),%esi
80105918:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010591f:	00 

80105920 <sys_exec>:

int
sys_exec(void)
{
80105920:	55                   	push   %ebp
80105921:	89 e5                	mov    %esp,%ebp
80105923:	81 ec b0 00 00 00    	sub    $0xb0,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105929:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
8010592f:	50                   	push   %eax
80105930:	6a 00                	push   $0x0
80105932:	e8 79 f4 ff ff       	call   80104db0 <argstr>
80105937:	83 c4 10             	add    $0x10,%esp
8010593a:	85 c0                	test   %eax,%eax
8010593c:	0f 88 8e 00 00 00    	js     801059d0 <sys_exec+0xb0>
80105942:	83 ec 08             	sub    $0x8,%esp
80105945:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010594b:	50                   	push   %eax
8010594c:	6a 01                	push   $0x1
8010594e:	e8 9d f3 ff ff       	call   80104cf0 <argint>
80105953:	83 c4 10             	add    $0x10,%esp
80105956:	85 c0                	test   %eax,%eax
80105958:	78 76                	js     801059d0 <sys_exec+0xb0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010595a:	83 ec 04             	sub    $0x4,%esp
8010595d:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105960:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105966:	68 80 00 00 00       	push   $0x80
8010596b:	6a 00                	push   $0x0
8010596d:	56                   	push   %esi
8010596e:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  for(i=0;; i++){
80105971:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105973:	e8 88 f0 ff ff       	call   80104a00 <memset>
80105978:	83 c4 10             	add    $0x10,%esp
8010597b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105980:	83 ec 08             	sub    $0x8,%esp
80105983:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105989:	50                   	push   %eax
8010598a:	8d 04 9d 00 00 00 00 	lea    0x0(,%ebx,4),%eax
80105991:	03 85 60 ff ff ff    	add    -0xa0(%ebp),%eax
80105997:	50                   	push   %eax
80105998:	e8 b3 f2 ff ff       	call   80104c50 <fetchint>
8010599d:	83 c4 10             	add    $0x10,%esp
801059a0:	85 c0                	test   %eax,%eax
801059a2:	78 26                	js     801059ca <sys_exec+0xaa>
      return -1;
    if(uarg == 0){
801059a4:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801059aa:	85 c0                	test   %eax,%eax
801059ac:	74 32                	je     801059e0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801059ae:	83 ec 08             	sub    $0x8,%esp
801059b1:	8d 14 9e             	lea    (%esi,%ebx,4),%edx
801059b4:	52                   	push   %edx
801059b5:	50                   	push   %eax
801059b6:	e8 d5 f2 ff ff       	call   80104c90 <fetchstr>
801059bb:	83 c4 10             	add    $0x10,%esp
801059be:	85 c0                	test   %eax,%eax
801059c0:	78 08                	js     801059ca <sys_exec+0xaa>
  for(i=0;; i++){
801059c2:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801059c5:	83 fb 20             	cmp    $0x20,%ebx
801059c8:	75 b6                	jne    80105980 <sys_exec+0x60>
801059ca:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801059cd:	8b 75 f8             	mov    -0x8(%ebp),%esi
      return -1;
  }
  return exec(path, argv);
}
801059d0:	c9                   	leave
    return -1;
801059d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059d6:	c3                   	ret
801059d7:	90                   	nop
801059d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801059df:	00 
      argv[i] = 0;
801059e0:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801059e7:	00 00 00 00 
  return exec(path, argv);
801059eb:	83 ec 08             	sub    $0x8,%esp
801059ee:	56                   	push   %esi
801059ef:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
801059f5:	e8 56 b1 ff ff       	call   80100b50 <exec>
801059fa:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801059fd:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105a00:	83 c4 10             	add    $0x10,%esp
}
80105a03:	c9                   	leave
80105a04:	c3                   	ret
80105a05:	8d 76 00             	lea    0x0(%esi),%esi
80105a08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a0f:	00 

80105a10 <sys_pipe>:

int
sys_pipe(void)
{
80105a10:	55                   	push   %ebp
80105a11:	89 e5                	mov    %esp,%ebp
80105a13:	83 ec 2c             	sub    $0x2c,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105a16:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105a19:	6a 08                	push   $0x8
80105a1b:	50                   	push   %eax
80105a1c:	6a 00                	push   $0x0
80105a1e:	e8 1d f3 ff ff       	call   80104d40 <argptr>
80105a23:	83 c4 10             	add    $0x10,%esp
80105a26:	85 c0                	test   %eax,%eax
80105a28:	0f 88 af 00 00 00    	js     80105add <sys_pipe+0xcd>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105a2e:	83 ec 08             	sub    $0x8,%esp
80105a31:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105a34:	50                   	push   %eax
80105a35:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105a38:	50                   	push   %eax
80105a39:	e8 42 dc ff ff       	call   80103680 <pipealloc>
80105a3e:	83 c4 10             	add    $0x10,%esp
80105a41:	85 c0                	test   %eax,%eax
80105a43:	0f 88 94 00 00 00    	js     80105add <sys_pipe+0xcd>
80105a49:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  for(fd = 0; fd < NOFILE; fd++){
80105a4c:	31 db                	xor    %ebx,%ebx
80105a4e:	89 7d fc             	mov    %edi,-0x4(%ebp)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105a51:	8b 7d e0             	mov    -0x20(%ebp),%edi
  struct proc *curproc = myproc();
80105a54:	e8 c7 e1 ff ff       	call   80103c20 <myproc>
    if(curproc->ofile[fd] == 0){
80105a59:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105a5d:	85 d2                	test   %edx,%edx
80105a5f:	74 1f                	je     80105a80 <sys_pipe+0x70>
80105a61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a6f:	00 
  for(fd = 0; fd < NOFILE; fd++){
80105a70:	83 c3 01             	add    $0x1,%ebx
80105a73:	83 fb 10             	cmp    $0x10,%ebx
80105a76:	74 48                	je     80105ac0 <sys_pipe+0xb0>
    if(curproc->ofile[fd] == 0){
80105a78:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105a7c:	85 d2                	test   %edx,%edx
80105a7e:	75 f0                	jne    80105a70 <sys_pipe+0x60>
80105a80:	89 75 f8             	mov    %esi,-0x8(%ebp)
      curproc->ofile[fd] = f;
80105a83:	8d 73 08             	lea    0x8(%ebx),%esi
80105a86:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105a8a:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105a8d:	e8 8e e1 ff ff       	call   80103c20 <myproc>
80105a92:	89 c2                	mov    %eax,%edx
  for(fd = 0; fd < NOFILE; fd++){
80105a94:	31 c0                	xor    %eax,%eax
80105a96:	66 90                	xchg   %ax,%ax
80105a98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a9f:	00 
    if(curproc->ofile[fd] == 0){
80105aa0:	8b 4c 82 28          	mov    0x28(%edx,%eax,4),%ecx
80105aa4:	85 c9                	test   %ecx,%ecx
80105aa6:	74 40                	je     80105ae8 <sys_pipe+0xd8>
  for(fd = 0; fd < NOFILE; fd++){
80105aa8:	83 c0 01             	add    $0x1,%eax
80105aab:	83 f8 10             	cmp    $0x10,%eax
80105aae:	75 f0                	jne    80105aa0 <sys_pipe+0x90>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105ab0:	e8 6b e1 ff ff       	call   80103c20 <myproc>
80105ab5:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105abc:	00 
80105abd:	8b 75 f8             	mov    -0x8(%ebp),%esi
    fileclose(rf);
80105ac0:	83 ec 0c             	sub    $0xc,%esp
80105ac3:	ff 75 e0             	push   -0x20(%ebp)
80105ac6:	e8 d5 b4 ff ff       	call   80100fa0 <fileclose>
    fileclose(wf);
80105acb:	58                   	pop    %eax
80105acc:	ff 75 e4             	push   -0x1c(%ebp)
80105acf:	e8 cc b4 ff ff       	call   80100fa0 <fileclose>
    return -1;
80105ad4:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105ad7:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105ada:	83 c4 10             	add    $0x10,%esp
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80105add:	c9                   	leave
    return -1;
80105ade:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ae3:	c3                   	ret
80105ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80105ae8:	89 7c 82 28          	mov    %edi,0x28(%edx,%eax,4)
  fd[0] = fd0;
80105aec:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105aef:	89 1a                	mov    %ebx,(%edx)
  fd[1] = fd1;
80105af1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105af4:	89 42 04             	mov    %eax,0x4(%edx)
  return 0;
80105af7:	31 c0                	xor    %eax,%eax
80105af9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105afc:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105aff:	8b 7d fc             	mov    -0x4(%ebp),%edi
}
80105b02:	c9                   	leave
80105b03:	c3                   	ret
80105b04:	66 90                	xchg   %ax,%ax
80105b06:	66 90                	xchg   %ax,%ax
80105b08:	66 90                	xchg   %ax,%ax
80105b0a:	66 90                	xchg   %ax,%ax
80105b0c:	66 90                	xchg   %ax,%ax
80105b0e:	66 90                	xchg   %ax,%ax

80105b10 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105b10:	e9 ab e2 ff ff       	jmp    80103dc0 <fork>
80105b15:	8d 76 00             	lea    0x0(%esi),%esi
80105b18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105b1f:	00 

80105b20 <sys_exit>:
}

int
sys_exit(void)
{
80105b20:	55                   	push   %ebp
80105b21:	89 e5                	mov    %esp,%ebp
80105b23:	83 ec 08             	sub    $0x8,%esp
  exit();
80105b26:	e8 25 e5 ff ff       	call   80104050 <exit>
  return 0;  // not reached
}
80105b2b:	31 c0                	xor    %eax,%eax
80105b2d:	c9                   	leave
80105b2e:	c3                   	ret
80105b2f:	90                   	nop

80105b30 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105b30:	e9 6b e6 ff ff       	jmp    801041a0 <wait>
80105b35:	8d 76 00             	lea    0x0(%esi),%esi
80105b38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105b3f:	00 

80105b40 <sys_kill>:
}

int
sys_kill(void)
{
80105b40:	55                   	push   %ebp
80105b41:	89 e5                	mov    %esp,%ebp
80105b43:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105b46:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b49:	50                   	push   %eax
80105b4a:	6a 00                	push   $0x0
80105b4c:	e8 9f f1 ff ff       	call   80104cf0 <argint>
80105b51:	83 c4 10             	add    $0x10,%esp
80105b54:	85 c0                	test   %eax,%eax
80105b56:	78 18                	js     80105b70 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105b58:	83 ec 0c             	sub    $0xc,%esp
80105b5b:	ff 75 f4             	push   -0xc(%ebp)
80105b5e:	e8 ed e8 ff ff       	call   80104450 <kill>
80105b63:	83 c4 10             	add    $0x10,%esp
}
80105b66:	c9                   	leave
80105b67:	c3                   	ret
80105b68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105b6f:	00 
80105b70:	c9                   	leave
    return -1;
80105b71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b76:	c3                   	ret
80105b77:	90                   	nop
80105b78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105b7f:	00 

80105b80 <sys_getpid>:

int
sys_getpid(void)
{
80105b80:	55                   	push   %ebp
80105b81:	89 e5                	mov    %esp,%ebp
80105b83:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105b86:	e8 95 e0 ff ff       	call   80103c20 <myproc>
80105b8b:	8b 40 10             	mov    0x10(%eax),%eax
}
80105b8e:	c9                   	leave
80105b8f:	c3                   	ret

80105b90 <sys_sbrk>:

int
sys_sbrk(void)
{
80105b90:	55                   	push   %ebp
80105b91:	89 e5                	mov    %esp,%ebp
80105b93:	83 ec 20             	sub    $0x20,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105b96:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b99:	50                   	push   %eax
80105b9a:	6a 00                	push   $0x0
80105b9c:	e8 4f f1 ff ff       	call   80104cf0 <argint>
80105ba1:	83 c4 10             	add    $0x10,%esp
80105ba4:	85 c0                	test   %eax,%eax
80105ba6:	78 26                	js     80105bce <sys_sbrk+0x3e>
80105ba8:	89 5d fc             	mov    %ebx,-0x4(%ebp)
    return -1;
  addr = myproc()->sz;
80105bab:	e8 70 e0 ff ff       	call   80103c20 <myproc>
  if(growproc(n) < 0)
80105bb0:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105bb3:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105bb5:	ff 75 f4             	push   -0xc(%ebp)
80105bb8:	e8 83 e1 ff ff       	call   80103d40 <growproc>
80105bbd:	83 c4 10             	add    $0x10,%esp
80105bc0:	85 c0                	test   %eax,%eax
80105bc2:	78 07                	js     80105bcb <sys_sbrk+0x3b>
  addr = myproc()->sz;
80105bc4:	89 d8                	mov    %ebx,%eax
80105bc6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
  return addr;
}
80105bc9:	c9                   	leave
80105bca:	c3                   	ret
80105bcb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105bce:	c9                   	leave
    return -1;
80105bcf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105bd4:	c3                   	ret
80105bd5:	8d 76 00             	lea    0x0(%esi),%esi
80105bd8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105bdf:	00 

80105be0 <sys_sleep>:

int
sys_sleep(void)
{
80105be0:	55                   	push   %ebp
80105be1:	89 e5                	mov    %esp,%ebp
80105be3:	83 ec 20             	sub    $0x20,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105be6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105be9:	50                   	push   %eax
80105bea:	6a 00                	push   $0x0
80105bec:	e8 ff f0 ff ff       	call   80104cf0 <argint>
80105bf1:	83 c4 10             	add    $0x10,%esp
80105bf4:	85 c0                	test   %eax,%eax
80105bf6:	78 68                	js     80105c60 <sys_sleep+0x80>
    return -1;
  acquire(&tickslock);
80105bf8:	83 ec 0c             	sub    $0xc,%esp
80105bfb:	68 80 4c 11 80       	push   $0x80114c80
80105c00:	e8 db ec ff ff       	call   801048e0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105c05:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105c08:	83 c4 10             	add    $0x10,%esp
80105c0b:	85 d2                	test   %edx,%edx
80105c0d:	74 64                	je     80105c73 <sys_sleep+0x93>
80105c0f:	89 5d fc             	mov    %ebx,-0x4(%ebp)
  ticks0 = ticks;
80105c12:	8b 1d 60 4c 11 80    	mov    0x80114c60,%ebx
80105c18:	eb 27                	jmp    80105c41 <sys_sleep+0x61>
80105c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105c20:	83 ec 08             	sub    $0x8,%esp
80105c23:	68 80 4c 11 80       	push   $0x80114c80
80105c28:	68 60 4c 11 80       	push   $0x80114c60
80105c2d:	e8 fe e6 ff ff       	call   80104330 <sleep>
  while(ticks - ticks0 < n){
80105c32:	a1 60 4c 11 80       	mov    0x80114c60,%eax
80105c37:	83 c4 10             	add    $0x10,%esp
80105c3a:	29 d8                	sub    %ebx,%eax
80105c3c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105c3f:	73 2f                	jae    80105c70 <sys_sleep+0x90>
    if(myproc()->killed){
80105c41:	e8 da df ff ff       	call   80103c20 <myproc>
80105c46:	8b 40 24             	mov    0x24(%eax),%eax
80105c49:	85 c0                	test   %eax,%eax
80105c4b:	74 d3                	je     80105c20 <sys_sleep+0x40>
      release(&tickslock);
80105c4d:	83 ec 0c             	sub    $0xc,%esp
80105c50:	68 80 4c 11 80       	push   $0x80114c80
80105c55:	e8 26 ec ff ff       	call   80104880 <release>
      return -1;
80105c5a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c5d:	83 c4 10             	add    $0x10,%esp
  }
  release(&tickslock);
  return 0;
}
80105c60:	c9                   	leave
    return -1;
80105c61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c66:	c3                   	ret
80105c67:	90                   	nop
80105c68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105c6f:	00 
80105c70:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&tickslock);
80105c73:	83 ec 0c             	sub    $0xc,%esp
80105c76:	68 80 4c 11 80       	push   $0x80114c80
80105c7b:	e8 00 ec ff ff       	call   80104880 <release>
  return 0;
80105c80:	83 c4 10             	add    $0x10,%esp
80105c83:	31 c0                	xor    %eax,%eax
}
80105c85:	c9                   	leave
80105c86:	c3                   	ret
80105c87:	90                   	nop
80105c88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105c8f:	00 

80105c90 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105c90:	55                   	push   %ebp
80105c91:	89 e5                	mov    %esp,%ebp
80105c93:	53                   	push   %ebx
80105c94:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105c97:	68 80 4c 11 80       	push   $0x80114c80
80105c9c:	e8 3f ec ff ff       	call   801048e0 <acquire>
  xticks = ticks;
  release(&tickslock);
80105ca1:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
  xticks = ticks;
80105ca8:	8b 1d 60 4c 11 80    	mov    0x80114c60,%ebx
  release(&tickslock);
80105cae:	e8 cd eb ff ff       	call   80104880 <release>
  return xticks;
}
80105cb3:	89 d8                	mov    %ebx,%eax
80105cb5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105cb8:	c9                   	leave
80105cb9:	c3                   	ret
80105cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105cc0 <sys_freepages>:

// int freepages(void): number of free physical pages.
int
sys_freepages(void)
{
  return countfreepages();
80105cc0:	e9 db cb ff ff       	jmp    801028a0 <countfreepages>
80105cc5:	8d 76 00             	lea    0x0(%esi),%esi
80105cc8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105ccf:	00 

80105cd0 <sys_va2pa>:
}

// int va2pa(int va): physical address of va in the calling process, or -1.
int
sys_va2pa(void)
{
80105cd0:	55                   	push   %ebp
80105cd1:	89 e5                	mov    %esp,%ebp
80105cd3:	83 ec 20             	sub    $0x20,%esp
  int va;

  if(argint(0, &va) < 0)
80105cd6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105cd9:	50                   	push   %eax
80105cda:	6a 00                	push   $0x0
80105cdc:	e8 0f f0 ff ff       	call   80104cf0 <argint>
80105ce1:	83 c4 10             	add    $0x10,%esp
80105ce4:	85 c0                	test   %eax,%eax
80105ce6:	78 28                	js     80105d10 <sys_va2pa+0x40>
80105ce8:	89 5d fc             	mov    %ebx,-0x4(%ebp)
    return -1;
  return va2pa_walk(myproc()->pgdir, (uint)va);
80105ceb:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105cee:	e8 2d df ff ff       	call   80103c20 <myproc>
80105cf3:	83 ec 08             	sub    $0x8,%esp
80105cf6:	53                   	push   %ebx
80105cf7:	ff 70 04             	push   0x4(%eax)
80105cfa:	e8 e1 19 00 00       	call   801076e0 <va2pa_walk>
80105cff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105d02:	83 c4 10             	add    $0x10,%esp
}
80105d05:	c9                   	leave
80105d06:	c3                   	ret
80105d07:	90                   	nop
80105d08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d0f:	00 
80105d10:	c9                   	leave
    return -1;
80105d11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d16:	c3                   	ret

80105d17 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105d17:	1e                   	push   %ds
  pushl %es
80105d18:	06                   	push   %es
  pushl %fs
80105d19:	0f a0                	push   %fs
  pushl %gs
80105d1b:	0f a8                	push   %gs
  pushal
80105d1d:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105d1e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105d22:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105d24:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105d26:	54                   	push   %esp
  call trap
80105d27:	e8 f4 00 00 00       	call   80105e20 <trap>
  addl $4, %esp
80105d2c:	83 c4 04             	add    $0x4,%esp

80105d2f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105d2f:	61                   	popa
  popl %gs
80105d30:	0f a9                	pop    %gs
  popl %fs
80105d32:	0f a1                	pop    %fs
  popl %es
80105d34:	07                   	pop    %es
  popl %ds
80105d35:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105d36:	83 c4 08             	add    $0x8,%esp
  iret
80105d39:	cf                   	iret
80105d3a:	66 90                	xchg   %ax,%ax
80105d3c:	66 90                	xchg   %ax,%ax
80105d3e:	66 90                	xchg   %ax,%ax

80105d40 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105d40:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105d41:	31 c0                	xor    %eax,%eax
{
80105d43:	89 e5                	mov    %esp,%ebp
80105d45:	83 ec 08             	sub    $0x8,%esp
80105d48:	eb 36                	jmp    80105d80 <tvinit+0x40>
80105d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105d50:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d57:	00 
80105d58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d5f:	00 
80105d60:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d67:	00 
80105d68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d6f:	00 
80105d70:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d77:	00 
80105d78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d7f:	00 
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105d80:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80105d87:	c7 04 c5 c2 4c 11 80 	movl   $0x8e000008,-0x7feeb33e(,%eax,8)
80105d8e:	08 00 00 8e 
80105d92:	66 89 14 c5 c0 4c 11 	mov    %dx,-0x7feeb340(,%eax,8)
80105d99:	80 
80105d9a:	c1 ea 10             	shr    $0x10,%edx
80105d9d:	66 89 14 c5 c6 4c 11 	mov    %dx,-0x7feeb33a(,%eax,8)
80105da4:	80 
  for(i = 0; i < 256; i++)
80105da5:	83 c0 01             	add    $0x1,%eax
80105da8:	3d 00 01 00 00       	cmp    $0x100,%eax
80105dad:	75 d1                	jne    80105d80 <tvinit+0x40>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80105daf:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105db2:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80105db7:	c7 05 c2 4e 11 80 08 	movl   $0xef000008,0x80114ec2
80105dbe:	00 00 ef 
  initlock(&tickslock, "time");
80105dc1:	68 4e 7b 10 80       	push   $0x80107b4e
80105dc6:	68 80 4c 11 80       	push   $0x80114c80
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105dcb:	66 a3 c0 4e 11 80    	mov    %ax,0x80114ec0
80105dd1:	c1 e8 10             	shr    $0x10,%eax
80105dd4:	66 a3 c6 4e 11 80    	mov    %ax,0x80114ec6
  initlock(&tickslock, "time");
80105dda:	e8 e1 e8 ff ff       	call   801046c0 <initlock>
}
80105ddf:	83 c4 10             	add    $0x10,%esp
80105de2:	c9                   	leave
80105de3:	c3                   	ret
80105de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105de8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105def:	00 

80105df0 <idtinit>:

void
idtinit(void)
{
80105df0:	55                   	push   %ebp
  pd[0] = size-1;
80105df1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105df6:	89 e5                	mov    %esp,%ebp
80105df8:	83 ec 10             	sub    $0x10,%esp
80105dfb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105dff:	b8 c0 4c 11 80       	mov    $0x80114cc0,%eax
80105e04:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105e08:	c1 e8 10             	shr    $0x10,%eax
80105e0b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105e0f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105e12:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105e15:	c9                   	leave
80105e16:	c3                   	ret
80105e17:	90                   	nop
80105e18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e1f:	00 

80105e20 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105e20:	55                   	push   %ebp
80105e21:	89 e5                	mov    %esp,%ebp
80105e23:	83 ec 28             	sub    $0x28,%esp
80105e26:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80105e29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105e2c:	8b 43 30             	mov    0x30(%ebx),%eax
80105e2f:	83 f8 40             	cmp    $0x40,%eax
80105e32:	0f 84 78 01 00 00    	je     80105fb0 <trap+0x190>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105e38:	83 e8 20             	sub    $0x20,%eax
80105e3b:	83 f8 1f             	cmp    $0x1f,%eax
80105e3e:	0f 87 7c 00 00 00    	ja     80105ec0 <trap+0xa0>
80105e44:	ff 24 85 a0 80 10 80 	jmp    *-0x7fef7f60(,%eax,4)
80105e4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105e50:	e8 2b c5 ff ff       	call   80102380 <ideintr>
    lapiceoi();
80105e55:	e8 a6 cc ff ff       	call   80102b00 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e5a:	e8 c1 dd ff ff       	call   80103c20 <myproc>
80105e5f:	85 c0                	test   %eax,%eax
80105e61:	74 1a                	je     80105e7d <trap+0x5d>
80105e63:	e8 b8 dd ff ff       	call   80103c20 <myproc>
80105e68:	8b 50 24             	mov    0x24(%eax),%edx
80105e6b:	85 d2                	test   %edx,%edx
80105e6d:	74 0e                	je     80105e7d <trap+0x5d>
80105e6f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105e73:	f7 d0                	not    %eax
80105e75:	a8 03                	test   $0x3,%al
80105e77:	0f 84 fb 01 00 00    	je     80106078 <trap+0x258>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105e7d:	e8 9e dd ff ff       	call   80103c20 <myproc>
80105e82:	85 c0                	test   %eax,%eax
80105e84:	74 0f                	je     80105e95 <trap+0x75>
80105e86:	e8 95 dd ff ff       	call   80103c20 <myproc>
80105e8b:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105e8f:	0f 84 bb 00 00 00    	je     80105f50 <trap+0x130>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105e95:	e8 86 dd ff ff       	call   80103c20 <myproc>
80105e9a:	85 c0                	test   %eax,%eax
80105e9c:	74 1a                	je     80105eb8 <trap+0x98>
80105e9e:	e8 7d dd ff ff       	call   80103c20 <myproc>
80105ea3:	8b 40 24             	mov    0x24(%eax),%eax
80105ea6:	85 c0                	test   %eax,%eax
80105ea8:	74 0e                	je     80105eb8 <trap+0x98>
80105eaa:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105eae:	f7 d0                	not    %eax
80105eb0:	a8 03                	test   $0x3,%al
80105eb2:	0f 84 25 01 00 00    	je     80105fdd <trap+0x1bd>
    exit();
}
80105eb8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105ebb:	c9                   	leave
80105ebc:	c3                   	ret
80105ebd:	8d 76 00             	lea    0x0(%esi),%esi
80105ec0:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105ec3:	89 7d fc             	mov    %edi,-0x4(%ebp)
    if(myproc() == 0 || (tf->cs&3) == 0){
80105ec6:	e8 55 dd ff ff       	call   80103c20 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ecb:	8b 73 38             	mov    0x38(%ebx),%esi
80105ece:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    if(myproc() == 0 || (tf->cs&3) == 0){
80105ed1:	85 c0                	test   %eax,%eax
80105ed3:	0f 84 b9 01 00 00    	je     80106092 <trap+0x272>
80105ed9:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105edd:	0f 84 af 01 00 00    	je     80106092 <trap+0x272>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105ee3:	0f 20 d7             	mov    %cr2,%edi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ee6:	e8 15 dd ff ff       	call   80103c00 <cpuid>
80105eeb:	8b 4b 30             	mov    0x30(%ebx),%ecx
80105eee:	89 45 d8             	mov    %eax,-0x28(%ebp)
80105ef1:	8b 43 34             	mov    0x34(%ebx),%eax
80105ef4:	89 4d dc             	mov    %ecx,-0x24(%ebp)
80105ef7:	89 45 e0             	mov    %eax,-0x20(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80105efa:	e8 21 dd ff ff       	call   80103c20 <myproc>
80105eff:	8d 70 6c             	lea    0x6c(%eax),%esi
80105f02:	e8 19 dd ff ff       	call   80103c20 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105f07:	8b 55 d8             	mov    -0x28(%ebp),%edx
80105f0a:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80105f0d:	57                   	push   %edi
80105f0e:	ff 75 e4             	push   -0x1c(%ebp)
80105f11:	52                   	push   %edx
80105f12:	ff 75 e0             	push   -0x20(%ebp)
80105f15:	51                   	push   %ecx
80105f16:	56                   	push   %esi
80105f17:	ff 70 10             	push   0x10(%eax)
80105f1a:	68 7c 7d 10 80       	push   $0x80107d7c
80105f1f:	e8 cc a7 ff ff       	call   801006f0 <cprintf>
    myproc()->killed = 1;
80105f24:	83 c4 20             	add    $0x20,%esp
80105f27:	e8 f4 dc ff ff       	call   80103c20 <myproc>
80105f2c:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105f33:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105f36:	8b 7d fc             	mov    -0x4(%ebp),%edi
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105f39:	e8 e2 dc ff ff       	call   80103c20 <myproc>
80105f3e:	85 c0                	test   %eax,%eax
80105f40:	0f 85 1d ff ff ff    	jne    80105e63 <trap+0x43>
80105f46:	e9 32 ff ff ff       	jmp    80105e7d <trap+0x5d>
80105f4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105f50:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105f54:	0f 85 3b ff ff ff    	jne    80105e95 <trap+0x75>
    yield();
80105f5a:	e8 81 e3 ff ff       	call   801042e0 <yield>
80105f5f:	e9 31 ff ff ff       	jmp    80105e95 <trap+0x75>
80105f64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105f68:	8b 4b 38             	mov    0x38(%ebx),%ecx
80105f6b:	0f b7 53 3c          	movzwl 0x3c(%ebx),%edx
80105f6f:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80105f72:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80105f75:	e8 86 dc ff ff       	call   80103c00 <cpuid>
80105f7a:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80105f7d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105f80:	51                   	push   %ecx
80105f81:	52                   	push   %edx
80105f82:	50                   	push   %eax
80105f83:	68 24 7d 10 80       	push   $0x80107d24
80105f88:	e8 63 a7 ff ff       	call   801006f0 <cprintf>
    lapiceoi();
80105f8d:	e8 6e cb ff ff       	call   80102b00 <lapiceoi>
    break;
80105f92:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105f95:	e8 86 dc ff ff       	call   80103c20 <myproc>
80105f9a:	85 c0                	test   %eax,%eax
80105f9c:	0f 85 c1 fe ff ff    	jne    80105e63 <trap+0x43>
80105fa2:	e9 d6 fe ff ff       	jmp    80105e7d <trap+0x5d>
80105fa7:	90                   	nop
80105fa8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105faf:	00 
    if(myproc()->killed)
80105fb0:	e8 6b dc ff ff       	call   80103c20 <myproc>
80105fb5:	8b 40 24             	mov    0x24(%eax),%eax
80105fb8:	85 c0                	test   %eax,%eax
80105fba:	0f 85 c8 00 00 00    	jne    80106088 <trap+0x268>
    myproc()->tf = tf;
80105fc0:	e8 5b dc ff ff       	call   80103c20 <myproc>
80105fc5:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105fc8:	e8 63 ee ff ff       	call   80104e30 <syscall>
    if(myproc()->killed)
80105fcd:	e8 4e dc ff ff       	call   80103c20 <myproc>
80105fd2:	8b 48 24             	mov    0x24(%eax),%ecx
80105fd5:	85 c9                	test   %ecx,%ecx
80105fd7:	0f 84 db fe ff ff    	je     80105eb8 <trap+0x98>
}
80105fdd:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105fe0:	c9                   	leave
      exit();
80105fe1:	e9 6a e0 ff ff       	jmp    80104050 <exit>
80105fe6:	66 90                	xchg   %ax,%ax
80105fe8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105fef:	00 
    uartintr();
80105ff0:	e8 5b 02 00 00       	call   80106250 <uartintr>
    lapiceoi();
80105ff5:	e8 06 cb ff ff       	call   80102b00 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ffa:	e8 21 dc ff ff       	call   80103c20 <myproc>
80105fff:	85 c0                	test   %eax,%eax
80106001:	0f 85 5c fe ff ff    	jne    80105e63 <trap+0x43>
80106007:	e9 71 fe ff ff       	jmp    80105e7d <trap+0x5d>
8010600c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106010:	e8 ab c9 ff ff       	call   801029c0 <kbdintr>
    lapiceoi();
80106015:	e8 e6 ca ff ff       	call   80102b00 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010601a:	e8 01 dc ff ff       	call   80103c20 <myproc>
8010601f:	85 c0                	test   %eax,%eax
80106021:	0f 85 3c fe ff ff    	jne    80105e63 <trap+0x43>
80106027:	e9 51 fe ff ff       	jmp    80105e7d <trap+0x5d>
8010602c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80106030:	e8 cb db ff ff       	call   80103c00 <cpuid>
80106035:	85 c0                	test   %eax,%eax
80106037:	0f 85 18 fe ff ff    	jne    80105e55 <trap+0x35>
      acquire(&tickslock);
8010603d:	83 ec 0c             	sub    $0xc,%esp
80106040:	68 80 4c 11 80       	push   $0x80114c80
80106045:	e8 96 e8 ff ff       	call   801048e0 <acquire>
      wakeup(&ticks);
8010604a:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
      ticks++;
80106051:	83 05 60 4c 11 80 01 	addl   $0x1,0x80114c60
      wakeup(&ticks);
80106058:	e8 93 e3 ff ff       	call   801043f0 <wakeup>
      release(&tickslock);
8010605d:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
80106064:	e8 17 e8 ff ff       	call   80104880 <release>
80106069:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
8010606c:	e9 e4 fd ff ff       	jmp    80105e55 <trap+0x35>
80106071:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80106078:	e8 d3 df ff ff       	call   80104050 <exit>
8010607d:	e9 fb fd ff ff       	jmp    80105e7d <trap+0x5d>
80106082:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106088:	e8 c3 df ff ff       	call   80104050 <exit>
8010608d:	e9 2e ff ff ff       	jmp    80105fc0 <trap+0x1a0>
80106092:	0f 20 d2             	mov    %cr2,%edx
80106095:	89 55 e0             	mov    %edx,-0x20(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106098:	e8 63 db ff ff       	call   80103c00 <cpuid>
8010609d:	8b 55 e0             	mov    -0x20(%ebp),%edx
801060a0:	83 ec 0c             	sub    $0xc,%esp
801060a3:	52                   	push   %edx
801060a4:	ff 75 e4             	push   -0x1c(%ebp)
801060a7:	50                   	push   %eax
801060a8:	ff 73 30             	push   0x30(%ebx)
801060ab:	68 48 7d 10 80       	push   $0x80107d48
801060b0:	e8 3b a6 ff ff       	call   801006f0 <cprintf>
      panic("trap");
801060b5:	83 c4 14             	add    $0x14,%esp
801060b8:	68 53 7b 10 80       	push   $0x80107b53
801060bd:	e8 de a2 ff ff       	call   801003a0 <panic>
801060c2:	66 90                	xchg   %ax,%ax
801060c4:	66 90                	xchg   %ax,%ax
801060c6:	66 90                	xchg   %ax,%ax
801060c8:	66 90                	xchg   %ax,%ax
801060ca:	66 90                	xchg   %ax,%ax
801060cc:	66 90                	xchg   %ax,%ax
801060ce:	66 90                	xchg   %ax,%ax

801060d0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801060d0:	a1 c0 54 11 80       	mov    0x801154c0,%eax
801060d5:	85 c0                	test   %eax,%eax
801060d7:	74 17                	je     801060f0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801060d9:	ba fd 03 00 00       	mov    $0x3fd,%edx
801060de:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801060df:	a8 01                	test   $0x1,%al
801060e1:	74 0d                	je     801060f0 <uartgetc+0x20>
801060e3:	ba f8 03 00 00       	mov    $0x3f8,%edx
801060e8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801060e9:	0f b6 c0             	movzbl %al,%eax
}
801060ec:	c3                   	ret
801060ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801060f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060f5:	c3                   	ret
801060f6:	66 90                	xchg   %ax,%ax
801060f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801060ff:	00 

80106100 <uartinit>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106100:	31 c0                	xor    %eax,%eax
80106102:	ba fa 03 00 00       	mov    $0x3fa,%edx
80106107:	ee                   	out    %al,(%dx)
80106108:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010610d:	ba fb 03 00 00       	mov    $0x3fb,%edx
80106112:	ee                   	out    %al,(%dx)
80106113:	b8 0c 00 00 00       	mov    $0xc,%eax
80106118:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010611d:	ee                   	out    %al,(%dx)
8010611e:	31 c0                	xor    %eax,%eax
80106120:	ba f9 03 00 00       	mov    $0x3f9,%edx
80106125:	ee                   	out    %al,(%dx)
80106126:	b8 03 00 00 00       	mov    $0x3,%eax
8010612b:	ba fb 03 00 00       	mov    $0x3fb,%edx
80106130:	ee                   	out    %al,(%dx)
80106131:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106136:	31 c0                	xor    %eax,%eax
80106138:	ee                   	out    %al,(%dx)
80106139:	b8 01 00 00 00       	mov    $0x1,%eax
8010613e:	ba f9 03 00 00       	mov    $0x3f9,%edx
80106143:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106144:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106149:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
8010614a:	3c ff                	cmp    $0xff,%al
8010614c:	0f 84 8e 00 00 00    	je     801061e0 <uartinit+0xe0>
{
80106152:	55                   	push   %ebp
80106153:	ba fa 03 00 00       	mov    $0x3fa,%edx
80106158:	89 e5                	mov    %esp,%ebp
8010615a:	83 ec 30             	sub    $0x30,%esp
  uart = 1;
8010615d:	c7 05 c0 54 11 80 01 	movl   $0x1,0x801154c0
80106164:	00 00 00 
{
80106167:	89 5d f4             	mov    %ebx,-0xc(%ebp)
8010616a:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010616d:	ec                   	in     (%dx),%al
8010616e:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106173:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106174:	6a 00                	push   $0x0
  for(p="xv6...\n"; *p; p++)
80106176:	bf 58 7b 10 80       	mov    $0x80107b58,%edi
  ioapicenable(IRQ_COM1, 0);
8010617b:	6a 04                	push   $0x4
8010617d:	e8 7e c4 ff ff       	call   80102600 <ioapicenable>
80106182:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106185:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
80106189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
80106190:	a1 c0 54 11 80       	mov    0x801154c0,%eax
80106195:	bb 80 00 00 00       	mov    $0x80,%ebx
8010619a:	85 c0                	test   %eax,%eax
8010619c:	75 14                	jne    801061b2 <uartinit+0xb2>
8010619e:	eb 26                	jmp    801061c6 <uartinit+0xc6>
    microdelay(10);
801061a0:	83 ec 0c             	sub    $0xc,%esp
801061a3:	6a 0a                	push   $0xa
801061a5:	e8 76 c9 ff ff       	call   80102b20 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801061aa:	83 c4 10             	add    $0x10,%esp
801061ad:	83 eb 01             	sub    $0x1,%ebx
801061b0:	74 0a                	je     801061bc <uartinit+0xbc>
801061b2:	ba fd 03 00 00       	mov    $0x3fd,%edx
801061b7:	ec                   	in     (%dx),%al
801061b8:	a8 20                	test   $0x20,%al
801061ba:	74 e4                	je     801061a0 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801061bc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801061c0:	ba f8 03 00 00       	mov    $0x3f8,%edx
801061c5:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
801061c6:	0f b6 47 01          	movzbl 0x1(%edi),%eax
801061ca:	83 c7 01             	add    $0x1,%edi
801061cd:	88 45 e7             	mov    %al,-0x19(%ebp)
801061d0:	81 ff 5f 7b 10 80    	cmp    $0x80107b5f,%edi
801061d6:	75 b8                	jne    80106190 <uartinit+0x90>
}
801061d8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801061db:	8b 7d fc             	mov    -0x4(%ebp),%edi
801061de:	c9                   	leave
801061df:	c3                   	ret
801061e0:	c3                   	ret
801061e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801061ef:	00 

801061f0 <uartputc>:
  if(!uart)
801061f0:	a1 c0 54 11 80       	mov    0x801154c0,%eax
801061f5:	85 c0                	test   %eax,%eax
801061f7:	74 47                	je     80106240 <uartputc+0x50>
{
801061f9:	55                   	push   %ebp
801061fa:	89 e5                	mov    %esp,%ebp
801061fc:	83 ec 08             	sub    $0x8,%esp
801061ff:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  if(!uart)
80106202:	bb 80 00 00 00       	mov    $0x80,%ebx
80106207:	eb 19                	jmp    80106222 <uartputc+0x32>
80106209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    microdelay(10);
80106210:	83 ec 0c             	sub    $0xc,%esp
80106213:	6a 0a                	push   $0xa
80106215:	e8 06 c9 ff ff       	call   80102b20 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010621a:	83 c4 10             	add    $0x10,%esp
8010621d:	83 eb 01             	sub    $0x1,%ebx
80106220:	74 0a                	je     8010622c <uartputc+0x3c>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106222:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106227:	ec                   	in     (%dx),%al
80106228:	a8 20                	test   $0x20,%al
8010622a:	74 e4                	je     80106210 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010622c:	8b 45 08             	mov    0x8(%ebp),%eax
8010622f:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106234:	ee                   	out    %al,(%dx)
}
80106235:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80106238:	c9                   	leave
80106239:	c3                   	ret
8010623a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106240:	c3                   	ret
80106241:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106248:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010624f:	00 

80106250 <uartintr>:

void
uartintr(void)
{
80106250:	55                   	push   %ebp
80106251:	89 e5                	mov    %esp,%ebp
80106253:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106256:	68 d0 60 10 80       	push   $0x801060d0
8010625b:	e8 b0 a6 ff ff       	call   80100910 <consoleintr>
}
80106260:	83 c4 10             	add    $0x10,%esp
80106263:	c9                   	leave
80106264:	c3                   	ret

80106265 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106265:	6a 00                	push   $0x0
  pushl $0
80106267:	6a 00                	push   $0x0
  jmp alltraps
80106269:	e9 a9 fa ff ff       	jmp    80105d17 <alltraps>

8010626e <vector1>:
.globl vector1
vector1:
  pushl $0
8010626e:	6a 00                	push   $0x0
  pushl $1
80106270:	6a 01                	push   $0x1
  jmp alltraps
80106272:	e9 a0 fa ff ff       	jmp    80105d17 <alltraps>

80106277 <vector2>:
.globl vector2
vector2:
  pushl $0
80106277:	6a 00                	push   $0x0
  pushl $2
80106279:	6a 02                	push   $0x2
  jmp alltraps
8010627b:	e9 97 fa ff ff       	jmp    80105d17 <alltraps>

80106280 <vector3>:
.globl vector3
vector3:
  pushl $0
80106280:	6a 00                	push   $0x0
  pushl $3
80106282:	6a 03                	push   $0x3
  jmp alltraps
80106284:	e9 8e fa ff ff       	jmp    80105d17 <alltraps>

80106289 <vector4>:
.globl vector4
vector4:
  pushl $0
80106289:	6a 00                	push   $0x0
  pushl $4
8010628b:	6a 04                	push   $0x4
  jmp alltraps
8010628d:	e9 85 fa ff ff       	jmp    80105d17 <alltraps>

80106292 <vector5>:
.globl vector5
vector5:
  pushl $0
80106292:	6a 00                	push   $0x0
  pushl $5
80106294:	6a 05                	push   $0x5
  jmp alltraps
80106296:	e9 7c fa ff ff       	jmp    80105d17 <alltraps>

8010629b <vector6>:
.globl vector6
vector6:
  pushl $0
8010629b:	6a 00                	push   $0x0
  pushl $6
8010629d:	6a 06                	push   $0x6
  jmp alltraps
8010629f:	e9 73 fa ff ff       	jmp    80105d17 <alltraps>

801062a4 <vector7>:
.globl vector7
vector7:
  pushl $0
801062a4:	6a 00                	push   $0x0
  pushl $7
801062a6:	6a 07                	push   $0x7
  jmp alltraps
801062a8:	e9 6a fa ff ff       	jmp    80105d17 <alltraps>

801062ad <vector8>:
.globl vector8
vector8:
  pushl $8
801062ad:	6a 08                	push   $0x8
  jmp alltraps
801062af:	e9 63 fa ff ff       	jmp    80105d17 <alltraps>

801062b4 <vector9>:
.globl vector9
vector9:
  pushl $0
801062b4:	6a 00                	push   $0x0
  pushl $9
801062b6:	6a 09                	push   $0x9
  jmp alltraps
801062b8:	e9 5a fa ff ff       	jmp    80105d17 <alltraps>

801062bd <vector10>:
.globl vector10
vector10:
  pushl $10
801062bd:	6a 0a                	push   $0xa
  jmp alltraps
801062bf:	e9 53 fa ff ff       	jmp    80105d17 <alltraps>

801062c4 <vector11>:
.globl vector11
vector11:
  pushl $11
801062c4:	6a 0b                	push   $0xb
  jmp alltraps
801062c6:	e9 4c fa ff ff       	jmp    80105d17 <alltraps>

801062cb <vector12>:
.globl vector12
vector12:
  pushl $12
801062cb:	6a 0c                	push   $0xc
  jmp alltraps
801062cd:	e9 45 fa ff ff       	jmp    80105d17 <alltraps>

801062d2 <vector13>:
.globl vector13
vector13:
  pushl $13
801062d2:	6a 0d                	push   $0xd
  jmp alltraps
801062d4:	e9 3e fa ff ff       	jmp    80105d17 <alltraps>

801062d9 <vector14>:
.globl vector14
vector14:
  pushl $14
801062d9:	6a 0e                	push   $0xe
  jmp alltraps
801062db:	e9 37 fa ff ff       	jmp    80105d17 <alltraps>

801062e0 <vector15>:
.globl vector15
vector15:
  pushl $0
801062e0:	6a 00                	push   $0x0
  pushl $15
801062e2:	6a 0f                	push   $0xf
  jmp alltraps
801062e4:	e9 2e fa ff ff       	jmp    80105d17 <alltraps>

801062e9 <vector16>:
.globl vector16
vector16:
  pushl $0
801062e9:	6a 00                	push   $0x0
  pushl $16
801062eb:	6a 10                	push   $0x10
  jmp alltraps
801062ed:	e9 25 fa ff ff       	jmp    80105d17 <alltraps>

801062f2 <vector17>:
.globl vector17
vector17:
  pushl $17
801062f2:	6a 11                	push   $0x11
  jmp alltraps
801062f4:	e9 1e fa ff ff       	jmp    80105d17 <alltraps>

801062f9 <vector18>:
.globl vector18
vector18:
  pushl $0
801062f9:	6a 00                	push   $0x0
  pushl $18
801062fb:	6a 12                	push   $0x12
  jmp alltraps
801062fd:	e9 15 fa ff ff       	jmp    80105d17 <alltraps>

80106302 <vector19>:
.globl vector19
vector19:
  pushl $0
80106302:	6a 00                	push   $0x0
  pushl $19
80106304:	6a 13                	push   $0x13
  jmp alltraps
80106306:	e9 0c fa ff ff       	jmp    80105d17 <alltraps>

8010630b <vector20>:
.globl vector20
vector20:
  pushl $0
8010630b:	6a 00                	push   $0x0
  pushl $20
8010630d:	6a 14                	push   $0x14
  jmp alltraps
8010630f:	e9 03 fa ff ff       	jmp    80105d17 <alltraps>

80106314 <vector21>:
.globl vector21
vector21:
  pushl $0
80106314:	6a 00                	push   $0x0
  pushl $21
80106316:	6a 15                	push   $0x15
  jmp alltraps
80106318:	e9 fa f9 ff ff       	jmp    80105d17 <alltraps>

8010631d <vector22>:
.globl vector22
vector22:
  pushl $0
8010631d:	6a 00                	push   $0x0
  pushl $22
8010631f:	6a 16                	push   $0x16
  jmp alltraps
80106321:	e9 f1 f9 ff ff       	jmp    80105d17 <alltraps>

80106326 <vector23>:
.globl vector23
vector23:
  pushl $0
80106326:	6a 00                	push   $0x0
  pushl $23
80106328:	6a 17                	push   $0x17
  jmp alltraps
8010632a:	e9 e8 f9 ff ff       	jmp    80105d17 <alltraps>

8010632f <vector24>:
.globl vector24
vector24:
  pushl $0
8010632f:	6a 00                	push   $0x0
  pushl $24
80106331:	6a 18                	push   $0x18
  jmp alltraps
80106333:	e9 df f9 ff ff       	jmp    80105d17 <alltraps>

80106338 <vector25>:
.globl vector25
vector25:
  pushl $0
80106338:	6a 00                	push   $0x0
  pushl $25
8010633a:	6a 19                	push   $0x19
  jmp alltraps
8010633c:	e9 d6 f9 ff ff       	jmp    80105d17 <alltraps>

80106341 <vector26>:
.globl vector26
vector26:
  pushl $0
80106341:	6a 00                	push   $0x0
  pushl $26
80106343:	6a 1a                	push   $0x1a
  jmp alltraps
80106345:	e9 cd f9 ff ff       	jmp    80105d17 <alltraps>

8010634a <vector27>:
.globl vector27
vector27:
  pushl $0
8010634a:	6a 00                	push   $0x0
  pushl $27
8010634c:	6a 1b                	push   $0x1b
  jmp alltraps
8010634e:	e9 c4 f9 ff ff       	jmp    80105d17 <alltraps>

80106353 <vector28>:
.globl vector28
vector28:
  pushl $0
80106353:	6a 00                	push   $0x0
  pushl $28
80106355:	6a 1c                	push   $0x1c
  jmp alltraps
80106357:	e9 bb f9 ff ff       	jmp    80105d17 <alltraps>

8010635c <vector29>:
.globl vector29
vector29:
  pushl $0
8010635c:	6a 00                	push   $0x0
  pushl $29
8010635e:	6a 1d                	push   $0x1d
  jmp alltraps
80106360:	e9 b2 f9 ff ff       	jmp    80105d17 <alltraps>

80106365 <vector30>:
.globl vector30
vector30:
  pushl $0
80106365:	6a 00                	push   $0x0
  pushl $30
80106367:	6a 1e                	push   $0x1e
  jmp alltraps
80106369:	e9 a9 f9 ff ff       	jmp    80105d17 <alltraps>

8010636e <vector31>:
.globl vector31
vector31:
  pushl $0
8010636e:	6a 00                	push   $0x0
  pushl $31
80106370:	6a 1f                	push   $0x1f
  jmp alltraps
80106372:	e9 a0 f9 ff ff       	jmp    80105d17 <alltraps>

80106377 <vector32>:
.globl vector32
vector32:
  pushl $0
80106377:	6a 00                	push   $0x0
  pushl $32
80106379:	6a 20                	push   $0x20
  jmp alltraps
8010637b:	e9 97 f9 ff ff       	jmp    80105d17 <alltraps>

80106380 <vector33>:
.globl vector33
vector33:
  pushl $0
80106380:	6a 00                	push   $0x0
  pushl $33
80106382:	6a 21                	push   $0x21
  jmp alltraps
80106384:	e9 8e f9 ff ff       	jmp    80105d17 <alltraps>

80106389 <vector34>:
.globl vector34
vector34:
  pushl $0
80106389:	6a 00                	push   $0x0
  pushl $34
8010638b:	6a 22                	push   $0x22
  jmp alltraps
8010638d:	e9 85 f9 ff ff       	jmp    80105d17 <alltraps>

80106392 <vector35>:
.globl vector35
vector35:
  pushl $0
80106392:	6a 00                	push   $0x0
  pushl $35
80106394:	6a 23                	push   $0x23
  jmp alltraps
80106396:	e9 7c f9 ff ff       	jmp    80105d17 <alltraps>

8010639b <vector36>:
.globl vector36
vector36:
  pushl $0
8010639b:	6a 00                	push   $0x0
  pushl $36
8010639d:	6a 24                	push   $0x24
  jmp alltraps
8010639f:	e9 73 f9 ff ff       	jmp    80105d17 <alltraps>

801063a4 <vector37>:
.globl vector37
vector37:
  pushl $0
801063a4:	6a 00                	push   $0x0
  pushl $37
801063a6:	6a 25                	push   $0x25
  jmp alltraps
801063a8:	e9 6a f9 ff ff       	jmp    80105d17 <alltraps>

801063ad <vector38>:
.globl vector38
vector38:
  pushl $0
801063ad:	6a 00                	push   $0x0
  pushl $38
801063af:	6a 26                	push   $0x26
  jmp alltraps
801063b1:	e9 61 f9 ff ff       	jmp    80105d17 <alltraps>

801063b6 <vector39>:
.globl vector39
vector39:
  pushl $0
801063b6:	6a 00                	push   $0x0
  pushl $39
801063b8:	6a 27                	push   $0x27
  jmp alltraps
801063ba:	e9 58 f9 ff ff       	jmp    80105d17 <alltraps>

801063bf <vector40>:
.globl vector40
vector40:
  pushl $0
801063bf:	6a 00                	push   $0x0
  pushl $40
801063c1:	6a 28                	push   $0x28
  jmp alltraps
801063c3:	e9 4f f9 ff ff       	jmp    80105d17 <alltraps>

801063c8 <vector41>:
.globl vector41
vector41:
  pushl $0
801063c8:	6a 00                	push   $0x0
  pushl $41
801063ca:	6a 29                	push   $0x29
  jmp alltraps
801063cc:	e9 46 f9 ff ff       	jmp    80105d17 <alltraps>

801063d1 <vector42>:
.globl vector42
vector42:
  pushl $0
801063d1:	6a 00                	push   $0x0
  pushl $42
801063d3:	6a 2a                	push   $0x2a
  jmp alltraps
801063d5:	e9 3d f9 ff ff       	jmp    80105d17 <alltraps>

801063da <vector43>:
.globl vector43
vector43:
  pushl $0
801063da:	6a 00                	push   $0x0
  pushl $43
801063dc:	6a 2b                	push   $0x2b
  jmp alltraps
801063de:	e9 34 f9 ff ff       	jmp    80105d17 <alltraps>

801063e3 <vector44>:
.globl vector44
vector44:
  pushl $0
801063e3:	6a 00                	push   $0x0
  pushl $44
801063e5:	6a 2c                	push   $0x2c
  jmp alltraps
801063e7:	e9 2b f9 ff ff       	jmp    80105d17 <alltraps>

801063ec <vector45>:
.globl vector45
vector45:
  pushl $0
801063ec:	6a 00                	push   $0x0
  pushl $45
801063ee:	6a 2d                	push   $0x2d
  jmp alltraps
801063f0:	e9 22 f9 ff ff       	jmp    80105d17 <alltraps>

801063f5 <vector46>:
.globl vector46
vector46:
  pushl $0
801063f5:	6a 00                	push   $0x0
  pushl $46
801063f7:	6a 2e                	push   $0x2e
  jmp alltraps
801063f9:	e9 19 f9 ff ff       	jmp    80105d17 <alltraps>

801063fe <vector47>:
.globl vector47
vector47:
  pushl $0
801063fe:	6a 00                	push   $0x0
  pushl $47
80106400:	6a 2f                	push   $0x2f
  jmp alltraps
80106402:	e9 10 f9 ff ff       	jmp    80105d17 <alltraps>

80106407 <vector48>:
.globl vector48
vector48:
  pushl $0
80106407:	6a 00                	push   $0x0
  pushl $48
80106409:	6a 30                	push   $0x30
  jmp alltraps
8010640b:	e9 07 f9 ff ff       	jmp    80105d17 <alltraps>

80106410 <vector49>:
.globl vector49
vector49:
  pushl $0
80106410:	6a 00                	push   $0x0
  pushl $49
80106412:	6a 31                	push   $0x31
  jmp alltraps
80106414:	e9 fe f8 ff ff       	jmp    80105d17 <alltraps>

80106419 <vector50>:
.globl vector50
vector50:
  pushl $0
80106419:	6a 00                	push   $0x0
  pushl $50
8010641b:	6a 32                	push   $0x32
  jmp alltraps
8010641d:	e9 f5 f8 ff ff       	jmp    80105d17 <alltraps>

80106422 <vector51>:
.globl vector51
vector51:
  pushl $0
80106422:	6a 00                	push   $0x0
  pushl $51
80106424:	6a 33                	push   $0x33
  jmp alltraps
80106426:	e9 ec f8 ff ff       	jmp    80105d17 <alltraps>

8010642b <vector52>:
.globl vector52
vector52:
  pushl $0
8010642b:	6a 00                	push   $0x0
  pushl $52
8010642d:	6a 34                	push   $0x34
  jmp alltraps
8010642f:	e9 e3 f8 ff ff       	jmp    80105d17 <alltraps>

80106434 <vector53>:
.globl vector53
vector53:
  pushl $0
80106434:	6a 00                	push   $0x0
  pushl $53
80106436:	6a 35                	push   $0x35
  jmp alltraps
80106438:	e9 da f8 ff ff       	jmp    80105d17 <alltraps>

8010643d <vector54>:
.globl vector54
vector54:
  pushl $0
8010643d:	6a 00                	push   $0x0
  pushl $54
8010643f:	6a 36                	push   $0x36
  jmp alltraps
80106441:	e9 d1 f8 ff ff       	jmp    80105d17 <alltraps>

80106446 <vector55>:
.globl vector55
vector55:
  pushl $0
80106446:	6a 00                	push   $0x0
  pushl $55
80106448:	6a 37                	push   $0x37
  jmp alltraps
8010644a:	e9 c8 f8 ff ff       	jmp    80105d17 <alltraps>

8010644f <vector56>:
.globl vector56
vector56:
  pushl $0
8010644f:	6a 00                	push   $0x0
  pushl $56
80106451:	6a 38                	push   $0x38
  jmp alltraps
80106453:	e9 bf f8 ff ff       	jmp    80105d17 <alltraps>

80106458 <vector57>:
.globl vector57
vector57:
  pushl $0
80106458:	6a 00                	push   $0x0
  pushl $57
8010645a:	6a 39                	push   $0x39
  jmp alltraps
8010645c:	e9 b6 f8 ff ff       	jmp    80105d17 <alltraps>

80106461 <vector58>:
.globl vector58
vector58:
  pushl $0
80106461:	6a 00                	push   $0x0
  pushl $58
80106463:	6a 3a                	push   $0x3a
  jmp alltraps
80106465:	e9 ad f8 ff ff       	jmp    80105d17 <alltraps>

8010646a <vector59>:
.globl vector59
vector59:
  pushl $0
8010646a:	6a 00                	push   $0x0
  pushl $59
8010646c:	6a 3b                	push   $0x3b
  jmp alltraps
8010646e:	e9 a4 f8 ff ff       	jmp    80105d17 <alltraps>

80106473 <vector60>:
.globl vector60
vector60:
  pushl $0
80106473:	6a 00                	push   $0x0
  pushl $60
80106475:	6a 3c                	push   $0x3c
  jmp alltraps
80106477:	e9 9b f8 ff ff       	jmp    80105d17 <alltraps>

8010647c <vector61>:
.globl vector61
vector61:
  pushl $0
8010647c:	6a 00                	push   $0x0
  pushl $61
8010647e:	6a 3d                	push   $0x3d
  jmp alltraps
80106480:	e9 92 f8 ff ff       	jmp    80105d17 <alltraps>

80106485 <vector62>:
.globl vector62
vector62:
  pushl $0
80106485:	6a 00                	push   $0x0
  pushl $62
80106487:	6a 3e                	push   $0x3e
  jmp alltraps
80106489:	e9 89 f8 ff ff       	jmp    80105d17 <alltraps>

8010648e <vector63>:
.globl vector63
vector63:
  pushl $0
8010648e:	6a 00                	push   $0x0
  pushl $63
80106490:	6a 3f                	push   $0x3f
  jmp alltraps
80106492:	e9 80 f8 ff ff       	jmp    80105d17 <alltraps>

80106497 <vector64>:
.globl vector64
vector64:
  pushl $0
80106497:	6a 00                	push   $0x0
  pushl $64
80106499:	6a 40                	push   $0x40
  jmp alltraps
8010649b:	e9 77 f8 ff ff       	jmp    80105d17 <alltraps>

801064a0 <vector65>:
.globl vector65
vector65:
  pushl $0
801064a0:	6a 00                	push   $0x0
  pushl $65
801064a2:	6a 41                	push   $0x41
  jmp alltraps
801064a4:	e9 6e f8 ff ff       	jmp    80105d17 <alltraps>

801064a9 <vector66>:
.globl vector66
vector66:
  pushl $0
801064a9:	6a 00                	push   $0x0
  pushl $66
801064ab:	6a 42                	push   $0x42
  jmp alltraps
801064ad:	e9 65 f8 ff ff       	jmp    80105d17 <alltraps>

801064b2 <vector67>:
.globl vector67
vector67:
  pushl $0
801064b2:	6a 00                	push   $0x0
  pushl $67
801064b4:	6a 43                	push   $0x43
  jmp alltraps
801064b6:	e9 5c f8 ff ff       	jmp    80105d17 <alltraps>

801064bb <vector68>:
.globl vector68
vector68:
  pushl $0
801064bb:	6a 00                	push   $0x0
  pushl $68
801064bd:	6a 44                	push   $0x44
  jmp alltraps
801064bf:	e9 53 f8 ff ff       	jmp    80105d17 <alltraps>

801064c4 <vector69>:
.globl vector69
vector69:
  pushl $0
801064c4:	6a 00                	push   $0x0
  pushl $69
801064c6:	6a 45                	push   $0x45
  jmp alltraps
801064c8:	e9 4a f8 ff ff       	jmp    80105d17 <alltraps>

801064cd <vector70>:
.globl vector70
vector70:
  pushl $0
801064cd:	6a 00                	push   $0x0
  pushl $70
801064cf:	6a 46                	push   $0x46
  jmp alltraps
801064d1:	e9 41 f8 ff ff       	jmp    80105d17 <alltraps>

801064d6 <vector71>:
.globl vector71
vector71:
  pushl $0
801064d6:	6a 00                	push   $0x0
  pushl $71
801064d8:	6a 47                	push   $0x47
  jmp alltraps
801064da:	e9 38 f8 ff ff       	jmp    80105d17 <alltraps>

801064df <vector72>:
.globl vector72
vector72:
  pushl $0
801064df:	6a 00                	push   $0x0
  pushl $72
801064e1:	6a 48                	push   $0x48
  jmp alltraps
801064e3:	e9 2f f8 ff ff       	jmp    80105d17 <alltraps>

801064e8 <vector73>:
.globl vector73
vector73:
  pushl $0
801064e8:	6a 00                	push   $0x0
  pushl $73
801064ea:	6a 49                	push   $0x49
  jmp alltraps
801064ec:	e9 26 f8 ff ff       	jmp    80105d17 <alltraps>

801064f1 <vector74>:
.globl vector74
vector74:
  pushl $0
801064f1:	6a 00                	push   $0x0
  pushl $74
801064f3:	6a 4a                	push   $0x4a
  jmp alltraps
801064f5:	e9 1d f8 ff ff       	jmp    80105d17 <alltraps>

801064fa <vector75>:
.globl vector75
vector75:
  pushl $0
801064fa:	6a 00                	push   $0x0
  pushl $75
801064fc:	6a 4b                	push   $0x4b
  jmp alltraps
801064fe:	e9 14 f8 ff ff       	jmp    80105d17 <alltraps>

80106503 <vector76>:
.globl vector76
vector76:
  pushl $0
80106503:	6a 00                	push   $0x0
  pushl $76
80106505:	6a 4c                	push   $0x4c
  jmp alltraps
80106507:	e9 0b f8 ff ff       	jmp    80105d17 <alltraps>

8010650c <vector77>:
.globl vector77
vector77:
  pushl $0
8010650c:	6a 00                	push   $0x0
  pushl $77
8010650e:	6a 4d                	push   $0x4d
  jmp alltraps
80106510:	e9 02 f8 ff ff       	jmp    80105d17 <alltraps>

80106515 <vector78>:
.globl vector78
vector78:
  pushl $0
80106515:	6a 00                	push   $0x0
  pushl $78
80106517:	6a 4e                	push   $0x4e
  jmp alltraps
80106519:	e9 f9 f7 ff ff       	jmp    80105d17 <alltraps>

8010651e <vector79>:
.globl vector79
vector79:
  pushl $0
8010651e:	6a 00                	push   $0x0
  pushl $79
80106520:	6a 4f                	push   $0x4f
  jmp alltraps
80106522:	e9 f0 f7 ff ff       	jmp    80105d17 <alltraps>

80106527 <vector80>:
.globl vector80
vector80:
  pushl $0
80106527:	6a 00                	push   $0x0
  pushl $80
80106529:	6a 50                	push   $0x50
  jmp alltraps
8010652b:	e9 e7 f7 ff ff       	jmp    80105d17 <alltraps>

80106530 <vector81>:
.globl vector81
vector81:
  pushl $0
80106530:	6a 00                	push   $0x0
  pushl $81
80106532:	6a 51                	push   $0x51
  jmp alltraps
80106534:	e9 de f7 ff ff       	jmp    80105d17 <alltraps>

80106539 <vector82>:
.globl vector82
vector82:
  pushl $0
80106539:	6a 00                	push   $0x0
  pushl $82
8010653b:	6a 52                	push   $0x52
  jmp alltraps
8010653d:	e9 d5 f7 ff ff       	jmp    80105d17 <alltraps>

80106542 <vector83>:
.globl vector83
vector83:
  pushl $0
80106542:	6a 00                	push   $0x0
  pushl $83
80106544:	6a 53                	push   $0x53
  jmp alltraps
80106546:	e9 cc f7 ff ff       	jmp    80105d17 <alltraps>

8010654b <vector84>:
.globl vector84
vector84:
  pushl $0
8010654b:	6a 00                	push   $0x0
  pushl $84
8010654d:	6a 54                	push   $0x54
  jmp alltraps
8010654f:	e9 c3 f7 ff ff       	jmp    80105d17 <alltraps>

80106554 <vector85>:
.globl vector85
vector85:
  pushl $0
80106554:	6a 00                	push   $0x0
  pushl $85
80106556:	6a 55                	push   $0x55
  jmp alltraps
80106558:	e9 ba f7 ff ff       	jmp    80105d17 <alltraps>

8010655d <vector86>:
.globl vector86
vector86:
  pushl $0
8010655d:	6a 00                	push   $0x0
  pushl $86
8010655f:	6a 56                	push   $0x56
  jmp alltraps
80106561:	e9 b1 f7 ff ff       	jmp    80105d17 <alltraps>

80106566 <vector87>:
.globl vector87
vector87:
  pushl $0
80106566:	6a 00                	push   $0x0
  pushl $87
80106568:	6a 57                	push   $0x57
  jmp alltraps
8010656a:	e9 a8 f7 ff ff       	jmp    80105d17 <alltraps>

8010656f <vector88>:
.globl vector88
vector88:
  pushl $0
8010656f:	6a 00                	push   $0x0
  pushl $88
80106571:	6a 58                	push   $0x58
  jmp alltraps
80106573:	e9 9f f7 ff ff       	jmp    80105d17 <alltraps>

80106578 <vector89>:
.globl vector89
vector89:
  pushl $0
80106578:	6a 00                	push   $0x0
  pushl $89
8010657a:	6a 59                	push   $0x59
  jmp alltraps
8010657c:	e9 96 f7 ff ff       	jmp    80105d17 <alltraps>

80106581 <vector90>:
.globl vector90
vector90:
  pushl $0
80106581:	6a 00                	push   $0x0
  pushl $90
80106583:	6a 5a                	push   $0x5a
  jmp alltraps
80106585:	e9 8d f7 ff ff       	jmp    80105d17 <alltraps>

8010658a <vector91>:
.globl vector91
vector91:
  pushl $0
8010658a:	6a 00                	push   $0x0
  pushl $91
8010658c:	6a 5b                	push   $0x5b
  jmp alltraps
8010658e:	e9 84 f7 ff ff       	jmp    80105d17 <alltraps>

80106593 <vector92>:
.globl vector92
vector92:
  pushl $0
80106593:	6a 00                	push   $0x0
  pushl $92
80106595:	6a 5c                	push   $0x5c
  jmp alltraps
80106597:	e9 7b f7 ff ff       	jmp    80105d17 <alltraps>

8010659c <vector93>:
.globl vector93
vector93:
  pushl $0
8010659c:	6a 00                	push   $0x0
  pushl $93
8010659e:	6a 5d                	push   $0x5d
  jmp alltraps
801065a0:	e9 72 f7 ff ff       	jmp    80105d17 <alltraps>

801065a5 <vector94>:
.globl vector94
vector94:
  pushl $0
801065a5:	6a 00                	push   $0x0
  pushl $94
801065a7:	6a 5e                	push   $0x5e
  jmp alltraps
801065a9:	e9 69 f7 ff ff       	jmp    80105d17 <alltraps>

801065ae <vector95>:
.globl vector95
vector95:
  pushl $0
801065ae:	6a 00                	push   $0x0
  pushl $95
801065b0:	6a 5f                	push   $0x5f
  jmp alltraps
801065b2:	e9 60 f7 ff ff       	jmp    80105d17 <alltraps>

801065b7 <vector96>:
.globl vector96
vector96:
  pushl $0
801065b7:	6a 00                	push   $0x0
  pushl $96
801065b9:	6a 60                	push   $0x60
  jmp alltraps
801065bb:	e9 57 f7 ff ff       	jmp    80105d17 <alltraps>

801065c0 <vector97>:
.globl vector97
vector97:
  pushl $0
801065c0:	6a 00                	push   $0x0
  pushl $97
801065c2:	6a 61                	push   $0x61
  jmp alltraps
801065c4:	e9 4e f7 ff ff       	jmp    80105d17 <alltraps>

801065c9 <vector98>:
.globl vector98
vector98:
  pushl $0
801065c9:	6a 00                	push   $0x0
  pushl $98
801065cb:	6a 62                	push   $0x62
  jmp alltraps
801065cd:	e9 45 f7 ff ff       	jmp    80105d17 <alltraps>

801065d2 <vector99>:
.globl vector99
vector99:
  pushl $0
801065d2:	6a 00                	push   $0x0
  pushl $99
801065d4:	6a 63                	push   $0x63
  jmp alltraps
801065d6:	e9 3c f7 ff ff       	jmp    80105d17 <alltraps>

801065db <vector100>:
.globl vector100
vector100:
  pushl $0
801065db:	6a 00                	push   $0x0
  pushl $100
801065dd:	6a 64                	push   $0x64
  jmp alltraps
801065df:	e9 33 f7 ff ff       	jmp    80105d17 <alltraps>

801065e4 <vector101>:
.globl vector101
vector101:
  pushl $0
801065e4:	6a 00                	push   $0x0
  pushl $101
801065e6:	6a 65                	push   $0x65
  jmp alltraps
801065e8:	e9 2a f7 ff ff       	jmp    80105d17 <alltraps>

801065ed <vector102>:
.globl vector102
vector102:
  pushl $0
801065ed:	6a 00                	push   $0x0
  pushl $102
801065ef:	6a 66                	push   $0x66
  jmp alltraps
801065f1:	e9 21 f7 ff ff       	jmp    80105d17 <alltraps>

801065f6 <vector103>:
.globl vector103
vector103:
  pushl $0
801065f6:	6a 00                	push   $0x0
  pushl $103
801065f8:	6a 67                	push   $0x67
  jmp alltraps
801065fa:	e9 18 f7 ff ff       	jmp    80105d17 <alltraps>

801065ff <vector104>:
.globl vector104
vector104:
  pushl $0
801065ff:	6a 00                	push   $0x0
  pushl $104
80106601:	6a 68                	push   $0x68
  jmp alltraps
80106603:	e9 0f f7 ff ff       	jmp    80105d17 <alltraps>

80106608 <vector105>:
.globl vector105
vector105:
  pushl $0
80106608:	6a 00                	push   $0x0
  pushl $105
8010660a:	6a 69                	push   $0x69
  jmp alltraps
8010660c:	e9 06 f7 ff ff       	jmp    80105d17 <alltraps>

80106611 <vector106>:
.globl vector106
vector106:
  pushl $0
80106611:	6a 00                	push   $0x0
  pushl $106
80106613:	6a 6a                	push   $0x6a
  jmp alltraps
80106615:	e9 fd f6 ff ff       	jmp    80105d17 <alltraps>

8010661a <vector107>:
.globl vector107
vector107:
  pushl $0
8010661a:	6a 00                	push   $0x0
  pushl $107
8010661c:	6a 6b                	push   $0x6b
  jmp alltraps
8010661e:	e9 f4 f6 ff ff       	jmp    80105d17 <alltraps>

80106623 <vector108>:
.globl vector108
vector108:
  pushl $0
80106623:	6a 00                	push   $0x0
  pushl $108
80106625:	6a 6c                	push   $0x6c
  jmp alltraps
80106627:	e9 eb f6 ff ff       	jmp    80105d17 <alltraps>

8010662c <vector109>:
.globl vector109
vector109:
  pushl $0
8010662c:	6a 00                	push   $0x0
  pushl $109
8010662e:	6a 6d                	push   $0x6d
  jmp alltraps
80106630:	e9 e2 f6 ff ff       	jmp    80105d17 <alltraps>

80106635 <vector110>:
.globl vector110
vector110:
  pushl $0
80106635:	6a 00                	push   $0x0
  pushl $110
80106637:	6a 6e                	push   $0x6e
  jmp alltraps
80106639:	e9 d9 f6 ff ff       	jmp    80105d17 <alltraps>

8010663e <vector111>:
.globl vector111
vector111:
  pushl $0
8010663e:	6a 00                	push   $0x0
  pushl $111
80106640:	6a 6f                	push   $0x6f
  jmp alltraps
80106642:	e9 d0 f6 ff ff       	jmp    80105d17 <alltraps>

80106647 <vector112>:
.globl vector112
vector112:
  pushl $0
80106647:	6a 00                	push   $0x0
  pushl $112
80106649:	6a 70                	push   $0x70
  jmp alltraps
8010664b:	e9 c7 f6 ff ff       	jmp    80105d17 <alltraps>

80106650 <vector113>:
.globl vector113
vector113:
  pushl $0
80106650:	6a 00                	push   $0x0
  pushl $113
80106652:	6a 71                	push   $0x71
  jmp alltraps
80106654:	e9 be f6 ff ff       	jmp    80105d17 <alltraps>

80106659 <vector114>:
.globl vector114
vector114:
  pushl $0
80106659:	6a 00                	push   $0x0
  pushl $114
8010665b:	6a 72                	push   $0x72
  jmp alltraps
8010665d:	e9 b5 f6 ff ff       	jmp    80105d17 <alltraps>

80106662 <vector115>:
.globl vector115
vector115:
  pushl $0
80106662:	6a 00                	push   $0x0
  pushl $115
80106664:	6a 73                	push   $0x73
  jmp alltraps
80106666:	e9 ac f6 ff ff       	jmp    80105d17 <alltraps>

8010666b <vector116>:
.globl vector116
vector116:
  pushl $0
8010666b:	6a 00                	push   $0x0
  pushl $116
8010666d:	6a 74                	push   $0x74
  jmp alltraps
8010666f:	e9 a3 f6 ff ff       	jmp    80105d17 <alltraps>

80106674 <vector117>:
.globl vector117
vector117:
  pushl $0
80106674:	6a 00                	push   $0x0
  pushl $117
80106676:	6a 75                	push   $0x75
  jmp alltraps
80106678:	e9 9a f6 ff ff       	jmp    80105d17 <alltraps>

8010667d <vector118>:
.globl vector118
vector118:
  pushl $0
8010667d:	6a 00                	push   $0x0
  pushl $118
8010667f:	6a 76                	push   $0x76
  jmp alltraps
80106681:	e9 91 f6 ff ff       	jmp    80105d17 <alltraps>

80106686 <vector119>:
.globl vector119
vector119:
  pushl $0
80106686:	6a 00                	push   $0x0
  pushl $119
80106688:	6a 77                	push   $0x77
  jmp alltraps
8010668a:	e9 88 f6 ff ff       	jmp    80105d17 <alltraps>

8010668f <vector120>:
.globl vector120
vector120:
  pushl $0
8010668f:	6a 00                	push   $0x0
  pushl $120
80106691:	6a 78                	push   $0x78
  jmp alltraps
80106693:	e9 7f f6 ff ff       	jmp    80105d17 <alltraps>

80106698 <vector121>:
.globl vector121
vector121:
  pushl $0
80106698:	6a 00                	push   $0x0
  pushl $121
8010669a:	6a 79                	push   $0x79
  jmp alltraps
8010669c:	e9 76 f6 ff ff       	jmp    80105d17 <alltraps>

801066a1 <vector122>:
.globl vector122
vector122:
  pushl $0
801066a1:	6a 00                	push   $0x0
  pushl $122
801066a3:	6a 7a                	push   $0x7a
  jmp alltraps
801066a5:	e9 6d f6 ff ff       	jmp    80105d17 <alltraps>

801066aa <vector123>:
.globl vector123
vector123:
  pushl $0
801066aa:	6a 00                	push   $0x0
  pushl $123
801066ac:	6a 7b                	push   $0x7b
  jmp alltraps
801066ae:	e9 64 f6 ff ff       	jmp    80105d17 <alltraps>

801066b3 <vector124>:
.globl vector124
vector124:
  pushl $0
801066b3:	6a 00                	push   $0x0
  pushl $124
801066b5:	6a 7c                	push   $0x7c
  jmp alltraps
801066b7:	e9 5b f6 ff ff       	jmp    80105d17 <alltraps>

801066bc <vector125>:
.globl vector125
vector125:
  pushl $0
801066bc:	6a 00                	push   $0x0
  pushl $125
801066be:	6a 7d                	push   $0x7d
  jmp alltraps
801066c0:	e9 52 f6 ff ff       	jmp    80105d17 <alltraps>

801066c5 <vector126>:
.globl vector126
vector126:
  pushl $0
801066c5:	6a 00                	push   $0x0
  pushl $126
801066c7:	6a 7e                	push   $0x7e
  jmp alltraps
801066c9:	e9 49 f6 ff ff       	jmp    80105d17 <alltraps>

801066ce <vector127>:
.globl vector127
vector127:
  pushl $0
801066ce:	6a 00                	push   $0x0
  pushl $127
801066d0:	6a 7f                	push   $0x7f
  jmp alltraps
801066d2:	e9 40 f6 ff ff       	jmp    80105d17 <alltraps>

801066d7 <vector128>:
.globl vector128
vector128:
  pushl $0
801066d7:	6a 00                	push   $0x0
  pushl $128
801066d9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801066de:	e9 34 f6 ff ff       	jmp    80105d17 <alltraps>

801066e3 <vector129>:
.globl vector129
vector129:
  pushl $0
801066e3:	6a 00                	push   $0x0
  pushl $129
801066e5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801066ea:	e9 28 f6 ff ff       	jmp    80105d17 <alltraps>

801066ef <vector130>:
.globl vector130
vector130:
  pushl $0
801066ef:	6a 00                	push   $0x0
  pushl $130
801066f1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801066f6:	e9 1c f6 ff ff       	jmp    80105d17 <alltraps>

801066fb <vector131>:
.globl vector131
vector131:
  pushl $0
801066fb:	6a 00                	push   $0x0
  pushl $131
801066fd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106702:	e9 10 f6 ff ff       	jmp    80105d17 <alltraps>

80106707 <vector132>:
.globl vector132
vector132:
  pushl $0
80106707:	6a 00                	push   $0x0
  pushl $132
80106709:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010670e:	e9 04 f6 ff ff       	jmp    80105d17 <alltraps>

80106713 <vector133>:
.globl vector133
vector133:
  pushl $0
80106713:	6a 00                	push   $0x0
  pushl $133
80106715:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010671a:	e9 f8 f5 ff ff       	jmp    80105d17 <alltraps>

8010671f <vector134>:
.globl vector134
vector134:
  pushl $0
8010671f:	6a 00                	push   $0x0
  pushl $134
80106721:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106726:	e9 ec f5 ff ff       	jmp    80105d17 <alltraps>

8010672b <vector135>:
.globl vector135
vector135:
  pushl $0
8010672b:	6a 00                	push   $0x0
  pushl $135
8010672d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106732:	e9 e0 f5 ff ff       	jmp    80105d17 <alltraps>

80106737 <vector136>:
.globl vector136
vector136:
  pushl $0
80106737:	6a 00                	push   $0x0
  pushl $136
80106739:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010673e:	e9 d4 f5 ff ff       	jmp    80105d17 <alltraps>

80106743 <vector137>:
.globl vector137
vector137:
  pushl $0
80106743:	6a 00                	push   $0x0
  pushl $137
80106745:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010674a:	e9 c8 f5 ff ff       	jmp    80105d17 <alltraps>

8010674f <vector138>:
.globl vector138
vector138:
  pushl $0
8010674f:	6a 00                	push   $0x0
  pushl $138
80106751:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106756:	e9 bc f5 ff ff       	jmp    80105d17 <alltraps>

8010675b <vector139>:
.globl vector139
vector139:
  pushl $0
8010675b:	6a 00                	push   $0x0
  pushl $139
8010675d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106762:	e9 b0 f5 ff ff       	jmp    80105d17 <alltraps>

80106767 <vector140>:
.globl vector140
vector140:
  pushl $0
80106767:	6a 00                	push   $0x0
  pushl $140
80106769:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010676e:	e9 a4 f5 ff ff       	jmp    80105d17 <alltraps>

80106773 <vector141>:
.globl vector141
vector141:
  pushl $0
80106773:	6a 00                	push   $0x0
  pushl $141
80106775:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010677a:	e9 98 f5 ff ff       	jmp    80105d17 <alltraps>

8010677f <vector142>:
.globl vector142
vector142:
  pushl $0
8010677f:	6a 00                	push   $0x0
  pushl $142
80106781:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106786:	e9 8c f5 ff ff       	jmp    80105d17 <alltraps>

8010678b <vector143>:
.globl vector143
vector143:
  pushl $0
8010678b:	6a 00                	push   $0x0
  pushl $143
8010678d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106792:	e9 80 f5 ff ff       	jmp    80105d17 <alltraps>

80106797 <vector144>:
.globl vector144
vector144:
  pushl $0
80106797:	6a 00                	push   $0x0
  pushl $144
80106799:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010679e:	e9 74 f5 ff ff       	jmp    80105d17 <alltraps>

801067a3 <vector145>:
.globl vector145
vector145:
  pushl $0
801067a3:	6a 00                	push   $0x0
  pushl $145
801067a5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801067aa:	e9 68 f5 ff ff       	jmp    80105d17 <alltraps>

801067af <vector146>:
.globl vector146
vector146:
  pushl $0
801067af:	6a 00                	push   $0x0
  pushl $146
801067b1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801067b6:	e9 5c f5 ff ff       	jmp    80105d17 <alltraps>

801067bb <vector147>:
.globl vector147
vector147:
  pushl $0
801067bb:	6a 00                	push   $0x0
  pushl $147
801067bd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801067c2:	e9 50 f5 ff ff       	jmp    80105d17 <alltraps>

801067c7 <vector148>:
.globl vector148
vector148:
  pushl $0
801067c7:	6a 00                	push   $0x0
  pushl $148
801067c9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801067ce:	e9 44 f5 ff ff       	jmp    80105d17 <alltraps>

801067d3 <vector149>:
.globl vector149
vector149:
  pushl $0
801067d3:	6a 00                	push   $0x0
  pushl $149
801067d5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801067da:	e9 38 f5 ff ff       	jmp    80105d17 <alltraps>

801067df <vector150>:
.globl vector150
vector150:
  pushl $0
801067df:	6a 00                	push   $0x0
  pushl $150
801067e1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801067e6:	e9 2c f5 ff ff       	jmp    80105d17 <alltraps>

801067eb <vector151>:
.globl vector151
vector151:
  pushl $0
801067eb:	6a 00                	push   $0x0
  pushl $151
801067ed:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801067f2:	e9 20 f5 ff ff       	jmp    80105d17 <alltraps>

801067f7 <vector152>:
.globl vector152
vector152:
  pushl $0
801067f7:	6a 00                	push   $0x0
  pushl $152
801067f9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801067fe:	e9 14 f5 ff ff       	jmp    80105d17 <alltraps>

80106803 <vector153>:
.globl vector153
vector153:
  pushl $0
80106803:	6a 00                	push   $0x0
  pushl $153
80106805:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010680a:	e9 08 f5 ff ff       	jmp    80105d17 <alltraps>

8010680f <vector154>:
.globl vector154
vector154:
  pushl $0
8010680f:	6a 00                	push   $0x0
  pushl $154
80106811:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106816:	e9 fc f4 ff ff       	jmp    80105d17 <alltraps>

8010681b <vector155>:
.globl vector155
vector155:
  pushl $0
8010681b:	6a 00                	push   $0x0
  pushl $155
8010681d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106822:	e9 f0 f4 ff ff       	jmp    80105d17 <alltraps>

80106827 <vector156>:
.globl vector156
vector156:
  pushl $0
80106827:	6a 00                	push   $0x0
  pushl $156
80106829:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010682e:	e9 e4 f4 ff ff       	jmp    80105d17 <alltraps>

80106833 <vector157>:
.globl vector157
vector157:
  pushl $0
80106833:	6a 00                	push   $0x0
  pushl $157
80106835:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010683a:	e9 d8 f4 ff ff       	jmp    80105d17 <alltraps>

8010683f <vector158>:
.globl vector158
vector158:
  pushl $0
8010683f:	6a 00                	push   $0x0
  pushl $158
80106841:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106846:	e9 cc f4 ff ff       	jmp    80105d17 <alltraps>

8010684b <vector159>:
.globl vector159
vector159:
  pushl $0
8010684b:	6a 00                	push   $0x0
  pushl $159
8010684d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106852:	e9 c0 f4 ff ff       	jmp    80105d17 <alltraps>

80106857 <vector160>:
.globl vector160
vector160:
  pushl $0
80106857:	6a 00                	push   $0x0
  pushl $160
80106859:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010685e:	e9 b4 f4 ff ff       	jmp    80105d17 <alltraps>

80106863 <vector161>:
.globl vector161
vector161:
  pushl $0
80106863:	6a 00                	push   $0x0
  pushl $161
80106865:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010686a:	e9 a8 f4 ff ff       	jmp    80105d17 <alltraps>

8010686f <vector162>:
.globl vector162
vector162:
  pushl $0
8010686f:	6a 00                	push   $0x0
  pushl $162
80106871:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106876:	e9 9c f4 ff ff       	jmp    80105d17 <alltraps>

8010687b <vector163>:
.globl vector163
vector163:
  pushl $0
8010687b:	6a 00                	push   $0x0
  pushl $163
8010687d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106882:	e9 90 f4 ff ff       	jmp    80105d17 <alltraps>

80106887 <vector164>:
.globl vector164
vector164:
  pushl $0
80106887:	6a 00                	push   $0x0
  pushl $164
80106889:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010688e:	e9 84 f4 ff ff       	jmp    80105d17 <alltraps>

80106893 <vector165>:
.globl vector165
vector165:
  pushl $0
80106893:	6a 00                	push   $0x0
  pushl $165
80106895:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010689a:	e9 78 f4 ff ff       	jmp    80105d17 <alltraps>

8010689f <vector166>:
.globl vector166
vector166:
  pushl $0
8010689f:	6a 00                	push   $0x0
  pushl $166
801068a1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801068a6:	e9 6c f4 ff ff       	jmp    80105d17 <alltraps>

801068ab <vector167>:
.globl vector167
vector167:
  pushl $0
801068ab:	6a 00                	push   $0x0
  pushl $167
801068ad:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801068b2:	e9 60 f4 ff ff       	jmp    80105d17 <alltraps>

801068b7 <vector168>:
.globl vector168
vector168:
  pushl $0
801068b7:	6a 00                	push   $0x0
  pushl $168
801068b9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801068be:	e9 54 f4 ff ff       	jmp    80105d17 <alltraps>

801068c3 <vector169>:
.globl vector169
vector169:
  pushl $0
801068c3:	6a 00                	push   $0x0
  pushl $169
801068c5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801068ca:	e9 48 f4 ff ff       	jmp    80105d17 <alltraps>

801068cf <vector170>:
.globl vector170
vector170:
  pushl $0
801068cf:	6a 00                	push   $0x0
  pushl $170
801068d1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801068d6:	e9 3c f4 ff ff       	jmp    80105d17 <alltraps>

801068db <vector171>:
.globl vector171
vector171:
  pushl $0
801068db:	6a 00                	push   $0x0
  pushl $171
801068dd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801068e2:	e9 30 f4 ff ff       	jmp    80105d17 <alltraps>

801068e7 <vector172>:
.globl vector172
vector172:
  pushl $0
801068e7:	6a 00                	push   $0x0
  pushl $172
801068e9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801068ee:	e9 24 f4 ff ff       	jmp    80105d17 <alltraps>

801068f3 <vector173>:
.globl vector173
vector173:
  pushl $0
801068f3:	6a 00                	push   $0x0
  pushl $173
801068f5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801068fa:	e9 18 f4 ff ff       	jmp    80105d17 <alltraps>

801068ff <vector174>:
.globl vector174
vector174:
  pushl $0
801068ff:	6a 00                	push   $0x0
  pushl $174
80106901:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106906:	e9 0c f4 ff ff       	jmp    80105d17 <alltraps>

8010690b <vector175>:
.globl vector175
vector175:
  pushl $0
8010690b:	6a 00                	push   $0x0
  pushl $175
8010690d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106912:	e9 00 f4 ff ff       	jmp    80105d17 <alltraps>

80106917 <vector176>:
.globl vector176
vector176:
  pushl $0
80106917:	6a 00                	push   $0x0
  pushl $176
80106919:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010691e:	e9 f4 f3 ff ff       	jmp    80105d17 <alltraps>

80106923 <vector177>:
.globl vector177
vector177:
  pushl $0
80106923:	6a 00                	push   $0x0
  pushl $177
80106925:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010692a:	e9 e8 f3 ff ff       	jmp    80105d17 <alltraps>

8010692f <vector178>:
.globl vector178
vector178:
  pushl $0
8010692f:	6a 00                	push   $0x0
  pushl $178
80106931:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106936:	e9 dc f3 ff ff       	jmp    80105d17 <alltraps>

8010693b <vector179>:
.globl vector179
vector179:
  pushl $0
8010693b:	6a 00                	push   $0x0
  pushl $179
8010693d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106942:	e9 d0 f3 ff ff       	jmp    80105d17 <alltraps>

80106947 <vector180>:
.globl vector180
vector180:
  pushl $0
80106947:	6a 00                	push   $0x0
  pushl $180
80106949:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010694e:	e9 c4 f3 ff ff       	jmp    80105d17 <alltraps>

80106953 <vector181>:
.globl vector181
vector181:
  pushl $0
80106953:	6a 00                	push   $0x0
  pushl $181
80106955:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010695a:	e9 b8 f3 ff ff       	jmp    80105d17 <alltraps>

8010695f <vector182>:
.globl vector182
vector182:
  pushl $0
8010695f:	6a 00                	push   $0x0
  pushl $182
80106961:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106966:	e9 ac f3 ff ff       	jmp    80105d17 <alltraps>

8010696b <vector183>:
.globl vector183
vector183:
  pushl $0
8010696b:	6a 00                	push   $0x0
  pushl $183
8010696d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106972:	e9 a0 f3 ff ff       	jmp    80105d17 <alltraps>

80106977 <vector184>:
.globl vector184
vector184:
  pushl $0
80106977:	6a 00                	push   $0x0
  pushl $184
80106979:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010697e:	e9 94 f3 ff ff       	jmp    80105d17 <alltraps>

80106983 <vector185>:
.globl vector185
vector185:
  pushl $0
80106983:	6a 00                	push   $0x0
  pushl $185
80106985:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010698a:	e9 88 f3 ff ff       	jmp    80105d17 <alltraps>

8010698f <vector186>:
.globl vector186
vector186:
  pushl $0
8010698f:	6a 00                	push   $0x0
  pushl $186
80106991:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106996:	e9 7c f3 ff ff       	jmp    80105d17 <alltraps>

8010699b <vector187>:
.globl vector187
vector187:
  pushl $0
8010699b:	6a 00                	push   $0x0
  pushl $187
8010699d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801069a2:	e9 70 f3 ff ff       	jmp    80105d17 <alltraps>

801069a7 <vector188>:
.globl vector188
vector188:
  pushl $0
801069a7:	6a 00                	push   $0x0
  pushl $188
801069a9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801069ae:	e9 64 f3 ff ff       	jmp    80105d17 <alltraps>

801069b3 <vector189>:
.globl vector189
vector189:
  pushl $0
801069b3:	6a 00                	push   $0x0
  pushl $189
801069b5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801069ba:	e9 58 f3 ff ff       	jmp    80105d17 <alltraps>

801069bf <vector190>:
.globl vector190
vector190:
  pushl $0
801069bf:	6a 00                	push   $0x0
  pushl $190
801069c1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801069c6:	e9 4c f3 ff ff       	jmp    80105d17 <alltraps>

801069cb <vector191>:
.globl vector191
vector191:
  pushl $0
801069cb:	6a 00                	push   $0x0
  pushl $191
801069cd:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801069d2:	e9 40 f3 ff ff       	jmp    80105d17 <alltraps>

801069d7 <vector192>:
.globl vector192
vector192:
  pushl $0
801069d7:	6a 00                	push   $0x0
  pushl $192
801069d9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801069de:	e9 34 f3 ff ff       	jmp    80105d17 <alltraps>

801069e3 <vector193>:
.globl vector193
vector193:
  pushl $0
801069e3:	6a 00                	push   $0x0
  pushl $193
801069e5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801069ea:	e9 28 f3 ff ff       	jmp    80105d17 <alltraps>

801069ef <vector194>:
.globl vector194
vector194:
  pushl $0
801069ef:	6a 00                	push   $0x0
  pushl $194
801069f1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801069f6:	e9 1c f3 ff ff       	jmp    80105d17 <alltraps>

801069fb <vector195>:
.globl vector195
vector195:
  pushl $0
801069fb:	6a 00                	push   $0x0
  pushl $195
801069fd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106a02:	e9 10 f3 ff ff       	jmp    80105d17 <alltraps>

80106a07 <vector196>:
.globl vector196
vector196:
  pushl $0
80106a07:	6a 00                	push   $0x0
  pushl $196
80106a09:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106a0e:	e9 04 f3 ff ff       	jmp    80105d17 <alltraps>

80106a13 <vector197>:
.globl vector197
vector197:
  pushl $0
80106a13:	6a 00                	push   $0x0
  pushl $197
80106a15:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106a1a:	e9 f8 f2 ff ff       	jmp    80105d17 <alltraps>

80106a1f <vector198>:
.globl vector198
vector198:
  pushl $0
80106a1f:	6a 00                	push   $0x0
  pushl $198
80106a21:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106a26:	e9 ec f2 ff ff       	jmp    80105d17 <alltraps>

80106a2b <vector199>:
.globl vector199
vector199:
  pushl $0
80106a2b:	6a 00                	push   $0x0
  pushl $199
80106a2d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106a32:	e9 e0 f2 ff ff       	jmp    80105d17 <alltraps>

80106a37 <vector200>:
.globl vector200
vector200:
  pushl $0
80106a37:	6a 00                	push   $0x0
  pushl $200
80106a39:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106a3e:	e9 d4 f2 ff ff       	jmp    80105d17 <alltraps>

80106a43 <vector201>:
.globl vector201
vector201:
  pushl $0
80106a43:	6a 00                	push   $0x0
  pushl $201
80106a45:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106a4a:	e9 c8 f2 ff ff       	jmp    80105d17 <alltraps>

80106a4f <vector202>:
.globl vector202
vector202:
  pushl $0
80106a4f:	6a 00                	push   $0x0
  pushl $202
80106a51:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106a56:	e9 bc f2 ff ff       	jmp    80105d17 <alltraps>

80106a5b <vector203>:
.globl vector203
vector203:
  pushl $0
80106a5b:	6a 00                	push   $0x0
  pushl $203
80106a5d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106a62:	e9 b0 f2 ff ff       	jmp    80105d17 <alltraps>

80106a67 <vector204>:
.globl vector204
vector204:
  pushl $0
80106a67:	6a 00                	push   $0x0
  pushl $204
80106a69:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106a6e:	e9 a4 f2 ff ff       	jmp    80105d17 <alltraps>

80106a73 <vector205>:
.globl vector205
vector205:
  pushl $0
80106a73:	6a 00                	push   $0x0
  pushl $205
80106a75:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106a7a:	e9 98 f2 ff ff       	jmp    80105d17 <alltraps>

80106a7f <vector206>:
.globl vector206
vector206:
  pushl $0
80106a7f:	6a 00                	push   $0x0
  pushl $206
80106a81:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106a86:	e9 8c f2 ff ff       	jmp    80105d17 <alltraps>

80106a8b <vector207>:
.globl vector207
vector207:
  pushl $0
80106a8b:	6a 00                	push   $0x0
  pushl $207
80106a8d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106a92:	e9 80 f2 ff ff       	jmp    80105d17 <alltraps>

80106a97 <vector208>:
.globl vector208
vector208:
  pushl $0
80106a97:	6a 00                	push   $0x0
  pushl $208
80106a99:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106a9e:	e9 74 f2 ff ff       	jmp    80105d17 <alltraps>

80106aa3 <vector209>:
.globl vector209
vector209:
  pushl $0
80106aa3:	6a 00                	push   $0x0
  pushl $209
80106aa5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106aaa:	e9 68 f2 ff ff       	jmp    80105d17 <alltraps>

80106aaf <vector210>:
.globl vector210
vector210:
  pushl $0
80106aaf:	6a 00                	push   $0x0
  pushl $210
80106ab1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106ab6:	e9 5c f2 ff ff       	jmp    80105d17 <alltraps>

80106abb <vector211>:
.globl vector211
vector211:
  pushl $0
80106abb:	6a 00                	push   $0x0
  pushl $211
80106abd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106ac2:	e9 50 f2 ff ff       	jmp    80105d17 <alltraps>

80106ac7 <vector212>:
.globl vector212
vector212:
  pushl $0
80106ac7:	6a 00                	push   $0x0
  pushl $212
80106ac9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106ace:	e9 44 f2 ff ff       	jmp    80105d17 <alltraps>

80106ad3 <vector213>:
.globl vector213
vector213:
  pushl $0
80106ad3:	6a 00                	push   $0x0
  pushl $213
80106ad5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106ada:	e9 38 f2 ff ff       	jmp    80105d17 <alltraps>

80106adf <vector214>:
.globl vector214
vector214:
  pushl $0
80106adf:	6a 00                	push   $0x0
  pushl $214
80106ae1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106ae6:	e9 2c f2 ff ff       	jmp    80105d17 <alltraps>

80106aeb <vector215>:
.globl vector215
vector215:
  pushl $0
80106aeb:	6a 00                	push   $0x0
  pushl $215
80106aed:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106af2:	e9 20 f2 ff ff       	jmp    80105d17 <alltraps>

80106af7 <vector216>:
.globl vector216
vector216:
  pushl $0
80106af7:	6a 00                	push   $0x0
  pushl $216
80106af9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106afe:	e9 14 f2 ff ff       	jmp    80105d17 <alltraps>

80106b03 <vector217>:
.globl vector217
vector217:
  pushl $0
80106b03:	6a 00                	push   $0x0
  pushl $217
80106b05:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106b0a:	e9 08 f2 ff ff       	jmp    80105d17 <alltraps>

80106b0f <vector218>:
.globl vector218
vector218:
  pushl $0
80106b0f:	6a 00                	push   $0x0
  pushl $218
80106b11:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106b16:	e9 fc f1 ff ff       	jmp    80105d17 <alltraps>

80106b1b <vector219>:
.globl vector219
vector219:
  pushl $0
80106b1b:	6a 00                	push   $0x0
  pushl $219
80106b1d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106b22:	e9 f0 f1 ff ff       	jmp    80105d17 <alltraps>

80106b27 <vector220>:
.globl vector220
vector220:
  pushl $0
80106b27:	6a 00                	push   $0x0
  pushl $220
80106b29:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106b2e:	e9 e4 f1 ff ff       	jmp    80105d17 <alltraps>

80106b33 <vector221>:
.globl vector221
vector221:
  pushl $0
80106b33:	6a 00                	push   $0x0
  pushl $221
80106b35:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106b3a:	e9 d8 f1 ff ff       	jmp    80105d17 <alltraps>

80106b3f <vector222>:
.globl vector222
vector222:
  pushl $0
80106b3f:	6a 00                	push   $0x0
  pushl $222
80106b41:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106b46:	e9 cc f1 ff ff       	jmp    80105d17 <alltraps>

80106b4b <vector223>:
.globl vector223
vector223:
  pushl $0
80106b4b:	6a 00                	push   $0x0
  pushl $223
80106b4d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106b52:	e9 c0 f1 ff ff       	jmp    80105d17 <alltraps>

80106b57 <vector224>:
.globl vector224
vector224:
  pushl $0
80106b57:	6a 00                	push   $0x0
  pushl $224
80106b59:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106b5e:	e9 b4 f1 ff ff       	jmp    80105d17 <alltraps>

80106b63 <vector225>:
.globl vector225
vector225:
  pushl $0
80106b63:	6a 00                	push   $0x0
  pushl $225
80106b65:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106b6a:	e9 a8 f1 ff ff       	jmp    80105d17 <alltraps>

80106b6f <vector226>:
.globl vector226
vector226:
  pushl $0
80106b6f:	6a 00                	push   $0x0
  pushl $226
80106b71:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106b76:	e9 9c f1 ff ff       	jmp    80105d17 <alltraps>

80106b7b <vector227>:
.globl vector227
vector227:
  pushl $0
80106b7b:	6a 00                	push   $0x0
  pushl $227
80106b7d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106b82:	e9 90 f1 ff ff       	jmp    80105d17 <alltraps>

80106b87 <vector228>:
.globl vector228
vector228:
  pushl $0
80106b87:	6a 00                	push   $0x0
  pushl $228
80106b89:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106b8e:	e9 84 f1 ff ff       	jmp    80105d17 <alltraps>

80106b93 <vector229>:
.globl vector229
vector229:
  pushl $0
80106b93:	6a 00                	push   $0x0
  pushl $229
80106b95:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106b9a:	e9 78 f1 ff ff       	jmp    80105d17 <alltraps>

80106b9f <vector230>:
.globl vector230
vector230:
  pushl $0
80106b9f:	6a 00                	push   $0x0
  pushl $230
80106ba1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106ba6:	e9 6c f1 ff ff       	jmp    80105d17 <alltraps>

80106bab <vector231>:
.globl vector231
vector231:
  pushl $0
80106bab:	6a 00                	push   $0x0
  pushl $231
80106bad:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106bb2:	e9 60 f1 ff ff       	jmp    80105d17 <alltraps>

80106bb7 <vector232>:
.globl vector232
vector232:
  pushl $0
80106bb7:	6a 00                	push   $0x0
  pushl $232
80106bb9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106bbe:	e9 54 f1 ff ff       	jmp    80105d17 <alltraps>

80106bc3 <vector233>:
.globl vector233
vector233:
  pushl $0
80106bc3:	6a 00                	push   $0x0
  pushl $233
80106bc5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106bca:	e9 48 f1 ff ff       	jmp    80105d17 <alltraps>

80106bcf <vector234>:
.globl vector234
vector234:
  pushl $0
80106bcf:	6a 00                	push   $0x0
  pushl $234
80106bd1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106bd6:	e9 3c f1 ff ff       	jmp    80105d17 <alltraps>

80106bdb <vector235>:
.globl vector235
vector235:
  pushl $0
80106bdb:	6a 00                	push   $0x0
  pushl $235
80106bdd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106be2:	e9 30 f1 ff ff       	jmp    80105d17 <alltraps>

80106be7 <vector236>:
.globl vector236
vector236:
  pushl $0
80106be7:	6a 00                	push   $0x0
  pushl $236
80106be9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106bee:	e9 24 f1 ff ff       	jmp    80105d17 <alltraps>

80106bf3 <vector237>:
.globl vector237
vector237:
  pushl $0
80106bf3:	6a 00                	push   $0x0
  pushl $237
80106bf5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106bfa:	e9 18 f1 ff ff       	jmp    80105d17 <alltraps>

80106bff <vector238>:
.globl vector238
vector238:
  pushl $0
80106bff:	6a 00                	push   $0x0
  pushl $238
80106c01:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106c06:	e9 0c f1 ff ff       	jmp    80105d17 <alltraps>

80106c0b <vector239>:
.globl vector239
vector239:
  pushl $0
80106c0b:	6a 00                	push   $0x0
  pushl $239
80106c0d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106c12:	e9 00 f1 ff ff       	jmp    80105d17 <alltraps>

80106c17 <vector240>:
.globl vector240
vector240:
  pushl $0
80106c17:	6a 00                	push   $0x0
  pushl $240
80106c19:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106c1e:	e9 f4 f0 ff ff       	jmp    80105d17 <alltraps>

80106c23 <vector241>:
.globl vector241
vector241:
  pushl $0
80106c23:	6a 00                	push   $0x0
  pushl $241
80106c25:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106c2a:	e9 e8 f0 ff ff       	jmp    80105d17 <alltraps>

80106c2f <vector242>:
.globl vector242
vector242:
  pushl $0
80106c2f:	6a 00                	push   $0x0
  pushl $242
80106c31:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106c36:	e9 dc f0 ff ff       	jmp    80105d17 <alltraps>

80106c3b <vector243>:
.globl vector243
vector243:
  pushl $0
80106c3b:	6a 00                	push   $0x0
  pushl $243
80106c3d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106c42:	e9 d0 f0 ff ff       	jmp    80105d17 <alltraps>

80106c47 <vector244>:
.globl vector244
vector244:
  pushl $0
80106c47:	6a 00                	push   $0x0
  pushl $244
80106c49:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106c4e:	e9 c4 f0 ff ff       	jmp    80105d17 <alltraps>

80106c53 <vector245>:
.globl vector245
vector245:
  pushl $0
80106c53:	6a 00                	push   $0x0
  pushl $245
80106c55:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106c5a:	e9 b8 f0 ff ff       	jmp    80105d17 <alltraps>

80106c5f <vector246>:
.globl vector246
vector246:
  pushl $0
80106c5f:	6a 00                	push   $0x0
  pushl $246
80106c61:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106c66:	e9 ac f0 ff ff       	jmp    80105d17 <alltraps>

80106c6b <vector247>:
.globl vector247
vector247:
  pushl $0
80106c6b:	6a 00                	push   $0x0
  pushl $247
80106c6d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106c72:	e9 a0 f0 ff ff       	jmp    80105d17 <alltraps>

80106c77 <vector248>:
.globl vector248
vector248:
  pushl $0
80106c77:	6a 00                	push   $0x0
  pushl $248
80106c79:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106c7e:	e9 94 f0 ff ff       	jmp    80105d17 <alltraps>

80106c83 <vector249>:
.globl vector249
vector249:
  pushl $0
80106c83:	6a 00                	push   $0x0
  pushl $249
80106c85:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106c8a:	e9 88 f0 ff ff       	jmp    80105d17 <alltraps>

80106c8f <vector250>:
.globl vector250
vector250:
  pushl $0
80106c8f:	6a 00                	push   $0x0
  pushl $250
80106c91:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106c96:	e9 7c f0 ff ff       	jmp    80105d17 <alltraps>

80106c9b <vector251>:
.globl vector251
vector251:
  pushl $0
80106c9b:	6a 00                	push   $0x0
  pushl $251
80106c9d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106ca2:	e9 70 f0 ff ff       	jmp    80105d17 <alltraps>

80106ca7 <vector252>:
.globl vector252
vector252:
  pushl $0
80106ca7:	6a 00                	push   $0x0
  pushl $252
80106ca9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106cae:	e9 64 f0 ff ff       	jmp    80105d17 <alltraps>

80106cb3 <vector253>:
.globl vector253
vector253:
  pushl $0
80106cb3:	6a 00                	push   $0x0
  pushl $253
80106cb5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106cba:	e9 58 f0 ff ff       	jmp    80105d17 <alltraps>

80106cbf <vector254>:
.globl vector254
vector254:
  pushl $0
80106cbf:	6a 00                	push   $0x0
  pushl $254
80106cc1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106cc6:	e9 4c f0 ff ff       	jmp    80105d17 <alltraps>

80106ccb <vector255>:
.globl vector255
vector255:
  pushl $0
80106ccb:	6a 00                	push   $0x0
  pushl $255
80106ccd:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106cd2:	e9 40 f0 ff ff       	jmp    80105d17 <alltraps>
80106cd7:	66 90                	xchg   %ax,%ax
80106cd9:	66 90                	xchg   %ax,%ax
80106cdb:	66 90                	xchg   %ax,%ax
80106cdd:	66 90                	xchg   %ax,%ax
80106cdf:	90                   	nop

80106ce0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106ce0:	55                   	push   %ebp
80106ce1:	89 e5                	mov    %esp,%ebp
80106ce3:	83 ec 28             	sub    $0x28,%esp
80106ce6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106ce9:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106cef:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106cf5:	39 d3                	cmp    %edx,%ebx
80106cf7:	73 72                	jae    80106d6b <deallocuvm.part.0+0x8b>
80106cf9:	89 75 f8             	mov    %esi,-0x8(%ebp)
80106cfc:	89 c6                	mov    %eax,%esi
80106cfe:	89 7d fc             	mov    %edi,-0x4(%ebp)
80106d01:	89 d7                	mov    %edx,%edi
80106d03:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80106d06:	eb 22                	jmp    80106d2a <deallocuvm.part.0+0x4a>
80106d08:	eb 16                	jmp    80106d20 <deallocuvm.part.0+0x40>
80106d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d10:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106d17:	00 
80106d18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106d1f:	00 
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106d20:	8d 5a 01             	lea    0x1(%edx),%ebx
80106d23:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106d26:	39 fb                	cmp    %edi,%ebx
80106d28:	73 38                	jae    80106d62 <deallocuvm.part.0+0x82>
  pde = &pgdir[PDX(va)];
80106d2a:	89 da                	mov    %ebx,%edx
80106d2c:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80106d2f:	8b 04 96             	mov    (%esi,%edx,4),%eax
80106d32:	a8 01                	test   $0x1,%al
80106d34:	74 ea                	je     80106d20 <deallocuvm.part.0+0x40>
  return &pgtab[PTX(va)];
80106d36:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106d38:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106d3d:	c1 e9 0a             	shr    $0xa,%ecx
80106d40:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
80106d46:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
80106d4d:	85 c0                	test   %eax,%eax
80106d4f:	74 cf                	je     80106d20 <deallocuvm.part.0+0x40>
    else if((*pte & PTE_P) != 0){
80106d51:	8b 10                	mov    (%eax),%edx
80106d53:	f6 c2 01             	test   $0x1,%dl
80106d56:	75 20                	jne    80106d78 <deallocuvm.part.0+0x98>
  for(; a  < oldsz; a += PGSIZE){
80106d58:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d5e:	39 fb                	cmp    %edi,%ebx
80106d60:	72 c8                	jb     80106d2a <deallocuvm.part.0+0x4a>
80106d62:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80106d65:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106d68:	8b 7d fc             	mov    -0x4(%ebp),%edi
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106d6b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80106d6e:	89 c8                	mov    %ecx,%eax
80106d70:	c9                   	leave
80106d71:	c3                   	ret
80106d72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(pa == 0)
80106d78:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106d7e:	74 26                	je     80106da6 <deallocuvm.part.0+0xc6>
      kfree(v);
80106d80:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106d83:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106d89:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106d8c:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80106d92:	52                   	push   %edx
80106d93:	e8 a8 b8 ff ff       	call   80102640 <kfree>
      *pte = 0;
80106d98:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(; a  < oldsz; a += PGSIZE){
80106d9b:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80106d9e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80106da4:	eb 80                	jmp    80106d26 <deallocuvm.part.0+0x46>
        panic("kfree");
80106da6:	83 ec 0c             	sub    $0xc,%esp
80106da9:	68 2c 79 10 80       	push   $0x8010792c
80106dae:	e8 ed 95 ff ff       	call   801003a0 <panic>
80106db3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80106db8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106dbf:	00 

80106dc0 <mappages>:
{
80106dc0:	55                   	push   %ebp
80106dc1:	89 e5                	mov    %esp,%ebp
80106dc3:	57                   	push   %edi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106dc4:	8d 7c 0a ff          	lea    -0x1(%edx,%ecx,1),%edi
{
80106dc8:	56                   	push   %esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106dc9:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80106dcf:	89 c6                	mov    %eax,%esi
{
80106dd1:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106dd2:	89 d3                	mov    %edx,%ebx
80106dd4:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106dda:	83 ec 1c             	sub    $0x1c,%esp
80106ddd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106de0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106de3:	29 d9                	sub    %ebx,%ecx
80106de5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80106de8:	eb 42                	jmp    80106e2c <mappages+0x6c>
80106dea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106df0:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106df2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106df7:	c1 ea 0a             	shr    $0xa,%edx
80106dfa:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106e00:	8d 94 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%edx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106e07:	85 d2                	test   %edx,%edx
80106e09:	74 6d                	je     80106e78 <mappages+0xb8>
    if(*pte & PTE_P)
80106e0b:	f6 02 01             	testb  $0x1,(%edx)
80106e0e:	0f 85 7e 00 00 00    	jne    80106e92 <mappages+0xd2>
    *pte = pa | perm | PTE_P;
80106e14:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106e17:	01 d8                	add    %ebx,%eax
80106e19:	0b 45 0c             	or     0xc(%ebp),%eax
80106e1c:	83 c8 01             	or     $0x1,%eax
80106e1f:	89 02                	mov    %eax,(%edx)
    if(a == last)
80106e21:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
80106e24:	74 62                	je     80106e88 <mappages+0xc8>
    a += PGSIZE;
80106e26:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pde = &pgdir[PDX(va)];
80106e2c:	89 d8                	mov    %ebx,%eax
80106e2e:	c1 e8 16             	shr    $0x16,%eax
80106e31:	8d 3c 86             	lea    (%esi,%eax,4),%edi
  if(*pde & PTE_P){
80106e34:	8b 07                	mov    (%edi),%eax
80106e36:	a8 01                	test   $0x1,%al
80106e38:	75 b6                	jne    80106df0 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106e3a:	e8 e1 b9 ff ff       	call   80102820 <kalloc>
80106e3f:	85 c0                	test   %eax,%eax
80106e41:	74 35                	je     80106e78 <mappages+0xb8>
    memset(pgtab, 0, PGSIZE);
80106e43:	83 ec 04             	sub    $0x4,%esp
80106e46:	68 00 10 00 00       	push   $0x1000
80106e4b:	6a 00                	push   $0x0
80106e4d:	50                   	push   %eax
80106e4e:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106e51:	e8 aa db ff ff       	call   80104a00 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106e56:	8b 55 dc             	mov    -0x24(%ebp),%edx
  return &pgtab[PTX(va)];
80106e59:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106e5c:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80106e62:	83 c8 07             	or     $0x7,%eax
80106e65:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80106e67:	89 d8                	mov    %ebx,%eax
80106e69:	c1 e8 0a             	shr    $0xa,%eax
80106e6c:	25 fc 0f 00 00       	and    $0xffc,%eax
80106e71:	01 c2                	add    %eax,%edx
80106e73:	eb 96                	jmp    80106e0b <mappages+0x4b>
80106e75:	8d 76 00             	lea    0x0(%esi),%esi
}
80106e78:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106e7b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e80:	5b                   	pop    %ebx
80106e81:	5e                   	pop    %esi
80106e82:	5f                   	pop    %edi
80106e83:	5d                   	pop    %ebp
80106e84:	c3                   	ret
80106e85:	8d 76 00             	lea    0x0(%esi),%esi
80106e88:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106e8b:	31 c0                	xor    %eax,%eax
}
80106e8d:	5b                   	pop    %ebx
80106e8e:	5e                   	pop    %esi
80106e8f:	5f                   	pop    %edi
80106e90:	5d                   	pop    %ebp
80106e91:	c3                   	ret
      panic("remap");
80106e92:	83 ec 0c             	sub    $0xc,%esp
80106e95:	68 60 7b 10 80       	push   $0x80107b60
80106e9a:	e8 01 95 ff ff       	call   801003a0 <panic>
80106e9f:	90                   	nop

80106ea0 <seginit>:
{
80106ea0:	55                   	push   %ebp
80106ea1:	89 e5                	mov    %esp,%ebp
80106ea3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106ea6:	e8 55 cd ff ff       	call   80103c00 <cpuid>
  pd[0] = size-1;
80106eab:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106eb0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106eb6:	c7 80 18 28 11 80 ff 	movl   $0xffff,-0x7feed7e8(%eax)
80106ebd:	ff 00 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106ec0:	c7 80 20 28 11 80 ff 	movl   $0xffff,-0x7feed7e0(%eax)
80106ec7:	ff 00 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106eca:	c7 80 28 28 11 80 ff 	movl   $0xffff,-0x7feed7d8(%eax)
80106ed1:	ff 00 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106ed4:	c7 80 30 28 11 80 ff 	movl   $0xffff,-0x7feed7d0(%eax)
80106edb:	ff 00 00 
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106ede:	c7 80 1c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7e4(%eax)
80106ee5:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106ee8:	c7 80 24 28 11 80 00 	movl   $0xcf9200,-0x7feed7dc(%eax)
80106eef:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106ef2:	c7 80 2c 28 11 80 00 	movl   $0xcffa00,-0x7feed7d4(%eax)
80106ef9:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106efc:	c7 80 34 28 11 80 00 	movl   $0xcff200,-0x7feed7cc(%eax)
80106f03:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106f06:	05 10 28 11 80       	add    $0x80112810,%eax
80106f0b:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
80106f0f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106f13:	c1 e8 10             	shr    $0x10,%eax
80106f16:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106f1a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106f1d:	0f 01 10             	lgdtl  (%eax)
}
80106f20:	c9                   	leave
80106f21:	c3                   	ret
80106f22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106f28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106f2f:	00 

80106f30 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106f30:	a1 c4 54 11 80       	mov    0x801154c4,%eax
80106f35:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106f3a:	0f 22 d8             	mov    %eax,%cr3
}
80106f3d:	c3                   	ret
80106f3e:	66 90                	xchg   %ax,%ax

80106f40 <switchuvm>:
{
80106f40:	55                   	push   %ebp
80106f41:	89 e5                	mov    %esp,%ebp
80106f43:	57                   	push   %edi
80106f44:	56                   	push   %esi
80106f45:	53                   	push   %ebx
80106f46:	83 ec 1c             	sub    $0x1c,%esp
80106f49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80106f4c:	85 db                	test   %ebx,%ebx
80106f4e:	0f 84 c9 00 00 00    	je     8010701d <switchuvm+0xdd>
  if(p->kstack == 0)
80106f54:	8b 43 08             	mov    0x8(%ebx),%eax
80106f57:	85 c0                	test   %eax,%eax
80106f59:	0f 84 d8 00 00 00    	je     80107037 <switchuvm+0xf7>
  if(p->pgdir == 0)
80106f5f:	8b 43 04             	mov    0x4(%ebx),%eax
80106f62:	85 c0                	test   %eax,%eax
80106f64:	0f 84 c0 00 00 00    	je     8010702a <switchuvm+0xea>
  pushcli();
80106f6a:	e8 11 d8 ff ff       	call   80104780 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106f6f:	e8 0c cc ff ff       	call   80103b80 <mycpu>
80106f74:	89 c6                	mov    %eax,%esi
80106f76:	e8 05 cc ff ff       	call   80103b80 <mycpu>
80106f7b:	8d 78 08             	lea    0x8(%eax),%edi
80106f7e:	e8 fd cb ff ff       	call   80103b80 <mycpu>
80106f83:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106f86:	e8 f5 cb ff ff       	call   80103b80 <mycpu>
80106f8b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106f8e:	ba 67 00 00 00       	mov    $0x67,%edx
80106f93:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106f9a:	83 c0 08             	add    $0x8,%eax
80106f9d:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106fa4:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106fa9:	83 c1 08             	add    $0x8,%ecx
80106fac:	c1 e8 18             	shr    $0x18,%eax
80106faf:	c1 e9 10             	shr    $0x10,%ecx
80106fb2:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
80106fb8:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106fbe:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106fc3:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106fca:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80106fcf:	e8 ac cb ff ff       	call   80103b80 <mycpu>
80106fd4:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106fdb:	e8 a0 cb ff ff       	call   80103b80 <mycpu>
80106fe0:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106fe4:	8b 73 08             	mov    0x8(%ebx),%esi
80106fe7:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106fed:	e8 8e cb ff ff       	call   80103b80 <mycpu>
80106ff2:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106ff5:	e8 86 cb ff ff       	call   80103b80 <mycpu>
80106ffa:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106ffe:	b8 28 00 00 00       	mov    $0x28,%eax
80107003:	0f 00 d8             	ltr    %eax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107006:	8b 43 04             	mov    0x4(%ebx),%eax
80107009:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010700e:	0f 22 d8             	mov    %eax,%cr3
}
80107011:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107014:	5b                   	pop    %ebx
80107015:	5e                   	pop    %esi
80107016:	5f                   	pop    %edi
80107017:	5d                   	pop    %ebp
  popcli();
80107018:	e9 b3 d7 ff ff       	jmp    801047d0 <popcli>
    panic("switchuvm: no process");
8010701d:	83 ec 0c             	sub    $0xc,%esp
80107020:	68 66 7b 10 80       	push   $0x80107b66
80107025:	e8 76 93 ff ff       	call   801003a0 <panic>
    panic("switchuvm: no pgdir");
8010702a:	83 ec 0c             	sub    $0xc,%esp
8010702d:	68 91 7b 10 80       	push   $0x80107b91
80107032:	e8 69 93 ff ff       	call   801003a0 <panic>
    panic("switchuvm: no kstack");
80107037:	83 ec 0c             	sub    $0xc,%esp
8010703a:	68 7c 7b 10 80       	push   $0x80107b7c
8010703f:	e8 5c 93 ff ff       	call   801003a0 <panic>
80107044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107048:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010704f:	00 

80107050 <inituvm>:
{
80107050:	55                   	push   %ebp
80107051:	89 e5                	mov    %esp,%ebp
80107053:	57                   	push   %edi
80107054:	56                   	push   %esi
80107055:	53                   	push   %ebx
80107056:	83 ec 1c             	sub    $0x1c,%esp
80107059:	8b 45 08             	mov    0x8(%ebp),%eax
8010705c:	8b 75 10             	mov    0x10(%ebp),%esi
8010705f:	8b 7d 0c             	mov    0xc(%ebp),%edi
80107062:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107065:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010706b:	77 49                	ja     801070b6 <inituvm+0x66>
  mem = kalloc();
8010706d:	e8 ae b7 ff ff       	call   80102820 <kalloc>
  memset(mem, 0, PGSIZE);
80107072:	83 ec 04             	sub    $0x4,%esp
80107075:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010707a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
8010707c:	6a 00                	push   $0x0
8010707e:	50                   	push   %eax
8010707f:	e8 7c d9 ff ff       	call   80104a00 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107084:	58                   	pop    %eax
80107085:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010708b:	5a                   	pop    %edx
8010708c:	6a 06                	push   $0x6
8010708e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107093:	31 d2                	xor    %edx,%edx
80107095:	50                   	push   %eax
80107096:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107099:	e8 22 fd ff ff       	call   80106dc0 <mappages>
  memmove(mem, init, sz);
8010709e:	83 c4 10             	add    $0x10,%esp
801070a1:	89 75 10             	mov    %esi,0x10(%ebp)
801070a4:	89 7d 0c             	mov    %edi,0xc(%ebp)
801070a7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801070aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070ad:	5b                   	pop    %ebx
801070ae:	5e                   	pop    %esi
801070af:	5f                   	pop    %edi
801070b0:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801070b1:	e9 ea d9 ff ff       	jmp    80104aa0 <memmove>
    panic("inituvm: more than a page");
801070b6:	83 ec 0c             	sub    $0xc,%esp
801070b9:	68 a5 7b 10 80       	push   $0x80107ba5
801070be:	e8 dd 92 ff ff       	call   801003a0 <panic>
801070c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801070c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801070cf:	00 

801070d0 <loaduvm>:
{
801070d0:	55                   	push   %ebp
801070d1:	89 e5                	mov    %esp,%ebp
801070d3:	83 ec 18             	sub    $0x18,%esp
801070d6:	89 75 f8             	mov    %esi,-0x8(%ebp)
  if((uint) addr % PGSIZE != 0)
801070d9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
801070dc:	89 7d fc             	mov    %edi,-0x4(%ebp)
801070df:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
801070e2:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
801070e8:	0f 85 b2 00 00 00    	jne    801071a0 <loaduvm+0xd0>
  for(i = 0; i < sz; i += PGSIZE){
801070ee:	85 ff                	test   %edi,%edi
801070f0:	0f 84 89 00 00 00    	je     8010717f <loaduvm+0xaf>
801070f6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801070f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
80107100:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107103:	8b 55 08             	mov    0x8(%ebp),%edx
80107106:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
80107108:	89 c1                	mov    %eax,%ecx
8010710a:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010710d:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
80107110:	f6 c1 01             	test   $0x1,%cl
80107113:	75 13                	jne    80107128 <loaduvm+0x58>
      panic("loaduvm: address should exist");
80107115:	83 ec 0c             	sub    $0xc,%esp
80107118:	68 bf 7b 10 80       	push   $0x80107bbf
8010711d:	e8 7e 92 ff ff       	call   801003a0 <panic>
80107122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107128:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010712b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107131:	25 fc 0f 00 00       	and    $0xffc,%eax
80107136:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010713d:	85 c9                	test   %ecx,%ecx
8010713f:	74 d4                	je     80107115 <loaduvm+0x45>
    if(sz - i < PGSIZE)
80107141:	89 fb                	mov    %edi,%ebx
80107143:	b8 00 10 00 00       	mov    $0x1000,%eax
80107148:	29 f3                	sub    %esi,%ebx
8010714a:	39 c3                	cmp    %eax,%ebx
8010714c:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010714f:	8b 45 14             	mov    0x14(%ebp),%eax
80107152:	01 f0                	add    %esi,%eax
80107154:	53                   	push   %ebx
80107155:	50                   	push   %eax
    pa = PTE_ADDR(*pte);
80107156:	8b 01                	mov    (%ecx),%eax
80107158:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010715d:	05 00 00 00 80       	add    $0x80000000,%eax
80107162:	50                   	push   %eax
80107163:	ff 75 10             	push   0x10(%ebp)
80107166:	e8 25 aa ff ff       	call   80101b90 <readi>
8010716b:	83 c4 10             	add    $0x10,%esp
8010716e:	39 d8                	cmp    %ebx,%eax
80107170:	75 1e                	jne    80107190 <loaduvm+0xc0>
  for(i = 0; i < sz; i += PGSIZE){
80107172:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107178:	39 fe                	cmp    %edi,%esi
8010717a:	72 84                	jb     80107100 <loaduvm+0x30>
8010717c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
}
8010717f:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107182:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return 0;
80107185:	31 c0                	xor    %eax,%eax
}
80107187:	c9                   	leave
80107188:	c3                   	ret
80107189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80107190:	8b 5d f4             	mov    -0xc(%ebp),%ebx
}
80107193:	8b 75 f8             	mov    -0x8(%ebp),%esi
      return -1;
80107196:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010719b:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010719e:	c9                   	leave
8010719f:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
801071a0:	83 ec 0c             	sub    $0xc,%esp
801071a3:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801071a6:	68 c0 7d 10 80       	push   $0x80107dc0
801071ab:	e8 f0 91 ff ff       	call   801003a0 <panic>

801071b0 <allocuvm>:
{
801071b0:	55                   	push   %ebp
801071b1:	89 e5                	mov    %esp,%ebp
801071b3:	83 ec 28             	sub    $0x28,%esp
801071b6:	89 75 f8             	mov    %esi,-0x8(%ebp)
801071b9:	8b 75 10             	mov    0x10(%ebp),%esi
  if(newsz >= KERNBASE)
801071bc:	85 f6                	test   %esi,%esi
801071be:	0f 88 ac 00 00 00    	js     80107270 <allocuvm+0xc0>
801071c4:	89 f2                	mov    %esi,%edx
  if(newsz < oldsz)
801071c6:	3b 75 0c             	cmp    0xc(%ebp),%esi
801071c9:	0f 82 b1 00 00 00    	jb     80107280 <allocuvm+0xd0>
  a = PGROUNDUP(oldsz);
801071cf:	8b 45 0c             	mov    0xc(%ebp),%eax
801071d2:	89 7d fc             	mov    %edi,-0x4(%ebp)
801071d5:	05 ff 0f 00 00       	add    $0xfff,%eax
801071da:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801071df:	89 c7                	mov    %eax,%edi
  for(; a < newsz; a += PGSIZE){
801071e1:	39 f0                	cmp    %esi,%eax
801071e3:	0f 83 ff 00 00 00    	jae    801072e8 <allocuvm+0x138>
801071e9:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801071ec:	89 75 e4             	mov    %esi,-0x1c(%ebp)
801071ef:	eb 47                	jmp    80107238 <allocuvm+0x88>
801071f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
801071f8:	83 ec 04             	sub    $0x4,%esp
801071fb:	68 00 10 00 00       	push   $0x1000
80107200:	6a 00                	push   $0x0
80107202:	50                   	push   %eax
80107203:	e8 f8 d7 ff ff       	call   80104a00 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107208:	58                   	pop    %eax
80107209:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010720f:	5a                   	pop    %edx
80107210:	6a 06                	push   $0x6
80107212:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107217:	89 fa                	mov    %edi,%edx
80107219:	50                   	push   %eax
8010721a:	8b 45 08             	mov    0x8(%ebp),%eax
8010721d:	e8 9e fb ff ff       	call   80106dc0 <mappages>
80107222:	83 c4 10             	add    $0x10,%esp
80107225:	83 f8 ff             	cmp    $0xffffffff,%eax
80107228:	74 66                	je     80107290 <allocuvm+0xe0>
  for(; a < newsz; a += PGSIZE){
8010722a:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107230:	39 f7                	cmp    %esi,%edi
80107232:	0f 83 98 00 00 00    	jae    801072d0 <allocuvm+0x120>
    mem = kalloc();
80107238:	e8 e3 b5 ff ff       	call   80102820 <kalloc>
8010723d:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
8010723f:	85 c0                	test   %eax,%eax
80107241:	75 b5                	jne    801071f8 <allocuvm+0x48>
      cprintf("allocuvm out of memory\n");
80107243:	83 ec 0c             	sub    $0xc,%esp
80107246:	68 dd 7b 10 80       	push   $0x80107bdd
8010724b:	e8 a0 94 ff ff       	call   801006f0 <cprintf>
  if(newsz >= oldsz)
80107250:	83 c4 10             	add    $0x10,%esp
80107253:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107256:	0f 84 84 00 00 00    	je     801072e0 <allocuvm+0x130>
  a = PGROUNDUP(newsz);
8010725c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010725f:	8b 45 08             	mov    0x8(%ebp),%eax
80107262:	89 f2                	mov    %esi,%edx
80107264:	e8 77 fa ff ff       	call   80106ce0 <deallocuvm.part.0>
80107269:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010726c:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010726f:	90                   	nop
    return 0;
80107270:	31 d2                	xor    %edx,%edx
}
80107272:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107275:	89 d0                	mov    %edx,%eax
80107277:	c9                   	leave
80107278:	c3                   	ret
80107279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107280:	8b 55 0c             	mov    0xc(%ebp),%edx
}
80107283:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107286:	c9                   	leave
80107287:	89 d0                	mov    %edx,%eax
80107289:	c3                   	ret
8010728a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107290:	83 ec 0c             	sub    $0xc,%esp
80107293:	68 f5 7b 10 80       	push   $0x80107bf5
80107298:	e8 53 94 ff ff       	call   801006f0 <cprintf>
  if(newsz >= oldsz)
8010729d:	83 c4 10             	add    $0x10,%esp
801072a0:	3b 75 0c             	cmp    0xc(%ebp),%esi
801072a3:	74 0d                	je     801072b2 <allocuvm+0x102>
  a = PGROUNDUP(newsz);
801072a5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801072a8:	8b 45 08             	mov    0x8(%ebp),%eax
801072ab:	89 f2                	mov    %esi,%edx
801072ad:	e8 2e fa ff ff       	call   80106ce0 <deallocuvm.part.0>
      kfree(mem);
801072b2:	83 ec 0c             	sub    $0xc,%esp
801072b5:	53                   	push   %ebx
801072b6:	e8 85 b3 ff ff       	call   80102640 <kfree>
      return 0;
801072bb:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801072be:	8b 7d fc             	mov    -0x4(%ebp),%edi
801072c1:	83 c4 10             	add    $0x10,%esp
801072c4:	eb aa                	jmp    80107270 <allocuvm+0xc0>
801072c6:	66 90                	xchg   %ax,%ax
801072c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801072cf:	00 
801072d0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801072d3:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801072d6:	8b 7d fc             	mov    -0x4(%ebp),%edi
}
801072d9:	8b 75 f8             	mov    -0x8(%ebp),%esi
801072dc:	c9                   	leave
801072dd:	89 d0                	mov    %edx,%eax
801072df:	c3                   	ret
801072e0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801072e3:	8b 7d fc             	mov    -0x4(%ebp),%edi
801072e6:	eb 88                	jmp    80107270 <allocuvm+0xc0>
801072e8:	8b 7d fc             	mov    -0x4(%ebp),%edi
801072eb:	eb 85                	jmp    80107272 <allocuvm+0xc2>
801072ed:	8d 76 00             	lea    0x0(%esi),%esi

801072f0 <deallocuvm>:
{
801072f0:	55                   	push   %ebp
801072f1:	89 e5                	mov    %esp,%ebp
801072f3:	8b 55 0c             	mov    0xc(%ebp),%edx
801072f6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801072f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801072fc:	39 d1                	cmp    %edx,%ecx
801072fe:	73 10                	jae    80107310 <deallocuvm+0x20>
}
80107300:	5d                   	pop    %ebp
80107301:	e9 da f9 ff ff       	jmp    80106ce0 <deallocuvm.part.0>
80107306:	66 90                	xchg   %ax,%ax
80107308:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010730f:	00 
80107310:	89 d0                	mov    %edx,%eax
80107312:	5d                   	pop    %ebp
80107313:	c3                   	ret
80107314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107318:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010731f:	00 

80107320 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107320:	55                   	push   %ebp
80107321:	89 e5                	mov    %esp,%ebp
80107323:	57                   	push   %edi
80107324:	56                   	push   %esi
80107325:	53                   	push   %ebx
80107326:	83 ec 0c             	sub    $0xc,%esp
80107329:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010732c:	85 f6                	test   %esi,%esi
8010732e:	74 59                	je     80107389 <freevm+0x69>
  a = PGROUNDUP(newsz);
80107330:	31 c9                	xor    %ecx,%ecx
80107332:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107337:	89 f0                	mov    %esi,%eax
80107339:	89 f3                	mov    %esi,%ebx
8010733b:	e8 a0 f9 ff ff       	call   80106ce0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107340:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107346:	eb 0f                	jmp    80107357 <freevm+0x37>
80107348:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010734f:	00 
80107350:	83 c3 04             	add    $0x4,%ebx
80107353:	39 fb                	cmp    %edi,%ebx
80107355:	74 23                	je     8010737a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107357:	8b 03                	mov    (%ebx),%eax
80107359:	a8 01                	test   $0x1,%al
8010735b:	74 f3                	je     80107350 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010735d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107362:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107365:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107368:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010736d:	50                   	push   %eax
8010736e:	e8 cd b2 ff ff       	call   80102640 <kfree>
80107373:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107376:	39 fb                	cmp    %edi,%ebx
80107378:	75 dd                	jne    80107357 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010737a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010737d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107380:	5b                   	pop    %ebx
80107381:	5e                   	pop    %esi
80107382:	5f                   	pop    %edi
80107383:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107384:	e9 b7 b2 ff ff       	jmp    80102640 <kfree>
    panic("freevm: no pgdir");
80107389:	83 ec 0c             	sub    $0xc,%esp
8010738c:	68 11 7c 10 80       	push   $0x80107c11
80107391:	e8 0a 90 ff ff       	call   801003a0 <panic>
80107396:	66 90                	xchg   %ax,%ax
80107398:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010739f:	00 

801073a0 <setupkvm>:
{
801073a0:	55                   	push   %ebp
801073a1:	89 e5                	mov    %esp,%ebp
801073a3:	83 ec 08             	sub    $0x8,%esp
801073a6:	89 75 fc             	mov    %esi,-0x4(%ebp)
  if((pgdir = (pde_t*)kalloc()) == 0)
801073a9:	e8 72 b4 ff ff       	call   80102820 <kalloc>
801073ae:	89 c6                	mov    %eax,%esi
801073b0:	85 c0                	test   %eax,%eax
801073b2:	74 49                	je     801073fd <setupkvm+0x5d>
  memset(pgdir, 0, PGSIZE);
801073b4:	83 ec 04             	sub    $0x4,%esp
801073b7:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801073ba:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
801073bf:	68 00 10 00 00       	push   $0x1000
801073c4:	6a 00                	push   $0x0
801073c6:	50                   	push   %eax
801073c7:	e8 34 d6 ff ff       	call   80104a00 <memset>
801073cc:	83 c4 10             	add    $0x10,%esp
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801073cf:	8b 43 04             	mov    0x4(%ebx),%eax
801073d2:	83 ec 08             	sub    $0x8,%esp
801073d5:	8b 4b 08             	mov    0x8(%ebx),%ecx
801073d8:	8b 13                	mov    (%ebx),%edx
801073da:	ff 73 0c             	push   0xc(%ebx)
801073dd:	50                   	push   %eax
801073de:	29 c1                	sub    %eax,%ecx
801073e0:	89 f0                	mov    %esi,%eax
801073e2:	e8 d9 f9 ff ff       	call   80106dc0 <mappages>
801073e7:	83 c4 10             	add    $0x10,%esp
801073ea:	83 f8 ff             	cmp    $0xffffffff,%eax
801073ed:	74 19                	je     80107408 <setupkvm+0x68>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801073ef:	83 c3 10             	add    $0x10,%ebx
801073f2:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
801073f8:	75 d5                	jne    801073cf <setupkvm+0x2f>
801073fa:	8b 5d f8             	mov    -0x8(%ebp),%ebx
}
801073fd:	89 f0                	mov    %esi,%eax
801073ff:	8b 75 fc             	mov    -0x4(%ebp),%esi
80107402:	c9                   	leave
80107403:	c3                   	ret
80107404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107408:	83 ec 0c             	sub    $0xc,%esp
8010740b:	56                   	push   %esi
    return 0;
8010740c:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
8010740e:	e8 0d ff ff ff       	call   80107320 <freevm>
}
80107413:	89 f0                	mov    %esi,%eax
      return 0;
80107415:	8b 5d f8             	mov    -0x8(%ebp),%ebx
}
80107418:	8b 75 fc             	mov    -0x4(%ebp),%esi
      return 0;
8010741b:	83 c4 10             	add    $0x10,%esp
}
8010741e:	c9                   	leave
8010741f:	c3                   	ret

80107420 <kvmalloc>:
{
80107420:	55                   	push   %ebp
80107421:	89 e5                	mov    %esp,%ebp
80107423:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107426:	e8 75 ff ff ff       	call   801073a0 <setupkvm>
8010742b:	a3 c4 54 11 80       	mov    %eax,0x801154c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107430:	05 00 00 00 80       	add    $0x80000000,%eax
80107435:	0f 22 d8             	mov    %eax,%cr3
}
80107438:	c9                   	leave
80107439:	c3                   	ret
8010743a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107440 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107440:	55                   	push   %ebp
80107441:	89 e5                	mov    %esp,%ebp
80107443:	83 ec 08             	sub    $0x8,%esp
80107446:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107449:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
8010744c:	89 c1                	mov    %eax,%ecx
8010744e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107451:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107454:	f6 c2 01             	test   $0x1,%dl
80107457:	75 17                	jne    80107470 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107459:	83 ec 0c             	sub    $0xc,%esp
8010745c:	68 22 7c 10 80       	push   $0x80107c22
80107461:	e8 3a 8f ff ff       	call   801003a0 <panic>
80107466:	66 90                	xchg   %ax,%ax
80107468:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010746f:	00 
  return &pgtab[PTX(va)];
80107470:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107473:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107479:	25 fc 0f 00 00       	and    $0xffc,%eax
8010747e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107485:	85 c0                	test   %eax,%eax
80107487:	74 d0                	je     80107459 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107489:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010748c:	c9                   	leave
8010748d:	c3                   	ret
8010748e:	66 90                	xchg   %ax,%ax

80107490 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107490:	55                   	push   %ebp
80107491:	89 e5                	mov    %esp,%ebp
80107493:	83 ec 28             	sub    $0x28,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107496:	e8 05 ff ff ff       	call   801073a0 <setupkvm>
8010749b:	89 c2                	mov    %eax,%edx
8010749d:	85 c0                	test   %eax,%eax
8010749f:	0f 84 cc 00 00 00    	je     80107571 <copyuvm+0xe1>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801074a5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801074a8:	85 c9                	test   %ecx,%ecx
801074aa:	0f 84 c1 00 00 00    	je     80107571 <copyuvm+0xe1>
801074b0:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801074b3:	89 75 f8             	mov    %esi,-0x8(%ebp)
801074b6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801074b9:	89 7d fc             	mov    %edi,-0x4(%ebp)
801074bc:	31 ff                	xor    %edi,%edi
801074be:	66 90                	xchg   %ax,%ax
  if(*pde & PTE_P){
801074c0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
801074c3:	89 f8                	mov    %edi,%eax
801074c5:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
801074c8:	8b 04 81             	mov    (%ecx,%eax,4),%eax
801074cb:	a8 01                	test   $0x1,%al
801074cd:	75 11                	jne    801074e0 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801074cf:	83 ec 0c             	sub    $0xc,%esp
801074d2:	68 2c 7c 10 80       	push   $0x80107c2c
801074d7:	e8 c4 8e ff ff       	call   801003a0 <panic>
801074dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
801074e0:	89 fa                	mov    %edi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801074e2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801074e7:	c1 ea 0a             	shr    $0xa,%edx
801074ea:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801074f0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801074f7:	85 c0                	test   %eax,%eax
801074f9:	74 d4                	je     801074cf <copyuvm+0x3f>
    if(!(*pte & PTE_P))
801074fb:	8b 30                	mov    (%eax),%esi
801074fd:	f7 c6 01 00 00 00    	test   $0x1,%esi
80107503:	0f 84 a8 00 00 00    	je     801075b1 <copyuvm+0x121>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
80107509:	e8 12 b3 ff ff       	call   80102820 <kalloc>
8010750e:	89 c3                	mov    %eax,%ebx
80107510:	85 c0                	test   %eax,%eax
80107512:	74 64                	je     80107578 <copyuvm+0xe8>
    pa = PTE_ADDR(*pte);
80107514:	89 f0                	mov    %esi,%eax
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107516:	83 ec 04             	sub    $0x4,%esp
    flags = PTE_FLAGS(*pte);
80107519:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
    pa = PTE_ADDR(*pte);
8010751f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107524:	68 00 10 00 00       	push   $0x1000
80107529:	05 00 00 00 80       	add    $0x80000000,%eax
8010752e:	50                   	push   %eax
8010752f:	53                   	push   %ebx
80107530:	e8 6b d5 ff ff       	call   80104aa0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107535:	58                   	pop    %eax
80107536:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010753c:	5a                   	pop    %edx
8010753d:	56                   	push   %esi
8010753e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107543:	89 fa                	mov    %edi,%edx
80107545:	50                   	push   %eax
80107546:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107549:	e8 72 f8 ff ff       	call   80106dc0 <mappages>
8010754e:	83 c4 10             	add    $0x10,%esp
80107551:	83 f8 ff             	cmp    $0xffffffff,%eax
80107554:	74 4a                	je     801075a0 <copyuvm+0x110>
  for(i = 0; i < sz; i += PGSIZE){
80107556:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010755c:	3b 7d 0c             	cmp    0xc(%ebp),%edi
8010755f:	0f 82 5b ff ff ff    	jb     801074c0 <copyuvm+0x30>
80107565:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107568:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010756b:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010756e:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return d;

bad:
  freevm(d);
  return 0;
}
80107571:	c9                   	leave
80107572:	89 d0                	mov    %edx,%eax
80107574:	c3                   	ret
80107575:	8d 76 00             	lea    0x0(%esi),%esi
80107578:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  freevm(d);
8010757b:	83 ec 0c             	sub    $0xc,%esp
8010757e:	52                   	push   %edx
8010757f:	e8 9c fd ff ff       	call   80107320 <freevm>
    return 0;
80107584:	31 d2                	xor    %edx,%edx
80107586:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107589:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010758c:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return 0;
8010758f:	83 c4 10             	add    $0x10,%esp
}
80107592:	89 d0                	mov    %edx,%eax
80107594:	c9                   	leave
80107595:	c3                   	ret
80107596:	66 90                	xchg   %ax,%ax
80107598:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010759f:	00 
      kfree(mem);
801075a0:	83 ec 0c             	sub    $0xc,%esp
801075a3:	53                   	push   %ebx
801075a4:	e8 97 b0 ff ff       	call   80102640 <kfree>
      goto bad;
801075a9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801075ac:	83 c4 10             	add    $0x10,%esp
801075af:	eb ca                	jmp    8010757b <copyuvm+0xeb>
      panic("copyuvm: page not present");
801075b1:	83 ec 0c             	sub    $0xc,%esp
801075b4:	68 46 7c 10 80       	push   $0x80107c46
801075b9:	e8 e2 8d ff ff       	call   801003a0 <panic>
801075be:	66 90                	xchg   %ax,%ax

801075c0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801075c0:	55                   	push   %ebp
801075c1:	89 e5                	mov    %esp,%ebp
801075c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801075c6:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801075c9:	89 c1                	mov    %eax,%ecx
801075cb:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801075ce:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801075d1:	f6 c2 01             	test   $0x1,%dl
801075d4:	0f 84 5b 01 00 00    	je     80107735 <uva2ka.cold>
  return &pgtab[PTX(va)];
801075da:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801075dd:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801075e3:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
801075e4:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
801075e9:	8b 94 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%edx
  return (char*)P2V(PTE_ADDR(*pte));
801075f0:	89 d0                	mov    %edx,%eax
801075f2:	f7 d2                	not    %edx
801075f4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801075f9:	05 00 00 00 80       	add    $0x80000000,%eax
801075fe:	83 e2 05             	and    $0x5,%edx
80107601:	ba 00 00 00 00       	mov    $0x0,%edx
80107606:	0f 45 c2             	cmovne %edx,%eax
}
80107609:	c3                   	ret
8010760a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107610 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107610:	55                   	push   %ebp
80107611:	89 e5                	mov    %esp,%ebp
80107613:	83 ec 18             	sub    $0x18,%esp
80107616:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107619:	8b 55 10             	mov    0x10(%ebp),%edx
8010761c:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010761f:	8b 7d 14             	mov    0x14(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107622:	85 ff                	test   %edi,%edi
80107624:	0f 84 a4 00 00 00    	je     801076ce <copyout+0xbe>
8010762a:	89 5d f4             	mov    %ebx,-0xc(%ebp)
8010762d:	89 75 f8             	mov    %esi,-0x8(%ebp)
80107630:	eb 47                	jmp    80107679 <copyout+0x69>
80107632:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return (char*)P2V(PTE_ADDR(*pte));
80107638:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
8010763d:	05 00 00 00 80       	add    $0x80000000,%eax
80107642:	74 6f                	je     801076b3 <copyout+0xa3>
      return -1;
    n = PGSIZE - (va - va0);
80107644:	8d 9e 00 10 00 00    	lea    0x1000(%esi),%ebx
8010764a:	29 cb                	sub    %ecx,%ebx
    if(n > len)
8010764c:	39 fb                	cmp    %edi,%ebx
8010764e:	0f 47 df             	cmova  %edi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107651:	81 e1 ff 0f 00 00    	and    $0xfff,%ecx
80107657:	83 ec 04             	sub    $0x4,%esp
8010765a:	01 c8                	add    %ecx,%eax
8010765c:	53                   	push   %ebx
8010765d:	52                   	push   %edx
8010765e:	50                   	push   %eax
8010765f:	89 55 10             	mov    %edx,0x10(%ebp)
80107662:	e8 39 d4 ff ff       	call   80104aa0 <memmove>
    len -= n;
    buf += n;
80107667:	8b 55 10             	mov    0x10(%ebp),%edx
  while(len > 0){
8010766a:	83 c4 10             	add    $0x10,%esp
    buf += n;
8010766d:	01 da                	add    %ebx,%edx
  while(len > 0){
8010766f:	29 df                	sub    %ebx,%edi
80107671:	74 55                	je     801076c8 <copyout+0xb8>
80107673:	8d 8e 00 10 00 00    	lea    0x1000(%esi),%ecx
  if(*pde & PTE_P){
80107679:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
8010767c:	89 c8                	mov    %ecx,%eax
    va0 = (uint)PGROUNDDOWN(va);
8010767e:	89 ce                	mov    %ecx,%esi
  pde = &pgdir[PDX(va)];
80107680:	c1 e8 16             	shr    $0x16,%eax
    va0 = (uint)PGROUNDDOWN(va);
80107683:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if(*pde & PTE_P){
80107689:	8b 04 83             	mov    (%ebx,%eax,4),%eax
8010768c:	a8 01                	test   $0x1,%al
8010768e:	0f 84 a8 00 00 00    	je     8010773c <copyout.cold>
  return &pgtab[PTX(va)];
80107694:	89 f3                	mov    %esi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107696:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
8010769b:	c1 eb 0c             	shr    $0xc,%ebx
8010769e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
801076a4:	8b 84 98 00 00 00 80 	mov    -0x80000000(%eax,%ebx,4),%eax
801076ab:	a8 01                	test   $0x1,%al
801076ad:	74 04                	je     801076b3 <copyout+0xa3>
  if((*pte & PTE_U) == 0)
801076af:	a8 04                	test   $0x4,%al
801076b1:	75 85                	jne    80107638 <copyout+0x28>
801076b3:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801076b6:	8b 75 f8             	mov    -0x8(%ebp),%esi
      return -1;
801076b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    va = va0 + PGSIZE;
  }
  return 0;
}
801076be:	8b 7d fc             	mov    -0x4(%ebp),%edi
801076c1:	c9                   	leave
801076c2:	c3                   	ret
801076c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801076c8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801076cb:	8b 75 f8             	mov    -0x8(%ebp),%esi
801076ce:	8b 7d fc             	mov    -0x4(%ebp),%edi
  return 0;
801076d1:	31 c0                	xor    %eax,%eax
}
801076d3:	c9                   	leave
801076d4:	c3                   	ret
801076d5:	8d 76 00             	lea    0x0(%esi),%esi
801076d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801076df:	00 

801076e0 <va2pa_walk>:
// address (frame address + offset inside the page).
// Returns -1 if the page is not present or not accessible from user mode.
// (walkpgdir() is static, so this helper lives in vm.c.)
int
va2pa_walk(pde_t *pgdir, uint va)
{
801076e0:	55                   	push   %ebp
801076e1:	89 e5                	mov    %esp,%ebp
801076e3:	8b 55 0c             	mov    0xc(%ebp),%edx
  if(*pde & PTE_P){
801076e6:	8b 45 08             	mov    0x8(%ebp),%eax
  pde = &pgdir[PDX(va)];
801076e9:	89 d1                	mov    %edx,%ecx
801076eb:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801076ee:	8b 04 88             	mov    (%eax,%ecx,4),%eax
801076f1:	a8 01                	test   $0x1,%al
801076f3:	75 0b                	jne    80107700 <va2pa_walk+0x20>
  pte_t *pte;

  pte = walkpgdir(pgdir, (void*)va, 0);
  if(pte == 0 || !(*pte & PTE_P) || !(*pte & PTE_U))
    return -1;
801076f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return PTE_ADDR(*pte) | (va & 0xFFF);
}
801076fa:	5d                   	pop    %ebp
801076fb:	c3                   	ret
801076fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107700:	89 d1                	mov    %edx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107702:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107707:	c1 e9 0a             	shr    $0xa,%ecx
8010770a:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
80107710:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
  if(pte == 0 || !(*pte & PTE_P) || !(*pte & PTE_U))
80107717:	85 c0                	test   %eax,%eax
80107719:	74 da                	je     801076f5 <va2pa_walk+0x15>
8010771b:	8b 00                	mov    (%eax),%eax
8010771d:	89 c1                	mov    %eax,%ecx
8010771f:	f7 d1                	not    %ecx
80107721:	83 e1 05             	and    $0x5,%ecx
80107724:	75 cf                	jne    801076f5 <va2pa_walk+0x15>
  return PTE_ADDR(*pte) | (va & 0xFFF);
80107726:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010772b:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
}
80107731:	5d                   	pop    %ebp
  return PTE_ADDR(*pte) | (va & 0xFFF);
80107732:	09 d0                	or     %edx,%eax
}
80107734:	c3                   	ret

80107735 <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
80107735:	a1 00 00 00 00       	mov    0x0,%eax
8010773a:	0f 0b                	ud2

8010773c <copyout.cold>:
8010773c:	a1 00 00 00 00       	mov    0x0,%eax
80107741:	0f 0b                	ud2
