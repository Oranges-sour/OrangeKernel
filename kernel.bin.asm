
kernel.bin:     file format elf32-i386


Disassembly of section .text:

00030400 <_start>:
   30400:	b4 0c                	mov    ah,0xc
   30402:	b0 4f                	mov    al,0x4f
   30404:	65 66 a3 ee 00 00 00 	mov    gs:0xee,ax
   3040b:	bc e0 48 03 00       	mov    esp,0x348e0
   30410:	0f 01 05 04 49 03 00 	sgdtd  ds:0x34904
   30417:	e8 41 03 00 00       	call   3075d <cstart>
   3041c:	0f 01 15 04 49 03 00 	lgdtd  ds:0x34904
   30423:	0f 01 1d 20 4d 03 00 	lidtd  ds:0x34d20
   3042a:	ea 31 04 03 00 08 00 	jmp    0x8:0x30431

00030431 <csinit>:
   30431:	31 c0                	xor    eax,eax
   30433:	66 b8 20 00          	mov    ax,0x20
   30437:	0f 00 d8             	ltr    eax
   3043a:	e9 f2 03 00 00       	jmp    30831 <kernel_main>

0003043f <restart>:
   3043f:	8b 25 a8 55 03 00    	mov    esp,DWORD PTR ds:0x355a8
   30445:	0f 00 54 24 48       	lldt   WORD PTR [esp+0x48]
   3044a:	8d 44 24 48          	lea    eax,[esp+0x48]
   3044e:	a3 44 55 03 00       	mov    ds:0x35544,eax

00030453 <restart_reenter>:
   30453:	ff 0d 80 d7 04 00    	dec    DWORD PTR ds:0x4d780
   30459:	0f a9                	pop    gs
   3045b:	0f a1                	pop    fs
   3045d:	07                   	pop    es
   3045e:	1f                   	pop    ds
   3045f:	61                   	popa
   30460:	83 c4 04             	add    esp,0x4
   30463:	cf                   	iret

00030464 <save>:
   30464:	60                   	pusha
   30465:	1e                   	push   ds
   30466:	06                   	push   es
   30467:	0f a0                	push   fs
   30469:	0f a8                	push   gs
   3046b:	66 8c d2             	mov    dx,ss
   3046e:	8e da                	mov    ds,edx
   30470:	8e c2                	mov    es,edx
   30472:	89 e6                	mov    esi,esp
   30474:	65 fe 05 00 00 00 00 	inc    BYTE PTR gs:0x0
   3047b:	ff 05 80 d7 04 00    	inc    DWORD PTR ds:0x4d780
   30481:	83 3d 80 d7 04 00 00 	cmp    DWORD PTR ds:0x4d780,0x0
   30488:	75 0d                	jne    30497 <save.1>
   3048a:	bc e0 48 03 00       	mov    esp,0x348e0
   3048f:	68 3f 04 03 00       	push   0x3043f
   30494:	ff 66 30             	jmp    DWORD PTR [esi+0x30]

00030497 <save.1>:
   30497:	68 53 04 03 00       	push   0x30453
   3049c:	ff 66 30             	jmp    DWORD PTR [esi+0x30]

0003049f <sys_call>:
   3049f:	e8 c0 ff ff ff       	call   30464 <save>
   304a4:	fb                   	sti
   304a5:	ff 14 85 98 40 03 00 	call   DWORD PTR [eax*4+0x34098]
   304ac:	89 46 2c             	mov    DWORD PTR [esi+0x2c],eax
   304af:	fa                   	cli
   304b0:	c3                   	ret
   304b1:	90                   	nop
   304b2:	90                   	nop
   304b3:	90                   	nop
   304b4:	90                   	nop
   304b5:	90                   	nop
   304b6:	90                   	nop
   304b7:	90                   	nop
   304b8:	90                   	nop
   304b9:	90                   	nop
   304ba:	90                   	nop
   304bb:	90                   	nop
   304bc:	90                   	nop
   304bd:	90                   	nop
   304be:	90                   	nop
   304bf:	90                   	nop

000304c0 <hwint00>:
   304c0:	e8 9f ff ff ff       	call   30464 <save>
   304c5:	e4 21                	in     al,0x21
   304c7:	0c 01                	or     al,0x1
   304c9:	e6 21                	out    0x21,al
   304cb:	b0 20                	mov    al,0x20
   304cd:	e6 20                	out    0x20,al
   304cf:	fb                   	sti
   304d0:	6a 00                	push   0x0
   304d2:	ff 15 40 d7 04 00    	call   DWORD PTR ds:0x4d740
   304d8:	59                   	pop    ecx
   304d9:	fa                   	cli
   304da:	e4 21                	in     al,0x21
   304dc:	24 fe                	and    al,0xfe
   304de:	e6 21                	out    0x21,al
   304e0:	c3                   	ret
   304e1:	90                   	nop
   304e2:	90                   	nop
   304e3:	90                   	nop
   304e4:	90                   	nop
   304e5:	90                   	nop
   304e6:	90                   	nop
   304e7:	90                   	nop
   304e8:	90                   	nop
   304e9:	90                   	nop
   304ea:	90                   	nop
   304eb:	90                   	nop
   304ec:	90                   	nop
   304ed:	90                   	nop
   304ee:	90                   	nop
   304ef:	90                   	nop

000304f0 <hwint01>:
   304f0:	e8 6f ff ff ff       	call   30464 <save>
   304f5:	e4 21                	in     al,0x21
   304f7:	0c 02                	or     al,0x2
   304f9:	e6 21                	out    0x21,al
   304fb:	b0 20                	mov    al,0x20
   304fd:	e6 20                	out    0x20,al
   304ff:	fb                   	sti
   30500:	6a 01                	push   0x1
   30502:	ff 15 44 d7 04 00    	call   DWORD PTR ds:0x4d744
   30508:	59                   	pop    ecx
   30509:	fa                   	cli
   3050a:	e4 21                	in     al,0x21
   3050c:	24 fd                	and    al,0xfd
   3050e:	e6 21                	out    0x21,al
   30510:	c3                   	ret
   30511:	90                   	nop
   30512:	90                   	nop
   30513:	90                   	nop
   30514:	90                   	nop
   30515:	90                   	nop
   30516:	90                   	nop
   30517:	90                   	nop
   30518:	90                   	nop
   30519:	90                   	nop
   3051a:	90                   	nop
   3051b:	90                   	nop
   3051c:	90                   	nop
   3051d:	90                   	nop
   3051e:	90                   	nop
   3051f:	90                   	nop

00030520 <hwint02>:
   30520:	e8 3f ff ff ff       	call   30464 <save>
   30525:	e4 21                	in     al,0x21
   30527:	0c 04                	or     al,0x4
   30529:	e6 21                	out    0x21,al
   3052b:	b0 20                	mov    al,0x20
   3052d:	e6 20                	out    0x20,al
   3052f:	fb                   	sti
   30530:	6a 02                	push   0x2
   30532:	ff 15 48 d7 04 00    	call   DWORD PTR ds:0x4d748
   30538:	59                   	pop    ecx
   30539:	fa                   	cli
   3053a:	e4 21                	in     al,0x21
   3053c:	24 fb                	and    al,0xfb
   3053e:	e6 21                	out    0x21,al
   30540:	c3                   	ret
   30541:	90                   	nop
   30542:	90                   	nop
   30543:	90                   	nop
   30544:	90                   	nop
   30545:	90                   	nop
   30546:	90                   	nop
   30547:	90                   	nop
   30548:	90                   	nop
   30549:	90                   	nop
   3054a:	90                   	nop
   3054b:	90                   	nop
   3054c:	90                   	nop
   3054d:	90                   	nop
   3054e:	90                   	nop
   3054f:	90                   	nop

00030550 <hwint03>:
   30550:	e8 0f ff ff ff       	call   30464 <save>
   30555:	e4 21                	in     al,0x21
   30557:	0c 08                	or     al,0x8
   30559:	e6 21                	out    0x21,al
   3055b:	b0 20                	mov    al,0x20
   3055d:	e6 20                	out    0x20,al
   3055f:	fb                   	sti
   30560:	6a 03                	push   0x3
   30562:	ff 15 4c d7 04 00    	call   DWORD PTR ds:0x4d74c
   30568:	59                   	pop    ecx
   30569:	fa                   	cli
   3056a:	e4 21                	in     al,0x21
   3056c:	24 f7                	and    al,0xf7
   3056e:	e6 21                	out    0x21,al
   30570:	c3                   	ret
   30571:	90                   	nop
   30572:	90                   	nop
   30573:	90                   	nop
   30574:	90                   	nop
   30575:	90                   	nop
   30576:	90                   	nop
   30577:	90                   	nop
   30578:	90                   	nop
   30579:	90                   	nop
   3057a:	90                   	nop
   3057b:	90                   	nop
   3057c:	90                   	nop
   3057d:	90                   	nop
   3057e:	90                   	nop
   3057f:	90                   	nop

00030580 <hwint04>:
   30580:	e8 df fe ff ff       	call   30464 <save>
   30585:	e4 21                	in     al,0x21
   30587:	0c 10                	or     al,0x10
   30589:	e6 21                	out    0x21,al
   3058b:	b0 20                	mov    al,0x20
   3058d:	e6 20                	out    0x20,al
   3058f:	fb                   	sti
   30590:	6a 04                	push   0x4
   30592:	ff 15 50 d7 04 00    	call   DWORD PTR ds:0x4d750
   30598:	59                   	pop    ecx
   30599:	fa                   	cli
   3059a:	e4 21                	in     al,0x21
   3059c:	24 ef                	and    al,0xef
   3059e:	e6 21                	out    0x21,al
   305a0:	c3                   	ret
   305a1:	90                   	nop
   305a2:	90                   	nop
   305a3:	90                   	nop
   305a4:	90                   	nop
   305a5:	90                   	nop
   305a6:	90                   	nop
   305a7:	90                   	nop
   305a8:	90                   	nop
   305a9:	90                   	nop
   305aa:	90                   	nop
   305ab:	90                   	nop
   305ac:	90                   	nop
   305ad:	90                   	nop
   305ae:	90                   	nop
   305af:	90                   	nop

000305b0 <hwint05>:
   305b0:	e8 af fe ff ff       	call   30464 <save>
   305b5:	e4 21                	in     al,0x21
   305b7:	0c 20                	or     al,0x20
   305b9:	e6 21                	out    0x21,al
   305bb:	b0 20                	mov    al,0x20
   305bd:	e6 20                	out    0x20,al
   305bf:	fb                   	sti
   305c0:	6a 05                	push   0x5
   305c2:	ff 15 54 d7 04 00    	call   DWORD PTR ds:0x4d754
   305c8:	59                   	pop    ecx
   305c9:	fa                   	cli
   305ca:	e4 21                	in     al,0x21
   305cc:	24 df                	and    al,0xdf
   305ce:	e6 21                	out    0x21,al
   305d0:	c3                   	ret
   305d1:	90                   	nop
   305d2:	90                   	nop
   305d3:	90                   	nop
   305d4:	90                   	nop
   305d5:	90                   	nop
   305d6:	90                   	nop
   305d7:	90                   	nop
   305d8:	90                   	nop
   305d9:	90                   	nop
   305da:	90                   	nop
   305db:	90                   	nop
   305dc:	90                   	nop
   305dd:	90                   	nop
   305de:	90                   	nop
   305df:	90                   	nop

000305e0 <hwint06>:
   305e0:	e8 7f fe ff ff       	call   30464 <save>
   305e5:	e4 21                	in     al,0x21
   305e7:	0c 40                	or     al,0x40
   305e9:	e6 21                	out    0x21,al
   305eb:	b0 20                	mov    al,0x20
   305ed:	e6 20                	out    0x20,al
   305ef:	fb                   	sti
   305f0:	6a 06                	push   0x6
   305f2:	ff 15 58 d7 04 00    	call   DWORD PTR ds:0x4d758
   305f8:	59                   	pop    ecx
   305f9:	fa                   	cli
   305fa:	e4 21                	in     al,0x21
   305fc:	24 bf                	and    al,0xbf
   305fe:	e6 21                	out    0x21,al
   30600:	c3                   	ret
   30601:	90                   	nop
   30602:	90                   	nop
   30603:	90                   	nop
   30604:	90                   	nop
   30605:	90                   	nop
   30606:	90                   	nop
   30607:	90                   	nop
   30608:	90                   	nop
   30609:	90                   	nop
   3060a:	90                   	nop
   3060b:	90                   	nop
   3060c:	90                   	nop
   3060d:	90                   	nop
   3060e:	90                   	nop
   3060f:	90                   	nop

00030610 <hwint07>:
   30610:	e8 4f fe ff ff       	call   30464 <save>
   30615:	e4 21                	in     al,0x21
   30617:	0c 80                	or     al,0x80
   30619:	e6 21                	out    0x21,al
   3061b:	b0 20                	mov    al,0x20
   3061d:	e6 20                	out    0x20,al
   3061f:	fb                   	sti
   30620:	6a 07                	push   0x7
   30622:	ff 15 5c d7 04 00    	call   DWORD PTR ds:0x4d75c
   30628:	59                   	pop    ecx
   30629:	fa                   	cli
   3062a:	e4 21                	in     al,0x21
   3062c:	24 7f                	and    al,0x7f
   3062e:	e6 21                	out    0x21,al
   30630:	c3                   	ret
   30631:	90                   	nop
   30632:	90                   	nop
   30633:	90                   	nop
   30634:	90                   	nop
   30635:	90                   	nop
   30636:	90                   	nop
   30637:	90                   	nop
   30638:	90                   	nop
   30639:	90                   	nop
   3063a:	90                   	nop
   3063b:	90                   	nop
   3063c:	90                   	nop
   3063d:	90                   	nop
   3063e:	90                   	nop
   3063f:	90                   	nop

00030640 <hwint08>:
   30640:	6a 08                	push   0x8
   30642:	e8 35 06 00 00       	call   30c7c <spurious_irq>
   30647:	83 c4 04             	add    esp,0x4
   3064a:	f4                   	hlt
   3064b:	90                   	nop
   3064c:	90                   	nop
   3064d:	90                   	nop
   3064e:	90                   	nop
   3064f:	90                   	nop

00030650 <hwint09>:
   30650:	6a 09                	push   0x9
   30652:	e8 25 06 00 00       	call   30c7c <spurious_irq>
   30657:	83 c4 04             	add    esp,0x4
   3065a:	f4                   	hlt
   3065b:	90                   	nop
   3065c:	90                   	nop
   3065d:	90                   	nop
   3065e:	90                   	nop
   3065f:	90                   	nop

