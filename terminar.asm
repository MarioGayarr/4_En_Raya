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
4enraya:
    ld de,1
    call cb1
    ret nc
    ld de, tamcolumna
    call cb1
    or A
    ret Z
    ld de, tamcolumna -1
     ;tam columna +1
cb1: ;h la fila y en l la columna
    call SlotPointer;dirección de la ficha cuando cae
    ld b,1
    ld a, (ix)
    push ix;la dirección de memoria de la posicion de la 
cb2_bucle1:
    add ix, de
    ld a, (ix)
    cp C
    jr nz, cb1_seguir
    inc B
    jr cb2_bucle1
cb1_seguir:
    pop ix
    ld a, e ;esto solo funciona cuando d es 0
    neg;neg no tiene que dar acarreo
    ld e,A
    ld d, $ff
;aqui abajo hacemos el mismo bucle que cb2, cb2_bucle2
cb1_seguir1:
    ld a,B
    cp 4
    ret;comprobar c para ver si hay 4 fichas