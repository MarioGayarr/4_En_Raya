; juego1: Lógica principal del juego.

; JUEGO: Punto de entrada principal de una partida.
JUEGO: 
        PUSH    AF
        PUSH    BC
        PUSH    DE
        PUSH    HL
        PUSH    IX

        XOR     A                       ; Reiniciar variables
        LD      (FullTablero), A        ; Tablero no lleno
        LD      (ColumnaFull), A        ; Columna no llena
        LD      (ContadorFichas), A     ; 0 fichas colocadas
        LD      (Ganador), A            ; No hay ganador aún
        
        CALL    LimpiarTablero          ; Limpiar array Posiciones1
        
        CALL    TABLERO_REDONDO         ; Dibujar tablero gráfico
        
        LD      A, TINTA_Yel            ; Color inicial: amarillo
        LD      (Color_Usuario), A
        
        LD      H, 0                    ; Fila 0 (encima del tablero)
        LD      L, 0                    ; Columna 0
        CALL    PintaCuadrao1           ; Dibujar cursor inicial

JUEGOEMPEZADO:
        CALL    TECLAS                  ; Leer teclas del jugador
        LD      A, (Caracter)
        CP      'F'                     ; ¿Fin del juego?
        JR      NZ, JUEGOEMPEZADO       ; No, seguir jugando

        POP     IX
        POP     HL
        POP     DE
        POP     BC
        POP     AF
        RET

; LimpiarTablero: Limpia el array Posiciones1.
LimpiarTablero:
        PUSH    AF
        PUSH    BC
        PUSH    DE
        PUSH    IX
        
        LD      IX, Posiciones1
        LD      B, 6                    ; 6 filas

LimpiarFila:
        LD      (IX), $FF               ; Borde izquierdo
        LD      (IX+1), 0               ; Columna 0
        LD      (IX+2), 0               ; Columna 1
        LD      (IX+3), 0               ; Columna 2
        LD      (IX+4), 0               ; Columna 3
        LD      (IX+5), 0               ; Columna 4
        LD      (IX+6), 0               ; Columna 5
        LD      (IX+7), 0               ; Columna 6
        LD      (IX+8), $FF             ; Borde derecho
        LD      DE, 9
        ADD     IX, DE                  ; Siguiente fila (9 bytes)
        DJNZ    LimpiarFila             ; Repetir para las 6 filas
        
        POP     IX
        POP     DE
        POP     BC
        POP     AF
        RET