;para saber si el juego ha terminado mirar primera fila si hay 0. Las primeras 7 filas está claro
Tablero_lleno:
    push af
    push ix 
    push bc
    
    ld ix, Posiciones1 +1
    ld b,7
bucle_compurebo:
    ld a, (ix)
    or a 
    jr z, nolleno
    inc ix 
    djnz bucle_compurebo
    ;si pasa por aquí está lleno
    ld a, 1
    ld(FullTablero), a
nolleno:
    pop bc
    pop ix
    pop af
    ret 