c_a1_linha	EQU	700H		
c_a2_linha	EQU	704H		
c_a3_linha	EQU	708H		
c_b1_linha	EQU	70CH		
c_b2_linha	EQU	710H		
c_b3_linha	EQU	714H		
c_b4_linha	EQU	718H		
c_b5_linha	EQU	71CH		
c_b6_linha	EQU	720H		
c_b7_linha	EQU	724H		
c_b8_linha	EQU	728H		
c_e1_linha	EQU	72CH		
c_e2_linha	EQU	730H		
c_e3_linha	EQU	734H		
c_linha		EQU	738H		; coordenada da linha do canhao
m_tecla		EQU	73CH		
linha_al	EQU	740H  ;valor aleatorio		
m_fim		EQU	744H  ;tecla fim		
m_b1		EQU	746H	;ver se a bala esta ativa	
m_b2		EQU	748H		
m_b3		EQU	74AH		
m_b4		EQU	74CH		
m_b5		EQU	74EH		
m_b6		EQU	750H		
m_b7		EQU	752H		
m_b8		EQU	754H		
m_int0		EQU	800H	;endereco das interrupcoes 	
m_int1		EQU	804H		
m_fst_en	EQU	808H	;inicio pixel screen	
m_ult_end	EQU	80AH	;fim pixel screen	
explo		EQU	80EH		
pontuacao	EQU	814H		
balas_d		EQU	816H		
LINHA		EQU	8		
l_min		EQU	22		
c_min		EQU	1		
lc_max		EQU	30		
linha_c		EQU	30		; linha inicial canhao
coluna_c	EQU	15		; coluna inicial canhao
lin_1		EQU	15		
col_1		EQU	15		
lin_2		EQU	10		
col_2		EQU	7		
lin_3		EQU	5		
col_3		EQU	23		
lin1		EQU	23		
col1		EQU	15		
max_a		EQU	3		
max_b		EQU	8		
lim_av_dir	EQU	28		
fst_en		EQU	8000H		
ult_en		EQU	807FH		
erase 		EQU	0000H		
pout1		EQU	0A000H		
pout2		EQU	0C000H		
pout3		EQU	06000H		
pin			EQU	0E000H		
masc		EQU	000FH		
masc2		EQU	00F0H		
					
PLACE		1000H			
pilha:		TABLE	100H		
fim_pilha:				
					
tab_int:	WORD	int0		
		WORD	int1		
					
PLACE		0			
					
jogo:		MOV	BTE, tab_int	
		MOV	SP, fim_pilha	
		EI0			
		EI1			
		EI			
					
