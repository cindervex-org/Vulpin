; Linux x86-64
bits 64
extern __ctype_b_loc
extern __errno_location
extern calloc
extern chmod
extern close
extern closedir
extern fclose
extern fdopen
extern ferror
extern fflush
extern fgets
extern fopen
extern fprintf
extern fputc
extern fputs
extern fread
extern free
extern fseek
extern ftell
extern fwrite
extern getenv
extern getline
extern memcpy
extern memmove
extern mkstemp
extern nanosleep
extern opendir
extern perror
extern printf
extern puts
extern qsort
extern realloc
extern readdir
extern readlink
extern realpath
extern snprintf
extern stat
extern stderr
extern stdin
extern stdout
extern strchr
extern strcmp
extern strerror
extern strlen
extern strncmp
extern strrchr
extern strtoll
extern strtoull
extern system
extern unlink

section .text
align 16
    cmp_names:
LFB39:
    jmp strcmp
LFE39:
section .rodata
LC0:
    db 0x3c, 0x69, 0x6e, 0x70, 0x75, 0x74, 0x3e, 0x00
LC1:
    db 0x25, 0x73, 0x00
section .text
align 16
    add_statement:
LFB22:
    cmp byte [rdi], 0
    je  L3
    mov rcx, rdi
    mov rdi, qword [rel statement_count]
    cmp rdi, 8191
    jbe L10
L3:
    ret
align 16
align 8
L10:
    push    rbp
    lea rax, [rdi+1]
    sal rdi, 11
    mov edx, LC1
    push    rbx
    mov rbp, rdi
    mov rbx, rsi
    lea rdi, [statements + rdi]
    mov esi, 1024
    sub rsp, 8
    mov qword [rel statement_count], rax
    xor eax, eax
    call    snprintf
    test    rbx, rbx
    mov eax, LC0
    lea rdi, [statements + rbp + 1024]
    cmove   rbx, rax
    add rsp, 8
    mov edx, LC1
    xor eax, eax
    mov esi, 1024
    mov rcx, rbx
    pop rbx
    pop rbp
    jmp snprintf
LFE22:
align 16
    number_value:
LFB14:
    sub rsp, 928
    mov r8, rsi
    mov rdx, rdi
    xor eax, eax
    lea rsi, [rsp-120]
    mov ecx, 130
    mov rdi, rsi
    rep stosq
    mov qword [rsp-112], r8
    mov ecx, 130
    mov rdi, rdx
    mov rax, rdx
    rep movsq
    add rsp, 928
    ret
LFE14:
align 16
    same_existing_path:
LFB75:
    push    r13
    push    r12
    push    rbp
    mov rbp, rsi
    push    rbx
    mov rbx, rdi
    sub rsp, 2056
    mov rsi, rsp
    call    realpath
    test    rax, rax
    je  L14
    lea r13, [rsp+1024]
    mov rdi, rbp
    mov rsi, r13
    call    realpath
    test    rax, rax
    je  L14
    mov rsi, r13
    mov rdi, rsp
    call    strcmp
    test    eax, eax
    sete    al
    add rsp, 2056
    pop rbx
    pop rbp
    pop r12
    pop r13
    ret
align 16
align 8
L14:
    mov rsi, rbp
    mov rdi, rbx
    call    strcmp
    test    eax, eax
    sete    al
    add rsp, 2056
    pop rbx
    pop rbp
    pop r12
    pop r13
    ret
LFE75:
align 16
    loaded_file:
LFB20:
    push    r12
    push    rbp
    mov rbp, rdi
    push    rbx
    sub rsp, 1024
    mov rsi, rsp
    call    realpath
    mov r12, qword [rel loaded_path_count]
    test    rax, rax
    cmovne  rbp, rsp
    test    r12, r12
    je  L27
    xor ebx, ebx
    jmp L26
align 16
align 8
L33:
    add rbx, 1
    cmp rbx, r12
    je  L27
L26:
    mov rdi, rbx
    mov rsi, rbp
    sal rdi, 10
    add rdi, loaded_paths
    call    strcmp
    test    eax, eax
    jne L33
    add rsp, 1024
    mov eax, 1
    pop rbx
    pop rbp
    pop r12
    ret
align 16
align 8
L27:
    add rsp, 1024
    xor eax, eax
    pop rbx
    pop rbp
    pop r12
    ret
LFE20:
align 16
    remember_file:
LFB21:
    push    r12
    push    rbp
    push    rbx
    sub rsp, 1024
    mov rbp, qword [rel loaded_path_count]
    cmp rbp, 511
    ja  L34
    mov rsi, rsp
    mov rbx, rdi
    call    realpath
    mov edx, LC1
    mov esi, 1024
    test    rax, rax
    lea rax, [rbp+1]
    cmovne  rbx, rsp
    sal rbp, 10
    mov qword [rel loaded_path_count], rax
    xor eax, eax
    lea rdi, [loaded_paths + rbp]
    mov rcx, rbx
    call    snprintf
L34:
    add rsp, 1024
    pop rbx
    pop rbp
    pop r12
    ret
LFE21:
align 16
    copy_stream:
LFB76:
    push    r15
    mov r15, rdx
    push    r14
    mov r14, rsi
    push    r13
    mov r13, rdi
    push    r12
    xor r12d, r12d
    push    rbp
    push    rbx
    sub rsp, 65544
    mov rbp, rsp
    jmp L41
align 16
align 8
L44:
    mov rcx, r14
    mov rdx, rbx
    mov esi, 1
    mov rdi, rbp
    call    fwrite
    cmp rax, rbx
    jne L45
    add r12, rax
L41:
    mov rcx, r13
    mov edx, 65536
    mov esi, 1
    mov rdi, rbp
    call    fread
    mov rbx, rax
    test    rax, rax
    jne L44
    mov rdi, r13
    call    ferror
    test    eax, eax
    jne L45
    test    r15, r15
    je  L40
    mov qword [r15], r12
L40:
    add rsp, 65544
    pop rbx
    pop rbp
    pop r12
    pop r13
    pop r14
    pop r15
    ret
align 16
align 8
L45:
    mov eax, -1
    jmp L40
LFE76:
align 16
    trim:
LFB17:
    push    rbp
    push    rbx
    mov rbx, rdi
    sub rsp, 8
    movzx   ebp, byte [rdi]
    test    bpl, bpl
    je  L50
    call    __ctype_b_loc
    mov rax, qword [rax]
    jmp L51
align 32
align 16
align 8
L52:
    movzx   ebp, byte [rbx+1]
    add rbx, 1
    test    bpl, bpl
    je  L50
L51:
    test    byte [rax+1+rbp*2], 32
    jne L52
L50:
    mov rdi, rbx
    call    strlen
    mov rbp, rax
    test    rax, rax
    je  L49
    call    __ctype_b_loc
    jmp L54
align 32
align 16
align 8
L56:
    mov byte [rbx+rbp], 0
    test    rbp, rbp
    je  L49
L54:
    sub rbp, 1
    mov rdx, qword [rax]
    movzx   ecx, byte [rbx+rbp]
    test    byte [rdx+1+rcx*2], 32
    jne L56
L49:
    add rsp, 8
    mov rax, rbx
    pop rbx
    pop rbp
    ret
LFE17:
align 16
    find_loop_end:
LFB57:
    push    r12
    push    rbp
    mov rbp, rsi
    push    rbx
    lea rbx, [rdi+1]
    cmp rbx, rsi
    jnb L66
    xor r12d, r12d
    jmp L72
align 16
align 8
L67:
    cmp byte [rax], 38
    jne L69
    cmp byte [rax+1], 0
    jne L69
    test    r12d, r12d
    je  L65
    sub r12d, 1
L69:
    add rbx, 1
    cmp rbx, rbp
    jnb L66
L72:
    mov rdi, rbx
    sal rdi, 11
    add rdi, statements
    call    trim
    movzx   edx, byte [rax]
    cmp dl, 64
    je  L73
    cmp dl, 79
    jne L67
L73:
    add rbx, 1
    add r12d, 1
    cmp rbx, rbp
    jb  L72
L66:
    mov rbx, rbp
L65:
    mov rax, rbx
    pop rbx
    pop rbp
    pop r12
    ret
LFE57:
align 16
    is_asm_mnemonic:
LFB70:
    push    r13
    push    r12
    mov r12, rdx
    push    rbp
    mov rbp, rsi
    push    rbx
    mov rbx, rdi
    mov rdi, rsi
    sub rsp, 8
    call    strlen
    mov rsi, rbp
    mov rdi, rbx
    xor ebp, ebp
    mov rdx, rax
    mov r13, rax
    call    strncmp
    test    eax, eax
    jne L79
    call    __ctype_b_loc
    add rbx, r13
    movzx   r13d, byte [rbx]
    mov rdx, qword [rax]
    movzx   eax, r13b
    movzx   eax, word [rdx+rax*2]
    test    r13b, r13b
    jne L91
    test    ah, 32
    je  L83
align 16
align 16
align 8
L82:
    movzx   eax, byte [rbx+1]
    add rbx, 1
    test    byte [rdx+1+rax*2], 32
    jne L82
L83:
    mov qword [r12], rbx
    mov ebp, 1
L79:
    add rsp, 8
    mov eax, ebp
    pop rbx
    pop rbp
    pop r12
    pop r13
    ret
align 16
align 8
L91:
    test    ah, 32
    jne L82
    add rsp, 8
    mov eax, ebp
    pop rbx
    pop rbp
    pop r12
    pop r13
    ret
LFE70:
section .rodata
LC2:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x75, 0x6e, 0x74, 0x65, 0x72, 0x6d, 0x69, 0x6e, 0x61, 0x74, 0x65, 0x64, 0x20, 0x73, 0x74, 0x72, 0x69, 0x6e, 0x67, 0x0a, 0x00
section .text
align 16
    parse_quoted:
LFB27:
    push    r14
    mov r14, rdx
    push    r13
    mov r13, rdi
    push    r12
    mov r12, rsi
    push    rbp
    push    rbx
    mov rbx, qword [rdi]
    call    __ctype_b_loc
    mov rcx, qword [rax]
    movzx   eax, byte [rbx]
    test    byte [rcx+1+rax*2], 32
    je  L124
align 32
align 16
align 8
L94:
    movzx   eax, byte [rbx+1]
    add rbx, 1
    mov rdx, rax
    test    byte [rcx+1+rax*2], 32
    jne L94
L93:
    cmp dl, 39
    je  L112
    xor eax, eax
    cmp dl, 34
    je  L112
    pop rbx
    pop rbp
    pop r12
    pop r13
    pop r14
    ret
align 16
align 8
L112:
    movzx   eax, byte [rbx+1]
    lea rbp, [rbx+1]
    xor esi, esi
    test    al, al
    jne L97
    jmp L98
align 16
align 8
L108:
    mov rbp, rcx
L99:
    lea rcx, [rsi+1]
    cmp rcx, r14
    jnb L100
    mov byte [r12+rsi], al
    mov rsi, rcx
L100:
    movzx   eax, byte [rbp+0]
    test    al, al
    je  L101
L97:
    cmp al, dl
    je  L126
    lea rcx, [rbp+1]
    cmp al, 92
    jne L108
    movzx   edi, byte [rbp+1]
    test    dil, dil
    je  L108
    add rbp, 2
    mov eax, 13
    cmp dil, 114
    je  L99
    mov eax, 9
    cmp dil, 116
    je  L99
    cmp dil, 110
    mov eax, 10
    cmovne  eax, edi
    jmp L99
align 16
align 8
L126:
    add r12, rsi
    add rbp, 1
L104:
    mov byte [r12], 0
    mov eax, 1
    mov qword [r13+0], rbp
    pop rbx
    pop rbp
    pop r12
    pop r13
    pop r14
    ret
align 16
align 8
L101:
    add r12, rsi
L98:
    mov edx, 28
    mov esi, 1
    mov edi, LC2
    mov rcx, qword [rel stderr]
    call    fwrite
    mov byte [rel runtime_error], 1
    jmp L104
align 16
align 8
L124:
    mov rdx, rax
    jmp L93
LFE27:
align 16
    parser_space:
LFB50:
    push    rbx
    mov rbx, rdi
    call    __ctype_b_loc
    mov rcx, qword [rax]
    mov rax, qword [rbx]
    movzx   edx, byte [rax]
    test    byte [rcx+1+rdx*2], 32
    je  L127
    add rax, 1
align 32
align 16
align 8
L129:
    mov rdx, rax
    mov qword [rbx], rax
    add rax, 1
    movzx   edx, byte [rdx]
    test    byte [rcx+1+rdx*2], 32
    jne L129
L127:
    pop rbx
    ret
LFE50:
align 16
    get_variable.part.0:
LFB82:
    push    rbx
    test    sil, sil
    je  L137
    mov rax, qword [rel variable_count]
    xor ebx, ebx
    cmp rax, 511
    ja  L135
    lea rbx, [rax+rax*8]
    lea rcx, [rax+1]
    mov rdx, rdi
    xor eax, eax
    sal rbx, 7
    mov qword [rel variable_count], rcx
    mov ecx, 144
    mov esi, 96
    add rbx, variables
    mov rdi, rbx
    rep stosq
    mov rcx, rdx
    mov rdi, rbx
    mov edx, LC1
    mov byte [rbx+1136], 1
    call    snprintf
    lea rdi, [rbx+96]
    xor esi, esi
    call    number_value
L135:
    mov rax, rbx
    pop rbx
    ret
align 16
align 8
L137:
    xor ebx, ebx
    mov rax, rbx
    pop rbx
    ret
LFE82:
section .rodata
LC3:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x74, 0x6f, 0x6f, 0x20, 0x6d, 0x61, 0x6e, 0x79, 0x20, 0x76, 0x61, 0x72, 0x69, 0x61, 0x62, 0x6c, 0x65, 0x73, 0x0a, 0x00
section .text
align 16
    set_value.part.0:
LFB84:
    sub rsp, 8
    mov edx, 27
    mov esi, 1
    mov rcx, qword [rel stderr]
    mov edi, LC3
    call    fwrite
    mov byte [rel runtime_error], 1
    add rsp, 8
    ret
LFE84:
section .rodata
LC4:
    db 0x72, 0x62, 0x00
LC5:
    db 0x56, 0x55, 0x4c, 0x50, 0x49, 0x4e, 0x2d, 0x42, 0x55, 0x4e, 0x44, 0x4c, 0x45, 0x2d, 0x31, 0x00
LC6:
    db 0x77, 0x62, 0x00
section .text
align 16
    load_embedded_source.constprop.0:
LFB93:
    push    r15
    push    r14
    push    r13
    push    r12
    mov r12, rsi
    mov esi, LC4
    push    rbp
    push    rbx
    sub rsp, 65576
    call    fopen
    test    rax, rax
    je  L143
    mov rdi, rax
    mov edx, 2
    xor esi, esi
    mov rbx, rax
    call    fseek
    mov rdi, rbx
    test    eax, eax
    jne L176
    call    ftell
    mov rbp, rax
    cmp rax, 22
    jle L174
    lea r13, [rax-23]
    xor edx, edx
    mov rdi, rbx
    mov rsi, r13
    call    fseek
    test    eax, eax
    jne L174
    lea rdi, [rsp+8]
    mov rcx, rbx
    mov edx, 1
    mov esi, 8
    mov qword [rsp+8], 0
    call    fread
    cmp rax, 1
    jne L174
    lea rdi, [rsp+17]
    mov rcx, rbx
    mov edx, 15
    mov esi, 1
    call    fread
    cmp rax, 15
    jne L174
    mov  rax, 4768553657241982294
    cmp qword [rsp+17], rax
    je  L177
align 16
align 8
L174:
    mov rdi, rbx
    call    fclose
L143:
    xor eax, eax
L142:
    add rsp, 65576
    pop rbx
    pop rbp
    pop r12
    pop r13
    pop r14
    pop r15
    ret
align 16
align 8
L176:
    call    fclose
    jmp L143
align 16
align 8
L177:
    mov  rax, 3543564675676263746
    cmp qword [rsp+24], rax
    jne L174
    mov rax, qword [rsp+8]
    cmp r13, rax
    jb  L174
    sub rbp, rax
    xor edx, edx
    mov rdi, rbx
    lea r13, [rbp-23]
    mov rsi, r13
    call    fseek
    test    eax, eax
    jne L174
    movdqa  xmm0, oword [rel LC7]
    mov rdi, r12
    movups  oword [r12], xmm0
    movdqa  xmm0, oword [rel LC8]
    movups  oword [r12+12], xmm0
    call    mkstemp
    mov ebp, eax
    test    eax, eax
    js  L174
    mov esi, LC6
    mov edi, eax
    call    fdopen
    mov r15, rax
    test    rax, rax
    je  L178
    xor edx, edx
    mov rsi, r13
    mov rdi, rbx
    call    fseek
    test    eax, eax
    jne L179
    mov r13, qword [rsp+8]
    test    r13, r13
    je  L170
    lea r14, [rsp+32]
    jmp L158
align 16
align 8
L180:
    mov rcx, r15
    mov rdx, rbp
    mov esi, 1
    mov rdi, r14
    call    fwrite
    cmp rbp, rax
    jne L157
    sub r13, rbp
    je  L170
L158:
    mov ebp, 65536
    mov rcx, rbx
    mov esi, 1
    mov rdi, r14
    cmp r13, rbp
    cmovbe  rbp, r13
    mov rdx, rbp
    call    fread
    cmp rbp, rax
    je  L180
L157:
    mov rdi, r15
    call    fflush
L162:
    mov rdi, r15
    call    fclose
    mov rdi, rbx
    call    fclose
    mov rdi, r12
    call    unlink
    jmp L143
L170:
    mov rdi, r15
    call    fflush
    test    eax, eax
    jne L162
    mov rdi, r15
    call    fclose
    mov rdi, rbx
    call    fclose
    mov eax, 1
    jmp L142
L179:
    mov rdi, r15
    call    fclose
    mov rdi, r12
    call    unlink
    jmp L174
L178:
    mov edi, ebp
    call    close
    mov rdi, r12
    call    unlink
    mov rdi, rbx
    call    fclose
    jmp L143
LFE93:
section .rodata
LC9:
    db 0x2f, 0x70, 0x72, 0x6f, 0x63, 0x2f, 0x73, 0x65, 0x6c, 0x66, 0x2f, 0x65, 0x78, 0x65, 0x00
section .text
align 16
    running_executable_path.constprop.0:
LFB94:
    push    rbp
    mov edx, 1023
    mov rbp, rdi
    mov edi, LC9
    push    rbx
    mov rbx, rsi
    sub rsp, 8
    call    readlink
    lea rdx, [rax-1]
    cmp rdx, 1022
    jbe L190
    xor eax, eax
    test    rbp, rbp
    je  L181
    mov rsi, rbx
    mov rdi, rbp
    call    realpath
    mov rdx, rax
    mov rax, rbp
    test    rdx, rdx
    je  L181
    mov rax, rbx
L181:
    add rsp, 8
    pop rbx
    pop rbp
    ret
align 16
align 8
L190:
    mov byte [rbx+rax], 0
    mov rax, rbx
    jmp L181
LFE94:
section .rodata
LC10:
    db 0x2e, 0x76, 0x75, 0x6c, 0x00
section .text
align 16
    safe_suffix.part.0.constprop.0:
LFB95:
    push    rbp
    mov rbp, rsi
    push    rbx
    mov rbx, rdi
    mov rdi, rsi
    sub rsp, 8
    call    strlen
    mov edx, 1023
    cmp rax, rdx
    cmova   rax, rdx
    cmp eax, 8
    jnb L192
    test    al, 4
    jne L203
    test    eax, eax
    je  L193
    movzx   edx, byte [rbp+0]
    mov byte [rbx], dl
    test    al, 2
    je  L193
    mov edx, eax
    movzx   ecx, word [rbp-2+rdx]
    mov word [rbx-2+rdx], cx
    jmp L193
align 16
align 8
L192:
    mov rdx, qword [rbp+0]
    lea rdi, [rbx+8]
    mov rsi, rbp
    and rdi, -8
    mov qword [rbx], rdx
    mov edx, eax
    mov rcx, qword [rbp-8+rdx]
    mov qword [rbx-8+rdx], rcx
    mov rcx, rbx
    sub rcx, rdi
    sub rsi, rcx
    add ecx, eax
    shr ecx, 3
    rep movsq
L193:
    mov edx, 1023
    mov ecx, 4
    sub rdx, rax
    cmp rdx, rcx
    cmova   rdx, rcx
    add rbx, rax
    mov esi, edx
    test    edx, edx
    je  L197
    xor eax, eax
L196:
    mov ecx, eax
    add eax, 1
    movzx   edi, byte [LC10 + rcx]
    mov byte [rbx+rcx], dil
    cmp eax, esi
    jb  L196
L197:
    mov byte [rbx+rdx], 0
    add rsp, 8
    pop rbx
    pop rbp
    ret
align 16
align 8
L203:
    mov edx, dword [rbp+0]
    mov dword [rbx], edx
    mov edx, eax
    mov ecx, dword [rbp-4+rdx]
    mov dword [rbx-4+rdx], ecx
    jmp L193
LFE95:
align 16
    safe_join.part.0.constprop.0:
LFB96:
    push    r13
    mov r13, rsi
    push    r12
    push    rbp
    mov rbp, rdx
    push    rbx
    mov rbx, rdi
    mov rdi, rsi
    sub rsp, 8
    call    strlen
    mov rdi, rbp
    mov r12, rax
    call    strlen
    mov edx, 1023
    cmp r12, rdx
    cmovbe  rdx, r12
    cmp edx, 8
    jnb L205
    test    dl, 4
    jne L224
    test    edx, edx
    je  L206
    movzx   ecx, byte [r13+0]
    mov byte [rbx], cl
    test    dl, 2
    je  L206
    mov ecx, edx
    movzx   esi, word [r13-2+rcx]
    mov word [rbx-2+rcx], si
    jmp L206
align 16
align 8
L205:
    mov rcx, qword [r13+0]
    lea rdi, [rbx+8]
    and rdi, -8
    mov qword [rbx], rcx
    mov ecx, edx
    mov rsi, qword [r13-8+rcx]
    mov qword [rbx-8+rcx], rsi
    mov rcx, rbx
    mov rsi, r13
    sub rcx, rdi
    sub rsi, rcx
    add ecx, edx
    shr ecx, 3
    rep movsq
L206:
    test    r12, r12
    jne L209
    mov edx, 1023
    cmp rax, rdx
    cmova   rax, rdx
    lea r8, [rbx+rax]
L210:
    mov ecx, eax
    cmp eax, 8
    jnb L213
L228:
    test    al, 4
    jne L225
    test    eax, eax
    je  L214
    movzx   edx, byte [rbp+0]
    mov byte [rbx], dl
    test    al, 2
    je  L214
    mov eax, eax
    movzx   edx, word [rbp-2+rax]
    mov word [rbx-2+rax], dx
    jmp L214
align 16
align 8
L209:
    cmp byte [rbx-1+rdx], 47
    je  L226
    cmp r12, 1022
    ja  L227
    lea rcx, [rdx+1]
    mov byte [rbx+rdx], 47
    mov edx, 1023
    sub rdx, rcx
    cmp rdx, rax
    cmovbe  rax, rdx
    lea r8, [rcx+rax]
    add r8, rbx
    add rbx, rcx
    mov ecx, eax
    cmp eax, 8
    jb  L228
align 16
align 8
L213:
    mov rdx, qword [rbp+0]
    lea rdi, [rbx+8]
    mov rsi, rbp
    and rdi, -8
    mov qword [rbx], rdx
    mov edx, eax
    mov rcx, qword [rbp-8+rdx]
    mov qword [rbx-8+rdx], rcx
    sub rbx, rdi
    lea ecx, [rax+rbx]
    sub rsi, rbx
    shr ecx, 3
    rep movsq
L214:
    mov byte [r8], 0
    add rsp, 8
    pop rbx
    pop rbp
    pop r12
    pop r13
    ret
align 16
align 8
L226:
    mov ecx, 1023
    sub rcx, rdx
    cmp rcx, rax
    cmovbe  rax, rcx
    lea r8, [rdx+rax]
    add r8, rbx
    add rbx, rdx
    jmp L210
align 16
align 8
L227:
    add rbx, 1023
    xor eax, eax
    mov r8, rbx
    jmp L210
align 16
align 8
L224:
    mov ecx, dword [r13+0]
    mov dword [rbx], ecx
    mov ecx, edx
    mov esi, dword [r13-4+rcx]
    mov dword [rbx-4+rcx], esi
    jmp L206
align 16
align 8
L225:
    mov eax, dword [rbp+0]
    mov dword [rbx], eax
    mov eax, dword [rbp-4+rcx]
    mov dword [rbx-4+rcx], eax
    jmp L214
LFE96:
align 16
    trim_mut.isra.0:
LFB97:
    push    rbp
    push    rbx
    mov rbx, rdi
    sub rsp, 8
    call    trim
    cmp rbx, rax
    je  L229
    mov rdi, rax
    mov rbp, rax
    call    strlen
    add rsp, 8
    mov rsi, rbp
    mov rdi, rbx
    lea rdx, [rax+1]
    pop rbx
    pop rbp
    jmp memmove
align 16
align 8
L229:
    add rsp, 8
    pop rbx
    pop rbp
    ret
LFE97:
align 16
    parse_identifier.constprop.0:
LFB99:
    push    r12
    mov r12, rdi
    push    rbp
    mov rbp, rsi
    push    rbx
    mov rbx, qword [rdi]
    call    __ctype_b_loc
    mov rcx, qword [rax]
    jmp L246
align 32
align 16
align 8
L247:
    add rbx, 1
L246:
    movzx   edx, byte [rbx]
    mov rsi, rdx
    movzx   edx, word [rcx+rdx*2]
    test    dh, 32
    jne L247
    cmp sil, 36
    je  L248
L235:
    xor edi, edi
align 16
align 8
L236:
    and edx, 8
    movzx   esi, byte [rbx]
    jne L237
    cmp sil, 95
    je  L237
    cmp sil, 46
    je  L237
    mov byte [rbp+0+rdi], 0
    mov qword [r12], rbx
    pop rbx
    pop rbp
    pop r12
    ret
align 16
align 8
L237:
    lea rdx, [rdi+1]
    cmp rdx, 95
    ja  L239
    mov byte [rbp+0+rdi], sil
    mov rcx, qword [rax]
    mov rdi, rdx
L239:
    movzx   edx, byte [rbx+1]
    add rbx, 1
    movzx   edx, word [rcx+rdx*2]
    jmp L236
align 16
align 8
L248:
    movzx   edx, byte [rbx+1]
    add rbx, 1
    movzx   edx, word [rcx+rdx*2]
    jmp L235
LFE99:
align 16
    find_label:
LFB60:
    push    r13
    push    r12
    push    rbp
    push    rbx
    mov rbx, rsi
    sub rsp, 120
    test    rsi, rsi
    je  L250
    mov r12, rdi
    xor r13d, r13d
    lea rbp, [rsp+16]
    jmp L252
align 16
align 8
L253:
    add r13, 1
    cmp rbx, r13
    je  L250
L252:
    mov rdi, r13
    sal rdi, 11
    add rdi, statements
    call    trim
    cmp byte [rax], 76
    jne L253
    add rax, 1
    lea rdi, [rsp+8]
    mov rsi, rbp
    mov qword [rsp+8], rax
    call    parse_identifier.constprop.0
    mov rsi, r12
    mov rdi, rbp
    call    strcmp
    test    eax, eax
    jne L253
    mov rbx, r13
L250:
    add rsp, 120
    mov rax, rbx
    pop rbx
    pop rbp
    pop r12
    pop r13
    ret
LFE60:
align 16
    candidate.constprop.0:
LFB100:
    push    rbp
    mov rbp, rdi
    push    rbx
    mov rbx, rsi
    mov rdi, rbx
    sub rsp, 152
    mov rsi, rsp
    call    stat
    test    eax, eax
    jne L260
    mov eax, dword [rsp+24]
    and eax, 61440
    cmp eax, 32768
    je  L270
L260:
    add rsp, 152
    xor eax, eax
    pop rbx
    pop rbp
    ret
align 16
align 8
L270:
    mov rdi, rbx
    call    strlen
    mov edx, 1023
    cmp rax, rdx
    cmova   rax, rdx
    cmp eax, 8
    jnb L261
    test    al, 4
    jne L271
    test    eax, eax
    je  L262
    movzx   edx, byte [rbx]
    mov byte [rbp+0], dl
    test    al, 2
    jne L272
L262:
    mov byte [rbp+0+rax], 0
    add rsp, 152
    mov eax, 1
    pop rbx
    pop rbp
    ret
align 16
align 8
L261:
    mov rdx, qword [rbx]
    lea rdi, [rbp+8]
    and rdi, -8
    mov qword [rbp+0], rdx
    mov edx, eax
    mov rcx, qword [rbx-8+rdx]
    mov qword [rbp-8+rdx], rcx
    mov rcx, rbp
    sub rcx, rdi
    sub rbx, rcx
    add ecx, eax
    mov rsi, rbx
    shr ecx, 3
    rep movsq
    jmp L262
align 16
align 8
L271:
    mov edx, dword [rbx]
    mov dword [rbp+0], edx
    mov edx, eax
    mov ecx, dword [rbx-4+rdx]
    mov dword [rbp-4+rdx], ecx
    jmp L262
L272:
    mov edx, eax
    movzx   ecx, word [rbx-2+rdx]
    mov word [rbp-2+rdx], cx
    jmp L262
LFE100:
section .rodata
align 8
LC11:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x66, 0x75, 0x6e, 0x63, 0x74, 0x69, 0x6f, 0x6e, 0x20, 0x25, 0x73, 0x20, 0x68, 0x61, 0x73, 0x20, 0x74, 0x6f, 0x6f, 0x20, 0x6d, 0x61, 0x6e, 0x79, 0x20, 0x70, 0x61, 0x72, 0x61, 0x6d, 0x65, 0x74, 0x65, 0x72, 0x73, 0x20, 0x28, 0x6d, 0x61, 0x78, 0x20, 0x25, 0x64, 0x29, 0x0a, 0x00
align 8
LC12:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x66, 0x75, 0x6e, 0x63, 0x74, 0x69, 0x6f, 0x6e, 0x20, 0x25, 0x73, 0x20, 0x61, 0x74, 0x20, 0x25, 0x73, 0x3a, 0x25, 0x7a, 0x75, 0x20, 0x68, 0x61, 0x73, 0x20, 0x6e, 0x6f, 0x20, 0x6d, 0x61, 0x74, 0x63, 0x68, 0x69, 0x6e, 0x67, 0x20, 0x27, 0x7e, 0x27, 0x0a, 0x00
section .rodata
LC13:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x66, 0x75, 0x6e, 0x63, 0x74, 0x69, 0x6f, 0x6e, 0x20, 0x74, 0x61, 0x62, 0x6c, 0x65, 0x20, 0x66, 0x75, 0x6c, 0x6c, 0x0a, 0x00
section .text
align 16
    register_functions:
