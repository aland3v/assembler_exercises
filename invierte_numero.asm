;Invertir un numero menor a 65535 = AX, BX
data segment
    pkey db "press any key...$"
    res dw 0
    num dw 0
ends

stack segment
    dw   128  dup(0) 
    
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax

    ; 345 -> 543
    mov num, 345
    
    
    itera:    
      ;DESCOMPONER
      mov ax, num
      mov bl, 10
      div bl   
      
      push ax
      mov ah, 0
      mov num, ax
       
      
          
      ;COMPONER
      mov ax, res   ; 5
      mov bl, 10
      mul bl
      
      mov res, ax
      
      
      pop ax      
      mov bl, ah
      mov bh, 0
      add res, bx
    
    cmp num,0
    jnz itera
    
           
    ; wait for any key....    
    
    lea dx, pkey
    mov ah, 9
    int 21h        
    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h 
    int 21h    
ends

end start 