ciclo:		CMP	R10, 1		;flag para verficar se foi feito o restar ao jogo
		JZ	x		
		MOV	R4, m_b1	;inicializacoes de todas as variaveis
		MOV	R1, 0		
		MOV	[R4], R1	
		MOV	R4, m_b2	
		MOV	R1, 0		
		MOV	[R4], R1	
		MOV	R4, m_b3	
		MOV	R1, 0		
		MOV	[R4], R1	
		MOV	R4, m_b4	
		MOV	R1, 0		
		MOV	[R4], R1	
		MOV	R4, m_b5	
		MOV	R1, 0		
		MOV	[R4], R1	
		MOV	R4, m_b6	
		MOV	R1, 0		
		MOV	[R4], R1	
		MOV	R4, m_b7	
		MOV	R1, 0		
		MOV	[R4], R1	
		MOV	R4, m_b8	
		MOV	R1, 0		
		MOV	[R4], R1	
		MOV	R4, m_fim	
		MOV	R1, 0		
		MOV	[R4], R1	
		CALL	apaga		
		MOV	R4, linha_al	
		MOV	R2, 6H		
		MOV	[R4], R2	
		MOV	R10, 1		
		MOV	R4, explo	
		MOV	R2, 0		
		MOV	[R4], R2	
		MOV	R4, pontuacao	
		MOV	R2, 0000H	
		MOVB	[R4], R2	
		MOV	R4, pout1	
		MOVB	[R4], R2	
		MOV	R4, balas_d	
		MOV	R2, 0050H	
		MOVB	[R4], R2	
		MOV	R4, pout3	
		MOVB	[R4], R2	
		MOV 	R2, linha_c	
		MOV 	R3, coluna_c	
		MOV 	R4, c_linha	
		MOV 	[R4], R2	; escreve na memoria linha inicial do canhao
		ADD	R4, 2		
		MOV 	[R4], R3	; escreve na memoria coluna inicial do canhao
		CALL	canhao		
		MOV	R4, c_b1_linha	
		MOV	[R4], R2	
		ADD	R4, 2		
		MOV	[R4], R3	
		MOV	R2, lin_1	
		MOV	R3, col_1	
		MOV	R4, c_a1_linha	
		SUB	R2, 2		
		MOV	[R4], R2	
		ADD	R4, 2		
		MOV	[R4], R3	
		MOV	R2, lin_2	
		MOV	R3, col_2	
		MOV	R4, c_a2_linha	
		MOV	[R4], R2	
		ADD	R4, 2		
		MOV	[R4], R3	
		MOV	R2, lin_3	
		MOV	R3, col_3	
		MOV	R4, c_a3_linha	
		MOV	[R4], R2	
		ADD	R4, 2		
		MOV	[R4], R3	
x:		CALL	move_o		  ;ciclo do jogo
		CALL	teclado		
		MOV	R4, m_fim	
		MOV	R1, [R4]	
		CMP	R1, 1		
		JZ	fim1		
		MOV	R1, balas_d	
		MOV	R4, masc2	
		MOVB	R3, [R1]	
		AND	R3, R4		
		CMP	R3, 0H		
		JNZ	ciclo		
		MOV	R4, masc	
		MOVB	R3, [R1]	
		AND	R3, R4		
		CMP	R3, 0H		
		JZ	fim1		
		JMP	ciclo		
					
fim1:		;MOV	R4, m_fim	
		;MOV	R1, 0		
		;MOV	[R4], R1	
		MOV	R10, 0		
		CALL	apaga		
fim:		CALL	teclado		
		;MOV	R4, m_fim	
		;MOV	R1, [R4]	
		;CMP	R1, 0		
		;JZ	ciclo		
		JMP	fim		
					
move_o:		PUSH	R0		;move objeto
		PUSH	R1		
		PUSH	R2		
		PUSH	R3		
		PUSH	R4		
		PUSH	R5		
		MOV	R0, fst_en	
		MOV	R2, m_int0	
		MOV	R1, [R2]	
		CMP	R1, 0		
		JZ	f_move		
		MOV	R5, max_a	
		MOV	R4, 0		
		MOV	R1, explo	
		MOV	R2, [R1]	
		CMP	R2, 0		
		JZ	salta_exp	
		MOV	R1, c_e1_linha	
		MOV	R2, [R1]	
		ADD	R1, 2		
		MOV	R3, [R1]	
		CALL	apaga_explosao	;desliga todos os pixeis do ecra
		MOV	R1, explo	
		MOV	R2, 0		
		MOV	[R1], R2	
salta_exp:	MOV	R1, c_a1_linha ;ve se explosao esta ativa	
		SUB	R1, 2		
;ciclo_av:	ADD	R1, 2	
	;	MOV	R2, [R1]	
	;	ADD	R1, 2		
	;	MOV	R3, [R1]	
	;	CALL	apaga_aviao	
	;	;CMP	R4, R5		
	;	;JNZ	ciclo_av	
	;	CMP	R3, 0		
	;	JZ	muda		
move_a_h:	SUB	R3, 1	;move aviao pa esquerda uma casa	
		;MOV	R1, c_a1_linha	
		;ADD	R1, 2		
		MOV	[R1], R3	
		CALL	aviao		
		JMP	f_move		
