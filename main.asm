        DEVICE ZXSPECTRUM48
        SLDOPT COMMENT WPMEM, LOGPOINT, ASSETION
        ORG     $8000                   ; Programa ubicado a partir de $8000 = 32768
        LD      SP, 0                   ; Inicializar pila
        JP      inicio                  ; Saltar a punto de entrada principal



portada:        INCBIN "portada.scr"

; SECCION DE DATOS - Cadenas de texto
M_WL:           DB "Bienvenido al Conecta 4", 0
M_PR:           DB "Quieres jugar?", 0 
M_GB:           DB "Adios!!!!", 0
M_PF:           DB "La partida ha finalizado  ", 0 
M_QJ:           DB "Quieres jugar otra partida? ", 0
M_GAN_AMARILLO: DB "Ganador: Amarillo", 0
M_GAN_ROJO:     DB "Ganador: Rojo", 0
M_TABLAS:       DB "Tablas", 0
M_COL_LLENA:    DB "Columna llena!", 0

;Variables de estado del juego
FullTablero:    DB 0                    ; Flag: 1 = tablero lleno
ContadorFichas: DB 0                    ; Contador de fichas colocadas (max 42)
Ganador:        DB 0                    ; 0=tablas, TINTA_Yel=amarillo, TINTA_Red=rojo
ColumnaFull:    DB 0                    ; Flag: 1 = columna actual llena
Caracter:       DB 0                    ; Ultimo caracter leido del teclado

;Constantes de colores
PAPEL_Azul      EQU 1*8                 ; Papel azul (bits 3-5)
TINTA_Yel       EQU 6                   ; Tinta amarilla (bits 0-2)
TINTA_Red       EQU 2                   ; Tinta roja (bits 0-2)
TINTA_Blck      EQU 0                   ; Tinta negra (bits 0-2)

;Variables de control del jugador
Color_Usuario:  DB TINTA_Yel            ; Color del jugador actual

;Constantes de posicion
POS_MAX1        EQU 6                   ; Columna maxima (0-6)
POS_MIN1        EQU 0                   ; Columna minima (0-6)

; Array del tablero con bordes (9 bytes x 6 filas)
; Estructura: $FF | 7 columnas | $FF (bordes para deteccion de limites)
Posiciones1:
        DB $FF,0,0,0,0,0,0,0,$FF
        DB $FF,0,0,0,0,0,0,0,$FF
        DB $FF,0,0,0,0,0,0,0,$FF
        DB $FF,0,0,0,0,0,0,0,$FF
        DB $FF,0,0,0,0,0,0,0,$FF
        DB $FF,0,0,0,0,0,0,0,$FF
       
;inicio: Punto de entrada y menú principal
inicio:
        LD      A, 0
        OUT     ($FE), A                ; Establecer borde negro
        CALL    CLEARSCR                ; Limpiar pantalla
        CALL    IMPORT_DRAW             ; Dibujar portada
        
        LD      B, 0                    ; Fila 0
        LD      C, 5                    ; Columna 5
        LD      A, 2+0*8+64             ; Atributo: tinta roja, bright
        LD      IX, M_WL
        CALL    PRINTAT                 ; Mostrar "Bienvenido al Conecta 4"

        LD      A, 6                    ; Atributo: tinta amarilla
        LD      B, 20                   ; Fila 20
        LD      C, 1                    ; Columna 1
        LD      IX, M_PR
        CALL    PRINTAT                 ; Mostrar "Quieres jugar?"
        
        LD      A, 6*8+128              ; Atributo con flash
        LD      ($5800+20*32+16), A     ; Marcar cursor

        CALL    LEER_SN                 ; Esperar respuesta S/N
        JR      NZ, fin                 ; Si N, terminar
        CALL    JUEGO                   ; Iniciar juego

;JUGAR_NUEVAMENTE: Bucle para repetir partidas y mostrar resultado
JUGAR_NUEVAMENTE:
        LD      A, 0 
        OUT     ($FE), A                ; Borde negro
        CALL    CLEARSCR
        
        LD      B, 1                    ; Fila 1
        LD      C, 5                    ; Columna 5
        LD      A, 1                    ; Atributo: tinta azul
        LD      IX, M_PF
        CALL    PRINTAT                 ; "La partida ha finalizado"

        CALL    MostrarResultado        ; Mostrar ganador o tablas

        LD      A, 6                    ; Atributo: tinta amarilla
        LD      B, 12                   ; Fila 12
        LD      C, 1                    ; Columna 1
        LD      IX, M_QJ
        CALL    PRINTAT                 ; "Quieres jugar otra partida?"
        
        LD      A, 6*8+128
        LD      ($5800+12*32+30), A     ; Marcar cursor
        
        CALL    LEER_SN                 ; Esperar respuesta S/N
        JR      NZ, fin                 ; Si N, terminar
        
        CALL    JUEGO                   ; Nueva partida
        JP      JUGAR_NUEVAMENTE        ; Bucle de juego

;fin: Finaliza la ejecución del programa
fin:     
        HALT 

;Incluye módulos del programa
        INCLUDE "PRINTAT.asm"
        INCLUDE "TABLERO.asm"
        INCLUDE "Importar_portada.asm"
        INCLUDE "pintaficha1.asm"
        INCLUDE "telasNuevas.asm"
        INCLUDE "juego1.asm"
        INCLUDE "terminar.asm"
        INCLUDE "slotpointer.asm"
        INCLUDE "SlotPointer_PosicionesArray.asm"





;SOLTAR_TECLA: Espera a que se suelten todas las teclas
SOLTAR_TECLA:
        PUSH    AF
SOLTAR_TECLA_LOOP:
        IN      A, (C)
        AND     $1F                     ; Máscara bits 0-4 (teclas)
        CP      $1F                     ; $1F = ninguna tecla pulsada
        JR      NZ, SOLTAR_TECLA_LOOP   ; Si hay tecla, esperar
        POP     AF
        RET
;LEER_SN: Lee 'S' o 'N' del teclado
LEER_SN:
        PUSH    BC
        PUSH    DE
        PUSH    HL
        PUSH    IX

SN_0: 
        LD      BC, $FDFE
        IN      A, (C)                  
        BIT     1, A                    ; Comprobar tecla 'S'
        JR      NZ, SN_1                ; No pulsada, probar 'N'
        
        CALL    SOLTAR_TECLA            ; Tecla 'S' pulsada
        LD      A, 'S'
        CALL    CLEARSCR
        XOR     A                       ; Z=1 (si)
        
        POP     IX
        POP     HL
        POP     DE
        POP     BC
        RET
       
SN_1:
        LD      BC, $7FFE
        IN      A, (C)                  
        BIT     3, A                    ; Comprobar tecla 'N'
        JR      NZ, SN_0                ; No pulsada, volver a 'S'
        
        CALL    SOLTAR_TECLA            ; Tecla 'N' pulsada
        LD      A, 'N'
        LD      A, 0 
        OUT     ($FE), A                ; Borde negro
        CALL    CLEARSCR
        
        LD      B, 12                   ; Fila 12
        LD      C, 12                   ; Columna 12
        LD      A, 0+2*8+64             ; Atributo: rojo, bright
        LD      IX, M_GB
        CALL    PRINTAT                 ; Mostrar "Adios!!!!"
        
        LD      A, 1
        OR      A                       ; Z=0 (no)
        
        POP     IX
        POP     HL
        POP     DE
        POP     BC
        RET