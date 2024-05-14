// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/**
 * @title A Raffle Contract
 * @author Fraol Bereket
 * @notice This is a smart contract using chainlink vrf and automation for lottery system
 */

contract Raffle {
    error Raffle__NotEnoughETHSent();

    uint256 private immutable i_entranceFee;
    uint256 private immutable i_interval;
    address payable[] private s_players;
    uint256 private s_lastTimeStamp;

    event EnteredRaffle(address indexed player);

    constructor(uint256 entranceFee, uint256 interval) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
    }

    function enterRaffle() external payable {
        //require(msg.value >= i_entranceFee, "Not enought ETH sent!");
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnoughETHSent();
        }

        s_players.push(payable(msg.sender));
        emit EnteredRaffle(msg.sender);
    }

    function pickWinner() public {
        if (block.timestamp - s_lastTimeStamp < i_interval) {
            revert();
        }
    }

    //Getter Function
    function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
    }
}
