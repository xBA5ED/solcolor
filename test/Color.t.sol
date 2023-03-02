// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Color.sol";

contract ColorTest is Test {
    using LibColor for Color;
    //Counter public counter;

    function setUp() public {
   
    }

    function testFromRGB() public {

        Color _color = newColorFromRGBString("FF00FF");

        console.log(
            string.concat(
                "#",
                _color.toString()
            )
        );
    }
}
