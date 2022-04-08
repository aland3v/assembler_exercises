include 'emu8086.inc'
;Invertir un numero menor a 65535 = AX, BX
data segment
    pkey    db "Presione cualquier tecla...$"  
    mns     db "Ingrese un valor menor a 65535: $"  
    mns_res db 10,13,"El resultado es: $"
    nl      db 10,13,"$"
    res     dw 0
ends

stack segment
    dw   128  dup(0) 
    
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    
    mov ah, 9
    lea dx, mns
    int 21h
    
    call scan_num ;lee en CX
    mov ax, cx
    
    
    itera:
      push ax    
      ;DESCOMPONER      
      mov dx, 0
      mov bx, 10
      div bx   
 
     
      ;guardar numero descompuesto
      push ax 
      
      ;guardar ultimo digito
      push dx
                     
          
      ;COMPONER   
      mov dx, 0
      mov ax, res
      mov bx, 10
      mul bx
      
      mov res, ax
      
      ;extraemos ultimo digito
      pop ax   
      add res, ax
      
      ;extrae num. restante 34
      pop ax
    cmp ax,0
    jnz itera
    
    
    lea dx, mns_res
    mov ah,9
    int 21h       
    
    mov ax, res
    call print_num_uns
    
    
           
    ; wait for any key....    
    lea dx, nl
    mov ah,9
    int 21h
    
    lea dx, pkey
    mov ah, 9
    int 21h        
    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h 
    int 21h    
ends   

DEFINE_SCAN_NUM  
DEFINE_PRINT_NUM_UNS
end start 
