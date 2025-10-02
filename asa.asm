.model small
.stack 100h

.data
ats db 0 , '$'
enterr db 13,10, '$'
liekana db 0, '$'

.code
main:
mov ax, @data
mov ds, ax

mov bx, 11
mov ax, 100
xor dx, dx
div bx

add al, '0'
mov ats, al
add dl, '0'
mov liekana, dl

mov ah, 09h
mov dx, offset ats
int 21h

mov ah, 09h
mov dx, offset enterr
int 21h

mov ah, 09h
mov dx, offset liekana
int 21h

mov ah, 04ch
int 21h

end main