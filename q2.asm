section .data
    ; our list of four 32-bit numbers
    numbers dd 8, 16, 24, 32

section .text
    global _main

_main:
    ; grab the 2nd number from the list (16)
    ; each number is 4 bytes, so "+ 4" skips the first one
    mov eax, [rel numbers + 4]

    ; multiply it by 4 -> eax = 64
    mov ebx, 4
    mul ebx

    ; now divide by 8 -> eax = 8
    mov ebx, 8
    div ebx

    ; put the answer back where the 16 used to be
    mov [rel numbers + 4], eax

    ; tell the OS we're done (exit code 0)
    mov eax, 0x2000001      ; macOS "exit" syscall number
    xor edi, edi            ; exit code = 0
    syscall
