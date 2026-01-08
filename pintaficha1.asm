; pintaficha1: Dibuja fichas y animación del tablero.

; FICHA: Dibuja una ficha circular (3x2).
FICHA:
        PUSH    HL
        PUSH    DE
        PUSH    BC 
        PUSH    IX 
        PUSH    AF
        
        CALL    PintaCuadrao            ; Pintar fondo del cuadrado
        LD      HL, IX                  ; HL = dirección de pantalla
        
        LD      A, H                    ; Detectar fila problemática
        CP      $40                     ; ¿Segundo tercio?
        JR      NZ, FICHA_NORMAL        ; No, usar normal
        LD      A, L  
        CP      $E1                     ; ¿Está entre $E1 y $F9?
        JR      C, FICHA_NORMAL         ; No, usar normal
        CP      $FA
        JR      NC, FICHA_NORMAL        ; No, usar normal
        CALL    FICHA_ENTERCIO_DRAW     ; Sí, usar especial
        JP      Fin_Ficha

FICHA_NORMAL:
        CALL    FICHA_NORMAL_DRAW       ; Dibujar ficha normal
        JP      Fin_Ficha

; FICHA_NORMAL_DRAW: Dibuja ficha en modo normal.
FICHA_NORMAL_DRAW:
        ; Arriba izquierda
        LD      A, %00000000
        LD      (HL), A                 ; Línea 0
        LD      DE, $100
        ADD     HL, DE
        LD      A, %00000001
        LD      (HL), A                 ; Línea 1
        ADD     HL, DE
        LD      A, %00000011
        LD      (HL), A                 ; Línea 2
        ADD     HL, DE
        LD      A, %00000111
        LD      (HL), A                 ; Línea 3
        ADD     HL, DE
        LD      (HL), A                 ; Línea 4
        ADD     HL, DE
        LD      A, %00001111
        LD      (HL), A                 ; Línea 5
        ADD     HL, DE
        LD      (HL), A                 ; Línea 6
        ADD     HL, DE
        LD      (HL), A                 ; Línea 7 

        ; Arriba centro
        INC     IX
        LD      HL, IX
        LD      A, %01111110
        LD      (HL), A                 ; Línea 0
        LD      DE, $100
        ADD     HL, DE
        LD      A, %11111111
        LD      (HL), A                 ; Línea 1
        ADD     HL, DE
        LD      (HL), A                 ; Línea 2
        ADD     HL, DE
        LD      (HL), A                 ; Línea 3
        ADD     HL, DE
        LD      (HL), A                 ; Línea 4
        ADD     HL, DE
        LD      (HL), A                 ; Línea 5
        ADD     HL, DE
        LD      (HL), A                 ; Línea 6
        ADD     HL, DE
        LD      (HL), A                 ; Línea 7

        ; Arriba derecha
        INC     IX
        LD      HL, IX
        LD      A, %00000000
        LD      (HL), A                 ; Línea 0
        LD      DE, $100
        ADD     HL, DE
        LD      A, %10000000
        LD      (HL), A                 ; Línea 1
        ADD     HL, DE
        LD      A, %11000000
        LD      (HL), A                 ; Línea 2
        ADD     HL, DE
        LD      A, %11100000
        LD      (HL), A                 ; Línea 3
        ADD     HL, DE
        LD      (HL), A                 ; Línea 4
        ADD     HL, DE
        LD      A, %11110000
        LD      (HL), A                 ; Línea 5
        ADD     HL, DE
        LD      (HL), A                 ; Línea 6
        ADD     HL, DE
        LD      (HL), A                 ; Línea 7

        ; Abajo derecha
        LD      BC, $20
        ADD     IX, BC                  ; Siguiente carácter
        LD      HL, IX
        LD      A, %11110000
        LD      (HL), A                 ; Línea 0
        LD      DE, $100
        ADD     HL, DE
        LD      (HL), A                 ; Línea 1
        ADD     HL, DE
        LD      (HL), A                 ; Línea 2
        ADD     HL, DE
        LD      A, %11100000
        LD      (HL), A                 ; Línea 3
        ADD     HL, DE
        LD      (HL), A                 ; Línea 4
        ADD     HL, DE
        LD      A, %11000000
        LD      (HL), A                 ; Línea 5
        ADD     HL, DE
        LD      A, %10000000
        LD      (HL), A                 ; Línea 6
        ADD     HL, DE
        LD      A, %00000000
        LD      (HL), A                 ; Línea 7

        ; Abajo centro
        DEC     IX
        LD      HL, IX
        LD      A, %11111111
        LD      (HL), A                 ; Línea 0
        LD      DE, $100
        ADD     HL, DE
        LD      (HL), A                 ; Línea 1
        ADD     HL, DE
        LD      (HL), A                 ; Línea 2
        ADD     HL, DE
        LD      (HL), A                 ; Línea 3
        ADD     HL, DE
        LD      (HL), A                 ; Línea 4
        ADD     HL, DE
        LD      (HL), A                 ; Línea 5
        ADD     HL, DE
        LD      (HL), A                 ; Línea 6
        ADD     HL, DE
        LD      A, %01111110
        LD      (HL), A                 ; Línea 7

        ; Abajo izquierda
        DEC     IX 
        LD      HL, IX
        LD      A, %00001111
        LD      (HL), A                 ; Línea 0
        LD      DE, $100
        ADD     HL, DE
        LD      (HL), A                 ; Línea 1
        ADD     HL, DE
        LD      (HL), A                 ; Línea 2
        ADD     HL, DE
        LD      A, %00000111
        LD      (HL), A                 ; Línea 3
        ADD     HL, DE
        LD      (HL), A                 ; Línea 4
        ADD     HL, DE
        LD      A, %00000011 
        LD      (HL), A                 ; Línea 5
        ADD     HL, DE
        LD      A, %00000001
        LD      (HL), A                 ; Línea 6
        ADD     HL, DE
        LD      A, %00000000
        LD      (HL), A                 ; Línea 7
        RET

