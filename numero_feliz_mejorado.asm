include 'emu8086.inc'

; Halla el cuadrado de la suma de los digitos
; de un numero
; 234: 2^2 + 3^2 + 4^2 = 29  
; 65535: 36+75+9

data segment
  num           dw 0   
  sum           dw 0 
  sw            db 0  ; 0->:(, 1->:)   
  msj_input     db "Ingrese un numero menor a 65535: $"
  msj_feliz     db 10,13,"Es un numero feliz  :)$"
  msj_no_feliz  db 10,13,"No es un numero feliz  :($" 
  msj_salir     db 10,13,"Presione cualquier tecla para salir...$"
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
    
    lea dx, msj_input
    call imprimir_cad
    
    call scan_num
    mov num, cx
   
    call es_feliz
    
    cmp sw, 0
    jne feliz
      ;imprimir :(
      lea dx, msj_no_feliz
      call imprimir_cad
      
      jmp salir
    
    feliz:
      ;imprimir :)
      lea dx, msj_feliz
      call imprimir_cad
    
             
    salir:        
    lea dx, msj_salir
    call imprimir_cad
        
    mov ah, 7
    int 21h
    
    mov ax, 4c00h
    int 21h    


imprimir_cad:
  mov ah,9
  int 21h
ret

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

DEFINE_SCAN_NUM
end start
