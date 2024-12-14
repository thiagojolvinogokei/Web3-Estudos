// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.20;

contract Exercicio4 {
    string private s_storedInfo;
    address public s_contractOwner;

    constructor(string memory myInfo) {
        s_storedInfo = myInfo;
        s_contractOwner = msg.sender;
    }

    function setInfo(string memory myInfo) external {
        // Check if the caller is the contract owner
        require(msg.sender == s_contractOwner, "Only the contract owner can call this function");
        s_storedInfo = myInfo;
    }

    function getInfo() external view returns (string memory) {
        return s_storedInfo;
    }
}
