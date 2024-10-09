// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract AssertionAdopter {
    receive() external payable{}
}

contract Starvation {

    address internal constant SENTINEL = address(0x1);

    // linked set
    mapping(address => address) public assertionAdopters;

    modifier notSentinel(address adopter){
        require(adopter != SENTINEL, "Cannot be sentinel adopter");
        _;
    }

    function addAssertionAdopter(address adopter) notSentinel(adopter) external {
        require(assertionAdopters[adopter] == address(0), "Assertion adopter already registered");
        if(assertionAdopters[SENTINEL] == address(0)){
            assertionAdopters[adopter] = SENTINEL;
        }
        else {
            assertionAdopters[adopter] = assertionAdopters[SENTINEL];
        }
        assertionAdopters[SENTINEL] = adopter;
    }

    function removeAssertionAdopter(address previousAdopter, address adopter) notSentinel(adopter) external{
        require(assertionAdopters[previousAdopter] == adopter, "Not previous element in set");
        assertionAdopters[previousAdopter] = assertionAdopters[adopter];
    }


}
