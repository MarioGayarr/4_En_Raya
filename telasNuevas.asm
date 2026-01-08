;MOVER_DERECHA: Mueve el cursor a la derecha
MOVER_DERECHA:
        PUSH    BC
        PUSH    DE
        
        CALL    BORRAR_FICHA1           ; Borrar ficha actual
        INC     L                       ; Siguiente columna
        LD      A, L
        CP      POS_MAX1                ; ¿Llegó al máximo?
        JR      Z, DIBUJA_DCHA          ; Sí, dibujar ahí
        JR      C, DIBUJA_DCHA          ; Aún no, dibujar
        
SALTO_FINAL:
        LD      L, 0                    ; Wrap-around a columna 0

DIBUJA_DCHA:
        CALL    PintaCuadrao1           ; Dibujar en nueva posición
        
        POP     DE
        POP     BC
        RET      

;MOVER_IZQUIERDA: Mueve el cursor a la izquierda
MOVER_IZQUIERDA:
        PUSH    BC
        PUSH    DE
        
        CALL    BORRAR_FICHA1           ; Borrar ficha actual
        LD      A, L
        CP      POS_MIN1                ; ¿Está en el mínimo?
        JR      Z, SALTO_INICIO         ; Sí, wrap
        JR      C, SALTO_INICIO
        DEC     L                       ; Columna anterior
        CALL    PintaCuadrao1           ; Dibujar en nueva posición
        
        POP     DE
        POP     BC
        RET

SALTO_INICIO:
        LD      L, POS_MAX1             ; Wrap-around a columna máxima
        CALL    PintaCuadrao1           ; Dibujar en nueva posición
        
        POP     DE
        POP     BC
        RET

;ES_AMARILLOYNolocambio: Redibuja el cursor del jugador amarillo
ES_AMARILLOYNolocambio:
        CALL    PintaCuadrao1           ; Redibujar cursor

;TECLAS: Lee teclas del jugador amarillo
TECLAS:
        PUSH    BC

L15:
        LD      BC, $FBFE
        IN      A, (C)                  ; Leer puerto $FBFE
        BIT     0, A                    ; Comprobar tecla Q
        JR      NZ, L16                 ; No pulsada, siguiente
        CALL    SOLTAR_TECLA
        LD      A, 'Q'
        LD      (Caracter), A
        POP     BC
        CALL    MOVER_IZQUIERDA         ; Mover a la izquierda
        RET

L16:
        BIT     1, A                    ; Comprobar tecla W
        JR      NZ, L17                 ; No pulsada, siguiente
        CALL    SOLTAR_TECLA
        LD      A, 'W'
        LD      (Caracter), A
        POP     BC
        CALL    MOVER_DERECHA           ; Mover a la derecha
        RET
       
L17:
        LD      BC, $FDFE
        IN      A, (C)                  ; Leer puerto $FDFE
        BIT     3, A                    ; Comprobar tecla F
        JR      NZ, L5                  ; No pulsada, siguiente
        CALL    SOLTAR_TECLA
        LD      A, 'F'
        LD      (Caracter), A
        POP     BC
        RET                             ; Finalizar

L5:
        LD      BC, $BFFE
        IN      A, (C)                  ; Leer puerto $BFFE
        BIT     0, A                    ; Comprobar ENTER
        JR      NZ, L15                 ; No pulsada, seguir
        CALL    SOLTAR_TECLA
        LD      A, $FF                  ; Código especial ENTER
        LD      (Caracter), A
        POP     BC
        JP      CAMBIAR_USUARIO

;ES_ROJO: Prepara el turno del otro jugador
ES_ROJO:
        CALL    Tablero_lleno           ; Comprobar si está lleno
        LD      A, (FullTablero)
        CP      1                       ; ¿Tablero lleno?
        JR      Z, seAcaba              ; Sí, terminar
        
        LD      A, TINTA_Yel            ; Cambiar a amarillo
        LD      (Color_Usuario), A
        LD      H, 0                    ; Posición inicial
        LD      L, 0
        CALL    PintaCuadrao1           ; Dibujar cursor
        RET

