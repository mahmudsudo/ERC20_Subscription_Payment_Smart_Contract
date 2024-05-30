// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SubscriptionPayment {
    IERC20 public token;

    struct Subscription {
        address subscriber;
        uint256 amount;
        uint256 interval;
        uint256 nextPaymentDue;
    }

    mapping(address => Subscription) public subscriptions;

    event SubscriptionCreated(address indexed subscriber, uint256 amount, uint256 interval);
    event SubscriptionCancelled(address indexed subscriber);
    event PaymentExecuted(address indexed subscriber, uint256 amount);

    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress);
    }

    function subscribe(uint256 _amount, uint256 _interval) external {
        require(subscriptions[msg.sender].subscriber == address(0), "Subscription already exists");

        subscriptions[msg.sender] = Subscription({
            subscriber: msg.sender,
            amount: _amount,
            interval: _interval,
            nextPaymentDue: block.timestamp + _interval
        });

        emit SubscriptionCreated(msg.sender, _amount, _interval);
    }

    function cancelSubscription() external {
        require(subscriptions[msg.sender].subscriber != address(0), "No active subscription");

        delete subscriptions[msg.sender];

        emit SubscriptionCancelled(msg.sender);
    }

    function executePayment(address _subscriber) external {
        Subscription storage subscription = subscriptions[_subscriber];
        require(subscription.subscriber != address(0), "No active subscription");
        require(block.timestamp >= subscription.nextPaymentDue, "Payment not due yet");

        uint256 amount = subscription.amount;
        subscription.nextPaymentDue += subscription.interval;

        require(token.transferFrom(_subscriber, address(this), amount), "Payment failed");

        emit PaymentExecuted(_subscriber, amount);
    }

    function getNextPaymentDue(address _subscriber) external view returns (uint256) {
        return subscriptions[_subscriber].nextPaymentDue;
    }
}
