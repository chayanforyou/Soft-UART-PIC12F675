
_SoftUart_Init:

;Soft_Uart.c,22 :: 		void  SoftUart_Init()
;Soft_Uart.c,24 :: 		Soft_Uart_Tx = 1;
	BSF        Soft_Uart_Tx+0, BitPos(Soft_Uart_Tx+0)
;Soft_Uart.c,25 :: 		Soft_Uart_Rx = 1;
	BSF        Soft_Uart_Rx+0, BitPos(Soft_Uart_Rx+0)
;Soft_Uart.c,26 :: 		Soft_Uart_Tx_Direction = 0;
	BCF        Soft_Uart_Tx_Direction+0, BitPos(Soft_Uart_Tx_Direction+0)
;Soft_Uart.c,27 :: 		Soft_Uart_Rx_Direction = 1;
	BSF        Soft_Uart_Rx_Direction+0, BitPos(Soft_Uart_Rx_Direction+0)
;Soft_Uart.c,28 :: 		Soft_Uart_Tx = 1;
	BSF        Soft_Uart_Tx+0, BitPos(Soft_Uart_Tx+0)
;Soft_Uart.c,29 :: 		delay_us(BITPERIOD);
	MOVLW      34
	MOVWF      R13+0
L_SoftUart_Init0:
	DECFSZ     R13+0, 1
	GOTO       L_SoftUart_Init0
	NOP
;Soft_Uart.c,30 :: 		}
L_end_SoftUart_Init:
	RETURN
; end of _SoftUart_Init

_Soft_UART_Write:

;Soft_Uart.c,33 :: 		void Soft_UART_Write(unsigned char Data)
;Soft_Uart.c,36 :: 		Soft_Uart_Tx = 0;
	BCF        Soft_Uart_Tx+0, BitPos(Soft_Uart_Tx+0)
;Soft_Uart.c,37 :: 		delay_us(BITPERIOD);
	MOVLW      34
	MOVWF      R13+0
L_Soft_UART_Write1:
	DECFSZ     R13+0, 1
	GOTO       L_Soft_UART_Write1
	NOP
;Soft_Uart.c,40 :: 		for (mask = 0x01; mask != 0; mask = mask << 1)
	MOVLW      1
	MOVWF      R1+0
L_Soft_UART_Write2:
	MOVF       R1+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_Soft_UART_Write3
;Soft_Uart.c,42 :: 		if (Data & mask) Soft_Uart_Tx = 1;
	MOVF       R1+0, 0
	ANDWF      FARG_Soft_UART_Write_Data+0, 0
	MOVWF      R0+0
	BTFSC      STATUS+0, 2
	GOTO       L_Soft_UART_Write5
	BSF        Soft_Uart_Tx+0, BitPos(Soft_Uart_Tx+0)
	GOTO       L_Soft_UART_Write6
L_Soft_UART_Write5:
;Soft_Uart.c,43 :: 		else Soft_Uart_Tx = 0;
	BCF        Soft_Uart_Tx+0, BitPos(Soft_Uart_Tx+0)
L_Soft_UART_Write6:
;Soft_Uart.c,44 :: 		delay_us(BITPERIOD_FOR_WRITE);      // For greater precision according to the crystal because it is 14 clock cycles
	MOVLW      29
	MOVWF      R13+0
L_Soft_UART_Write7:
	DECFSZ     R13+0, 1
	GOTO       L_Soft_UART_Write7
	NOP
	NOP
;Soft_Uart.c,40 :: 		for (mask = 0x01; mask != 0; mask = mask << 1)
	RLF        R1+0, 1
	BCF        R1+0, 0
;Soft_Uart.c,45 :: 		}
	GOTO       L_Soft_UART_Write2
L_Soft_UART_Write3:
;Soft_Uart.c,46 :: 		Soft_Uart_Tx = 1;
	BSF        Soft_Uart_Tx+0, BitPos(Soft_Uart_Tx+0)
;Soft_Uart.c,47 :: 		delay_us(BITPERIOD);
	MOVLW      34
	MOVWF      R13+0
L_Soft_UART_Write8:
	DECFSZ     R13+0, 1
	GOTO       L_Soft_UART_Write8
	NOP
;Soft_Uart.c,48 :: 		}
L_end_Soft_UART_Write:
	RETURN
; end of _Soft_UART_Write

_Soft_UART_Write_Text:

;Soft_Uart.c,51 :: 		void Soft_UART_Write_Text(char* Text)
;Soft_Uart.c,53 :: 		while (*Text)Soft_UART_Write(*Text++);
L_Soft_UART_Write_Text9:
	MOVF       FARG_Soft_UART_Write_Text_Text+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_Soft_UART_Write_Text10
	MOVF       FARG_Soft_UART_Write_Text_Text+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Soft_UART_Write_Data+0
	CALL       _Soft_UART_Write+0
	INCF       FARG_Soft_UART_Write_Text_Text+0, 1
	GOTO       L_Soft_UART_Write_Text9
L_Soft_UART_Write_Text10:
;Soft_Uart.c,54 :: 		}
L_end_Soft_UART_Write_Text:
	RETURN
; end of _Soft_UART_Write_Text

