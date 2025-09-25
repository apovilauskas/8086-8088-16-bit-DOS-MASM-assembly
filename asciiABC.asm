.model small
.stack 100h

.data
msg1 db "Alphabet A-Z: ", 0dh, 0ah, '$'

.code
main:
    mov ax, @data
    mov ds, ax

    mov ah, 09h
    mov dx, offset msg1
    int 21h

    mov cx, 26
    mov dx, 65

    abcloop:

    mov ah, 02h
    int 21h

    add dx, 1

    loop abcloop

    mov ah, 04ch
    int 21h
end main