muda:		MOV	R3, lim_av_dir	 ;altera a coordenada do aviao po inicio
		MOV	R1, linha_al	
		MOV	R2, [R1]	
		MOV	R1, c_a1_linha	
		MOV	[R1], R2
		ADD	R1, 2		
		MOV	[R1], R3	
		CALL	aviao		
f_move:		;CMP	R4, R5	   ;finaliza o movimento do aviao	
		;JNZ	ciclo_av	
		CALL	move_b		
		MOV	R2, m_int0	
		MOV	R1, 0		
		MOV	[R2], R1	
		POP	R5		
		POP	R4		
		POP	R3		
		POP	R2		
		POP	R1		
		POP	R0		
		RET			
					
move_b:		PUSH	R0		  ;escreve explosao e apaga o aviao
		PUSH	R1		
		PUSH	R2		
		PUSH	R3		
		PUSH	R5		
		PUSH	R6		
		PUSH	R7		
		MOV	R0, fst_en	
		MOV	R2, m_int1	
		MOV	R1, [R2]	
		CMP	R1, 0		
		JZ	f_move_b	
		MOV	R1, c_b1_linha	
		MOV	R2, [R1]	
		ADD	R1, 2		
		MOV	R3, [R1]	
		CALL	apaga_pixel	
		CMP	R2, 0		
		JZ	muda_b		
		MOV	R5, c_a1_linha	
		MOV	R6, [R5]	
		ADD	R5, 2		
		MOV	R7, [R5]	
		CMP	R6, R2		
		JZ	col_cmp		
		SUB	R6, 1		
		CMP	R6, R2		
		JZ	col_2_cmp	
		ADD	R6, 2		
		CMP	R6, R2		
		JZ	col_2_cmp	
		ADD	R6, 1		
		CMP	R6, R2		
		JZ	col_3_cmp	
		SUB	R6, 4		
		CMP	R6, R2		
		JZ	col_3_cmp	
mov_b_v:	SUB	R2, 1	 ;movimenta a bala na vertical	
		MOV	R1, c_b1_linha	
		MOV	[R1], R2	
		CALL	set_pixel ;escreve a bala na nova posicao	
		JMP	f_move_b	
acertou_a:	MOV	R1, c_a1_linha	;verfica se a bala chocou com o aviao
		MOV	R2, [R1]	
		ADD	R1, 2		
		MOV	R3, [R1]	
		MOV	R1, c_e1_linha	
		MOV	[R1], R2	
		ADD	R1, 2		
		MOV	[R1], R3	
		CALL	apaga_aviao	 ;apaga o aviao na posicao onde foi atingido
		CALL	explosao	 ;escreve a explosao naquela posicao
		CALL	pontos		 ; atualiza o contador de pontos
		MOV	R1, c_a1_linha	
		MOV	R3, lim_av_dir		
		MOV	[R1], R2	
		ADD	R1, 2		
		MOV	[R1], R3	
		CALL	aviao		
		MOV	R1, explo	
		MOV	R2, 1		
		MOV	[R1], R2	
muda_b:		MOV 	R1, c_linha	  ;atualiza as coordenadas da bala quando chega ao fim do ecra
		MOV 	R2, [R1]	; le linha do canhao
		ADD	R1, 2		
		MOV 	R3, [R1]	; le coluna do canhao
		MOV	R1, c_b1_linha	
		SUB	R2, 2		
		MOV	[R1], R2	
		ADD	R1, 2		
		MOV	[R1], R3	
		CALL	balas_disp	;
f_move_b:	MOV	R2, m_int1	 ;finaliza o movimento da bala  
		MOV	R1, 0		
		MOV	[R2], R1	
		POP	R7		
		POP	R6		
		POP	R5		
		POP	R3		
		POP	R2		
		POP	R1		
		POP	R0		
		RET			
					
					
