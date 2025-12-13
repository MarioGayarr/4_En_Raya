JUEGO: 
    ; REINICIAR VARIABLES AL INICIO DE CADA PARTIDA
    XOR A
    LD (FullTablero), A    ; Reiniciar flag de tablero lleno
    LD (ColumnaFull), A    ; Reiniciar flag de columna llena
    
    ; LIMPIAR TABLERO Posiciones1 (6 filas x 9 bytes)
    CALL LimpiarTablero
    
    CALL TABLERO_REDONDO
    
    ; Reiniciar color del usuario a amarillo DESPUES de TABLERO_REDONDO
    ; (TABLERO_REDONDO modifica Color_Usuario internamente)
    LD A, TINTA_Yel
    LD (Color_Usuario), A
    
    LD H, 0
    LD L, 0
    CALL PintaCuadrao1
JUEGOEMPEZADO:    
    CALL TECLAS
    LD A,(Caracter)
    CP 'F'
    jr nz, JUEGOEMPEZADO
    RET

; RUTINA: Limpia el tablero Posiciones1 poniendo 0 en las casillas y $FF en los bordes
LimpiarTablero:
    PUSH AF
    PUSH BC
    PUSH IX
    
    LD IX, Posiciones1
    LD B, 6                ; 6 filas
LimpiarFila:
    LD (IX), $FF           ; Borde izquierdo
    LD (IX+1), 0           ; Columnas 0-6 a 0 (vacio)
    LD (IX+2), 0
    LD (IX+3), 0
    LD (IX+4), 0
    LD (IX+5), 0
    LD (IX+6), 0
    LD (IX+7), 0
    LD (IX+8), $FF         ; Borde derecho
    LD DE, 9
    ADD IX, DE             ; Siguiente fila
    DJNZ LimpiarFila
    
    POP IX
    POP BC
    POP AF
    RET