
_main:

;main.c,13 :: 		void main()
;main.c,15 :: 		OSCCAL  = 0x20;     // Load the calibration value of the internal oscillator
	MOVLW      32
	MOVWF      OSCCAL+0
;main.c,16 :: 		ANSEL   = 0x00;     // Set ports as digital I/O, not analog input
	CLRF       ANSEL+0
;main.c,17 :: 		ADCON0  = 0x00;     // Shut off the A/D Converter
	CLRF       ADCON0+0
;main.c,18 :: 		CMCON   = 0x07;     // Shut off the Comparator
	MOVLW      7
	MOVWF      CMCON+0
;main.c,19 :: 		VRCON   = 0x00;     // Shut off the Voltage Reference
	CLRF       VRCON+0
;main.c,20 :: 		TRISIO  = 0x00;     // All Output
	CLRF       TRISIO+0
;main.c,21 :: 		GPIO    = 0x00;     // Make all Pin Low
	CLRF       GPIO+0
;main.c,23 :: 		Delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
	NOP
;main.c,25 :: 		SoftUart_Init();                              // Initialize Serial Communication (9600 default)
	CALL       _SoftUart_Init+0
;main.c,26 :: 		Soft_UART_Write_Text_Const("STARTING...");
	MOVLW      ?lstr_1_main+0
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+0
	MOVLW      hi_addr(?lstr_1_main+0)
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+1
	CALL       _Soft_UART_Write_Text_Const+0
;main.c,27 :: 		Soft_UART_Write_Text_Const("\r\n\r\n");
	MOVLW      ?lstr_2_main+0
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+0
	MOVLW      hi_addr(?lstr_2_main+0)
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+1
	CALL       _Soft_UART_Write_Text_Const+0
