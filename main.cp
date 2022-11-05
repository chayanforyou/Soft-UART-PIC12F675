#line 1 "C:/Users/Minion/Desktop/Soft UART PIC12F675/main.c"
#line 1 "c:/users/minion/desktop/soft uart pic12f675/soft_uart.h"
#line 6 "c:/users/minion/desktop/soft uart pic12f675/soft_uart.h"
void SoftUart_Init();
void Soft_UART_Write(unsigned char Data);
void Soft_UART_Write_Text(char* Text);
void Soft_UART_Write_Text_Const(const char* Text);
unsigned char Soft_UART_Read();
void Soft_UART_Read_Text(char* Buffer, char StopChar);
#line 4 "C:/Users/Minion/Desktop/Soft UART PIC12F675/main.c"
sbit Soft_Uart_Tx at GPIO.B0;
sbit Soft_Uart_Rx at GPIO.B1;
sbit Soft_Uart_Tx_Direction at TRISIO.B0;
sbit Soft_Uart_Rx_Direction at TRISIO.B1;

unsigned char i, byte_read;
unsigned char text[15];
unsigned short count;

void main()
{
 OSCCAL = 0x20;
 ANSEL = 0x00;
 ADCON0 = 0x00;
 CMCON = 0x07;
 VRCON = 0x00;
 TRISIO = 0x00;
 GPIO = 0x00;

 Delay_ms(500);

 SoftUart_Init();
 Soft_UART_Write_Text_Const("STARTING...");
 Soft_UART_Write_Text_Const("\r\n\r\n");

 for (i = 'A'; i <= 'Z'; i++) {
 Soft_UART_Write(i);
 Delay_ms(100);
 }
 Soft_UART_Write_Text_Const("\r\n\r\n");


 while (1)
 {

 Soft_UART_Write_Text_Const("Type message & press Enter: ");
 Soft_UART_Read_Text(text, '\r\n');
 Soft_UART_Write_text(text);
 Soft_UART_Write_Text("\r\n\r\n");


 Soft_UART_Write_Text_Const("Waiting for a single input");
 Soft_UART_Write_Text_Const("\r\n");
 byte_read = Soft_UART_Read();
 Soft_UART_Write_Text_Const("\r\n");
 Soft_UART_Write_Text_Const("Input: ");
 Soft_UART_Write(byte_read);
 Soft_UART_Write_Text_Const("\r\n\r\n");


 count++;
 Soft_UART_Write_Text_Const("Counter: ");
 WordToStr(count, text);
 Soft_UART_Write_text(text);
 Soft_UART_Write_Text_Const("\r\n\r\n");

 Soft_UART_Write_Text_Const("=============================");
 Soft_UART_Write_Text_Const("\r\n\r\n");

 Delay_ms(20);
 }
}
