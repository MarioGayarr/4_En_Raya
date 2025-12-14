       DEVICE ZXSPECTRUM48
       SLDOPT COMMENT WPMEM, LOGPOINT, ASSETION
       org $8000               ; Programa ubicado a partir de $8000 = 32768
       ld sp, 0   
       jp inicio
portada: INCBIN "portada.scr"

M_WL:
       DB "Bienvenido al Conecta 4", 0
M_PR:
       DB "Quieres jugar?", 0 
M_GB:
       DB "Adios!!!!", 0
M_RS:
       DB 0,0 
M_PF:
       DB "La partida ha finalizado  ", 0 
M_QJ: 
       DB "Quieres jugar otra partida? ", 0
M_GAN_AMARILLO:
       DB "Ganador: Amarillo", 0
M_GAN_ROJO:
       DB "Ganador: Rojo", 0
M_TABLAS:
       DB "Tablas", 0
FullTablero DB 0
ContadorFichas DB 0
Ganador DB 0          ; 0=tablas, TINTA_Yel=amarillo, TINTA_Red=rojo
ColumnaFull db 0
Caracter DB 0
PAPEL_Azul EQU 1*8
TINTA_Yel EQU 6
TINTA_Red EQU 2
TINTA_Blck EQU 0
Color_Usuario db TINTA_Yel
POS_MAX EQU $3A ;$5839 EN ATRIBUTOS (+24)
POS_MIN EQU $20 ;$5821
;nuevas pos max
POS_MAX1 EQU 6 ;$5839 EN ATRIBUTOS , en fila 7 en L
POS_MIN1 EQU 0 ;columna inicial en atributos
Posiciones:
       db 0,0,0,0,0,0,0
       db 0,0,0,0,0,0,0
       db 0,0,0,0,0,0,0
       db 0,0,0,0,0,0,0
       db 0,0,0,0,0,0,0
       db 0,0,0,0,0,0,0
Posiciones1:; poner $ff, cambiar rutina limpieza
       db $ff,0,0,0,0,0,0,0,$ff
       db $ff,0,0,0,0,0,0,0,$ff
       db $ff,0,0,0,0,0,0,0,$ff
       db $ff,0,0,0,0,0,0,0,$ff
       db $ff,0,0,0,0,0,0,0,$ff
       db $ff,0,0,0,0,0,0,0,$ff
       
;recomendado usar DE para color y n.judador con EXX para ir cambiando
inicio:
       
       LD A, 0 
       OUT ($FE), A
       CALL CLEARSCR
       CALL IMPORT_DRAW
       LD B, 0        
       LD C, 5
       LD A, 2+0*8+64
       LD IX, M_WL
       CALL PRINTAT

       LD A, 6
       LD B, 20
       LD C, 1
       LD IX, M_PR
       CALL PRINTAT
       LD A, 6*8+128
       LD ($5800+20*32+16), A

       CALL LEER_SN
       JR NZ, fin
       CALL JUEGO ;al salir la primera vez con F baja a jugar nuevamente.

JUGAR_NUEVAMENTE:  ; empieza limpiando e imprimiendo los dos textos de la pantalla
       LD A, 0 
       OUT ($FE), A
       CALL CLEARSCR
       LD B, 1
       LD C, 5
       LD A, 1
       LD IX, M_PF
       CALL PRINTAT

       ; Mostrar resultado de la partida
       CALL MostrarResultado

       LD A, 6
       LD B, 12
       LD C, 1
       LD IX, M_QJ
       CALL PRINTAT
       LD A, 6*8+128
       LD ($5800+12*32+30), A   
       CALL LEER_SN     ; hace la funcion nuevamente de la pantalla inicial
       JR NZ, fin
       
       CALL JUEGO
       JP JUGAR_NUEVAMENTE
fin:     
       HALT 
        
        INCLUDE "PRINTAT.asm"
        INCLUDE "TABLERO.asm"
        INCLUDE "Importar_portada.asm"
        INCLUDE "pintaficha1.asm"
        INCLUDE "telasNuevas.asm"
        INCLUDE "juego1.asm"
        INCLUDE "terminar.asm"
       INCLUDE "slotpointer.asm"
       INCLUDE "SlotPointer_PosicionesArray.asm"





SOLTAR_TECLA:
       IN A, (C)
       AND $1F ;ASEGURA QUE LOS BITS DE A (0-7) LOS PRIMEROS 5 SON LOS Q NOS INTERESAN, ASEGURA QUE A VALGA %00011111
       CP $1F ;COMPRUEBA SI SE HA ESCRITO ALGO PORQUE SI VALE 1F SIGNIFICA QUE NO SE HA PULSADO TECLAS
       JR NZ, SOLTAR_TECLA ;SI Z=0 (ES DECIR, A ES DISTINTO DE $1F), LA TECLA SIGUE PULSADA ENTONCES BUCLE HASTA QUE EL USUARIO LA SUELTE
       RET






LEER_SN:
       PUSH BC
SN_0: 
       LD BC, $FDFE ;'S' en D1
       IN A, (C) 
       BIT 1, A
       JR NZ, SN_1
       CALL SOLTAR_TECLA
       LD A, 'S'
       CALL CLEARSCR
       ;Z=1
       XOR A
       POP BC
       RET
       
SN_1:
       LD BC, $7FFE ;'N' en D3
       IN A, (C)
       BIT 3, A
       JR NZ, SN_0
       CALL SOLTAR_TECLA
       LD A, 'N'
       CALL CLEARSCR
       LD A, 0 
       OUT ($FE), A
       CALL CLEARSCR
       LD B, 12
       LD C, 12
       LD A, 0+2*8+64
       LD IX, M_GB
       CALL PRINTAT
       ;Z=0
       LD A, 1
       OR A
       POP BC
       RET