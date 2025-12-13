    DEVICE ZXSPECTRUM48
    ORG $8000
    LD SP, $6000

VRAM    EQU     $5800       ; Dirección de los atributos de video
XY_INICIO   EQU     $0200   ; Coordenadas de incio del tipógrafo
Inicio:
    CALL CLEARSCR   ; Borrar pantalla
    LD A,1          ; Letra azul, fondo negro
    LD B,0          ; Coordenadas para pintar el título
    LD C,11         ; Columna 11
    LD IX,Mensaje   ; Dirección del título
    CALL PRINTAT    ; Imprime el título

    CALL Init_Cursor
Bucle:
    CALL Prt_Cursor     ; pintar el cursor parpadeante
    CALL Lee_Tecla      ; Leer tecla pulsada en carácter
    CALL Soltar_Tecla   ; Esperar a que la tecla pulsada se libere
    CALL Escribe        ; Escribe el carácter pulsado
    LD HL,(Coordenada)  ; Comprobar si se ha llegado a la última línea
    LD A,H
    CP 23
    JR Z, Inicio        ; Si es la última línea volver empezar
    JR Bucle            ; siguiente carácter
    
Escribe:                ; Rutina de escribir el carácter pulsado
    LD IX,Caracter      ; Dirección donde se ha guardado el carácter pulsado
    LD bc,(Coordenada)  ; Coordenadas donde hay que escribirlo
    LD A,(IX)           ; Comprobar si se ha pulsado RETURN
    CP $FF
    JR NZ,E1            ; Si no es RETURN
    LD HL,(Dir_Attr)    ; Dirección del siguiente atributo a escribir
    DEC HL              ; Retroceder al cursor
    LD (HL),0           ; Quitar cursor
    INC HL              ; Volver al siguiente atributo a escribir
    LD A,C              ; Columna de HL
E3:                     ; Bucle para saltar a la siguiente fila
    INC A               ; Siguiente columna
    INC HL              ; Siguiente posición de atributo
    CP 31               ; ¿Es la última columna?
    JR NZ,E3            ; Bucle hasta que sea la columna 31
    LD (Dir_Attr),HL    ; Guardar la dirección del atributo
    INC B               ; Siguiente fila
    LD C,0              ; Columna 0
    JR E2               ; Saltar a fin
E1:
    LD A,2              ; Color letra roja, fondo negro
    CALL PRINTAT        ; Imprimir el carácter
    LD BC,(Coordenada)  ; Cargar la coordenada donde se ha escrito el carácter por si PRINTAT lo ha cambiado
    inc BC              ; Siguiente coordenada
    LD A,32             ; Comprobar si es la columna 32
    CP C            
    JR NZ,E2            ; Si no lo es saltar a fin     
    INC B               ; Si es columna 32, siguiente fila y columna 0
    LD C,0 
E2: 
    LD HL,BC            ; Guardar la coordenada
    LD (Coordenada),HL
    RET                 ; retorno
Soltar_Tecla:           ; Rutina de espera hasta que se suelta la tecla
    IN A,(C)            ; Leer del puerto que se ha definido en Lee_Tecla
    AND $1F
    CP $1F              ; Comprobar que no hay tecla pulsada
    JR NZ,Soltar_Tecla  ; esperar hasta que no haya tecla pulsada
    RET
Lee_Tecla:
    LD BC,$FEFE         ; Primera línea de teclas
    IN A,(C)            ; leer si hay alguna tecla pulsada
L1:                     ; Si es la primera tecla (la tecla 0 no interesa)
    BIT 1,A             ; Comprobar el bit D1
    JR NZ,L2            ; Si está a 1 mirar siguiente tecla
    LD A,'Z'            ; Se ha pulsado la 'Z'
    LD (Caracter),A     ; Cargar el carácter 'Z' en el mensaje a imprimir
    RET
L2:                     ; Se repite lo mismo para las 40 teclas
    BIT 2,A
    JR NZ,L3
    LD A,'X'
    LD (Caracter),A
    RET
L3:
    BIT 3,A
    JR NZ,L4
    LD A,'C'
    LD (Caracter),A
    RET
L4:
    BIT 4,A
    JR NZ,L5
    LD A,'V'
    LD (Caracter),A
    RET
L5:                     ; Este cambia porque es RETURN y se carga como carácter $FF
    LD BC,$BFFE
    IN A,(C)
    BIT 0,A
    JR NZ,L6
    LD A,$FF
    LD (Caracter),A
    RET
L6:
    BIT 1,A
    JR NZ,L7
    LD A,'L'
    LD (Caracter),A
    RET
L7:
    BIT 2,A
    JR NZ,L8
    LD A,'K'
    LD (Caracter),A
    RET
L8:
    BIT 3,A
    JR NZ,L9
    LD A,'J'
    LD (Caracter),A
    RET
L9:
    BIT 4,A
    JR NZ,L10
    LD A,'H'
    LD (Caracter),A
    RET
L10:
    LD BC,$FDFE
    IN A,(C)
    BIT 0,A
    JR NZ,L11
    LD A,'A'
    LD (Caracter),A
    RET
L11:
    BIT 1,A
    JR NZ,L12
    LD A,'S'
    LD (Caracter),A
    RET