00030660 <hwint10>:
   30660:	6a 0a                	push   0xa
   30662:	e8 15 06 00 00       	call   30c7c <spurious_irq>
   30667:	83 c4 04             	add    esp,0x4
   3066a:	f4                   	hlt
   3066b:	90                   	nop
   3066c:	90                   	nop
   3066d:	90                   	nop
   3066e:	90                   	nop
   3066f:	90                   	nop

00030670 <hwint11>:
   30670:	6a 0b                	push   0xb
   30672:	e8 05 06 00 00       	call   30c7c <spurious_irq>
   30677:	83 c4 04             	add    esp,0x4
   3067a:	f4                   	hlt
   3067b:	90                   	nop
   3067c:	90                   	nop
   3067d:	90                   	nop
   3067e:	90                   	nop
   3067f:	90                   	nop

00030680 <hwint12>:
   30680:	6a 0c                	push   0xc
   30682:	e8 f5 05 00 00       	call   30c7c <spurious_irq>
   30687:	83 c4 04             	add    esp,0x4
   3068a:	f4                   	hlt
   3068b:	90                   	nop
   3068c:	90                   	nop
   3068d:	90                   	nop
   3068e:	90                   	nop
   3068f:	90                   	nop

00030690 <hwint13>:
   30690:	6a 0d                	push   0xd
   30692:	e8 e5 05 00 00       	call   30c7c <spurious_irq>
   30697:	83 c4 04             	add    esp,0x4
   3069a:	f4                   	hlt
   3069b:	90                   	nop
   3069c:	90                   	nop
   3069d:	90                   	nop
   3069e:	90                   	nop
   3069f:	90                   	nop

000306a0 <hwint14>:
   306a0:	6a 0e                	push   0xe
   306a2:	e8 d5 05 00 00       	call   30c7c <spurious_irq>
   306a7:	83 c4 04             	add    esp,0x4
   306aa:	f4                   	hlt
   306ab:	90                   	nop
   306ac:	90                   	nop
   306ad:	90                   	nop
   306ae:	90                   	nop
   306af:	90                   	nop

000306b0 <hwint15>:
   306b0:	6a 0f                	push   0xf
   306b2:	e8 c5 05 00 00       	call   30c7c <spurious_irq>
   306b7:	83 c4 04             	add    esp,0x4
   306ba:	f4                   	hlt

000306bb <divide_error>:
   306bb:	6a ff                	push   0xffffffff
   306bd:	6a 00                	push   0x0
   306bf:	eb 4e                	jmp    3070f <exception>

000306c1 <single_step_exception>:
   306c1:	6a ff                	push   0xffffffff
   306c3:	6a 01                	push   0x1
   306c5:	eb 48                	jmp    3070f <exception>

000306c7 <nmi>:
   306c7:	6a ff                	push   0xffffffff
   306c9:	6a 02                	push   0x2
   306cb:	eb 42                	jmp    3070f <exception>

000306cd <breakpoint_exception>:
   306cd:	6a ff                	push   0xffffffff
   306cf:	6a 03                	push   0x3
   306d1:	eb 3c                	jmp    3070f <exception>

000306d3 <overflow>:
   306d3:	6a ff                	push   0xffffffff
   306d5:	6a 04                	push   0x4
   306d7:	eb 36                	jmp    3070f <exception>

000306d9 <bounds_check>:
   306d9:	6a ff                	push   0xffffffff
   306db:	6a 05                	push   0x5
   306dd:	eb 30                	jmp    3070f <exception>

000306df <inval_opcode>:
   306df:	6a ff                	push   0xffffffff
   306e1:	6a 06                	push   0x6
   306e3:	eb 2a                	jmp    3070f <exception>

000306e5 <copr_not_available>:
   306e5:	6a ff                	push   0xffffffff
   306e7:	6a 07                	push   0x7
   306e9:	eb 24                	jmp    3070f <exception>

000306eb <double_fault>:
   306eb:	6a 08                	push   0x8
   306ed:	eb 20                	jmp    3070f <exception>

000306ef <copr_seg_overrun>:
   306ef:	6a ff                	push   0xffffffff
   306f1:	6a 09                	push   0x9
   306f3:	eb 1a                	jmp    3070f <exception>

000306f5 <inval_tss>:
   306f5:	6a 0a                	push   0xa
   306f7:	eb 16                	jmp    3070f <exception>

000306f9 <segment_not_present>:
   306f9:	6a 0b                	push   0xb
   306fb:	eb 12                	jmp    3070f <exception>

000306fd <stack_exception>:
   306fd:	6a 0c                	push   0xc
   306ff:	eb 0e                	jmp    3070f <exception>

00030701 <general_protection>:
   30701:	6a 0d                	push   0xd
   30703:	eb 0a                	jmp    3070f <exception>

00030705 <page_fault>:
   30705:	6a 0e                	push   0xe
   30707:	eb 06                	jmp    3070f <exception>

00030709 <copr_error>:
   30709:	6a ff                	push   0xffffffff
   3070b:	6a 10                	push   0x10
   3070d:	eb 00                	jmp    3070f <exception>

0003070f <exception>:
   3070f:	e8 a0 05 00 00       	call   30cb4 <exception_handler>
   30714:	83 c4 08             	add    esp,0x8
   30717:	f4                   	hlt
   30718:	66 90                	xchg   ax,ax
   3071a:	66 90                	xchg   ax,ax
   3071c:	66 90                	xchg   ax,ax
   3071e:	66 90                	xchg   ax,ax

00030720 <get_ticks>:
   30720:	b8 00 00 00 00       	mov    eax,0x0
   30725:	cd 90                	int    0x90
   30727:	c3                   	ret

00030728 <sys_get_ticks>:
   30728:	55                   	push   ebp
   30729:	89 e5                	mov    ebp,esp
   3072b:	53                   	push   ebx
   3072c:	83 ec 04             	sub    esp,0x4
   3072f:	e8 25 00 00 00       	call   30759 <__x86.get_pc_thunk.bx>
   30734:	81 c3 c0 38 00 00    	add    ebx,0x38c0
   3073a:	83 ec 0c             	sub    esp,0xc
   3073d:	8d 83 0c e0 ff ff    	lea    eax,[ebx-0x1ff4]
   30743:	50                   	push   eax
   30744:	e8 b7 0d 00 00       	call   31500 <disp_str>
   30749:	83 c4 10             	add    esp,0x10
   3074c:	c7 c0 84 d7 04 00    	mov    eax,0x4d784
   30752:	8b 00                	mov    eax,DWORD PTR [eax]
   30754:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
   30757:	c9                   	leave
   30758:	c3                   	ret

00030759 <__x86.get_pc_thunk.bx>:
   30759:	8b 1c 24             	mov    ebx,DWORD PTR [esp]
   3075c:	c3                   	ret

0003075d <cstart>:
   3075d:	55                   	push   ebp
   3075e:	89 e5                	mov    ebp,esp
   30760:	53                   	push   ebx
   30761:	83 ec 14             	sub    esp,0x14
   30764:	e8 f0 ff ff ff       	call   30759 <__x86.get_pc_thunk.bx>
   30769:	81 c3 8b 38 00 00    	add    ebx,0x388b
   3076f:	c7 c0 04 49 03 00    	mov    eax,0x34904
   30775:	0f b7 00             	movzx  eax,WORD PTR [eax]
   30778:	0f b7 c0             	movzx  eax,ax
   3077b:	8d 50 01             	lea    edx,[eax+0x1]
   3077e:	c7 c0 04 49 03 00    	mov    eax,0x34904
   30784:	8d 40 02             	lea    eax,[eax+0x2]
   30787:	8b 00                	mov    eax,DWORD PTR [eax]
   30789:	83 ec 04             	sub    esp,0x4
   3078c:	52                   	push   edx
   3078d:	50                   	push   eax
   3078e:	c7 c0 20 49 03 00    	mov    eax,0x34920
   30794:	50                   	push   eax
   30795:	e8 16 0e 00 00       	call   315b0 <memcpy>
   3079a:	83 c4 10             	add    esp,0x10
   3079d:	c7 c0 04 49 03 00    	mov    eax,0x34904
   307a3:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
   307a6:	c7 c0 04 49 03 00    	mov    eax,0x34904
   307ac:	8d 40 02             	lea    eax,[eax+0x2]
   307af:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
   307b2:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
   307b5:	66 c7 00 ff 03       	mov    WORD PTR [eax],0x3ff
   307ba:	c7 c0 20 49 03 00    	mov    eax,0x34920
   307c0:	89 c2                	mov    edx,eax
   307c2:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
   307c5:	89 10                	mov    DWORD PTR [eax],edx
   307c7:	c7 c0 20 4d 03 00    	mov    eax,0x34d20
   307cd:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
   307d0:	c7 c0 20 4d 03 00    	mov    eax,0x34d20
   307d6:	8d 40 02             	lea    eax,[eax+0x2]
   307d9:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
   307dc:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
   307df:	66 c7 00 ff 07       	mov    WORD PTR [eax],0x7ff
   307e4:	c7 c0 40 4d 03 00    	mov    eax,0x34d40
   307ea:	89 c2                	mov    edx,eax
   307ec:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
   307ef:	89 10                	mov    DWORD PTR [eax],edx
   307f1:	e8 38 08 00 00       	call   3102e <init_protect>
   307f6:	83 ec 08             	sub    esp,0x8
   307f9:	6a 00                	push   0x0
   307fb:	6a 00                	push   0x0
   307fd:	e8 e1 10 00 00       	call   318e3 <set_disp_pos>
   30802:	83 c4 10             	add    esp,0x10
   30805:	83 ec 0c             	sub    esp,0xc
   30808:	8d 83 0e e0 ff ff    	lea    eax,[ebx-0x1ff2]
   3080e:	50                   	push   eax
   3080f:	e8 ec 0c 00 00       	call   31500 <disp_str>
   30814:	83 c4 10             	add    esp,0x10
   30817:	90                   	nop
   30818:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
   3081b:	c9                   	leave
   3081c:	c3                   	ret

0003081d <testt>:
   3081d:	55                   	push   ebp
   3081e:	89 e5                	mov    ebp,esp
   30820:	e8 08 00 00 00       	call   3082d <__x86.get_pc_thunk.ax>
   30825:	05 cf 37 00 00       	add    eax,0x37cf
   3082a:	90                   	nop
   3082b:	5d                   	pop    ebp
   3082c:	c3                   	ret

0003082d <__x86.get_pc_thunk.ax>:
   3082d:	8b 04 24             	mov    eax,DWORD PTR [esp]
   30830:	c3                   	ret

