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
main: ; not part of the main challenge plz ignore
	mov rax, 65556
	shl rax, 7
	or al, 1
	mov eax, DWORD [rax]
	xor eax, 0x20d54558
	xor DWORD [rax], 0x12622e68
	xor DWORD [rax + 4], 0x76757b73
	xor DWORD [rax + 8], 0x00377c66

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

align 32

flag: db "{YOU CHEATER}", 0x0a, 0x00