LFB37:
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbp
    push    rbx
    mov rbx, rdi
    sal rbx, 11
    add rbx, statements+1024
    sub rsp, 3144
    cmp rdi, rsi
    jnb L273
    mov qword [rsp+24], rdx
    mov r15, rdi
    mov rbp, rsi
align 16
align 8
L318:
    lea rdi, [rbx-1024]
    call    trim
    lea r8, [r15+1]
    cmp byte [rax], 70
    mov r12, rax
    jne L275
    movzx   r14d, byte [rax+1]
    test    r14b, r14b
    je  L275
    lea rax, [rax+1]
    mov qword [rsp+8], r8
    mov qword [rsp+56], rax
    call    __ctype_b_loc
    mov r8, qword [rsp+8]
    mov r9, qword [rax]
    mov r13, rax
    test    byte [r9+1+r14*2], 32
    je  L276
    lea rax, [r12+2]
align 32
align 16
align 8
L277:
    mov rdx, rax
    add rax, 1
    movzx   ecx, byte [rdx]
    test    byte [r9+1+rcx*2], 32
    jne L277
    mov qword [rsp+56], rdx
L276:
    lea r14, [rsp+56]
    lea rsi, [rsp+64]
    mov qword [rsp+8], r8
    mov rdi, r14
    mov qword [rsp+16], r9
    call    parse_identifier.constprop.0
    cmp byte [rsp+64], 0
    mov r8, qword [rsp+8]
    je  L275
    mov r10, qword [rsp+56]
    mov r9, qword [rsp+16]
    movzx   eax, byte [r10]
    mov rdx, rax
    test    byte [r9+1+rax*2], 32
    je  L279
    lea rax, [r10+1]
align 32
align 16
align 8
L280:
    movzx   ecx, byte [rax]
    mov r10, rax
    add rax, 1
    mov rdx, rcx
    test    byte [r9+1+rcx*2], 32
    jne L280
L279:
    cmp dl, 40
    je  L363
align 16
align 8
L275:
    add rbx, 2048
    cmp r8, rbp
    jnb L273
L319:
    mov r15, r8
    jmp L318
align 16
align 8
L273:
    add rsp, 3144
    pop rbx
    pop rbp
    pop r12
    pop r13
    pop r14
    pop r15
    ret
align 16
align 8
L363:
    lea rax, [r10+1]
    mov ecx, 359
    mov edx, LC1
    mov esi, 96
    lea r12, [rsp+256]
    mov qword [rsp+32], rax
    mov qword [rsp+56], rax
    mov rdi, r12
    xor eax, eax
    rep stosq
    lea rcx, [rsp+64]
    mov qword [rsp+16], r8
    lea rdi, [rsp+352]
    mov qword [rsp+8], r10
    call    snprintf
    mov rcx, qword [rsp+24]
    xor eax, eax
    lea rdi, [rsp+448]
    mov edx, LC1
    mov esi, 96
    call    snprintf
    mov rax, qword [rsp+24]
    mov r10, qword [rsp+8]
    mov r8, qword [rsp+16]
    cmp byte [rax], 0
    jne L364
L281:
    lea rcx, [rsp+64]
    mov edx, LC1
    mov rdi, r12
    xor eax, eax
    mov esi, 96
    mov qword [rsp+16], r8
    mov qword [rsp+8], r10
    call    snprintf
    mov r8, qword [rsp+16]
    mov r10, qword [rsp+8]
L290:
    mov qword [rsp+2088], r15
    movzx   edx, byte [r10+1]
    test    dl, dl
    je  L295
    mov rax, qword [rsp+32]
    mov rcx, qword [r13+0]
    mov qword [rsp+16], rbp
    lea r15, [rsp+160]
    mov qword [rsp+8], rbx
    mov rbx, r13
    mov r13, r8
L302:
    movzx   esi, dl
    add rax, 1
    test    byte [rcx+1+rsi*2], 32
    je  L305
align 32
align 16
align 8
L293:
    movzx   esi, byte [rax]
    mov rdi, rax
    add rax, 1
    mov rdx, rsi
    test    byte [rcx+1+rsi*2], 32
    jne L293
    mov qword [rsp+56], rdi
L305:
    cmp dl, 41
    je  L358
    mov ebp, dword [rsp+2080]
    cmp ebp, 15
    jg  L365
    mov rsi, r15
    mov rdi, r14
    call    parse_identifier.constprop.0
    cmp byte [rsp+160], 0
    je  L359
    movsx   rax, ebp
    lea edx, [rbp+1]
    mov rcx, r15
    mov esi, 96
    lea rax, [rax+rax*2]
    mov dword [rsp+2080], edx
    mov edx, LC1
    sal rax, 5
    lea rdi, [r12+288+rax]
    xor eax, eax
    call    snprintf
    mov rsi, qword [rsp+56]
    mov rcx, qword [rbx]
    movzx   eax, byte [rsi]
    mov rdx, rax
    test    byte [rcx+1+rax*2], 32
    je  L299
    lea rax, [rsi+1]
align 32
align 16
align 8
L300:
    movzx   edi, byte [rax]
    mov rsi, rax
    lea rax, [rax+1]
    mov rdx, rdi
    test    byte [rcx+1+rdi*2], 32
    jne L300
    mov qword [rsp+56], rsi
L299:
    cmp dl, 44
    je  L366
    mov rbx, qword [rsp+8]
    mov rbp, qword [rsp+16]
    mov r8, r13
    cmp dl, 41
    jne L275
L295:
    mov r13, r8
    mov r14, r8
    cmp r8, rbp
    jb  L306
    jmp L307
align 16
align 8
L309:
    add r13, 1
    cmp r13, rbp
    jnb L361
L306:
    mov rdi, r13
    sal rdi, 11
    add rdi, statements
    call    trim
    cmp byte [rax], 126
    jne L309
    cmp byte [rax+1], 0
    jne L309
    mov r8, r14
    cmp r13, rbp
    jnb L307
    xor eax, eax
    mov rcx, rbx
    mov edx, LC1
    mov esi, 1024
    lea rdi, [rsp+2104]
    mov qword [rsp+8], r14
    mov qword [rsp+2096], r13
    call    snprintf
    mov r15, qword [rel function_count]
    mov r8, qword [rsp+8]
    test    r15, r15
    je  L321
    xor r13d, r13d
    mov qword [rsp+8], rbx
    mov r14d, functions
    mov rbx, r13
    mov r13, r8
    jmp L314
align 16
align 8
L311:
    add rbx, 1
    add r14, 2872
    cmp rbx, r15
    je  L367
L314:
    mov rsi, r12
    mov rdi, r14
    call    strcmp
    test    eax, eax
    jne L311
    mov r8, r13
    mov r13, rbx
    mov rbx, qword [rsp+8]
    test    r13d, r13d
    js  L313
    movsx   rax, r13d
    mov ecx, 359
    mov rsi, r12
    imul    rax, rax, 2872
    add rax, functions
    mov rdi, rax
    rep movsq
L315:
    add rbx, 2048
    jmp L319
align 16
align 8
L361:
    mov r8, r14
L307:
    mov rdi, qword [rel stderr]
    mov rcx, rbx
    mov rdx, r12
    xor eax, eax
    mov esi, LC12
    mov qword [rsp+8], r8
    call    fprintf
    mov byte [rel runtime_error], 1
    mov r8, qword [rsp+8]
    jmp L275
align 16
align 8
L367:
    mov rbx, qword [rsp+8]
    mov r8, r13
L313:
    lea rax, [r15+1]
    cmp r15, 511
    ja  L368
L310:
    imul    r15, r15, 2872
    mov qword [rel function_count], rax
    mov ecx, 359
    mov rsi, r12
    add r15, functions
    mov rdi, r15
    rep movsq
    jmp L315
align 16
align 8
L364:
    mov esi, 46
    lea rdi, [rsp+64]
    call    strchr
    mov r10, qword [rsp+8]
    mov r8, qword [rsp+16]
    test    rax, rax
    jne L281
    mov rdi, qword [rsp+24]
    call    strlen
    mov rsi, qword [rsp+24]
    mov r10, qword [rsp+8]
    mov rdi, r12
    mov r9, rax
    mov eax, 94
    mov r8, qword [rsp+16]
    cmp r9, rax
    cmova   r9, rax
    cmp r9d, 8
    jb  L282
    mov ecx, r9d
    shr ecx, 3
    rep movsq
L282:
    xor eax, eax
    test    r9b, 4
    je  L283
    mov eax, dword [rsi]
    mov dword [rdi], eax
    mov eax, 4
L283:
    test    r9b, 2
    je  L284
    movzx   edx, word [rsi+rax]
    mov word [rdi+rax], dx
    add rax, 2
L284:
    test    r9b, 1
    je  L285
    movzx   edx, byte [rsi+rax]
    mov byte [rdi+rax], dl
L285:
    lea rdi, [rsp+64]
    mov qword [rsp+40], r8
    mov qword [rsp+16], r10
    mov byte [rsp+256+r9], 46
    mov qword [rsp+8], r9
    call    strlen
    mov r9, qword [rsp+8]
    mov edx, 94
    mov r10, qword [rsp+16]
    mov r8, qword [rsp+40]
    sub rdx, r9
    cmp rdx, rax
    cmova   rdx, rax
    add r9, 1
    lea rax, [r12+r9]
    cmp edx, 8
    jnb L286
    test    dl, 4
    jne L369
    test    edx, edx
    je  L287
    movzx   ecx, byte [rsp+64]
    mov byte [rax], cl
    test    dl, 2
    jne L370
L287:
    lea rax, [rdx+3136]
    lea rdx, [rsp+rax]
    mov byte [r9-2880+rdx], 0
    jmp L290
L368:
    mov edx, 28
    mov esi, 1
    mov edi, LC13
    mov rcx, qword [rel stderr]
    mov qword [rsp+8], r8
    call    fwrite
    mov byte [rel runtime_error], 1
    mov r8, qword [rsp+8]
    jmp L315
L366:
    movzx   edx, byte [rsi+1]
    lea rax, [rsi+1]
    mov qword [rsp+56], rax
    test    dl, dl
    jne L302
L358:
    mov rbx, qword [rsp+8]
    mov rbp, qword [rsp+16]
    mov r8, r13
    jmp L295
L321:
    mov eax, 1
    jmp L310
L286:
    mov rcx, qword [rsp+64]
    lea rdi, [rax+8]
    and rdi, -8
    mov qword [rax], rcx
    mov ecx, edx
    mov rsi, qword [rsp+56+rcx]
    mov qword [rax-8+rcx], rsi
    sub rax, rdi
    lea rsi, [rsp+64]
    sub rsi, rax
    add eax, edx
    shr eax, 3
    mov ecx, eax
    rep movsq
    jmp L287
L365:
    mov rdi, qword [rel stderr]
    mov ecx, 16
    lea rdx, [rsp+64]
    xor eax, eax
    mov esi, LC11
    mov rbx, qword [rsp+8]
    mov rbp, qword [rsp+16]
    mov qword [rsp+8], r13
    call    fprintf
    mov byte [rel runtime_error], 1
    mov r8, qword [rsp+8]
    jmp L275
L359:
    mov rbx, qword [rsp+8]
    mov rbp, qword [rsp+16]
    mov r8, r13
    jmp L275
L369:
    mov ecx, dword [rsp+64]
    mov dword [rax], ecx
    mov ecx, edx
    mov esi, dword [rsp+60+rcx]
    mov dword [rax-4+rcx], esi
    jmp L287
L370:
    mov ecx, edx
    movzx   esi, word [rsp+62+rcx]
    mov word [rax-2+rcx], si
    jmp L287
LFE37:
section .rodata
LC14:
    db 0x72, 0x00
section .rodata
align 8
LC15:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x73, 0x74, 0x61, 0x74, 0x65, 0x6d, 0x65, 0x6e, 0x74, 0x20, 0x6c, 0x69, 0x6d, 0x69, 0x74, 0x20, 0x28, 0x25, 0x64, 0x29, 0x20, 0x72, 0x65, 0x61, 0x63, 0x68, 0x65, 0x64, 0x20, 0x77, 0x68, 0x69, 0x6c, 0x65, 0x20, 0x72, 0x65, 0x61, 0x64, 0x69, 0x6e, 0x67, 0x20, 0x25, 0x73, 0x0a, 0x00
section .rodata
LC16:
    db 0x3b, 0x00
section .text
align 16
    load_source:
LFB38:
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbp
    push    rbx
    mov rbx, rdi
    sub rsp, 184
    lea rbp, [rsp+32]
    mov qword [rsp], rsi
    mov rsi, rbp
    call    stat
    test    eax, eax
    jne L375
    mov eax, dword [rsp+56]
    and eax, 61440
    cmp eax, 32768
    je  L442
L375:
    xor eax, eax
L371:
    add rsp, 184
    pop rbx
    pop rbp
    pop r12
    pop r13
    pop r14
    pop r15
    ret
L442:
    mov rdi, rbx
    call    loaded_file
    test    al, al
    jne L373
    mov esi, LC14
    mov rdi, rbx
    call    fopen
    mov r13, rax
    test    rax, rax
    je  L375
    mov rax, qword [rel statement_count]
    lea r15, [rsp+24]
    mov qword [rsp+24], 0
    mov qword [rsp+32], 0
    mov qword [rsp+8], rax
align 16
align 8
L393:
    mov rdx, r13
    mov rsi, rbp
    mov rdi, r15
    call    getline
    test    rax, rax
    js  L380
    cmp qword [rel statement_count], 8191
    ja  L443
    mov r12, qword [rsp+24]
    mov rdi, r12
    call    strlen
    test    rax, rax
    jne L381
    jmp L384
align 32
align 16
align 8
L385:
    mov byte [r12+rax], 0
    test    rax, rax
    je  L384
L381:
    sub rax, 1
    movzx   edx, byte [r12+rax]
    cmp dl, 10
    je  L385
    cmp dl, 13
    je  L385
L384:
    movzx   eax, byte [r12]
    mov rdx, r12
    test    al, al
    je  L383
align 16
align 8
L392:
    cmp al, 39
    je  L416
    cmp al, 34
    je  L416
    cmp al, 35
    je  L391
    movzx   eax, byte [rdx+1]
    add rdx, 1
    test    al, al
    jne L392
align 16
align 8
L383:
    mov rdi, r12
    call    trim
    mov r14, rax
    movzx   eax, byte [rax]
    test    al, al
    je  L393
    cmp al, 59
    jne L414
    cmp byte [r14+1], 0
    je  L444
L414:
    mov rdi, r14
L395:
    cmp al, 39
    je  L417
    cmp al, 34
    je  L417
    test    al, al
    jne L445
L399:
    mov byte [r14], 0
    call    trim
    cmp byte [rax], 0
    mov rdi, rax
    je  L393
    mov rsi, rbx
    call    add_statement
    jmp L393
align 16
align 8
L416:
    movzx   ecx, byte [rdx+1]
    add rdx, 1
    test    cl, cl
    je  L383
    movzx   esi, byte [rdx+1]
    cmp cl, al
    je  L386
L447:
    cmp cl, 92
    je  L446
    mov ecx, esi
L387:
    add rdx, 1
    test    cl, cl
    je  L383
    movzx   esi, byte [rdx+1]
    cmp cl, al
    jne L447
L386:
    add rdx, 1
    test    sil, sil
    je  L383
    mov eax, esi
    jmp L392
align 16
align 8
L417:
    movzx   ecx, byte [r14+1]
    add r14, 1
    cmp cl, al
    je  L404
L405:
    cmp cl, 92
    je  L398
    test    cl, cl
    je  L399
    movzx   ecx, byte [r14+1]
    add r14, 1
L400:
    cmp cl, al
    jne L405
    mov r12, r14
L397:
    cmp cl, 59
    jne L404
    mov byte [r14], 0
    call    trim
    cmp byte [rax], 0
    jne L409
    add r14, 1
    movzx   eax, byte [r12+1]
    mov rdi, r14
    jmp L395
align 16
align 8
L446:
    test    sil, sil
    je  L383
    movzx   ecx, byte [rdx+2]
    add rdx, 1
    jmp L387
align 16
align 8
L398:
    cmp byte [r14+1], 0
    jne L401
    add r14, 1
    jmp L399
align 16
align 8
L401:
    movzx   ecx, byte [r14+2]
    add r14, 2
    jmp L400
align 16
align 8
L391:
    mov byte [rdx], 0
    jmp L383
align 16
align 8
L445:
    mov ecx, eax
    mov r12, r14
    jmp L397
align 16
align 8
L444:
    mov rsi, rbx
    mov edi, LC16
    call    add_statement
    jmp L393
L443:
    mov rcx, rbx
    mov edx, 8192
    mov esi, LC15
    xor eax, eax
    mov rdi, qword [rel stderr]
    call    fprintf
    mov byte [rel runtime_error], 1
L380:
    mov rdi, qword [rsp+24]
    call    free
    mov rdi, r13
    call    fclose
    mov rdi, rbx
    call    remember_file
    mov rdx, qword [rsp]
    mov rdi, qword [rsp+8]
    mov rsi, qword [rel statement_count]
    call    register_functions
L373:
    mov eax, 1
    jmp L371
align 16
align 8
L404:
    movzx   eax, byte [r14+1]
    add r14, 1
    jmp L395
L409:
    mov rdi, rax
    mov rsi, rbx
    call    add_statement
    lea rdi, [r14+1]
    movzx   eax, byte [r14+1]
    mov r14, rdi
    jmp L395
LFE38:
section .rodata
LC17:
    db 0x25, 0x73, 0x2f, 0x25, 0x73, 0x00
LC18:
    db 0x00
section .text
align 16
    load_plugin_directory:
LFB40:
    push    r15
    push    r14
    push    r13
    push    r12
    mov r12, rdi
    push    rbp
    push    rbx
    sub rsp, 66568
    call    opendir
    test    rax, rax
    je  L448
    mov rbp, rax
    xor ebx, ebx
    lea r13, [rsp+1024]
align 16
align 8
L449:
    mov rdi, rbp
    call    readdir
    test    rax, rax
    je  L467
L451:
    cmp byte [rax+19], 46
    je  L449
    lea r14, [rax+19]
    mov rdi, r14
    call    strlen
    cmp rax, 3
    jbe L449
    lea rdi, [r14-4+rax]
    mov esi, LC10
    call    strcmp
    test    eax, eax
    jne L449
    cmp rbx, 255
    ja  L449
    lea r15, [rbx+1]
    sal rbx, 8
    mov rcx, r14
    mov edx, LC1
    lea rdi, [r13+0+rbx]
    mov esi, 256
    mov rbx, r15
    call    snprintf
    mov rdi, rbp
    call    readdir
    test    rax, rax
    jne L451
align 16
align 8
L467:
    mov rdi, rbp
    call    closedir
    mov ecx, cmp_names
    mov rsi, rbx
    mov rdi, r13
    mov edx, 256
    call    qsort
    test    rbx, rbx
    je  L448
    xor ebp, ebp
    mov r14, rsp
align 16
align 8
L453:
    mov r8, rbp
    mov rcx, r12
    mov edx, LC17
    mov esi, 1024
    sal r8, 8
    mov rdi, r14
    xor eax, eax
    add rbp, 1
    add r8, r13
    call    snprintf
    mov esi, LC18
    mov rdi, r14
    call    load_source
    cmp rbx, rbp
    jne L453
L448:
    add rsp, 66568
    pop rbx
    pop rbp
    pop r12
    pop r13
    pop r14
    pop r15
    ret
LFE40:
section .rodata
LC19:
    db 0x48, 0x4f, 0x4d, 0x45, 0x00
LC20:
    db 0x25, 0x73, 0x2f, 0x2e, 0x63, 0x6f, 0x6e, 0x66, 0x69, 0x67, 0x2f, 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x2f, 0x76, 0x69, 0x6e, 0x69, 0x74, 0x00
LC21:
    db 0x25, 0x73, 0x2f, 0x76, 0x69, 0x6e, 0x69, 0x74, 0x00
LC22:
    db 0x76, 0x69, 0x6e, 0x69, 0x74, 0x00
section .text
align 16
    load_plugins:
LFB41:
    push    rbp
    push    rbx
    sub rsp, 1032
    test    rdi, rdi
    je  L469
    mov esi, 47
    mov rbx, rdi
    call    strchr
    test    rax, rax
    je  L469
    mov esi, 1024
    mov rdi, rsp
    xor eax, eax
    mov rcx, rbx
    mov edx, LC1
    call    snprintf
    mov esi, 47
    mov rdi, rsp
    call    strrchr
    test    rax, rax
    je  L469
    mov byte [rax], 0
    mov rdi, rsp
    call    strlen
    lea rdx, [rax+7]
    cmp rdx, 1023
    jbe L484
align 16
align 8
L469:
    mov edi, LC19
    call    getenv
    mov rbx, rax
    test    rax, rax
    je  L473
    cmp byte [rax], 0
    jne L485
L473:
    add rsp, 1032
    mov edi, LC22
    pop rbx
    pop rbp
    jmp load_plugin_directory
align 16
align 8
L485:
    mov rcx, rax
    mov edx, LC20
    mov esi, 1024
    mov rdi, rsp
    xor eax, eax
    call    snprintf
    mov rdi, rsp
    call    load_plugin_directory
    mov rdi, rsp
    mov rcx, rbx
    mov edx, LC21
    mov esi, 1024
    xor eax, eax
    call    snprintf
    mov rdi, rsp
    call    load_plugin_directory
    jmp L473
align 16
align 8
L484:
    add rax, rsp
    mov rdi, rsp
    mov dword [rax], 1852405295
    mov dword [rax+3], 7629166
    call    load_plugin_directory
    jmp L469
LFE41:
section .rodata
LC23:
    db 0x25, 0x73, 0x2e, 0x25, 0x73, 0x00
section .text
align 16
    find_function:
LFB34:
    push    r14
    push    r13
    push    r12
    push    rbp
    mov rbp, rsi
    mov esi, 46
    push    rbx
    mov rbx, rdi
    sub rsp, 192
    call    strchr
    test    rax, rax
    jne L514
    cmp byte [rbp+0], 0
    jne L491
    mov r13, qword [rel function_count]
    test    r13, r13
    je  L503
L492:
    mov r12d, functions
    xor ebp, ebp
    jmp L499
align 16
align 8
L497:
    add rbp, 1
    add r12, 2872
    cmp rbp, r13
    je  L498
L499:
    mov rsi, rbx
    mov rdi, r12
    call    strcmp
    test    eax, eax
    jne L497
    mov r14d, ebp
    test    ebp, ebp
    js  L498
L486:
    cmp r14d, -1
    jne FIND_FUNCTION_RETURN
    mov rdi, rbx
    call find_builtin
    test eax, eax
    js FIND_FUNCTION_RETURN
    add eax, dword [rel function_count]
    mov r14d, eax
FIND_FUNCTION_RETURN:
    add rsp, 192
    mov eax, r14d
    pop rbx
    pop rbp
    pop r12
    pop r13
    pop r14
    ret
align 16
align 8
L514:
    mov r13, qword [rel function_count]
    test    r13, r13
    je  L503
    mov ebp, functions
    xor r14d, r14d
align 16
align 8
L490:
    mov rsi, rbx
    mov rdi, rbp
    call    strcmp
    test    eax, eax
    je  L486
    add r14, 1
    add rbp, 2872
    cmp r14, r13
    jne L490
L503:
    mov r14d, -1
    jmp L486
align 16
align 8
L498:
    mov r12d, functions+96
    mov r14d, -1
    xor ebp, ebp
    jmp L502
align 16
align 8
L515:
    mov r14d, ebp
L500:
    add rbp, 1
    add r12, 2872
    cmp rbp, r13
    je  L486
L502:
    mov rsi, rbx
    mov rdi, r12
    call    strcmp
    test    eax, eax
    jne L500
    test    r14d, r14d
    js  L515
    mov r14d, -1
    jmp L486
align 16
align 8
L491:
    mov r8, rbx
    mov rcx, rbp
    mov edx, LC23
    mov esi, 192
    mov rdi, rsp
    xor eax, eax
    mov r14, rsp
    call    snprintf
    mov r13, qword [rel function_count]
    test    r13, r13
    je  L503
    mov r12d, functions
    xor ebp, ebp
    jmp L496
align 16
align 8
L494:
    add rbp, 1
    add r12, 2872
    cmp r13, rbp
    je  L492
L496:
    mov rsi, r14
    mov rdi, r12
    call    strcmp
    test    eax, eax
    jne L494
    mov r14d, ebp
    test    ebp, ebp
    js  L492
    jmp L486
LFE34:
align 16
    set_value:
LFB31:
    push    r13
    mov r13, rdi
    push    r12
    push    rbp
    push    rbx
    sub rsp, 8
    mov r12, qword [rel variable_count]
    test    r12, r12
    je  L517
    mov ebx, variables
    xor ebp, ebp
align 16
align 8
L520:
    cmp byte [rbx+1136], 0
    je  L518
    mov rsi, r13
    mov rdi, rbx
    call    strcmp
    test    eax, eax
    je  L526
L518:
    add rbp, 1
    add rbx, 1152
    cmp r12, rbp
    jne L520
L517:
    mov rdi, r13
    mov esi, 1
    call    get_variable.part.0
    mov rdi, rax
    test    rax, rax
    je  L527
L519:
    lea rsi, [rsp+48]
    add rdi, 96
    mov ecx, 130
    rep movsq
    add rsp, 8
    pop rbx
    pop rbp
    pop r12
    pop r13
    ret
align 16
align 8
L526:
    lea rdi, [rbp+0+rbp*8]
    sal rdi, 7
    add rdi, variables
    jmp L519
L527:
    add rsp, 8
    pop rbx
    pop rbp
    pop r12
    pop r13
    jmp set_value.part.0
LFE31:
align 16
    get_value:
LFB30:
    push    r14
    mov r14, rdi
    push    r13
    mov r13, rsi
    push    r12
    mov r12, qword [rel variable_count]
    push    rbp
    push    rbx
    test    r12, r12
    je  L529
    mov ebx, variables
    xor ebp, ebp
align 16
align 8
L532:
    cmp byte [rbx+1136], 0
    je  L530
    mov rsi, r13
    mov rdi, rbx
    call    strcmp
    test    eax, eax
    je  L540
L530:
    add rbp, 1
    add rbx, 1152
    cmp r12, rbp
    jne L532
L529:
    xor esi, esi
    mov rdi, r13
    call    get_variable.part.0
    mov rsi, rax
    test    rax, rax
    je  L533
L531:
    mov rdi, r14
    add rsi, 96
    mov ecx, 130
    mov rax, r14
    rep movsq
    pop rbx
    pop rbp
    pop r12
    pop r13
    pop r14
    ret
align 16
align 8
L540:
    lea rsi, [rbp+0+rbp*8]
    sal rsi, 7
    add rsi, variables
    jmp L531
align 16
align 8
L533:
    mov rdi, r14
    xor esi, esi
    call    number_value
    pop rbx
    mov rax, r14
    pop rbp
    pop r12
    pop r13
    pop r14
    ret
LFE30:
align 16
    parse_range_atom.isra.0:
LFB103:
    push    r12
    push    rbp
    mov rbp, rdi
    push    rbx
    mov rbx, rsi
    sub rsp, 1152
    call    __ctype_b_loc
    mov rdi, qword [rbp+0]
    mov rsi, qword [rax]
    movzx   eax, byte [rdi]
    movzx   ecx, word [rsi+rax*2]
    test    ch, 32
    je  L564
    lea rax, [rdi+1]
align 32
align 16
align 8
L543:
    mov qword [rbp+0], rax
    movzx   ecx, byte [rax]
    mov rdi, rax
    add rax, 1
    mov rdx, rcx
    movzx   ecx, word [rsi+rcx*2]
    test    ch, 32
    jne L543
L542:
    test    dl, dl
    je  L551
    sub edx, 43
    mov rax, rdi
    and edx, 253
    jne L546
    lea rax, [rdi+1]
    mov qword [rbp+0], rax
    movzx   edx, byte [rdi+1]
    movzx   ecx, word [rsi+rdx*2]
L546:
    and ch, 8
    je  L547
    add rax, 1
align 32
align 16
align 8
L548:
    mov rdx, rax
    mov qword [rbp+0], rax
    add rax, 1
    movzx   ecx, byte [rdx]
    test    byte [rsi+1+rcx*2], 8
    jne L548
    sub rdx, rdi
    mov rbp, rdx
    cmp rdx, 127
    ja  L551
    lea r12, [rsp+112]
    mov rsi, rdi
    mov rdi, r12
    call    memcpy
    mov byte [rsp+112+rbp], 0
    call    __errno_location
    mov edx, 10
    lea rsi, [rsp+16]
    mov rdi, r12
    mov dword [rax], 0
    mov rbp, rax
    call    strtoll
    mov edx, dword [rbp+0]
    test    edx, edx
    jne L551
    mov rdx, qword [rsp+16]
    cmp byte [rdx], 0
    jne L551
L566:
    mov qword [rbx], rax
    add rsp, 1152
    mov eax, 1
    pop rbx
    pop rbp
    pop r12
    ret
align 16
align 8
L547:
    mov qword [rbp+0], rdi
    lea r12, [rsp+16]
    mov rdi, rbp
    mov rsi, r12
    call    parse_identifier.constprop.0
    cmp byte [rsp+16], 0
    jne L567
L551:
    add rsp, 1152
    xor eax, eax
    pop rbx
    pop rbp
    pop r12
    ret
align 16
align 8
L567:
    lea rdi, [rsp+112]
    mov rsi, r12
    call    get_value
    cmp dword [rsp+112], 1
    mov rax, qword [rsp+120]
    jne L566
    lea rbp, [rsp+128]
    mov edx, 10
    lea rsi, [rsp+8]
    mov rdi, rbp
    call    strtoll
    mov rdx, qword [rsp+8]
    cmp rdx, rbp
    je  L557
    cmp byte [rdx], 0
    mov edx, 0
    cmovne  rax, rdx
    jmp L566
align 16
align 8
L564:
    mov rdx, rax
    jmp L542
L557:
    xor eax, eax
    jmp L566
