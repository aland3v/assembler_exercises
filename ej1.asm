; multi-segment executable file template.
; 9abcdefghi
; 8abcdefgh
; 7abcdefg
; ....
; ....
; 1a 

data segment
    ; add your data here!
    pkey db 10,13,"Presione cualquier tecla para salir...$"  
    nl   db 10,13,"$"
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
    mov cx, 9
    
    ite1:
      push cx
      mov dl, cl       
      add dl, 30h
      mov ah, 2
      int 21h 
            
      mov dl, 'a'
      ite2:  
      
      mov ah, 2      
      int 21h                  
      inc dl
                      
      loop ite2
      
      lea dx, nl
      mov ah, 9
      int 21h
    
      pop cx
    loop ite1
    
    
    
    
            
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
