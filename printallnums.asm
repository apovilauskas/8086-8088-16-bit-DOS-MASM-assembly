.model small
.stack 100h

.data
num dw 4532
space db " "

.code
main:
mov ax, @data
mov ds, ax

mov ax, num
mov bx, 10

mov cx, 0 ; digit count


    division:
        mov dx, 0
        div bx
        push dx
        inc cx   

        cmp ax, 0
        jne division    

    mov ah, 02h
    mov dl, space
    int 21h
    
    
    print:
        pop dx
        add dl, 48
        mov ah, 02h
        int 21h
        loop print


mov ah, 04ch
int 21h
end main