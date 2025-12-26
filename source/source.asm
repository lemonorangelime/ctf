bits 64

section .data

align 16
buffer: times 0x100 db 0
incorrect: db "INCORRECT", 0x0a, 0x00
correct: db "CORRECT", 0x0a, 0x00
prompt: db "> "

align 256

section .text

extern printf
extern system
extern main
main:
	call nothing_dont_worry_about_it
	mov rbp, rsp

.prompt:
	mov rax, 1
	mov rdi, 1
	mov rsi, prompt
	mov rdx, 2
	syscall

.read_input:
	xor rax, rax
	xor rdi, rdi
	mov rsi, buffer
	mov rdx, 0x200
	syscall

	cmp rax, 1
	jbe .exit

.print:
	mov rdi, correct
.print.check_answer:
	mov rdx, [buffer]
	cmp edx, 0x30344537
	je .print.correct
	mov rdi, incorrect
.print.correct:
	push rbp
	and rsp, ~0x0f
	call printf
	mov rbp, rsp
	pop rbp

.check_answer:
	mov rdx, [buffer]
	cmp edx, 0x30344537
	jne .prompt

.exit:
	xor rax, rax
	mov rsp, rbp
	ret

align 64

flag: db "{YOU CHEATER}", 0x0a, 0x00





nothing_dont_worry_about_it:
	xor rcx, rcx
	mov BYTE [.thunk], 0x5b
	call .thunk
._thunk:
	db 0xff
.thunk:
	db 0xff
	mov BYTE [.thunk], 0xc3
	push .thunk2
	jmp .thunk
	db 0xff
	.1: dd 0x17342e6e
	.2: dd 0x74767d22
	.3: dd 0x0065746d
.thunk2:
	or al, [.thunk]
	xor rax, rax
	mov cl, [rbx + (.thunk2 - ._thunk)]
	shl rcx, 8
	xor rax, rcx
	xor rcx, rcx
.thunk3:
	add BYTE [.thunk], 0x00
	mov cl, [rbx + (.thunk3 - ._thunk)]
	shl rcx, 16
	xor rax, rcx
	or rax, 1
	mov ecx, [rbx + (.1 - ._thunk)]
	xor DWORD [rax], ecx
	mov ecx, [rbx + (.2 - ._thunk)]
	xor DWORD [rax + 4], ecx
	mov ecx, [rbx + (.3 - ._thunk)]
	xor DWORD [rax + 8], ecx
	ret