col_cmp:	CMP	R7, R3		;verifica se a bala acertou na primeira coluna do aviao
		JZ	acertou_a		
		ADD	R7, 1		
		CMP	R7, R3		
		JZ	acertou_a		
		ADD	R7, 1		
		CMP	R7, R3		
		JZ	acertou_a		
		ADD	R7, 1		
		CMP	R7, R3		
		JZ	acertou_a		
		JMP	mov_b_v		
					
col_2_cmp:	ADD	R7, 1		;verifica se a bala acertou na segundo coluna do aviao
		CMP	R7, R3		
		JZ	acertou_a		
		JMP	mov_b_v		
					
col_3_cmp:	ADD	R7, 2		;verifica se a bala acertou na terceira coluna do aviao
		CMP	R7, R3		
		JZ	acertou_a		
		JMP	mov_b_v		
					
int0:		PUSH	R1		
		PUSH	R2		
		MOV	R2, m_int0	
		MOV	R1, [R2]	
		MOV	R1, 1		
		MOV	[R2], R1	
		POP	R2		
		POP	R1		
		RFE			
					
int1:		PUSH	R1		
		PUSH	R2		
		MOV	R2, m_int1	
		MOV	R1, [R2]	
		MOV	R1, 1		
		MOV	[R2], R1	
		POP	R2		
		POP	R1		
		RFE			
					
sai_escreve:	RET			
					
set_pixel:	PUSH 	R0		;acende um pixel 
		PUSH 	R1		
		PUSH 	R2		
		PUSH 	R3		
		PUSH	R6		
		SHL 	R2, 2		
		ADD 	R0, R2		
		MOV 	R1, R3		
		SHR 	R1, 3		
		ADD 	R0, R1		
		MOV 	R6, 8		
		MOD 	R3, R6		
		ADD 	R3, 1		
		MOV 	R7, 100H	
shift:		SUB 	R3, 1  	;seleciona a mascara certa a usar
		SHR 	R7, 1		
		CMP 	R3, 0		
		JNZ 	shift		
		MOVB 	R8, [R0]	
		OR 	R8, R7		
		MOVB	[R0], R8	
		POP	R6		
		POP 	R3		
		POP 	R2		
		POP 	R1		
		POP 	R0		
		JMP 	sai_escreve	
					
apaga_pixel:	PUSH 	R0		;desliga um pixel
		PUSH 	R1		
		PUSH 	R2		
		PUSH 	R3		
		PUSH	R6		
		PUSH	R7		
		SHL 	R2, 2		
		ADD 	R0, R2		
		MOV 	R1, R3		
		SHR 	R1, 3		
		ADD 	R0, R1		
		MOV 	R6, 8		
		MOD 	R3, R6		
		ADD 	R3, 1		
		MOV 	R7, 100H	
shift_a:	SUB 	R3, 1		;seleciona a mascara a usar para apagar o pixel
		SHR 	R7, 1		
		CMP 	R3, 0		
		JNZ 	shift_a		
		NOT	R7		
		MOVB 	R8, [R0]	
		AND	R8, R7		
		MOVB	[R0], R8	
		POP	R7		
		POP	R6		
		POP 	R3		
		POP 	R2		
		POP 	R1		
		POP 	R0		
		JMP 	sai_escreve	
					
aviao:		PUSH	R4		;desenha o aviao 
		PUSH 	R2		; 
		PUSH 	R3		;		
		CALL	set_pixel	;		
		ADD 	R3, 1		;		
		CALL	set_pixel	;		
		SUB 	R2, 1		
		CALL	set_pixel	
		ADD 	R2, 2		
		CALL	set_pixel	
		ADD 	R3, 1		
		ADD 	R2, 1		
		CALL	set_pixel	
		SUB 	R2, 2		
		CALL	set_pixel	
		ADD 	R3, 1		
		CALL	set_pixel	
		SUB 	R3, 1		
		SUB 	R2, 2		
		CALL	set_pixel	
		POP 	R3		
		POP 	R2		
		POP	R4		
		RET			
					
