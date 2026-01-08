;TABLERO_REDONDO: Dibuja el tablero de juego
TABLERO_REDONDO:
        PUSH    HL
        PUSH    IX
        PUSH    DE
        PUSH    BC
        PUSH    AF
        
        CALL    CLEARSCR                ; Limpiar pantalla
        
        LD      HL, $5800 + 96          ; Posición: 3 filas abajo
        LD      IX, HL          

        LD      A, 8                    ; Color azul (papel)
        LD      B, 19                   ; 19 filas de caracteres

FullCuadrao:
        LD      C, 29                   ; 29 columnas de caracteres

COLUMNA:
        LD      (HL), A                 ; Pintar atributo azul
        INC     HL
        DEC     C
        JR      NZ, COLUMNA             ; Siguiente columna
        
        LD      DE, 32
        ADD     IX, DE                  ; Siguiente fila
        LD      HL, IX
        DEC     B
        JR      NZ, FullCuadrao         ; Siguiente fila

        LD      A, 0                    ; Color negro (selector)
        LD      (Color_Usuario), A
        LD      IX, $4021               ; Dirección pantalla fila 0
        LD      HL, $5821               ; Dirección atributos fila 0
        LD      C, 7                    ; 7 columnas

FilaColumnas0:
        CALL    FICHA                   ; Dibujar ficha vacía
        LD      DE, 4
        ADD     IX, DE                  ; Siguiente columna (pantalla)
        ADD     HL, DE                  ; Siguiente columna (atributos)
        DEC     C
        JR      NZ, FilaColumnas0       ; Siguiente columna

        LD      A, %00001000            ; Ficha negra sobre azul
        LD      (Color_Usuario), A
        LD      IX, $4081               ; Dirección pantalla fila 1
        LD      HL, $5881               ; Dirección atributos fila 1
        LD      C, 7                    ; 7 columnas

FilaColumnas1:
        CALL    FICHA                   ; Dibujar ficha vacía
        LD      DE, 4
        ADD     IX, DE                  ; Siguiente columna (pantalla)
        ADD     HL, DE                  ; Siguiente columna (atributos)
        DEC     C
        JR      NZ, FilaColumnas1       ; Siguiente columna

        LD      IX, $40E1               ; Dirección pantalla fila 2
        LD      HL, $5881 + 96          ; Dirección atributos fila 2
        LD      C, 7                    ; 7 columnas

FilaColumnas2:
        CALL    FICHA                   ; Dibujar ficha vacía
        LD      DE, 4
        ADD     IX, DE                  ; Siguiente columna (pantalla)
        ADD     HL, DE                  ; Siguiente columna (atributos)
        DEC     C
        JR      NZ, FilaColumnas2       ; Siguiente columna

        LD      IX, $4841               ; Dirección pantalla fila 3
        LD      HL, $5881 + 192         ; Dirección atributos fila 3
        LD      C, 7                    ; 7 columnas

FilaColumnas3:
        CALL    FICHA                   ; Dibujar ficha vacía
        LD      DE, 4
        ADD     IX, DE                  ; Siguiente columna (pantalla)
        ADD     HL, DE                  ; Siguiente columna (atributos)
        DEC     C
        JR      NZ, FilaColumnas3       ; Siguiente columna

        LD      IX, $48A1               ; Dirección pantalla fila 4
        LD      HL, $5881 + 288         ; Dirección atributos fila 4
        LD      C, 7                    ; 7 columnas

FilaColumnas4:
        CALL    FICHA                   ; Dibujar ficha vacía
        LD      DE, 4
        ADD     IX, DE                  ; Siguiente columna (pantalla)
        ADD     HL, DE                  ; Siguiente columna (atributos)
        DEC     C
        JR      NZ, FilaColumnas4       ; Siguiente columna

        LD      IX, $5001               ; Dirección pantalla fila 5
        LD      HL, $5881 + 384         ; Dirección atributos fila 5
        LD      C, 7                    ; 7 columnas

FilaColumnas5:
        CALL    FICHA                   ; Dibujar ficha vacía
        LD      DE, 4
        ADD     IX, DE                  ; Siguiente columna (pantalla)
        ADD     HL, DE                  ; Siguiente columna (atributos)
        DEC     C
        JR      NZ, FilaColumnas5       ; Siguiente columna

        LD      IX, $5061               ; Dirección pantalla fila 6
        LD      HL, $5881 + 480         ; Dirección atributos fila 6
        LD      C, 7                    ; 7 columnas

FilaColumnas6:
        CALL    FICHA                   ; Dibujar ficha vacía
        LD      DE, 4
        ADD     IX, DE                  ; Siguiente columna (pantalla)
        ADD     HL, DE                  ; Siguiente columna (atributos)
        DEC     C
        JR      NZ, FilaColumnas6       ; Siguiente columna
       
        LD      A, TINTA_Yel            ; Restaurar color amarillo
        LD      (Color_Usuario), A
        
        POP     AF
        POP     BC
        POP     DE
        POP     IX
        POP     HL
        RET