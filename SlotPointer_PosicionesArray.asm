;SlotPointer_Array: Convierte fila/columna a posición en Posiciones1
;éste no sirve para pintar en pantalla, en Seguir1 también se hace un cáculo de la posición en tablero pero usando
;el cambio a hl
SlotPointer_Array:
        PUSH    BC
        
        LD      A, H                    ; A = fila
        LD      B, A                    ; B = fila (guardar)
        
        SLA     A                       ; A = fila * 2
        SLA     A                       ; A = fila * 4
        SLA     A                       ; A = fila * 8
        ADD     A, B                    ; A = fila * 9
        ADD     A, L                    ; A = fila * 9 + columna
        INC     A                       ; +1 por borde $FF izquierdo
        
        LD      E, A
        LD      D, 0
        LD      IX, Posiciones1
        ADD     IX, DE                  ; IX = Posiciones1 + offset
        
        POP     BC
        RET