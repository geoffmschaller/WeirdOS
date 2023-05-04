; Memory offset to show assembler where to put code
org 0x7C00
; Output 16bit
bits 16

start:
	jmp main

puts:
	;Save the registers we will modify
	push si
	push ax

.loop:
	lodsb ;Loads next character
	or al, al ;Verifies that the next character is not null
	jz .done
	
	mov ah, 0x0e
	mov bh, 0
	int 0x10

	jmp .loop

.done:
	pop ax
	pop si
	ret

main:
	; Setup Data Segments
	mov ax, 0
	mov ds, ax ; Can't write to ds, es directly
	mov es, ax

	; Setup Stack
	mov ss, ax
	mov sp, 0x7C00 ;Stack grows downward from here
	
	; Print Message	
	mov si, msg_to_print
	call puts
	
	hlt
		
.halt:
	jmp .halt

msg_to_print: db 'Hello Geoff!', 0x0A, 0


times 510-($-$$) db 0
dw 0AA55h

