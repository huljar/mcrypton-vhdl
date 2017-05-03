# mCrypton block cipher - VHDL implementation

This is an implementation of the mCrypton lightweight block cipher
as described in [this paper](http://link.springer.com/chapter/10.1007/11604938_19).
It encrypts individual blocks of 64 bit length with a 64, 96, or 128 bit key.

## Xilinx Vivado project file

The Vivado project file *(&ast;.xpr)* is configured to use the *Digilent Zybo*
FPGA board for synthesis. This board is not available by default in Vivado
(at least not if you are using the WebPACK edition). To obtain the required
board files for the *Zybo* (and other boards by Digilent), refer to
[this wiki entry](https://reference.digilentinc.com/reference/software/vivado/board-files).

## License
The code is licensed under the terms of the MIT license. For more
information, please see the [LICENSE.md](LICENSE.md) file.
