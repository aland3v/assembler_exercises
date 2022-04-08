include 'emu8086.inc'
;Invertir un numero menor a 65535
data segment
    pkey    db 10,13,"Presione cualquier tecla...$"  
    mns     db "Ingrese un valor menor a 65535: $"  
    mns_res db 10,13,"El resultado es: $"
ends

stack segment
    dw   128  dup(0) 
ends

code segment
start:
    mov ax, data
    mov ds, ax
    
    mov ah, 9
    lea dx, mns
    int 21h
    
    ;lee en CX
    call scan_num    
    mov bx, cx
       
    ; valor iniciar de num a componer    
    push 0 ;numero a componer
    push bx ;numero a descomponer
    
    itera:        
      ;Descomponer     
      mov ax, bx 
      mov dx, 0
      mov bx, 10
      div bx   
      
      ;num a descomponer
      pop bx      
      
      ;numero a componer        
      pop bx
      
      ;guardar numero descompuesto
      push ax 
      
      ;guardar ultimo digito
      push dx
                
      ;Componer   
      mov dx, 0
      mov ax, bx
      mov bx, 10
      mul bx
            
      ;extraemos ultimo digito
      pop bx   
      add ax, bx
      
      ;extrae num. descompuesto
      pop bx         
            
      ;guardamos num. a componer
      push ax
      
      ;guardar num. a descomponer
      push bx                  
      
    cmp bx,0  
    jnz itera
    
    
    lea dx, mns_res
    mov ah,9
    int 21h       
    
    ;extraer num. a descomponer
    pop ax                     
    
    ;extraer num. compuesto
    pop ax                  
    
    ;muestra num compuesto
    call print_num_uns
    
    ; saliendo....       
    lea dx, pkey
    mov ah, 9
    int 21h        
    
    mov ah, 7
    int 21h
    
    mov ax, 4c00h 
    int 21h    
ends   

DEFINE_SCAN_NUM  
DEFINE_PRINT_NUM_UNS
end start 
