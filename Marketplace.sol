// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Marketplace {
    mapping(address => uint256) public balance;

    event Purchase(
        address indexed buyer,
        address indexed seller,
        uint256 value
    );

    modifier onlyRegistered(address _user) {
        require(balance[_user] > 0, "User not registered");
        _;
    }

    function register(address _user, uint256 _initialBalance) public {
        require(
            _initialBalance > 0,
            "Initial balance must be greater than zero"
        );
        balance[_user] = _initialBalance;
    }

    function buy(address _seller, uint256 _cash)
        public
        virtual
        onlyRegistered(msg.sender)
        onlyRegistered(_seller)
    {
        require(_cash > 0, "Cash must be greater than zero");
        require(balance[msg.sender] >= _cash, "Insufficient balance");

        balance[msg.sender] -= _cash;
        balance[_seller] += _cash;

        emit Purchase(msg.sender, _seller, _cash);
    }

    function sell(address _buyer, uint256 _price)
        public
        virtual
        onlyRegistered(msg.sender)
        onlyRegistered(_buyer)
        returns (string memory)
    {
        require(_price > 0, "Price must be greater than zero");
        require(msg.sender != _buyer, "Seller and buyer cannot be the same");

        return "Item will be shipped to buyer location";
    }
}

contract PremiumSeller is Marketplace {
    uint256 public fee;

    constructor(uint256 _fee) {
        fee = _fee;
    }

    function sell(address _buyer, uint256 _price)
        public
        override
        onlyRegistered(msg.sender)
        onlyRegistered(_buyer)
        returns (string memory)
    {
        require(balance[msg.sender] > 0, "Insufficient seller balance");
        require(_price > 0, "Price must be greater than zero");
        require(msg.sender != _buyer, "Seller and buyer cannot be the same");

        uint256 feeAmount = (_price * fee) / 100;
        balance[msg.sender] -= feeAmount;
        balance[address(this)] += feeAmount;

        return super.sell(_buyer, _price);
    }
}

contract RegularBuyer is Marketplace {}

contract VIPBuyer is Marketplace {
    uint256 public discount;

    constructor(uint256 _discount) {
        discount = _discount;
    }

    function buy(address _seller, uint256 _purchaseAmount)
        public
        override
        onlyRegistered(msg.sender)
        onlyRegistered(_seller)
    {
        require(
            _purchaseAmount > 0,
            "Purchase amount must be greater than zero"
        );

        uint256 discountAmount = (_purchaseAmount * discount) / 100;
        uint256 finalAmount = _purchaseAmount - discountAmount;

        require(
            balance[msg.sender] >= finalAmount,
            "Insufficient balance after discount"
        );

        balance[msg.sender] -= finalAmount;
        balance[_seller] += finalAmount;

        emit Purchase(msg.sender, _seller, finalAmount);
    }
}