; FICHA_ENTERCIO_DRAW: Dibuja ficha cruzando tercio.
FICHA_ENTERCIO_DRAW:
        ; Arriba izquierda
        LD      A, %00000000
        LD      (HL), A                 ; Línea 0
        LD      DE, $100
        ADD     HL, DE
        LD      A, %00000001
        LD      (HL), A                 ; Línea 1
        ADD     HL, DE
        LD      A, %00000011
        LD      (HL), A                 ; Línea 2
        ADD     HL, DE
        LD      A, %00000111
        LD      (HL), A                 ; Línea 3
        ADD     HL, DE
        LD      (HL), A                 ; Línea 4
        ADD     HL, DE
        LD      A, %00001111
        LD      (HL), A                 ; Línea 5
        ADD     HL, DE
        LD      (HL), A                 ; Línea 6
        ADD     HL, DE
        LD      (HL), A                 ; Línea 7

        ; Arriba centro
        INC     IX
        LD      HL, IX
        LD      A, %01111110
        LD      (HL), A                 ; Línea 0
        LD      DE, $100
        ADD     HL, DE
        LD      A, %11111111
        LD      (HL), A                 ; Línea 1
        ADD     HL, DE
        LD      (HL), A                 ; Línea 2
        ADD     HL, DE
        LD      (HL), A                 ; Línea 3
        ADD     HL, DE
        LD      (HL), A                 ; Línea 4
        ADD     HL, DE
        LD      (HL), A                 ; Línea 5
        ADD     HL, DE
        LD      (HL), A                 ; Línea 6
        ADD     HL, DE
        LD      (HL), A                 ; Línea 7

        ; Arriba derecha
        INC     IX
        LD      HL, IX
        LD      A, %00000000
        LD      (HL), A                 ; Línea 0
        LD      DE, $100
        ADD     HL, DE
        LD      A, %10000000
        LD      (HL), A                 ; Línea 1
        ADD     HL, DE
        LD      A, %11000000
        LD      (HL), A                 ; Línea 2
        ADD     HL, DE
        LD      A, %11100000
        LD      (HL), A                 ; Línea 3
        ADD     HL, DE
        LD      (HL), A                 ; Línea 4
        ADD     HL, DE
        LD      A, %11110000
        LD      (HL), A                 ; Línea 5
        ADD     HL, DE
        LD      (HL), A                 ; Línea 6
        ADD     HL, DE
        LD      (HL), A                 ; Línea 7

        ; Abajo derecha (offset especial $720)
        LD      BC, $720
        ADD     IX, BC                  ; Salto especial para tercio
        LD      HL, IX
        LD      A, %11110000
        LD      (HL), A                 ; Línea 0
        LD      DE, $100
        ADD     HL, DE
        LD      (HL), A                 ; Línea 1
        ADD     HL, DE
        LD      (HL), A                 ; Línea 2
        ADD     HL, DE
        LD      A, %11100000
        LD      (HL), A                 ; Línea 3
        ADD     HL, DE
        LD      (HL), A                 ; Línea 4
        ADD     HL, DE
        LD      A, %11000000
        LD      (HL), A                 ; Línea 5
        ADD     HL, DE
        LD      A, %10000000
        LD      (HL), A                 ; Línea 6
        ADD     HL, DE
        LD      A, %00000000
        LD      (HL), A                 ; Línea 7

        ; Abajo centro
        DEC     IX
        LD      HL, IX
        LD      A, %11111111
        LD      (HL), A                 ; Línea 0
        LD      DE, $100
        ADD     HL, DE
        LD      (HL), A                 ; Línea 1
        ADD     HL, DE
        LD      (HL), A                 ; Línea 2
        ADD     HL, DE
        LD      (HL), A                 ; Línea 3
        ADD     HL, DE
        LD      (HL), A                 ; Línea 4
        ADD     HL, DE
        LD      (HL), A                 ; Línea 5
        ADD     HL, DE
        LD      (HL), A                 ; Línea 6
        ADD     HL, DE
        LD      A, %01111110
        LD      (HL), A                 ; Línea 7

        ; Abajo izquierda
        DEC     IX 
        LD      HL, IX
        LD      A, %00001111
        LD      (HL), A                 ; Línea 0
        LD      DE, $100
        ADD     HL, DE
        LD      (HL), A                 ; Línea 1
        ADD     HL, DE
        LD      (HL), A                 ; Línea 2
        ADD     HL, DE
        LD      A, %00000111
        LD      (HL), A                 ; Línea 3
        ADD     HL, DE
        LD      (HL), A                 ; Línea 4
        ADD     HL, DE
        LD      A, %00000011 
        LD      (HL), A                 ; Línea 5
        ADD     HL, DE
        LD      A, %00000001
        LD      (HL), A                 ; Línea 6
        ADD     HL, DE
        LD      A, %00000000
        LD      (HL), A                 ; Línea 7
        RET

