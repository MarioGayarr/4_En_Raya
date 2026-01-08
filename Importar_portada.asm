;IMPORT_DRAW: Copia la portada a la memoria de pantalla
IMPORT_DRAW: 
        PUSH    HL
        PUSH    DE
        PUSH    BC
        
        LD      HL, portada             ; Origen: datos de imagen
        LD      DE, $4000               ; Destino: memoria de video
        LD      BC, 6912                ; Tamaño: pantalla completa
        LDIR                            ; Copiar bloque completo
        
        POP     BC
        POP     DE
        POP     HL
        RET