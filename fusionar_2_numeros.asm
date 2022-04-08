; multi-segment executable file template.

data segment
    ; add your data here!
    pkey    db "Presione cualquier tecla para salir...$"    
    n1      db 0   ; num. de 3 digitos (ah)
    n2      db 0   ; num. de 2 digitos (al)
    factor  dw 1   ;1, 10, 100, 1000, 10000
    sw      db 0   ;alterna entre n1 y n2
    working db 0   ;numero a descomponer
    res     dw 0   ;resultado final
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
    ; set segment registers:
    mov ax, data
    mov ds, ax 

    ; add your code here 
    ; n1 = 255 = 25
    ; n2 = 98  = 9
    
    mov ah, 255
    mov al, 45  
    
    mov n1, ah
    mov n2, al
    
    
    ;cargar n1   
    mov al,n1
    mov working, al  
    
    ite1:   
      
      ;get last digit    
      mov al, working
      mov ah, 0 
      mov bl, 10
      div bl                    
      
      mov working, al
      
      ;multi last digit * factor
      mov al, ah
      mov ah, 0      
      mov bx, factor
      mul bx 
      
      ; sumamos al resultado
      add res, ax   
      
      ; multip. el factor * 10
      mov ax, factor
      mov bx, 10
      mul bx 
      mov factor, ax
      
      ;bloque de alternación entre numeros n1 y n2 dependiendo de sw 
      ;previamente actualizando los valores de n1, n2
      cmp sw, 0
      jne esuno  
        ; por verdad
        mov al, working
        mov n1, al
        
        mov sw, 1
        
        ;cargar n2
        mov al, n2 
        mov working, al
        
        jmp salta
        
      esuno: 
        ; por falso
        mov al, working
        mov n2, al
        
        mov sw, 0 
        
        ;cargar n1
        mov al, n1
        mov working, al
      
      salta:     
       
      ; parada cuando el numero mas grande n1 sea cero 
      cmp n1,0   
      je salir
    jmp ite1
    
    
    ;saliendo del programa    
    salir:

    lea dx, pkey
    mov ah, 9
    int 21h        
    
    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h 
    int 21h    
ends

end start 
