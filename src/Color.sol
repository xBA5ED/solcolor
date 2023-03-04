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

    function uint8tohexchar(uint8 i) internal pure returns (uint8) {
        return (i > 9) ?
            (i + 87) : // ascii a-f
            (i + 48); // ascii 0-9
    }
    

    // function toHSVScaled(Color c) internal pure returns (uint8, uint8, uint8) {
    //     (uint8 _r, uint8 _g, uint8 _b) = LibColor.toRGB(c);
        
    //     uint8 rgbMin = min(_r, min(_g, _b));
    //     uint8 rgbMax = max(_r, max(_g, _b));

    //     unchecked {
    //         uint8 _v = rgbMax;
    //         if(_v == 0) return (0, 0, 0);
    //         uint8 _s = uint8(uint256(255) * (rgbMax - rgbMin) / _v);
    //         if(_s == 0) return (0, 0, _v);

            
    //         if(rgbMax == _r) return(0 + 43 * (_g  - _b) / (rgbMax - rgbMin), _s, _v);
    //         if(rgbMax == _g) return(85 + 43 * (_b  - _r) / (rgbMax - rgbMin), _s, _v);

    //         return(uint8(171 + 43 * (_b  - _g) / (rgbMax - rgbMin)), _s, _v);
    //     }
    // }

    function toHSVScaled(Color c) internal pure returns (uint8, uint8, uint8) {
        (uint8 _r, uint8 _g, uint8 _b) = LibColor.toRGB(c);
        
        uint8 rgbMin = min(_r, min(_g, _b));
        uint8 rgbMax = max(_r, max(_g, _b));

        if(rgbMax == 0) return (0, 0, 0);

        uint8 _val = rgbMax;
        uint8 _sat = uint8(255 * uint256(rgbMax - rgbMin) / _val);

        if(_sat == 0) return (0, 0, _val);

        uint8 _hue;
        unchecked {
            if(_r == rgbMax){
                _hue = (_g - _b);
                _hue = uint8( 0 + uint256(43) * (_g - _b) / (rgbMax - rgbMin));
            }else if (_g == rgbMax){
                _hue = uint8( 85 + uint256(43) * (_b - _r ) / (rgbMax - rgbMin));
            }else{ /* rgb_max == rgb.b */ 
                _hue = uint8( 171 + uint256(43) * (_r - _g) / (rgbMax - rgbMin));
            }
        }

        return (_hue, _sat, _val);
    }

    function max(uint8 a, uint8 b) private pure returns (uint8) {
        return a > b ? a : b;
    }

    function min(uint8 a, uint8 b) private pure returns (uint8) {
        return a < b ? a : b;
    }

    function toHSV(Color c) internal pure returns (uint16, uint8, uint8) {
        (uint8 _h, uint8 _s, uint8 _v) = LibColor.toHSVScaled(c);
        
        return (uint16(uint32(_h) * 360 / 255), uint8(uint16(_s) * 100 / 255), uint8(uint16(_v) * 100 / 255));
    }
}