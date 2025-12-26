nasm -felf64 source.asm -o /tmp/ctf.o
gcc -flto -fpie -fomit-frame-pointer -Tlink.ld /tmp/ctf.o -o ctf -z noexecstack
strip --wildcard -N "nothing_dont_worry_about_it" -N 'nothing_dont_worry_about_it*' ctf
cp ctf ctf.stripped
objcopy --remove-section .note --remove-section .gnu.version --remove-section .hash --remove-section .gnu.hash --remove-section .note.ABI-tag --remove-section .eh_frame --remove-section .eh_frame_hdr --remove-section .note.gnu.property ctf.stripped
