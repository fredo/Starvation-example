// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract AssertionAdopter {
    receive() external payable{}
}

contract StarvationOptimized {

    fallback(bytes calldata data) external returns (bytes memory){
        address[] memory adopters = abi.decode(data, (address[]));
        for(uint i=0; i < adopters.length; i++){
            adopters[i].call{value: 1}("");
        }
        return "";
    }
}
