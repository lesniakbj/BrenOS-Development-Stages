;=======================;
;	PRIMARY FUNCTIONS	;
;=======================;
read_from_disk:
	mov ah, 0x02	; Read Sector Function
	
	mov al, 1		; Number of Sectors to Read
	; mov dl, 0x80	; Use the 1st (C:) Drive. HDD.
	mov ch, 0		; Use the 1st Cylinder/Track
	mov dh, 0		; Use the 1st Read/Write Head
	mov cl, 2		; Read the 2nd Sector
	
	; Where to buffer the disk read to...
	; ES:BX
	mov bx, 0
	mov es, bx		; ES -> 0
	mov bx, 0x7E00	; BX -> 0x7E00 = 0x0000:0x7E00
	
	int 0x13
	
	jc .disk_read_error
	ret 

.disk_read_error:
	mov si, READ_ERROR
	call write_string
	jmp $