;main.c,29 :: 		for (i = 'A'; i <= 'Z'; i++) {                // Send bytes from 'A' to 'Z'
	MOVLW      65
	MOVWF      _i+0
L_main1:
	MOVF       _i+0, 0
	SUBLW      90
	BTFSS      STATUS+0, 0
	GOTO       L_main2
;main.c,30 :: 		Soft_UART_Write(i);
	MOVF       _i+0, 0
	MOVWF      FARG_Soft_UART_Write_Data+0
	CALL       _Soft_UART_Write+0
;main.c,31 :: 		Delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	NOP
	NOP
;main.c,29 :: 		for (i = 'A'; i <= 'Z'; i++) {                // Send bytes from 'A' to 'Z'
	INCF       _i+0, 1
;main.c,32 :: 		}
	GOTO       L_main1
L_main2:
;main.c,33 :: 		Soft_UART_Write_Text_Const("\r\n\r\n");
	MOVLW      ?lstr_3_main+0
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+0
	MOVLW      hi_addr(?lstr_3_main+0)
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+1
	CALL       _Soft_UART_Write_Text_Const+0
;main.c,36 :: 		while (1)
L_main5:
;main.c,39 :: 		Soft_UART_Write_Text_Const("Type message & press Enter: ");
	MOVLW      ?lstr_4_main+0
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+0
	MOVLW      hi_addr(?lstr_4_main+0)
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+1
	CALL       _Soft_UART_Write_Text_Const+0
;main.c,40 :: 		Soft_UART_Read_Text(text, '\r\n');       // Read until the CR + LF arrives
	MOVLW      _text+0
	MOVWF      FARG_Soft_UART_Read_Text_Buffer+0
	MOVLW      13
	MOVWF      FARG_Soft_UART_Read_Text_StopChar+0
	CALL       _Soft_UART_Read_Text+0
;main.c,41 :: 		Soft_UART_Write_text(text);              // Print text
	MOVLW      _text+0
	MOVWF      FARG_Soft_UART_Write_Text_Text+0
	CALL       _Soft_UART_Write_Text+0
;main.c,42 :: 		Soft_UART_Write_Text("\r\n\r\n");
	MOVLW      ?lstr5_main+0
	MOVWF      FARG_Soft_UART_Write_Text_Text+0
	CALL       _Soft_UART_Write_Text+0
;main.c,45 :: 		Soft_UART_Write_Text_Const("Waiting for a single input");
	MOVLW      ?lstr_6_main+0
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+0
	MOVLW      hi_addr(?lstr_6_main+0)
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+1
	CALL       _Soft_UART_Write_Text_Const+0
;main.c,46 :: 		Soft_UART_Write_Text_Const("\r\n");     // Newline
	MOVLW      ?lstr_7_main+0
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+0
	MOVLW      hi_addr(?lstr_7_main+0)
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+1
	CALL       _Soft_UART_Write_Text_Const+0
;main.c,47 :: 		byte_read = Soft_UART_Read();           // Read data
	CALL       _Soft_UART_Read+0
	MOVF       R0+0, 0
	MOVWF      _byte_read+0
;main.c,48 :: 		Soft_UART_Write_Text_Const("\r\n");     // Newline
	MOVLW      ?lstr_8_main+0
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+0
	MOVLW      hi_addr(?lstr_8_main+0)
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+1
	CALL       _Soft_UART_Write_Text_Const+0
;main.c,49 :: 		Soft_UART_Write_Text_Const("Input: ");
	MOVLW      ?lstr_9_main+0
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+0
	MOVLW      hi_addr(?lstr_9_main+0)
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+1
	CALL       _Soft_UART_Write_Text_Const+0
;main.c,50 :: 		Soft_UART_Write(byte_read);             // Print data
	MOVF       _byte_read+0, 0
	MOVWF      FARG_Soft_UART_Write_Data+0
	CALL       _Soft_UART_Write+0
;main.c,51 :: 		Soft_UART_Write_Text_Const("\r\n\r\n");
	MOVLW      ?lstr_10_main+0
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+0
	MOVLW      hi_addr(?lstr_10_main+0)
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+1
	CALL       _Soft_UART_Write_Text_Const+0
;main.c,54 :: 		count++;
	INCF       _count+0, 1
;main.c,55 :: 		Soft_UART_Write_Text_Const("Counter: ");
	MOVLW      ?lstr_11_main+0
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+0
	MOVLW      hi_addr(?lstr_11_main+0)
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+1
	CALL       _Soft_UART_Write_Text_Const+0
;main.c,56 :: 		WordToStr(count, text);
	MOVF       _count+0, 0
	MOVWF      FARG_WordToStr_input+0
	CLRF       FARG_WordToStr_input+1
	MOVLW      _text+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;main.c,57 :: 		Soft_UART_Write_text(text);
	MOVLW      _text+0
	MOVWF      FARG_Soft_UART_Write_Text_Text+0
	CALL       _Soft_UART_Write_Text+0
;main.c,58 :: 		Soft_UART_Write_Text_Const("\r\n\r\n");
	MOVLW      ?lstr_12_main+0
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+0
	MOVLW      hi_addr(?lstr_12_main+0)
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+1
	CALL       _Soft_UART_Write_Text_Const+0
;main.c,60 :: 		Soft_UART_Write_Text_Const("=============================");
	MOVLW      ?lstr_13_main+0
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+0
	MOVLW      hi_addr(?lstr_13_main+0)
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+1
	CALL       _Soft_UART_Write_Text_Const+0
;main.c,61 :: 		Soft_UART_Write_Text_Const("\r\n\r\n");
	MOVLW      ?lstr_14_main+0
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+0
	MOVLW      hi_addr(?lstr_14_main+0)
	MOVWF      FARG_Soft_UART_Write_Text_Const_Text+1
	CALL       _Soft_UART_Write_Text_Const+0
;main.c,63 :: 		Delay_ms(20);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	NOP
;main.c,64 :: 		}
	GOTO       L_main5
;main.c,65 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
