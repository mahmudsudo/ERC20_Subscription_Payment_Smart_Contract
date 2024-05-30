# ERC20 Subscription Payment Smart Contract

This repository contains a Solidity smart contract for handling subscription-based payments using an ERC20 token. The contract allows users to subscribe to a service, manage their subscriptions, and automate recurring payments.

## Features

- **Subscription Management**: Users can create and cancel subscriptions.
- **Automated Payments**: Allows for recurring payments at specified intervals.
- **ERC20 Token Integration**: Supports payments using any ERC20 token.
- **Event Logging**: Logs subscription creation, cancellation, and payment execution events.

## Contract Overview

The main contract `SubscriptionPayment` is designed to handle recurring payments in a decentralized manner. Below are the key functionalities:

- `subscribe(uint256 _amount, uint256 _interval)`: Allows users to create a new subscription by specifying the payment amount and interval.
- `cancelSubscription()`: Allows users to cancel their existing subscription.
- `executePayment(address _subscriber)`: Executes the payment for the given subscriber if the payment is due.
- `getNextPaymentDue(address _subscriber)`: Returns the next payment due timestamp for a given subscriber.