seAcaba:
        LD      A, 'F'                  ; Marcar fin
        LD      (Caracter), A
        RET

;CAMBIAR_USUARIO: Procesa la jugada y cambia de jugador
CAMBIAR_USUARIO:
        PUSH    BC
        PUSH    DE
        
        CALL    BORRAR_FICHA1           ; Borrar cursor
        CALL    Animacion_Caeficha      ; Soltar ficha
        
        LD      A, (Caracter)
        CP      'F'                     ; ¿Hay 4 en raya?
        JR      Z, CAMBIAR_FIN          ; Sí, salir
        
        LD      A, (ColumnaFull)
        CP      1                       ; ¿Columna llena?
        JP      Z, nohaycambio          ; Sí, repetir turno
        
        LD      A, (Color_Usuario)
        CP      TINTA_Yel               ; ¿Es amarillo?
        JR      NZ, ES_ROJO_CAMBIO      ; No, cambiar a amarillo
        
        LD      A, TINTA_Red            ; Cambiar a rojo
        LD      (Color_Usuario), A
        LD      H, 0                    ; Posición inicial
        LD      L, 0

ES_ROJOYNolocambio:
        CALL    PintaCuadrao1           ; Redibujar cursor rojo

L21:
        PUSH    BC
        LD      BC, $DFFE
        IN      A, (C)                  ; Leer puerto $DFFE
        
        BIT     0, A                    ; Comprobar tecla P (derecha)
        JR      NZ, L22                 ; No pulsada, siguiente
        CALL    SOLTAR_TECLA
        LD      A, 'P'
        LD      (Caracter), A
        POP     BC
        CALL    MOVER_DERECHA           ; Mover a la derecha
        JR      L21                     ; Volver a leer

L22:
        BIT     1, A                    ; Comprobar tecla O (izquierda)
        JR      NZ, L23                 ; No pulsada, siguiente
        CALL    SOLTAR_TECLA
        LD      A, 'O'
        LD      (Caracter), A
        POP     BC
        CALL    MOVER_IZQUIERDA         ; Mover a la izquierda
        JR      L21                     ; Volver a leer

L23:
        LD      BC, $FDFE
        IN      A, (C)                  ; Leer puerto $FDFE
        BIT     3, A                    ; Comprobar tecla F
        JR      NZ, L24                 ; No pulsada, siguiente
        CALL    SOLTAR_TECLA
        LD      A, 'F'
        LD      (Caracter), A
        POP     BC
        JR      CAMBIAR_FIN             ; Finalizar

L24:
        LD      BC, $BFFE
        IN      A, (C)                  ; Leer puerto $BFFE
        BIT     0, A                    ; Comprobar ENTER
        JR      NZ, L25                 ; No pulsada, seguir
        CALL    SOLTAR_TECLA
        LD      A, $FF                  ; Código especial ENTER
        LD      (Caracter), A
        POP     BC
        POP     DE
        POP     BC
        JP      CAMBIAR_USUARIO         ; Procesar soltar ficha

L25:
        POP     BC                      ; Ninguna tecla
        JR      L21                     ; Seguir leyendo

;ES_ROJO_CAMBIO: Salta a preparación del otro jugador
ES_ROJO_CAMBIO:
        POP     DE
        POP     BC
        JP      ES_ROJO                 ; Preparar turno rojo

;CAMBIAR_FIN: Finaliza secuencia de cambio
CAMBIAR_FIN:
        POP     DE
        POP     BC
        RET

;nohaycambio: Repite turno si la columna estaba llena
nohaycambio:
        XOR     A                       ; Limpiar flag de columna llena
        LD      (ColumnaFull), A
        LD      A, (Color_Usuario)
        CP      TINTA_Yel               ; ¿Es amarillo?
        JP      NZ, ES_ROJOYNolocambio  ; No, es rojo
        POP     DE
        POP     BC
        JP      ES_AMARILLOYNolocambio  ; Sí, es amarillo 