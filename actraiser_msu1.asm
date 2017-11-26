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
constant SNES_MUL_OPERAND_A($4202)
constant SNES_MUL_OPERAND_B($4203)
constant SNES_DIV_DIVIDEND_L($4204)
constant SNES_DIV_DIVIDEND_H($4205)
constant SNES_DIV_DIVISOR($4206)
constant SNES_DIV_QUOTIENT_L($4214)
constant SNES_DIV_QUOTIENT_H($4215)
constant SNES_MUL_DIV_RESULT_L($4216)
constant SNES_MUL_DIV_RESULT_H($4217)

// Constants
constant FULL_VOLUME($FF)

constant TOTAL_TRACKS(22)

constant FADE_DELTA(2)

variable fadeVolume($7e3d30)

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
// Hijack
seek($00a412)
    jsl MSU_SetupFade
    jmp $a41e

seek($02b66c)
    jsl SPC_Hijack_1
    nop

seek($02b674)
    jsl SPC_Hijack_2
    jmp $b67e

// Check if song fade out done hijack
seek($00a429)
    jsr SongFadeOutDoneHijack

// During gameplay
seek($00a48f)
    jsl MSU_Main

// Sound test
seek($0298f9)
    jsl MSU_Main

//seek($029953)
//	jsl MSU_Main
//
//seek($029E1B)
//	jsl MSU_Main

seek($03e51b)
    jsl MSU_Main

// Menu ?
seek($02b68d)
    jsl MSU_Main

seek($008520)
    jsl MSU_NMI_Hijack

seek($00FF40)
SongFadeOutDoneHijack:
    jsl CheckIsFadeOutDone
    rts

// MSU-1 code
seek($9F8000)
scope MSU_Main: {
    php
    rep #$30
    pha
    phx
    phy

    sep #$30
    CheckMSUPresence(OriginalCode)

    jsr FindTrackIndex
    cpx.b #TOTAL_TRACKS
    beq OriginalCode

    stx MSU_AUDIO_TRACK_LO
    stz MSU_AUDIO_TRACK_HI

IsMSUReady:
    lda.w MSU_STATUS
    and.b #MSU_STATUS_AUDIO_BUSY
    bne IsMSUReady

    // Check if the track is missing
    lda.w MSU_STATUS
    and.b #MSU_STATUS_TRACK_MISSING
    bne TrackMissing

    // Play the song and add repeat if needed
    jsr TrackNeedLooping
    sta.w MSU_AUDIO_CONTROL

    // Set volume
    lda.b #FULL_VOLUME
    sta.w MSU_AUDIO_VOLUME

    lda.b #0
    sta fadeVolume

    // Play silence on the SPC
    rep #$10
    ldy #$ab8f
    sty $a5
    lda #$06
    sta $a7
    bra OriginalCode

TrackMissing:
    stz MSU_AUDIO_CONTROL
    stz MSU_AUDIO_VOLUME

OriginalCode:
    rep #$30
    ply
    plx
    pla
    plp

    jsl $029964

    rtl
}

scope TrackNeedLooping: {
    // Round Clear (Victory Jingle)
    cpx.b #04
    beq NoLooping
    // Descent
    cpx.b #08
    beq NoLooping
    // Level Up (Jingle)
    cpx.b #11
    beq NoLooping
    // Silence (name of the track)
    cpx.b #15
    beq NoLooping
    // Ending (Jingle)
    cpx.b #17
    beq NoLooping
    // Ending (Another Jingle, shorter one)
    cpx.b #18
    beq NoLooping
    lda.b #$03
    rts
NoLooping:
    lda.b #$01
    rts
}

scope FindTrackIndex: {
    rep #$10
    ldx #$0000

    sep #$30
FindTrackLoop:
    phx
    txa
    asl
    clc
    adc $01,s
    tax
    rep #$30
    lda $a5
    cmp TrackPointerData,x
    bne +
    sep #$30
    lda $a7
    cmp TrackPointerData+2,x
    bne +
    sep #$30
    plx
    bra Exit
+
    sep #$30
    plx
    inx
    cpx.b #TOTAL_TRACKS
    bne FindTrackLoop

Exit:
    rts

TrackPointerData:
    dl $18947f // Fillmore
    dl $1ca988 // Sky Palace
    dl $18ddcc // Bloodpool ~ Casandora
    dl $1ae9e2 // The Beast Appears (Boss Battle 1)
    dl $1ca5fb // Round Clear (Victory Jingle)
    dl $1b8554 // Aitos ~ Temple
    dl $1b9470 // Powerful Enemy (Boss Battle 2)
    dl $1a94b8 // Opening
    dl $1ca7cc // Descent
    dl $0ef69f // Piramid ~ Marana
    dl $1babed // Birth of the People
    dl $1cafeb // Level Up (Jingle)
    dl $19fa4b // North Wall
    dl $17c027 // All over the World
    dl $18d4fa // Satan
    dl $1c9f3d // Silence (name of the track)
    dl $1aef63 // Sacrifices
    dl $1bfd6b // Ending (Jingle)
    dl $1cb3f2 // Ending (Another Jingle, shorter one)
    dl $1ba2ab // Peaceful World
    dl $06ab8f // (Actual Silence)
    dl $17b05c // Ending (Long Track)
}

scope SPC_Hijack_1: {
    php
    rep #$30
    pha

    sep #$20
    CheckMSUPresence(OriginalCode)

    rep #$30
    pla
    plp
    rtl

OriginalCode:
    rep #$30
    pla
    plp
-
    lda $2143
    bne -

    rtl
}

scope SPC_Hijack_2: {
    php
    rep #$30
    pha

    sep #$20
    CheckMSUPresence(OriginalCode)

    rep #$30
    pla
    plp
    rtl

OriginalCode:
    rep #$30
    pla
    plp

    lda #$f0
    sta $2140
-
    lda $2140
    bne -

    rtl
}

scope CheckIsFadeOutDone: {
    CheckMSUPresence(OriginalCode)

    lda fadeVolume

    rtl

OriginalCode:
    lda.w SPC_COMM_0

    rtl
}

scope MSU_SetupFade: {
    php
    rep #$30
    pha

    sep #$20
    CheckMSUPresence(OriginalCode)

    lda.b #FULL_VOLUME
    sta fadeVolume

    rep #$30
    pla
    plp
    rtl

OriginalCode:
    rep #$30
    pla
    plp

    lda #$f1
-
    cmp $2140
    bne -
    lda #$01
    sta $2140

    rtl
}

scope MSU_NMI_Hijack: {
    php
    rep #$30
    pha

    sep #$20

    CheckMSUPresence(exit)

    lda fadeVolume
    beq exit

    lda fadeVolume
    sec
    sbc.b #FADE_DELTA
    bcs setVolume

    stz MSU_AUDIO_CONTROL
    lda.b #0
setVolume:
    sta fadeVolume
    sta.w MSU_AUDIO_VOLUME

    // Original Code
exit:
    rep #$30
    pla
    plp

    jml $02abf0
}