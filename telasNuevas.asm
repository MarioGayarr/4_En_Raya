;funciones al leer una tecla válida(excepto F que hace que salga):
MOVER_DERECHA:
    CALL BORRAR_FICHA1
    INC L
    LD A, L
    CP POS_MAX1
    JR Z, DIBUJA_DCHA
    JR C, DIBUJA_DCHA
SALTO_FINAL:
    LD L, 0
DIBUJA_DCHA:
    CALL PintaCuadrao1
    RET      


MOVER_IZQUIERDA:
    CALL BORRAR_FICHA1
    LD A, L
    CP POS_MIN1
    JR Z, SALTO_INICIO
    JR C, SALTO_INICIO
    DEC L
    CALL PintaCuadrao1
    RET      
SALTO_INICIO:
    LD L, POS_MAX1
    CALL PintaCuadrao1
    RET

;función principal---------------------------------
ES_AMARILLOYNolocambio:
    CALL PintaCuadrao1
TECLAS: ; CAMBIA A
    PUSH BC

L15:
    LD BC,$FBFE
    IN A,(C)
    BIT 0,A
    JR NZ,L16
    CALL SOLTAR_TECLA
    LD A,'Q'
    LD (Caracter),A
    POP BC
    CALL MOVER_IZQUIERDA
    RET
L16:
    BIT 1,A
    JR NZ,L17
    CALL SOLTAR_TECLA
    LD A,'W'
    LD (Caracter),A
    POP BC
    CALL MOVER_DERECHA
    RET

       
L17:
    LD BC,$FDFE
    IN A,(C)
    BIT 3,A
    JR NZ,L5
    CALL SOLTAR_TECLA
    LD A,'F'
    LD (Caracter),A
    POP BC
    RET
L5:                     ; Este cambia porque es RETURN y se carga como carácter $FF
    LD BC,$BFFE
    IN A,(C)
    BIT 0,A
    JR NZ,L15
    CALL SOLTAR_TECLA
    LD A,$FF
    LD (Caracter),A
    POP BC
    jr CAMBIAR_USUARIO


;cambio de usuario y lectura de movimiento con o-p  
ES_ROJO:
    CALL Tablero_lleno
    ld a, (FullTablero)
    cp 1
    jr z, seAcaba
    LD A, TINTA_Yel          ; cambiar a amarillo (sin papel)
    LD (Color_Usuario), A
    LD H,0    ; Restaurar posición inicial
    LD L,0
    CALL PintaCuadrao1
    RET
seAcaba:
    ld a, "F"
    ld(Caracter), A
    ret

CAMBIAR_USUARIO:
    CALL BORRAR_FICHA1
    CALL Animacion_Caeficha
    
    ; Comprobar si hay 4 en raya (Caracter = 'F') y salir inmediatamente
    ld a, (Caracter)
    cp 'F'
    ret z                  ; Si hay 4 en raya, salir sin cambiar usuario
    
    ld a,(ColumnaFull);comprobamos si la columna ha estado llena
    cp 1
    jp z, nohaycambio
    LD A, (Color_Usuario)   ; carga el color actual
    CP TINTA_Yel            ; comparo con amarillo
    JR NZ, ES_ROJO          ; si es amarillo se cambia a rojo
    LD A, TINTA_Red         ; cambiar a rojo (sin papel)
    LD (Color_Usuario), A
    LD H,0
    ld L,0    ; Restaurar posición inicial
ES_ROJOYNolocambio:
    CALL PintaCuadrao1
L21:
    PUSH BC                 ; Guardar BC al inicio del bucle
    LD BC,$DFFE
    IN A,(C)
    BIT 0,A
    JR NZ,L22
    CALL SOLTAR_TECLA
    LD A,'P'
    LD (Caracter),A
    POP BC
    CALL MOVER_DERECHA
    jr L21
L22:
    BIT 1,A
    JR NZ,L23
    CALL SOLTAR_TECLA
    LD A,'O'
    LD (Caracter),A
    POP BC
    CALL MOVER_IZQUIERDA
    jr L21
L23:
    LD BC,$FDFE
    IN A,(C)
    BIT 3,A
    JR NZ,L24
    CALL SOLTAR_TECLA
    LD A,'F'
    LD (Caracter),A
    POP BC
    RET
L24:                     ; Este cambia porque es RETURN y se carga como carácter $FF
    LD BC,$BFFE
    IN A,(C)
    BIT 0,A
    JR NZ,L25
    CALL SOLTAR_TECLA
    LD A,$FF
    LD (Caracter),A
    POP BC
    jr CAMBIAR_USUARIO
L25:
    POP BC              ; Limpiar stack si no se presionó ninguna tecla
    jr L21

    RET
nohaycambio: 
    xor a
    ld (ColumnaFull), a
    LD A, (Color_Usuario)   ; carga el color actual
    CP TINTA_Yel            ; comparo con amarillo
    JP NZ, ES_ROJOYNolocambio
    JP ES_AMARILLOYNolocambio 