section .data
    A db 2, 4, 6, 8, 10, 12, 14, 16, 18, 20     ; input array A
    C db 4, 6, 8, 10, 12, 14, 16, 18, 20, 22    ; input array C
section .bss
    B resb 10                   ; output array B (10 bytes)
section .text
    global _main
_main:
    ; get the address of each array
    lea r8,  [rel A]            ; r8  = address of A
    lea r9,  [rel C]            ; r9  = address of C
    lea r10, [rel B]            ; r10 = address of B
    xor esi, esi                ; i = 0
loop_start:
    cmp esi, 10                 ; is i < 10?
    jae loop_end                ; no, so stop
    ; A[i] * 3 + 1
    movzx eax, byte [r8 + rsi]  ; eax = A[i]
    mov ebx, 3
    mul ebx                     ; eax = A[i] * 3
    add eax, 1                  ; eax = A[i] * 3 + 1
    mov edi, eax                ; total = eax
    ; C[i] * 2 + 1
    movzx eax, byte [r9 + rsi]  ; eax = C[i]
    mov ebx, 2
    mul ebx                     ; eax = C[i] * 2
    add eax, 1                  ; eax = C[i] * 2 + 1
    add edi, eax                ; total = total + eax
    ; (A[i] + C[i]) / 2
    movzx eax, byte [r8 + rsi]  ; eax = A[i]
    movzx ecx, byte [r9 + rsi]  ; ecx = C[i]
    add eax, ecx                ; eax = A[i] + C[i]
    xor edx, edx                ; clear edx before div
    mov ebx, 2
    div ebx                     ; eax = eax / 2
    add edi, eax                ; total = total + eax
    ; save the result
    mov [r10 + rsi], dil        ; B[i] = total
    inc esi                     ; i++
    jmp loop_start              ; repeat
loop_end:
    ; exit the program (macOS)
    mov eax, 0x2000001          ; exit syscall
    xor edi, edi                ; exit code 0
    syscall
