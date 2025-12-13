
TABLERO_REDONDO:
        push hl
        push ix
        push de
        push bc
        push AF
        
        CALL CLEARSCR
        
        ; Dibujar el fondo del tablero primero
        LD HL, $5800 + 96     ; HL se mueve 3 filas hacia abajo, dejando espacio arriba para ficha amarilla
        LD IX,HL          

        LD A, 8             ; A = 8, color azul para las barras del tablero
        LD B, 19            ; B = 19, número de filas
FullCuadrao:
        LD C, 29
COLUMNA:
        LD (HL), A          ; Escribe el color azul en HL
        INC HL              ; Avanza HL al siguiente byte
        DEC C               ; Disminuye contador de columnas
        JR NZ, COLUMNA 
        LD DE, 32
        ADD IX,DE
        LD HL,IX
        DEC B
        JR NZ, FullCuadrao
; Fila 0: $4021 / $5821
        LD A, 0
        LD (Color_Usuario), A
        LD IX, $4021       
        LD HL, $5821        
        LD C, 7  

FilaColumnas0:
        CALL FICHA          
        LD DE, 4
        ADD IX, DE          
        ADD HL, DE          
        DEC C
        JR NZ, FilaColumnas0

        ; Fila 2: $40E1 / $5881+96
        LD IX, $40E1        
        LD HL, $5881 + 96   
        LD C, 7
; Fila 1: $4081 / $5881
        LD A, %00001000     ; pongo la ficha en negro
        LD (Color_Usuario), A
        LD IX, $4081        
        LD HL, $5881        
        LD C, 7  
FilaColumnas1:
        CALL FICHA          
        LD DE, 4
        ADD IX, DE          
        ADD HL, DE          
        DEC C
        JR NZ, FilaColumnas1

        ; Fila 2: $40E1 / $5881+96
        LD IX, $40E1        
        LD HL, $5881 + 96   
        LD C, 7  
FilaColumnas2:
        CALL FICHA          
        LD DE, 4
        ADD IX, DE          
        ADD HL, DE          
        DEC C
        JR NZ, FilaColumnas2

        ; Fila 3: $4841 / $5881+192
        LD IX, $4841        
        LD HL, $5881 + 192  
        LD C, 7  
FilaColumnas3:
        CALL FICHA          
        LD DE, 4
        ADD IX, DE          
        ADD HL, DE          
        DEC C
        JR NZ, FilaColumnas3

        ; Fila 4: $48A1 / $5881+288
        LD IX, $48A1        
        LD HL, $5881 + 288  
        LD C, 7  
FilaColumnas4:
        CALL FICHA          
        LD DE, 4
        ADD IX, DE          
        ADD HL, DE          
        DEC C
        JR NZ, FilaColumnas4

        ; Fila 5: $5001 / $5881+384
        LD IX, $5001        
        LD HL, $5881 + 384  
        LD C, 7  
FilaColumnas5:
        CALL FICHA          
        LD DE, 4
        ADD IX, DE          
        ADD HL, DE          
        DEC C
        JR NZ, FilaColumnas5

        ; Fila 6: $5061 / $5881+480
        LD IX, $5061        
        LD HL, $5881 + 480  
        LD C, 7  
FilaColumnas6:
        CALL FICHA          
        LD DE, 4
        ADD IX, DE          
        ADD HL, DE          
        DEC C
        JR NZ, FilaColumnas6
       
        LD A, 6
        LD (Color_Usuario), A
        
        pop AF
        pop bc
        pop de
        pop ix
        pop hl
        
        RET