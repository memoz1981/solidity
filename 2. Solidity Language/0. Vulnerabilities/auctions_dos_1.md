**A.Safe**

if (highestBid != 0) {
    // Instead of sending Ether directly:
    pendingReturns[highestBidder] += highestBid;
}
highestBidder = msg.sender;
highestBid = msg.value;

**B.Unsafe**
if (highestBid != 0) {
    // Send ether directly
    highestBidder.send(highestBid); // OR .transfer(highestBid)
}
highestBidder = msg.sender;
highestBid = msg.value;

The sender may be a contract that may have fallback function with revert() code that will make any bids reverted thus DOS (Denial of Service) attack. 

**Note:** Mostly applicable for bids/auctions - which is why refunds are mostly request based -> otherwise this attack may be possible. 