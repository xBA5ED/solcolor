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

// // https://stackoverflow.com/a/14733008
// function newColorFromHSV(uint8 _h, uint8 _s, uint8 _v) pure returns (Color) {
//     if (_s == 0)
//         return newColorFromRGB(_v, _v, _v);
    
//     unchecked{
//         uint8 _region = _h / 43;
//         uint8 _remainder = (_h - (_region * 43)) * 6;

//         uint8 _p = (_v * (255 - _s)) >> 8;
//         uint8 _q = (_v * (255 - ((_s * _remainder) >> 8))) >> 8;
//         uint8 _t = (_v * (255 - ((_s * (255 - _remainder)) >> 8 ))) >> 8;

//         if(_region <= 4){
//             if(_region == 0){
//                 return newColorFromRGB(_v, _t, _p);
//             }else if(_region == 1){
//                 return newColorFromRGB(_q, _v, _p);
//             }else if(_region == 2){
//             return newColorFromRGB(_p, _v, _t);
//             }else if(_region == 3){
//                 return newColorFromRGB(_p, _q, _v);
//             }else if(_region == 4){
//                 return newColorFromRGB(_t, _p, _v);
//             }
//         }

//         return newColorFromRGB(_v, _p, _q);
//     }
// }