00030831 <kernel_main>:
   30831:	55                   	push   ebp
   30832:	89 e5                	mov    ebp,esp
   30834:	53                   	push   ebx
   30835:	83 ec 14             	sub    esp,0x14
   30838:	e8 1c ff ff ff       	call   30759 <__x86.get_pc_thunk.bx>
   3083d:	81 c3 b7 37 00 00    	add    ebx,0x37b7
   30843:	83 ec 0c             	sub    esp,0xc
   30846:	8d 83 1b e0 ff ff    	lea    eax,[ebx-0x1fe5]
   3084c:	50                   	push   eax
   3084d:	e8 ae 0c 00 00       	call   31500 <disp_str>
   30852:	83 c4 10             	add    esp,0x10
   30855:	c7 c0 80 d7 04 00    	mov    eax,0x4d780
   3085b:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
   30861:	c7 c0 84 d7 04 00    	mov    eax,0x4d784
   30867:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
   3086d:	83 ec 08             	sub    esp,0x8
   30870:	c7 c0 bb 0a 03 00    	mov    eax,0x30abb
   30876:	50                   	push   eax
   30877:	6a 00                	push   0x0
   30879:	e8 c9 03 00 00       	call   30c47 <put_irq_handler>
   3087e:	83 c4 10             	add    esp,0x10
   30881:	83 ec 0c             	sub    esp,0xc
   30884:	6a 00                	push   0x0
   30886:	e8 9f 11 00 00       	call   31a2a <enable_irq>
   3088b:	83 c4 10             	add    esp,0x10
   3088e:	c7 45 f4 00 80 01 00 	mov    DWORD PTR [ebp-0xc],0x18000
   30895:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
   3089c:	e9 3b 01 00 00       	jmp    309dc <kernel_main+0x1ab>
   308a1:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
   308a4:	c1 e0 07             	shl    eax,0x7
   308a7:	89 c2                	mov    edx,eax
   308a9:	c7 c0 c0 55 03 00    	mov    eax,0x355c0
   308af:	01 d0                	add    eax,edx
   308b1:	89 45 ec             	mov    DWORD PTR [ebp-0x14],eax
   308b4:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
   308b7:	83 c0 05             	add    eax,0x5
   308ba:	8d 14 c5 00 00 00 00 	lea    edx,[eax*8+0x0]
   308c1:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
   308c4:	66 89 50 48          	mov    WORD PTR [eax+0x48],dx
   308c8:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
   308cb:	8d 50 4a             	lea    edx,[eax+0x4a]
   308ce:	83 ec 04             	sub    esp,0x4
   308d1:	6a 08                	push   0x8
   308d3:	c7 c0 20 49 03 00    	mov    eax,0x34920
   308d9:	8d 40 08             	lea    eax,[eax+0x8]
   308dc:	50                   	push   eax
   308dd:	52                   	push   edx
   308de:	e8 cd 0c 00 00       	call   315b0 <memcpy>
   308e3:	83 c4 10             	add    esp,0x10
   308e6:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
   308e9:	c6 40 4f b8          	mov    BYTE PTR [eax+0x4f],0xb8
   308ed:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
   308f0:	8d 50 52             	lea    edx,[eax+0x52]
   308f3:	83 ec 04             	sub    esp,0x4
   308f6:	6a 08                	push   0x8
   308f8:	c7 c0 20 49 03 00    	mov    eax,0x34920
   308fe:	8d 40 10             	lea    eax,[eax+0x10]
   30901:	50                   	push   eax
   30902:	52                   	push   edx
   30903:	e8 a8 0c 00 00       	call   315b0 <memcpy>
   30908:	83 c4 10             	add    esp,0x10
   3090b:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
   3090e:	c6 40 57 b2          	mov    BYTE PTR [eax+0x57],0xb2
   30912:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
   30915:	c7 40 38 05 00 00 00 	mov    DWORD PTR [eax+0x38],0x5
   3091c:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
   3091f:	c7 40 0c 0d 00 00 00 	mov    DWORD PTR [eax+0xc],0xd
   30926:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
   30929:	c7 40 08 0d 00 00 00 	mov    DWORD PTR [eax+0x8],0xd
   30930:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
   30933:	c7 40 04 0d 00 00 00 	mov    DWORD PTR [eax+0x4],0xd
   3093a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
   3093d:	c7 40 44 0d 00 00 00 	mov    DWORD PTR [eax+0x44],0xd
   30944:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
   30947:	c7 00 19 00 00 00    	mov    DWORD PTR [eax],0x19
   3094d:	c7 c1 20 40 03 00    	mov    ecx,0x34020
   30953:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
   30956:	89 d0                	mov    eax,edx
   30958:	c1 e0 02             	shl    eax,0x2
   3095b:	01 d0                	add    eax,edx
   3095d:	c1 e0 03             	shl    eax,0x3
   30960:	01 c8                	add    eax,ecx
   30962:	8b 00                	mov    eax,DWORD PTR [eax]
   30964:	89 c2                	mov    edx,eax
   30966:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
   30969:	89 50 34             	mov    DWORD PTR [eax+0x34],edx
   3096c:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
   3096f:	c7 c2 40 57 03 00    	mov    edx,0x35740
   30975:	01 c2                	add    edx,eax
   30977:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
   3097a:	89 50 40             	mov    DWORD PTR [eax+0x40],edx
   3097d:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
   30980:	c7 40 3c 02 12 00 00 	mov    DWORD PTR [eax+0x3c],0x1202
   30987:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
   3098a:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
   3098d:	89 50 5c             	mov    DWORD PTR [eax+0x5c],edx
   30990:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
   30993:	89 d0                	mov    eax,edx
   30995:	c1 e0 02             	shl    eax,0x2
   30998:	01 d0                	add    eax,edx
   3099a:	c1 e0 03             	shl    eax,0x3
   3099d:	c7 c2 20 40 03 00    	mov    edx,0x34020
   309a3:	01 d0                	add    eax,edx
   309a5:	8d 50 08             	lea    edx,[eax+0x8]
   309a8:	8b 45 ec             	mov    eax,DWORD PTR [ebp-0x14]
   309ab:	83 c0 60             	add    eax,0x60
   309ae:	83 ec 08             	sub    esp,0x8
   309b1:	52                   	push   edx
   309b2:	50                   	push   eax
   309b3:	e8 bf 0e 00 00       	call   31877 <strcpy>
   309b8:	83 c4 10             	add    esp,0x10
   309bb:	c7 c1 20 40 03 00    	mov    ecx,0x34020
   309c1:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
   309c4:	89 d0                	mov    eax,edx
   309c6:	c1 e0 02             	shl    eax,0x2
   309c9:	01 d0                	add    eax,edx
   309cb:	c1 e0 03             	shl    eax,0x3
   309ce:	01 c8                	add    eax,ecx
   309d0:	83 c0 04             	add    eax,0x4
   309d3:	8b 00                	mov    eax,DWORD PTR [eax]
   309d5:	29 45 f4             	sub    DWORD PTR [ebp-0xc],eax
   309d8:	83 45 f0 01          	add    DWORD PTR [ebp-0x10],0x1
   309dc:	83 7d f0 02          	cmp    DWORD PTR [ebp-0x10],0x2
   309e0:	0f 8e bb fe ff ff    	jle    308a1 <kernel_main+0x70>
   309e6:	c7 c0 a8 55 03 00    	mov    eax,0x355a8
   309ec:	c7 c2 c0 55 03 00    	mov    edx,0x355c0
   309f2:	89 10                	mov    DWORD PTR [eax],edx
   309f4:	83 ec 0c             	sub    esp,0xc
   309f7:	8d 83 27 e0 ff ff    	lea    eax,[ebx-0x1fd9]
   309fd:	50                   	push   eax
   309fe:	e8 fd 0a 00 00       	call   31500 <disp_str>
   30a03:	83 c4 10             	add    esp,0x10
   30a06:	e8 34 fa ff ff       	call   3043f <restart>
   30a0b:	90                   	nop
   30a0c:	eb fd                	jmp    30a0b <kernel_main+0x1da>

00030a0e <TaskA>:
   30a0e:	55                   	push   ebp
   30a0f:	89 e5                	mov    ebp,esp
   30a11:	53                   	push   ebx
   30a12:	83 ec 04             	sub    esp,0x4
   30a15:	e8 3f fd ff ff       	call   30759 <__x86.get_pc_thunk.bx>
   30a1a:	81 c3 da 35 00 00    	add    ebx,0x35da
   30a20:	83 ec 0c             	sub    esp,0xc
   30a23:	8d 83 32 e0 ff ff    	lea    eax,[ebx-0x1fce]
   30a29:	50                   	push   eax
   30a2a:	e8 d1 0a 00 00       	call   31500 <disp_str>
   30a2f:	83 c4 10             	add    esp,0x10
   30a32:	e8 e9 fc ff ff       	call   30720 <get_ticks>
   30a37:	83 ec 0c             	sub    esp,0xc
   30a3a:	50                   	push   eax
   30a3b:	e8 ed 0e 00 00       	call   3192d <disp_int>
   30a40:	83 c4 10             	add    esp,0x10
   30a43:	83 ec 0c             	sub    esp,0xc
   30a46:	6a 64                	push   0x64
   30a48:	e8 19 0f 00 00       	call   31966 <delay>
   30a4d:	83 c4 10             	add    esp,0x10
   30a50:	90                   	nop
   30a51:	eb cd                	jmp    30a20 <TaskA+0x12>

00030a53 <TaskB>:
   30a53:	55                   	push   ebp
   30a54:	89 e5                	mov    ebp,esp
   30a56:	53                   	push   ebx
   30a57:	83 ec 04             	sub    esp,0x4
   30a5a:	e8 fa fc ff ff       	call   30759 <__x86.get_pc_thunk.bx>
   30a5f:	81 c3 95 35 00 00    	add    ebx,0x3595
   30a65:	83 ec 0c             	sub    esp,0xc
   30a68:	8d 83 34 e0 ff ff    	lea    eax,[ebx-0x1fcc]
   30a6e:	50                   	push   eax
   30a6f:	e8 8c 0a 00 00       	call   31500 <disp_str>
   30a74:	83 c4 10             	add    esp,0x10
   30a77:	83 ec 0c             	sub    esp,0xc
   30a7a:	6a 64                	push   0x64
   30a7c:	e8 e5 0e 00 00       	call   31966 <delay>
   30a81:	83 c4 10             	add    esp,0x10
   30a84:	90                   	nop
   30a85:	eb de                	jmp    30a65 <TaskB+0x12>

00030a87 <TaskC>:
   30a87:	55                   	push   ebp
   30a88:	89 e5                	mov    ebp,esp
   30a8a:	53                   	push   ebx
   30a8b:	83 ec 04             	sub    esp,0x4
   30a8e:	e8 c6 fc ff ff       	call   30759 <__x86.get_pc_thunk.bx>
   30a93:	81 c3 61 35 00 00    	add    ebx,0x3561
   30a99:	83 ec 0c             	sub    esp,0xc
   30a9c:	8d 83 36 e0 ff ff    	lea    eax,[ebx-0x1fca]
   30aa2:	50                   	push   eax
   30aa3:	e8 58 0a 00 00       	call   31500 <disp_str>
   30aa8:	83 c4 10             	add    esp,0x10
   30aab:	83 ec 0c             	sub    esp,0xc
   30aae:	6a 64                	push   0x64
   30ab0:	e8 b1 0e 00 00       	call   31966 <delay>
   30ab5:	83 c4 10             	add    esp,0x10
   30ab8:	90                   	nop
   30ab9:	eb de                	jmp    30a99 <TaskC+0x12>

00030abb <clock_handler>:
   30abb:	55                   	push   ebp
   30abc:	89 e5                	mov    ebp,esp
   30abe:	53                   	push   ebx
   30abf:	83 ec 04             	sub    esp,0x4
   30ac2:	e8 66 fd ff ff       	call   3082d <__x86.get_pc_thunk.ax>
   30ac7:	05 2d 35 00 00       	add    eax,0x352d
   30acc:	c7 c2 84 d7 04 00    	mov    edx,0x4d784
   30ad2:	8b 12                	mov    edx,DWORD PTR [edx]
   30ad4:	8d 4a 01             	lea    ecx,[edx+0x1]
   30ad7:	c7 c2 84 d7 04 00    	mov    edx,0x4d784
   30add:	89 0a                	mov    DWORD PTR [edx],ecx
   30adf:	c7 c2 80 d7 04 00    	mov    edx,0x4d780
   30ae5:	8b 12                	mov    edx,DWORD PTR [edx]
   30ae7:	85 d2                	test   edx,edx
   30ae9:	74 16                	je     30b01 <clock_handler+0x46>
   30aeb:	83 ec 0c             	sub    esp,0xc
   30aee:	8d 90 38 e0 ff ff    	lea    edx,[eax-0x1fc8]
   30af4:	52                   	push   edx
   30af5:	89 c3                	mov    ebx,eax
   30af7:	e8 04 0a 00 00       	call   31500 <disp_str>
   30afc:	83 c4 10             	add    esp,0x10
   30aff:	eb 58                	jmp    30b59 <clock_handler+0x9e>
   30b01:	8b 90 ec 08 00 00    	mov    edx,DWORD PTR [eax+0x8ec]
   30b07:	83 c2 01             	add    edx,0x1
   30b0a:	89 90 ec 08 00 00    	mov    DWORD PTR [eax+0x8ec],edx
   30b10:	8b 90 ec 08 00 00    	mov    edx,DWORD PTR [eax+0x8ec]
   30b16:	83 e2 01             	and    edx,0x1
   30b19:	85 d2                	test   edx,edx
   30b1b:	75 3c                	jne    30b59 <clock_handler+0x9e>
   30b1d:	c7 c2 a8 55 03 00    	mov    edx,0x355a8
   30b23:	8b 12                	mov    edx,DWORD PTR [edx]
   30b25:	8d 8a 80 00 00 00    	lea    ecx,[edx+0x80]
   30b2b:	c7 c2 a8 55 03 00    	mov    edx,0x355a8
   30b31:	89 0a                	mov    DWORD PTR [edx],ecx
   30b33:	c7 c2 a8 55 03 00    	mov    edx,0x355a8
   30b39:	8b 0a                	mov    ecx,DWORD PTR [edx]
   30b3b:	c7 c2 c0 55 03 00    	mov    edx,0x355c0
   30b41:	8d 92 80 01 00 00    	lea    edx,[edx+0x180]
   30b47:	39 d1                	cmp    ecx,edx
   30b49:	72 0e                	jb     30b59 <clock_handler+0x9e>
   30b4b:	c7 c2 a8 55 03 00    	mov    edx,0x355a8
   30b51:	c7 c0 c0 55 03 00    	mov    eax,0x355c0
   30b57:	89 02                	mov    DWORD PTR [edx],eax
   30b59:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
   30b5c:	c9                   	leave
   30b5d:	c3                   	ret

00030b5e <init_8259A>:
   30b5e:	55                   	push   ebp
   30b5f:	89 e5                	mov    ebp,esp
   30b61:	53                   	push   ebx
   30b62:	83 ec 14             	sub    esp,0x14
   30b65:	e8 ef fb ff ff       	call   30759 <__x86.get_pc_thunk.bx>
   30b6a:	81 c3 8a 34 00 00    	add    ebx,0x348a
   30b70:	83 ec 08             	sub    esp,0x8
   30b73:	6a 11                	push   0x11
   30b75:	6a 20                	push   0x20
   30b77:	e8 13 0a 00 00       	call   3158f <out_byte>
   30b7c:	83 c4 10             	add    esp,0x10
   30b7f:	83 ec 08             	sub    esp,0x8
   30b82:	6a 11                	push   0x11
   30b84:	68 a0 00 00 00       	push   0xa0
   30b89:	e8 01 0a 00 00       	call   3158f <out_byte>
   30b8e:	83 c4 10             	add    esp,0x10
   30b91:	83 ec 08             	sub    esp,0x8
   30b94:	6a 20                	push   0x20
   30b96:	6a 21                	push   0x21
   30b98:	e8 f2 09 00 00       	call   3158f <out_byte>
   30b9d:	83 c4 10             	add    esp,0x10
   30ba0:	83 ec 08             	sub    esp,0x8
   30ba3:	6a 28                	push   0x28
   30ba5:	68 a1 00 00 00       	push   0xa1
   30baa:	e8 e0 09 00 00       	call   3158f <out_byte>
   30baf:	83 c4 10             	add    esp,0x10
   30bb2:	83 ec 08             	sub    esp,0x8
   30bb5:	6a 04                	push   0x4
   30bb7:	6a 21                	push   0x21
   30bb9:	e8 d1 09 00 00       	call   3158f <out_byte>
   30bbe:	83 c4 10             	add    esp,0x10
   30bc1:	83 ec 08             	sub    esp,0x8
   30bc4:	6a 02                	push   0x2
   30bc6:	68 a1 00 00 00       	push   0xa1
   30bcb:	e8 bf 09 00 00       	call   3158f <out_byte>
   30bd0:	83 c4 10             	add    esp,0x10
   30bd3:	83 ec 08             	sub    esp,0x8
   30bd6:	6a 01                	push   0x1
   30bd8:	6a 21                	push   0x21
   30bda:	e8 b0 09 00 00       	call   3158f <out_byte>
   30bdf:	83 c4 10             	add    esp,0x10
   30be2:	83 ec 08             	sub    esp,0x8
   30be5:	6a 01                	push   0x1
   30be7:	68 a1 00 00 00       	push   0xa1
   30bec:	e8 9e 09 00 00       	call   3158f <out_byte>
   30bf1:	83 c4 10             	add    esp,0x10
   30bf4:	83 ec 08             	sub    esp,0x8
   30bf7:	68 ff 00 00 00       	push   0xff
   30bfc:	6a 21                	push   0x21
   30bfe:	e8 8c 09 00 00       	call   3158f <out_byte>
   30c03:	83 c4 10             	add    esp,0x10
   30c06:	83 ec 08             	sub    esp,0x8
   30c09:	68 ff 00 00 00       	push   0xff
   30c0e:	68 a1 00 00 00       	push   0xa1
   30c13:	e8 77 09 00 00       	call   3158f <out_byte>
   30c18:	83 c4 10             	add    esp,0x10
   30c1b:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
   30c22:	eb 16                	jmp    30c3a <init_8259A+0xdc>
   30c24:	c7 c0 40 d7 04 00    	mov    eax,0x4d740
   30c2a:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
   30c2d:	8d 8b 88 cc ff ff    	lea    ecx,[ebx-0x3378]
   30c33:	89 0c 90             	mov    DWORD PTR [eax+edx*4],ecx
   30c36:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
   30c3a:	83 7d f4 0f          	cmp    DWORD PTR [ebp-0xc],0xf
   30c3e:	7e e4                	jle    30c24 <init_8259A+0xc6>
   30c40:	90                   	nop
   30c41:	90                   	nop
   30c42:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
   30c45:	c9                   	leave
   30c46:	c3                   	ret

