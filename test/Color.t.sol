// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Color.sol";

contract ColorTest is Test {
    using LibColor for Color;
    //Counter public counter;

    function setUp() public {
   
    }

    function testRGB(uint8 red, uint8 green, uint8 blue) public {
        Color _color = newColorFromRGB(red, green, blue);
        (uint8 _red, uint8 _green, uint8 _blue) = _color.toRGB();

        assertEq(_red, red);
        assertEq(_green,green);
        assertEq(_blue,blue);
    }

    function testHSVSample() public {
        
        Color _colorToHSV = newColorFromRGB(112, 172, 182);
        (uint16 _h, uint8 _s, uint8 _v) = _colorToHSV.toHSVScaled();

        assertEq(
            _h,
            135
        );

        assertEq(
            _s,
            98
        );

        assertEq(
            _v,
            182
        );
        console.log(
            "Color to HSV",
            _h,
            _s,
            _v
        );
    }

    function testHSVman() public {
        
        Color _colorToHSV = newColorFromRGB(219, 132, 163);
        (uint16 _h, uint8 _s, uint8 _v) = _colorToHSV.toHSV();

        console.log(
            "Color to HSV",
            _h,
            _s,
            _v
        );
    }
    // function testHSV(uint8 hue, uint8 saturation, uint8 value) public {
    //     Color _color = newColorFromScaledHSV(hue, saturation, value);
    //     (uint8 _h, uint8 _s, uint8 _v) = _color.toHSVScaled();

    //     console.log(
    //         string.concat(
    //             "#",
    //             _color.toString()
    //         )
    //     );

    //     assertEq(_h, hue, "HUE");
    //     assertEq(_s, saturation, "SATURATION");
    //     assertEq(_v, value, "VALUE");
    // }

    function testFromBytes3(bytes3 color) public {

        Color _color = newColorFromRGBString("FF00FF");

        console.log(
            string.concat(
                "#",
                _color.toString()
            )
        );
    }
}
