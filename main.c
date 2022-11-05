#include "Soft_Uart.h"

// Define TX, RX Pin
sbit Soft_Uart_Tx at GPIO.B0;
sbit Soft_Uart_Rx at GPIO.B1;
sbit Soft_Uart_Tx_Direction at TRISIO.B0;
sbit Soft_Uart_Rx_Direction at TRISIO.B1;

unsigned char i, byte_read;        // Auxiliary variables
unsigned char text[15];
unsigned short count;

void main()
{
  OSCCAL  = 0x20;     // Load the calibration value of the internal oscillator
  ANSEL   = 0x00;     // Set ports as digital I/O, not analog input
  ADCON0  = 0x00;     // Shut off the A/D Converter
  CMCON   = 0x07;     // Shut off the Comparator
  VRCON   = 0x00;     // Shut off the Voltage Reference
  TRISIO  = 0x00;     // All Output
  GPIO    = 0x00;     // Make all Pin Low

  Delay_ms(500);

  SoftUart_Init();                              // Initialize Serial Communication (9600 default)
  Soft_UART_Write_Text_Const("STARTING...");
  Soft_UART_Write_Text_Const("\r\n\r\n");

  for (i = 'A'; i <= 'Z'; i++) {                // Send bytes from 'A' to 'Z'
    Soft_UART_Write(i);
    Delay_ms(100);
  }
  Soft_UART_Write_Text_Const("\r\n\r\n");


  while (1)
  {
    // ---------- Example 1 ----------
    Soft_UART_Write_Text_Const("Type message & press Enter: ");
    Soft_UART_Read_Text(text, '\r\n');       // Read until the CR + LF arrives
    Soft_UART_Write_text(text);              // Print text
    Soft_UART_Write_Text("\r\n\r\n");

    // ---------- Example 2 ----------
    Soft_UART_Write_Text_Const("Waiting for a single input");
    Soft_UART_Write_Text_Const("\r\n");     // Newline
    byte_read = Soft_UART_Read();           // Read data
    Soft_UART_Write_Text_Const("\r\n");     // Newline
    Soft_UART_Write_Text_Const("Input: ");
    Soft_UART_Write(byte_read);             // Print data
    Soft_UART_Write_Text_Const("\r\n\r\n");

    // ---------- Example 3 ----------
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