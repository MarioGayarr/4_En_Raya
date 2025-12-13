IMPORT_DRAW: 
    PUSH HL
    PUSH DE
    PUSH BC
    LD HL, portada
    LD DE, $4000
    LD BC, 6912
    LDIR
    POP BC
    POP DE
    POP HL
    RET