LFE103:
section .rodata
LC24:
    db 0x64, 0x65, 0x63, 0x00
LC25:
    db 0x69, 0x6e, 0x63, 0x00
LC26:
    db 0x61, 0x64, 0x64, 0x00
LC27:
    db 0x73, 0x75, 0x62, 0x00
LC28:
    db 0x69, 0x6d, 0x75, 0x6c, 0x00
LC29:
    db 0x6d, 0x75, 0x6c, 0x00
LC30:
    db 0x64, 0x69, 0x76, 0x00
LC31:
    db 0x69, 0x64, 0x69, 0x76, 0x00
LC32:
    db 0x78, 0x6f, 0x72, 0x00
LC33:
    db 0x61, 0x6e, 0x64, 0x00
LC34:
    db 0x6f, 0x72, 0x00
LC35:
    db 0x63, 0x6d, 0x70, 0x00
LC36:
    db 0x6d, 0x6f, 0x76, 0x00
section .rodata
align 8
LC37:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x67, 0x6c, 0x6f, 0x62, 0x61, 0x6c, 0x20, 0x61, 0x73, 0x73, 0x69, 0x67, 0x6e, 0x6d, 0x65, 0x6e, 0x74, 0x20, 0x73, 0x79, 0x6e, 0x74, 0x61, 0x78, 0x20, 0x69, 0x73, 0x20, 0x6c, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x3d, 0x76, 0x61, 0x6c, 0x75, 0x65, 0x20, 0x6f, 0x72, 0x20, 0x6c, 0x6e, 0x61, 0x6d, 0x65, 0x3d, 0x76, 0x61, 0x6c, 0x75, 0x65, 0x0a, 0x00
section .rodata
LC38:
    db 0x6a, 0x6d, 0x70, 0x00
LC39:
    db 0x6a, 0x65, 0x00
LC40:
    db 0x6a, 0x6e, 0x65, 0x00
LC41:
    db 0x6a, 0x67, 0x00
LC42:
    db 0x6a, 0x67, 0x65, 0x00
LC43:
    db 0x6a, 0x6c, 0x00
LC44:
    db 0x6a, 0x6c, 0x65, 0x00
LC45:
    db 0x6a, 0x7a, 0x00
LC46:
    db 0x6a, 0x6e, 0x7a, 0x00
section .rodata
align 8
LC47:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x25, 0x73, 0x20, 0x72, 0x65, 0x71, 0x75, 0x69, 0x72, 0x65, 0x73, 0x20, 0x61, 0x20, 0x70, 0x72, 0x65, 0x76, 0x69, 0x6f, 0x75, 0x73, 0x20, 0x63, 0x6d, 0x70, 0x20, 0x69, 0x6e, 0x73, 0x74, 0x72, 0x75, 0x63, 0x74, 0x69, 0x6f, 0x6e, 0x0a, 0x00
align 8
LC48:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x61, 0x73, 0x73, 0x65, 0x6d, 0x62, 0x6c, 0x79, 0x20, 0x63, 0x6f, 0x6d, 0x70, 0x61, 0x72, 0x69, 0x73, 0x6f, 0x6e, 0x73, 0x20, 0x72, 0x65, 0x71, 0x75, 0x69, 0x72, 0x65, 0x20, 0x6e, 0x75, 0x6d, 0x65, 0x72, 0x69, 0x63, 0x20, 0x6f, 0x70, 0x65, 0x72, 0x61, 0x6e, 0x64, 0x73, 0x0a, 0x00
align 8
LC49:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x61, 0x73, 0x73, 0x65, 0x6d, 0x62, 0x6c, 0x79, 0x20, 0x6a, 0x75, 0x6d, 0x70, 0x20, 0x74, 0x61, 0x72, 0x67, 0x65, 0x74, 0x20, 0x27, 0x25, 0x73, 0x27, 0x20, 0x69, 0x73, 0x20, 0x6e, 0x6f, 0x74, 0x20, 0x61, 0x20, 0x6c, 0x61, 0x62, 0x65, 0x6c, 0x20, 0x6f, 0x72, 0x20, 0x76, 0x61, 0x6c, 0x69, 0x64, 0x20, 0x73, 0x74, 0x61, 0x74, 0x65, 0x6d, 0x65, 0x6e, 0x74, 0x20, 0x69, 0x6e, 0x64, 0x65, 0x78, 0x0a, 0x00
section .rodata
LC50:
    db 0x63, 0x61, 0x6c, 0x6c, 0x00
section .rodata
align 8
LC51:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x63, 0x61, 0x6c, 0x6c, 0x20, 0x74, 0x61, 0x72, 0x67, 0x65, 0x74, 0x20, 0x27, 0x25, 0x73, 0x27, 0x20, 0x69, 0x73, 0x20, 0x6e, 0x6f, 0x74, 0x20, 0x61, 0x20, 0x56, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x20, 0x66, 0x75, 0x6e, 0x63, 0x74, 0x69, 0x6f, 0x6e, 0x0a, 0x00
section .rodata
LC52:
    db 0x72, 0x61, 0x78, 0x00
LC53:
    db 0x72, 0x65, 0x74, 0x00
section .rodata
align 8
LC54:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x72, 0x65, 0x74, 0x20, 0x6f, 0x75, 0x74, 0x73, 0x69, 0x64, 0x65, 0x20, 0x61, 0x20, 0x66, 0x75, 0x6e, 0x63, 0x74, 0x69, 0x6f, 0x6e, 0x0a, 0x00
section .rodata
LC55:
    db 0x6e, 0x6f, 0x70, 0x00
section .rodata
align 8
LC56:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x25, 0x73, 0x20, 0x65, 0x78, 0x70, 0x65, 0x63, 0x74, 0x73, 0x20, 0x63, 0x6f, 0x6d, 0x6d, 0x61, 0x2d, 0x73, 0x65, 0x70, 0x61, 0x72, 0x61, 0x74, 0x65, 0x64, 0x20, 0x6f, 0x70, 0x65, 0x72, 0x61, 0x6e, 0x64, 0x73, 0x0a, 0x00
align 8
LC57:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x25, 0x73, 0x20, 0x72, 0x65, 0x71, 0x75, 0x69, 0x72, 0x65, 0x73, 0x20, 0x61, 0x20, 0x6e, 0x75, 0x6d, 0x65, 0x72, 0x69, 0x63, 0x20, 0x72, 0x65, 0x67, 0x69, 0x73, 0x74, 0x65, 0x72, 0x0a, 0x00
align 8
LC58:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x72, 0x65, 0x67, 0x69, 0x73, 0x74, 0x65, 0x72, 0x20, 0x6f, 0x76, 0x65, 0x72, 0x66, 0x6c, 0x6f, 0x77, 0x20, 0x69, 0x6e, 0x20, 0x25, 0x73, 0x0a, 0x00
align 8
LC59:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x69, 0x6e, 0x76, 0x61, 0x6c, 0x69, 0x64, 0x20, 0x72, 0x69, 0x67, 0x68, 0x74, 0x20, 0x6f, 0x70, 0x65, 0x72, 0x61, 0x6e, 0x64, 0x20, 0x27, 0x25, 0x73, 0x27, 0x20, 0x66, 0x6f, 0x72, 0x20, 0x25, 0x73, 0x0a, 0x00
align 8
LC60:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x69, 0x6e, 0x76, 0x61, 0x6c, 0x69, 0x64, 0x20, 0x6c, 0x65, 0x66, 0x74, 0x20, 0x6f, 0x70, 0x65, 0x72, 0x61, 0x6e, 0x64, 0x20, 0x27, 0x25, 0x73, 0x27, 0x20, 0x66, 0x6f, 0x72, 0x20, 0x63, 0x6d, 0x70, 0x0a, 0x00
align 8
LC61:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x25, 0x73, 0x20, 0x6f, 0x70, 0x65, 0x72, 0x61, 0x6e, 0x64, 0x73, 0x20, 0x6d, 0x75, 0x73, 0x74, 0x20, 0x62, 0x65, 0x20, 0x6e, 0x75, 0x6d, 0x65, 0x72, 0x69, 0x63, 0x0a, 0x00
align 8
LC62:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x69, 0x6e, 0x76, 0x61, 0x6c, 0x69, 0x64, 0x20, 0x6f, 0x70, 0x65, 0x72, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x20, 0x6f, 0x72, 0x20, 0x6f, 0x76, 0x65, 0x72, 0x66, 0x6c, 0x6f, 0x77, 0x20, 0x69, 0x6e, 0x20, 0x25, 0x73, 0x20, 0x28, 0x63, 0x68, 0x65, 0x63, 0x6b, 0x20, 0x64, 0x69, 0x76, 0x69, 0x64, 0x65, 0x2d, 0x62, 0x79, 0x2d, 0x7a, 0x65, 0x72, 0x6f, 0x20, 0x61, 0x6e, 0x64, 0x20, 0x6f, 0x70, 0x65, 0x72, 0x61, 0x6e, 0x64, 0x20, 0x73, 0x69, 0x7a, 0x65, 0x29, 0x0a, 0x00
section .rodata
LC63:
    db 0x25, 0x6c, 0x6c, 0x64, 0x00
section .rodata
align 8
LC64:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x6f, 0x20, 0x65, 0x78, 0x70, 0x65, 0x63, 0x74, 0x73, 0x20, 0x61, 0x20, 0x71, 0x75, 0x6f, 0x74, 0x65, 0x64, 0x20, 0x73, 0x68, 0x65, 0x6c, 0x6c, 0x20, 0x63, 0x6f, 0x6d, 0x6d, 0x61, 0x6e, 0x64, 0x2c, 0x20, 0x65, 0x2e, 0x67, 0x2e, 0x20, 0x6f, 0x22, 0x65, 0x63, 0x68, 0x6f, 0x20, 0x68, 0x69, 0x22, 0x0a, 0x00
section .rodata
LC65:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x73, 0x79, 0x73, 0x74, 0x65, 0x6d, 0x00
section .rodata
align 8
LC66:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x55, 0x20, 0x65, 0x78, 0x70, 0x65, 0x63, 0x74, 0x73, 0x20, 0x61, 0x20, 0x71, 0x75, 0x6f, 0x74, 0x65, 0x64, 0x20, 0x6d, 0x6f, 0x64, 0x75, 0x6c, 0x65, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x2c, 0x20, 0x65, 0x2e, 0x67, 0x2e, 0x20, 0x55, 0x22, 0x6d, 0x61, 0x74, 0x68, 0x22, 0x0a, 0x00
section .rodata
LC67:
    db 0x6d, 0x6f, 0x64, 0x75, 0x6c, 0x65, 0x73, 0x00
LC68:
    db 0x76, 0x6d, 0x6f, 0x64, 0x75, 0x6c, 0x65, 0x73, 0x00
LC69:
    db 0x2e, 0x2e, 0x00
LC70:
    db 0x2e, 0x2e, 0x2f, 0x6d, 0x6f, 0x64, 0x75, 0x6c, 0x65, 0x73, 0x00
section .rodata
align 8
LC71:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x6d, 0x6f, 0x64, 0x75, 0x6c, 0x65, 0x20, 0x27, 0x25, 0x73, 0x27, 0x20, 0x6e, 0x6f, 0x74, 0x20, 0x66, 0x6f, 0x75, 0x6e, 0x64, 0x20, 0x28, 0x63, 0x68, 0x65, 0x63, 0x6b, 0x65, 0x64, 0x20, 0x74, 0x68, 0x65, 0x20, 0x63, 0x75, 0x72, 0x72, 0x65, 0x6e, 0x74, 0x20, 0x64, 0x69, 0x72, 0x65, 0x63, 0x74, 0x6f, 0x72, 0x79, 0x2c, 0x20, 0x6d, 0x6f, 0x64, 0x75, 0x6c, 0x65, 0x73, 0x2f, 0x2c, 0x20, 0x76, 0x6d, 0x6f, 0x64, 0x75, 0x6c, 0x65, 0x73, 0x2f, 0x2c, 0x20, 0x61, 0x6e, 0x64, 0x20, 0x74, 0x68, 0x65, 0x20, 0x73, 0x6f, 0x75, 0x72, 0x63, 0x65, 0x20, 0x64, 0x69, 0x72, 0x65, 0x63, 0x74, 0x6f, 0x72, 0x79, 0x29, 0x0a, 0x00
align 8
LC72:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x63, 0x61, 0x6e, 0x6e, 0x6f, 0x74, 0x20, 0x72, 0x65, 0x61, 0x64, 0x20, 0x6d, 0x6f, 0x64, 0x75, 0x6c, 0x65, 0x20, 0x25, 0x73, 0x0a, 0x00
align 8
LC73:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x4b, 0x20, 0x6e, 0x65, 0x65, 0x64, 0x73, 0x20, 0x61, 0x20, 0x76, 0x61, 0x72, 0x69, 0x61, 0x62, 0x6c, 0x65, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x0a, 0x00
section .rodata
LC74:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x6c, 0x61, 0x62, 0x65, 0x6c, 0x20, 0x27, 0x25, 0x73, 0x27, 0x20, 0x6e, 0x6f, 0x74, 0x20, 0x66, 0x6f, 0x75, 0x6e, 0x64, 0x0a, 0x00
section .rodata
align 8
LC75:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x75, 0x6e, 0x74, 0x65, 0x72, 0x6d, 0x69, 0x6e, 0x61, 0x74, 0x65, 0x64, 0x20, 0x6c, 0x6f, 0x6f, 0x70, 0x20, 0x61, 0x74, 0x20, 0x25, 0x73, 0x3a, 0x25, 0x7a, 0x75, 0x0a, 0x00
align 8
LC76:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x6c, 0x6f, 0x6f, 0x70, 0x20, 0x69, 0x74, 0x65, 0x72, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x20, 0x73, 0x61, 0x66, 0x65, 0x74, 0x79, 0x20, 0x6c, 0x69, 0x6d, 0x69, 0x74, 0x20, 0x72, 0x65, 0x61, 0x63, 0x68, 0x65, 0x64, 0x0a, 0x00
align 8
LC77:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x75, 0x6e, 0x74, 0x65, 0x72, 0x6d, 0x69, 0x6e, 0x61, 0x74, 0x65, 0x64, 0x20, 0x72, 0x61, 0x6e, 0x67, 0x65, 0x20, 0x6c, 0x6f, 0x6f, 0x70, 0x20, 0x61, 0x74, 0x20, 0x25, 0x73, 0x3a, 0x25, 0x7a, 0x75, 0x0a, 0x00
align 8
LC78:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x4f, 0x20, 0x73, 0x79, 0x6e, 0x74, 0x61, 0x78, 0x20, 0x69, 0x73, 0x20, 0x4f, 0x20, 0x6e, 0x61, 0x6d, 0x65, 0x20, 0x73, 0x74, 0x61, 0x72, 0x74, 0x20, 0x65, 0x6e, 0x64, 0x20, 0x5b, 0x73, 0x74, 0x65, 0x70, 0x5d, 0x0a, 0x00
section .rodata
LC79:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x69, 0x6e, 0x76, 0x61, 0x6c, 0x69, 0x64, 0x20, 0x72, 0x61, 0x6e, 0x67, 0x65, 0x20, 0x73, 0x74, 0x65, 0x70, 0x0a, 0x00
section .rodata
align 8
LC80:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x72, 0x61, 0x6e, 0x67, 0x65, 0x20, 0x73, 0x74, 0x65, 0x70, 0x20, 0x63, 0x61, 0x6e, 0x6e, 0x6f, 0x74, 0x20, 0x62, 0x65, 0x20, 0x7a, 0x65, 0x72, 0x6f, 0x0a, 0x00
align 8
LC81:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x72, 0x61, 0x6e, 0x67, 0x65, 0x20, 0x69, 0x74, 0x65, 0x72, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x20, 0x73, 0x61, 0x66, 0x65, 0x74, 0x79, 0x20, 0x6c, 0x69, 0x6d, 0x69, 0x74, 0x20, 0x72, 0x65, 0x61, 0x63, 0x68, 0x65, 0x64, 0x0a, 0x00
section .rodata
LC82:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x72, 0x61, 0x6e, 0x67, 0x65, 0x20, 0x6f, 0x76, 0x65, 0x72, 0x66, 0x6c, 0x6f, 0x77, 0x0a, 0x00
LC83:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x52, 0x20, 0x6f, 0x75, 0x74, 0x73, 0x69, 0x64, 0x65, 0x20, 0x61, 0x20, 0x66, 0x75, 0x6e, 0x63, 0x74, 0x69, 0x6f, 0x6e, 0x0a, 0x00
section .rodata
align 8
LC84:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x75, 0x6e, 0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x20, 0x66, 0x75, 0x6e, 0x63, 0x74, 0x69, 0x6f, 0x6e, 0x20, 0x27, 0x25, 0x73, 0x27, 0x0a, 0x00
align 8
LC85:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x6d, 0x61, 0x6c, 0x66, 0x6f, 0x72, 0x6d, 0x65, 0x64, 0x20, 0x61, 0x72, 0x67, 0x75, 0x6d, 0x65, 0x6e, 0x74, 0x73, 0x20, 0x74, 0x6f, 0x20, 0x25, 0x73, 0x0a, 0x00
align 8
LC86:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x75, 0x6e, 0x6b, 0x6e, 0x6f, 0x77, 0x6e, 0x20, 0x63, 0x6f, 0x6d, 0x6d, 0x61, 0x6e, 0x64, 0x20, 0x61, 0x74, 0x20, 0x25, 0x73, 0x3a, 0x25, 0x7a, 0x75, 0x3a, 0x20, 0x25, 0x73, 0x0a, 0x00
section .text
LCOLDB87:
section .text
LHOTB87:
align 16
    execute_statement:
LFB72:
    push    r15
    mov r15, rdi
    push    r14
    push    r13
    mov r13, rsi
    push    r12
    mov r12, rdi
    push    rbp
    sal r12, 11
    push    rbx
    lea rdi, [statements + r12]
    mov rbx, rdx
    sub rsp, 23032
    call    trim
    movzx   r8d, byte [rax]
    test    r8b, r8b
    je  L1143
    cmp r8b, 70
    je  L1158
    cmp r8b, 126
    mov rcx, rax
    sete    al
    cmp r8b, 38
    sete    dl
    or  al, dl
    jne L1143
    cmp r8b, 58
    je  L1143
    cmp byte [rcx], 59
    je  L1159
L891:
    lea r14, [r15+1]
    mov rbp, r14
    cmp r8b, 108
    je  L1160
    mov qword [rsp+1104], 0
    cmp r8b, 109
    jne L590
    movzx   eax, byte [rcx+1]
    cmp al, 32
    je  L885
    cmp al, 9
    jne L590
L885:
    lea r15, [rcx+1]
    mov r12d, LC36
    mov qword [rsp+1104], r15
    jmp L592
align 16
align 8
L1143:
    lea r14, [r15+1]
L619:
    mov rbp, r14
L568:
    add rsp, 23032
    mov rax, rbp
    pop rbx
    pop rbp
    pop r12
    pop r13
    pop r14
    pop r15
    ret
align 16
align 8
L1159:
    cmp byte [rcx+1], 0
    lea r14, [r15+1]
    je  L619
    jmp L891
align 16
align 8
L1158:
    mov rcx, qword [rel function_count]
    mov edx, functions+1832
    xor eax, eax
    test    rcx, rcx
    jne L574
    jmp L1143
align 32
align 16
align 8
L573:
    add rax, 1
    add rdx, 2872
    cmp rax, rcx
    je  L1143
L574:
    cmp r15, qword [rdx]
    jne L573
    cdqe
    imul    rax, rax, 2872
    mov rbp, qword [functions + rax + 1840]
    add rbp, 1
    jmp L568
align 16
align 8
L590:
    mov rdi, rcx
    lea rdx, [rsp+1104]
    mov esi, LC36
    mov qword [rsp], rcx
    mov byte [rsp+8], r8b
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    test    al, al
    je  L1161
    mov r15, qword [rsp+1104]
    mov r12d, LC36
L592:
    mov esi, 44
    mov rdi, r15
    call    strchr
    test    rax, rax
    je  L654
L606:
    mov rdx, rax
    sub rdx, r15
    je  L652
L644:
    mov ecx, 95
    lea r13, [rsp+1200]
    mov rsi, r15
    cmp rdx, rcx
    mov rdi, r13
    cmova   rdx, rcx
    cmp edx, 8
    jnb L1162
L646:
    xor ecx, ecx
    test    dl, 4
    jne L1163
L647:
    test    dl, 2
    jne L1164
L648:
    test    dl, 1
    jne L1165
L649:
    mov byte [rsp+1200+rdx], 0
    lea rcx, [rax+1]
    mov edx, LC1
    xor eax, eax
    lea r14, [rsp+2224]
    mov esi, 1024
    mov rdi, r14
    call    snprintf
    mov rdi, r13
    call    trim
    cmp rax, r13
    je  L650
    mov rdi, rax
    mov qword [rsp], rax
    call    strlen
    mov rsi, qword [rsp]
    mov rdi, r13
    lea rdx, [rax+1]
    call    memmove
L650:
    mov rdi, r14
    call    trim
    cmp rax, r14
    je  L651
    mov rdi, rax
    mov qword [rsp], rax
    call    strlen
    mov rsi, qword [rsp]
    mov rdi, r14
    lea rdx, [rax+1]
    call    memmove
L651:
    cmp byte [rsp+1200], 0
    je  L652
    cmp byte [rsp+2224], 0
    jne L653
align 16
align 8
L652:
    mov esi, LC25
    mov rdi, r12
    call    strcmp
    test    eax, eax
    jne L1166
L605:
    mov rcx, r15
    mov edx, LC1
    mov esi, 96
    xor eax, eax
    lea r13, [rsp+1200]
    mov rdi, r13
    call    snprintf
    mov rdi, r13
    call    trim
    mov r14, rax
    cmp rax, r13
    je  L655
    mov rdi, rax
    call    strlen
    mov rsi, r14
    mov rdi, r13
    lea rdx, [rax+1]
    call    memmove
L655:
    mov byte [rsp+2224], 0
L653:
    mov esi, LC25
    mov rdi, r12
    call    strcmp
    test    eax, eax
    je  L656
    mov esi, LC24
    mov rdi, r12
    call    strcmp
    test    eax, eax
    jne L657
L656:
    lea rdi, [rsp+4304]
    mov rsi, r13
    call    get_value
    mov ecx, dword [rsp+4304]
    test    ecx, ecx
    jne L1167
    mov esi, LC25
    mov rdi, r12
    mov rbx, qword [rsp+4312]
    call    strcmp
    test    eax, eax
    jne L660
    mov  rax, 9223372036854775807
    cmp rbx, rax
    je  L661
    mov esi, LC24
    mov rdi, r12
    call    strcmp
    test    eax, eax
    jne L1145
    mov  rax, -9223372036854775808
    cmp rbx, rax
    je  L661
L1145:
    mov edx, 1
L663:
    lea rsi, [rsp+6384]
    xor eax, eax
    mov ecx, 130
    mov rdi, rsi
    rep stosq
    lea rax, [rbx+rdx]
    lea rdi, [rsp+5344]
    sub rsp, 1040
    mov qword [rsp+7432], rax
    mov ecx, 130
    rep movsq
    lea rsi, [rsp+6384]
L1153:
    mov rdi, rsp
    mov ecx, 130
    rep movsq
    mov rdi, r13
    call    set_value
    add rsp, 1040
    jmp L568
align 16
align 8
L1160:
    ; Save the full statement before probing the compact global form.
    ; Identifiers beginning with 'l' (for example list_push(...)) are not
    ; global assignments unless the parsed identifier is followed by '='.
    mov qword [rsp+10000], rcx
    lea r12, [rsp+4304]
    lea r14, [rcx+1]
    lea rdi, [rsp+3264]
    mov rsi, r12
    mov qword [rsp+3264], r14
    call    parse_identifier.constprop.0
    call    __ctype_b_loc
    mov rsi, qword [rsp+3264]
    mov rdi, qword [rax]
    movzx   eax, byte [rsi]
    mov rdx, rax
    test    byte [rdi+1+rax*2], 32
    je  L577
    lea rax, [rsi+1]
align 32
align 16
align 8
L578:
    movzx   ecx, byte [rax]
    mov rsi, rax
    add rax, 1
    mov rdx, rcx
    test    byte [rdi+1+rcx*2], 32
    jne L578
L577:
    cmp byte [rsp+4304], 0
    je  L579
    ; A lower-case identifier such as list_push(...) begins with the
    ; global marker byte, but '(' proves it is a normal function call.
    cmp dl, 40
    je  L1626
    cmp dl, 61
    jne L579
    cmp byte [rsi+1], 61
    je  L579
    lea r13, [rsp+5344]
    add rsi, 1
    lea rcx, [rsp+2224]
    mov rdx, rbx
    mov rdi, r13
    mov qword [rsp+3264], rsi
    call    parse_expression_text
    cmp byte [rsp+2224], 0
    jne L1168
L1152:
    mov byte [rel runtime_error], 1
    jmp L568
align 16
align 8
L657:
    lea r14, [rsp+3264]
    lea r15, [rsp+2224]
    mov rsi, rbx
    mov rdx, r14
    mov rdi, r15
    call    parse_asm_value
    test    al, al
    je  L1169
    mov esi, LC35
    mov rdi, r12
    call    strcmp
    test    eax, eax
    je  L1170
    mov esi, LC36
    mov rdi, r12
    call    strcmp
    test    eax, eax
    je  L1171
    lea rdi, [rsp+5344]
    mov rsi, r13
    call    get_value
    mov eax, dword [rsp+5344]
    or  eax, dword [rsp+3264]
    jne L1172
    mov esi, LC26
    mov rdi, r12
    mov r14, qword [rsp+3272]
    mov rbx, qword [rsp+5352]
    call    strcmp
    test    eax, eax
    jne L671
    add rbx, r14
    jo  L674
L679:
    lea rsi, [rsp+6384]
    mov ecx, 130
    xor eax, eax
    mov rdi, rsi
    rep stosq
    mov qword [rsp+6392], rbx
    lea rdi, [rsp+4304]
    sub rsp, 1040
    mov ecx, 130
    rep movsq
    lea rsi, [rsp+5344]
    jmp L1153
align 16
align 8
L1166:
    mov esi, LC24
    mov rdi, r12
    call    strcmp
    test    eax, eax
    je  L605
L654:
    mov rdi, qword [rel stderr]
    mov rdx, r12
    mov esi, LC56
    xor eax, eax
    call    fprintf
    mov byte [rel runtime_error], 1
    jmp L568
align 16
align 8
L1165:
    movzx   esi, byte [rsi+rcx]
    mov byte [rdi+rcx], sil
    jmp L649
align 16
align 8
L1164:
    movzx   r8d, word [rsi+rcx]
    mov word [rdi+rcx], r8w
    add rcx, 2
    jmp L648
align 16
align 8
L1163:
    mov ecx, dword [rsi]
    mov dword [rdi], ecx
    mov ecx, 4
    jmp L647
align 16
align 8
L1162:
    mov ecx, edx
    shr ecx, 3
    rep movsq
    jmp L646
align 16
align 8
L1167:
    mov rdi, qword [rel stderr]
    mov rdx, r12
    mov esi, LC57
    xor eax, eax
    call    fprintf
    mov byte [rel runtime_error], 1
    jmp L568
align 16
align 8
L1626:
    ; Re-enter ordinary statement dispatch with the original text.
    mov rcx, qword [rsp+10000]
    movzx r8d, byte [rcx]
    mov qword [rsp+1104], 0
    jmp L590
align 16
align 8
L579:
    mov edx, 64
    mov esi, 1
    mov edi, LC37
    mov rcx, qword [rel stderr]
    call    fwrite
    mov byte [rel runtime_error], 1
    jmp L568
align 16
align 8
L1161:
    mov rdi, rcx
    lea rdx, [rsp+1104]
    mov esi, LC26
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    movzx   r8d, byte [rsp+8]
    test    al, al
    je  L594
    mov r15, qword [rsp+1104]
    mov r12d, LC26
    jmp L592
align 16
align 8
L660:
    mov esi, LC24
    mov rdi, r12
    call    strcmp
    test    eax, eax
    jne L1144
    mov  rax, -9223372036854775808
    cmp rbx, rax
    jne L1144
L661:
    mov rdi, qword [rel stderr]
    mov rdx, r12
    mov esi, LC58
    xor eax, eax
    call    fprintf
    mov byte [rel runtime_error], 1
    jmp L568
align 16
align 8
L1144:
    mov rdx, -1
    jmp L663
L1172:
    mov rdi, qword [rel stderr]
    mov rdx, r12
    mov esi, LC61
    xor eax, eax
    call    fprintf
    mov byte [rel runtime_error], 1
    jmp L568
L594:
    mov rdi, rcx
    mov esi, LC27
    mov byte [rsp+8], r8b
    lea rdx, [rsp+1104]
    mov qword [rsp], rcx
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    movzx   r8d, byte [rsp+8]
    test    al, al
    je  L595
    mov r15, qword [rsp+1104]
    mov r12d, LC27
    jmp L592
L1171:
    sub rsp, 1040
    mov ecx, 130
    mov rsi, r14
    mov rdi, rsp
    rep movsq
    mov rdi, r13
    call    set_value
    add rsp, 1040
    jmp L568
L1169:
    mov rdi, qword [rel stderr]
    mov rcx, r12
    mov rdx, r15
    mov esi, LC59
    call    fprintf
    mov byte [rel runtime_error], 1
    jmp L568
L1170:
    lea r12, [rsp+6384]
    mov rsi, rbx
    mov rdi, r13
    mov rdx, r12
    call    parse_asm_value
    test    al, al
    je  L1173
    mov edi, asm_compare_left
    mov ecx, 130
    mov rsi, r12
    mov byte [rel asm_compare_valid], 1
    rep movsq
    mov edi, asm_compare_right
    mov ecx, 130
    mov rsi, r14
    rep movsq
    jmp L568
L1168:
    mov r15, qword [rel variable_count]
    lea rdi, [rsp+6384]
    mov ecx, 130
    mov rsi, r13
    mov qword [rsp], rdi
    rep movsq
    test    r15, r15
    je  L583
    mov ebx, variables
    xor r13d, r13d
align 16
align 8
L586:
    cmp byte [rbx+1136], 0
    je  L584
    mov rsi, r12
    mov rdi, rbx
    call    strcmp
    test    eax, eax
    je  L1174
L584:
    add r13, 1
    add rbx, 1152
    cmp r13, r15
    jne L586
L583:
    mov esi, 1
    mov rdi, r12
    call    get_variable.part.0
    test    rax, rax
    je  L1175
