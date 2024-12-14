/**
 *Submitted for verification at Etherscan.io on 2024-12-07
*/

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

error Exercicio2_OwnerNaoPermitido();

contract Exercicio2 {

    string private storedInfo;
    uint public counterChange = 0;
    address public s_contractOwner;

    constructor(string memory _storedInfo) {

        storedInfo = _storedInfo;
        s_contractOwner = msg.sender;
    
    }

    function setInfo(string memory newInfo) external {
        if (s_contractOwner == msg.sender) {
            storedInfo = newInfo;
            counterChange = counterChange + 1;
        }
        else revert Exercicio2_OwnerNaoPermitido();
    }

    function getInfo() external view returns(string memory){

        return storedInfo;

    }
}