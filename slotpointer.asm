;SlotPointer: Convierte fila/columna a dirección de atributos hl> $5800, código proporcionado en clase.
SlotPointer:
        PUSH    BC
        
        LD      A, H                    ; A = fila
        SLA     A                       ; A = fila * 2
        SLA     A                       ; A = fila * 4
        SLA     A                       ; A = fila * 8
        SLA     A                       ; A = fila * 16
        SLA     A                       ; A = fila * 32 (parte de offset)
        OR      L                       ; Combinar con columna
        LD      L, A                    ; L = byte bajo de direccion
        
        LD      A, H                    ; A = fila
        SRA     A                       ; A = fila / 2
        SRA     A                       ; A = fila / 4
        SRA     A                       ; A = fila / 8
        OR      $58                     ; Base de atributos $5800
        LD      H, A                    ; H = byte alto de direccion
        
        POP     BC
        RET