00030c47 <put_irq_handler>:
   30c47:	55                   	push   ebp
   30c48:	89 e5                	mov    ebp,esp
   30c4a:	53                   	push   ebx
   30c4b:	83 ec 04             	sub    esp,0x4
   30c4e:	e8 06 fb ff ff       	call   30759 <__x86.get_pc_thunk.bx>
   30c53:	81 c3 a1 33 00 00    	add    ebx,0x33a1
   30c59:	83 ec 0c             	sub    esp,0xc
   30c5c:	ff 75 08             	push   DWORD PTR [ebp+0x8]
   30c5f:	e8 41 0d 00 00       	call   319a5 <disable_irq>
   30c64:	83 c4 10             	add    esp,0x10
   30c67:	c7 c0 40 d7 04 00    	mov    eax,0x4d740
   30c6d:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
   30c70:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
   30c73:	89 0c 90             	mov    DWORD PTR [eax+edx*4],ecx
   30c76:	90                   	nop
   30c77:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
   30c7a:	c9                   	leave
   30c7b:	c3                   	ret

00030c7c <spurious_irq>:
   30c7c:	55                   	push   ebp
   30c7d:	89 e5                	mov    ebp,esp
   30c7f:	53                   	push   ebx
   30c80:	83 ec 04             	sub    esp,0x4
   30c83:	e8 d1 fa ff ff       	call   30759 <__x86.get_pc_thunk.bx>
   30c88:	81 c3 6c 33 00 00    	add    ebx,0x336c
   30c8e:	83 ec 0c             	sub    esp,0xc
   30c91:	8d 83 3a e0 ff ff    	lea    eax,[ebx-0x1fc6]
   30c97:	50                   	push   eax
   30c98:	e8 63 08 00 00       	call   31500 <disp_str>
   30c9d:	83 c4 10             	add    esp,0x10
   30ca0:	83 ec 0c             	sub    esp,0xc
   30ca3:	ff 75 08             	push   DWORD PTR [ebp+0x8]
   30ca6:	e8 82 0c 00 00       	call   3192d <disp_int>
   30cab:	83 c4 10             	add    esp,0x10
   30cae:	90                   	nop
   30caf:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
   30cb2:	c9                   	leave
   30cb3:	c3                   	ret

00030cb4 <exception_handler>:
   30cb4:	55                   	push   ebp
   30cb5:	89 e5                	mov    ebp,esp
   30cb7:	53                   	push   ebx
   30cb8:	81 ec 84 00 00 00    	sub    esp,0x84
   30cbe:	e8 96 fa ff ff       	call   30759 <__x86.get_pc_thunk.bx>
   30cc3:	81 c3 31 33 00 00    	add    ebx,0x3331
   30cc9:	c7 45 b8 00 00 00 00 	mov    DWORD PTR [ebp-0x48],0x0
   30cd0:	c7 45 bc 00 00 00 00 	mov    DWORD PTR [ebp-0x44],0x0
   30cd7:	c7 45 c0 00 00 00 00 	mov    DWORD PTR [ebp-0x40],0x0
   30cde:	c7 45 c4 00 00 00 00 	mov    DWORD PTR [ebp-0x3c],0x0
   30ce5:	c7 45 c8 00 00 00 00 	mov    DWORD PTR [ebp-0x38],0x0
   30cec:	c7 45 cc 00 00 00 00 	mov    DWORD PTR [ebp-0x34],0x0
   30cf3:	c7 45 d0 00 00 00 00 	mov    DWORD PTR [ebp-0x30],0x0
   30cfa:	c7 45 d4 00 00 00 00 	mov    DWORD PTR [ebp-0x2c],0x0
   30d01:	c7 45 d8 00 00 00 00 	mov    DWORD PTR [ebp-0x28],0x0
   30d08:	c7 45 dc 00 00 00 00 	mov    DWORD PTR [ebp-0x24],0x0
   30d0f:	c7 45 e0 00 00 00 00 	mov    DWORD PTR [ebp-0x20],0x0
   30d16:	c7 45 e4 00 00 00 00 	mov    DWORD PTR [ebp-0x1c],0x0
   30d1d:	c7 45 e8 00 00 00 00 	mov    DWORD PTR [ebp-0x18],0x0
   30d24:	c7 45 ec 00 00 00 00 	mov    DWORD PTR [ebp-0x14],0x0
   30d2b:	c7 45 f0 00 00 00 00 	mov    DWORD PTR [ebp-0x10],0x0
   30d32:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
   30d39:	c7 85 78 ff ff ff 00 	mov    DWORD PTR [ebp-0x88],0x0
   30d40:	00 00 00 
   30d43:	c7 85 7c ff ff ff 00 	mov    DWORD PTR [ebp-0x84],0x0
   30d4a:	00 00 00 
   30d4d:	c7 45 80 00 00 00 00 	mov    DWORD PTR [ebp-0x80],0x0
   30d54:	c7 45 84 00 00 00 00 	mov    DWORD PTR [ebp-0x7c],0x0
   30d5b:	c7 45 88 00 00 00 00 	mov    DWORD PTR [ebp-0x78],0x0
   30d62:	c7 45 8c 00 00 00 00 	mov    DWORD PTR [ebp-0x74],0x0
   30d69:	c7 45 90 00 00 00 00 	mov    DWORD PTR [ebp-0x70],0x0
   30d70:	c7 45 94 00 00 00 00 	mov    DWORD PTR [ebp-0x6c],0x0
   30d77:	c7 45 98 00 00 00 00 	mov    DWORD PTR [ebp-0x68],0x0
   30d7e:	c7 45 9c 00 00 00 00 	mov    DWORD PTR [ebp-0x64],0x0
   30d85:	c7 45 a0 00 00 00 00 	mov    DWORD PTR [ebp-0x60],0x0
   30d8c:	c7 45 a4 00 00 00 00 	mov    DWORD PTR [ebp-0x5c],0x0
   30d93:	c7 45 a8 00 00 00 00 	mov    DWORD PTR [ebp-0x58],0x0
   30d9a:	c7 45 ac 00 00 00 00 	mov    DWORD PTR [ebp-0x54],0x0
   30da1:	c7 45 b0 00 00 00 00 	mov    DWORD PTR [ebp-0x50],0x0
   30da8:	c7 45 b4 00 00 00 00 	mov    DWORD PTR [ebp-0x4c],0x0
   30daf:	83 ec 08             	sub    esp,0x8
   30db2:	6a 00                	push   0x0
   30db4:	6a 00                	push   0x0
   30db6:	e8 28 0b 00 00       	call   318e3 <set_disp_pos>
   30dbb:	83 c4 10             	add    esp,0x10
   30dbe:	83 ec 08             	sub    esp,0x8
   30dc1:	6a 0c                	push   0xc
   30dc3:	8d 83 30 e1 ff ff    	lea    eax,[ebx-0x1ed0]
   30dc9:	50                   	push   eax
   30dca:	e8 78 07 00 00       	call   31547 <disp_color_str>
   30dcf:	83 c4 10             	add    esp,0x10
   30dd2:	83 ec 08             	sub    esp,0x8
   30dd5:	6a 00                	push   0x0
   30dd7:	6a 01                	push   0x1
   30dd9:	e8 05 0b 00 00       	call   318e3 <set_disp_pos>
   30dde:	83 c4 10             	add    esp,0x10
   30de1:	83 ec 08             	sub    esp,0x8
   30de4:	8d 83 3d e1 ff ff    	lea    eax,[ebx-0x1ec3]
   30dea:	50                   	push   eax
   30deb:	8d 45 b8             	lea    eax,[ebp-0x48]
   30dee:	50                   	push   eax
   30def:	e8 83 0a 00 00       	call   31877 <strcpy>
   30df4:	83 c4 10             	add    esp,0x10
   30df7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   30dfa:	8b 84 83 ac 00 00 00 	mov    eax,DWORD PTR [ebx+eax*4+0xac]
   30e01:	83 ec 08             	sub    esp,0x8
   30e04:	50                   	push   eax
   30e05:	8d 45 b8             	lea    eax,[ebp-0x48]
   30e08:	50                   	push   eax
   30e09:	e8 f6 09 00 00       	call   31804 <strcat>
   30e0e:	83 c4 10             	add    esp,0x10
   30e11:	83 ec 08             	sub    esp,0x8
   30e14:	6a 0f                	push   0xf
   30e16:	8d 45 b8             	lea    eax,[ebp-0x48]
   30e19:	50                   	push   eax
   30e1a:	e8 28 07 00 00       	call   31547 <disp_color_str>
   30e1f:	83 c4 10             	add    esp,0x10
   30e22:	83 ec 08             	sub    esp,0x8
   30e25:	6a 00                	push   0x0
   30e27:	6a 02                	push   0x2
   30e29:	e8 b5 0a 00 00       	call   318e3 <set_disp_pos>
   30e2e:	83 c4 10             	add    esp,0x10
   30e31:	83 ec 08             	sub    esp,0x8
   30e34:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
   30e37:	8d 85 78 ff ff ff    	lea    eax,[ebp-0x88]
   30e3d:	50                   	push   eax
   30e3e:	e8 c0 08 00 00       	call   31703 <itoa_hex>
   30e43:	83 c4 10             	add    esp,0x10
   30e46:	83 ec 08             	sub    esp,0x8
   30e49:	8d 83 4d e1 ff ff    	lea    eax,[ebx-0x1eb3]
   30e4f:	50                   	push   eax
   30e50:	8d 45 b8             	lea    eax,[ebp-0x48]
   30e53:	50                   	push   eax
   30e54:	e8 1e 0a 00 00       	call   31877 <strcpy>
   30e59:	83 c4 10             	add    esp,0x10
   30e5c:	83 ec 08             	sub    esp,0x8
   30e5f:	8d 85 78 ff ff ff    	lea    eax,[ebp-0x88]
   30e65:	50                   	push   eax
   30e66:	8d 45 b8             	lea    eax,[ebp-0x48]
   30e69:	50                   	push   eax
   30e6a:	e8 95 09 00 00       	call   31804 <strcat>
   30e6f:	83 c4 10             	add    esp,0x10
   30e72:	83 ec 08             	sub    esp,0x8
   30e75:	6a 0f                	push   0xf
   30e77:	8d 45 b8             	lea    eax,[ebp-0x48]
   30e7a:	50                   	push   eax
   30e7b:	e8 c7 06 00 00       	call   31547 <disp_color_str>
   30e80:	83 c4 10             	add    esp,0x10
   30e83:	83 ec 08             	sub    esp,0x8
   30e86:	6a 00                	push   0x0
   30e88:	6a 03                	push   0x3
   30e8a:	e8 54 0a 00 00       	call   318e3 <set_disp_pos>
   30e8f:	83 c4 10             	add    esp,0x10
   30e92:	83 ec 08             	sub    esp,0x8
   30e95:	ff 75 10             	push   DWORD PTR [ebp+0x10]
   30e98:	8d 85 78 ff ff ff    	lea    eax,[ebp-0x88]
   30e9e:	50                   	push   eax
   30e9f:	e8 5f 08 00 00       	call   31703 <itoa_hex>
   30ea4:	83 c4 10             	add    esp,0x10
   30ea7:	83 ec 08             	sub    esp,0x8
   30eaa:	8d 83 57 e1 ff ff    	lea    eax,[ebx-0x1ea9]
   30eb0:	50                   	push   eax
   30eb1:	8d 45 b8             	lea    eax,[ebp-0x48]
   30eb4:	50                   	push   eax
   30eb5:	e8 bd 09 00 00       	call   31877 <strcpy>
   30eba:	83 c4 10             	add    esp,0x10
   30ebd:	83 ec 08             	sub    esp,0x8
   30ec0:	8d 85 78 ff ff ff    	lea    eax,[ebp-0x88]
   30ec6:	50                   	push   eax
   30ec7:	8d 45 b8             	lea    eax,[ebp-0x48]
   30eca:	50                   	push   eax
   30ecb:	e8 34 09 00 00       	call   31804 <strcat>
   30ed0:	83 c4 10             	add    esp,0x10
   30ed3:	83 ec 08             	sub    esp,0x8
   30ed6:	6a 0f                	push   0xf
   30ed8:	8d 45 b8             	lea    eax,[ebp-0x48]
   30edb:	50                   	push   eax
   30edc:	e8 66 06 00 00       	call   31547 <disp_color_str>
   30ee1:	83 c4 10             	add    esp,0x10
   30ee4:	83 ec 08             	sub    esp,0x8
   30ee7:	6a 00                	push   0x0
   30ee9:	6a 04                	push   0x4
   30eeb:	e8 f3 09 00 00       	call   318e3 <set_disp_pos>
   30ef0:	83 c4 10             	add    esp,0x10
   30ef3:	83 ec 08             	sub    esp,0x8
   30ef6:	ff 75 14             	push   DWORD PTR [ebp+0x14]
   30ef9:	8d 85 78 ff ff ff    	lea    eax,[ebp-0x88]
   30eff:	50                   	push   eax
   30f00:	e8 fe 07 00 00       	call   31703 <itoa_hex>
   30f05:	83 c4 10             	add    esp,0x10
   30f08:	83 ec 08             	sub    esp,0x8
   30f0b:	8d 83 5c e1 ff ff    	lea    eax,[ebx-0x1ea4]
   30f11:	50                   	push   eax
   30f12:	8d 45 b8             	lea    eax,[ebp-0x48]
   30f15:	50                   	push   eax
   30f16:	e8 5c 09 00 00       	call   31877 <strcpy>
   30f1b:	83 c4 10             	add    esp,0x10
   30f1e:	83 ec 08             	sub    esp,0x8
   30f21:	8d 85 78 ff ff ff    	lea    eax,[ebp-0x88]
   30f27:	50                   	push   eax
   30f28:	8d 45 b8             	lea    eax,[ebp-0x48]
   30f2b:	50                   	push   eax
   30f2c:	e8 d3 08 00 00       	call   31804 <strcat>
   30f31:	83 c4 10             	add    esp,0x10
   30f34:	83 ec 08             	sub    esp,0x8
   30f37:	6a 0f                	push   0xf
   30f39:	8d 45 b8             	lea    eax,[ebp-0x48]
   30f3c:	50                   	push   eax
   30f3d:	e8 05 06 00 00       	call   31547 <disp_color_str>
   30f42:	83 c4 10             	add    esp,0x10
   30f45:	83 ec 08             	sub    esp,0x8
   30f48:	6a 00                	push   0x0
   30f4a:	6a 05                	push   0x5
   30f4c:	e8 92 09 00 00       	call   318e3 <set_disp_pos>
   30f51:	83 c4 10             	add    esp,0x10
   30f54:	83 ec 08             	sub    esp,0x8
   30f57:	ff 75 18             	push   DWORD PTR [ebp+0x18]
   30f5a:	8d 85 78 ff ff ff    	lea    eax,[ebp-0x88]
   30f60:	50                   	push   eax
   30f61:	e8 9d 07 00 00       	call   31703 <itoa_hex>
   30f66:	83 c4 10             	add    esp,0x10
   30f69:	83 ec 08             	sub    esp,0x8
   30f6c:	8d 83 60 e1 ff ff    	lea    eax,[ebx-0x1ea0]
   30f72:	50                   	push   eax
   30f73:	8d 45 b8             	lea    eax,[ebp-0x48]
   30f76:	50                   	push   eax
   30f77:	e8 fb 08 00 00       	call   31877 <strcpy>
   30f7c:	83 c4 10             	add    esp,0x10
   30f7f:	83 ec 08             	sub    esp,0x8
   30f82:	8d 85 78 ff ff ff    	lea    eax,[ebp-0x88]
   30f88:	50                   	push   eax
   30f89:	8d 45 b8             	lea    eax,[ebp-0x48]
   30f8c:	50                   	push   eax
   30f8d:	e8 72 08 00 00       	call   31804 <strcat>
   30f92:	83 c4 10             	add    esp,0x10
   30f95:	83 ec 08             	sub    esp,0x8
   30f98:	6a 0f                	push   0xf
   30f9a:	8d 45 b8             	lea    eax,[ebp-0x48]
   30f9d:	50                   	push   eax
   30f9e:	e8 a4 05 00 00       	call   31547 <disp_color_str>
   30fa3:	83 c4 10             	add    esp,0x10
   30fa6:	90                   	nop
   30fa7:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
   30faa:	c9                   	leave
   30fab:	c3                   	ret