L585:
    mov rbx, qword [rel global_write_counter]
    mov rsi, qword [rsp]
    lea rdi, [rax+96]
    mov ecx, 130
    rep movsq
    mov byte [rax+1137], 1
    lea rdx, [rbx+1]
    mov qword [rel global_write_counter], rdx
    mov qword [rax+1144], rdx
    jmp L568
L676:
    mov esi, LC28
    mov rdi, r12
    call    strcmp
    test    eax, eax
    je  L680
    mov esi, LC29
    mov rdi, r12
    call    strcmp
    test    eax, eax
    je  L680
    mov esi, LC30
    mov rdi, r12
    call    strcmp
    test    eax, eax
    je  L684
    mov esi, LC31
    mov rdi, r12
    call    strcmp
    test    eax, eax
    je  L684
    mov esi, LC32
    mov rdi, r12
    call    strcmp
    test    eax, eax
    je  L1176
    mov esi, LC33
    mov rdi, r12
    call    strcmp
    test    eax, eax
    je  L1177
    mov esi, LC34
    mov rdi, r12
    or  rbx, r14
    call    strcmp
    test    eax, eax
    je  L679
L674:
    mov rdi, qword [rel stderr]
    mov rdx, r12
    mov esi, LC62
    xor eax, eax
    call    fprintf
    mov byte [rel runtime_error], 1
    jmp L568
L671:
    mov esi, LC27
    mov rdi, r12
    call    strcmp
    test    eax, eax
    jne L676
    sub rbx, r14
    jno L679
    jmp L674
align 16
align 8
L595:
    mov rdi, rcx
    mov esi, LC28
    mov byte [rsp+8], r8b
    lea rdx, [rsp+1104]
    mov qword [rsp], rcx
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    movzx   r8d, byte [rsp+8]
    test    al, al
    je  L596
    mov r15, qword [rsp+1104]
    mov r12d, LC28
    jmp L592
L1173:
    mov rdi, qword [rel stderr]
    mov rdx, r13
    mov esi, LC60
    call    fprintf
    mov byte [rel runtime_error], 1
    jmp L568
L1174:
    lea rax, [r13+0+r13*8]
    sal rax, 7
    add rax, variables
    jmp L585
L680:
    imul    rbx, r14
    jno L679
    jmp L674
align 16
align 8
L596:
    mov rdi, rcx
    mov esi, LC29
    mov byte [rsp+8], r8b
    lea rdx, [rsp+1104]
    mov qword [rsp], rcx
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    movzx   r8d, byte [rsp+8]
    test    al, al
    je  L597
    mov r15, qword [rsp+1104]
    mov r12d, LC29
    jmp L592
L1175:
    mov edx, 27
    mov esi, 1
    mov edi, LC3
    mov rcx, qword [rel stderr]
    call    fwrite
    mov byte [rel runtime_error], 1
    jmp L568
L684:
    test    r14, r14
    je  L674
    mov eax, 1
    sal rax, 63
    cmp rbx, rax
    jne L886
    cmp r14, -1
    je  L674
L886:
    mov rax, rbx
    cqo
    idiv    r14
    mov rbx, rax
    jmp L679
L597:
    mov rdi, rcx
    mov esi, LC30
    mov byte [rsp+8], r8b
    lea rdx, [rsp+1104]
    mov qword [rsp], rcx
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    movzx   r8d, byte [rsp+8]
    test    al, al
    je  L598
    mov r15, qword [rsp+1104]
    mov r12d, LC30
    jmp L592
L598:
    mov rdi, rcx
    mov esi, LC31
    mov byte [rsp+8], r8b
    lea rdx, [rsp+1104]
    mov qword [rsp], rcx
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    movzx   r8d, byte [rsp+8]
    test    al, al
    je  L599
    mov r15, qword [rsp+1104]
    mov r12d, LC31
    jmp L592
L1176:
    xor rbx, r14
    jmp L679
L1177:
    and rbx, r14
    jmp L679
L599:
    mov rdi, rcx
    mov esi, LC32
    mov byte [rsp+8], r8b
    lea rdx, [rsp+1104]
    mov qword [rsp], rcx
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    movzx   r8d, byte [rsp+8]
    test    al, al
    je  L600
    mov r15, qword [rsp+1104]
    mov r12d, LC32
    jmp L592
L600:
    mov rdi, rcx
    mov esi, LC33
    mov byte [rsp+8], r8b
    lea rdx, [rsp+1104]
    mov qword [rsp], rcx
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    movzx   r8d, byte [rsp+8]
    test    al, al
    je  L601
    mov r15, qword [rsp+1104]
    mov r12d, LC33
    jmp L592
L601:
    mov rdi, rcx
    mov esi, LC34
    mov byte [rsp+8], r8b
    lea rdx, [rsp+1104]
    mov qword [rsp], rcx
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    movzx   r8d, byte [rsp+8]
    test    al, al
    je  L602
    mov r15, qword [rsp+1104]
    mov r12d, LC34
    jmp L592
L602:
    mov rdi, rcx
    lea rdx, [rsp+1104]
    mov esi, LC25
    mov qword [rsp], rcx
    mov byte [rsp+8], r8b
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    test    al, al
    je  L1178
    mov r15, qword [rsp+1104]
    mov esi, 44
    mov rdi, r15
    call    strchr
    test    rax, rax
    je  L884
    mov rdx, rax
    sub rdx, r15
    je  L884
    mov r12d, LC25
    jmp L644
L1178:
    mov rdi, rcx
    lea rdx, [rsp+1104]
    mov esi, LC24
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    movzx   r8d, byte [rsp+8]
    test    al, al
    je  L604
    mov r15, qword [rsp+1104]
    mov esi, 44
    mov r12d, LC24
    mov rdi, r15
    call    strchr
    test    rax, rax
    jne L606
    jmp L605
L884:
    mov r12d, LC25
    jmp L605
L604:
    mov rdi, rcx
    mov esi, LC35
    mov byte [rsp+16], r8b
    lea rdx, [rsp+1104]
    mov qword [rsp], rcx
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    movzx   r8d, byte [rsp+16]
    test    al, al
    mov byte [rsp+8], al
    je  L607
    mov r15, qword [rsp+1104]
    mov r12d, LC35
    jmp L592
L607:
    mov rdi, rcx
    mov esi, LC38
    mov byte [rsp+16], r8b
    lea rdx, [rsp+1104]
    mov qword [rsp], rcx
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    movzx   r8d, byte [rsp+16]
    test    al, al
    je  L608
L610:
    xor r8d, r8d
    mov qword [rsp+16], rcx
    lea rbx, [rsp+5344]
    mov qword [rsp+5344], r8
    call    __ctype_b_loc
    mov qword [rsp], rbx
    mov rcx, qword [rsp+16]
    mov r12, rax
    xor eax, eax
    jmp L609
L1179:
    cmp rax, 7
    je  L612
    mov rbx, qword [rsp]
    mov byte [rbx+rax], dl
    add rax, 1
L609:
    movzx   edx, byte [rcx+rax]
    mov rsi, qword [r12]
    test    dl, dl
    je  L612
    movzx   edi, dl
    test    byte [rsi+1+rdi*2], 32
    je  L1179
L612:
    mov rax, qword [rsp+1104]
    jmp L615
L875:
    mov byte [rsp+8], 1
L615:
    mov rbx, rax
    lea rax, [rax+1]
    movzx   edx, byte [rbx]
    test    byte [rsi+1+rdx*2], 32
    jne L875
    cmp byte [rsp+8], 0
    je  L616
    mov qword [rsp+1104], rbx
L616:
    mov rdi, qword [rsp]
    mov esi, LC38
    call    strcmp
    test    eax, eax
    je  L617
    cmp byte [rel asm_compare_valid], 0
    je  L1180
    mov eax, dword [rel asm_compare_left]
    or  eax, dword [rel asm_compare_right]
    jne L1181
    mov rdi, qword [rsp]
    mov esi, LC39
    mov r15, qword [rel asm_compare_left + 8]
    mov rbp, qword [rel asm_compare_right + 8]
    call    strcmp
    test    eax, eax
    je  L621
    mov rdi, qword [rsp]
    mov esi, LC45
    call    strcmp
    test    eax, eax
    je  L621
    mov rdi, qword [rsp]
    mov esi, LC40
    call    strcmp
    test    eax, eax
    je  L624
    mov rdi, qword [rsp]
    mov esi, LC46
    call    strcmp
    test    eax, eax
    je  L624
    mov rdi, qword [rsp]
    mov esi, LC41
    call    strcmp
    test    eax, eax
    je  L1182
    mov rdi, qword [rsp]
    mov esi, LC42
    call    strcmp
    test    eax, eax
    je  L1183
    mov rdi, qword [rsp]
    mov esi, LC43
    call    strcmp
    test    eax, eax
    je  L1184
    mov rdi, qword [rsp]
    mov esi, LC44
    call    strcmp
    test    eax, eax
    jne L619
    cmp r15, rbp
    setle   al
L623:
    test    al, al
    je  L619
L617:
    lea rax, [rsp+6384]
    mov rcx, rbx
    mov edx, LC1
    mov esi, 96
    mov rbx, rax
    mov rdi, rax
    mov qword [rsp], rax
    xor eax, eax
    call    snprintf
    mov rdi, rbx
    call    trim_mut.isra.0
    mov rsi, r13
    mov rdi, rbx
    call    find_label
    mov rbp, rax
    cmp rax, r13
    jb  L1151
    xor esi, esi
    mov qword [rsp+4304], rsi
    call    __errno_location
    xor edi, edi
    lea rsi, [rsp+4304]
    xor edx, edx
    mov dword [rax], edi
    mov rdi, qword [rsp]
    mov rbx, rax
    call    strtoull
    mov rbp, rax
    jmp L631
L1186:
    movzx   ecx, byte [rax]
    mov rdx, qword [r12]
    test    byte [rdx+1+rcx*2], 32
    je  L1185
    add rax, 1
    mov qword [rsp+4304], rax
L631:
    mov rax, qword [rsp+4304]
    test    rax, rax
    jne L1186
    jmp L632
L608:
    mov rdi, rcx
    lea rdx, [rsp+1104]
    mov esi, LC39
    mov qword [rsp], rcx
    mov byte [rsp+16], r8b
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    test    al, al
    jne L610
    mov rdi, rcx
    lea rdx, [rsp+1104]
    mov esi, LC40
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    test    al, al
    jne L610
    mov rdi, rcx
    lea rdx, [rsp+1104]
    mov esi, LC41
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    test    al, al
    jne L610
    mov rdi, rcx
    lea rdx, [rsp+1104]
    mov esi, LC42
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    test    al, al
    jne L610
    mov rdi, rcx
    lea rdx, [rsp+1104]
    mov esi, LC43
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    test    al, al
    jne L610
    mov rdi, rcx
    lea rdx, [rsp+1104]
    mov esi, LC44
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    test    al, al
    jne L610
    mov rdi, rcx
    lea rdx, [rsp+1104]
    mov esi, LC45
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    test    al, al
    jne L610
    mov rdi, rcx
    lea rdx, [rsp+1104]
    mov esi, LC46
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    movzx   r8d, byte [rsp+16]
    test    al, al
    jne L610
    mov rdi, rcx
    mov esi, LC50
    mov byte [rsp+8], r8b
    lea rdx, [rsp+1104]
    mov qword [rsp], rcx
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    movzx   r8d, byte [rsp+8]
    test    al, al
    jne L1187
    mov rdi, rcx
    mov esi, LC53
    mov byte [rsp+8], r8b
    lea rdx, [rsp+1104]
    mov qword [rsp], rcx
    call    is_asm_mnemonic
    mov rcx, qword [rsp]
    movzx   r8d, byte [rsp+8]
    test    al, al
    je  L639
    test    rbx, rbx
    je  L640
    cmp byte [rbx], 0
    jne L641
L640:
    mov edx, 31
    mov esi, 1
    mov edi, LC54
    mov rcx, qword [rel stderr]
    call    fwrite
    mov byte [rel runtime_error], 1
    jmp L568
L639:
    lea rdx, [rsp+1104]
    mov esi, LC55
    mov rdi, rcx
    mov qword [rsp], rcx
    mov byte [rsp+8], r8b
    call    is_asm_mnemonic
    test    al, al
    jne L568
    movzx   r8d, byte [rsp+8]
    mov rcx, qword [rsp]
    cmp r8b, 71
    je  L887
    cmp r8b, 80
    je  L887
    cmp r8b, 111
    je  L1188
    cmp r8b, 85
    je  L1189
    lea eax, [r8-63]
    cmp al, 19
    ja  L739
    movzx   eax, al
    jmp qword [L741 + rax*8]
section .rodata
align 8
align 4
L741:
    dq L748
    dq L747
    dq L746
    dq L739
    dq L739
    dq L739
    dq L739
    dq L739
    dq L739
    dq L739
    dq L739
    dq L745
    dq L744
    dq L568
    dq L739
    dq L739
    dq L743
    dq L739
    dq L742
    dq L740
section .text
align 16
align 8
L739:
    cmp r8b, 68
    jne L697
    lea r12, [rcx+1]
    mov qword [rsp], rcx
    mov qword [rsp+4304], r12
    call    __ctype_b_loc
    mov rcx, qword [rsp]
    mov rsi, qword [rax]
    movzx   edx, byte [rcx+1]
    mov rax, rdx
    test    byte [rsi+1+rdx*2], 32
    je  L840
    add rcx, 2
align 32
align 16
align 8
L841:
    movzx   edx, byte [rcx]
    mov r12, rcx
    lea rcx, [rcx+1]
    mov rax, rdx
    test    byte [rsi+1+rdx*2], 32
    jne L841
    mov qword [rsp+4304], r12
L840:
    cmp al, 39
    je  L890
    cmp al, 34
    je  L890
    lea rdi, [rsp+6384]
    lea rcx, [rsp+3264]
    mov rdx, rbx
    mov rsi, r12
    call    parse_expression_text
    cmp byte [rsp+3264], 0
    je  L568
    cmp dword [rsp+6384], 0
    mov rax, qword [rsp+6392]
    jne L568
    test    rax, rax
    jle L568
    mov qword [rsp+5344], rax
    xor edx, edx
    lea rax, [rsp+5344]
    mov qword [rsp+5352], rdx
    mov qword [rsp], rax
    jmp L849
L1190:
    call    __errno_location
    cmp dword [rax], 4
    jne L568
L849:
    mov rsi, qword [rsp]
    mov rdi, rsi
    call    nanosleep
    test    eax, eax
    js  L1190
    jmp L568
align 16
align 8
L740:
    test    rbx, rbx
    je  L823
    cmp byte [rbx], 0
    jne L824
L823:
    mov edx, 29
    mov esi, 1
    mov edi, LC83
    mov rcx, qword [rel stderr]
    call    fwrite
    mov byte [rel runtime_error], 1
    jmp L568
L745:
    lea rbx, [rsp+6384]
    add rcx, 1
    lea rdi, [rsp+5344]
    mov rsi, rbx
    mov qword [rsp+5344], rcx
    call    parse_identifier.constprop.0
    mov rsi, r13
    mov rdi, rbx
    call    find_label
    cmp rax, r13
    jnb L1191
L821:
    lea rbp, [rax+1]
    jmp L568
L746:
    movzx   eax, byte [rcx+1]
    cmp al, 39
    je  L889
    cmp al, 34
    je  L889
align 16
align 8
L697:
    lea rax, [rsp+5344]
    lea r15, [rsp+3264]
    mov qword [rsp+8], rcx
    mov rsi, rax
    mov rdi, r15
    mov qword [rsp+3264], rcx
    mov qword [rsp], rax
    call    parse_identifier.constprop.0
    call    __ctype_b_loc
    mov r13, qword [rsp+3264]
    mov rcx, qword [rsp+8]
    mov r8, qword [rax]
    movzx   edx, byte [r13+0]
    test    byte [r8+1+rdx*2], 32
    mov rax, rdx
    je  L850
    lea rdx, [r13+1]
align 32
align 16
align 8
L851:
    movzx   esi, byte [rdx]
    mov r13, rdx
    lea rdx, [rdx+1]
    mov rax, rsi
    test    byte [r8+1+rsi*2], 32
    jne L851
    mov qword [rsp+3264], r13
L850:
    cmp byte [rsp+5344], 0
    je  L852
    cmp al, 40
    je  L1192
L852:
    mov rsi, qword [rsp]
    lea rdi, [rsp+4304]
    mov qword [rsp+16], r8
    mov qword [rsp+4304], rcx
    mov qword [rsp+8], rcx
    call    parse_identifier.constprop.0
    mov r8, qword [rsp+16]
    mov rcx, qword [rsp+8]
    mov rax, qword [rsp+4304]
    movzx   esi, byte [rax]
    test    byte [r8+1+rsi*2], 32
    mov rdx, rsi
    je  L866
align 32
align 16
align 8
L867:
    movzx   esi, byte [rax+1]
    add rax, 1
    mov rdx, rsi
    test    byte [r8+1+rsi*2], 32
    jne L867
L866:
    cmp byte [rsp+5344], 0
    je  L868
    cmp dl, 61
    je  L1193
L868:
    mov rdi, qword [rel stderr]
    mov r8, rcx
    mov esi, LC86
    mov rcx, r14
    lea rdx, [statements + r12 + 1024]
    xor eax, eax
    call    fprintf
    jmp L1152
L747:
    mov rsi, r13
    mov rdi, r15
    mov qword [rsp+8], rcx
    mov r15d, 10000000
    call    find_loop_end
    mov rcx, qword [rsp+8]
    mov qword [rsp], rax
    lea rsi, [rcx+1]
    cmp rax, r13
    jnb L1194
    mov r13, qword [rsp]
    mov r12, rsi
align 16
align 8
L790:
    cmp byte [rel quit_requested], 0
    jne L794
    cmp byte [rel runtime_error], 0
    jne L794
    lea rdi, [rsp+6384]
    mov qword [rsp+6384], r12
    mov qword [rsp+6400], 0
    mov qword [rsp+6392], rbx
    call    eval_condition
    mov ebp, eax
    call    __ctype_b_loc
    mov rcx, qword [rax]
    mov rax, qword [rsp+6384]
    movzx   edx, byte [rax]
    test    byte [rcx+1+rdx*2], 32
    je  L791
    add rax, 1
align 32
align 16
align 8
L792:
    mov rdx, rax
    mov qword [rsp+6384], rax
    add rax, 1
    movzx   edx, byte [rdx]
    test    byte [rcx+1+rdx*2], 32
    jne L792
L791:
    cmp byte [rsp+6400], 0
    jne L1148
    test    bpl, bpl
    je  L794
    mov rdx, rbx
    mov rsi, r13
    mov rdi, r14
    call    execute_range.isra.0
    test    rbx, rbx
    je  L796
    cmp byte [rbx+1], 0
    jne L794
L796:
    cmp r15, 1
    je  L1195
    sub r15, 1
    jmp L790
L748:
    lea rax, [rsp+6384]
    add rcx, 1
    mov qword [rsp+6400], 0
    mov rdi, rax
    mov qword [rsp+6384], rcx
    mov qword [rsp+6392], rbx
    mov qword [rsp], rax
    call    eval_condition
    mov byte [rsp+8], al
    call    __ctype_b_loc
    mov rsi, qword [rsp+6384]
    mov rdi, qword [rax]
    mov rcx, rax
    movzx   eax, byte [rsi]
    mov r8, rax
    test    byte [rdi+1+rax*2], 32
    je  L757
    lea rax, [rsi+1]
align 32
align 16
align 8
L758:
    mov qword [rsp+6384], rax
    movzx   edx, byte [rax]
    mov rsi, rax
    add rax, 1
    mov r8, rdx
    test    byte [rdi+1+rdx*2], 32
    jne L758
L757:
    cmp byte [rsp+6400], 0
    jne L1152
    test    r8b, r8b
    je  L1196
    cmp byte [rsp+8], 0
    je  L619
    cmp r8b, 71
    je  L888
    cmp r8b, 80
    je  L888
    cmp r8b, 74
    jne L568
    mov rbx, qword [rsp]
    add rsi, 1
    lea rdi, [rsp+3264]
    mov qword [rsp+3264], rsi
    mov rsi, rbx
    call    parse_identifier.constprop.0
    mov rsi, r13
    mov rdi, rbx
    call    find_label
    cmp rax, r13
    jb  L821
    mov rdx, qword [rsp]
L1155:
    mov rdi, qword [rel stderr]
    mov esi, LC74
    xor eax, eax
    call    fprintf
    mov byte [rel runtime_error], 1
    jmp L568
L743:
    mov rsi, r13
    mov rdi, r15
    mov qword [rsp], rcx
    call    find_loop_end
    mov rcx, qword [rsp]
    cmp rax, r13
    mov qword [rsp+8], rax
    jnb L1197
    lea rax, [rsp+5344]
    add rcx, 1
    lea rdi, [rsp+1104]
    mov rsi, rax
    mov qword [rsp+1104], rcx
    mov qword [rsp], rax
    call    parse_identifier.constprop.0
    cmp byte [rsp+5344], 0
    mov qword [rsp+1200], 0
    mov qword [rsp+2224], 0
    mov qword [rsp+4304], 1
    je  L802
    lea rsi, [rsp+1200]
    lea rdi, [rsp+1104]
    call    parse_range_atom.isra.0
    test    al, al
    je  L802
    lea rsi, [rsp+2224]
    lea rdi, [rsp+1104]
    call    parse_range_atom.isra.0
    test    al, al
    je  L802
    call    __ctype_b_loc
    mov rsi, qword [rax]
    mov rax, qword [rsp+1104]
    movzx   ecx, byte [rax]
    mov rdx, rcx
    test    byte [rsi+1+rcx*2], 32
    je  L803
    add rax, 1
L804:
    movzx   ecx, byte [rax]
    mov rdi, rax
    add rax, 1
    mov rdx, rcx
    test    byte [rsi+1+rcx*2], 32
    jne L804
    mov qword [rsp+1104], rdi
L803:
    mov rax, qword [rsp+8]
    add rax, 1
    mov qword [rsp+16], rax
    test    dl, dl
    jne L1198
    mov rax, qword [rsp+2224]
    mov r12, qword [rsp+1200]
    mov r15d, 1
    mov r13d, 10000000
    mov rbp, rax
    jmp L809
L1200:
    mov  rax, 9223372036854775807
    sub rax, r15
    cmp rax, r12
    jl  L815
    add r12, r15
    mov rax, rbp
L809:
    cmp rax, r12
    jle L808
L818:
    cmp byte [rel quit_requested], 0
    jne L808
    cmp byte [rel runtime_error], 0
    jne L808
    lea rsi, [rsp+6384]
    xor eax, eax
    mov ecx, 130
    mov rdi, rsi
    rep stosq
    mov qword [rsp+6392], r12
    lea rdi, [rsp+3264]
    mov ecx, 130
    sub rsp, 1040
    rep movsq
    lea rsi, [rsp+4304]
    mov rdi, rsp
    mov ecx, 130
    rep movsq
    mov rdi, qword [rsp+1040]
    call    set_value
    mov rsi, qword [rsp+1048]
    mov rdx, rbx
    mov rdi, r14
    add rsp, 1040
    call    execute_range.isra.0
    test    rbx, rbx
    je  L811
    cmp byte [rbx+1], 0
    jne L808
L811:
    sub r13, 1
    je  L1199
    test    r15, r15
    jg  L1200
    mov  rax, -9223372036854775808
    sub rax, r15
    cmp rax, r12
    jg  L815
    add r12, r15
L810:
    cmp rbp, r12
    jl  L818
L808:
    mov rbp, qword [rsp+16]
    jmp L568
L744:
    add rcx, 1
    lea r12, [rsp+4304]
    xor eax, eax
    mov qword [rsp+1200], rcx
    mov rdi, r12
    mov ecx, 128
    lea r15, [rsp+3264]
    rep stosq
    lea r13, [rsp+1200]
    mov rsi, r15
    mov rdi, r13
    call    parse_identifier.constprop.0
    cmp byte [rsp+3264], 0
    je  L749
    call    __ctype_b_loc
    mov rsi, qword [rax]
    mov rax, qword [rsp+1200]
    movzx   ecx, byte [rax]
    mov rdx, rcx
    test    byte [rsi+1+rcx*2], 32
    je  L750
    add rax, 1
align 32
align 16
align 8
L751:
    movzx   ecx, byte [rax]
    mov rdi, rax
    add rax, 1
    mov rdx, rcx
    test    byte [rsi+1+rcx*2], 32
    jne L751
    mov qword [rsp+1200], rdi
L750:
    cmp dl, 39
    je  L753
    cmp dl, 34
    je  L753
L754:
    lea rbx, [rsp+5344]
    mov rdx, qword [rel stdin]
    mov esi, 1024
    mov rdi, rbx
    mov qword [rsp], rbx
    call    fgets
    test    rax, rax
    je  L568
    mov rdi, rbx
    call    strlen
    test    rax, rax
    je  L756
    cmp byte [rsp+5343+rax], 10
    jne L756
    mov byte [rsp+5343+rax], 0
L756:
    lea rbx, [rsp+6384]
    xor eax, eax
    mov ecx, 130
    mov edx, LC1
    mov rdi, rbx
    mov esi, 1024
    rep stosq
    mov rcx, qword [rsp]
    lea rdi, [rsp+6400]
    mov dword [rsp+6384], 1
    call    snprintf
    lea rdi, [rsp+2224]
    mov ecx, 130
    mov rsi, rbx
    rep movsq
    sub rsp, 1040
    mov ecx, 130
    lea rsi, [rsp+3264]
    mov rdi, rsp
    rep movsq
    mov rdi, r15
    call    set_value
    add rsp, 1040
    jmp L568
L742:
    mov byte [rel quit_requested], 1
    jmp L568
align 16
align 8
L1188:
    movzx   r13d, byte [rcx+1]
    cmp r13b, 39
    je  L696
    cmp r13b, 34
    je  L696
    mov qword [rsp], rcx
    call    __ctype_b_loc
    mov rcx, qword [rsp]
    mov rax, qword [rax]
    test    byte [rax+1+r13*2], 32
    je  L697
L696:
    lea rbx, [rsp+6384]
    add rcx, 1
    mov edx, 1024
    lea rdi, [rsp+5344]
    mov rsi, rbx
    mov qword [rsp+5344], rcx
    call    parse_quoted
    test    al, al
    jne L698
    mov edx, 58
    mov esi, 1
    mov edi, LC64
    mov rcx, qword [rel stderr]
    call    fwrite
    mov byte [rel runtime_error], 1
    jmp L568
align 16
align 8
L1189:
    movzx   r13d, byte [rcx+1]
    cmp r13b, 39
    je  L701
    cmp r13b, 34
    je  L701
    mov qword [rsp], rcx
    call    __ctype_b_loc
    mov rcx, qword [rsp]
    mov rax, qword [rax]
    test    byte [rax+1+r13*2], 32
    je  L697
L701:
    lea r13, [rsp+1200]
    add rcx, 1
    mov edx, 1024
    lea rdi, [rsp+1096]
    mov rsi, r13
    mov qword [rsp+1096], rcx
    call    parse_quoted
    mov ebx, eax
    test    al, al
    jne L702
    mov edx, 53
    mov esi, 1
    mov edi, LC66
    mov rcx, qword [rel stderr]
    call    fwrite
    mov byte [rel runtime_error], 1
    jmp L568
L887:
    lea rax, [rsp+3264]
    lea rsi, [rcx+1]
    mov rdx, rbx
    mov byte [rsp], r8b
    lea r12, [rsp+5344]
    mov rcx, rax
    mov rdi, r12
    call    parse_expression_text
    cmp byte [rsp+3264], 0
    movzx   r8d, byte [rsp]
    je  L568
    lea rdi, [rsp+6384]
    mov ecx, 130
    mov rsi, r12
    rep movsq
    cmp dword [rsp+6384], 2
    jne COLLECTION_PRINT_NOT_HANDLE
    lea rdi, [rsp+6384]
    xor esi, esi
    xor edx, edx
    call collection_print_value
    movzx r8d, byte [rsp]
    cmp r8b, 71
    jne L568
    mov rsi, qword [rel stdout]
    mov edi, 10
    call fputc
    jmp L568
COLLECTION_PRINT_NOT_HANDLE:
    cmp dword [rsp+6384], 1
    je  L1157
    mov byte [rsp], r8b
    mov rcx, qword [rsp+6392]
    mov edx, LC63
    lea r12, [rsp+4304]
L1147:
    mov esi, 1024
    mov rdi, r12
    xor eax, eax
    call    snprintf
    mov rsi, qword [rel stdout]
    mov rdi, r12
    call    fputs
    movzx   r8d, byte [rsp]
    cmp r8b, 71
    jne L568
    mov rsi, qword [rel stdout]
    mov edi, 10
    call    fputc
    jmp L568
L698:
    mov rdi, rbx
    call    system
    cmp eax, -1
    jne L568
    jmp L1116
align 16
align 8
L702:
    mov esi, 47
    mov rdi, r13
    call    strrchr
    lea rsi, [rax+1]
    test    rax, rax
    cmove   rsi, r13
    mov rdi, rsi
    mov r15, rsi
    call    strlen
    mov r14, rax
    cmp rax, 95
    jbe L705
    movdqu  xmm0, oword [r15]
    mov byte [rsp+1199], 0
    mov r14d, 91
    movaps  oword [rsp+1104], xmm0
    movdqu  xmm0, oword [r15+16]
    movaps  oword [rsp+1120], xmm0
    movdqu  xmm0, oword [r15+32]
    movaps  oword [rsp+1136], xmm0
    movdqu  xmm0, oword [r15+48]
    movaps  oword [rsp+1152], xmm0
    movdqu  xmm0, oword [r15+64]
    movaps  oword [rsp+1168], xmm0
    movdqu  xmm0, oword [r15+79]
    movups  oword [rsp+1183], xmm0
L706:
    lea rax, [rsp+1104]
    mov esi, LC10
    add r14, rax
    mov rdi, r14
    call    strcmp
    test    eax, eax
    jne L708
    mov byte [r14], 0
L708:
    mov r15, qword [rel imported_module_count]
    test    r15, r15
    je  L710
    xor r14d, r14d
align 16
align 8
L712:
    lea rdi, [r14+r14*2]
    lea rsi, [rsp+1104]
    sal rdi, 5
    add rdi, imported_modules
    call    strcmp
    test    eax, eax
    je  L568
    add r14, 1
    cmp r15, r14
    jne L712