apaga_aviao:	PUSH	R4		
		PUSH 	R2		; apaga aviao 
		PUSH 	R3		;	     
		CALL	apaga_pixel	;	      
		ADD 	R3, 1		;	      
		CALL	apaga_pixel	;	      
		SUB 	R2, 1		
		CALL	apaga_pixel	
		ADD 	R2, 2		
		CALL	apaga_pixel	
		ADD 	R3, 1		
		ADD 	R2, 1		
		CALL	apaga_pixel	
		SUB 	R2, 2		
		CALL	apaga_pixel	
		ADD 	R3, 1		
		CALL	apaga_pixel	
		SUB 	R3, 1		
		SUB 	R2, 2		
		CALL	apaga_pixel	
		POP 	R3		
		POP 	R2		
		POP	R4		
		RET			
					
apaga:		PUSH 	R0		;apaga o ecra todo 
		PUSH 	R1		
		PUSH 	R2		
		PUSH 	R3		
		MOV 	R0, ult_en	
		MOV 	R5, m_ult_end	
		MOV 	[R5], R0	; escreve na memoria ultimo endereco do pixel screen
		MOV 	R0, fst_en	
		MOV 	R5, m_fst_en	
		MOV 	[R5], R0	; escreve na memoria primeiro endereco do pixel screen
					
					
		MOV 	R0, fst_en	; le o valor do primeiro endereco do pixel screen
		MOV 	R1, ult_en	; le o valor do ultimo endereco do pixel screen
		MOV 	R3, erase	
					
apaga_2:	MOV 	[R0], R3	; escreve 0000H no endereco  cilco pa apahar o ecra
		ADD 	R0, 2		; passa ao proximo endereco
		CMP 	R1, R0		
		JGE 	apaga_2		; verifica-se e o ulimo endereco do pixel screen
		POP 	R3		
		POP 	R2		
		POP 	R1		
		POP 	R0		
		RET			
					
explosao:	PUSH 	R2		; desenha explosao
		PUSH 	R3		;		   0110
		CALL	set_pixel	;		   0110
		ADD 	R3, 1		;		   1001
		CALL	set_pixel	
		ADD 	R2, 1		
		CALL	set_pixel	
		SUB 	R3, 1		
		CALL	set_pixel	
		SUB 	R3, 1		
		ADD 	R2, 1		
		CALL	set_pixel	
		ADD 	R3, 3		
		CALL	set_pixel	
		SUB 	R2, 3		
		CALL	set_pixel	
		SUB 	R3, 3		
		CALL 	set_pixel	
		POP 	R3		
		POP 	R2		
		RET			
					
apaga_explosao:	PUSH 	R2		; apaga explosao 
		PUSH 	R3		;		   
		CALL	apaga_pixel	;		   
		ADD 	R3, 1		;		   
		CALL	apaga_pixel	
		ADD 	R2, 1		
		CALL	apaga_pixel	
		SUB 	R3, 1		
		CALL	apaga_pixel	
		SUB 	R3, 1		
		ADD 	R2, 1		
		CALL	apaga_pixel	
		ADD 	R3, 3		
		CALL	apaga_pixel	
		SUB 	R2, 3		
		CALL	apaga_pixel	
		SUB 	R3, 3		
		CALL 	apaga_pixel	
		POP 	R3		
		POP 	R2		
		RET			
					
pontos:		PUSH	R1		;atualiza a pontucao
		PUSH	R2		
		PUSH	R3		
		PUSH	R4		
		MOV	R4, masc	
		MOV	R1, pontuacao	
		MOVB	R2, [R1]	
		MOVB	R3, [R1]	
		AND	R3, R4		
		SUB	R3, 3		
		CMP	R3, 6H		
		JNZ	adiciona	
		ADD	R2, 7		
		JMP	escreve_p	
