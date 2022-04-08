; Halla el cuadrado de la suma de los digitos
; de un numero
; 234: 2^2 + 3^2 + 4^2 = 29  
; 65535: 36+75+9

data segment
  num           dw 0   
  sum           dw 0 
  sw            db 0  ; 0->:(, 1->:)  
  msj_feliz     db "Es un numero feliz  :)$"
  msj_no_feliz  db "No es un numero feliz  :($"
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
    
    mov num, 43
   
    call es_feliz
    
    cmp sw, 0
    jne feliz
      ;imprimir :(
      lea dx, msj_no_feliz
      mov ah,9
      int 21h
      
      jmp salir
    
    feliz:
      ;imprimir :)
      lea dx, msj_feliz
      mov ah,9
      int 21h
    
             
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


es_feliz:
    
  cmp num,4
  jne seguir
             
    mov sw,0             
    jmp salirf
  
  seguir:
  
  call sumar_cuadrados
  
  cmp sum,1
  jne pdenuevo
  
    mov sw,1
    jmp salirf

  pdenuevo:  
  
    mov ax, sum
    mov num, ax
    
    mov sum,0         
    call es_feliz    
    
  salirf:
ret

ends    

end start