L710:
    mov rdi, r13
    lea r14, [rsp+2224]
    call    strlen
    cmp rax, 3
    jbe L714
    lea rdi, [r13-4+rax]
    mov esi, LC10
    call    strcmp
    test    eax, eax
    jne L714
    mov rsi, r13
    mov rdi, r14
    call    candidate.constprop.0
    test    al, al
    jne L727
    mov rdi, r13
    call    strlen
    lea rdi, [rsp+5344]
    mov rsi, r13
    mov qword [rsp], rdi
    cmp eax, 8
    jb  L721
    mov ecx, eax
    shr ecx, 3
    rep movsq
L721:
    xor edx, edx
    test    al, 4
    je  L722
    mov edx, dword [rsi]
    mov dword [rdi], edx
    mov edx, 4
L722:
    test    al, 2
    je  L723
    movzx   ecx, word [rsi+rdx]
    mov word [rdi+rdx], cx
    add rdx, 2
L723:
    test    al, 1
    je  L724
    movzx   ecx, byte [rsi+rdx]
    mov byte [rdi+rdx], cl
L724:
    mov byte [rsp+5344+rax], 0
    mov rdx, qword [rsp]
    mov esi, LC67
    lea r15, [rsp+3264]
    mov rdi, r15
    call    safe_join.part.0.constprop.0
    mov rsi, r15
    mov rdi, r14
    call    candidate.constprop.0
    test    al, al
    jne L727
    mov rdx, qword [rsp]
    mov esi, LC68
    mov rdi, r15
    call    safe_join.part.0.constprop.0
    mov rsi, r15
    mov rdi, r14
    call    candidate.constprop.0
    test    al, al
    jne L727
L728:
    lea rax, [statements + r12 + 1024]
    mov esi, 47
    mov rdi, rax
    mov r12, rax
    call    strchr
    test    rax, rax
    je  L737
    mov rdi, r12
    mov qword [rsp+8], r12
    lea r12, [rsp+4304]
    call    strlen
    mov edx, 1023
    mov rsi, qword [rsp+8]
    mov rdi, r12
    cmp rax, rdx
    cmova   rax, rdx
    cmp eax, 8
    jb  L730
    mov ecx, eax
    shr ecx, 3
    rep movsq
L730:
    xor edx, edx
    test    al, 4
    je  L731
    mov edx, dword [rsi]
    mov dword [rdi], edx
    mov edx, 4
L731:
    test    al, 2
    je  L732
    movzx   ecx, word [rsi+rdx]
    mov word [rdi+rdx], cx
    add rdx, 2
L732:
    test    al, 1
    je  L733
    movzx   ecx, byte [rsi+rdx]
    mov byte [rdi+rdx], cl
L733:
    mov byte [rsp+4304+rax], 0
    mov esi, 47
    mov rdi, r12
    call    strrchr
    test    rax, rax
    je  L734
    mov byte [rax], 0
L735:
    mov rsi, r12
    mov rdi, r15
    mov rdx, r13
    call    safe_join.part.0.constprop.0
    mov rsi, r15
    mov rdi, r14
    call    candidate.constprop.0
    test    al, al
    jne L727
    test    bl, bl
    je  L1201
L737:
    mov rdi, qword [rel stderr]
    mov rdx, r13
    mov esi, LC71
    xor eax, eax
    call    fprintf
    mov byte [rel runtime_error], 1
    jmp L568
L1195:
    mov edx, 44
    mov esi, 1
    mov edi, LC76
    mov rcx, qword [rel stderr]
    call    fwrite
L1148:
    mov byte [rel runtime_error], 1
L794:
    mov rbp, qword [rsp]
L1151:
    add rbp, 1
    jmp L568
L802:
    mov edx, 44
    mov esi, 1
    mov edi, LC78
    mov rcx, qword [rel stderr]
    call    fwrite
    mov rbp, qword [rsp+8]
    mov byte [rel runtime_error], 1
    add rbp, 1
    jmp L568
L705:
    mov rdx, rax
    mov rsi, r15
    lea rdi, [rsp+1104]
    call    memcpy
    mov byte [rsp+1104+r14], 0
    cmp r14, 3
    jbe L708
    sub r14, 4
    jmp L706
L1157:
    lea rcx, [rsp+6400]
    lea r12, [rsp+4304]
    mov edx, LC1
    jmp L1147
L890:
    lea r14, [rsp+6384]
    lea rdi, [rsp+4304]
    mov edx, 96
    mov rsi, r14
    call    parse_quoted
    test    al, al
    je  L568
    mov r13, qword [rel variable_count]
    test    r13, r13
    je  L568
    mov r12d, variables
    xor ebx, ebx
    jmp L846
align 32
align 16
align 8
L845:
    add rbx, 1
    add r12, 1152
    cmp rbx, r13
    je  L568
L846:
    cmp byte [r12+1136], 0
    je  L845
    mov rsi, r14
    mov rdi, r12
    call    strcmp
    test    eax, eax
    jne L845
    movsx   rax, ebx
    imul    rax, rax, 1152
    mov byte [variables + rax + 1136], 0
    jmp L568
L1197:
    mov rdi, qword [rel stderr]
    mov rcx, r14
    mov esi, LC77
    xor eax, eax
    lea rdx, [statements + r12 + 1024]
    call    fprintf
    mov byte [rel runtime_error], 1
    jmp L568
L714:
    mov rsi, r13
    mov rdi, r14
    call    candidate.constprop.0
    test    al, al
    jne L727
    lea rax, [rsp+5344]
    mov rsi, r13
    mov rbx, rax
    mov rdi, rax
    mov qword [rsp], rax
    call    safe_suffix.part.0.constprop.0
    mov rsi, rbx
    mov rdi, r14
    call    candidate.constprop.0
    test    al, al
    jne L727
    lea r15, [rsp+3264]
    mov rdx, qword [rsp]
    mov esi, LC67
    mov rdi, r15
    call    safe_join.part.0.constprop.0
    mov rsi, r15
    mov rdi, r14
    call    candidate.constprop.0
    test    al, al
    jne L727
    lea rbx, [rsp+4304]
    mov rsi, r13
    mov rdi, rbx
    call    safe_suffix.part.0.constprop.0
    mov esi, LC67
    mov rdi, r15
    mov rdx, rbx
    call    safe_join.part.0.constprop.0
    mov rsi, r15
    mov rdi, r14
    call    candidate.constprop.0
    test    al, al
    jne L727
    mov rdx, rbx
    mov esi, LC68
    mov rdi, r15
    call    safe_join.part.0.constprop.0
    mov rsi, r15
    mov rdi, r14
    call    candidate.constprop.0
    mov ebx, eax
    test    al, al
    je  L728
L727:
    lea rsi, [rsp+1104]
    mov rdi, r14
    call    load_source
    test    al, al
    je  L1202
    mov rax, qword [rel imported_module_count]
    cmp rax, 255
    ja  L568
    lea rdx, [rax+1]
    lea rcx, [rsp+1104]
    mov esi, 96
    imul    rax, rax, 96
    mov qword [rel imported_module_count], rdx
    mov edx, LC1
    lea rdi, [imported_modules + rax]
    xor eax, eax
    call    snprintf
    jmp L568
L749:
    mov edx, 32
    mov esi, 1
    mov edi, LC73
    mov rcx, qword [rel stderr]
    call    fwrite
    mov byte [rel runtime_error], 1
    jmp L568
L1194:
    mov rdi, qword [rel stderr]
    mov rcx, r14
    mov esi, LC75
    xor eax, eax
    lea rdx, [statements + r12 + 1024]
    call    fprintf
    mov byte [rel runtime_error], 1
    jmp L568
L1191:
    mov rdx, rbx
    jmp L1155
L889:
    lea rax, [rsp+5344]
    add rcx, 1
    mov edx, 96
    lea rdi, [rsp+4304]
    mov rsi, rax
    mov qword [rsp+4304], rcx
    mov qword [rsp], rax
    call    parse_quoted
    test    al, al
    je  L1152
    call    __ctype_b_loc
    mov rdi, qword [rax]
    mov rax, qword [rsp+4304]
    movzx   ecx, byte [rax]
    mov rdx, rcx
    test    byte [rdi+1+rcx*2], 32
    je  L830
    lea rcx, [rax+1]
L831:
    movzx   esi, byte [rcx]
    mov rax, rcx
    lea rcx, [rcx+1]
    mov rdx, rsi
    test    byte [rdi+1+rsi*2], 32
    jne L831
    mov qword [rsp+4304], rax
L830:
    cmp dl, 43
    jne L833
    add rax, 1
    mov qword [rsp+4304], rax
L833:
    mov rsi, qword [rsp+4304]
    lea rdi, [rsp+6384]
    lea rcx, [rsp+3264]
    mov rdx, rbx
    call    parse_expression_text
    mov r14, qword [rel variable_count]
    mov r12d, dword [rsp+6384]
    test    r14, r14
    je  L834
    mov r15, qword [rsp]
    mov r13d, variables
    xor ebx, ebx
L837:
    cmp byte [r13+1136], 0
    je  L835
    mov rsi, r15
    mov rdi, r13
    call    strcmp
    test    eax, eax
    je  L1203
L835:
    add rbx, 1
    add r13, 1152
    cmp rbx, r14
    jne L837
L834:
    mov rdi, qword [rsp]
    mov esi, 1
    call    get_variable.part.0
    mov rbx, rax
L836:
    cmp byte [rsp+3264], 0
    je  L1152
    test    rbx, rbx
    je  L838
    test    r12d, r12d
    jne L1152
    cmp dword [rbx+96], 0
    jne L1204
L839:
    mov rax, qword [rsp+6392]
    add qword [rbx+104], rax
    jmp L568
align 16
align 8
L824:
    lea rax, [rsp+5344]
    lea r12, [rsp+6384]
    mov rdx, rbx
    lea rsi, [rcx+1]
    mov rdi, r12
    mov rcx, rax
    call    parse_expression_text
    cmp byte [rsp+5344], 0
    lea rdi, [rbx+8]
    je  L826
    mov ecx, 130
    mov rsi, r12
    rep movsq
L827:
    mov byte [rbx+1], 1
    jmp L568
L753:
    mov edx, 1024
    mov rsi, r12
    mov rdi, r13
    call    parse_quoted
    test    al, al
    je  L754
    mov rsi, qword [rel stdout]
    mov rdi, r12
    call    fputs
    mov rdi, qword [rel stdout]
    call    fflush
    jmp L754
L1196:
    cmp r14, r13
    jnb L1205
    lea rdx, [statements + r12 + 2048]
    mov qword [rsp+16], r15
    mov r12, rbx
    xor ebp, ebp
    mov qword [rsp+32], rcx
    mov r15, r13
    mov rbx, rdx
    mov qword [rsp+24], r14
    jmp L785
L1208:
    cmp byte [rcx+1], 0
    jne L782
    test    ebp, ebp
    jne L780
    cmp r13, r15
    cmove   r15, r14
L780:
    add r14, 1
    add rbx, 2048
    cmp r14, r13
    jnb L1206
L785:
    mov rdi, rbx
    call    trim
    cmp byte [rax], 63
    mov rcx, rax
    je  L1207
L777:
    movzx   eax, byte [rcx]
    cmp eax, 58
    je  L1208
L782:
    cmp eax, 59
    jne L780
    cmp byte [rcx+1], 0
    jne L780
    test    ebp, ebp
    je  L784
    sub ebp, 1
    jmp L780
L1207:
    cmp byte [rbx], 63
    jne L777
    mov rdi, qword [rsp]
    mov qword [rsp+40], rax
    lea rax, [rbx+1]
    mov qword [rsp+6384], rax
    mov qword [rsp+6392], r12
    mov qword [rsp+6400], 256
    call    eval_condition
    mov rax, qword [rsp+32]
    mov rcx, qword [rsp+40]
    mov r9, qword [rax]
    mov rax, qword [rsp+6384]
    movzx   r8d, byte [rax]
    test    byte [r9+1+r8*2], 32
    mov rdi, r8
    je  L778
L779:
    add rax, 1
    mov qword [rsp+6384], rax
    movzx   edx, byte [rax]
    mov rdi, rdx
    test    byte [r9+1+rdx*2], 32
    jne L779
L778:
    test    dil, dil
    jne L777
    add ebp, 1
    jmp L780
L1192:
    test    rbx, rbx
    je  L881
    lea rsi, [rbx+1048]
L853:
    mov rdi, qword [rsp]
    call    find_function
    mov r14d, eax
    test    eax, eax
    js  L1209
    lea r12, [rsp+4304]
    xor eax, eax
    add r13, 1
    mov qword [rsp+4312], rbx
    mov rdi, r12
    mov qword [rsp+4320], rax
    xor r15d, r15d
    lea rbx, [rsp+48]
    mov qword [rsp+4304], r13
    call    parser_space
    mov rdx, qword [rsp+4304]
    xor eax, eax
    cmp byte [rdx], 41
    je  L857
L856:
    cmp byte [rsp+4320], 0
    jne L1149
    cmp eax, 16
    je  L1210
    lea r15d, [rax+1]
    mov rsi, r12
    mov rdi, rbx
    imul    rax, rax, 1040
    lea r13, [rsp+6384+rax]
    call    eval_expr
    mov ecx, 130
    mov rdi, r13
    mov rsi, rbx
    rep movsq
    mov rdi, r12
    call    parser_space
    mov rax, qword [rsp+4304]
    cmp byte [rax], 44
    je  L1211
    cmp byte [rax], 41
    je  L857
L859:
    mov byte [rsp+4320], 1
L860:
    mov rdx, qword [rsp]
    mov rdi, qword [rel stderr]
    mov esi, LC85
    xor eax, eax
    call    fprintf
    jmp L1152
L1206:
    mov r15, qword [rsp+16]
    mov r14, qword [rsp+24]
    mov rbx, r12
L786:
    cmp byte [rsp+8], 0
    lea rbp, [r15+2]
    jne L1212
L873:
    cmp r13, rbp
    cmovbe  rbp, r13
    jmp L568
L1193:
    cmp byte [rax+1], 61
    je  L868
    lea r12, [rsp+6384]
    lea rsi, [rax+1]
    mov rcx, r15
    mov rdx, rbx
    mov rdi, r12
    mov qword [rsp+4304], rsi
    call    parse_expression_text
    cmp byte [rsp+3264], 0
    je  L1152
    sub rsp, 1040
    mov ecx, 130
    mov rsi, r12
    mov rdi, rsp
    rep movsq
    mov rdi, qword [rsp+1040]
    call    set_value
    add rsp, 1040
    jmp L568
L826:
    xor esi, esi
    call    number_value
    jmp L827
L1203:
    imul    rbx, rbx, 1152
    add rbx, variables
    jmp L836
L784:
    mov rbx, r12
    mov r12, r14
    mov rsi, r15
    mov r14, qword [rsp+24]
    mov r15, qword [rsp+16]
    cmp r12, r13
    jnb L786
    cmp byte [rsp+8], 0
    jne L1213
    cmp rsi, r12
    jb  L1214
L789:
    lea rbp, [r12+1]
    jmp L568
L888:
    lea r12, [rsp+5344]
    add rsi, 1
    mov rdx, rbx
    mov byte [rsp+8], r8b
    lea rcx, [rsp+2224]
    mov rdi, r12
    mov qword [rsp+3264], rsi
    call    parse_expression_text
    cmp byte [rsp+2224], 0
    movzx   r8d, byte [rsp+8]
    je  L568
    mov rdi, qword [rsp]
    mov ecx, 130
    mov rsi, r12
    mov byte [rsp], r8b
    rep movsq
    cmp dword [rsp+6384], 1
    je  L1157
    mov rcx, qword [rsp+6392]
    lea r12, [rsp+4304]
    mov edx, LC63
    jmp L1147
L1202:
    mov rdi, qword [rel stderr]
    mov rdx, r14
    mov esi, LC72
    call    fprintf
    mov byte [rel runtime_error], 1
    jmp L568
L857:
    cmp byte [rsp+4320], 0
    jne L860
    lea rdi, [rsp+48]
    lea rdx, [rsp+6384]
    mov ecx, r15d
    mov esi, r14d
    call    invoke_function.isra.0
    jmp L568
L1209:
    mov rdx, qword [rsp]
    mov rdi, qword [rel stderr]
    mov esi, LC84
    xor eax, eax
    call    fprintf
    mov byte [rel runtime_error], 1
    jmp L568
L881:
    mov esi, LC18
    jmp L853
L1212:
    mov rdx, rbx
    mov rsi, rbp
    mov rdi, r14
    call    execute_range.isra.0
    jmp L873
L1211:
    add rax, 1
    mov qword [rsp+4304], rax
    movsx   rax, r15d
    jmp L856
L1214:
    lea rdi, [rsi+1]
    mov rdx, rbx
    mov rsi, r12
    call    execute_range.isra.0
    jmp L789
L1213:
    cmp r12, rsi
    mov rdx, rbx
    mov rdi, r14
    cmovbe  rsi, r12
    call    execute_range.isra.0
    jmp L789
L1198:
    lea rsi, [rsp+4304]
    lea rdi, [rsp+1104]
    call    parse_range_atom.isra.0
    test    al, al
    je  L1215
    mov r15, qword [rsp+4304]
    test    r15, r15
    jne L807
    mov edx, 34
    mov esi, 1
    mov edi, LC80
    mov rcx, qword [rel stderr]
    call    fwrite
    mov byte [rel runtime_error], 1
    jmp L808
L838:
    test    r12d, r12d
    je  L568
    jmp L1152
L815:
    mov edx, 23
    mov esi, 1
    mov edi, LC82
    mov rcx, qword [rel stderr]
    call    fwrite
    mov byte [rel runtime_error], 1
    jmp L808
L807:
    mov r12, qword [rsp+1200]
    mov rbp, qword [rsp+2224]
    jg  L880
    mov r13d, 10000000
    jmp L810
L1187:
    lea rax, [rsp+5344]
    mov edx, LC1
    mov esi, 96
    mov rcx, qword [rsp+1104]
    mov rdi, rax
    mov qword [rsp], rax
    mov r14, rax
    xor eax, eax
    call    snprintf
    mov rdi, r14
    call    trim_mut.isra.0
    test    rbx, rbx
    je  L876
    lea rsi, [rbx+1048]
L636:
    mov rbx, qword [rsp]
    mov rdi, rbx
    call    find_function
    mov esi, eax
    test    eax, eax
    js  L1216
    lea rbx, [rsp+6384]
    xor ecx, ecx
    xor edx, edx
    mov rdi, rbx
    call    invoke_function.isra.0
    sub rsp, 1040
    mov ecx, 130
    mov rsi, rbx
    mov rdi, rsp
    rep movsq
    mov edi, LC52
    call    set_value
    add rsp, 1040
    jmp L568
L641:
    lea r12, [rsp+48]
    mov esi, LC52
    mov rdi, r12
    call    get_value
    lea rdi, [rbx+8]
    mov ecx, 130
    mov rsi, r12
    rep movsq
    mov byte [rbx+1], 1
    jmp L568
L880:
    mov rax, rbp
    mov r13d, 10000000
    jmp L809
L1216:
    mov rdi, qword [rel stderr]
    mov rdx, rbx
    mov esi, LC51
    xor eax, eax
    call    fprintf
    mov byte [rel runtime_error], 1
    jmp L568
L876:
    mov esi, LC18
    jmp L636
L1185:
    cmp dword [rbx], 0
    jne L632
    mov rbx, qword [rsp]
    cmp rax, rbx
    je  L632
    cmp byte [rax], 0
    jne L632
    cmp rbp, r13
    jb  L568
L632:
    mov rdx, qword [rsp]
    mov rdi, qword [rel stderr]
    mov esi, LC49
    xor eax, eax
    call    fprintf
    mov byte [rel runtime_error], 1
    jmp L619
L1199:
    mov edx, 45
    mov esi, 1
    mov edi, LC81
    mov rcx, qword [rel stderr]
    call    fwrite
    mov byte [rel runtime_error], 1
    jmp L808
L1215:
    mov edx, 27
    mov esi, 1
    mov edi, LC79
    mov rcx, qword [rel stderr]
    call    fwrite
    mov byte [rel runtime_error], 1
    jmp L808
L1210:
    mov byte [rsp+4320], 1
L1149:
    mov rax, qword [rsp+4304]
    cmp byte [rax], 41
    jne L859
    jmp L860
L1205:
    lea rbp, [r15+2]
    jmp L873
L1204:
    lea rdi, [rbx+112]
    xor esi, esi
    mov edx, 10
    call    strtoll
    lea rdi, [rbx+96]
    mov rsi, rax
    call    number_value
    jmp L839
L1201:
    mov rdx, qword [rsp]
    mov rsi, r12
    mov rdi, r15
    call    safe_join.part.0.constprop.0
    mov rsi, r15
    mov rdi, r14
    call    candidate.constprop.0
    test    al, al
    jne L727
    lea rbx, [rsp+6384]
    mov edx, LC67
    mov rsi, r12
    mov rdi, rbx
    call    safe_join.part.0.constprop.0
    mov rdx, qword [rsp]
    mov rsi, rbx
    mov rdi, r15
    call    safe_join.part.0.constprop.0
    mov rsi, r15
    mov rdi, r14
    call    candidate.constprop.0
    test    al, al
    jne L727
    mov edx, LC69
    mov rsi, r12
    mov rdi, rbx
    call    safe_join.part.0.constprop.0
    mov rdx, qword [rsp]
    mov rsi, rbx
    mov rdi, r15
    call    safe_join.part.0.constprop.0
    mov rsi, r15
    mov rdi, r14
    call    candidate.constprop.0
    test    al, al
    jne L727
    mov edx, LC70
    mov rsi, r12
    mov rdi, rbx
    call    safe_join.part.0.constprop.0
    mov rdx, qword [rsp]
    mov rsi, rbx
    mov rdi, r15
    call    safe_join.part.0.constprop.0
    mov rsi, r15
    mov rdi, r14
    call    candidate.constprop.0
    test    al, al
    je  L737
    jmp L727
L734:
    mov byte [rsp+4304], 0
    jmp L735
L1184:
    cmp r15, rbp
    setl    al
    jmp L623
L1183:
    cmp r15, rbp
    setge   al
    jmp L623
L1182:
    cmp r15, rbp
    setg    al
    jmp L623
L624:
    cmp r15, rbp
    setne   al
    jmp L623
L621:
    cmp r15, rbp
    sete    al
    jmp L623
L1181:
    mov edx, 54
    mov esi, 1
    mov edi, LC48
    mov rcx, qword [rel stderr]
    call    fwrite
    mov byte [rel runtime_error], 1
    jmp L619
L1180:
    mov rdx, qword [rsp]
    mov rdi, qword [rel stderr]
    mov esi, LC47
    xor eax, eax
    call    fprintf
    mov byte [rel runtime_error], 1
    jmp L619
section .text
    execute_statement.cold:
LFSB72:
L1116:
    mov edi, LC65
    call    perror
    mov byte [rel runtime_error], 1
    jmp L568
LFE72:
section .text
section .text
LCOLDE87:
section .text
LHOTE87:
section .rodata
align 8
LC88:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x69, 0x6e, 0x74, 0x65, 0x72, 0x6e, 0x61, 0x6c, 0x20, 0x63, 0x6f, 0x6e, 0x74, 0x72, 0x6f, 0x6c, 0x2d, 0x66, 0x6c, 0x6f, 0x77, 0x20, 0x65, 0x72, 0x72, 0x6f, 0x72, 0x0a, 0x00
section .text
align 16
    execute_range.isra.0:
LFB105:
    push    r12
    mov r12, rsi
    push    rbp
    mov rbp, rdx
    push    rbx
    mov rbx, rdi
    jmp L1218
align 16
align 8
L1227:
    cmp byte [rel quit_requested], 0
    jne L1217
    cmp byte [rel runtime_error], 0
    jne L1217
    test    rbp, rbp
    je  L1220
    cmp byte [rbp+1], 0
    jne L1217
L1220:
    mov rdx, rbp
    mov rsi, r12
    mov rdi, rbx
    call    execute_statement
    cmp rbx, rax
    je  L1226
    mov rbx, rax
L1218:
    cmp rbx, r12
    jb  L1227
L1217:
    pop rbx
    pop rbp
    pop r12
    ret
align 16
align 8
L1226:
    mov edx, 36
    mov esi, 1
    mov edi, LC88
    mov rcx, qword [rel stderr]
    call    fwrite
    pop rbx
    pop rbp
    mov byte [rel runtime_error], 1
    pop r12
    ret
LFE105:
section .rodata
align 8
LC89:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x66, 0x75, 0x6e, 0x63, 0x74, 0x69, 0x6f, 0x6e, 0x20, 0x63, 0x61, 0x6c, 0x6c, 0x20, 0x64, 0x65, 0x70, 0x74, 0x68, 0x20, 0x6c, 0x69, 0x6d, 0x69, 0x74, 0x20, 0x28, 0x25, 0x64, 0x29, 0x20, 0x72, 0x65, 0x61, 0x63, 0x68, 0x65, 0x64, 0x0a, 0x00
align 8
LC90:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x25, 0x73, 0x20, 0x65, 0x78, 0x70, 0x65, 0x63, 0x74, 0x73, 0x20, 0x25, 0x64, 0x20, 0x61, 0x72, 0x67, 0x75, 0x6d, 0x65, 0x6e, 0x74, 0x28, 0x73, 0x29, 0x2c, 0x20, 0x67, 0x6f, 0x74, 0x20, 0x25, 0x64, 0x0a, 0x00
section .text
align 16
    invoke_function.part.0:
LFB90:
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbp
    push    rbx
    sub rsp, 24600
    cmp dword [rel call_depth], 63
    mov qword [rsp+40], rdi
    mov dword [rsp+20], ecx
    ja  L1264
    movsx   rsi, esi
    mov ebx, 359
    mov r12, rdx
    mov eax, dword [rsp+20]
    imul    rsi, rsi, 2872
    lea rdx, [rsp+3280]
    mov rcx, rbx
    mov rdi, rdx
    add rsi, functions
    rep movsq
    mov rbx, rcx
    mov ecx, dword [rsp+5104]
    cmp ecx, eax
    jne L1231
    test    eax, eax
    je  L1265
    movsx   rax, dword [rsp+20]
    lea rbp, [rsp+6160]
    lea rbx, [rsp+3568]
    lea r15, [rax+rax*8]
    sal r15, 7
    lea rax, [r15+rbp]
    mov qword [rsp+24], rax
    lea rax, [rsp+2128]
    mov qword [rsp+8], rax
    lea rax, [rsp+1088]
    mov qword [rsp+32], rax
align 16
align 8
L1239:
    mov rcx, rbx
    mov edx, LC1
    mov esi, 96
    mov rdi, rbp
    xor eax, eax
    call    snprintf
    mov r13, qword [rel variable_count]
    test    r13, r13
    je  L1235
    mov r14d, variables
    xor r15d, r15d
align 16
align 8
L1238:
    cmp byte [r14+1136], 0
    je  L1236
    mov rsi, rbx
    mov rdi, r14
    call    strcmp
    test    eax, eax
    je  L1266
L1236:
    add r15, 1
    add r14, 1152
    cmp r15, r13
    jne L1238
L1235:
    mov rdi, qword [rsp+32]
    xor eax, eax
    mov ecx, 130
    lea rsi, [rsp+2128]
    mov byte [rbp+1136], 0
    rep stosq
    mov rdi, qword [rsp+8]
    mov ecx, 130
    mov qword [rsp+8], rsi
    rep stosq
    lea rdi, [rbp+96]
    mov ecx, 130
    rep movsq
L1237:
    sub rsp, 1040
    mov qword [rbp+1144], rax
    mov rsi, r12
    mov ecx, 130
    mov rdi, rsp
    add rbp, 1152
    add r12, 1040
    rep movsq
    mov rdi, rbx
    add rbx, 96
    call    set_value
    mov rax, qword [rsp+1064]
    add rsp, 1040
    cmp rbp, rax
    jne L1239
L1240:
    mov rdi, qword [rsp+8]
    xor eax, eax
    lea rdx, [rsp+48]
    xor r13d, r13d
    mov ecx, 143
    lea r14, [rsp+2136]
    lea rsi, [rsp+1088]
    rep stosq
    mov rdi, rdx
    mov ecx, 130
    mov byte [rsp+2128], 1
    rep stosq
    mov rdi, qword [rsp+32]
    mov ecx, 130
    mov edx, LC1
    lea rbp, [rsp+6160]
    rep stosq
    mov ecx, 130
    mov rdi, r14
    rep movsq
    lea rcx, [rsp+3472]
    lea rdi, [rsp+3176]
    mov esi, 96
    call    snprintf
    mov rax, qword [rsp+5112]
    mov rdx, qword [rsp+8]
    mov rsi, qword [rsp+5120]
    add dword [rel call_depth], 1
    lea rdi, [rax+1]
    call    execute_range.isra.0
    mov eax, dword [rsp+20]
    sub dword [rel call_depth], 1
    test    eax, eax
    je  L1234
align 16
align 8
L1249:
    mov rbx, qword [rel variable_count]
    test    rbx, rbx
    je  L1241
    mov r15d, variables
    xor r12d, r12d
align 16
align 8
L1245:
    cmp byte [r15+1136], 0
    je  L1242
    mov rsi, rbp
    mov rdi, r15
    call    strcmp
    test    eax, eax
    je  L1267
L1242:
    add r12, 1
    add r15, 1152
    cmp rbx, r12
    jne L1245
L1241:
    cmp byte [rbp+1136], 0
    jne L1247
L1246:
    add r13d, 1
    add rbp, 1152
    cmp dword [rsp+20], r13d
    jne L1249
L1234:
    mov rdi, qword [rsp+40]
    mov ecx, 130
    mov rsi, r14
    rep movsq
L1228:
    mov rax, qword [rsp+40]
    add rsp, 24600
    pop rbx
    pop rbp
    pop r12
    pop r13
    pop r14
    pop r15
    ret
align 16
align 8
L1266:
    movsx   rcx, r15d
    mov byte [rbp+1136], 1
    lea rdi, [rbp+96]
    lea rax, [rcx+rcx*8]
    mov ecx, 130
    sal rax, 7
    lea rsi, [variables + rax + 96]
    mov rax, qword [variables + rax + 1144]
    rep movsq
    jmp L1237
align 16
align 8
L1267:
    movsx   rdx, r12d
    mov ecx, r12d
    lea rax, [rdx+rdx*8]
    sal rax, 7
    cmp byte [variables + rax + 1137], 0
    lea rdx, [variables + rax]
    je  L1261
    mov rax, qword [rdx+1144]
    cmp qword [rbp+1144], rax
    jb  L1246
