.model small
.stack 100h

.data 
msg1 db "iveskite DIDELE raide", 0dh, 0ah, '$'
input db ?

.code
main:
mov ax, @data
mov ds, ax

mov ah, 09h
mov dx, offset msg1
int 21h

mov ah, 08h
int 21h
mov bl, al

add bl, 32

mov dl, bl
mov ah, 02h
int 21h

; pabaiga
mov ah, 04ch
int 21h

end main