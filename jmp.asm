.model small
.stack 100h

.data
msg1 db "enter 1st number- ", "$"
msg2 db 0dh, 0ah, "enter second number- ", "$"
msg3 db 0dh, 0ah, "not equal", "$"
msg4 db 0dh, 0ah, "equal", "$"

.code
main:
mov ax, @data
mov ds, ax

mov ah, 09h
mov dx, offset msg1
int 21h

mov ah, 01h
int 21h
mov bl, al

mov ah, 09h
mov dx, offset msg2
int 21h

mov ah, 01h
int 21h
mov cl, al

cmp cl, bl
je label1

mov ah,09h
mov dx, offset msg3
int 21h
jmp exit

label1:
mov ah,09h
mov dx, offset msg4
int 21h

exit:
mov ah, 04ch
int 21h

end main