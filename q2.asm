section .data
    ; our list of four 32-bit unsigned numbers
    numbers dd 8, 16, 24, 32

section .text
    global _main

_main:
    ; load the 2nd number (16); each element is 4 bytes, so the offset is +4
    mov eax, [rel numbers + 4]

    ; multiply it by 4 -> eax = 64
    mov ebx, 4
    mul ebx

    ; clear edx, because div works on edx:eax together
    ; (mul can write to edx, so we don't rely on it being 0)
    xor edx, edx

    ; divide by 8 -> eax = 8
    mov ebx, 8
    div ebx

    ; put the answer back into the 2nd element
    mov [rel numbers + 4], eax

    ; exit with code 0 (macOS)
    mov eax, 0x2000001
    xor edi, edi
    syscall