L1261:
    cmp byte [rbp+1136], 0
    jne L1247
    movsx   rax, ecx
    lea rax, [rax+rax*8]
    sal rax, 7
    mov byte [variables + rax + 1136], 0
    jmp L1246
align 16
align 8
L1247:
    movsx   rax, r13d
    mov ecx, 130
    lea rax, [rax+rax*8]
    sal rax, 7
    lea rsi, [rsp+6256+rax]
    sub rsp, 1040
    mov rdi, rsp
    rep movsq
    mov rdi, rbp
    call    set_value
    add rsp, 1040
    jmp L1246
L1231:
    mov rdi, qword [rel stderr]
    mov r8d, dword [rsp+20]
    mov esi, LC90
    xor eax, eax
    call    fprintf
    mov rdi, qword [rsp+40]
    mov rax, rbx
    mov ecx, 130
    mov byte [rel runtime_error], 1
    rep stosq
    jmp L1228
L1264:
    mov rdi, qword [rel stderr]
    mov edx, 64
    mov esi, LC89
    xor eax, eax
    call    fprintf
    mov rdi, qword [rsp+40]
    xor eax, eax
    mov ecx, 130
    mov byte [rel runtime_error], 1
    rep stosq
    jmp L1228
L1265:
    lea rax, [rsp+2128]
    mov qword [rsp+8], rax
    lea rax, [rsp+1088]
    mov qword [rsp+32], rax
    jmp L1240
LFE90:
align 16
    invoke_function.isra.0:
LFB104:
    movsx   rax, esi
    cmp rax, qword [rel function_count]
    push    rbx
    mov rbx, rdi
    jnb L1272
    call    invoke_function.part.0
    mov rax, rbx
    pop rbx
    ret
align 16
align 8
L1272:
    xor esi, esi
    call    number_value
    mov rax, rbx
    pop rbx
    ret
LFE104:
section .rodata
LC91:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x65, 0x78, 0x70, 0x65, 0x63, 0x74, 0x65, 0x64, 0x20, 0x27, 0x29, 0x27, 0x0a, 0x00
section .rodata
align 8
LC92:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x75, 0x6e, 0x61, 0x72, 0x79, 0x20, 0x73, 0x69, 0x67, 0x6e, 0x20, 0x72, 0x65, 0x71, 0x75, 0x69, 0x72, 0x65, 0x73, 0x20, 0x61, 0x20, 0x6e, 0x75, 0x6d, 0x62, 0x65, 0x72, 0x0a, 0x00
align 8
LC93:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x69, 0x6e, 0x76, 0x61, 0x6c, 0x69, 0x64, 0x20, 0x69, 0x6e, 0x74, 0x65, 0x67, 0x65, 0x72, 0x20, 0x6c, 0x69, 0x74, 0x65, 0x72, 0x61, 0x6c, 0x0a, 0x00
align 8
LC94:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x65, 0x78, 0x70, 0x65, 0x63, 0x74, 0x65, 0x64, 0x20, 0x65, 0x78, 0x70, 0x72, 0x65, 0x73, 0x73, 0x69, 0x6f, 0x6e, 0x20, 0x6e, 0x65, 0x61, 0x72, 0x20, 0x27, 0x25, 0x2e, 0x33, 0x30, 0x73, 0x27, 0x0a, 0x00
align 8
LC95:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x74, 0x6f, 0x6f, 0x20, 0x6d, 0x61, 0x6e, 0x79, 0x20, 0x63, 0x61, 0x6c, 0x6c, 0x20, 0x61, 0x72, 0x67, 0x75, 0x6d, 0x65, 0x6e, 0x74, 0x73, 0x0a, 0x00
align 8
LC96:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x65, 0x78, 0x70, 0x65, 0x63, 0x74, 0x65, 0x64, 0x20, 0x27, 0x29, 0x27, 0x20, 0x61, 0x66, 0x74, 0x65, 0x72, 0x20, 0x61, 0x72, 0x67, 0x75, 0x6d, 0x65, 0x6e, 0x74, 0x73, 0x20, 0x74, 0x6f, 0x20, 0x25, 0x73, 0x0a, 0x00
section .text
align 16
    eval_primary:
LFB51:
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbp
    mov rbp, rdi
    push    rbx
    mov rbx, rsi
    sub rsp, 17784
    call    __ctype_b_loc
    mov r12, qword [rbx]
    mov r13, qword [rax]
    mov r14, rax
    movzx   eax, byte [r12]
    movzx   esi, word [r13+0+rax*2]
    test    si, 8192
    je  L1337
    lea rdx, [r12+1]
align 32
align 16
align 8
L1275:
    mov qword [rbx], rdx
    movzx   esi, byte [rdx]
    mov r12, rdx
    add rdx, 1
    mov rcx, rsi
    movzx   esi, word [r13+0+rsi*2]
    test    si, 8192
    jne L1275
L1274:
    cmp byte [rbx+16], 0
    jne L1342
    lea eax, [rcx-34]
    cmp al, 11
    ja  L1278
    movzx   eax, al
    jmp qword [L1280 + rax*8]
section .rodata
align 8
align 4
L1280:
    dq L1282
    dq L1278
    dq L1278
    dq L1278
    dq L1278
    dq L1282
    dq L1281
    dq L1278
    dq L1278
    dq L1279
    dq L1278
    dq L1279
section .text
align 16
align 8
L1278:
    test    si, 2048
    jne L1344
    cmp cl, 36
    jne L1296
    lea rax, [r12+1]
    mov qword [rbx], rax
    movzx   edx, byte [r12+1]
    mov r12, rax
    movzx   esi, word [r13+0+rdx*2]
    mov rcx, rdx
L1296:
    test    si, 1024
    jne L1297
    cmp cl, 95
    je  L1297
    mov rdx, r12
    mov esi, LC94
L1343:
    mov rdi, qword [rel stderr]
    xor eax, eax
    call    fprintf
L1341:
    mov byte [rbx+16], 1
L1342:
    mov ecx, 130
    xor eax, eax
    mov rdi, rbp
    rep stosq
L1273:
    add rsp, 17784
    mov rax, rbp
    pop rbx
    pop rbp
    pop r12
    pop r13
    pop r14
    pop r15
    ret
align 16
align 8
L1282:
    lea r12, [rsp+96]
    mov edx, 1024
    mov rdi, rbx
    mov rsi, r12
    call    parse_quoted
    test    al, al
    je  L1341
    lea rbx, [rsp+1136]
    xor eax, eax
    mov ecx, 130
    mov esi, 1024
    mov rdi, rbx
    mov edx, LC1
    rep stosq
    lea rdi, [rsp+1152]
    mov rcx, r12
    mov dword [rsp+1136], 1
    call    snprintf
    mov ecx, 130
    mov rdi, rbp
    mov rsi, rbx
    rep movsq
    jmp L1273
align 16
align 8
L1279:
    lea rax, [r12+1]
    mov rsi, rbx
    mov qword [rbx], rax
    movzx   r13d, byte [r12]
    lea r12, [rsp+96]
    mov rdi, r12
    call    eval_primary
    mov eax, dword [rsp+96]
    test    eax, eax
    jne L1345
    mov rax, qword [rsp+104]
    mov rdx, rax
    neg rdx
    cmp r13b, 45
    cmove   rax, rdx
    mov qword [rsp+104], rax
L1340:
    mov ecx, 130
    mov rdi, rbp
    mov rsi, r12
    rep movsq
    jmp L1273
L1281:
    add r12, 1
    mov rsi, rbx
    mov qword [rbx], r12
    lea r12, [rsp+1136]
    mov rdi, r12
    call    eval_expr
    mov rax, qword [rbx]
    mov rsi, qword [r14]
    movzx   ecx, byte [rax]
    mov rdx, rcx
    test    byte [rsi+1+rcx*2], 32
    je  L1283
align 32
align 16
align 8
L1284:
    add rax, 1
    mov qword [rbx], rax
    movzx   ecx, byte [rax]
    mov rdx, rcx
    test    byte [rsi+1+rcx*2], 32
    jne L1284
L1283:
    cmp dl, 41
    jne L1285
    add rax, 1
    mov qword [rbx], rax
    jmp L1340
L1297:
    mov rsi, rsp
    mov rdi, rbx
    mov r12, rsp
    call    parse_identifier.constprop.0
    mov rax, qword [rbx]
    movzx   ecx, byte [rax]
    mov rdx, rcx
    test    byte [r13+1+rcx*2], 32
    je  L1298
align 32
align 16
align 8
L1299:
    add rax, 1
    mov qword [rbx], rax
    movzx   ecx, byte [rax]
    mov rdx, rcx
    test    byte [r13+1+rcx*2], 32
    jne L1299
L1298:
    cmp dl, 40
    jne L1300
    mov rax, qword [rbx+8]
    mov rdi, r12
    test    rax, rax
    lea rsi, [rax+1048]
    mov eax, LC18
    cmove   rsi, rax
    call    find_function
    mov rdx, r12
    mov esi, LC84
    mov r13d, eax
    test    eax, eax
    js  L1343
    mov rdx, qword [rbx]
    mov rsi, qword [r14]
    lea rax, [rdx+1]
    mov qword [rbx], rax
    movzx   ecx, byte [rdx+1]
    mov rdx, rcx
    test    byte [rsi+1+rcx*2], 32
    je  L1304
align 32
align 16
align 8
L1305:
    add rax, 1
    mov qword [rbx], rax
    movzx   ecx, byte [rax]
    mov rdx, rcx
    test    byte [rsi+1+rcx*2], 32
    jne L1305
L1304:
    xor eax, eax
    xor r15d, r15d
    cmp dl, 41
    je  L1307
L1306:
    mov rdx, rax
    lea r15d, [rax+1]
    mov rsi, rbx
    sal rdx, 6
    add rax, rdx
    sal rax, 4
    lea rdi, [rsp+1136+rax]
    call    eval_expr
    cmp byte [rbx+16], 0
    jne L1308
    mov rax, qword [rbx]
    mov rsi, qword [r14]
    movzx   ecx, byte [rax]
    mov rdx, rcx
    test    byte [rsi+1+rcx*2], 32
    je  L1310
align 32
align 16
align 8
L1309:
    add rax, 1
    mov qword [rbx], rax
    movzx   ecx, byte [rax]
    mov rdx, rcx
    test    byte [rsi+1+rcx*2], 32
    jne L1309
L1310:
    cmp dl, 44
    je  L1346
L1307:
    mov rax, qword [rbx]
    cmp byte [rax], 41
    jne L1347
    add rax, 1
    cmp byte [rbx+17], 0
    mov qword [rbx], rax
    jne L1342
    movsx   rax, r13d
    cmp rax, qword [rel function_count]
    jb  EVAL_PRIMARY_USER_FUNCTION
    ; Builtins are encoded after the current user-function index range.
    mov eax, r13d
    sub rax, qword [rel function_count]
    lea rdx, [rsp+1136]
    mov ecx, r15d
    mov rdi, rbp
    call invoke_builtin
    jmp L1273
EVAL_PRIMARY_USER_FUNCTION:
    lea rdx, [rsp+1136]
    mov ecx, r15d
    mov esi, r13d
    mov rdi, rbp
    call    invoke_function.part.0
    jmp L1273
align 16
align 8
L1337:
    mov rcx, rax
    jmp L1274
align 16
align 8
L1285:
    mov edx, 21
    mov esi, 1
    mov edi, LC91
    mov rcx, qword [rel stderr]
    call    fwrite
    mov byte [rbx+16], 1
    jmp L1340
L1345:
    mov edx, 37
    mov esi, 1
    mov edi, LC92
    mov rcx, qword [rel stderr]
    call    fwrite
    jmp L1341
L1344:
    call    __errno_location
    mov edx, 10
    lea rsi, [rsp+96]
    mov rdi, r12
    mov dword [rax], 0
    mov r13, rax
    mov qword [rsp+96], 0
    call    strtoll
    mov rdx, rax
    mov rax, qword [rsp+96]
    cmp qword [rbx], rax
    je  L1293
    cmp dword [r13+0], 34
    jne L1294
L1293:
    mov edx, 32
    mov esi, 1
    mov edi, LC93
    mov rcx, qword [rel stderr]
    call    fwrite
    jmp L1341
L1294:
    lea rsi, [rsp+1136]
    mov qword [rbx], rax
    mov ecx, 130
    xor eax, eax
    mov rdi, rsi
    rep stosq
    mov qword [rsp+1144], rdx
    mov ecx, 130
    mov rdi, rbp
    rep movsq
    jmp L1273
L1300:
    mov rsi, r12
    mov rdi, rbp
    call    get_value
    jmp L1273
L1347:
    mov rdx, r12
    mov esi, LC96
    jmp L1343
L1346:
    add rax, 1
    mov qword [rbx], rax
    cmp r15d, 16
    je  L1311
    movsx   rax, r15d
    jmp L1306
L1311:
    mov edx, 32
    mov esi, 1
    mov edi, LC95
    mov rcx, qword [rel stderr]
    call    fwrite
    jmp L1341
L1308:
    xor esi, esi
    mov rdi, rbp
    call    number_value
    jmp L1273
LFE51:
section .rodata
align 8
LC97:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x61, 0x72, 0x69, 0x74, 0x68, 0x6d, 0x65, 0x74, 0x69, 0x63, 0x20, 0x72, 0x65, 0x71, 0x75, 0x69, 0x72, 0x65, 0x73, 0x20, 0x6e, 0x75, 0x6d, 0x62, 0x65, 0x72, 0x73, 0x0a, 0x00
section .rodata
LC98:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x64, 0x69, 0x76, 0x69, 0x73, 0x69, 0x6f, 0x6e, 0x20, 0x62, 0x79, 0x20, 0x7a, 0x65, 0x72, 0x6f, 0x0a, 0x00
section .rodata
align 8
LC99:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x69, 0x6e, 0x74, 0x65, 0x67, 0x65, 0x72, 0x20, 0x64, 0x69, 0x76, 0x69, 0x73, 0x69, 0x6f, 0x6e, 0x20, 0x6f, 0x76, 0x65, 0x72, 0x66, 0x6c, 0x6f, 0x77, 0x0a, 0x00
section .text
align 16
    eval_term:
LFB53:
    push    r15
    push    r14
    mov r14, rsi
    push    r13
    push    r12
    mov r12, rdi
    push    rbp
    push    rbx
    sub rsp, 3144
    lea rdi, [rsp+16]
    call    eval_primary
    cmp byte [r14+16], 0
    mov rbx, qword [rsp+24]
    jne L1349
    call    __ctype_b_loc
    mov  r13, -9223372036854775808
    mov rbp, rax
align 16
align 8
L1360:
    mov rcx, qword [r14]
    mov rsi, qword [rbp+0]
    movzx   eax, byte [rcx]
    mov r15, rax
    test    byte [rsi+1+rax*2], 32
    je  L1362
    lea rdx, [rcx+1]
align 32
align 16
align 8
L1351:
    mov qword [r14], rdx
    movzx   eax, byte [rdx]
    mov rcx, rdx
    add rdx, 1
    mov r15, rax
    test    byte [rsi+1+rax*2], 32
    jne L1351
L1362:
    cmp r15b, 42
    je  L1363
    cmp r15b, 47
    jne L1349
L1363:
    add rcx, 1
    lea rdi, [rsp+1056]
    mov rsi, r14
    mov qword [r14], rcx
    call    eval_primary
    mov eax, dword [rsp+16]
    or  eax, dword [rsp+1056]
    mov r9, qword [rsp+1064]
    jne L1380
    cmp r15b, 42
    je  L1381
    test    r9, r9
    je  L1382
    cmp r9, -1
    jne L1359
    cmp rbx, r13
    je  L1383
L1359:
    mov rax, rbx
    cqo
    idiv    r9
    mov rbx, rax
L1357:
    cmp byte [r14+16], 0
    je  L1360
L1349:
    mov qword [rsp+24], rbx
    mov ecx, 130
    mov rdi, r12
    lea rsi, [rsp+16]
    rep movsq
L1348:
    add rsp, 3144
    mov rax, r12
    pop rbx
    pop rbp
    pop r12
    pop r13
    pop r14
    pop r15
    ret
align 16
align 8
L1381:
    imul    rbx, r9
    jmp L1357
L1380:
    mov edx, 36
    mov esi, 1
    mov edi, LC97
    mov rcx, qword [rel stderr]
L1379:
    call    fwrite
    mov ecx, 130
    xor eax, eax
    mov rdi, r12
    rep stosq
    mov byte [r14+16], 1
    jmp L1348
L1382:
    mov edi, LC98
    mov edx, 25
    mov esi, 1
    mov rcx, qword [rel stderr]
    mov qword [rsp+8], r9
    call    fwrite
    mov rax, qword [rsp+8]
    mov ecx, 130
    mov rdi, r12
    mov byte [r14+16], 1
    rep stosq
    jmp L1348
L1383:
    mov edx, 34
    mov esi, 1
    mov edi, LC99
    mov rcx, qword [rel stderr]
    jmp L1379
LFE53:
section .rodata
align 8
LC100:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x73, 0x75, 0x62, 0x74, 0x72, 0x61, 0x63, 0x74, 0x69, 0x6f, 0x6e, 0x20, 0x72, 0x65, 0x71, 0x75, 0x69, 0x72, 0x65, 0x73, 0x20, 0x6e, 0x75, 0x6d, 0x62, 0x65, 0x72, 0x73, 0x0a, 0x00
section .text
align 16
    eval_expr:
LFB54:
    push    r15
    mov r15, rsi
    push    r14
    push    r13
    push    r12
    push    rbp
    push    rbx
    mov rbx, rdi
    sub rsp, 9352
    lea rdi, [rsp+3104]
    call    eval_term
    cmp byte [r15+16], 0
    mov r13d, dword [rsp+3104]
    mov r14, qword [rsp+3112]
    jne L1385
    call    __ctype_b_loc
    mov qword [rsp+24], rbx
    lea rbp, [rsp+4144]
    mov r12, rax
align 16
align 8
L1408:
    mov rcx, qword [r15]
    mov rsi, qword [r12]
    movzx   eax, byte [rcx]
    mov rbx, rax
    test    byte [rsi+1+rax*2], 32
    je  L1409
    lea rax, [rcx+1]
align 32
align 16
align 8
L1387:
    mov qword [r15], rax
    movzx   edx, byte [rax]
    mov rcx, rax
    add rax, 1
    mov rbx, rdx
    test    byte [rsi+1+rdx*2], 32
    jne L1387
L1409:
    lea eax, [rbx-43]
    test    al, -3
    jne L1427
    add rcx, 1
    mov rsi, r15
    mov rdi, rbp
    mov qword [r15], rcx
    call    eval_term
    mov edx, dword [rsp+4144]
    mov r10, qword [rsp+4152]
    cmp bl, 43
    je  L1429
    or  r13d, edx
    jne L1430
    sub r14, r10
L1405:
    cmp byte [r15+16], 0
    je  L1408
L1427:
    mov rbx, qword [rsp+24]
L1385:
    mov dword [rsp+3104], r13d
    mov ecx, 130
    mov rdi, rbx
    lea rsi, [rsp+3104]
    mov qword [rsp+3112], r14
    rep movsq
L1384:
    add rsp, 9352
    mov rax, rbx
    pop rbx
    pop rbp
    pop r12
    pop r13
    pop r14
    pop r15
    ret
align 16
align 8
L1429:
    mov eax, 130
    mov dword [rsp+3104], r13d
    lea rdi, [rsp+5184]
    lea rsi, [rsp+3104]
    mov rcx, rax
    mov qword [rsp+3112], r14
    lea r9, [rsp+6224]
    rep movsq
    mov rdi, r9
    mov rsi, rbp
    mov rax, rcx
    mov ecx, 130
    rep movsq
    test    r13d, r13d
    jne L1390
    test    edx, edx
    je  L1431
    lea rbx, [rsp+8304]
    mov ecx, 130
    lea rsi, [rsp+5184]
    mov rdi, rbx
    rep movsq
L1393:
    lea r13, [rsp+32]
    mov rcx, r14
    mov edx, LC63
    xor eax, eax
    mov esi, 1024
    mov rdi, r13
    call    snprintf
    lea rax, [rsp+8320]
    lea r9, [rsp+6224]
    mov qword [rsp+8], rax
L1394:
    mov ecx, 130
    mov rdi, rbx
    mov rsi, r9
    rep movsq
    lea r14, [rsp+1056]
    cmp dword [rsp+8304], 1
    je  L1432
    mov edx, LC63
    mov esi, 1024
    mov rdi, r14
    xor eax, eax
    mov rcx, qword [rsp+8312]
    call    snprintf
L1396:
    mov rdi, r13
    call    strlen
    lea rdi, [rsp+2080]
    mov rdx, rax
    cmp eax, 8
    jb  L1397
    mov ecx, eax
    mov rsi, r13
    shr ecx, 3
    rep movsq
    mov r13, rsi
L1397:
    xor eax, eax
    test    dl, 4
    je  L1398
    mov eax, dword [r13+0]
    mov dword [rdi], eax
    mov eax, 4
L1398:
    test    dl, 2
    je  L1399
    movzx   ecx, word [r13+0+rax]
    mov word [rdi+rax], cx
    add rax, 2
L1399:
    test    dl, 1
    je  L1400
    movzx   ecx, byte [r13+0+rax]
    mov byte [rdi+rax], cl
L1400:
    mov rdi, r14
    mov qword [rsp+16], rdx
    call    strlen
    mov rdx, qword [rsp+16]
    lea rdi, [rsp+2080]
    mov rcx, rax
    mov eax, 1023
    sub rax, rdx
    cmp rax, rcx
    cmova   rax, rcx
    lea rcx, [rdi+rdx]
    cmp eax, 8
    jnb L1401
    test    al, 4
    jne L1433
    test    eax, eax
    jne L1434
L1402:
    lea rdi, [rdx+9344]
    mov ecx, 130
    mov esi, 1024
    lea rdx, [rsp+rdi]
    mov rdi, rbx
    mov byte [rax-7264+rdx], 0
    xor eax, eax
    mov edx, LC1
    rep stosq
    mov rdi, qword [rsp+8]
    lea rcx, [rsp+2080]
    mov dword [rsp+8304], 1
    call    snprintf
    lea rax, [rsp+7264]
    mov rsi, rbx
    mov ecx, 130
    mov rdi, rax
    mov r14, qword [rsp+8312]
    rep movsq
L1392:
    mov qword [rsp+7272], r14
    mov ecx, 130
    mov rsi, rax
    lea rdi, [rsp+3104]
    rep movsq
    mov r13d, dword [rsp+7264]
    jmp L1405
L1401:
    mov rsi, qword [r14]
    mov qword [rcx], rsi
    mov esi, eax
    mov rdi, qword [r14-8+rsi]
    mov qword [rcx-8+rsi], rdi
    lea rdi, [rcx+8]
    mov rsi, r14
    and rdi, -8
    sub rcx, rdi
    sub rsi, rcx
    add ecx, eax
    shr ecx, 3
    rep movsq
    jmp L1402
L1390:
    lea rbx, [rsp+8304]
    mov ecx, 130
    lea rsi, [rsp+5184]
    mov rdi, rbx
    rep movsq
    cmp r13d, 1
    jne L1393
    lea r13, [rsp+32]
    mov edx, LC1
    mov esi, 1024
    lea rax, [rsp+8320]
    mov rdi, r13
    mov qword [rsp+8], rax
    mov rcx, rax
    xor eax, eax
    call    snprintf
    lea r9, [rsp+6224]
    jmp L1394
L1432:
    mov rcx, qword [rsp+8]
    mov edx, LC1
    mov rdi, r14
    xor eax, eax
    mov esi, 1024
    call    snprintf
    jmp L1396
L1434:
    movzx   esi, byte [r14]
    mov byte [rcx], sil
    test    al, 2
    je  L1402
    mov esi, eax
    movzx   edi, word [r14-2+rsi]
    mov word [rcx-2+rsi], di
    jmp L1402
align 16
align 8
L1430:
    mov rbx, qword [rsp+24]
    mov edi, LC100
    mov edx, 37
    mov rcx, qword [rel stderr]
    mov esi, 1
    call    fwrite
    mov ecx, 130
    xor eax, eax
    mov rdi, rbx
    rep stosq
    mov byte [r15+16], 1
    jmp L1384
L1431:
    lea rsi, [rsp+8304]
    mov ecx, 130
    add r14, r10
    mov rdi, rsi
    rep stosq
    lea rax, [rsp+7264]
    mov qword [rsp+8312], r14
    mov ecx, 130
    mov rdi, rax
    rep movsq
    jmp L1392
L1433:
    mov esi, dword [r14]
    mov dword [rcx], esi
    mov esi, eax
    mov edi, dword [r14-4+rsi]
    mov dword [rcx-4+rsi], edi
    jmp L1402
LFE54:
section .rodata
align 8
LC101:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x6f, 0x72, 0x64, 0x65, 0x72, 0x69, 0x6e, 0x67, 0x20, 0x63, 0x6f, 0x6d, 0x70, 0x61, 0x72, 0x69, 0x73, 0x6f, 0x6e, 0x73, 0x20, 0x72, 0x65, 0x71, 0x75, 0x69, 0x72, 0x65, 0x20, 0x6e, 0x75, 0x6d, 0x62, 0x65, 0x72, 0x73, 0x0a, 0x00
section .text
align 16
    eval_condition:
LFB56:
    push    r15
    mov rsi, rdi
    push    r14
    mov r14, rdi
    push    r13
    push    r12
    push    rbp
    push    rbx
    sub rsp, 7272
    lea rbx, [rsp+2064]
    mov rdi, rbx
    call    eval_expr
    mov ebp, dword [rsp+2064]
    mov r12, qword [rsp+2072]
    call    __ctype_b_loc
    movzx   r13d, byte [rsp+2080]
    mov rsi, qword [rax]
    mov rax, qword [r14]
    movzx   ecx, byte [rax]
    test    byte [rsi+1+rcx*2], 32
    je  L1504
align 32
align 16
align 8
L1437:
    add rax, 1
    mov qword [r14], rax
    movzx   ecx, byte [rax]
    mov rdx, rcx
    test    byte [rsi+1+rcx*2], 32
    jne L1437
L1436:
    cmp byte [r14+16], 0
    jne L1439
    movzx   ecx, byte [rax]
    cmp ecx, 61
    je  L1506
L1481:
    cmp ecx, 33
    jne L1482
    cmp byte [rax+1], 61
    jne L1482
    add rax, 2
    lea r15, [rsp+3104]
    mov rsi, r14
    mov qword [r14], rax
    mov rdi, r15
    call    eval_expr
    cmp byte [r14+16], 0
    je  L1507
L1439:
    xor eax, eax
L1435:
    add rsp, 7272
    pop rbx
    pop rbp
    pop r12
    pop r13
    pop r14
    pop r15
    ret
align 16
align 8
L1506:
    cmp byte [rax+1], 61
    mov edi, 2
    jne L1481
L1441:
    add rdi, rax
    lea r15, [rsp+3104]
    mov rsi, r14
    mov qword [r14], rdi
    mov rdi, r15
    call    eval_expr
    cmp byte [r14+16], 0
    jne L1439
    mov rsi, rbx
    lea rax, [rsp+4144]
    lea rbx, [rsp+5184]
    mov ecx, 130
    mov rdi, rax
    mov r14d, dword [rsp+3104]
    mov r8, qword [rsp+3112]
    rep movsq
    mov ecx, 130
    mov rdi, rbx
    mov rsi, r15
    rep movsq
    cmp ebp, 1
    je  L1452
    cmp r14d, 1
    je  L1508
    cmp r12, r8
    sete    al
    jmp L1435
align 16
align 8
L1482:
    cmp ecx, 60
    jne L1483
    cmp byte [rax+1], 61
    jne L1483
    mov edx, 2
    mov ebx, 3
L1445:
    add rax, rdx
    lea rdi, [rsp+3104]
    mov rsi, r14
    mov qword [r14], rax
    call    eval_expr
    cmp byte [r14+16], 0
    mov eax, dword [rsp+3104]
    mov rdx, qword [rsp+3112]
    jne L1439
    or  eax, ebp
    jne L1509
    cmp r12, rdx
    setle   al
    cmp ebx, 3
    je  L1435
    cmp r12, rdx
    setge   al
    cmp ebx, 4
    je  L1435
    cmp r12, rdx
    setg    al
    cmp ebx, 5
    jne L1435
    cmp r12, rdx
    setl    al
    jmp L1435
align 16
align 8
L1483:
    cmp ecx, 62
    jne L1484
    cmp byte [rax+1], 61
    jne L1484
    mov edx, 2
    mov ebx, 4
    jmp L1445
L1509:
    mov edx, 45
    mov esi, 1
    mov edi, LC101
    mov rcx, qword [rel stderr]
    call    fwrite
    mov byte [r14+16], 1
    jmp L1439
align 16
align 8
L1504:
    mov rdx, rcx
    jmp L1436
L1484:
    cmp dl, 61
    je  L1477
    cmp dl, 60
    je  L1478
    cmp dl, 62
    je  L1479
    cmp dl, 108
    je  L1510
    cmp dl, 109
    je  L1511
    ; Membership: <value> in <list|dict|set>. Require whitespace after `in`.
    cmp dl, 105
    jne L1448
    cmp byte [rax+1], 110
    jne L1448
    cmp byte [rax+2], 32
    je  CONDITION_IN_PARSE
    cmp byte [rax+2], 9
    jne L1448
CONDITION_IN_PARSE:
    add rax, 2
CONDITION_IN_SKIP_SPACE:
    cmp byte [rax], 32
    je  CONDITION_IN_ADVANCE
    cmp byte [rax], 9
    jne CONDITION_IN_EVAL
CONDITION_IN_ADVANCE:
    add rax, 1
    jmp CONDITION_IN_SKIP_SPACE
CONDITION_IN_EVAL:
    mov qword [r14], rax
    lea rdi, [rsp+3104]
    mov rsi, r14
    call eval_expr
    cmp byte [r14+16], 0
    jne L1439
    lea rdi, [rsp+2064]
    lea rsi, [rsp+3104]
    call collection_contains
    jmp L1435
L1448:
    test    ebp, ebp
    jne L1450
    test    r12, r12
    setne   al
    jmp L1435
L1507:
    mov rsi, rbx
    lea rax, [rsp+4144]
    lea rbx, [rsp+5184]
    mov ecx, 130
    mov rdi, rax
    mov r14d, dword [rsp+3104]
    mov r8, qword [rsp+3112]
    rep movsq
    mov ecx, 130
    mov rdi, rbx
    mov rsi, r15
    rep movsq
    cmp ebp, 1
    je  L1457
    cmp r14d, 1
    je  L1512
    cmp r12, r8
    sete    al
