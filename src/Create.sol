// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./Types.sol";


function newColorFromRGB(uint8 _red, uint8 _green, uint8 _blue) pure returns (Color) {
    return Color.wrap(
        bytes3(uint24(_blue)) | (bytes3(uint24(_green)) << 8) | bytes3(uint24(_red)) << 16
    );
}

function newColorFromRGB(bytes3 _rgb) pure returns (Color) {
    return Color.wrap(_rgb);
}

// Credits @DrGorilla_md
function newColorFromRGBString(string memory _data) pure returns (Color) {
    bytes memory _tmp = bytes(_data);
    bytes3 _out;

    for(uint256 i; i < 6; i++) {
        uint256 _index = uint8(_tmp[5 - i]);
        if (_index >= 48 && _index <= 57) {
            _index -= 48;
        } else if (_index >= 65 && _index <= 70) {
            _index -= 55;
        } else {
            revert("Invalid hex character");
        }
        _out |= bytes3(uint24(_index << i * 4));
    }

    return Color.wrap(_out);
}
