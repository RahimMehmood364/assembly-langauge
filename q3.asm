; COMP1001 Q3 - Convert C code to assembly (x86-64 NASM, macOS)
; for (i = 0; i < 10; i++)
;     B[i] = (A[i]*3 + 1) + (C[i]*2 + 1) + (A[i] + C[i]) / 2;

section .data
    ; our two input lists, one byte per number (every value fits in 8 bits)
    A db 2, 4, 6, 8, 10, 12, 14, 16, 18, 20
    C db 4, 6, 8, 10, 12, 14, 16, 18, 20, 22

section .bss
    B resb 10                   ; empty output list: room for 10 bytes (largest answer is 127)

section .text
    global _main

_main:
    ; macOS needs RIP-relative addressing, which can't be combined with an
    ; index register, so we first put each list's address into a register
    lea r8,  [rel A]            ; r8  -> start of A
    lea r9,  [rel C]            ; r9  -> start of C
    lea r10, [rel B]            ; r10 -> start of B

    xor esi, esi                ; i = 0 (esi is our loop counter)