L1461:
    xor eax, 1
    jmp L1435
L1477:
    mov edi, 1
    jmp L1441
L1478:
    mov edx, 1
    mov ebx, 5
    jmp L1445
L1508:
    mov dword [rsp+4144], ebp
    mov rsi, rax
    lea rdi, [rsp+6224]
    xor eax, eax
    mov ecx, 130
    lea rbp, [rsp+16]
    mov edx, LC63
    mov qword [rsp+4152], r12
    mov byte [rsp+4160], r13b
    rep movsq
    mov rcx, r12
    mov esi, 1024
    mov rdi, rbp
    lea r12, [rsp+6240]
    call    snprintf
    lea rdi, [rsp+6224]
    mov ecx, 130
    mov rsi, rbx
    rep movsq
L1466:
    mov rcx, r12
    mov edx, LC1
    mov esi, 1024
    xor eax, eax
    lea rbx, [rsp+1040]
    mov rdi, rbx
    call    snprintf
L1455:
    mov rsi, rbx
    mov rdi, rbp
    call    strcmp
    test    eax, eax
    sete    al
    jmp L1435
L1452:
    mov qword [rsp+4152], r12
    mov rsi, rax
    lea rdi, [rsp+6224]
    xor eax, eax
    mov ecx, 130
    mov byte [rsp+4160], r13b
    lea r12, [rsp+6240]
    lea rbp, [rsp+16]
    mov dword [rsp+4144], 1
    mov edx, LC1
    lea r13, [rsp+6224]
    rep movsq
    mov rcx, r12
    mov esi, 1024
    mov rdi, rbp
    mov qword [rsp+8], r8
    call    snprintf
    cmp r14d, 1
    mov rdi, r13
    mov rsi, rbx
    mov ecx, 130
    mov r8, qword [rsp+8]
    rep movsq
    je  L1466
    mov rcx, r8
    mov edx, LC63
    mov esi, 1024
    xor eax, eax
    lea rbx, [rsp+1040]
    mov rdi, rbx
    call    snprintf
    jmp L1455
L1512:
    mov dword [rsp+4144], ebp
    mov rsi, rax
    lea rdi, [rsp+6224]
    xor eax, eax
    mov ecx, 130
    lea rbp, [rsp+16]
    mov edx, LC63
    mov qword [rsp+4152], r12
    mov byte [rsp+4160], r13b
    rep movsq
    mov rcx, r12
    mov esi, 1024
    mov rdi, rbp
    lea r12, [rsp+6240]
    call    snprintf
    lea rdi, [rsp+6224]
    mov ecx, 130
    mov rsi, rbx
    rep movsq
L1468:
    mov rcx, r12
    mov edx, LC1
    mov esi, 1024
    xor eax, eax
    lea rbx, [rsp+1040]
    mov rdi, rbx
    call    snprintf
L1460:
    mov rsi, rbx
    mov rdi, rbp
    call    strcmp
    test    eax, eax
    sete    al
    jmp L1461
L1457:
    mov qword [rsp+4152], r12
    mov rsi, rax
    lea rdi, [rsp+6224]
    xor eax, eax
    mov ecx, 130
    mov byte [rsp+4160], r13b
    lea r12, [rsp+6240]
    lea rbp, [rsp+16]
    mov dword [rsp+4144], 1
    mov edx, LC1
    lea r13, [rsp+6224]
    rep movsq
    mov rcx, r12
    mov esi, 1024
    mov rdi, rbp
    mov qword [rsp+8], r8
    call    snprintf
    cmp r14d, 1
    mov rdi, r13
    mov rsi, rbx
    mov ecx, 130
    mov r8, qword [rsp+8]
    rep movsq
    je  L1468
    mov rcx, r8
    mov edx, LC63
    mov esi, 1024
    xor eax, eax
    lea rbx, [rsp+1040]
    mov rdi, rbx
    call    snprintf
    jmp L1460
L1479:
    mov edx, 1
    mov ebx, 6
    jmp L1445
L1450:
    test    r13b, r13b
    setne   al
    jmp L1435
L1510:
    movzx   ecx, byte [rax+1]
    test    byte [rsi+rcx*2], 8
    jne L1448
    cmp cl, 95
    je  L1448
    cmp cl, 46
    je  L1448
    mov edx, 1
    mov ebx, 3
    jmp L1445
L1511:
    movzx   edx, byte [rax+1]
    mov rcx, rdx
    test    byte [rsi+rdx*2], 8
    jne L1448
    cmp dl, 95
    je  L1448
    mov edx, 1
    mov ebx, 4
    cmp cl, 46
    jne L1445
    jmp L1448
LFE56:
section .rodata
align 8
LC102:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x75, 0x6e, 0x65, 0x78, 0x70, 0x65, 0x63, 0x74, 0x65, 0x64, 0x20, 0x74, 0x65, 0x78, 0x74, 0x20, 0x6e, 0x65, 0x61, 0x72, 0x20, 0x27, 0x25, 0x2e, 0x33, 0x30, 0x73, 0x27, 0x0a, 0x00
section .text
align 16
    parse_expression_text:
LFB61:
    push    r12
    mov r12, rcx
    push    rbp
    push    rbx
    mov rbx, rdi
    sub rsp, 1072
    lea rbp, [rsp+32]
    mov qword [rsp], rsi
    mov rsi, rsp
    mov rdi, rbp
    mov qword [rsp+8], rdx
    mov qword [rsp+16], 0
    call    eval_expr
    call    __ctype_b_loc
    mov rdx, qword [rsp]
    mov rax, qword [rax]
    movzx   esi, byte [rdx]
    test    byte [rax+1+rsi*2], 32
    je  L1526
align 32
align 16
align 8
L1515:
    add rdx, 1
    mov qword [rsp], rdx
    movzx   r8d, byte [rdx]
    mov rcx, r8
    test    byte [rax+1+r8*2], 32
    jne L1515
L1514:
    test    cl, cl
    jne L1528
    movzx   eax, byte [rsp+16]
    mov edx, eax
    xor edx, 1
    mov byte [r12], dl
    test    al, al
    jne L1517
L1518:
    mov rdi, rbx
    mov rsi, rbp
    mov ecx, 130
    mov rax, rbx
    rep movsq
    add rsp, 1072
    pop rbx
    pop rbp
    pop r12
    ret
align 16
align 8
L1528:
    mov rdi, qword [rel stderr]
    mov esi, LC102
    xor eax, eax
    call    fprintf
    mov byte [r12], 0
L1517:
    mov byte [rel runtime_error], 1
    jmp L1518
align 16
align 8
L1526:
    mov rcx, rsi
    jmp L1514
LFE61:
align 16
    parse_asm_value:
LFB66:
    push    r13
    push    r12
    mov r12, rsi
    push    rbp
    mov rbp, rdx
    push    rbx
    mov rbx, rdi
    sub rsp, 1064
    call    __ctype_b_loc
    movzx   edx, byte [rbx]
    mov rcx, qword [rax]
    mov r13, rax
    test    byte [rcx+1+rdx*2], 32
    je  L1549
align 32
align 16
align 8
L1531:
    movzx   edx, byte [rbx+1]
    add rbx, 1
    mov rax, rdx
    test    byte [rcx+1+rdx*2], 32
    jne L1531
L1530:
    xor edx, edx
    test    al, al
    je  L1529
    cmp al, 48
    jne L1533
    movzx   eax, byte [rbx+1]
    and eax, -33
    cmp al, 88
    je  L1551
L1533:
    lea rcx, [rsp+1048]
    mov rdx, r12
    mov rsi, rbx
    mov rdi, rsp
    call    parse_expression_text
    mov ecx, 130
    mov rdi, rbp
    mov rsi, rsp
    rep movsq
    movzx   edx, byte [rsp+1048]
L1529:
    add rsp, 1064
    mov eax, edx
    pop rbx
    pop rbp
    pop r12
    pop r13
    ret
align 16
align 8
L1551:
    mov qword [rsp+1048], 0
    call    __errno_location
    mov edx, 16
    lea rsi, [rsp+1048]
    mov rdi, rbx
    mov dword [rax], 0
    mov r12, rax
    call    strtoull
    mov rdx, qword [rsp+1048]
    test    rdx, rdx
    je  L1538
    movzx   esi, byte [rdx]
    mov rdi, qword [r13+0]
    mov rcx, rsi
    test    byte [rdi+1+rsi*2], 32
    je  L1536
align 32
align 16
align 8
L1537:
    add rdx, 1
    mov qword [rsp+1048], rdx
    movzx   esi, byte [rdx]
    mov rcx, rsi
    test    byte [rdi+1+rsi*2], 32
    jne L1537
L1536:
    mov esi, dword [r12]
    test    esi, esi
    jne L1538
    cmp rdx, rbx
    je  L1538
    test    cl, cl
    jne L1538
    mov rsi, rax
    mov rdi, rbp
    call    number_value
    mov edx, 1
    jmp L1529
align 16
align 8
L1538:
    xor edx, edx
    jmp L1529
align 16
align 8
L1549:
    mov rax, rdx
    jmp L1530
LFE66:
section .rodata
LC103:
    db 0x76, 0x65, 0x72, 0x73, 0x69, 0x6f, 0x6e, 0x00
section .rodata
align 8
LC104:
    db 0x56, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x20, 0x31, 0x2e, 0x31, 0x2e, 0x30, 0x00
section .rodata
LC105:
    db 0x62, 0x75, 0x69, 0x6c, 0x64, 0x00
section .rodata
align 8
LC106:
    db 0x75, 0x73, 0x61, 0x67, 0x65, 0x3a, 0x20, 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x20, 0x62, 0x75, 0x69, 0x6c, 0x64, 0x20, 0x61, 0x70, 0x70, 0x2e, 0x76, 0x75, 0x6c, 0x20, 0x6f, 0x75, 0x74, 0x70, 0x75, 0x74, 0x20, 0x5b, 0x2d, 0x2d, 0x74, 0x61, 0x72, 0x67, 0x65, 0x74, 0x20, 0x6c, 0x69, 0x6e, 0x75, 0x78, 0x2d, 0x78, 0x38, 0x36, 0x5f, 0x36, 0x34, 0x5d, 0x0a, 0x00
section .rodata
LC107:
    db 0x2d, 0x2d, 0x74, 0x61, 0x72, 0x67, 0x65, 0x74, 0x00
LC108:
    db 0x2d, 0x2d, 0x74, 0x61, 0x72, 0x67, 0x65, 0x74, 0x3d, 0x00
section .rodata
align 8
LC109:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x2d, 0x2d, 0x74, 0x61, 0x72, 0x67, 0x65, 0x74, 0x20, 0x72, 0x65, 0x71, 0x75, 0x69, 0x72, 0x65, 0x73, 0x20, 0x61, 0x20, 0x76, 0x61, 0x6c, 0x75, 0x65, 0x0a, 0x00
section .rodata
LC110:
    db 0x6c, 0x69, 0x6e, 0x75, 0x78, 0x2d, 0x78, 0x38, 0x36, 0x5f, 0x36, 0x34, 0x00
LC111:
    db 0x6c, 0x69, 0x6e, 0x75, 0x78, 0x00
section .rodata
align 8
LC112:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x74, 0x61, 0x72, 0x67, 0x65, 0x74, 0x20, 0x27, 0x25, 0x73, 0x27, 0x20, 0x69, 0x73, 0x20, 0x6e, 0x6f, 0x74, 0x20, 0x73, 0x75, 0x70, 0x70, 0x6f, 0x72, 0x74, 0x65, 0x64, 0x20, 0x62, 0x79, 0x20, 0x74, 0x68, 0x69, 0x73, 0x20, 0x72, 0x75, 0x6e, 0x74, 0x69, 0x6d, 0x65, 0x3b, 0x20, 0x74, 0x68, 0x69, 0x73, 0x20, 0x62, 0x75, 0x69, 0x6c, 0x64, 0x20, 0x73, 0x75, 0x70, 0x70, 0x6f, 0x72, 0x74, 0x73, 0x20, 0x6c, 0x69, 0x6e, 0x75, 0x78, 0x2d, 0x78, 0x38, 0x36, 0x5f, 0x36, 0x34, 0x20, 0x6f, 0x6e, 0x6c, 0x79, 0x0a, 0x00
align 8
LC113:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x62, 0x75, 0x69, 0x6c, 0x64, 0x3a, 0x20, 0x73, 0x6f, 0x75, 0x72, 0x63, 0x65, 0x20, 0x66, 0x69, 0x6c, 0x65, 0x20, 0x27, 0x25, 0x73, 0x27, 0x20, 0x64, 0x6f, 0x65, 0x73, 0x20, 0x6e, 0x6f, 0x74, 0x20, 0x65, 0x78, 0x69, 0x73, 0x74, 0x0a, 0x00
align 8
LC114:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x62, 0x75, 0x69, 0x6c, 0x64, 0x3a, 0x20, 0x6f, 0x75, 0x74, 0x70, 0x75, 0x74, 0x20, 0x6d, 0x75, 0x73, 0x74, 0x20, 0x64, 0x69, 0x66, 0x66, 0x65, 0x72, 0x20, 0x66, 0x72, 0x6f, 0x6d, 0x20, 0x74, 0x68, 0x65, 0x20, 0x69, 0x6e, 0x74, 0x65, 0x72, 0x70, 0x72, 0x65, 0x74, 0x65, 0x72, 0x20, 0x61, 0x6e, 0x64, 0x20, 0x73, 0x6f, 0x75, 0x72, 0x63, 0x65, 0x20, 0x66, 0x69, 0x6c, 0x65, 0x0a, 0x00
align 8
LC115:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x62, 0x75, 0x69, 0x6c, 0x64, 0x3a, 0x20, 0x63, 0x61, 0x6e, 0x6e, 0x6f, 0x74, 0x20, 0x6f, 0x70, 0x65, 0x6e, 0x20, 0x72, 0x75, 0x6e, 0x6e, 0x69, 0x6e, 0x67, 0x20, 0x69, 0x6e, 0x74, 0x65, 0x72, 0x70, 0x72, 0x65, 0x74, 0x65, 0x72, 0x20, 0x27, 0x25, 0x73, 0x27, 0x3a, 0x20, 0x25, 0x73, 0x0a, 0x00
align 8
LC116:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x62, 0x75, 0x69, 0x6c, 0x64, 0x3a, 0x20, 0x63, 0x61, 0x6e, 0x6e, 0x6f, 0x74, 0x20, 0x6f, 0x70, 0x65, 0x6e, 0x20, 0x27, 0x25, 0x73, 0x27, 0x3a, 0x20, 0x25, 0x73, 0x0a, 0x00
align 8
LC117:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x62, 0x75, 0x69, 0x6c, 0x64, 0x3a, 0x20, 0x63, 0x61, 0x6e, 0x6e, 0x6f, 0x74, 0x20, 0x63, 0x72, 0x65, 0x61, 0x74, 0x65, 0x20, 0x27, 0x25, 0x73, 0x27, 0x3a, 0x20, 0x25, 0x73, 0x0a, 0x00
align 8
LC118:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x62, 0x75, 0x69, 0x6c, 0x64, 0x3a, 0x20, 0x77, 0x72, 0x69, 0x74, 0x65, 0x20, 0x66, 0x61, 0x69, 0x6c, 0x65, 0x64, 0x3a, 0x20, 0x25, 0x73, 0x0a, 0x00
align 8
LC119:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x62, 0x75, 0x69, 0x6c, 0x64, 0x3a, 0x20, 0x63, 0x61, 0x6e, 0x6e, 0x6f, 0x74, 0x20, 0x6d, 0x61, 0x72, 0x6b, 0x20, 0x6f, 0x75, 0x74, 0x70, 0x75, 0x74, 0x20, 0x65, 0x78, 0x65, 0x63, 0x75, 0x74, 0x61, 0x62, 0x6c, 0x65, 0x3a, 0x20, 0x25, 0x73, 0x0a, 0x00
align 8
LC120:
    db 0x42, 0x75, 0x69, 0x6c, 0x74, 0x20, 0x73, 0x74, 0x61, 0x6e, 0x64, 0x61, 0x6c, 0x6f, 0x6e, 0x65, 0x20, 0x4c, 0x69, 0x6e, 0x75, 0x78, 0x20, 0x78, 0x38, 0x36, 0x2d, 0x36, 0x34, 0x20, 0x65, 0x78, 0x65, 0x63, 0x75, 0x74, 0x61, 0x62, 0x6c, 0x65, 0x3a, 0x20, 0x25, 0x73, 0x0a, 0x00
section .rodata
LC121:
    db 0x2e, 0x65, 0x78, 0x65, 0x00
section .rodata
align 8
LC122:
    db 0x4e, 0x6f, 0x74, 0x65, 0x3a, 0x20, 0x74, 0x68, 0x69, 0x73, 0x20, 0x69, 0x73, 0x20, 0x61, 0x6e, 0x20, 0x45, 0x4c, 0x46, 0x2f, 0x4c, 0x69, 0x6e, 0x75, 0x78, 0x20, 0x65, 0x78, 0x65, 0x63, 0x75, 0x74, 0x61, 0x62, 0x6c, 0x65, 0x3b, 0x20, 0x74, 0x68, 0x65, 0x20, 0x2e, 0x65, 0x78, 0x65, 0x20, 0x65, 0x78, 0x74, 0x65, 0x6e, 0x73, 0x69, 0x6f, 0x6e, 0x20, 0x64, 0x6f, 0x65, 0x73, 0x20, 0x6e, 0x6f, 0x74, 0x20, 0x6d, 0x61, 0x6b, 0x65, 0x20, 0x69, 0x74, 0x20, 0x61, 0x20, 0x57, 0x69, 0x6e, 0x64, 0x6f, 0x77, 0x73, 0x20, 0x50, 0x45, 0x20, 0x70, 0x72, 0x6f, 0x67, 0x72, 0x61, 0x6d, 0x2e, 0x00
align 8
LC123:
    db 0x75, 0x73, 0x61, 0x67, 0x65, 0x3a, 0x20, 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x20, 0x66, 0x69, 0x6c, 0x65, 0x2e, 0x76, 0x75, 0x6c, 0x20, 0x7c, 0x20, 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x20, 0x62, 0x75, 0x69, 0x6c, 0x64, 0x20, 0x61, 0x70, 0x70, 0x2e, 0x76, 0x75, 0x6c, 0x20, 0x6f, 0x75, 0x74, 0x70, 0x75, 0x74, 0x20, 0x7c, 0x20, 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x20, 0x76, 0x65, 0x72, 0x73, 0x69, 0x6f, 0x6e, 0x0a, 0x00
align 8
LC124:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x66, 0x61, 0x69, 0x6c, 0x65, 0x64, 0x20, 0x74, 0x6f, 0x20, 0x6c, 0x6f, 0x61, 0x64, 0x20, 0x65, 0x6d, 0x62, 0x65, 0x64, 0x64, 0x65, 0x64, 0x20, 0x73, 0x6f, 0x75, 0x72, 0x63, 0x65, 0x0a, 0x00
align 8
LC125:
    db 0x76, 0x75, 0x6c, 0x70, 0x69, 0x6e, 0x3a, 0x20, 0x63, 0x61, 0x6e, 0x6e, 0x6f, 0x74, 0x20, 0x6f, 0x70, 0x65, 0x6e, 0x20, 0x73, 0x6f, 0x75, 0x72, 0x63, 0x65, 0x20, 0x66, 0x69, 0x6c, 0x65, 0x20, 0x27, 0x25, 0x73, 0x27, 0x3a, 0x20, 0x25, 0x73, 0x0a, 0x00
section .text
align 16
global vulpin_runtime_main
    vulpin_runtime_main:
LFB81:
    push    r15
    push    r14
    push    r13
    push    r12
    push    rbp
    push    rbx
    mov rbx, rsi
    sub rsp, 2200
    cmp edi, 1
    jle L1553
    mov r13, qword [rsi+8]
    mov r12d, edi
    mov esi, LC103
    mov rdi, r13
    call    strcmp
    mov ebp, eax
    test    eax, eax
    je  L1613
    mov esi, LC105
    mov rdi, r13
    call    strcmp
    test    eax, eax
    jne L1556
    cmp r12d, 3
    jle L1614
    cmp r12d, 4
    je  L1559
    mov rbp, qword [rbx+32]
    mov esi, LC107
    mov rdi, rbp
    call    strcmp
    test    eax, eax
    jne L1615
    cmp r12d, 5
    je  L1616
    mov rbp, qword [rbx+40]
L1564:
    mov esi, LC110
    mov rdi, rbp
    call    strcmp
    test    eax, eax
    je  L1559
    mov esi, LC111
    mov rdi, rbp
    call    strcmp
    test    eax, eax
    jne L1617
L1559:
    mov rdi, qword [rbx]
    lea rsi, [rsp+16]
    lea rbp, [rsp+1040]
    call    running_executable_path.constprop.0
    mov r12, qword [rbx+24]
    mov rbx, qword [rbx+16]
    mov rsi, rbp
    mov r13, rax
    mov rdi, rbx
    call    stat
    test    eax, eax
    jne L1565
    mov eax, dword [rsp+1064]
    and eax, 61440
    cmp eax, 32768
    je  L1566
L1565:
    mov rdi, qword [rel stderr]
    mov rdx, rbx
    mov esi, LC113
    xor eax, eax
    call    fprintf
L1612:
    mov ebp, 1
    jmp L1552
align 16
align 8
L1556:
    mov rdi, qword [rbx]
    lea r12, [rsp+1040]
    call    load_plugins
    mov rdi, qword [rbx+8]
    mov esi, LC18
    call    load_source
    test    al, al
    je  L1618
L1591:
    xor eax, eax
    mov ecx, 143
    mov rdi, r12
    mov rdx, r12
    rep stosq
    mov rsi, qword [rel statement_count]
    xor edi, edi
    call    execute_range.isra.0
    movzx   ebp, byte [rel runtime_error]
L1552:
    add rsp, 2200
    mov eax, ebp
    pop rbx
    pop rbp
    pop r12
    pop r13
    pop r14
    pop r15
    ret
align 16
align 8
L1553:
    mov rdi, qword [rbx]
    lea rsi, [rsp+16]
    call    running_executable_path.constprop.0
    mov r13, rax
    test    rax, rax
    je  L1582
    lea r12, [rsp+1040]
    mov rdi, rax
    mov rsi, r12
    call    load_embedded_source.constprop.0
    test    al, al
    jne L1619
L1582:
    mov edx, 70
    mov esi, 1
    mov edi, LC123
    mov rcx, qword [rel stderr]
    mov ebp, 2
    call    fwrite
    jmp L1552
align 16
align 8
L1613:
    mov edi, LC104
    call    puts
    jmp L1552
align 16
align 8
L1619:
    mov rdi, r13
    call    load_plugins
    mov esi, LC18
    mov rdi, r12
    call    load_source
    test    al, al
    je  L1583
    xor ebp, ebp
    cmp qword [rel statement_count], 0
    mov ebx, statements+1024
    jne L1587
    jmp L1585
align 16
align 8
L1586:
    add rbp, 1
    add rbx, 2048
    cmp rbp, qword [rel statement_count]
    jnb L1585
L1587:
    mov rsi, r12
    mov rdi, rbx
    call    strcmp
    test    eax, eax
    jne L1586
    mov rcx, r13
    mov edx, LC1
    mov esi, 1024
    mov rdi, rbx
    call    snprintf
    jmp L1586
align 16
align 8
L1566:
    mov rsi, r12
    mov rdi, r13
    call    same_existing_path
    test    al, al
    jne L1570
    mov rsi, r12
    mov rdi, rbx
    call    same_existing_path
    test    al, al
    je  L1620
L1570:
    mov edx, 71
    mov esi, 1
    mov edi, LC114
    mov rcx, qword [rel stderr]
    call    fwrite
    jmp L1612
align 16
align 8
L1585:
    cmp qword [rel function_count], 0
    je  L1588
    mov ebx, functions+1848
    xor ebp, ebp
    jmp L1590
align 16
align 8
L1589:
    add rbp, 1
    add rbx, 2872
    cmp rbp, qword [rel function_count]
    jnb L1588
L1590:
    mov rsi, r12
    mov rdi, rbx
    call    strcmp
    test    eax, eax
    jne L1589
    mov rcx, r13
    mov edx, LC1
    mov esi, 1024
    mov rdi, rbx
    call    snprintf
    jmp L1589
align 16
align 8
L1588:
    mov rdi, r12
    call    unlink
    jmp L1591
align 16
align 8
L1615:
    mov rdi, rbp
    mov edx, 9
    mov esi, LC108
    add rbp, 9
    call    strncmp
    test    eax, eax
    je  L1564
    jmp L1559
align 16
align 8
L1618:
    call    __errno_location
    mov edi, dword [rax]
    call    strerror
    mov rdx, qword [rbx+8]
    mov esi, LC125
    mov rdi, qword [rel stderr]
    mov rcx, rax
    xor eax, eax
    call    fprintf
    jmp L1612
align 16
align 8
L1614:
    mov edx, 59
    mov esi, 1
    mov edi, LC106
    mov rcx, qword [rel stderr]
    call    fwrite
L1558:
    mov ebp, 2
    jmp L1552
align 16
align 8
L1620:
    mov rsi, rbp
    mov rdi, r13
    call    running_executable_path.constprop.0
    mov rsi, r12
    mov rdi, rax
    mov rbp, rax
    call    same_existing_path
    test    al, al
    jne L1570
    mov rsi, r12
    mov rdi, rbx
    call    same_existing_path
    test    al, al
    jne L1570
    mov esi, LC4
    mov rdi, rbp
    call    fopen
    mov r13, rax
    test    rax, rax
    je  L1621
    mov esi, LC4
    mov rdi, rbx
    call    fopen
    mov rbp, rax
    test    rax, rax
    je  L1622
    mov esi, LC6
    mov rdi, r12
    call    fopen
    mov rbx, rax
    test    rax, rax
    je  L1623
    mov rdx, rsp
    mov rsi, rax
    mov rdi, r13
    mov qword [rsp], 0
    mov qword [rsp+8], 0
    call    copy_stream
    test    eax, eax
    je  L1624
L1576:
    mov rdi, rbx
    call    fflush
    mov rdi, r13
    call    fclose
    mov rdi, rbp
    call    fclose
    mov rdi, rbx
    call    fclose
L1592:
    call    __errno_location
    mov edi, dword [rax]
    call    strerror
    mov esi, LC118
    mov rdx, rax
L1611:
    mov rdi, qword [rel stderr]
    xor eax, eax
    call    fprintf
    mov rdi, r12
    call    unlink
    jmp L1612
align 16
align 8
L1617:
    mov rdi, qword [rel stderr]
    mov rdx, rbp
    mov esi, LC112
    xor eax, eax
    call    fprintf
    jmp L1558
align 16
align 8
L1583:
    mov edx, 39
    mov esi, 1
    mov edi, LC124
    mov rcx, qword [rel stderr]
    mov ebp, 1
    call    fwrite
    mov rdi, r12
    call    unlink
    jmp L1552
L1616:
    mov edx, 34
    mov esi, 1
    mov edi, LC109
    mov rcx, qword [rel stderr]
    call    fwrite
    jmp L1558
L1624:
    lea r14, [rsp+8]
    mov rsi, rbx
    mov rdi, rbp
    mov rdx, r14
    call    copy_stream
    test    eax, eax
    jne L1576
    mov rcx, rbx
    mov edx, 1
    mov esi, 8
    mov rdi, r14
    call    fwrite
    cmp rax, 1
    jne L1576
    mov rcx, rbx
    mov edx, 15
    mov esi, 1
    mov edi, LC5
    call    fwrite
    mov rdi, rbx
    mov r14, rax
    call    fflush
    mov rdi, r13
    mov r15d, eax
    call    fclose
    mov rdi, rbp
    call    fclose
    mov rdi, rbx
    call    fclose
    test    r15d, r15d
    mov edx, eax
    setne   al
    cmp r14, 15
    setne   cl
    or  eax, ecx
    movzx   eax, al
    or  eax, edx
    jne L1592
    mov esi, 493
    mov rdi, r12
    call    chmod
    mov ebp, eax
    test    eax, eax
    jne L1625
    mov edi, LC120
    xor eax, eax
    mov rsi, r12
    call    printf
    mov rdi, r12
    call    strlen
    cmp rax, 3
    jbe L1552
    lea rdi, [r12-4+rax]
    mov esi, LC121
    call    strcmp
    test    eax, eax
    jne L1552
    mov edi, LC122
    call    puts
    jmp L1552
L1625:
    call    __errno_location
    mov edi, dword [rax]
    call    strerror
    mov esi, LC119
    mov rdx, rax
    jmp L1611
L1623:
    call    __errno_location
    mov edi, dword [rax]
    call    strerror
    mov rdi, qword [rel stderr]
    mov rdx, r12
    mov esi, LC117
    mov rcx, rax
    xor eax, eax
    call    fprintf
    mov rdi, r13
    call    fclose
    mov rdi, rbp
    call    fclose
    jmp L1612
L1622:
    call    __errno_location
    mov edi, dword [rax]
    call    strerror
    mov rdi, qword [rel stderr]
    mov rdx, rbx
    mov esi, LC116
    mov rcx, rax
    xor eax, eax
    call    fprintf
    mov rdi, r13
    call    fclose
    jmp L1612
L1621:
    call    __errno_location
    mov edi, dword [rax]
    call    strerror
    mov rdi, qword [rel stderr]
    mov rdx, rbp
    mov esi, LC115
    mov rcx, rax
    xor eax, eax
    call    fprintf
    jmp L1612
LFE81:
section .bss
alignb 32
asm_compare_right:
    resb 1040
alignb 32
asm_compare_left:
    resb 1040
alignb 1
asm_compare_valid:
    resb 1
alignb 8
global_write_counter:
    resb 8
alignb 1
runtime_error:
    resb 1
alignb 4
call_depth:
    resb 4
alignb 1
quit_requested:
    resb 1
alignb 8
imported_module_count:
    resb 8
alignb 32
imported_modules:
    resb 24576
alignb 8
loaded_path_count:
    resb 8
alignb 32
loaded_paths:
    resb 524288
alignb 8
function_count:
    resb 8
alignb 32
functions:
    resb 1470464
alignb 8
variable_count:
    resb 8
alignb 32
variables:
    resb 589824
alignb 8
statement_count:
    resb 8
alignb 32
statements:
    resb 16777216
section .rodata
align 16
LC7:
    dq 7815282674493125679
    dq 7305521826869700976
