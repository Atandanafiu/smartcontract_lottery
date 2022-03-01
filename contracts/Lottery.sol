//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract Lottery {
    address payable[] public players;
    uint256 public usdEntryFee;
    AggregatorV3Interface internal ethUSDPriceFeed;

    constructor(address _priceFeedAddress) {
        usdEntryFee = 50 * (10**18);
        ethUSDPriceFeed = AggregatorV3Interface(_priceFeedAddress);
    }

    function enter() public payable {
        require(msg.value >= getEntranceFee(), "Not enough ETH");
        players.push(payable(msg.sender));
    }

    function getEntranceFee() public view returns (uint256) {
        (, int256 price, , , ) = ethUSDPriceFeed.latestRoundData();
        //Need to convert int to uint
        uint256 ajustPrice = uint256(price) * 10**10; //It's 18 decimal
        //To set price at $50, ETH $2000
        //we need to divide it 50/2000
        //since ETH doesn't do decimal  50*100000
        uint256 costToEnter = (usdEntryFee * 10**18) / ajustPrice;
        return costToEnter;
    }

    function startLottery() public {}

    function endLottery() public {}
}
