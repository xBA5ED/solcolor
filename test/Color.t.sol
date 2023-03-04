// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {Color, LibColor, newColorFromRGBString, newColorFromRGB} from "../src/Color.sol";

contract ColorTest is Test {
    using LibColor for Color;
    //Counter public counter;

    function setUp() public {
   
    }

    function testRGB(uint8 red, uint8 green, uint8 blue) public {
        Color _color = newColorFromRGB(red, green, blue);
        (uint8 _red, uint8 _green, uint8 _blue) = _color.toRGB();

        assertEq(_red, red);
        assertEq( _green,green);
        assertEq(_blue,blue);
    }

    // function testFromBytes3() view public {
    //     Color _color = newColorFromRGBString("FF00FF");

    //     console.log(
    //         string.concat(
    //             "#",
    //             _color.toString()
    //         )
    //     );
    // }

    function testFromString_longFormatHex() public {
        assertEq(
            newColorFromRGBString("123456").toString(),
            "123456"
        );

        assertEq(
            newColorFromRGBString("654321").toString(),
            "654321"
        );

        assertEq(
            newColorFromRGBString("AAAAAA").toString(),
            "AAAAAA"
        );
    }

    function testFromString_longFormatHexPrefixed() public {
        assertEq(
            newColorFromRGBString("#123456").toString(),
            "123456"
        );

        assertEq(
            newColorFromRGBString("#654321").toString(),
            "654321"
        );

        assertEq(
            newColorFromRGBString("#AAAAAA").toString(),
            "AAAAAA"
        );
    }

    function testFromString_shortFormatHex() public {
        assertEq(
            newColorFromRGBString("123").toString(),
            "112233"
        );

        assertEq(
            newColorFromRGBString("321").toString(),
            "332211"
        );

        assertEq(
            newColorFromRGBString("AAA").toString(),
            "AAAAAA"
        );
    }

    function testFromString_shortFormatHexPrefixed() public {
        assertEq(
            newColorFromRGBString("#123").toString(),
            "112233"
        );

        assertEq(
            newColorFromRGBString("#321").toString(),
            "332211"
        );

        assertEq(
            newColorFromRGBString("#AAA").toString(),
            "AAAAAA"
        );
    }

    function testFromString_gasS() public {
        newColorFromRGBString("123");
    }
      function testFromString_gasL() public {
        newColorFromRGBString("112233");
    }
}