; Fin_Ficha: Salida de FICHA y restauración de registros.
Fin_Ficha:
        POP     AF
        POP     IX
        POP     BC
        POP     DE
        POP     HL
        RET

; PintaCuadrao: Pinta cuadrado 3x2 con color del usuario.
PintaCuadrao:
        LD      A, (Color_Usuario)
        JR      SEGUIR

; BORRAR_FICHA: Borra cuadrado 3x2 (atributo 0).
BORRAR_FICHA:
        LD      A, 0

SEGUIR:
        PUSH    BC 
        PUSH    HL
        PUSH    AF
        PUSH    DE

        LD      (HL), A                 ; Byte 0 fila 1
        INC     HL
        LD      (HL), A                 ; Byte 1 fila 1
        INC     HL
        LD      (HL), A                 ; Byte 2 fila 1
        
        LD      DE, 32                  ; Siguiente fila de atributos
        ADD     HL, DE
        LD      (HL), A                 ; Byte 2 fila 2
        DEC     HL
        LD      (HL), A                 ; Byte 1 fila 2
        DEC     HL
        LD      (HL), A                 ; Byte 0 fila 2

        POP     DE
        POP     AF
        POP     HL
        POP     BC
        RET

; Datos: Variables de posición de ficha.
ColumnaFinal:   DB 0                    ; Columna donde cayo la ficha (0-6)
FilaFinal:      DB 0                    ; Fila donde cayo la ficha (0-5)

; Animacion_Caeficha: Anima caída y actualiza estado del juego.
Animacion_Caeficha:
        PUSH    AF
        PUSH    BC
        PUSH    DE
        PUSH    IX

        XOR     A                       ; Limpiar flag columna llena
        LD      (ColumnaFull), A

        LD      A, L                    ; Guardar columna
        LD      (ColumnaFinal), A
        
        LD      IX, Posiciones1         ; Base del array
        INC     A                       ; +1 por borde $FF
        LD      E, A
        LD      D, 0
        ADD     IX, DE                  ; IX apunta a la columna

        LD      DE, 9*5                 ; Ir a última fila
        ADD     IX, DE

        LD      B, 6                    ; 6 filas a comprobar
        LD      DE, -9                  ; Salto hacia arriba

BuscarHueco:
        LD      A, (IX)
        CP      0                       ; ¿Hueco vacío?
        JR      Z, HuecoEncontrado      ; Sí, usar este

        ADD     IX, DE                  ; Subir 1 fila
        DJNZ    BuscarHueco             ; Repetir

        JR      ColumnaLlena            ; No hay hueco

