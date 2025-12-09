// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Listing {
    struct Item {
        string name;
        uint listingPrice;
        bool sold;
        bool sent;
        bool recieved;
        address seller;
    }

    struct Buyer {
        address addr;
        uint biddingPrice;
    }

    Item private item;
    Buyer private buyer;

    constructor(string memory _name, uint _listingPrice) {
        item.name = _name;
        item.listingPrice = _listingPrice;
        item.seller = msg.sender;

        buyer.addr = address(0);
        buyer.biddingPrice = 0;
    }


    function bid() external payable {
        require(msg.value >= item.listingPrice, "Bid is too low");
        require(item.sold == false, "Item is already sold!");
        require(msg.value > buyer.biddingPrice, "Another bidder has bid higher!");

        if(buyer.addr != address(0)) {
            address payable _to = payable(buyer.addr);
            _to.transfer(buyer.biddingPrice);
        }

        buyer.addr = msg.sender;
        buyer.biddingPrice = msg.value;
    }

    function endBidding() external {
        require(msg.sender == item.seller, "Only the seller can end the bidding");
        require(buyer.addr != address(0), "Item is not sold yet!");
        require(item.sold == false, "bidding already ended");

        item.sold = true;
    }

    function itemSent() external{
        require(msg.sender == item.seller, "Only seller can send item");
        require(item.sold, "Item must be sold");
        item.sent = true;
    }

    function itemRecieved() external {
        require(msg.sender == buyer.addr, "Only the buyer can mark item as recieved");
        require(item.sent, "item must be sent");
        item.recieved = true;

        address payable _to = payable(item.seller);
        _to.transfer(buyer.biddingPrice);
    }

    function getName() public view returns(string memory){
        return item.name;
    }

    function isSent() public view returns(bool){
        return item.sent;
    }

    function isRecieved() public view returns(bool) {
        return item.recieved;
    }

    function getBuyer() public view returns(address) {
        require(item.sold, "item is not sold yet");
        return buyer.addr;
    }

    function getPrice() public view returns(uint) {
        if(buyer.biddingPrice == 0) {
            return item.listingPrice;
        }
        return buyer.biddingPrice;
    }
}