00030fac <init_idt_desc>:
   30fac:	55                   	push   ebp
   30fad:	89 e5                	mov    ebp,esp
   30faf:	53                   	push   ebx
   30fb0:	83 ec 1c             	sub    esp,0x1c
   30fb3:	e8 75 f8 ff ff       	call   3082d <__x86.get_pc_thunk.ax>
   30fb8:	05 3c 30 00 00       	add    eax,0x303c
   30fbd:	8b 5d 08             	mov    ebx,DWORD PTR [ebp+0x8]
   30fc0:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
   30fc3:	8b 55 14             	mov    edx,DWORD PTR [ebp+0x14]
   30fc6:	88 5d e8             	mov    BYTE PTR [ebp-0x18],bl
   30fc9:	88 4d e4             	mov    BYTE PTR [ebp-0x1c],cl
   30fcc:	88 55 e0             	mov    BYTE PTR [ebp-0x20],dl
   30fcf:	0f b6 55 e8          	movzx  edx,BYTE PTR [ebp-0x18]
   30fd3:	c1 e2 03             	shl    edx,0x3
   30fd6:	c7 c0 40 4d 03 00    	mov    eax,0x34d40
   30fdc:	01 d0                	add    eax,edx
   30fde:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
   30fe1:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
   30fe4:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
   30fe7:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
   30fea:	89 c2                	mov    edx,eax
   30fec:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
   30fef:	66 89 10             	mov    WORD PTR [eax],dx
   30ff2:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
   30ff5:	66 c7 40 02 08 00    	mov    WORD PTR [eax+0x2],0x8
   30ffb:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
   30ffe:	c6 40 04 00          	mov    BYTE PTR [eax+0x4],0x0
   31002:	0f b6 45 e0          	movzx  eax,BYTE PTR [ebp-0x20]
   31006:	c1 e0 05             	shl    eax,0x5
   31009:	89 c2                	mov    edx,eax
   3100b:	0f b6 45 e4          	movzx  eax,BYTE PTR [ebp-0x1c]
   3100f:	09 d0                	or     eax,edx
   31011:	89 c2                	mov    edx,eax
   31013:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
   31016:	88 50 05             	mov    BYTE PTR [eax+0x5],dl
   31019:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
   3101c:	c1 e8 10             	shr    eax,0x10
   3101f:	89 c2                	mov    edx,eax
   31021:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
   31024:	66 89 50 06          	mov    WORD PTR [eax+0x6],dx
   31028:	90                   	nop
   31029:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
   3102c:	c9                   	leave
   3102d:	c3                   	ret

0003102e <init_protect>:
   3102e:	55                   	push   ebp
   3102f:	89 e5                	mov    ebp,esp
   31031:	53                   	push   ebx
   31032:	83 ec 14             	sub    esp,0x14
   31035:	e8 1f f7 ff ff       	call   30759 <__x86.get_pc_thunk.bx>
   3103a:	81 c3 ba 2f 00 00    	add    ebx,0x2fba
   31040:	e8 19 fb ff ff       	call   30b5e <init_8259A>
   31045:	6a 00                	push   0x0
   31047:	c7 c0 bb 06 03 00    	mov    eax,0x306bb
   3104d:	50                   	push   eax
   3104e:	68 8e 00 00 00       	push   0x8e
   31053:	6a 00                	push   0x0
   31055:	e8 52 ff ff ff       	call   30fac <init_idt_desc>
   3105a:	83 c4 10             	add    esp,0x10
   3105d:	6a 00                	push   0x0
   3105f:	c7 c0 c1 06 03 00    	mov    eax,0x306c1
   31065:	50                   	push   eax
   31066:	68 8e 00 00 00       	push   0x8e
   3106b:	6a 01                	push   0x1
   3106d:	e8 3a ff ff ff       	call   30fac <init_idt_desc>
   31072:	83 c4 10             	add    esp,0x10
   31075:	6a 00                	push   0x0
   31077:	c7 c0 c7 06 03 00    	mov    eax,0x306c7
   3107d:	50                   	push   eax
   3107e:	68 8e 00 00 00       	push   0x8e
   31083:	6a 02                	push   0x2
   31085:	e8 22 ff ff ff       	call   30fac <init_idt_desc>
   3108a:	83 c4 10             	add    esp,0x10
   3108d:	6a 03                	push   0x3
   3108f:	c7 c0 cd 06 03 00    	mov    eax,0x306cd
   31095:	50                   	push   eax
   31096:	68 8e 00 00 00       	push   0x8e
   3109b:	6a 03                	push   0x3
   3109d:	e8 0a ff ff ff       	call   30fac <init_idt_desc>
   310a2:	83 c4 10             	add    esp,0x10
   310a5:	6a 03                	push   0x3
   310a7:	c7 c0 d3 06 03 00    	mov    eax,0x306d3
   310ad:	50                   	push   eax
   310ae:	68 8e 00 00 00       	push   0x8e
   310b3:	6a 04                	push   0x4
   310b5:	e8 f2 fe ff ff       	call   30fac <init_idt_desc>
   310ba:	83 c4 10             	add    esp,0x10
   310bd:	6a 00                	push   0x0
   310bf:	c7 c0 d9 06 03 00    	mov    eax,0x306d9
   310c5:	50                   	push   eax
   310c6:	68 8e 00 00 00       	push   0x8e
   310cb:	6a 05                	push   0x5
   310cd:	e8 da fe ff ff       	call   30fac <init_idt_desc>
   310d2:	83 c4 10             	add    esp,0x10
   310d5:	6a 00                	push   0x0
   310d7:	c7 c0 df 06 03 00    	mov    eax,0x306df
   310dd:	50                   	push   eax
   310de:	68 8e 00 00 00       	push   0x8e
   310e3:	6a 06                	push   0x6
   310e5:	e8 c2 fe ff ff       	call   30fac <init_idt_desc>
   310ea:	83 c4 10             	add    esp,0x10
   310ed:	6a 00                	push   0x0
   310ef:	c7 c0 e5 06 03 00    	mov    eax,0x306e5
   310f5:	50                   	push   eax
   310f6:	68 8e 00 00 00       	push   0x8e
   310fb:	6a 07                	push   0x7
   310fd:	e8 aa fe ff ff       	call   30fac <init_idt_desc>
   31102:	83 c4 10             	add    esp,0x10
   31105:	6a 00                	push   0x0
   31107:	c7 c0 eb 06 03 00    	mov    eax,0x306eb
   3110d:	50                   	push   eax
   3110e:	68 8e 00 00 00       	push   0x8e
   31113:	6a 08                	push   0x8
   31115:	e8 92 fe ff ff       	call   30fac <init_idt_desc>
   3111a:	83 c4 10             	add    esp,0x10
   3111d:	6a 00                	push   0x0
   3111f:	c7 c0 ef 06 03 00    	mov    eax,0x306ef
   31125:	50                   	push   eax
   31126:	68 8e 00 00 00       	push   0x8e
   3112b:	6a 09                	push   0x9
   3112d:	e8 7a fe ff ff       	call   30fac <init_idt_desc>
   31132:	83 c4 10             	add    esp,0x10
   31135:	6a 00                	push   0x0
   31137:	c7 c0 f5 06 03 00    	mov    eax,0x306f5
   3113d:	50                   	push   eax
   3113e:	68 8e 00 00 00       	push   0x8e
   31143:	6a 0a                	push   0xa
   31145:	e8 62 fe ff ff       	call   30fac <init_idt_desc>
   3114a:	83 c4 10             	add    esp,0x10
   3114d:	6a 00                	push   0x0
   3114f:	c7 c0 f9 06 03 00    	mov    eax,0x306f9
   31155:	50                   	push   eax
   31156:	68 8e 00 00 00       	push   0x8e
   3115b:	6a 0b                	push   0xb
   3115d:	e8 4a fe ff ff       	call   30fac <init_idt_desc>
   31162:	83 c4 10             	add    esp,0x10
   31165:	6a 00                	push   0x0
   31167:	c7 c0 fd 06 03 00    	mov    eax,0x306fd
   3116d:	50                   	push   eax
   3116e:	68 8e 00 00 00       	push   0x8e
   31173:	6a 0c                	push   0xc
   31175:	e8 32 fe ff ff       	call   30fac <init_idt_desc>
   3117a:	83 c4 10             	add    esp,0x10
   3117d:	6a 00                	push   0x0
   3117f:	c7 c0 01 07 03 00    	mov    eax,0x30701
   31185:	50                   	push   eax
   31186:	68 8e 00 00 00       	push   0x8e
   3118b:	6a 0d                	push   0xd
   3118d:	e8 1a fe ff ff       	call   30fac <init_idt_desc>
   31192:	83 c4 10             	add    esp,0x10
   31195:	6a 00                	push   0x0
   31197:	c7 c0 05 07 03 00    	mov    eax,0x30705
   3119d:	50                   	push   eax
   3119e:	68 8e 00 00 00       	push   0x8e
   311a3:	6a 0e                	push   0xe
   311a5:	e8 02 fe ff ff       	call   30fac <init_idt_desc>
   311aa:	83 c4 10             	add    esp,0x10
   311ad:	6a 00                	push   0x0
   311af:	c7 c0 09 07 03 00    	mov    eax,0x30709
   311b5:	50                   	push   eax
   311b6:	68 8e 00 00 00       	push   0x8e
   311bb:	6a 10                	push   0x10
   311bd:	e8 ea fd ff ff       	call   30fac <init_idt_desc>
   311c2:	83 c4 10             	add    esp,0x10
   311c5:	6a 00                	push   0x0
   311c7:	c7 c0 c0 04 03 00    	mov    eax,0x304c0
   311cd:	50                   	push   eax
   311ce:	68 8e 00 00 00       	push   0x8e
   311d3:	6a 20                	push   0x20
   311d5:	e8 d2 fd ff ff       	call   30fac <init_idt_desc>
   311da:	83 c4 10             	add    esp,0x10
   311dd:	6a 00                	push   0x0
   311df:	c7 c0 f0 04 03 00    	mov    eax,0x304f0
   311e5:	50                   	push   eax
   311e6:	68 8e 00 00 00       	push   0x8e
   311eb:	6a 21                	push   0x21
   311ed:	e8 ba fd ff ff       	call   30fac <init_idt_desc>
   311f2:	83 c4 10             	add    esp,0x10
   311f5:	6a 00                	push   0x0
   311f7:	c7 c0 20 05 03 00    	mov    eax,0x30520
   311fd:	50                   	push   eax
   311fe:	68 8e 00 00 00       	push   0x8e
   31203:	6a 22                	push   0x22
   31205:	e8 a2 fd ff ff       	call   30fac <init_idt_desc>
   3120a:	83 c4 10             	add    esp,0x10
   3120d:	6a 00                	push   0x0
   3120f:	c7 c0 50 05 03 00    	mov    eax,0x30550
   31215:	50                   	push   eax
   31216:	68 8e 00 00 00       	push   0x8e
   3121b:	6a 23                	push   0x23
   3121d:	e8 8a fd ff ff       	call   30fac <init_idt_desc>
   31222:	83 c4 10             	add    esp,0x10
   31225:	6a 00                	push   0x0
   31227:	c7 c0 80 05 03 00    	mov    eax,0x30580
   3122d:	50                   	push   eax
   3122e:	68 8e 00 00 00       	push   0x8e
   31233:	6a 24                	push   0x24
   31235:	e8 72 fd ff ff       	call   30fac <init_idt_desc>
   3123a:	83 c4 10             	add    esp,0x10
   3123d:	6a 00                	push   0x0
   3123f:	c7 c0 b0 05 03 00    	mov    eax,0x305b0
   31245:	50                   	push   eax
   31246:	68 8e 00 00 00       	push   0x8e
   3124b:	6a 25                	push   0x25
   3124d:	e8 5a fd ff ff       	call   30fac <init_idt_desc>
   31252:	83 c4 10             	add    esp,0x10
   31255:	6a 00                	push   0x0
   31257:	c7 c0 e0 05 03 00    	mov    eax,0x305e0
   3125d:	50                   	push   eax
   3125e:	68 8e 00 00 00       	push   0x8e
   31263:	6a 26                	push   0x26
   31265:	e8 42 fd ff ff       	call   30fac <init_idt_desc>
   3126a:	83 c4 10             	add    esp,0x10
   3126d:	6a 00                	push   0x0
   3126f:	c7 c0 10 06 03 00    	mov    eax,0x30610
   31275:	50                   	push   eax
   31276:	68 8e 00 00 00       	push   0x8e
   3127b:	6a 27                	push   0x27
   3127d:	e8 2a fd ff ff       	call   30fac <init_idt_desc>
   31282:	83 c4 10             	add    esp,0x10
   31285:	6a 00                	push   0x0
   31287:	c7 c0 40 06 03 00    	mov    eax,0x30640
   3128d:	50                   	push   eax
   3128e:	68 8e 00 00 00       	push   0x8e
   31293:	6a 28                	push   0x28
   31295:	e8 12 fd ff ff       	call   30fac <init_idt_desc>
   3129a:	83 c4 10             	add    esp,0x10
   3129d:	6a 00                	push   0x0
   3129f:	c7 c0 50 06 03 00    	mov    eax,0x30650
   312a5:	50                   	push   eax
   312a6:	68 8e 00 00 00       	push   0x8e
   312ab:	6a 29                	push   0x29
   312ad:	e8 fa fc ff ff       	call   30fac <init_idt_desc>
   312b2:	83 c4 10             	add    esp,0x10
   312b5:	6a 00                	push   0x0
   312b7:	c7 c0 60 06 03 00    	mov    eax,0x30660
   312bd:	50                   	push   eax
   312be:	68 8e 00 00 00       	push   0x8e
   312c3:	6a 2a                	push   0x2a
   312c5:	e8 e2 fc ff ff       	call   30fac <init_idt_desc>
   312ca:	83 c4 10             	add    esp,0x10
   312cd:	6a 00                	push   0x0
   312cf:	c7 c0 70 06 03 00    	mov    eax,0x30670
   312d5:	50                   	push   eax
   312d6:	68 8e 00 00 00       	push   0x8e
   312db:	6a 2b                	push   0x2b
   312dd:	e8 ca fc ff ff       	call   30fac <init_idt_desc>
   312e2:	83 c4 10             	add    esp,0x10
   312e5:	6a 00                	push   0x0
   312e7:	c7 c0 80 06 03 00    	mov    eax,0x30680
   312ed:	50                   	push   eax
   312ee:	68 8e 00 00 00       	push   0x8e
   312f3:	6a 2c                	push   0x2c
   312f5:	e8 b2 fc ff ff       	call   30fac <init_idt_desc>
   312fa:	83 c4 10             	add    esp,0x10
   312fd:	6a 00                	push   0x0
   312ff:	c7 c0 90 06 03 00    	mov    eax,0x30690
   31305:	50                   	push   eax
   31306:	68 8e 00 00 00       	push   0x8e
   3130b:	6a 2d                	push   0x2d
   3130d:	e8 9a fc ff ff       	call   30fac <init_idt_desc>
   31312:	83 c4 10             	add    esp,0x10
   31315:	6a 00                	push   0x0
   31317:	c7 c0 a0 06 03 00    	mov    eax,0x306a0
   3131d:	50                   	push   eax
   3131e:	68 8e 00 00 00       	push   0x8e
   31323:	6a 2e                	push   0x2e
   31325:	e8 82 fc ff ff       	call   30fac <init_idt_desc>
   3132a:	83 c4 10             	add    esp,0x10
   3132d:	6a 00                	push   0x0
   3132f:	c7 c0 b0 06 03 00    	mov    eax,0x306b0
   31335:	50                   	push   eax
   31336:	68 8e 00 00 00       	push   0x8e
   3133b:	6a 2f                	push   0x2f
   3133d:	e8 6a fc ff ff       	call   30fac <init_idt_desc>
   31342:	83 c4 10             	add    esp,0x10
   31345:	6a 03                	push   0x3
   31347:	c7 c0 9f 04 03 00    	mov    eax,0x3049f
   3134d:	50                   	push   eax
   3134e:	68 8e 00 00 00       	push   0x8e
   31353:	68 90 00 00 00       	push   0x90
   31358:	e8 4f fc ff ff       	call   30fac <init_idt_desc>
   3135d:	83 c4 10             	add    esp,0x10
   31360:	83 ec 04             	sub    esp,0x4
   31363:	6a 68                	push   0x68
   31365:	6a 00                	push   0x0
   31367:	c7 c0 40 55 03 00    	mov    eax,0x35540
   3136d:	50                   	push   eax
   3136e:	e8 59 02 00 00       	call   315cc <memset>
   31373:	83 c4 10             	add    esp,0x10
   31376:	83 ec 0c             	sub    esp,0xc
   31379:	6a 10                	push   0x10
   3137b:	e8 a1 00 00 00       	call   31421 <seg2phys>
   31380:	83 c4 10             	add    esp,0x10
   31383:	c7 c2 40 55 03 00    	mov    edx,0x35540
   31389:	01 d0                	add    eax,edx
   3138b:	68 89 00 00 00       	push   0x89
   31390:	6a 67                	push   0x67
   31392:	50                   	push   eax
   31393:	c7 c0 20 49 03 00    	mov    eax,0x34920
   31399:	8d 40 20             	lea    eax,[eax+0x20]
   3139c:	50                   	push   eax
   3139d:	e8 db 00 00 00       	call   3147d <init_descriptor>
   313a2:	83 c4 10             	add    esp,0x10
   313a5:	c7 c0 40 55 03 00    	mov    eax,0x35540
   313ab:	c7 40 08 10 00 00 00 	mov    DWORD PTR [eax+0x8],0x10
   313b2:	c7 c0 40 55 03 00    	mov    eax,0x35540
   313b8:	66 c7 40 66 68 00    	mov    WORD PTR [eax+0x66],0x68
   313be:	c7 45 f4 00 00 00 00 	mov    DWORD PTR [ebp-0xc],0x0
   313c5:	eb 4d                	jmp    31414 <init_protect+0x3e6>
   313c7:	83 ec 0c             	sub    esp,0xc
   313ca:	6a 10                	push   0x10
   313cc:	e8 50 00 00 00       	call   31421 <seg2phys>
   313d1:	83 c4 10             	add    esp,0x10
   313d4:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
   313d7:	c1 e2 07             	shl    edx,0x7
   313da:	8d 4a 40             	lea    ecx,[edx+0x40]
   313dd:	c7 c2 c0 55 03 00    	mov    edx,0x355c0
   313e3:	01 ca                	add    edx,ecx
   313e5:	83 c2 0a             	add    edx,0xa
   313e8:	01 c2                	add    edx,eax
   313ea:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
   313ed:	83 c0 05             	add    eax,0x5
   313f0:	8d 0c c5 00 00 00 00 	lea    ecx,[eax*8+0x0]
   313f7:	c7 c0 20 49 03 00    	mov    eax,0x34920
   313fd:	01 c8                	add    eax,ecx
   313ff:	68 82 00 00 00       	push   0x82
   31404:	6a 0f                	push   0xf
   31406:	52                   	push   edx
   31407:	50                   	push   eax
   31408:	e8 70 00 00 00       	call   3147d <init_descriptor>
   3140d:	83 c4 10             	add    esp,0x10
   31410:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
   31414:	83 7d f4 02          	cmp    DWORD PTR [ebp-0xc],0x2
   31418:	7e ad                	jle    313c7 <init_protect+0x399>
   3141a:	90                   	nop
   3141b:	90                   	nop
   3141c:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
   3141f:	c9                   	leave
   31420:	c3                   	ret

