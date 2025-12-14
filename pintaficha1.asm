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

PintaCuadrao:;coge hl externo
        
        LD A, (Color_Usuario)
        JR SEGUIR
BORRAR_FICHA:
        LD A,0
SEGUIR:
        PUSH BC 
        PUSH HL
        PUSH AF


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

; Variables para guardar posicion final de la ficha (usadas por Comprobar4enraya)
ColumnaFinal: db 0              ; Columna donde cayo la ficha (0-6)
FilaFinal:    db 0              ; Fila donde cayo la ficha (0-5)

Animacion_Caeficha:

        xor a
        ld (ColumnaFull), a

        ; GUARDAMOS LA COLUMNA para usarla despues en Comprobar4enraya
        ld a, l                ; A columna (0-6)
        ld (ColumnaFinal), a   ; Guardar columna para despues
        
        ld ix, Posiciones1     ; IX = inicio del tablero
        inc a                  ; +1 por el $ff
        ld e, a
        ld d, 0
        add ix, de             ; IX = Posiciones1 +1 + columna

        ld de, 9*5             ; 45 bytes, ultima fila
        add ix, de             ; IX apunta a ultima fila

        ld b, 6                ; 6 filas (5..0)
        ld de, -9              ; salto hacia arriba una fila

BuscarHueco:
        ld a, (ix)
        cp 0
        jr z, HuecoEncontrado

        add ix, de             ; subir 1 fila
        djnz BuscarHueco

        jr ColumnaLlena

HuecoEncontrado:

        ; Guardamos color
        ld a, (Color_Usuario)
        ld (ix), a

        ; CALCULAMOS Y GUARDAMOS LA FILA FINAL
        ; B=6 -> fila 5, B=5 -> fila 4, ..., B=1 -> fila 0
        ; Fila = B - 1
        ld a, b
        dec a
        ld (FilaFinal), a      ; Guardar fila para Comprobar4enraya

        ; B vale filas probadas
        ld c, b                ; C = veces que cae
        ld h, 0                ; empezar caida desde encima del tablero

bucle_Cae:
        inc H
        call PintaCuadrao1
        call ESPERAR
        dec c
        jr z, TerminaAnimacion
        call BORRAR_FICHA1
        jr bucle_Cae
TerminaAnimacion:
        xor a
        ld (ColumnaFull), a
        
        ; Incrementar contador de fichas
        ld a, (ContadorFichas)
        inc a
        ld (ContadorFichas), a
        
        ; Cargar fila y columna guardadas para Comprobar4enraya
        ; H = fila (0-5), L = columna (0-6)
        push hl                ; Guardar HL actual
        ld a, (FilaFinal)
        ld h, a
        ld a, (ColumnaFinal)
        ld l, a
        call Comprobar4enraya
        pop hl                 ; Restaurar HL
        
        ; Si hay 4 en raya, ya termino (Caracter='F')
        ld a, (Caracter)
        cp 'F'
        ret z
        
        ; Comprobar si tablero lleno (42 fichas = 6 filas x 7 columnas)
        ld a, (ContadorFichas)
        cp 42
        ret nz                 ; Si no esta lleno, seguir jugando
        
        ; Tablero lleno = tablas
        ld a, 'F'
        ld (Caracter), a       ; Terminar juego
        ret
ColumnaLlena:
        ld a, 1
        ld (ColumnaFull),a 
        ret
PintaCuadrao1:;coge hl externo, DE 0-6 EN H (FILA) Y L (COLUMNA) CALCULA COORD Y PINTA
        
        LD A, H
        OR A
        JR Z, COLOR_SUPERIOR
        LD A, (Color_Usuario)
        OR PAPEL_Azul
        JR SEGUIR1
COLOR_SUPERIOR:
        LD A, (Color_Usuario)
        JR SEGUIR1
BORRAR_FICHA1:
        LD A, H ;compruebo si es arriba del tablero(h=0)
        OR A 
        JR Z, BORRAR_SUPERIOR
        LD A, PAPEL_Azul + TINTA_Blck 
        JR SEGUIR1
BORRAR_SUPERIOR:
        XOR A
SEGUIR1:
        PUSH HL
        PUSH AF
        PUSH AF 
        LD A, H  ; H= H*3 +1 "abajo"
        ADD A, H:ADD A, H 
        INC A 
        LD H,A 
        LD A,L ; L = L*4 +1 "derecha"
        ADD A,L 
        ADD A,A 
        INC A 
        LD L,A 
        CALL SlotPointer ;HL>$5800
        POP AF 
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
        RET
ESPERAR: 
        push bc 
        LD B,50 
D1:     LD C, 255
D2:     DEC C 
        JR NZ,D2 
        DJNZ D1 
        pop bc
        RET 

 