; SlotPointer para el array Posiciones1
; Similar a SlotPointer pero calcula la direccion en Posiciones1 en vez de atributos de pantalla
; Entrada: H = fila (0-5), L = columna (0-6)
; Salida: IX = direccion en Posiciones1
; Modifica: A, DE, IX
SlotPointer_Array:
    ld a, h              ; A = fila
    ld b, a              ; B = fila (guardar)
    
    ; fila * 9 = fila*8 + fila
    sla a                ; A = fila*2
    sla a                ; A = fila*4
    sla a                ; A = fila*8
    add a, b             ; A = fila*9
    add a, l             ; A = fila*9 + columna
    inc a                ; +1 por borde $FF izquierdo
    
    ld e, a
    ld d, 0
    ld ix, Posiciones1
    add ix, de           ; IX = Posiciones1 + offset
    ret
