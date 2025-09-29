.model small
.stack 100h

.data
msg1 db "enter a string", 0dh, 0ah, '$'
msg2 db "length is ", '$'
msg3 db 0dh, 0ah, "your input was ", '$'
len db 0
array db 11 dup('$')

.code
main:

    mov ax, @data
    mov ds, ax

    mov ah, 09h
    mov dx, offset msg1
    int 21h

    mov cx, 10
    mov si, offset array

    input:
        mov ah, 01h ; take input char
        int 21h
        mov [si], al ; mov input to array address
        cmp al, 0dh ; see if its enter
        je output
        
        add si,1
        add len, 1


    loop input

    output:
        mov ah, 09h
        mov dx, offset msg2
        int 21h

        mov al, len
        add al, 48
        mov dl, al
        
        mov ah, 02h
        int 21h

        mov ah,09h
        mov dx, offset msg3
        int 21h

        mov ah, 09h
        mov dx, offset array
        int 21h       

    mov ah, 4ch
    int 21h

end main