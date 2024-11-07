// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./safemath.sol";
import "./credit.sol";


contract p2pOwnable is ownable {
    using SafeMath for uint256;

    struct User {
        bool credited;
        address activeCredit;
        bool fraudStatus;
        address[] allCredit;
    }
    mapping(address => User) public users;
    address[] public credits;

    event logCreditCreated(
        address indexed _address,
        address _borrower,
        uint256 indexed timestamp
    );
    event logCreditStateChanged(
        address indexed _address,
        Credit.State indexed state,
        uint256 indexed timestamp
    );
    event logCreditStateActiveChanged(
        address indexed _address,
        bool indexed active,
        uint256 indexed timestamp
    );
    event logUserSetFraud(
        address indexed _address,
        bool fraudstates,
        uint256 timestamp
    );

    function applyforcredit(
        uint256 requestamount,
        uint256 repaymentscount,
        uint256 interest,
        bytes memory creditdescriptiion
    ) public returns (address _credit) {
        require(users[msg.sender].credited == false);
        require(users[msg.sender].fraudStatus == false);
        assert(users[msg.sender].activeCredit == address(0));
        users[msg.sender].credited = true;
        Credit credit = new Credit(
            requestamount,
            repaymentscount,
            interest,
            creditdescriptiion
        );
        users[msg.sender].activeCredit = address(credit);
        credits.push(address(credit));
        emit logCreditCreated(address(credit), msg.sender, block.timestamp);
        return address(credit);
    }

    function getcredit() public view returns (address[] memory) {
        return credits;
    }

    function getuserCredits() public view returns (address[] memory) {
        return users[msg.sender].allCredit;
    }

    function setfraudstatus(address _borrower) external returns (bool) {
        users[_borrower].fraudStatus = true;
        emit logUserSetFraud(
            _borrower,
            users[_borrower].fraudStatus,
            block.timestamp
        );

        return users[_borrower].fraudStatus;
    }

    function changeCreditstate(Credit _credit, Credit.State state)
        public
        onlyowner
    {
        Credit credit = Credit(_credit);
        credit.changeState(state);
        emit logCreditStateChanged(address(credit), state, block.timestamp);
    }

    function changeCreditState(Credit _credit) public onlyowner {
        Credit credit = Credit(_credit);
        bool active = credit.toggleActive();
        emit logCreditStateActiveChanged(
            address(credit),
            active,
            block.timestamp
        );
    }
}