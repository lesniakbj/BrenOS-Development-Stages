; We will be using this Stage02 shell
; to eventually load us into 32 bit mode, along with
; seup our correct segmenting modes.

; NOTE: We are no longer limited to 512 bytes,
; this section can be as large as it needs/wants to ne
; and can consist of a large amount of pre initialization
; to the kernel. 

[ORG 0x0]		; We offset to 0 for now, after the shell is done
				; we will use correct segmentation
[BITS 16]		; Yep, still in 16bit Real Mode

jmp boot_stage02_main

; =========================
; 	CODE SEGMENT
; =========================
boot_stage02_main:
	mov ax, 0x7E00
	mov es, ax
	
	mov si, boot2msg
	call write_string
	
	jmp loop_stub

write_string:
	lodsb
	or al, al
	jz .print_done
	mov ah, 0x0E
	int 0x10
	jmp write_string

.print_done:
	ret

loop_stub:
	jmp loop_stub

; =======================
;     STAGE02 DATA
; ======================
boot2msg db 'Welcome to 2nd stage...', 0
