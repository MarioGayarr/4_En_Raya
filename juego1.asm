JUEGO: 
    CALL TABLERO_REDONDO
    LD H, 0
    LD L, 0
    CALL PintaCuadrao1
JUEGOEMPEZADO:    
    CALL TECLAS
    LD A,(Caracter)
    CP 'F'
    jr nz, JUEGOEMPEZADO
    RET