00031421 <seg2phys>:
   31421:	55                   	push   ebp
   31422:	89 e5                	mov    ebp,esp
   31424:	83 ec 14             	sub    esp,0x14
   31427:	e8 01 f4 ff ff       	call   3082d <__x86.get_pc_thunk.ax>
   3142c:	05 c8 2b 00 00       	add    eax,0x2bc8
   31431:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
   31434:	66 89 55 ec          	mov    WORD PTR [ebp-0x14],dx
   31438:	0f b7 55 ec          	movzx  edx,WORD PTR [ebp-0x14]
   3143c:	66 c1 ea 03          	shr    dx,0x3
   31440:	0f b7 d2             	movzx  edx,dx
   31443:	c1 e2 03             	shl    edx,0x3
   31446:	c7 c0 20 49 03 00    	mov    eax,0x34920
   3144c:	01 d0                	add    eax,edx
   3144e:	89 45 fc             	mov    DWORD PTR [ebp-0x4],eax
   31451:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
   31454:	0f b6 40 07          	movzx  eax,BYTE PTR [eax+0x7]
   31458:	0f b6 c0             	movzx  eax,al
   3145b:	c1 e0 18             	shl    eax,0x18
   3145e:	89 c2                	mov    edx,eax
   31460:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
   31463:	0f b6 40 04          	movzx  eax,BYTE PTR [eax+0x4]
   31467:	0f b6 c0             	movzx  eax,al
   3146a:	c1 e0 10             	shl    eax,0x10
   3146d:	09 c2                	or     edx,eax
   3146f:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
   31472:	0f b7 40 02          	movzx  eax,WORD PTR [eax+0x2]
   31476:	0f b7 c0             	movzx  eax,ax
   31479:	09 d0                	or     eax,edx
   3147b:	c9                   	leave
   3147c:	c3                   	ret

0003147d <init_descriptor>:
   3147d:	55                   	push   ebp
   3147e:	89 e5                	mov    ebp,esp
   31480:	83 ec 04             	sub    esp,0x4
   31483:	e8 a5 f3 ff ff       	call   3082d <__x86.get_pc_thunk.ax>
   31488:	05 6c 2b 00 00       	add    eax,0x2b6c
   3148d:	8b 45 14             	mov    eax,DWORD PTR [ebp+0x14]
   31490:	66 89 45 fc          	mov    WORD PTR [ebp-0x4],ax
   31494:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
   31497:	89 c2                	mov    edx,eax
   31499:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   3149c:	66 89 10             	mov    WORD PTR [eax],dx
   3149f:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
   314a2:	89 c2                	mov    edx,eax
   314a4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   314a7:	66 89 50 02          	mov    WORD PTR [eax+0x2],dx
   314ab:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
   314ae:	c1 e8 10             	shr    eax,0x10
   314b1:	89 c2                	mov    edx,eax
   314b3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   314b6:	88 50 04             	mov    BYTE PTR [eax+0x4],dl
   314b9:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
   314bd:	89 c2                	mov    edx,eax
   314bf:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   314c2:	88 50 05             	mov    BYTE PTR [eax+0x5],dl
   314c5:	8b 45 10             	mov    eax,DWORD PTR [ebp+0x10]
   314c8:	c1 e8 10             	shr    eax,0x10
   314cb:	83 e0 0f             	and    eax,0xf
   314ce:	89 c2                	mov    edx,eax
   314d0:	0f b7 45 fc          	movzx  eax,WORD PTR [ebp-0x4]
   314d4:	66 c1 e8 08          	shr    ax,0x8
   314d8:	83 e0 f0             	and    eax,0xfffffff0
   314db:	09 c2                	or     edx,eax
   314dd:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   314e0:	88 50 06             	mov    BYTE PTR [eax+0x6],dl
   314e3:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
   314e6:	c1 e8 18             	shr    eax,0x18
   314e9:	89 c2                	mov    edx,eax
   314eb:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   314ee:	88 50 07             	mov    BYTE PTR [eax+0x7],dl
   314f1:	90                   	nop
   314f2:	c9                   	leave
   314f3:	c3                   	ret
   314f4:	66 90                	xchg   ax,ax
   314f6:	66 90                	xchg   ax,ax
   314f8:	66 90                	xchg   ax,ax
   314fa:	66 90                	xchg   ax,ax
   314fc:	66 90                	xchg   ax,ax
   314fe:	66 90                	xchg   ax,ax

00031500 <disp_str>:
   31500:	55                   	push   ebp
   31501:	89 e5                	mov    ebp,esp
   31503:	56                   	push   esi
   31504:	57                   	push   edi
   31505:	53                   	push   ebx
   31506:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
   31509:	8b 3d 00 49 03 00    	mov    edi,DWORD PTR ds:0x34900
   3150f:	b4 0f                	mov    ah,0xf
   31511:	fc                   	cld

00031512 <disp_str.1>:
   31512:	ac                   	lods   al,BYTE PTR ds:[esi]
   31513:	84 c0                	test   al,al
   31515:	74 23                	je     3153a <disp_str.2>
   31517:	3c 0a                	cmp    al,0xa
   31519:	75 16                	jne    31531 <disp_str.3>
   3151b:	50                   	push   eax
   3151c:	89 f8                	mov    eax,edi
   3151e:	b3 a0                	mov    bl,0xa0
   31520:	f6 f3                	div    bl
   31522:	25 ff 00 00 00       	and    eax,0xff
   31527:	40                   	inc    eax
   31528:	b3 a0                	mov    bl,0xa0
   3152a:	f6 e3                	mul    bl
   3152c:	89 c7                	mov    edi,eax
   3152e:	58                   	pop    eax
   3152f:	eb e1                	jmp    31512 <disp_str.1>

00031531 <disp_str.3>:
   31531:	65 66 89 07          	mov    WORD PTR gs:[edi],ax
   31535:	83 c7 02             	add    edi,0x2
   31538:	eb d8                	jmp    31512 <disp_str.1>

0003153a <disp_str.2>:
   3153a:	89 3d 00 49 03 00    	mov    DWORD PTR ds:0x34900,edi
   31540:	5b                   	pop    ebx
   31541:	5f                   	pop    edi
   31542:	5e                   	pop    esi
   31543:	89 ec                	mov    esp,ebp
   31545:	5d                   	pop    ebp
   31546:	c3                   	ret