adiciona:	ADD	R2, 1		
escreve_p:	MOV	R1, pout1	;escreve os pontos
		MOVB	[R1], R2	
		MOV	R1, pontuacao	
		MOVB	[R1], R2	
		POP	R4		
		POP	R3		
		POP	R2		
		POP	R1		
		RET			
					
					
					
balas_disp:	PUSH	R1	 ;atualiza o valor das balas	
		PUSH	R2		
		PUSH	R3		
		PUSH	R4		
		MOV	R4, masc	
		MOV	R1, balas_d	
		MOVB	R2, [R1]	
		MOVB	R3, [R1]	
		AND	R3, R4		
		CMP	R3, 0H		
		JNZ	subtrai		
		SUB	R2, 7		
		JMP	escreve_b	
subtrai:	SUB	R2, 1		
escreve_b:	MOV	R1, pout3	;escreve as balas restantes
		MOVB	[R1], R2	
		MOV	R1, balas_d	
		MOVB	[R1], R2	
		POP	R4		
		POP	R3		
		POP	R2		
		POP	R1		
		RET			
					
canhao:		PUSH	R4		; desenha canhao 010
		PUSH 	R2		;		 111
		PUSH	R3		;		 111	
		PUSH	R0		
		MOV	R0, fst_en	
		MOV 	R4, c_linha	
		MOV 	R2, [R4]	; le linha do canhao
		ADD	R4, 2		
		MOV 	R3, [R4]	; le coluna do canhao
		SUB 	R2, 1		
		CALL	set_pixel	
		ADD 	R2, 1		
		CALL	set_pixel	
		SUB 	R3, 1		
		CALL	set_pixel	
		ADD 	R3, 2		
		CALL	set_pixel	
		ADD 	R2, 1		
		CALL	set_pixel	
		SUB 	R3, 1		
		CALL	set_pixel	
		SUB 	R3, 1		
		CALL	set_pixel	
		POP	R0		
		POP 	R3		
		POP 	R2		
		POP	R4		
		RET			
					
apaga_canhao:	PUSH	R4		; apaga o canhao nas coordenadas em que se encontra
		PUSH 	R2		
		PUSH	R3		
		PUSH	R0		
		MOV	R0, fst_en
		MOV 	R4, c_linha	
		MOV 	R2, [R4]	; le linha do canhao
		ADD	R4, 2		
		MOV 	R3, [R4]	; le coluna do canhao
		SUB 	R2, 1		
		CALL	apaga_pixel	
		ADD 	R2, 1		
		CALL	apaga_pixel	
		SUB 	R3, 1		
		CALL	apaga_pixel	
		ADD 	R3, 2		
		CALL	apaga_pixel	
		ADD 	R2, 1		
		CALL	apaga_pixel	
		SUB 	R3, 1		
		CALL	apaga_pixel	
		SUB 	R3, 1		
		CALL	apaga_pixel	
		POP	R0		
		POP 	R3		
		POP 	R2		
		POP	R4		
		RET			
					
teclado:	PUSH 	R0		
		PUSH 	R1		
		PUSH 	R2		
		PUSH 	R3		
		PUSH 	R4		
		PUSH 	R5		
		PUSH 	R9		
		PUSH 	R7		
		PUSH	R8		
					
início:					
; inicializações gerais do teclado	
					
		CALL	aleatorio_l	
		MOV	R1, c_linha	
		MOV	R2, [R1]	; le linha atual do canhao
		ADD	R1, 2		
		MOV	R3, [R1]	; le coluna atual do canhao
		CALL	canhao		
		MOV	R1, LINHA	; testar a linha 4 
		MOV	R2, pout2	; R2 com o endereço do periférico de saida
		MOV	R3, pin		; R3 com o endereço do periférico de entrada
					
