#line 1 "C:/Users/Minion/Desktop/Soft UART PIC12F675/Soft_Uart.c"
#line 1 "c:/users/minion/desktop/soft uart pic12f675/soft_uart.h"
#line 6 "c:/users/minion/desktop/soft uart pic12f675/soft_uart.h"
void SoftUart_Init();
void Soft_UART_Write(unsigned char Data);
void Soft_UART_Write_Text(char* Text);
void Soft_UART_Write_Text_Const(const char* Text);
unsigned char Soft_UART_Read();
void Soft_UART_Read_Text(char* Buffer, char StopChar);
#line 4 "C:/Users/Minion/Desktop/Soft UART PIC12F675/Soft_Uart.c"
extern sfr sbit Soft_Uart_Tx;
extern sfr sbit Soft_Uart_Rx;
extern sfr sbit Soft_Uart_Tx_Direction ;
extern sfr sbit Soft_Uart_Rx_Direction;


const unsigned char cristal = Clock_MHz();
#line 22 "C:/Users/Minion/Desktop/Soft UART PIC12F675/Soft_Uart.c"
void SoftUart_Init()
{
 Soft_Uart_Tx = 1;
 Soft_Uart_Rx = 1;
 Soft_Uart_Tx_Direction = 0;
 Soft_Uart_Rx_Direction = 1;
 Soft_Uart_Tx = 1;
 delay_us( ((1000000/ 9600 )) );
}


void Soft_UART_Write(unsigned char Data)
{
 unsigned char mask;
 Soft_Uart_Tx = 0;
 delay_us( ((1000000/ 9600 )) );


 for (mask = 0x01; mask != 0; mask = mask << 1)
 {
 if (Data & mask) Soft_Uart_Tx = 1;
 else Soft_Uart_Tx = 0;
 delay_us( ( ((1000000/ 9600 ))  - (4*14/cristal) ) );
 }
 Soft_Uart_Tx = 1;
 delay_us( ((1000000/ 9600 )) );
}


void Soft_UART_Write_Text(char* Text)
{
 while (*Text)Soft_UART_Write(*Text++);
}


void Soft_UART_Write_Text_Const(const char* Text)
{
 while (*Text)Soft_UART_Write(*Text++);
}


unsigned char Soft_UART_Read()
{
 char mask;
 char Data = 0;

 while (Soft_Uart_Rx == 1);
 delay_us( ( ((1000000/ 9600 )) /2) );
 for (mask = 0x01; mask != 0; mask = mask << 1)
 {
 delay_us( ( ((1000000/ 9600 ))  - (4*10/cristal) ) );
 if (Soft_Uart_Rx) Data = Data | mask;
 }
 Delay_us( ((1000000/ 9600 )) );
 return Data;
}

void Soft_UART_Read_Text(char* Buffer, char StopChar)
{
 while (*(Buffer - 1) != StopChar)
 {
 *Buffer++ = Soft_UART_Read();
 }
 *--Buffer = 0;
}
