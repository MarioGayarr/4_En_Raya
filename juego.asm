JUEGO: 
    CALL TABLERO_REDONDO
    LD HL, $5800 +32 +1 
    LD IX, $4021 
    CALL FICHA
JUEGOEMPEZADO:    
    CALL TECLAS
    LD A,(Caracter)
    CP 'F'
    jr nz, JUEGOEMPEZADO
    RET



    
