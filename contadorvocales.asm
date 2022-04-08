; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db 10,13,"press any key...$" 
    v    db 100 dup(0)   
    w    db 'a','e','i','o','u' 
    nvocales dw 0
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

    ; add your code here  
    mov bx, offset v    
    mov dx, 0
    ite:
    
      mov ah,1 ;lee en AL
      int 21h  
      
      cmp al, 0dh
      je salirtodo
            
      lea si, w
      mov cx, 5
      
      ite2:
        
        cmp al,[si]
          jne seguir
          inc dx      
          jmp salirloop     
        seguir:
        inc si

      loop ite2
      
      salirloop:
      
      mov [bx],al
      inc bx 
    
    jmp ite
    
    salirtodo:
    
    mov nvocales, dx
            
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
