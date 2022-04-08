; multi-segment executable file template.
; Cifrado César
data segment
    ; add your data here!
    pkey db "press any key...$"
    v    db 'U','M','S','A','X','Z',' '  
    nl   db 10,13,'$'
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

    lea si, v  
    mov cx, 6
    
    ite:
      
      mov dl, [si] 
      
      cmp dl, 'X'
      jne cmpy
      
        mov dl, 'A'
        jmp continue    
      
      cmpy:
      cmp dl, 'Y'
      jne cmpx
         
         mov dl, 'B'
         jmp continue
      
      cmpx:
      cmp dl, 'Z'
      jne seguir
      
        mov dl, 'C'
        jmp continue
                
      seguir:
      add dl, 3 
            
      continue:
      mov [si], dl
      inc si 
      
    loop ite
    
    mov [si], '$' 
    
    lea dx, v 
    mov ah, 9
    int 21h       
    
    lea dx, nl 
    mov ah, 9
    int 21h
    
    
    ;SALIR        
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
