# VHDL-Pipelined-Mips-Processor-Implementation

In this project, a 24-bit pipelined processor is implemented in VHDL featuring hazard detection and forwarding.
The processor includes a hazard detection unit to determine when a stall cycle must be added. Due to data forwarding, this will only happen when a value is used immediately after being loaded from memory, so data forwarding eliminates most stall cycles. The hazard detection unit prevents the program counter from updating with its next value to stall the program for one clock cycle. 

# Implemented By :
                   1- Maryam Hilmy Awad (Benha Faculty of Engineering)
                   2- Omar Ahmed Yousef (Benha Faculty of Engineering)
                   3- Amir Tarek Mohamed (Benha Faculty of Engineering)