L12:
    BIT 2,A
    JR NZ,L13
    LD A,'D'
    LD (Caracter),A
    RET
L13:
    BIT 3,A
    JR NZ,L14
    LD A,'F'
    LD (Caracter),A
    RET
L14:
    BIT 4,A
    JR NZ,L15
    LD A,'G'
    LD (Caracter),A
    RET
L15:
    LD BC,$FBFE
    IN A,(C)
    BIT 0,A
    JR NZ,L16
    LD A,'Q'
    LD (Caracter),A
    RET
L16:
    BIT 1,A
    JR NZ,L17
    LD A,'W'
    LD (Caracter),A
    RET
L17:
    BIT 2,A
    JR NZ,L18
    LD A,'E'
    LD (Caracter),A
    RET
L18:
    BIT 3,A
    JR NZ,L19
    LD A,'R'
    LD (Caracter),A
    RET
L19:
    BIT 4,A
    JR NZ,L20
    LD A,'T'
    LD (Caracter),A
    RET
L20:
    LD BC,$F7FE
    IN A,(C)
    BIT 0,A
    JR NZ,L21
    LD A,'1'
    LD (Caracter),A
    RET
L21:
    BIT 1,A
    JR NZ,L22
    LD A,'2'
    LD (Caracter),A
    RET
L22:
    BIT 2,A
    JR NZ,L23
    LD A,'3'
    LD (Caracter),A
    RET
L23:
    BIT 3,A
    JR NZ,L24
    LD A,'4'
    LD (Caracter),A
    RET
L24:
    BIT 4,A
    JR NZ,L25
    LD A,'5'
    LD (Caracter),A
    RET
L25:
    LD BC,$EFFE
    IN A,(C)
    BIT 0,A
    JR NZ,L26
    LD A,'0'
    LD (Caracter),A
    RET
L26:
    BIT 1,A
    JR NZ,L27
    LD A,'9'
    LD (Caracter),A
    RET
L27:
    BIT 2,A
    JR NZ,L28
    LD A,'8'
    LD (Caracter),A
    RET
L28:
    BIT 3,A
    JR NZ,L29
    LD A,'7'
    LD (Caracter),A
    RET
L29:
    BIT 4,A
    JR NZ,L30
    LD A,'6'
    LD (Caracter),A
    RET
L30:
    LD BC,$DFFE
    IN A,(C)
    BIT 0,A
    JR NZ,L31
    LD A,'P'
    LD (Caracter),A
    RET
L31:
    BIT 1,A
    JR NZ,L32
    LD A,'O'
    LD (Caracter),A
    RET
L32:
    BIT 2,A
    JR NZ,L33
    LD A,'I'
    LD (Caracter),A
    RET
L33:
    BIT 3,A
    JR NZ,L34
    LD A,'U'
    LD (Caracter),A
    RET
L34:
    BIT 4,A
    JR NZ,L35
    LD A,'Y'
    LD (Caracter),A
    RET
L35:
    LD BC,$7FFE
    IN A,(C)
    BIT 0,A
    JR NZ,L36
    LD A,' '
    LD (Caracter),A
    RET
L36:
    BIT 2,A
    JR NZ,L37
    LD A,'M'
    LD (Caracter),A
    RET
L37:
    BIT 3,A
    JR NZ,L38
    LD A,'N'
    LD (Caracter),A
    RET
L38:
    BIT 4,A
    JP NZ,Lee_Tecla
    LD A,'B'
    LD (Caracter),A
    RET
Init_Cursor:                    ; Inicializar las variables
    LD HL,XY_INICIO             ; Cargar las coordenadas iniciales
    LD (Coordenada),HL          ; Guardarlo en memoria
    LD BC,HL                    ; Copiar las coordenadas en B,C
    LD HL,VRAM                  ; Cargar la dirección de comienzo de los atributos
    LD DE,32                    ; Número de columnas
B1:                             ; Rutina para avanzar la dirección de los atributos tantas líneas como diga B
    ADD HL,DE           
    DJNZ B1
    LD A,C                      ; Mirar si es la primera columna (C=0)
    OR 0
    JR Z,B3                     ; Si es a primera columna ir a B3
    LD B,C                      ; Cargar en B para el bucle el número de columnas a saltar (C)
B2:                             ; Bucle de incrementar la dirección de atributos tantos como columnas
    INC HL
    DJNZ B2
B3:
    LD (Dir_Attr),HL            ; Guardar la dirección en memoria
    RET
Prt_Cursor:                     ; Rutina de impresión del cursor
    LD HL,(Dir_Attr)            ; Cargar la dirección del siguiente atributo
    LD A,$81                    ; Color del cursor INK=azul, PAPER=Blank, FLASH
    LD (HL),A                   ; Cargar el atributo
    INC HL                      ; Pasar al siguiente atributo
    LD (Dir_Attr),HL            ; Guardar la dirección del atributo en memoria
    RET
Mensaje:    db "Tipografo",0    ; Título
Coordenada: db 0,0              ; Coordenadas de comienzo de escritura
Dir_Attr:   db 0,0              ; Dirección del siguiente atributo
Caracter:   db 0,0              ; Mensaje del carácter para imprimir

    INCLUDE printat.asm         ; Incluir el código de PRINTAT 