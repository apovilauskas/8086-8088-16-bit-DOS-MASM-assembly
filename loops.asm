.model small
.stack 100h

.data
msg1 db "digits 0-9", 0dh, 0ah, '$'

.code
start:

    mov ax, @data
    mov ds, ax

    mov ah, 09h
    mov dx, offset msg1
    int 21h

    mov cx, 10
    mov dx, 48

    labelname:
    mov ah, 02h
    int 21h

    add dx, 1

    loop labelname

    mov ah, 04ch
    int 21h  

end start