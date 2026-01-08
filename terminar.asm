;Constantes y utilidades
tamcolumna      EQU 9

;Tablero_lleno: Comprueba si el tablero está lleno
Tablero_lleno:
        PUSH    AF
        PUSH    BC
        PUSH    IX
        
        LD      IX, Posiciones1 + 1     ; Saltar borde izquierdo
        LD      B, 7                    ; 7 columnas

bucle_compruebo:
        LD      A, (IX)
        OR      A                       ; Si es 0, hay hueco
        JR      Z, nolleno
        INC     IX 
        DJNZ    bucle_compruebo
        
        ; Si llega aqui, tablero lleno
        LD      A, 1
        LD      (FullTablero), A

nolleno:
        POP     IX
        POP     BC
        POP     AF
        RET 

;Comprobar4enraya: Comprueba si hay 4 en raya
Comprobar4enraya:
        PUSH    AF
        PUSH    BC
        PUSH    DE
        PUSH    HL
        PUSH    IX
        
        ; Calcular direccion en Posiciones1
        CALL    SlotPointer_Array       ; IX = direccion de la ficha
        
        LD      C, (IX)                 ; C = color de la ficha
        
        PUSH    IX                      ; Guardar posicion central
        
        ; 1) HORIZONTAL (izquierda <-> derecha): DE = 1
        LD      DE, 1
        CALL    ContarFichasConsecutivas
        CP      4
        JR      NC, hay_4enraya_pop
        
        ; 2) VERTICAL (arriba <-> abajo): DE = 9
        POP     IX
        PUSH    IX
        LD      DE, tamcolumna
        CALL    ContarFichasConsecutivas
        CP      4
        JR      NC, hay_4enraya_pop
        
        ; 3) DIAGONAL (arriba-izq <-> abajo-der): DE = 10
        POP     IX
        PUSH    IX
        LD      DE, tamcolumna + 1
        CALL    ContarFichasConsecutivas
        CP      4
        JR      NC, hay_4enraya_pop
        
        ; 4) DIAGONAL (arriba-der <-> abajo-izq): DE = 8
        POP     IX
        PUSH    IX
        LD      DE, tamcolumna - 1
        CALL    ContarFichasConsecutivas
        CP      4
        JR      NC, hay_4enraya_pop
        
        ; No hay 4 en raya
        POP     IX                      ; Limpiar stack
        POP     IX
        POP     HL
        POP     DE
        POP     BC
        POP     AF
        OR      A                       ; Carry = 0
        RET

hay_4enraya_pop:
        POP     IX                      ; Limpiar stack

hay_4enraya:
        ; Guarda color del ganador
        LD      A, C
        LD      (Ganador), A
        
        ; Marcar fin de juego
        LD      A, 'F'
        LD      (Caracter), A
        
        POP     IX
        POP     HL
        POP     DE
        POP     BC
        POP     AF
        SCF                             ; Carry = 1
        RET

;ContarFichasConsecutivas: Cuenta fichas consecutivas en ambas direcciones
ContarFichasConsecutivas:
        PUSH    IX                      ; Guardar posicion central
        PUSH    DE
        
        LD      B, 1                    ; B = contador (1 por la ficha central)
        
        ; Contar en direccion positiva (+DE)
cb_positivo:
        ADD     IX, DE
        LD      A, (IX)
        CP      C                       ; Es del mismo color?
        JR      NZ, cb_cambiar_dir
        INC     B
        JR      cb_positivo
        
cb_cambiar_dir:
        ; Restaurar para direccion negativa
        POP     DE
        POP     IX
        PUSH    IX
        PUSH    DE
        
        ; Negar DE para direccion negativa: DE = -DE
        XOR     A
        SUB     E
        LD      E, A
        LD      A, 0
        SBC     A, D
        LD      D, A
        
        ; Contar en direccion negativa (-DE)
cb_negativo:
        ADD     IX, DE
        LD      A, (IX)
        CP      C                       ; Es del mismo color?
        JR      NZ, cb_fin
        INC     B
        JR      cb_negativo
        
cb_fin:
        POP     DE
        POP     IX
        LD      A, B                    ; A = total
        RET

;MostrarResultado: Muestra el resultado de la partida
MostrarResultado:
        PUSH    AF
        PUSH    BC
        PUSH    IX
        
        LD      A, (Ganador)
        
        ; Comprobar si es amarillo
        CP      TINTA_Yel
        JR      Z, MostrarAmarillo
        
        ; Comprobar si es rojo
        CP      TINTA_Red
        JR      Z, MostrarRojo
        
        ; Tablas (Ganador = 0)
        LD      B, 3                    ; Fila 3
        LD      C, 13                   ; Columna 13 (centrado)
        LD      A, 7                    ; Atributo blanco
        LD      IX, M_TABLAS
        CALL    PRINTAT
        JR      FinMostrarResultado
        
MostrarAmarillo:
        LD      B, 3                    ; Fila 3
        LD      C, 7                    ; Columna 7 (centrado)
        LD      A, TINTA_Yel            ; Atributo amarillo
        LD      IX, M_GAN_AMARILLO
        CALL    PRINTAT
        JR      FinMostrarResultado
        
MostrarRojo:
        LD      B, 3                    ; Fila 3
        LD      C, 9                    ; Columna 9 (centrado)
        LD      A, TINTA_Red            ; Atributo rojo
        LD      IX, M_GAN_ROJO
        CALL    PRINTAT
        
FinMostrarResultado:
        POP     IX
        POP     BC
        POP     AF
        RET