; lee numeros 45|33|66|37|enter

data segment
    ; add your data here!     
    inp  db "Ingrese el vector: $"
    oup  db "Vector ingresado: $" 
    pkey db 10,13,"Presione cualquier tecla para salir...$"     
    nl   db 10,13,"$"
    v    db 5 dup(2)
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
    
    
    lea dx, inp
    mov ah, 9
    int 21h
    
    ; lectura del vector
        
    mov cx,5 ;tamaño vector
    mov di, offset v
    
    iterar:
      mov ah, 1; lee en al
      int 21h 
      
      ;corrección a binario
      sub al, 30h
      
      ;guardar
      mov [di],al
      
      inc di
      
    loop iterar          
    
    lea dx, nl
    mov ah,9
    int 21h
    
    lea dx, oup
    mov ah,9
    int 21h
    
    ;mostrar vector
    mov cx, 5
    mov si, offset v
    iterar2:    
      
      mov dl, [si] 
      add dl, 30h ;corrección a ascii
      inc si
      
      mov ah,2;imprime de dl
      int 21h    
    
    loop iterar2
    
      
    lea dx, pkey
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
