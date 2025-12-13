SlotPointer: ;h fila, l columna y te devuelve coordenada de atributos
    ld a,h 
    sla a
    sla a
    sla a
    sla a
    sla a
    or L
    ld l,a 
    ld a,h 
    sra a 
    sra a
    sra a 
    or $58 
    ld h,a 
    ret  
