// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/AssertionAdopter.sol";
import "../src/StarvationOptimized.sol";

contract StarvationOptimizedTest is Test {
    StarvationOptimized public starvation;

    function setUp() public {
        starvation = new StarvationOptimized();

    }

    function addAdopters(uint32 amount) internal returns (bytes memory){
        address[] memory adopters = new address[](amount);
        for(uint32 i = 0; i < amount; i++){
            AssertionAdopter adopter = new AssertionAdopter();
            adopters[i] = address(adopter);
        }
        return abi.encodePacked(adopters);
    }

    function test_StarvationZero() public {
        address(starvation).call("");
    }

    function test_StarvationOne() public {
        bytes memory adopterData = addAdopters(1);
        vm.resetGasMetering();
        address(starvation).call(adopterData);
    }

    function test_StarvationTen() public {
        bytes memory adopterData = addAdopters(10);
        vm.resetGasMetering();
        address(starvation).call(adopterData);
    }

    function test_StarvationHundred() public {
        bytes memory adopterData = addAdopters(100);
        vm.resetGasMetering();
        address(starvation).call(adopterData);
    }

    function test_StarvationFiveHundred() public {
        bytes memory adopterData = addAdopters(500);
        vm.resetGasMetering();
        address(starvation).call(adopterData);
    }

}