_Soft_UART_Write_Text_Const:

;Soft_Uart.c,57 :: 		void Soft_UART_Write_Text_Const(const char* Text)
;Soft_Uart.c,59 :: 		while (*Text)Soft_UART_Write(*Text++);
L_Soft_UART_Write_Text_Const11:
	MOVF       FARG_Soft_UART_Write_Text_Const_Text+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       FARG_Soft_UART_Write_Text_Const_Text+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_Soft_UART_Write_Text_Const12
	MOVF       FARG_Soft_UART_Write_Text_Const_Text+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       FARG_Soft_UART_Write_Text_Const_Text+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_Soft_UART_Write_Data+0
	CALL       _Soft_UART_Write+0
	INCF       FARG_Soft_UART_Write_Text_Const_Text+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_Soft_UART_Write_Text_Const_Text+1, 1
	GOTO       L_Soft_UART_Write_Text_Const11
L_Soft_UART_Write_Text_Const12:
;Soft_Uart.c,60 :: 		}
L_end_Soft_UART_Write_Text_Const:
	RETURN
; end of _Soft_UART_Write_Text_Const

_Soft_UART_Read:

;Soft_Uart.c,63 :: 		unsigned char Soft_UART_Read()
;Soft_Uart.c,66 :: 		char Data = 0;
	CLRF       Soft_UART_Read_Data_L0+0
;Soft_Uart.c,68 :: 		while (Soft_Uart_Rx == 1);            // Wait for start bit
L_Soft_UART_Read13:
	BTFSS      Soft_Uart_Rx+0, BitPos(Soft_Uart_Rx+0)
	GOTO       L_Soft_UART_Read14
	GOTO       L_Soft_UART_Read13
L_Soft_UART_Read14:
;Soft_Uart.c,69 :: 		delay_us(HALFBITPERIOD);
	MOVLW      17
	MOVWF      R13+0
L_Soft_UART_Read15:
	DECFSZ     R13+0, 1
	GOTO       L_Soft_UART_Read15
;Soft_Uart.c,70 :: 		for (mask = 0x01; mask != 0; mask = mask << 1)
	MOVLW      1
	MOVWF      R1+0
L_Soft_UART_Read16:
	MOVF       R1+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_Soft_UART_Read17
;Soft_Uart.c,72 :: 		delay_us(BITPERIOD_FOR_READ);       // Delay to read
	MOVLW      31
	MOVWF      R13+0
L_Soft_UART_Read19:
	DECFSZ     R13+0, 1
	GOTO       L_Soft_UART_Read19
;Soft_Uart.c,73 :: 		if (Soft_Uart_Rx) Data = Data | mask;
	BTFSS      Soft_Uart_Rx+0, BitPos(Soft_Uart_Rx+0)
	GOTO       L_Soft_UART_Read20
	MOVF       R1+0, 0
	IORWF      Soft_UART_Read_Data_L0+0, 1
L_Soft_UART_Read20:
;Soft_Uart.c,70 :: 		for (mask = 0x01; mask != 0; mask = mask << 1)
	RLF        R1+0, 1
	BCF        R1+0, 0
;Soft_Uart.c,74 :: 		}
	GOTO       L_Soft_UART_Read16
L_Soft_UART_Read17:
;Soft_Uart.c,75 :: 		Delay_us(BITPERIOD);
	MOVLW      34
	MOVWF      R13+0
L_Soft_UART_Read21:
	DECFSZ     R13+0, 1
	GOTO       L_Soft_UART_Read21
	NOP
;Soft_Uart.c,76 :: 		return Data;
	MOVF       Soft_UART_Read_Data_L0+0, 0
	MOVWF      R0+0
;Soft_Uart.c,77 :: 		}
L_end_Soft_UART_Read:
	RETURN
; end of _Soft_UART_Read

_Soft_UART_Read_Text:

;Soft_Uart.c,79 :: 		void Soft_UART_Read_Text(char* Buffer, char StopChar)
;Soft_Uart.c,81 :: 		while (*(Buffer - 1) != StopChar)    // Wait until desired character does not arrive
L_Soft_UART_Read_Text22:
	DECF       FARG_Soft_UART_Read_Text_Buffer+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORWF      FARG_Soft_UART_Read_Text_StopChar+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_Soft_UART_Read_Text23
;Soft_Uart.c,83 :: 		*Buffer++ = Soft_UART_Read();      // Keep buffering
	CALL       _Soft_UART_Read+0
	MOVF       FARG_Soft_UART_Read_Text_Buffer+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       FARG_Soft_UART_Read_Text_Buffer+0, 1
;Soft_Uart.c,84 :: 		}
	GOTO       L_Soft_UART_Read_Text22
L_Soft_UART_Read_Text23:
;Soft_Uart.c,85 :: 		*--Buffer = 0;                       // Put trailing zero to make it string
	DECF       FARG_Soft_UART_Read_Text_Buffer+0, 1
	MOVF       FARG_Soft_UART_Read_Text_Buffer+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;Soft_Uart.c,86 :: 		}
L_end_Soft_UART_Read_Text:
	RETURN
; end of _Soft_UART_Read_Text
