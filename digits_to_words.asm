;paima du failus, viena perskaito ir jei jame randa skaitmeni, ji pakeicia i zodi. pvz 3 tampa "trys". iraso i nauja faila

.model small
.stack 100h

.data
    msg1 db ' irasykite duomenu failo pavadinima: $'
    msg2 db 0dh, 0ah, ' irasykite rezultato failo pavadinima : $'
    input db 128, 0, 128 dup(0) ;failo pavadinimui laikyti, kiek max, kiek typed, ir dup(0)
    output db 128, 0, 128 dup(0)
    buffer db ? ;vieta kur laikysim nuskaitoma elementa
    input_id dw ? ;id (handle) kodai
    output_id dw ?
    success_msg db 0dh, 0ah, ' konvertavimas ivykdytas!$'
    
    ;zodziai skaitmenims
    nulis db 'nulis$'
    vienas db 'vienas$'
    du db 'du$'
    trys db 'trys$'
    keturi db 'keturi$'
    penki db 'penki$'
    sesi db 'sesi$'
    septyni db 'septyni$'
    astuoni db 'astuoni$'
    devyni db 'devyni$'

.code
main proc
    mov ax, @data
    mov ds, ax
    
    ; prasome pirmo pavadinimo
    mov ah, 09h 
    mov dx, offset msg1
    int 21h

    ;nesu tikras ar tikrai reikia null terminavimo
    ;
    ;
    ;
    ;

    ; nuskaitom duom failo pavadinima
    mov ah, 0ah ;string
    mov dx, offset input
    int 21h
    
    ; null-terminate input
    mov bl, [input+1] ; input+1 laiko actual ilgi, ji perkeliam i bl
    xor bh, bh; kad bx butu ilgis
    mov si, bx ; nes bx negalima indeksuot
    add si, 2 ; +1 nes 128, +1 nes reikia vieno indekso po ilgio
    mov byte ptr [input+si], 0
    
    ; prasom antro pavadinimo
    mov ah, 09h 
    mov dx, offset msg2
    int 21h
    
    ; nuskaitom rez pavadinima
    lea dx, output
    mov ah, 0ah
    int 21h
    
    ; null-terminate output filename
    mov bl, [output+1] ; output+1 laiko actual ilgi, ji perkeliam i bl
    xor bh, bh; kad bx butu ilgis
    mov si, bx ; nes bx negalima indeksuot
    add si, 2 ; +1 nes 128, +1 nes reikia vieno indekso po ilgio
    mov byte ptr [output+si], 0
    
    ; open input file
    lea dx, input+2 ;+2 kad praskipint pirmus 2 baitus, lea movina adresa
    mov ah, 3dh ; open existing file comanda
    mov al, 0 ; 0 read, 1 write 2 abu
    int 21h
    mov input_id, ax 
    
    ; create output file
    lea dx, output+2
    mov ah, 3ch ; create file command
    mov cx, 0 ; nes reikes loope
    int 21h
    mov output_id, ax
    
read_loop:
    ; skaito po viena characteri
    mov bx, input_id ; idedam i bx kad galetume nuskaityti
    mov dx, offset buffer ; dx yra kur laikom buferio adresa (galim ir lea naudot)
    mov cx, 1 ; nuskaitom po viena. i cx nes convention
    mov ah, 3fh ; read from file
    int 21h
    
	cmp ax, 0
	je close_files

    ; is_digit
    mov al, buffer
    cmp al, '0' ; jei ascii kodas mazesnis negu nulio tai printinam raide
    jl write_char
    cmp al, '9' ; jei didesnis nei 9 tai irgi printinam raide
    jg write_char
    
    ; digit_to_word
    sub al, '0' ; char to number
    call write_digit_word
    jmp read_loop
    
write_char:
    ; write non-digit character as-is
    mov bx, output_id
    lea dx, buffer
    mov cx, 1
    mov ah, 40h
    int 21h
    jmp read_loop
    
close_files:
    ; close input file
    mov bx, input_id
    mov ah, 3eh
    int 21h
    
    ; close output file
    mov bx, output_id
    mov ah, 3eh
    int 21h
    
    ; say success
    lea dx, success_msg
    mov ah, 09h
    int 21h
    
exit:
    mov ah, 4ch
    int 21h
    
main endp

; funkcija printinti zodzius vietoj skaitmenu
write_digit_word proc
    push ax        ; keiciam ah
    push bx        ; output_id
    push dx        ; adresas musu bufferio elemento
    
    ; gausim adresa zodzio pagal jo skaitmeni
    cmp al, 0
    je write_0
    cmp al, 1
    je write_1
    cmp al, 2
    je write_2
    cmp al, 3
    je write_3
    cmp al, 4
    je write_4
    cmp al, 5
    je write_5
    cmp al, 6
    je write_6
    cmp al, 7
    je write_7
    cmp al, 8
    je write_8
    cmp al, 9
    je write_9
    jmp done_write
    
write_0:
    lea si, nulis ; kaip ir offset, duoda adresa stringo nulis
    mov cx, 5 ; raidziu kiekis zodyje nulis
    jmp do_write
write_1:
    lea si, vienas
    mov cx, 6
    jmp do_write
write_2:
    lea si, du
    mov cx, 2
    jmp do_write
write_3:
    lea si, trys
    mov cx, 4
    jmp do_write
write_4:
    lea si, keturi
    mov cx, 6
    jmp do_write
write_5:
    lea si, penki
    mov cx, 5
    jmp do_write
write_6:
    lea si, sesi
    mov cx, 4
    jmp do_write
write_7:
    lea si, septyni
    mov cx, 7
    jmp do_write
write_8:
    lea si, astuoni
    mov cx, 7
    jmp do_write
write_9:
    lea si, devyni
    mov cx, 6
    
do_write:
    mov bx, output_id
    mov dx, si
    mov ah, 40h
    int 21h
    
done_write:
    pop dx
    pop bx
    pop ax
    ret
write_digit_word endp

end main
