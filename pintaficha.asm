FICHA:; coje hl para pintar cuadrado y ix para la bola
        push hl
        push de
        push bc 
        push ix 
        PUSH AF
        CALL PintaCuadrao
        ld hl, ix
        
        ;Detectar si estamos en la fila problemática (segunda fila)
        LD A, H
        CP $40
        JR NZ, FICHA_NORMAL
        LD A, L  
        CP $E1
        JR C, FICHA_NORMAL    ; Si es menor que $E1, usar normal
        CP $FA
        JR NC, FICHA_NORMAL   ; Si es mayor o igual que $FA, usar normal
        JP FICHA_ENTERCIO     ; Si está entre $E1 y $F9, usar específica

FICHA_NORMAL:
        ;arriba izquierda
        LD A,%00000000
        LD(HL),A
        LD A,%00000001
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%00000011
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%00000111
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%00001111
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 

        ;arriba centro
        INC IX
        LD HL, IX
        
        LD A,%01111110
        LD(HL),A
        LD A,%11111111
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%11111111
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 

        ;arriba derecha

        INC IX
        LD HL, IX
        LD A,%00000000
        LD(HL),A
        LD A,%10000000
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%11000000
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%11100000
        LD DE, $100
        ADD HL,DE
        LD(HL),A
        LD DE, $100
        ADD HL,DE 
        LD(HL),A 
        LD A,%11110000
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 

        
        ;ld de,32
        ;add hl, de

        ;abajo derecha

        ld bc,$20
        ADD IX, BC 
        LD HL,IX
        LD A,%11110000
        LD(HL),A
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%11100000
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%11000000
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%10000000
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%00000000
        LD DE, $100
        ADD HL,DE
        LD(HL),A 

        ;abajo centro

        DEC IX
        LD HL,IX
        LD A,%11111111
        LD(HL),A
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD A,%01111110
        LD(HL),A 

        ;abajo izquierda
        DEC IX 
        LD HL,IX
        LD A,%00001111
        LD(HL),A
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A
        LD A,%00000111
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%00000011 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%00000001
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%00000000
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        jp Fin_Ficha

FICHA_ENTERCIO:
        ;arriba izquierda
        LD A,%00000000
        LD(HL),A
        LD A,%00000001
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%00000011
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%00000111
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%00001111
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 

        ;arriba centro
        INC IX
        LD HL, IX
        
        LD A,%01111110
        LD(HL),A
        LD A,%11111111
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%11111111
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 

        ;arriba derecha

        INC IX
        LD HL, IX
        LD A,%00000000
        LD(HL),A
        LD A,%10000000
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%11000000
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%11100000
        LD DE, $100
        ADD HL,DE
        LD(HL),A
        LD DE, $100
        ADD HL,DE 
        LD(HL),A 
        LD A,%11110000
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 

        ;abajo derecha en tercio

        ld bc,$720
        ADD IX, BC 
        LD HL,IX
        LD A,%11110000
        LD(HL),A
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%11100000
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%11000000
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%10000000
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%00000000
        LD DE, $100
        ADD HL,DE
        LD(HL),A 

        ;abajo centro

        DEC IX
        LD HL,IX
        LD A,%11111111
        LD(HL),A
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD A,%01111110
        LD(HL),A 

        ;abajo izquierda
        DEC IX 
        LD HL,IX
        LD A,%00001111
        LD(HL),A
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A
        LD A,%00000111
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%00000011 
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%00000001
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
        LD A,%00000000
        LD DE, $100
        ADD HL,DE
        LD(HL),A 
Fin_Ficha:
        POP AF
        pop ix
        pop bc
        pop de
        pop hl
        RET


BORRAR_FICHA:; coje hl para pintar cuadrado en negro
           PUSH BC 
        PUSH HL
        LD B,3
        
        LD (HL), 0
        INC HL
        LD (HL), 0
        INC HL
        LD (HL), 0
        LD DE,32
        ADD HL,DE
        LD (HL), 0
        DEC HL
        LD (HL), 0
        DEC HL
        LD (HL), 0

        POP HL
        POP BC
        RET

PintaCuadrao:;coge hl externo
        PUSH BC 
        PUSH HL
        PUSH AF
        LD B,3
        LD A, (Color_Usuario)
        LD (HL), A
        INC HL
        LD (HL), A
        INC HL
        LD (HL), A
        LD DE,32
        ADD HL,DE
        LD (HL), A
        DEC HL
        LD (HL),A
        DEC HL
        LD (HL), A

        POP AF
        POP HL
        POP BC
        RET