align 16
LC8:
    dq 7234298758801026405
    dq 24866934413088813
section .note.GNU-stack noalloc noexec nowrite progbits

section .text
global main
main:
    jmp vulpin_runtime_main

section .note.GNU-stack noalloc noexec nowrite progbits

section .rodata
align 8
vulpin_collection_error:
    db 'vulpin: invalid collection operation, type, or index', 10, 0
vulpin_collection_memory_error:
    db 'vulpin: collection allocation failed', 10, 0
vulpin_collection_api_error:
    db 'vulpin: invalid collection function arguments', 10, 0
vulpin_collection_fmt_num:
    db '%lld', 0
vulpin_collection_fmt_str:
    db '%s', 0
vulpin_collection_open_list:
    db '[', 0
vulpin_collection_open_dict:
    db '{', 0
vulpin_collection_open_set:
    db '{', 0
vulpin_collection_close_list:
    db ']', 0
vulpin_collection_close_dict:
    db '}', 0
vulpin_collection_close_set:
    db '}', 0
vulpin_collection_comma:
    db ', ', 0
vulpin_collection_colon:
    db ': ', 0
vulpin_collection_ellipsis:
    db '...', 0
vulpin_collection_quote:
    db '"', 0
vulpin_collection_invalid:
    db '<invalid-collection>', 0
vulpin_collection_builtin_0:  db '__v_list_new', 0
vulpin_collection_builtin_1:  db '__v_list_push', 0
vulpin_collection_builtin_2:  db '__v_list_get', 0
vulpin_collection_builtin_3:  db '__v_list_set', 0
vulpin_collection_builtin_4:  db '__v_list_pop', 0
vulpin_collection_builtin_5:  db '__v_list_length', 0
vulpin_collection_builtin_6:  db '__v_dict_new', 0
vulpin_collection_builtin_7:  db '__v_dict_set', 0
vulpin_collection_builtin_8:  db '__v_dict_get', 0
vulpin_collection_builtin_9:  db '__v_dict_has', 0
vulpin_collection_builtin_10: db '__v_dict_delete', 0
vulpin_collection_builtin_11: db '__v_dict_length', 0
vulpin_collection_builtin_12: db '__v_set_new', 0
vulpin_collection_builtin_13: db '__v_set_add', 0
vulpin_collection_builtin_14: db '__v_set_remove', 0
vulpin_collection_builtin_15: db '__v_set_has', 0
vulpin_collection_builtin_16: db '__v_set_union', 0
vulpin_collection_builtin_17: db '__v_set_difference', 0
vulpin_collection_builtin_18: db '__v_set_length', 0
align 8
vulpin_collection_builtin_names:
    dq vulpin_collection_builtin_0, vulpin_collection_builtin_1
    dq vulpin_collection_builtin_2, vulpin_collection_builtin_3
    dq vulpin_collection_builtin_4, vulpin_collection_builtin_5
    dq vulpin_collection_builtin_6, vulpin_collection_builtin_7
    dq vulpin_collection_builtin_8, vulpin_collection_builtin_9
    dq vulpin_collection_builtin_10, vulpin_collection_builtin_11
    dq vulpin_collection_builtin_12, vulpin_collection_builtin_13
    dq vulpin_collection_builtin_14, vulpin_collection_builtin_15
    dq vulpin_collection_builtin_16, vulpin_collection_builtin_17
    dq vulpin_collection_builtin_18

section .bss
alignb 8
vulpin_collection_key_buffer:
    resb 96

section .text

; rdi=name -> eax=builtin id or -1
find_builtin:
    push rbx
    push r12
    sub rsp, 8
    mov rbx, rdi
    xor r12d, r12d
.find_builtin_loop:
    cmp r12d, 19
    jae .find_builtin_miss
    lea rax, [rel vulpin_collection_builtin_names]
    mov rdi, qword [rax+r12*8]
    mov rsi, rbx
    call strcmp
    test eax, eax
    je .find_builtin_found
    add r12d, 1
    jmp .find_builtin_loop
.find_builtin_found:
    mov eax, r12d
    jmp .find_builtin_done
.find_builtin_miss:
    mov eax, -1
.find_builtin_done:
    add rsp, 8
    pop r12
    pop rbx
    ret

; Error helper: tail-call fputs(stderr), preserving caller's stack alignment.
collection_report_error:
    mov byte [rel runtime_error], 1
    mov rdi, qword [rel stderr]
    ; message pointer is supplied in rsi by caller
    xchg rdi, rsi
    jmp fputs

; rdi=Vulpin value pointer, esi=expected collection kind (0 means any).
; Returns collection pointer in rax or zero on error.
collection_from_value:
    push rbx
    mov rbx, rdi
    cmp dword [rbx], 2
    jne .collection_from_value_bad
    mov rax, qword [rbx+8]
    test rax, rax
    je .collection_from_value_bad
    test esi, esi
    je .collection_from_value_ok
    cmp qword [rax], rsi
    jne .collection_from_value_bad
.collection_from_value_ok:
    pop rbx
    ret
.collection_from_value_bad:
    mov rsi, vulpin_collection_error
    call collection_report_error
    xor eax, eax
    pop rbx
    ret

; edi=collection kind (1 list, 2 dict, 3 set) -> rax=new object or zero.
collection_allocate:
    push rbx
    mov ebx, edi
    mov edi, 1
    mov esi, 32
    call calloc
    test rax, rax
    je .collection_allocate_failed
    mov qword [rax], rbx
    jmp .collection_allocate_done
.collection_allocate_failed:
    mov rsi, vulpin_collection_memory_error
    call collection_report_error
    xor eax, eax
.collection_allocate_done:
    pop rbx
    ret

; rdi=collection, rsi=minimum entry count; grows dynamic entry vector.
collection_reserve:
    push rbp
    push rbx
    push r12
    push r13
    sub rsp, 8
    mov rbx, rdi
    mov r12, rsi
    mov rax, qword [rbx+16]
    cmp rax, r12
    jae .collection_reserve_done
    test rax, rax
    jnz .collection_reserve_double
    mov eax, 8
    jmp .collection_reserve_check
.collection_reserve_double:
    add rax, rax
.collection_reserve_check:
    cmp rax, r12
    jae .collection_reserve_capacity_ready
    add rax, rax
    jmp .collection_reserve_check
.collection_reserve_capacity_ready:
    mov r13, rax
    imul rsi, rax, 1136
    mov rdi, qword [rbx+24]
    call realloc
    test rax, rax
    je .collection_reserve_failed
    mov qword [rbx+24], rax
    mov qword [rbx+16], r13
.collection_reserve_done:
    mov eax, 1
    jmp .collection_reserve_exit
.collection_reserve_failed:
    mov rsi, vulpin_collection_memory_error
    call collection_report_error
    xor eax, eax
.collection_reserve_exit:
    add rsp, 8
    pop r13
    pop r12
    pop rbx
    pop rbp
    ret

; rdi=value A, rsi=value B -> eax equal (1/0).
collection_value_equal:
    push rbx
    mov rbx, rdi
    mov eax, dword [rbx]
    cmp eax, dword [rsi]
    jne .collection_value_not_equal
    test eax, eax
    je .collection_value_compare_number
    cmp eax, 1
    je .collection_value_compare_string
    cmp eax, 2
    je .collection_value_compare_handle
    jmp .collection_value_not_equal
.collection_value_compare_number:
    mov rax, qword [rbx+8]
    cmp rax, qword [rsi+8]
    sete al
    movzx eax, al
    jmp .collection_value_equal_done
.collection_value_compare_string:
    lea rdi, [rbx+16]
    lea rsi, [rsi+16]
    call strcmp
    test eax, eax
    sete al
    movzx eax, al
    jmp .collection_value_equal_done
.collection_value_compare_handle:
    mov rax, qword [rbx+8]
    cmp rax, qword [rsi+8]
    sete al
    movzx eax, al
    jmp .collection_value_equal_done
.collection_value_not_equal:
    xor eax, eax
.collection_value_equal_done:
    pop rbx
    ret

; rdi=value, rsi=96-byte output; eax=1 if a key could be created.
collection_key_from_value:
    sub rsp, 8
    cmp dword [rdi], 1
    je .collection_key_string
    cmp dword [rdi], 0
    je .collection_key_number
    xor eax, eax
    jmp .collection_key_done
.collection_key_string:
    mov rdx, vulpin_collection_fmt_str
    lea rcx, [rdi+16]
    mov rdi, rsi
    mov esi, 96
    xor eax, eax
    call snprintf
    mov eax, 1
    jmp .collection_key_done
.collection_key_number:
    mov rdx, vulpin_collection_fmt_num
    mov rcx, qword [rdi+8]
    mov rdi, rsi
    mov esi, 96
    xor eax, eax
    call snprintf
    mov eax, 1
.collection_key_done:
    add rsp, 8
    ret

; rdi=collection, rsi=key string -> rax=index or -1.
collection_find_dict:
    push rbx
    push r12
    push r13
    mov rbx, rdi
    mov r12, rsi
    xor r13d, r13d
.collection_find_dict_loop:
    cmp r13, qword [rbx+8]
    jae .collection_find_dict_missing
    mov rax, qword [rbx+24]
    imul rcx, r13, 1136
    add rax, rcx
    mov rdi, rax
    mov rsi, r12
    call strcmp
    test eax, eax
    je .collection_find_dict_found
    inc r13
    jmp .collection_find_dict_loop
.collection_find_dict_found:
    mov rax, r13
    jmp .collection_find_dict_done
.collection_find_dict_missing:
    mov rax, -1
.collection_find_dict_done:
    pop r13
    pop r12
    pop rbx
    ret

; rdi=collection, rsi=value pointer -> rax=index or -1.
collection_find_value:
    push rbx
    push r12
    push r13
    mov rbx, rdi
    mov r12, rsi
    xor r13d, r13d
.collection_find_value_loop:
    cmp r13, qword [rbx+8]
    jae .collection_find_value_missing
    mov rax, qword [rbx+24]
    imul rcx, r13, 1136
    lea rdi, [rax+rcx+96]
    mov rsi, r12
    call collection_value_equal
    test eax, eax
    jne .collection_find_value_found
    inc r13
    jmp .collection_find_value_loop
.collection_find_value_found:
    mov rax, r13
    jmp .collection_find_value_done
.collection_find_value_missing:
    mov rax, -1
.collection_find_value_done:
    pop r13
    pop r12
    pop rbx
    ret

; rdi=collection, rsi=key pointer or zero, rdx=value pointer -> rax=inserted index.
collection_insert:
    push rbp
    push rbx
    push r12
    push r13
    sub rsp, 8
    mov rbx, rdi
    mov r12, rsi
    mov r13, rdx
    mov rsi, qword [rbx+8]
    inc rsi
    mov rdi, rbx
    call collection_reserve
    test eax, eax
    je .collection_insert_failed
    mov rax, qword [rbx+24]
    mov rdx, qword [rbx+8]
    imul rcx, rdx, 1136
    add rax, rcx
    mov rbp, rax
    test r12, r12
    je .collection_insert_copy_value
    mov rdi, rbp
    mov esi, 96
    mov rdx, vulpin_collection_fmt_str
    mov rcx, r12
    xor eax, eax
    call snprintf
.collection_insert_copy_value:
    lea rdi, [rbp+96]
    mov rsi, r13
    mov ecx, 130
    rep movsq
    mov rax, qword [rbx+8]
    inc rax
    mov qword [rbx+8], rax
    dec rax
    jmp .collection_insert_done
.collection_insert_failed:
    mov rax, -1
.collection_insert_done:
    add rsp, 8
    pop r13
    pop r12
    pop rbx
    pop rbp
    ret

; rdi=collection, rsi=signed index -> rax=normalized index, or -1.
collection_normalize_index:
    mov rax, rsi
    test rax, rax
    jns .collection_normalize_check
    add rax, qword [rdi+8]
.collection_normalize_check:
    test rax, rax
    js .collection_normalize_bad
    cmp rax, qword [rdi+8]
    jae .collection_normalize_bad
    ret
.collection_normalize_bad:
    mov rax, -1
    ret

; rdi=collection, rsi=index -> removes entry; eax=1 success.
collection_remove_index:
    push rbx
    push r12
    push r13
    mov rbx, rdi
    mov r12, rsi
    mov r13, qword [rbx+8]
    lea rax, [r12+1]
    cmp rax, r13
    jae .collection_remove_last
    mov rcx, r13
    sub rcx, rax
    imul rdx, rcx, 1136
    mov rax, qword [rbx+24]
    imul rcx, r12, 1136
    lea rdi, [rax+rcx]
    lea rsi, [rdi+1136]
    call memmove
.collection_remove_last:
    dec qword [rbx+8]
    mov eax, 1
    pop r13
    pop r12
    pop rbx
    ret

; rdi=needle value, rsi=collection value -> eax=membership boolean.
collection_contains:
    push rbx
    push r12
    push r13
    mov rbx, rdi
    mov rdi, rsi
    xor esi, esi
    call collection_from_value
    test rax, rax
    je .collection_contains_no
    mov r12, rax
    cmp qword [r12], 2
    jne .collection_contains_value
    mov rdi, rbx
    mov rsi, vulpin_collection_key_buffer
    call collection_key_from_value
    test eax, eax
    je .collection_contains_no
    mov rdi, r12
    mov rsi, vulpin_collection_key_buffer
    call collection_find_dict
    jmp .collection_contains_check
.collection_contains_value:
    mov rdi, r12
    mov rsi, rbx
    call collection_find_value
.collection_contains_check:
    cmp rax, -1
    sete al
    xor al, 1
    movzx eax, al
    jmp .collection_contains_done
.collection_contains_no:
    xor eax, eax
.collection_contains_done:
    pop r13
    pop r12
    pop rbx
    ret

; rdi=value pointer, esi=nesting depth, edx=inside collection flag.
collection_print_value:
    push rbx
    push rbp
    push r12
    push r13
    push r14
    push r15
    sub rsp, 8
    mov rbx, rdi
    mov ebp, esi
    mov r15d, edx
    cmp dword [rbx], 0
    je .collection_print_number
    cmp dword [rbx], 1
    je .collection_print_string
    cmp dword [rbx], 2
    jne .collection_print_invalid
    mov r12, qword [rbx+8]
    test r12, r12
    je .collection_print_invalid
    cmp ebp, 8
    jae .collection_print_ellipsis
    cmp qword [r12], 1
    je .collection_print_open_list
    cmp qword [r12], 2
    je .collection_print_open_dict
    cmp qword [r12], 3
    je .collection_print_open_set
    jmp .collection_print_invalid
.collection_print_number:
    mov rdi, vulpin_collection_fmt_num
    mov rsi, qword [rbx+8]
    xor eax, eax
    call printf
    jmp .collection_print_done
.collection_print_string:
    test r15d, r15d
    je .collection_print_raw_string
    mov edi, 34
    mov rsi, qword [rel stdout]
    call fputc
.collection_print_raw_string:
    lea rdi, [rbx+16]
    mov rsi, qword [rel stdout]
    call fputs
    test r15d, r15d
    je .collection_print_done
    mov edi, 34
    mov rsi, qword [rel stdout]
    call fputc
    jmp .collection_print_done
.collection_print_open_list:
    mov edi, 91
    jmp .collection_print_open
.collection_print_open_dict:
    mov edi, 123
    jmp .collection_print_open
.collection_print_open_set:
    mov edi, 123
.collection_print_open:
    mov rsi, qword [rel stdout]
    call fputc
    xor r13d, r13d
.collection_print_loop:
    cmp r13, qword [r12+8]
    jae .collection_print_close
    test r13, r13
    je .collection_print_no_comma
    mov rdi, vulpin_collection_comma
    mov rsi, qword [rel stdout]
    call fputs
.collection_print_no_comma:
    cmp qword [r12], 2
    jne .collection_print_entry_value
    mov rax, qword [r12+24]
    imul rcx, r13, 1136
    add rax, rcx
    mov rdi, 34
    mov rsi, qword [rel stdout]
    call fputc
    mov rax, qword [r12+24]
    imul rcx, r13, 1136
    add rax, rcx
    mov rdi, rax
    mov rsi, qword [rel stdout]
    call fputs
    mov rdi, 34
    mov rsi, qword [rel stdout]
    call fputc
    mov rdi, vulpin_collection_colon
    mov rsi, qword [rel stdout]
    call fputs
.collection_print_entry_value:
    mov rax, qword [r12+24]
    imul rcx, r13, 1136
    lea rdi, [rax+rcx+96]
    lea esi, [rbp+1]
    mov edx, 1
    call collection_print_value
    inc r13
    jmp .collection_print_loop
.collection_print_close:
    cmp qword [r12], 1
    je .collection_print_close_list
    mov edi, 125
    jmp .collection_print_close_char
.collection_print_close_list:
    mov edi, 93
.collection_print_close_char:
    mov rsi, qword [rel stdout]
    call fputc
    jmp .collection_print_done
.collection_print_ellipsis:
    mov rdi, vulpin_collection_ellipsis
    mov rsi, qword [rel stdout]
    call fputs
    jmp .collection_print_done
.collection_print_invalid:
    mov rdi, vulpin_collection_invalid
    mov rsi, qword [rel stdout]
    call fputs
.collection_print_done:
    add rsp, 8
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    pop rbx
    ret

; Native function dispatcher. eax=builtin id, rdi=result, rdx=arg vector, ecx=argc.
; Argument and result values use the interpreter's existing 1040-byte layout.
%macro COLL_REQUIRE_ARGS 1
    cmp r14d, %1
    je %%ok
    jmp .ib_bad_args
%%ok:
%endmacro
%macro COLL_RESULT_NUMBER 1
    mov dword [r12], 0
    mov qword [r12+8], %1
    jmp .ib_done
%endmacro
%macro COLL_RESULT_HANDLE 1
    mov dword [r12], 2
    mov qword [r12+8], %1
    jmp .ib_done
%endmacro

invoke_builtin:
    push rbx
    push rbp
    push r12
    push r13
    push r14
    push r15
    sub rsp, 8
    mov r12, rdi
    mov r13, rdx
    mov r14d, ecx
    mov r15d, eax
    xor eax, eax
    mov rdi, r12
    mov ecx, 130
    rep stosq
    cmp r15d, 18
    ja .ib_bad_args
    lea rax, [rel vulpin_collection_builtin_handlers]
    jmp qword [rax+r15*8]

.ib_list_new:
    COLL_REQUIRE_ARGS 0
    mov edi, 1
    call collection_allocate
    test rax, rax
    je .ib_done
    COLL_RESULT_HANDLE rax

.ib_list_push:
    COLL_REQUIRE_ARGS 2
    mov rdi, r13
    mov esi, 1
    call collection_from_value
    test rax, rax
    je .ib_done
    mov rbx, rax
    mov rdi, rbx
    xor esi, esi
    lea rdx, [r13+1040]
    call collection_insert
    cmp rax, -1
    je .ib_done
    mov rax, qword [rbx+8]
    COLL_RESULT_NUMBER rax

.ib_list_get:
    COLL_REQUIRE_ARGS 2
    mov rdi, r13
    mov esi, 1
    call collection_from_value
    test rax, rax
    je .ib_done
    mov rbx, rax
    cmp dword [r13+1040], 0
    jne .ib_bad_args
    mov rsi, qword [r13+1048]
    mov rdi, rbx
    call collection_normalize_index
    cmp rax, -1
    je .ib_collection_error
    mov rdx, qword [rbx+24]
    imul rax, rax, 1136
    lea rsi, [rdx+rax+96]
    mov rdi, r12
    mov ecx, 130
    rep movsq
    jmp .ib_done

.ib_list_set:
    COLL_REQUIRE_ARGS 3
    mov rdi, r13
    mov esi, 1
    call collection_from_value
    test rax, rax
    je .ib_done
    mov rbx, rax
    cmp dword [r13+1040], 0
    jne .ib_bad_args
    mov rsi, qword [r13+1048]
    mov rdi, rbx
    call collection_normalize_index
    cmp rax, -1
    je .ib_collection_error
    mov rdx, qword [rbx+24]
    imul rax, rax, 1136
    lea rdi, [rdx+rax+96]
    lea rsi, [r13+2080]
    mov ecx, 130
    rep movsq
    COLL_RESULT_NUMBER 1

.ib_list_pop:
    COLL_REQUIRE_ARGS 1
    mov rdi, r13
    mov esi, 1
    call collection_from_value
    test rax, rax
    je .ib_done
    mov rbx, rax
    mov rax, qword [rbx+8]
    test rax, rax
    je .ib_done
    dec rax
    mov rdx, qword [rbx+24]
    imul rax, rax, 1136
    lea rsi, [rdx+rax+96]
    mov rdi, r12
    mov ecx, 130
    rep movsq
    dec qword [rbx+8]
    jmp .ib_done

.ib_list_length:
    COLL_REQUIRE_ARGS 1
    mov rdi, r13
    mov esi, 1
    call collection_from_value
    test rax, rax
    je .ib_done
    mov rax, qword [rax+8]
    COLL_RESULT_NUMBER rax

.ib_dict_new:
    COLL_REQUIRE_ARGS 0
    mov edi, 2
    call collection_allocate
    test rax, rax
    je .ib_done
    COLL_RESULT_HANDLE rax

.ib_dict_set:
    COLL_REQUIRE_ARGS 3
    mov rdi, r13
    mov esi, 2
    call collection_from_value
    test rax, rax
    je .ib_done
    mov rbx, rax
    lea rdi, [r13+1040]
    mov rsi, vulpin_collection_key_buffer
    call collection_key_from_value
    test eax, eax
    je .ib_bad_args
    mov rdi, rbx
    mov rsi, vulpin_collection_key_buffer
    call collection_find_dict
    cmp rax, -1
    je .ib_dict_set_new
    mov rdx, qword [rbx+24]
    imul rax, rax, 1136
    lea rdi, [rdx+rax+96]
    lea rsi, [r13+2080]
    mov ecx, 130
    rep movsq
    COLL_RESULT_NUMBER 1
.ib_dict_set_new:
    mov rdi, rbx
    mov rsi, vulpin_collection_key_buffer
    lea rdx, [r13+2080]
    call collection_insert
    cmp rax, -1
    je .ib_done
    COLL_RESULT_NUMBER 1

.ib_dict_get:
    COLL_REQUIRE_ARGS 2
    mov rdi, r13
    mov esi, 2
    call collection_from_value
    test rax, rax
    je .ib_done
    mov rbx, rax
    lea rdi, [r13+1040]
    mov rsi, vulpin_collection_key_buffer
    call collection_key_from_value
    test eax, eax
    je .ib_bad_args
    mov rdi, rbx
    mov rsi, vulpin_collection_key_buffer
    call collection_find_dict
    cmp rax, -1
    je .ib_done
    mov rdx, qword [rbx+24]
    imul rax, rax, 1136
    lea rsi, [rdx+rax+96]
    mov rdi, r12
    mov ecx, 130
    rep movsq
    jmp .ib_done

.ib_dict_has:
    COLL_REQUIRE_ARGS 2
    mov rdi, r13
    mov esi, 2
    call collection_from_value
    test rax, rax
    je .ib_done
    mov rbx, rax
    lea rdi, [r13+1040]
    mov rsi, vulpin_collection_key_buffer
    call collection_key_from_value
    test eax, eax
    je .ib_bad_args
    mov rdi, rbx
    mov rsi, vulpin_collection_key_buffer
    call collection_find_dict
    cmp rax, -1
    sete al
    xor al, 1
    movzx eax, al
    COLL_RESULT_NUMBER rax

.ib_dict_delete:
    COLL_REQUIRE_ARGS 2
    mov rdi, r13
    mov esi, 2
    call collection_from_value
    test rax, rax
    je .ib_done
    mov rbx, rax
    lea rdi, [r13+1040]
    mov rsi, vulpin_collection_key_buffer
    call collection_key_from_value
    test eax, eax
    je .ib_bad_args
    mov rdi, rbx
    mov rsi, vulpin_collection_key_buffer
    call collection_find_dict
    cmp rax, -1
    je .ib_dict_delete_missing
    mov rdi, rbx
    mov rsi, rax
    call collection_remove_index
    COLL_RESULT_NUMBER 1
.ib_dict_delete_missing:
    COLL_RESULT_NUMBER 0

.ib_dict_length:
    COLL_REQUIRE_ARGS 1
    mov rdi, r13
    mov esi, 2
    call collection_from_value
    test rax, rax
    je .ib_done
    mov rax, qword [rax+8]
    COLL_RESULT_NUMBER rax

.ib_set_new:
    COLL_REQUIRE_ARGS 0
    mov edi, 3
    call collection_allocate
    test rax, rax
    je .ib_done
    COLL_RESULT_HANDLE rax

.ib_set_add:
    COLL_REQUIRE_ARGS 2
    mov rdi, r13
    mov esi, 3
    call collection_from_value
    test rax, rax
    je .ib_done
    mov rbx, rax
    mov rdi, rbx
    lea rsi, [r13+1040]
    call collection_find_value
    cmp rax, -1
    jne .ib_set_add_duplicate
    mov rdi, rbx
    xor esi, esi
    lea rdx, [r13+1040]
    call collection_insert
    cmp rax, -1
    je .ib_done
    COLL_RESULT_NUMBER 1
.ib_set_add_duplicate:
    COLL_RESULT_NUMBER 0

.ib_set_remove:
    COLL_REQUIRE_ARGS 2
    mov rdi, r13
    mov esi, 3
    call collection_from_value
    test rax, rax
    je .ib_done
    mov rbx, rax
    mov rdi, rbx
    lea rsi, [r13+1040]
    call collection_find_value
    cmp rax, -1
    je .ib_set_remove_missing
    mov rdi, rbx
    mov rsi, rax
    call collection_remove_index
    COLL_RESULT_NUMBER 1
.ib_set_remove_missing:
    COLL_RESULT_NUMBER 0

.ib_set_has:
    COLL_REQUIRE_ARGS 2
    mov rdi, r13
    mov esi, 3
    call collection_from_value
    test rax, rax
    je .ib_done
    mov rbx, rax
    mov rdi, rbx
    lea rsi, [r13+1040]
    call collection_find_value
    cmp rax, -1
    sete al
    xor al, 1
    movzx eax, al
    COLL_RESULT_NUMBER rax

.ib_set_union:
    COLL_REQUIRE_ARGS 2
    mov rdi, r13
    mov esi, 3
    call collection_from_value
    test rax, rax
    je .ib_done
    mov rbx, rax
    mov rdi, r13
    add rdi, 1040
    mov esi, 3
    call collection_from_value
    test rax, rax
    je .ib_done
    mov rbp, rax
    mov edi, 3
    call collection_allocate
    test rax, rax
    je .ib_done
    mov r15, rax
    xor r14d, r14d
.ib_set_union_first_loop:
    cmp r14, qword [rbx+8]
    jae .ib_set_union_second_start
    mov rax, qword [rbx+24]
    imul rcx, r14, 1136
    lea rsi, [rax+rcx+96]
    mov rdi, r15
    call collection_find_value
    cmp rax, -1
    jne .ib_set_union_first_next
    mov rax, qword [rbx+24]
    imul rcx, r14, 1136
    lea rdx, [rax+rcx+96]
    mov rdi, r15
    xor esi, esi
    call collection_insert
.ib_set_union_first_next:
    inc r14
    jmp .ib_set_union_first_loop
.ib_set_union_second_start:
    xor r14d, r14d
.ib_set_union_second_loop:
    cmp r14, qword [rbp+8]
    jae .ib_set_union_done
    mov rax, qword [rbp+24]
    imul rcx, r14, 1136
    lea rsi, [rax+rcx+96]
    mov rdi, r15
    call collection_find_value
    cmp rax, -1
    jne .ib_set_union_second_next
    mov rax, qword [rbp+24]
    imul rcx, r14, 1136
    lea rdx, [rax+rcx+96]
    mov rdi, r15
    xor esi, esi
    call collection_insert
.ib_set_union_second_next:
    inc r14
    jmp .ib_set_union_second_loop
.ib_set_union_done:
    COLL_RESULT_HANDLE r15

.ib_set_difference:
    COLL_REQUIRE_ARGS 2
    mov rdi, r13
    mov esi, 3
    call collection_from_value
    test rax, rax
    je .ib_done
    mov rbx, rax
    mov rdi, r13
    add rdi, 1040
    mov esi, 3
    call collection_from_value
    test rax, rax
    je .ib_done
    mov rbp, rax
    mov edi, 3
    call collection_allocate
    test rax, rax
    je .ib_done
    mov r15, rax
    xor r14d, r14d
.ib_set_difference_loop:
    cmp r14, qword [rbx+8]
    jae .ib_set_difference_done
    mov rax, qword [rbx+24]
    imul rcx, r14, 1136
    lea rsi, [rax+rcx+96]
    mov rdi, rbp
    call collection_find_value
    cmp rax, -1
    jne .ib_set_difference_next
    mov rax, qword [rbx+24]
    imul rcx, r14, 1136
    lea rdx, [rax+rcx+96]
    mov rdi, r15
    xor esi, esi
    call collection_insert
.ib_set_difference_next:
    inc r14
    jmp .ib_set_difference_loop
.ib_set_difference_done:
    COLL_RESULT_HANDLE r15

.ib_set_length:
    COLL_REQUIRE_ARGS 1
    mov rdi, r13
    mov esi, 3
    call collection_from_value
    test rax, rax
    je .ib_done
    mov rax, qword [rax+8]
    COLL_RESULT_NUMBER rax

.ib_collection_error:
    mov rsi, vulpin_collection_error
    call collection_report_error
    jmp .ib_done
.ib_bad_args:
    mov rsi, vulpin_collection_api_error
    call collection_report_error
.ib_done:
    add rsp, 8
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    pop rbx
    ret

align 8
vulpin_collection_builtin_handlers:
    dq invoke_builtin.ib_list_new
    dq invoke_builtin.ib_list_push
    dq invoke_builtin.ib_list_get
    dq invoke_builtin.ib_list_set
    dq invoke_builtin.ib_list_pop
    dq invoke_builtin.ib_list_length
    dq invoke_builtin.ib_dict_new
    dq invoke_builtin.ib_dict_set
    dq invoke_builtin.ib_dict_get
    dq invoke_builtin.ib_dict_has
    dq invoke_builtin.ib_dict_delete
    dq invoke_builtin.ib_dict_length
    dq invoke_builtin.ib_set_new
    dq invoke_builtin.ib_set_add
    dq invoke_builtin.ib_set_remove
    dq invoke_builtin.ib_set_has
    dq invoke_builtin.ib_set_union
    dq invoke_builtin.ib_set_difference
    dq invoke_builtin.ib_set_length
