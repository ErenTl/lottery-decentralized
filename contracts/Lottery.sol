// SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract Lottery {
    using SafeMathChainlink for uint256;

    address payable[] public players;
    uint256 public entryFeeUSD;
    AggregatorV3Interface public priceFeedETHUSD;

    constructor(address _priceFeedAddress) public {
        entryFeeUSD = 10 * (10**18);
        priceFeedETHUSD = AggregatorV3Interface(_priceFeedAddress);
        owner = msg.sender;
    }

    function enter() public payable {
        //$10 minimum
        players.push(msg.sender);
    }

    function getEntranceFee() public view returns (uint256) {}

    function startLottery() public {}

    function endLottery() public {}
}