; corpo principal do programa do teclado
ciclo_t:	MOV	R5, 0		
		MOV	R9, 0		
		MOVB 	[R2], R1	; escrever no porto de saída
		MOVB 	R4, [R3]	; ler do porto de entrada
		MOV	R8, 0FH	
		AND	R4, R8		
		JNZ	linha		; se uma tecla foi premida entao salta para ver qual e (linha)
		SHR	R1, 1		; ler proxima linha
		JNZ	ciclo_t		; verifica-se alguma tecla foi premida em alguma das linhas se nao entao passa
		POP	R8		
		POP	R7		
		POP	R9		
		POP	R5		
		POP	R4		
		POP	R3		
		POP	R2		
		POP	R1		
		POP	R0		
		RET			
					
linha:		SHR	R1, 1		; ve a linha em que a tecla foi premida e converte para decimal
		JZ	coluna		
		ADD 	R5, 1		
		JMP	linha		
coluna:		SHR	R4, 1		; ve a coluna em que a tecla foi premida e converte para decimal
		JZ	tecla		
		ADD	R9, 1		
		JMP	coluna		
tecla:		MOV	R7, 4		; 4x o num da linha + o num da coluna 
		MUL	R5, R7		
		ADD	R5, R9		
		MOV 	R9, m_tecla	; R5 com endereço de memória da tecla
		MOV	[R9], R5	; escrita do valor da tecla na memoria
		CALL 	move_canhao	; vai ver o que faz a tecla e aplica-lo
		POP	R8		
		POP	R7		
		POP	R9		
		POP	R5		
		POP	R4		
		POP	R3		
		POP	R2		
		POP	R1		
		POP	R0		
		RET			
					
move_canhao:	PUSH	R0		
		PUSH	R1		
		PUSH	R2		
		PUSH	R3		
		PUSH	R4		
		PUSH	R5		
		PUSH	R9		
		CALL	apaga_canhao	
		MOV	R4, m_tecla	
		MOV	R1, [R4]	; le valor da tecla 
		MOV	R4, c_linha	
		MOV	R2, [R4]	; le linha atual do canhao
		ADD	R4, 2		
		MOV	R3, [R4]	; le coluna atual do canhao
; verifica qual a tecla premida		
		;MOV	R4, m_fim	
		;MOV	R1, [R4]	
		;CMP	R1, 1		
		;JZ	t_r		
		CMP	R1, 00H		
		JZ	tecla_cima_esq	
		CMP	R1, 01H		
		JZ	tecla_cima	
		CMP	R1, 02H		
		JZ	tecla_cima_dir	
		CMP	R1, 03H		
		JZ	tecla_3		
		CMP	R1, 04H		
		JZ	tecla_esq	
		CMP	R1, 05H		
		JZ	tecla_5		
		CMP	R1, 06H		
		JZ	tecla_dir	
		CMP	R1, 07H		
		JZ	tecla_7		
		MOV	R4, 08H		
		CMP	R1, R4		
		JZ	tecla_baix_esq	
		MOV	R4, 09H		
		CMP	R1, R4		
		JZ	tecla_baixo	
		MOV	R4, 0AH		
		CMP	R1, R4		
		JZ	tecla_baix_dir	
		MOV	R4, 0BH		
		CMP	R1, R4		
		JZ	tecla_B		
t_r:	MOV	R4, 0CH		
		CMP	R1, R4		
		JZ	tecla_restart	
		;MOV	R4, m_fim	
		;MOV	R1, [R4]	
		;CMP	R1, 1		
		;JZ	pp_t
		MOV	R4, 0DH		
		CMP	R1, R4		
		JZ	tecla_D		
		MOV	R4, 0EH		
		CMP	R1, R4		
		JZ	tecla_E		
		JMP	tecla_F		
					
tecla_cima_esq:	MOV	R5, l_min 	; verifica se da para mover
		CMP	R5, R2		
		JZ	fim_move	
		MOV	R5, c_min	
		CMP	R5, R3		
		JZ	fim_move	
		SUB	R2, 1		; novo valor da linha do canhao
		SUB	R3, 1		; novo valor da coluna do canhao
		JMP	fim_move	
