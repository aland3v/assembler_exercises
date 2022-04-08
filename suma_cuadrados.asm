; Halla el cuadrado de la suma de los digitos
; de un numero
; 234: 2^2 + 3^2 + 4^2 = 29  
; 65535: 36+75+9

data segment
  num dw 0 
  sum dw 0 
ends

stack segment
    dw   128  dup(0)
ends

code segment  
  
start:
    mov ax, data
    mov ds, ax
    
    ;limites    
    ;16bits -> 65535
    ;8 bits -> 255
    ;32bits -> 4.294.967.295
    
    
    mov num, 65535
    
   
    call sumar_cuadrados
         
    
    salir:        
        
    mov ah, 1
    int 21h
    
    mov ax, 4c00h
    int 21h    



sumar_cuadrados:

  mov bx, 10   

      
  descompone:
    
    ;extrae el ultimo digito
    mov dx, 0
    mov ax, num
    div bx    
    mov num,ax
    
    ;multiplica por si mismo   
    mov ax, dx
    mul dx
    
    add sum, ax
  
  cmp num,0
  jne descompone
   
ret

ends    

end start
