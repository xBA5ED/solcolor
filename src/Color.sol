// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./Types.sol";
import "./Create.sol";

library LibColor {

    function toBytes3(Color c) internal pure returns (bytes3) {
        return Color.unwrap(c);
    }

    function toRGB(Color c) internal pure returns (uint8 red, uint8 green, uint8 blue) {
        uint24 i = uint24(Color.unwrap(c));
        return (
            uint8(i >> 16),
            uint8(i >> 8),
            uint8(i)
        );
    }

    // https://stackoverflow.com/a/69316712
    function toString(Color c) internal pure returns(string memory){
        uint24 i = uint24(Color.unwrap(c));
        bytes memory o = new bytes(6);
        uint24 mask = 0x00000f;
        o[5] = bytes1(uint8tohexchar(uint8(i & mask)));
        i = i >> 4;
        o[4] = bytes1(uint8tohexchar(uint8(i & mask)));
        i = i >> 4;
        o[3] = bytes1(uint8tohexchar(uint8(i & mask)));
        i = i >> 4;
        o[2] = bytes1(uint8tohexchar(uint8(i & mask)));
        i = i >> 4;
        o[1] = bytes1(uint8tohexchar(uint8(i & mask)));
        i = i >> 4;
        o[0] = bytes1(uint8tohexchar(uint8(i & mask)));

        return string(o);
    }

    function uint8tohexchar(uint8 i) private pure returns (uint8) {
        return (i > 9) ?
            (i + 55) : // ascii A-F
            (i + 48); // ascii 0-9
    }
}