tecla_cima:	MOV	R5, l_min	; verifica se da para mover
		CMP	R5, R2		
		JZ	fim_move	
		SUB	R2, 1		; novo valor da linha do canhao
		JMP	fim_move	
tecla_cima_dir:	MOV	R5, l_min	; verifica se da para mover
		CMP	R5, R2		
		JZ	fim_move	
		MOV	R5, lc_max	
		CMP	R5, R3		
		JZ	fim_move	
		SUB	R2, 1		; novo valor da linha do canhao
		ADD	R3, 1		; novo valor da coluna do canhao
		JMP	fim_move	
tecla_3:	JMP	fim_move	
tecla_esq:	MOV	R5, c_min	; verifica se da para mover
		CMP	R5, R3		
		JZ	fim_move	
		SUB	R3, 1		; novo valor da coluna do canhao
		JMP	fim_move	
tecla_5:	SUB	R2, 2		; valor da linha da bala
		
		ADD	R2, 2		
		JMP	fim_move	
tecla_dir:	MOV	R5, lc_max	; verifica se da para mover
		CMP	R5, R3		
		JZ	fim_move	
		ADD	R3, 1		; novo valor da coluna do canhao
		JMP	fim_move	
tecla_7:	JMP	fim_move	
tecla_baix_esq:	MOV	R5, lc_max	; verifica se da para mover
		CMP	R5, R2		
		JZ	fim_move	
		MOV	R5, c_min	
		CMP	R5, R3		
		JZ	fim_move	
		ADD	R2, 1		; novo valor da linha do canhao
		SUB	R3, 1		; novo valor da coluna do canhao
		JMP	fim_move	
tecla_baixo:	MOV	R5, lc_max	; verifica se da para mover
		CMP	R5, R2		
		JZ	fim_move	
		ADD	R2, 1		; novo valor da linha do canhao
		JMP	fim_move	
tecla_baix_dir:	MOV	R5, lc_max	; verifica se da para mover
		CMP	R5, R2		
		JZ	fim_move	
		CMP	R5, R3		
		JZ	fim_move	
		ADD	R2, 1		; novo valor da linha do canhao
		ADD	R3, 1		; novo valor da coluna do canhao
		JMP	fim_move	
tecla_B:	JMP	fim_move	
tecla_restart:	;MOV	R4, m_fim	
		;MOV	R1, 0		
		;MOV	[R4], R1	
		MOV	R4, 0		
		MOV	R10, 0		
		JMP	fim_move	
tecla_D:	MOV	R4, m_fim	
		MOV	R1, 1		
		MOV	[R4], R1	
		JMP	fim_move	
tecla_E:	JMP	fim_move	
tecla_F:	JMP	fim_move	
fim_move:	MOV	R4, c_linha	
		MOV	[R4], R2	; escreve na memoria linha do canhao
		ADD	R4, 2			
		MOV	[R4], R3	; escreve na memoria coluna do canhao
		MOV	R4, m_fim	
		MOV	R1, [R4]	
		CMP	R1, 1		
		JZ	salta_c		
		CALL	canhao		; desenha o canhao
salta_c:	MOV	R5, 0H		
		MOV 	R9, m_tecla	; R9 com endereço de memória da tecla
		MOV	[R9], R5	; escrita do valor da 0H na memoria
pp_t:		POP	R9		
		POP	R5		
		POP	R4		
		POP	R3		
		POP	R2		
		POP	R1		
		POP	R0		
		RET			
					

aleatorio_l:	     ;alterna as posicoes do aviao
		PUSH	R1		
		PUSH	R2		
		PUSH	R3		
		MOV	R1, linha_al	
		MOV	R2, [R1]	
		MOV	R3, masc	
		CMP	R2, R3		
		JGE	mov_6		
		ADD	R2, 3

		
		JMP	f_al		
mov_6:		MOV	R2, 6H		 
f_al:		MOV	[R1], R2	
		POP	R3		
		POP	R2		
		POP	R1		
		RET			


					