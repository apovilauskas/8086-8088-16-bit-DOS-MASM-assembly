.model small
.stack 100h

.data
deci db 49
tens db 0
ones db 0
space db " "

.code
main:
mov ax, @data
mov ds, ax

mov ah, 0
mov al, deci
mov bl, 10
div bl

add al, 48
add ah, 48
mov tens, al
mov ones, ah

mov ah, 02h
mov dl, space
int 21h

mov ah, 02h
mov dl, tens
int 21h

mov ah, 02h
mov dl, ones
int 21h

mov ah, 04ch
int 21h
end main
