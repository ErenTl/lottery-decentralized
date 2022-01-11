// SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract Lottery {
    using SafeMathChainlink for uint256;

    address payable[] public players;
    address public owner;
    uint256 public entryFeeUSD;
    AggregatorV3Interface public priceFeedETHUSD;
    uint256 decimals;

    constructor(
        address _priceFeedAddress,
        uint256 _decimals,
        uint256 _entryFeeUSD
    ) public {
        entryFeeUSD = _entryFeeUSD * (10**18);
        priceFeedETHUSD = AggregatorV3Interface(_priceFeedAddress);
        decimals = _decimals;
        owner = msg.sender;
    }

    function enter() public payable {
        //$10 minimum
        players.push(msg.sender);
    }

    function getEntranceFee() public view returns (uint256) {
        uint256 eth_usd_price = getLatestPrice();
        // 10/4000
        uint256 payToEnter = (entryFeeUSD * 10**18) / eth_usd_price;
        return payToEnter;
    }

    function startLottery() public {}

    function endLottery() public {}

    function getLatestPrice() public view returns (uint256) {
        (
            uint80 roundID,
            int256 price,
            uint256 startedAt,
            uint256 timeStamp,
            uint80 answeredInRound
        ) = priceFeedETHUSD.latestRoundData();
        uint256 adjustedPrice = uint256(price) * ((18 - decimals)**10); //18 decimals
        return adjustedPrice;
    }
}