00031547 <disp_color_str>:
   31547:	55                   	push   ebp
   31548:	89 e5                	mov    ebp,esp
   3154a:	56                   	push   esi
   3154b:	57                   	push   edi
   3154c:	53                   	push   ebx
   3154d:	8b 75 08             	mov    esi,DWORD PTR [ebp+0x8]
   31550:	8b 3d 00 49 03 00    	mov    edi,DWORD PTR ds:0x34900
   31556:	8a 65 0c             	mov    ah,BYTE PTR [ebp+0xc]
   31559:	fc                   	cld

0003155a <disp_color_str.1>:
   3155a:	ac                   	lods   al,BYTE PTR ds:[esi]
   3155b:	84 c0                	test   al,al
   3155d:	74 23                	je     31582 <disp_color_str.2>
   3155f:	3c 0a                	cmp    al,0xa
   31561:	75 16                	jne    31579 <disp_color_str.3>
   31563:	50                   	push   eax
   31564:	89 f8                	mov    eax,edi
   31566:	b3 a0                	mov    bl,0xa0
   31568:	f6 f3                	div    bl
   3156a:	25 ff 00 00 00       	and    eax,0xff
   3156f:	40                   	inc    eax
   31570:	b3 a0                	mov    bl,0xa0
   31572:	f6 e3                	mul    bl
   31574:	89 c7                	mov    edi,eax
   31576:	58                   	pop    eax
   31577:	eb e1                	jmp    3155a <disp_color_str.1>

00031579 <disp_color_str.3>:
   31579:	65 66 89 07          	mov    WORD PTR gs:[edi],ax
   3157d:	83 c7 02             	add    edi,0x2
   31580:	eb d8                	jmp    3155a <disp_color_str.1>

00031582 <disp_color_str.2>:
   31582:	89 3d 00 49 03 00    	mov    DWORD PTR ds:0x34900,edi
   31588:	5b                   	pop    ebx
   31589:	5f                   	pop    edi
   3158a:	5e                   	pop    esi
   3158b:	89 ec                	mov    esp,ebp
   3158d:	5d                   	pop    ebp
   3158e:	c3                   	ret

0003158f <out_byte>:
   3158f:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
   31593:	8a 44 24 08          	mov    al,BYTE PTR [esp+0x8]
   31597:	ee                   	out    dx,al
   31598:	90                   	nop
   31599:	90                   	nop
   3159a:	c3                   	ret

0003159b <in_byte>:
   3159b:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
   3159f:	31 c0                	xor    eax,eax
   315a1:	ec                   	in     al,dx
   315a2:	90                   	nop
   315a3:	90                   	nop
   315a4:	c3                   	ret

000315a5 <get_reg_ss>:
   315a5:	31 c0                	xor    eax,eax
   315a7:	66 8c d0             	mov    ax,ss
   315aa:	c3                   	ret

000315ab <get_reg_esp>:
   315ab:	31 c0                	xor    eax,eax
   315ad:	89 e0                	mov    eax,esp
   315af:	c3                   	ret

000315b0 <memcpy>:
   315b0:	55                   	push   ebp
   315b1:	89 e5                	mov    ebp,esp
   315b3:	56                   	push   esi
   315b4:	57                   	push   edi
   315b5:	51                   	push   ecx
   315b6:	8b 7d 08             	mov    edi,DWORD PTR [ebp+0x8]
   315b9:	8b 75 0c             	mov    esi,DWORD PTR [ebp+0xc]
   315bc:	8b 4d 10             	mov    ecx,DWORD PTR [ebp+0x10]
   315bf:	fc                   	cld
   315c0:	f3 a4                	rep movs BYTE PTR es:[edi],BYTE PTR ds:[esi]
   315c2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   315c5:	59                   	pop    ecx
   315c6:	5f                   	pop    edi
   315c7:	5e                   	pop    esi
   315c8:	89 ec                	mov    esp,ebp
   315ca:	5d                   	pop    ebp
   315cb:	c3                   	ret

000315cc <memset>:
   315cc:	55                   	push   ebp
   315cd:	89 e5                	mov    ebp,esp
   315cf:	57                   	push   edi
   315d0:	8b 7d 08             	mov    edi,DWORD PTR [ebp+0x8]
   315d3:	8a 45 0c             	mov    al,BYTE PTR [ebp+0xc]
   315d6:	8b 4d 10             	mov    ecx,DWORD PTR [ebp+0x10]
   315d9:	fc                   	cld
   315da:	f3 aa                	rep stos BYTE PTR es:[edi],al
   315dc:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   315df:	5e                   	pop    esi
   315e0:	89 ec                	mov    esp,ebp
   315e2:	5d                   	pop    ebp
   315e3:	c3                   	ret

000315e4 <itoa>:
   315e4:	55                   	push   ebp
   315e5:	89 e5                	mov    ebp,esp
   315e7:	83 ec 20             	sub    esp,0x20
   315ea:	e8 3e f2 ff ff       	call   3082d <__x86.get_pc_thunk.ax>
   315ef:	05 05 2a 00 00       	add    eax,0x2a05
   315f4:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
   315fb:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
   31602:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
   31606:	75 19                	jne    31621 <itoa+0x3d>
   31608:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   3160b:	c6 00 30             	mov    BYTE PTR [eax],0x30
   3160e:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   31611:	83 c0 01             	add    eax,0x1
   31614:	c6 00 00             	mov    BYTE PTR [eax],0x0
   31617:	b8 00 00 00 00       	mov    eax,0x0
   3161c:	e9 e0 00 00 00       	jmp    31701 <itoa+0x11d>
   31621:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
   31625:	79 72                	jns    31699 <itoa+0xb5>
   31627:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
   3162a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   3162d:	01 d0                	add    eax,edx
   3162f:	c6 00 2d             	mov    BYTE PTR [eax],0x2d
   31632:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
   31636:	f7 5d 0c             	neg    DWORD PTR [ebp+0xc]
   31639:	c7 45 f8 01 00 00 00 	mov    DWORD PTR [ebp-0x8],0x1
   31640:	eb 57                	jmp    31699 <itoa+0xb5>
   31642:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
   31645:	ba 67 66 66 66       	mov    edx,0x66666667
   3164a:	89 c8                	mov    eax,ecx
   3164c:	f7 ea                	imul   edx
   3164e:	c1 fa 02             	sar    edx,0x2
   31651:	89 c8                	mov    eax,ecx
   31653:	c1 f8 1f             	sar    eax,0x1f
   31656:	29 c2                	sub    edx,eax
   31658:	89 d0                	mov    eax,edx
   3165a:	c1 e0 02             	shl    eax,0x2
   3165d:	01 d0                	add    eax,edx
   3165f:	01 c0                	add    eax,eax
   31661:	29 c1                	sub    ecx,eax
   31663:	89 ca                	mov    edx,ecx
   31665:	89 55 e8             	mov    DWORD PTR [ebp-0x18],edx
   31668:	8b 4d 0c             	mov    ecx,DWORD PTR [ebp+0xc]
   3166b:	ba 67 66 66 66       	mov    edx,0x66666667
   31670:	89 c8                	mov    eax,ecx
   31672:	f7 ea                	imul   edx
   31674:	89 d0                	mov    eax,edx
   31676:	c1 f8 02             	sar    eax,0x2
   31679:	c1 f9 1f             	sar    ecx,0x1f
   3167c:	89 ca                	mov    edx,ecx
   3167e:	29 d0                	sub    eax,edx
   31680:	89 45 0c             	mov    DWORD PTR [ebp+0xc],eax
   31683:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
   31686:	8d 48 30             	lea    ecx,[eax+0x30]
   31689:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
   3168c:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   3168f:	01 d0                	add    eax,edx
   31691:	89 ca                	mov    edx,ecx
   31693:	88 10                	mov    BYTE PTR [eax],dl
   31695:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
   31699:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
   3169d:	7f a3                	jg     31642 <itoa+0x5e>
   3169f:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
   316a2:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
   316a5:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
   316a8:	83 e8 01             	sub    eax,0x1
   316ab:	89 45 f0             	mov    DWORD PTR [ebp-0x10],eax
   316ae:	eb 39                	jmp    316e9 <itoa+0x105>
   316b0:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
   316b3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   316b6:	01 d0                	add    eax,edx
   316b8:	0f b6 00             	movzx  eax,BYTE PTR [eax]
   316bb:	88 45 ef             	mov    BYTE PTR [ebp-0x11],al
   316be:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
   316c1:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   316c4:	01 d0                	add    eax,edx
   316c6:	8b 4d f4             	mov    ecx,DWORD PTR [ebp-0xc]
   316c9:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
   316cc:	01 ca                	add    edx,ecx
   316ce:	0f b6 00             	movzx  eax,BYTE PTR [eax]
   316d1:	88 02                	mov    BYTE PTR [edx],al
   316d3:	8b 55 f0             	mov    edx,DWORD PTR [ebp-0x10]
   316d6:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   316d9:	01 c2                	add    edx,eax
   316db:	0f b6 45 ef          	movzx  eax,BYTE PTR [ebp-0x11]
   316df:	88 02                	mov    BYTE PTR [edx],al
   316e1:	83 45 f4 01          	add    DWORD PTR [ebp-0xc],0x1
   316e5:	83 6d f0 01          	sub    DWORD PTR [ebp-0x10],0x1
   316e9:	8b 45 f4             	mov    eax,DWORD PTR [ebp-0xc]
   316ec:	3b 45 f0             	cmp    eax,DWORD PTR [ebp-0x10]
   316ef:	7c bf                	jl     316b0 <itoa+0xcc>
   316f1:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
   316f4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   316f7:	01 d0                	add    eax,edx
   316f9:	c6 00 00             	mov    BYTE PTR [eax],0x0
   316fc:	b8 00 00 00 00       	mov    eax,0x0
   31701:	c9                   	leave
   31702:	c3                   	ret

00031703 <itoa_hex>:
   31703:	55                   	push   ebp
   31704:	89 e5                	mov    ebp,esp
   31706:	83 ec 30             	sub    esp,0x30
   31709:	e8 1f f1 ff ff       	call   3082d <__x86.get_pc_thunk.ax>
   3170e:	05 e6 28 00 00       	add    eax,0x28e6
   31713:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   31716:	c6 00 30             	mov    BYTE PTR [eax],0x30
   31719:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   3171c:	83 c0 01             	add    eax,0x1
   3171f:	c6 00 78             	mov    BYTE PTR [eax],0x78
   31722:	c7 45 fc 02 00 00 00 	mov    DWORD PTR [ebp-0x4],0x2
   31729:	c7 45 f0 02 00 00 00 	mov    DWORD PTR [ebp-0x10],0x2
   31730:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
   31734:	75 1c                	jne    31752 <itoa_hex+0x4f>
   31736:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   31739:	83 c0 02             	add    eax,0x2
   3173c:	c6 00 30             	mov    BYTE PTR [eax],0x30
   3173f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   31742:	83 c0 03             	add    eax,0x3
   31745:	c6 00 00             	mov    BYTE PTR [eax],0x0
   31748:	b8 00 00 00 00       	mov    eax,0x0
   3174d:	e9 b0 00 00 00       	jmp    31802 <itoa_hex+0xff>
   31752:	c7 45 d7 30 31 32 33 	mov    DWORD PTR [ebp-0x29],0x33323130
   31759:	c7 45 db 34 35 36 37 	mov    DWORD PTR [ebp-0x25],0x37363534
   31760:	c7 45 df 38 39 61 62 	mov    DWORD PTR [ebp-0x21],0x62613938
   31767:	c7 45 e3 63 64 65 66 	mov    DWORD PTR [ebp-0x1d],0x66656463
   3176e:	c6 45 e7 00          	mov    BYTE PTR [ebp-0x19],0x0
   31772:	eb 26                	jmp    3179a <itoa_hex+0x97>
   31774:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
   31777:	83 e0 0f             	and    eax,0xf
   3177a:	89 45 e8             	mov    DWORD PTR [ebp-0x18],eax
   3177d:	c1 7d 0c 04          	sar    DWORD PTR [ebp+0xc],0x4
   31781:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
   31784:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   31787:	01 c2                	add    edx,eax
   31789:	8d 4d d7             	lea    ecx,[ebp-0x29]
   3178c:	8b 45 e8             	mov    eax,DWORD PTR [ebp-0x18]
   3178f:	01 c8                	add    eax,ecx
   31791:	0f b6 00             	movzx  eax,BYTE PTR [eax]
   31794:	88 02                	mov    BYTE PTR [edx],al
   31796:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
   3179a:	83 7d 0c 00          	cmp    DWORD PTR [ebp+0xc],0x0
   3179e:	75 d4                	jne    31774 <itoa_hex+0x71>
   317a0:	8b 45 f0             	mov    eax,DWORD PTR [ebp-0x10]
   317a3:	89 45 f8             	mov    DWORD PTR [ebp-0x8],eax
   317a6:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
   317a9:	83 e8 01             	sub    eax,0x1
   317ac:	89 45 f4             	mov    DWORD PTR [ebp-0xc],eax
   317af:	eb 39                	jmp    317ea <itoa_hex+0xe7>
   317b1:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
   317b4:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   317b7:	01 d0                	add    eax,edx
   317b9:	0f b6 00             	movzx  eax,BYTE PTR [eax]
   317bc:	88 45 ef             	mov    BYTE PTR [ebp-0x11],al
   317bf:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
   317c2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   317c5:	01 d0                	add    eax,edx
   317c7:	8b 4d f8             	mov    ecx,DWORD PTR [ebp-0x8]
   317ca:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
   317cd:	01 ca                	add    edx,ecx
   317cf:	0f b6 00             	movzx  eax,BYTE PTR [eax]
   317d2:	88 02                	mov    BYTE PTR [edx],al
   317d4:	8b 55 f4             	mov    edx,DWORD PTR [ebp-0xc]
   317d7:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   317da:	01 c2                	add    edx,eax
   317dc:	0f b6 45 ef          	movzx  eax,BYTE PTR [ebp-0x11]
   317e0:	88 02                	mov    BYTE PTR [edx],al
   317e2:	83 45 f8 01          	add    DWORD PTR [ebp-0x8],0x1
   317e6:	83 6d f4 01          	sub    DWORD PTR [ebp-0xc],0x1
   317ea:	8b 45 f8             	mov    eax,DWORD PTR [ebp-0x8]
   317ed:	3b 45 f4             	cmp    eax,DWORD PTR [ebp-0xc]
   317f0:	7c bf                	jl     317b1 <itoa_hex+0xae>
   317f2:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
   317f5:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   317f8:	01 d0                	add    eax,edx
   317fa:	c6 00 00             	mov    BYTE PTR [eax],0x0
   317fd:	b8 00 00 00 00       	mov    eax,0x0
   31802:	c9                   	leave
   31803:	c3                   	ret

