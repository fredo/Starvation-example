// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/AssertionAdopter.sol";
import "../src/StarvationFlex.sol";

contract StarvationFlexTest is Test {
    StarvationFlex public starvation;

    function setUp() public {
        starvation = new StarvationFlex();

    }

    function addAdopters(uint32 amount) internal {
        for(uint32 i = 0; i < amount; i++){
            AssertionAdopter adopter = new AssertionAdopter();
            starvation.addAssertionAdopter(address(adopter));
        }
    }

    function test_StarvationZero() public {
        address(starvation).call("");
    }

    function test_StarvationOne() public {
        addAdopters(1);
        vm.resetGasMetering();
        address(starvation).call("");
    }

    function test_StarvationTen() public {
        addAdopters(10);
        vm.resetGasMetering();
        address(starvation).call("");
    }

    function test_StarvationHundred() public {
        addAdopters(100);
        vm.resetGasMetering();
        address(starvation).call("");
    }

    function test_StarvationFiveHundred() public {
        addAdopters(500);
        vm.resetGasMetering();
        address(starvation).call("");
    }

}
