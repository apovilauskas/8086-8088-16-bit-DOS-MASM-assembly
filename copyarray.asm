.model small
.stack 100h

.data
str1 db "Augustas", '$'
str2 db 10 dup('$')

.code
main:

mov ax, @data
mov ds, ax

    mov cx, 10
    mov si, offset str1
    mov di, offset str2

    copyarray:
        mov bl, [si]
        mov [di], bl
        inc di
        inc si
    loop copyarray

    mov ah, 09h
    mov dx, offset str2
    int 21h

mov ah, 04ch
int 21h

end main