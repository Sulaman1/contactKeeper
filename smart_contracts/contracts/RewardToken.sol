//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./CertCoin.sol";

contract RewardToken {
    string public name = "RewardToken";

    CertCoin public certCoin;

    address[] public stackers;
    mapping(address => uint256) public stackAmount;
    mapping(address => bool) public hasStacked;
    mapping(address => bool) public isStacking;

    event StackEvent(address sender, address stacker, uint256 value);

    constructor(CertCoin _certCoin) {
        certCoin = _certCoin;
    }

    // Stacking
    function StackingCert(uint256 _value) public {
        require(_value > 0, "Your amount cant be 0 or less");

        // certCoin.transferFrom(msg.sender, address(this), _value);
        stackAmount[msg.sender] = stackAmount[msg.sender] + _value;

        if (!hasStacked[msg.sender]) {
            stackers.push(msg.sender);
        }
        isStacking[msg.sender] = true;
        hasStacked[msg.sender] = true;

        emit StackEvent(msg.sender, address(this), _value);
    }

    // Unstaking
    function UnStackingCert() public {
        require(hasStacked[msg.sender], "");

        //msg.sender.transfer(stackAmount[msg.sender]);
        certCoin.transfer(msg.sender, stackAmount[msg.sender]);
        stackAmount[msg.sender] = 0;
        hasStacked[msg.sender] = false;
    }

    // EarnReward
    function issueToken() public {
        uint256 balance;
        for (uint256 i = 0; i < stackers.length; i++) {
            address add;
            add = stackers[i];

            balance = stackAmount[add];

            if (balance > 0) {
                certCoin.transfer(add, balance);
            }
        }
    }
}
