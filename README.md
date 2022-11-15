#  digital_systems
This is a repository of digital systems' projects described using VHDL, written and simulated using Xilinx ISE WebPack.
Some of them will also be tested on FPGA: they're still initially written in Xilinx ISE and then imported in Vivado.

## Exercises

### Exercise 1
* **decoder_esercizio_1**: 4:16 decoder using 2:4 decoder components a) in a tree structure and b) in a semi-selection structure.

### Exercise 2
* **seq_rec_esercizio_2**: sequence recognition 1-1 with Flip-Flop D.

### Exercise 3
* **orologio_esercizio_3**: clock (synthesized on FPGA).

### Exercise 4
* **shift_register_esercizio_4**: 4-bit sliding register that can operate, according to a selection, in 4 different modes (Left scrolling with serial loading of a bit equal to 0, (2) right scrolling with serial loading of a bit equal to 0, (3) circular scrolling to the left, (4) left scrolling with serial loading of an x bit).

### Exercise 5
* **a_mod_b_esercizio_5**: system that, given two binary strings A and B of 8 bits each acquired by handshaking, calculates the value A mod B.
The system shall be designed using a modular approach based on the identification of the operational part and the control part, and the control part shall be implemented by means of (a) wired logic and (b) microprogrammed logic.

### Exercise 6
* **buffer_esercizio_6**: system to send two 16-bit words each from one unit A to one unit B. The two units do not have a direct connection consisting of a 16-bit bus, but unit A has a 4-bit bus output and unit B has an 8-bit bus input. For this reason, the transfer must take place in several steps using a buffer.

### Exercise 7
* **prodotto_scalare_esercizio_7**: system able to calculate the scalar product between 2 vectors A and B of elements M, each encoded on bits N (vectors preloaded in ROM).

### Exercise 8
* **processore_esercizio_8**: analysis of the architecture of a processor operating according to the IJVM model.

### Exercise 9
* **seriale_esercizio_9**: taking advantage of the implementation provided by Digilent of a UART device design and implement in VHDL the following components UART_TAPPO, 2_UART, UART_PC.

### Exercise 10
* **switch_esercizio_10**: Multistage switch according to the omega network model.

### Exercise 11
* **macchina_aritmetica_11**: Robertson multiplier to make the product of 2 strings A and B of 8 bits each.

### Exam's Exercise
* **Multiplier_check**
