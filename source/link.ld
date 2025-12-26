OUTPUT_FORMAT(elf64-x86-64)
ENTRY(_start)

SECTIONS
	{
		. = 0x00800000;
		.rodata : {
			*(.rodata .rodata.*)
		}
		.data : {
			*(.data .data.*)
			*(.bss .bss.*)
			*(COMMON)
		}
		.text : {
			. = ALIGN(8);
			*(.text .text.*)
		}
		.init : {
			*(.init .init.*)
		}
		.fini : {
			*(.fini .fini.*)
		}
		/DISCARD/ : {
			*(.comment .comment.*)
		}
	}