00031804 <strcat>:
   31804:	55                   	push   ebp
   31805:	89 e5                	mov    ebp,esp
   31807:	83 ec 10             	sub    esp,0x10
   3180a:	e8 1e f0 ff ff       	call   3082d <__x86.get_pc_thunk.ax>
   3180f:	05 e5 27 00 00       	add    eax,0x27e5
   31814:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
   3181b:	eb 04                	jmp    31821 <strcat+0x1d>
   3181d:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
   31821:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
   31824:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   31827:	01 d0                	add    eax,edx
   31829:	0f b6 00             	movzx  eax,BYTE PTR [eax]
   3182c:	84 c0                	test   al,al
   3182e:	75 ed                	jne    3181d <strcat+0x19>
   31830:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
   31837:	eb 1d                	jmp    31856 <strcat+0x52>
   31839:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
   3183c:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
   3183f:	01 d0                	add    eax,edx
   31841:	8b 4d fc             	mov    ecx,DWORD PTR [ebp-0x4]
   31844:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
   31847:	01 ca                	add    edx,ecx
   31849:	0f b6 00             	movzx  eax,BYTE PTR [eax]
   3184c:	88 02                	mov    BYTE PTR [edx],al
   3184e:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
   31852:	83 45 f8 01          	add    DWORD PTR [ebp-0x8],0x1
   31856:	8b 55 f8             	mov    edx,DWORD PTR [ebp-0x8]
   31859:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
   3185c:	01 d0                	add    eax,edx
   3185e:	0f b6 00             	movzx  eax,BYTE PTR [eax]
   31861:	84 c0                	test   al,al
   31863:	75 d4                	jne    31839 <strcat+0x35>
   31865:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
   31868:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   3186b:	01 d0                	add    eax,edx
   3186d:	c6 00 00             	mov    BYTE PTR [eax],0x0
   31870:	b8 00 00 00 00       	mov    eax,0x0
   31875:	c9                   	leave
   31876:	c3                   	ret

00031877 <strcpy>:
   31877:	55                   	push   ebp
   31878:	89 e5                	mov    ebp,esp
   3187a:	53                   	push   ebx
   3187b:	83 ec 04             	sub    esp,0x4
   3187e:	e8 d6 ee ff ff       	call   30759 <__x86.get_pc_thunk.bx>
   31883:	81 c3 71 27 00 00    	add    ebx,0x2771
   31889:	83 ec 0c             	sub    esp,0xc
   3188c:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
   3188f:	e8 1e 00 00 00       	call   318b2 <strlen>
   31894:	83 c4 10             	add    esp,0x10
   31897:	83 c0 01             	add    eax,0x1
   3189a:	83 ec 04             	sub    esp,0x4
   3189d:	50                   	push   eax
   3189e:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
   318a1:	ff 75 08             	push   DWORD PTR [ebp+0x8]
   318a4:	e8 07 fd ff ff       	call   315b0 <memcpy>
   318a9:	83 c4 10             	add    esp,0x10
   318ac:	90                   	nop
   318ad:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
   318b0:	c9                   	leave
   318b1:	c3                   	ret

000318b2 <strlen>:
   318b2:	55                   	push   ebp
   318b3:	89 e5                	mov    ebp,esp
   318b5:	83 ec 10             	sub    esp,0x10
   318b8:	e8 70 ef ff ff       	call   3082d <__x86.get_pc_thunk.ax>
   318bd:	05 37 27 00 00       	add    eax,0x2737
   318c2:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
   318c9:	eb 04                	jmp    318cf <strlen+0x1d>
   318cb:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
   318cf:	8b 55 fc             	mov    edx,DWORD PTR [ebp-0x4]
   318d2:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   318d5:	01 d0                	add    eax,edx
   318d7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
   318da:	84 c0                	test   al,al
   318dc:	75 ed                	jne    318cb <strlen+0x19>
   318de:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
   318e1:	c9                   	leave
   318e2:	c3                   	ret

000318e3 <set_disp_pos>:
   318e3:	55                   	push   ebp
   318e4:	89 e5                	mov    ebp,esp
   318e6:	e8 c8 01 00 00       	call   31ab3 <__x86.get_pc_thunk.cx>
   318eb:	81 c1 09 27 00 00    	add    ecx,0x2709
   318f1:	83 7d 08 18          	cmp    DWORD PTR [ebp+0x8],0x18
   318f5:	76 07                	jbe    318fe <set_disp_pos+0x1b>
   318f7:	c7 45 08 18 00 00 00 	mov    DWORD PTR [ebp+0x8],0x18
   318fe:	83 7d 0c 4f          	cmp    DWORD PTR [ebp+0xc],0x4f
   31902:	76 07                	jbe    3190b <set_disp_pos+0x28>
   31904:	c7 45 0c 4f 00 00 00 	mov    DWORD PTR [ebp+0xc],0x4f
   3190b:	8b 55 08             	mov    edx,DWORD PTR [ebp+0x8]
   3190e:	89 d0                	mov    eax,edx
   31910:	c1 e0 02             	shl    eax,0x2
   31913:	01 d0                	add    eax,edx
   31915:	c1 e0 04             	shl    eax,0x4
   31918:	89 c2                	mov    edx,eax
   3191a:	8b 45 0c             	mov    eax,DWORD PTR [ebp+0xc]
   3191d:	01 d0                	add    eax,edx
   3191f:	8d 14 00             	lea    edx,[eax+eax*1]
   31922:	c7 c0 00 49 03 00    	mov    eax,0x34900
   31928:	89 10                	mov    DWORD PTR [eax],edx
   3192a:	90                   	nop
   3192b:	5d                   	pop    ebp
   3192c:	c3                   	ret

0003192d <disp_int>:
   3192d:	55                   	push   ebp
   3192e:	89 e5                	mov    ebp,esp
   31930:	53                   	push   ebx
   31931:	83 ec 14             	sub    esp,0x14
   31934:	e8 20 ee ff ff       	call   30759 <__x86.get_pc_thunk.bx>
   31939:	81 c3 bb 26 00 00    	add    ebx,0x26bb
   3193f:	83 ec 08             	sub    esp,0x8
   31942:	ff 75 08             	push   DWORD PTR [ebp+0x8]
   31945:	8d 45 e8             	lea    eax,[ebp-0x18]
   31948:	50                   	push   eax
   31949:	e8 b5 fd ff ff       	call   31703 <itoa_hex>
   3194e:	83 c4 10             	add    esp,0x10
   31951:	83 ec 0c             	sub    esp,0xc
   31954:	8d 45 e8             	lea    eax,[ebp-0x18]
   31957:	50                   	push   eax
   31958:	e8 a3 fb ff ff       	call   31500 <disp_str>
   3195d:	83 c4 10             	add    esp,0x10
   31960:	90                   	nop
   31961:	8b 5d fc             	mov    ebx,DWORD PTR [ebp-0x4]
   31964:	c9                   	leave
   31965:	c3                   	ret

00031966 <delay>:
   31966:	55                   	push   ebp
   31967:	89 e5                	mov    ebp,esp
   31969:	83 ec 10             	sub    esp,0x10
   3196c:	e8 bc ee ff ff       	call   3082d <__x86.get_pc_thunk.ax>
   31971:	05 83 26 00 00       	add    eax,0x2683
   31976:	c7 45 fc 00 00 00 00 	mov    DWORD PTR [ebp-0x4],0x0
   3197d:	eb 1a                	jmp    31999 <delay+0x33>
   3197f:	c7 45 f8 00 00 00 00 	mov    DWORD PTR [ebp-0x8],0x0
   31986:	eb 04                	jmp    3198c <delay+0x26>
   31988:	83 45 f8 01          	add    DWORD PTR [ebp-0x8],0x1
   3198c:	81 7d f8 4f c3 00 00 	cmp    DWORD PTR [ebp-0x8],0xc34f
   31993:	7e f3                	jle    31988 <delay+0x22>
   31995:	83 45 fc 01          	add    DWORD PTR [ebp-0x4],0x1
   31999:	8b 45 fc             	mov    eax,DWORD PTR [ebp-0x4]
   3199c:	3b 45 08             	cmp    eax,DWORD PTR [ebp+0x8]
   3199f:	7c de                	jl     3197f <delay+0x19>
   319a1:	90                   	nop
   319a2:	90                   	nop
   319a3:	c9                   	leave
   319a4:	c3                   	ret

000319a5 <disable_irq>:
   319a5:	55                   	push   ebp
   319a6:	89 e5                	mov    ebp,esp
   319a8:	56                   	push   esi
   319a9:	53                   	push   ebx
   319aa:	e8 aa ed ff ff       	call   30759 <__x86.get_pc_thunk.bx>
   319af:	81 c3 45 26 00 00    	add    ebx,0x2645
   319b5:	83 7d 08 07          	cmp    DWORD PTR [ebp+0x8],0x7
   319b9:	7f 32                	jg     319ed <disable_irq+0x48>
   319bb:	83 ec 0c             	sub    esp,0xc
   319be:	6a 21                	push   0x21
   319c0:	e8 d6 fb ff ff       	call   3159b <in_byte>
   319c5:	83 c4 10             	add    esp,0x10
   319c8:	89 c6                	mov    esi,eax
   319ca:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   319cd:	ba 01 00 00 00       	mov    edx,0x1
   319d2:	89 c1                	mov    ecx,eax
   319d4:	d3 e2                	shl    edx,cl
   319d6:	89 d0                	mov    eax,edx
   319d8:	09 f0                	or     eax,esi
   319da:	0f b6 c0             	movzx  eax,al
   319dd:	83 ec 08             	sub    esp,0x8
   319e0:	50                   	push   eax
   319e1:	6a 21                	push   0x21
   319e3:	e8 a7 fb ff ff       	call   3158f <out_byte>
   319e8:	83 c4 10             	add    esp,0x10
   319eb:	eb 36                	jmp    31a23 <disable_irq+0x7e>
   319ed:	83 ec 0c             	sub    esp,0xc
   319f0:	68 a1 00 00 00       	push   0xa1
   319f5:	e8 a1 fb ff ff       	call   3159b <in_byte>
   319fa:	83 c4 10             	add    esp,0x10
   319fd:	89 c6                	mov    esi,eax
   319ff:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   31a02:	ba 01 00 00 00       	mov    edx,0x1
   31a07:	89 c1                	mov    ecx,eax
   31a09:	d3 e2                	shl    edx,cl
   31a0b:	89 d0                	mov    eax,edx
   31a0d:	09 f0                	or     eax,esi
   31a0f:	0f b6 c0             	movzx  eax,al
   31a12:	83 ec 08             	sub    esp,0x8
   31a15:	50                   	push   eax
   31a16:	68 a1 00 00 00       	push   0xa1
   31a1b:	e8 6f fb ff ff       	call   3158f <out_byte>
   31a20:	83 c4 10             	add    esp,0x10
   31a23:	8d 65 f8             	lea    esp,[ebp-0x8]
   31a26:	5b                   	pop    ebx
   31a27:	5e                   	pop    esi
   31a28:	5d                   	pop    ebp
   31a29:	c3                   	ret

00031a2a <enable_irq>:
   31a2a:	55                   	push   ebp
   31a2b:	89 e5                	mov    ebp,esp
   31a2d:	56                   	push   esi
   31a2e:	53                   	push   ebx
   31a2f:	e8 25 ed ff ff       	call   30759 <__x86.get_pc_thunk.bx>
   31a34:	81 c3 c0 25 00 00    	add    ebx,0x25c0
   31a3a:	83 7d 08 07          	cmp    DWORD PTR [ebp+0x8],0x7
   31a3e:	7f 34                	jg     31a74 <enable_irq+0x4a>
   31a40:	83 ec 0c             	sub    esp,0xc
   31a43:	6a 21                	push   0x21
   31a45:	e8 51 fb ff ff       	call   3159b <in_byte>
   31a4a:	83 c4 10             	add    esp,0x10
   31a4d:	89 c6                	mov    esi,eax
   31a4f:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   31a52:	ba 01 00 00 00       	mov    edx,0x1
   31a57:	89 c1                	mov    ecx,eax
   31a59:	d3 e2                	shl    edx,cl
   31a5b:	89 d0                	mov    eax,edx
   31a5d:	f7 d0                	not    eax
   31a5f:	21 f0                	and    eax,esi
   31a61:	0f b6 c0             	movzx  eax,al
   31a64:	83 ec 08             	sub    esp,0x8
   31a67:	50                   	push   eax
   31a68:	6a 21                	push   0x21
   31a6a:	e8 20 fb ff ff       	call   3158f <out_byte>
   31a6f:	83 c4 10             	add    esp,0x10
   31a72:	eb 38                	jmp    31aac <enable_irq+0x82>
   31a74:	83 ec 0c             	sub    esp,0xc
   31a77:	68 a1 00 00 00       	push   0xa1
   31a7c:	e8 1a fb ff ff       	call   3159b <in_byte>
   31a81:	83 c4 10             	add    esp,0x10
   31a84:	89 c6                	mov    esi,eax
   31a86:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
   31a89:	ba 01 00 00 00       	mov    edx,0x1
   31a8e:	89 c1                	mov    ecx,eax
   31a90:	d3 e2                	shl    edx,cl
   31a92:	89 d0                	mov    eax,edx
   31a94:	f7 d0                	not    eax
   31a96:	21 f0                	and    eax,esi
   31a98:	0f b6 c0             	movzx  eax,al
   31a9b:	83 ec 08             	sub    esp,0x8
   31a9e:	50                   	push   eax
   31a9f:	68 a1 00 00 00       	push   0xa1
   31aa4:	e8 e6 fa ff ff       	call   3158f <out_byte>
   31aa9:	83 c4 10             	add    esp,0x10
   31aac:	8d 65 f8             	lea    esp,[ebp-0x8]
   31aaf:	5b                   	pop    ebx
   31ab0:	5e                   	pop    esi
   31ab1:	5d                   	pop    ebp
   31ab2:	c3                   	ret

00031ab3 <__x86.get_pc_thunk.cx>:
   31ab3:	8b 0c 24             	mov    ecx,DWORD PTR [esp]
   31ab6:	c3                   	ret
