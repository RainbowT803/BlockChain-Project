// SPDX-License-Identifier: GPL-3.0
// This license specifies that the code is open source under GNU General Public License v3.0

pragma solidity >=0.8.2 <0.9.0;
// Specifies compatible Solidity compiler versions (0.8.2 to 0.9.0 exclusive)

contract Listing {
    // This is the main contract that implements a decentralized item listing and bidding system
    
    // STRUCT DECLARATIONS
    
    struct Item {
        string name;        // Name/description of the listed item
        uint listingPrice;  // Minimum price set by seller (in wei)
        bool sold;          // Tracks if item has been sold (bidding ended)
        bool sent;          // Tracks if seller has shipped the item
        bool recieved;      // Tracks if buyer has received the item (note: misspelled as "recieved")
        address seller;     // Ethereum address of the seller
    }
    
    struct Buyer {
        address addr;       // Ethereum address of the current highest bidder
        uint biddingPrice;  // Current highest bid amount (in wei)
    }
    
    // STATE VARIABLES
    Item private item;      // Private variable storing the listed item details
    Buyer private buyer;    // Private variable storing the current highest bidder information
    
    // CONSTRUCTOR FUNCTION
    // Called once when contract is deployed
    constructor(string memory _name, uint _listingPrice) {
        // Initialize the item with provided parameters
        item.name = _name;
        item.listingPrice = _listingPrice;  // Set minimum price for bidding
        item.seller = msg.sender;           // Set seller as contract deployer
        
        // Initialize buyer with default values (no buyer yet)
        buyer.addr = address(0);           // Zero address indicates no buyer
        buyer.biddingPrice = 0;            // No bid amount yet
    }
    
    // BID FUNCTION
    // Allows users to place bids on the item
    function bid() external payable {
        // Validate bid requirements:
        require(msg.value >= item.listingPrice, "Bid is too low");        // Bid must meet minimum price
        require(item.sold == false, "Item is already sold!");             // Item must not be sold already
        require(msg.value > buyer.biddingPrice, "Another bidder has bid higher!");  // Bid must exceed current highest
        
        // If there's already a previous highest bidder, refund them
        if(buyer.addr != address(0)) {
            address payable _to = payable(buyer.addr);  // Convert to payable address
            _to.transfer(buyer.biddingPrice);           // Send back their previous bid
        }
        
        // Update to new highest bidder
        buyer.addr = msg.sender;      // Set new bidder address
        buyer.biddingPrice = msg.value; // Set new highest bid amount
    }
    
    // END BIDDING FUNCTION
    // Allows seller to finalize the auction
    function endBidding() external {
        // Validate seller authorization and contract state:
        require(msg.sender == item.seller, "Only the seller can end the bidding");  // Only seller can call
        require(buyer.addr != address(0), "Item is not sold yet!");                 // Must have at least one bid
        require(item.sold == false, "bidding already ended");                       // Bidding must not already be ended
        
        item.sold = true;  // Mark item as sold, ending the bidding phase
    }
    
    // ITEM SENT FUNCTION
    // Allows seller to mark item as shipped
    function itemSent() external {
        // Validate seller authorization and contract state:
        require(msg.sender == item.seller, "Only seller can send item");  // Only seller can call
        require(item.sold, "Item must be sold");                          // Item must be in sold state
        
        item.sent = true;  // Mark item as shipped by seller
    }
    
    // ITEM RECEIVED FUNCTION (Note: misspelled as "itemRecieved")
    // Allows buyer to confirm receipt and release payment to seller
    function itemRecieved() external {
        // Validate buyer authorization and contract state:
        require(msg.sender == buyer.addr, "Only the buyer can mark item as recieved");  // Only buyer can call
        require(item.sent, "item must be sent");                                        // Item must be marked as sent
        
        item.recieved = true;  // Mark item as received by buyer
        
        // Release payment to seller
        address payable _to = payable(item.seller);  // Convert seller address to payable
        _to.transfer(buyer.biddingPrice);           // Transfer the bid amount to seller
    }
    
    // VIEW FUNCTIONS (Read-only, don't modify state)
    
    // Returns the item name
    function getName() public view returns(string memory){
        return item.name;
    }
    
    // Returns whether item has been marked as sent
    function isSent() public view returns(bool){
        return item.sent;
    }
    
    // Returns whether item has been marked as received (Note: misspelled as "isRecieved")
    function isRecieved() public view returns(bool) {
        return item.recieved;
    }
    
    // Returns buyer address (only if item is sold)
    function getBuyer() public view returns(address) {
        require(item.sold, "item is not sold yet");  // Must check item is sold first
        return buyer.addr;
    }
    
    // Returns current price: listing price if no bids, otherwise highest bid
    function getPrice() public view returns(uint) {
        if(buyer.biddingPrice == 0) {
            return item.listingPrice;  // Return initial listing price if no bids
        }
        return buyer.biddingPrice;     // Otherwise return current highest bid
    }
}