Animacion_Caeficha:;LE PASAS LOS HL E IX CORRECTOS DE DONDE ESTÁ LA FICHA ENCIMA
        ;SUMAR 8 A color usuario previo
        ;comprobar columna para detectar primer 0 desde abajo, por lo tanto los argumentos de esta rutina serán las coordenadas hl
                ;e ix de la ficha encima del tablero para calcular un +x/4 desde la izquierda del todo para averiguar columna 
        ;pintar x veces y borrar x-1
        ;guradar posición dónde se ha quedado
        ; RESTAR 8 AL COLOR DE USUARIO
        PUSH AF
        PUSH IX
        PUSH DE
        PUSH BC
        PUSH HL 
        ;comprobar columna para detectar primer 0 desde abajo, por lo tanto los argumentos de esta rutina serán las coordenadas hl
                ;e ix de la ficha encima del tablero para calcular un +x/4 desde la izquierda del todo para averiguar columna 
        LD DE, $5800 +32 +1 
        SBC HL, DE
        LD A, L         ; Copiar L a A
        SRL A           ; Shift right (dividir entre 2)
        SRL A           ; Shift right (dividir entre 4)
        LD IX, Posiciones
        LD C, A              ; C = columna (0-6)
        LD B, 6              ; B = fila (empezar desde la última fila)
        LD E, 5
BUCLE_COMPROBACION0:
        ; Calcular BYTE = B × 7 + C, 0-42, luego sumar esos bytes a la direccion Posiciones
        LD A, E
        ADD A, A         ; A = B × 2
        LD D, A          ; D = B × 3
        ADD A, A         ; A = B × 4
        ADD A, D         ; A = B × 6
        ADD A, E         ; A = B × 7
        ADD A, C         ; A = B × 7 + C 
    
        LD H, A
        LD L, 0          ; hl = N. bytes extra
        PUSH IX
        PUSH DE
        PUSH HL 
        POP DE 
        ADD IX, DE       ; IX apunta a Posiciones[B][C]
        LD A, (IX)
        POP DE       
        POP IX

        CP 0             ; ¿Es 0?
        JR Z, EncontradoVacio  ; Si 
    
        DEC E            ; subir fila
        DJNZ BUCLE_COMPROBACION0  ; Si B != 0, continuar
    
        ; No hay espacio en esta columna (columna llena)
        JP ColumnaLlena

EncontradoVacio:
        PUSH DE
        PUSH HL
        POP DE 
        ADD IX, DE
        POP DE

        LD(IX), 1 ;ACTUALIZO ESTADO DEL TABLERO

        ;llamar funcion que pinta espera borra y baja el numero de veces que son
        ;RESTAR 8 AL COLOR DE USUARIO
        
        ;RECUPERANDO VALOR DONDE IMPRIMO FICHA
        LD H, 0
        LD L, B         ; HL = A
        ADD HL, HL       ; HL × 2
        ADD HL, HL       ; HL × 4  
        ADD HL, HL       ; HL × 8
        ADD HL, HL       ; HL × 16
        ADD HL, HL       ; HL × 32
        LD D, H
        LD E, L          ; DE = A × 32
        ADD HL, HL       ; HL = A × 64
        ADD HL, DE       ; HL = A × 96
        LD DE, HL
        POP HL
        ADD HL, DE ; DIRECCION DE MEMORIA ATRIBUTOS DONDE IMPRIMIR FICHA - ahora está en HL
        PUSH HL    ; Guardar para devolver después
        ; Sumar PAPEL_Azul al color actual para el tablero
        LD A, (Color_Usuario)
        ADD A, PAPEL_Azul
        LD (Color_Usuario), A
        CALL PintaCuadrao  ; Pintar el cuadrado en la nueva posición
        ; Restaurar color sin papel azul
        LD A, (Color_Usuario)
        SUB PAPEL_Azul
        LD (Color_Usuario), A
        POP HL     ; Recuperar la posición actualizada
        
        POP BC
        POP DE
        POP IX
        POP AF
        RET
ColumnaLlena:
        ;vuelve a teclas pero hay que asegurarse de que vuelve a color y teclas correctas, quizás con a=1 y 
                ;luego comparo, algo tangible

        
       
        
        POP HL
        POP BC
        POP DE
        POP IX
        POP AF
        RET

 