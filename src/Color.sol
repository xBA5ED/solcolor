// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./Types.sol";
import "./Create.sol";

library LibColor {

    /// @notice Transforms a RGB Color value to a bytes3.
    /// @param c A RGB Color.
    /// @return bytes3 Unwrapped bytes3 color value.
    function toBytes3(Color c) internal pure returns (bytes3) {
        return Color.unwrap(c);
    }

    /// @notice Transforms a RGB Color to three uint8 values.
    /// @param c A bytes3 encoded RGB value
    /// @return red uint8 Red value, 0-255.
    /// @return green uint8 Green value, 0-255.
    /// @return blue uint8 Blue value, 0-255
    function toRGB(Color c) internal pure returns (uint8 red, uint8 green, uint8 blue) {
        return (
            uint8(uint24(Color.unwrap(c)) >> 16),
            uint8(uint24(Color.unwrap(c)) >> 8),
            uint8(uint24(Color.unwrap(c)))
        );
    }

    /// @notice Transforms a RGB Color to a string encoded Hex color.
    /// @dev Based on https://stackoverflow.com/a/69316712
    /// @param c A bytes3 encoded RGB value
    /// @return string A Hex color string (e.g., "FFFFFF")
    function toString(Color c) internal pure returns(string memory){
        bytes memory o = new bytes(6);
        o[5] = bytes1(uint8tohexchar(uint8(uint24(Color.unwrap(c)) & 0xf)));
        o[4] = bytes1(uint8tohexchar(uint8(uint24(Color.unwrap(c)) >> 4 & 0xf)));
        o[3] = bytes1(uint8tohexchar(uint8(uint24(Color.unwrap(c)) >> 8 & 0xf)));
        o[2] = bytes1(uint8tohexchar(uint8(uint24(Color.unwrap(c)) >> 12 & 0xf)));
        o[1] = bytes1(uint8tohexchar(uint8(uint24(Color.unwrap(c)) >> 16 & 0xf)));
        o[0] = bytes1(uint8tohexchar(uint8(uint24(Color.unwrap(c)) >> 20 & 0xf)));
        return string(o);
    }

    /// @notice Returns the ASCII character code number of the least significant digit of the Hex representation of the given uint8. 
    /// @dev For example, input `10` is `0x0A` in hex and this function returns 65, which corresponds to the ASCII symbol `A`.
    function uint8tohexchar(uint8 i) private pure returns (uint8) {
        unchecked{
            return (i > 9) ?
                (i + 55) : // ascii A-F
                (i + 48); // ascii 0-9
        }
    }
}