HuecoEncontrado:
        LD      A, (Color_Usuario)      ; Guardar color en array
        LD      (IX), A

        LD      A, B                    ; Calcular fila final
        DEC     A                       ; B=6 -> fila 5, etc.
        LD      (FilaFinal), A
        LD      C, B                    ; C = pasos de animación
        LD      H, 0                    ; Empezar desde fila 0

bucle_Cae:
        INC     H                       ; Siguiente fila
        CALL    PintaCuadrao1           ; Dibujar ficha
        CALL    ESPERAR                 ; Retardo
        DEC     C                       ; Decrementar pasos
        JR      Z, TerminaAnimacion     ; Si C=0, terminar
        CALL    BORRAR_FICHA1           ; Borrar ficha anterior
        JR      bucle_Cae               ; Repetir

TerminaAnimacion:
        XOR     A
        LD      (ColumnaFull), A        ; Limpiar flag
        
        LD      A, (ContadorFichas)     ; Incrementar contador
        INC     A
        LD      (ContadorFichas), A
        
        PUSH    HL                      ; Guardar HL
        LD      A, (FilaFinal)
        LD      H, A
        LD      A, (ColumnaFinal)
        LD      L, A
        CALL    Comprobar4enraya        ; Comprobar victoria
        POP     HL                      ; Restaurar HL
        
        LD      A, (Caracter)
        CP      'F'                     ; ¿Hay 4 en raya?
        JR      Z, Animacion_Fin        ; Sí, salir
        
        LD      A, (ContadorFichas)
        CP      42                      ; ¿Tablero lleno?
        JR      NZ, Animacion_Fin       ; No, salir normal
        
        LD      A, 'F'                  ; Sí, marcar fin (tablas)
        LD      (Caracter), A

Animacion_Fin:
        POP     IX
        POP     DE
        POP     BC
        POP     AF
        RET

; ColumnaLlena: Marca columna llena.
ColumnaLlena:
        LD      A, 1                    ; Marcar columna llena
        LD      (ColumnaFull), A
        POP     IX
        POP     DE
        POP     BC
        POP     AF
        RET

; PintaCuadrao1: Pinta 3x2 en coordenadas del tablero.
PintaCuadrao1:
        LD      A, H
        OR      A                       ; ¿Fila 0?
        JR      Z, COLOR_SUPERIOR       ; Sí, sin fondo azul
        LD      A, (Color_Usuario)
        OR      PAPEL_Azul              ; Añadir fondo azul
        JR      SEGUIR1

COLOR_SUPERIOR:
        LD      A, (Color_Usuario)      ; Solo color, sin fondo
        JR      SEGUIR1

; BORRAR_FICHA1: Borra 3x2 en coordenadas del tablero.
BORRAR_FICHA1:
        LD      A, H
        OR      A                       ; ¿Fila 0?
        JR      Z, BORRAR_SUPERIOR      ; Sí, atributo 0
        LD      A, PAPEL_Azul + TINTA_Blck
        JR      SEGUIR1

BORRAR_SUPERIOR:
        XOR     A                       ; Atributo 0

SEGUIR1:
        PUSH    HL
        PUSH    DE
        PUSH    BC
        PUSH    AF                      ; Guardar atributo

        ; Convertir coordenadas logicas a posicion de atributos
        ; H = H*3 + 1 (fila de caracteres)
        LD      B, A                    ; Guardar atributo en B
        LD      A, H
        ADD     A, H
        ADD     A, H 
        INC     A 
        LD      H, A
        
        ; L = L*4 + 1 (columna de caracteres)
        LD      A, L
        ADD     A, L 
        ADD     A, A 
        INC     A 
        LD      L, A
        
        CALL    SlotPointer             ; HL = direccion de atributos

        ; Pintar cuadrado 3x2
        LD      A, B                    ; Recuperar atributo
        LD      (HL), A
        INC     HL
        LD      (HL), A
        INC     HL
        LD      (HL), A
        LD      DE, 32
        ADD     HL, DE
        LD      (HL), A
        DEC     HL
        LD      (HL), A
        DEC     HL
        LD      (HL), A

        POP     AF
        POP     BC
        POP     DE
        POP     HL
        RET

; ESPERAR: Retardo para animación de fichas.
ESPERAR: 
        PUSH    BC 
        LD      B, 50
D1:     
        LD      C, 255
D2:     
        DEC     C 
        JR      NZ, D2 
        DJNZ    D1 
        POP     BC
        RET