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

tamcolumna EQU 9

; Entrada: H = fila (0-5), L = columna (0-6) donde cayo la ficha
; Salida: Carry=1 si hay 4 en raya, Carry=0 si no
; Si hay 4 en raya, pone Caracter='F' para que el juego pare
; Usa Posiciones1 con bordes $FF como topes
Comprobar4enraya:
    push af
    push bc
    push de
    push hl
    push ix
    
    ; Usar SlotPointer_Array para calcular direccion en Posiciones1
    call SlotPointer_Array   ; IX = direccion de la ficha en Posiciones1
    
    ld c, (ix)           ; C = color de la ficha (TINTA_Yel=6 o TINTA_Red=2)
    
    ; Guardar IX para restaurar en cada comprobacion
    push ix
    
    ; 1) HORIZONTAL (izquierda <-> derecha): DE = 1
    ld de, 1
    call cb1
    cp 4
    jr nc, hay_4enraya_pop
    
    ; 2) VERTICAL (arriba <-> abajo): DE = 9 (tamcolumna)
    pop ix
    push ix
    ld de, tamcolumna
    call cb1
    cp 4
    jr nc, hay_4enraya_pop
    
    ; 3) DIAGONAL \ (arriba-izq <-> abajo-der): DE = 10 (tamcolumna+1)
    pop ix
    push ix
    ld de, tamcolumna + 1
    call cb1
    cp 4
    jr nc, hay_4enraya_pop
    
    ; 4) DIAGONAL / (arriba-der <-> abajo-izq): DE = 8 (tamcolumna-1)
    pop ix
    push ix
    ld de, tamcolumna - 1
    call cb1
    cp 4
    jr nc, hay_4enraya_pop
    
    ; No hay 4 en raya
    pop ix               ; limpiar stack
    pop ix
    pop hl
    pop de
    pop bc
    pop af
    or a                 ; Carry = 0
    ret

hay_4enraya_pop:
    pop ix               ; limpiar stack
hay_4enraya:
    ld a, 'F'
    ld (Caracter), a
    pop ix
    pop hl
    pop de
    pop bc
    pop af
    scf                  ; Carry = 1
    ret

; Subrutina: Contar fichas consecutivas en ambas direcciones
; Entrada: IX = posicion central, C = color a buscar, DE = desplazamiento
; Salida: A = total de fichas consecutivas
; Los bordes $FF actuan como tope (nunca coinciden con color 2 o 6)
cb1:
    push ix              ; guardar posicion central
    ld b, 1              ; B = contador (1 por la ficha central)
    push de              ; guardar DE
    
    ; Contar en direccion positiva (+DE)
cb2_bucle1:
    add ix, de
    ld a, (ix)           ; Leer casilla
    cp c                 ; Es del mismo color? (si es $FF o 0 o diferente, para)
    jr nz, cb1_seguir
    inc b
    jr cb2_bucle1
    
cb1_seguir:
    ; Restaurar para direccion negativa
    pop de
    pop ix
    push ix
    
    ; Negar DE
    xor a
    sub e
    ld e, a
    ld a, 0
    sbc a, d
    ld d, a              ; DE = -DE
    
    ; Contar en direccion negativa
cb2_bucle2:
    add ix, de
    ld a, (ix)           ; Leer casilla
    cp c                 ; Es del mismo color?
    jr nz, cb1_fin
    inc b
    jr cb2_bucle2
    
cb1_fin:
    pop ix
    ld a, b              ; A = total
    ret