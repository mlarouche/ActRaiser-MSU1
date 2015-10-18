arch snes.cpu

// MSU memory map I/O
constant MSU_STATUS($2000)
constant MSU_ID($2002)
constant MSU_AUDIO_TRACK_LO($2004)
constant MSU_AUDIO_TRACK_HI($2005)
constant MSU_AUDIO_VOLUME($2006)
constant MSU_AUDIO_CONTROL($2007)

// SPC communication ports
constant SPC_COMM_0($2140)
constant SPC_COMM_1($2141)
constant SPC_COMM_2($2142)
constant SPC_COMM_3($2143)

// MSU_STATUS possible values
constant MSU_STATUS_TRACK_MISSING($8)
constant MSU_STATUS_AUDIO_PLAYING(%00010000)
constant MSU_STATUS_AUDIO_REPEAT(%00100000)
constant MSU_STATUS_AUDIO_BUSY($40)
constant MSU_STATUS_DATA_BUSY(%10000000)

// SNES Multiply register
constant SNES_MUL_OPERAND_A($004202)
constant SNES_MUL_OPERAND_B($004203)
constant SNES_DIV_DIVIDEND_L($004204)
constant SNES_DIV_DIVIDEND_H($004205)
constant SNES_DIV_DIVISOR($004206)
constant SNES_DIV_QUOTIENT_L($004214)
constant SNES_DIV_QUOTIENT_H($004215)
constant SNES_MUL_DIV_RESULT_L($004216)
constant SNES_MUL_DIV_RESULT_H($004217)

// Constants
if {defined EMULATOR_VOLUME} {
	constant FULL_VOLUME($50)
} else {
	constant FULL_VOLUME($FF)
}

// **********
// * Macros *
// **********
// seek converts SNES LoROM address to physical address
macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

macro CheckMSUPresence(labelToJump) {
	lda MSU_ID
	cmp.b #'S'
	bne {labelToJump}
}

macro WaitMulResult() {
	nop
	nop
	nop
	nop
}

macro WaitDivResult() {
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
}

// ********
// * Code *
// ********
