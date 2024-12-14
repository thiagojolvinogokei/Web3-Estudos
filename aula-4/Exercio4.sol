/**
 *Submitted for verification at Etherscan.io on 2024-12-07
*/

// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.20;
/// @title Storage string
/// @author Solange Gueiros
contract Exercicio4 {
    string private s_storedInfo;
    address public s_contractOwner; // Endereço Ethereum

    constructor(string memory myInfo) {
        s_storedInfo = myInfo;
        s_contractOwner = msg.sender; //variável global
    }

    /// @param myInfo the new string to store
    function setInfo(string memory myInfo) external {
        if(s_contractOwner ==  msg.sender){
            s_storedInfo = myInfo;
        }
    }

    /// Return the stored string
    /// @dev retrieves the string of the state variable `storedInfo`
    /// @return the stored string
    function getInfo() external view returns (string memory) {
        return s_storedInfo;
    }



}