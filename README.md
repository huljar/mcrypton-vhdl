# mCrypton block cipher - VHDL implementation

This is an implementation of the mCrypton lightweight block cipher
as described in [this paper](http://link.springer.com/chapter/10.1007/11604938_19).
It encrypts individual blocks of 64 bit length with a 96 bit key.

## Limitations

Currently, only the 96 bit version of mCrypton is supported. In
a future release, the 64 and 128 bit versions are planned to be
supported as well.

## License
The code is licensed under the terms of the MIT license. For more
information, please see the [LICENSE.md](LICENSE.md) file.
