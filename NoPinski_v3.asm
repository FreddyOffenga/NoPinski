; No Pinski - Yet Another Sierpinski Thing
; F#READY, 2022-01-16

; v3 - added colors and sound, 61 bytes
; v2 - optimised, 48 bytes
; v1 - converted and adapted BASIC program, 76 bytes
; BASIC code from New Atari User, issue 56

; experiment with these values :)
MAX_VALUE   = 3
MIN_VALUE   = 127
BIG_VALUE   = 255

ROWCRS      = $54       ; byte
y_position  = ROWCRS    ; alias

COLCRS      = $55       ; word
x_position  = COLCRS    ; alias

OLDROW      = $5a       ; byte
y_start     = OLDROW    ; alias

OLDCOL      = $5b       ; word
x_start     = OLDCOL    ; alias

open_mode   = $ef9c     ; A=mode
clear_scr   = $f420     ; zero screen memory
draw_to     = $f9c2     ; $f9bf (stx FILFLG)
plot_pixel  = $f1d8

FILFLG      = $2b7
FILDAT      = $2fd

ATACHR      = $2fb      ; drawing color
draw_color  = ATACHR    ; alias

            org $80
            
            lda #7
            jsr open_mode

; maybe?
;            dec 77          

            ;lda #MAX_VALUE
            ;sta x_position
            ;lda #32
            ;sta y_position
            
repeat
            lda 19
            sta draw_color

notzero
            lda $d20a
            and #3
            ;beq notzero     ; this, or add extra byte to Ytab,Ztab
            tax
            lda Ytab,x
            adc x_position                      
            lsr
            sta x_position

            lda Ztab,x
            adc y_position
            lsr
            sta y_position

            lda 20
            and #$f0
            ora 19 ; ora $e30b,x
            sta 708     ;708,x
            
            sta $d200,x
                      
            jsr plot_pixel
            ;sta 710
              
            bvc repeat

Ytab        dta MAX_VALUE, MIN_VALUE, BIG_VALUE, MAX_VALUE
Ztab        dta MIN_VALUE, MAX_VALUE, MAX_VALUE, MIN_VALUE
