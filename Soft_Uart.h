/**
 * Communication Speed
 */
#define BAUDRATE 9600

void SoftUart_Init();
void Soft_UART_Write(unsigned char Data);
void Soft_UART_Write_Text(char* Text);
void Soft_UART_Write_Text_Const(const char* Text);
unsigned char Soft_UART_Read();
void Soft_UART_Read_Text(char* Buffer, char StopChar);