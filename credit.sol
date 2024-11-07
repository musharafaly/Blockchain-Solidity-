// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ownable.sol";
import "./safemath.sol";

contract Credit is ownable{
    using SafeMath for uint;

    address borrower;
    uint requestamount;
    uint returnamount;
    uint repaidamount;
    uint interest;
    uint requestpayment;
    uint remainingpayment;
    uint requesteddate;
    uint lastrepaymentdate;
    uint repaymentinstallment;

    bytes description;
    bool active=true;
    uint lenderscount=0;
    uint revokeVotes=0;

    uint revoketimeneeded=block.timestamp + 1 seconds;
    uint fraudvotes=0;

    mapping (address=>bool) public lenders;
    mapping (address=>uint)public lendersinvestamount;
    mapping (address=>bool)revokevoters;
    mapping (address=>bool)fraudvaiters;


    enum State{
        investment,
        repayment,
        interestReturns,
        expired,
        revoked,
        fraud
    }
    State state;
    event LogCreditInitialized(address indexed borrower, uint256 timestamp);
    event LogCreditStateChanged(State newState, uint256 timestamp);
    event LogCreditStateActiveChanged(bool isActive, uint256 timestamp);
    event LogBorrowerWithdrawal(address indexed _address,uint256 amount, uint256 timestamp);
    event LogBorrowerRepaymentInstallment(address indexed _address,uint256 amount, uint256 timestamp);
    event LogBorrowerRepaymentFinished(address indexed _address,uint256 timestamp);
    event LogBorrowerChangeReturned(address indexed _address ,uint256 amount, uint256 timestamp);
    event LogLenderInvestment(address indexed lender, uint256 amount, uint256 timestamp);
    event LogLenderWithdrawal(address indexed _address,uint256 amount, uint256 timestamp);
    event LogLenderChangeReturned(uint256 amount, uint256 timestamp);
    event LogLenderVoteForRevoking(address indexed lender, uint256 timestamp);
    event LogLenderVoteForFraud(address indexed lender, uint256 timestamp);
    event LogLenderRefunded(address indexed lender, uint256 amount, uint256 timestamp);
    modifier IsActive(){
        require(active==true);
        _;
    }
    modifier  onlyBorrower(){
        require(msg.sender==borrower);
        _;
    }
    modifier onlylender(){
        require(lenders[msg.sender]==true);
        _;
    }
    modifier CanAskForinterset(){
        require(state==State.interestReturns);
        require(lendersinvestamount[msg.sender]>0);
        _;
    }
    modifier CanIvest(){
        require(state==State.investment);
        _;
    }
    modifier canRepay(){
        require(state==State.repayment);
        _;
    }
    modifier canWithdraw(){
        require(address(this).balance>=requestamount);
        _;
    }
    modifier isNotFraud(){
        require(state!=State.fraud);
        _;
    }
    modifier  isRevokable(){
        require(block.timestamp >=revoketimeneeded);
        require(state==State.investment);
        _;
    }
    modifier isrevoked(){
        require(state==State.revoked);
        _;
    }
     constructor(uint _requestamount,uint _requestpayment,uint _interest,bytes memory _description){
        borrower=tx.origin;
        interest=_interest;
        requestamount=_requestamount;
        requestpayment=_requestpayment;
        description=_description;
        returnamount=requestamount.add(interest);
        repaymentinstallment=returnamount.div(requestpayment);
        requesteddate=block.timestamp;

        emit LogCreditInitialized(borrower, block.timestamp);
         }
      function getBalance()public view returns(uint256){
        return address(this).balance;
        }
      function changeState(State _state)external onlyowner{
        state=_state;
        emit LogCreditStateChanged(state, block.timestamp);
      }
      function toggleActive()external onlyowner returns (bool){
        active=!active;
        emit LogCreditStateActiveChanged(active, block.timestamp);
        return active;
      }
    function invest()public CanIvest payable{
        uint extramoney=0;
        if(address(this).balance>=requestamount){
            extramoney=address(this).balance.sub(requestamount);
            address(this).balance.sub(extramoney);
            assert(extramoney<=msg.value);
        if(extramoney>0){
        payable(msg.sender).transfer(extramoney);
         emit LogLenderChangeReturned(extramoney, block.timestamp);
        }
        state=State.repayment;
        emit LogCreditStateChanged(state, block.timestamp);
        }
        lenders[msg.sender]=true;
        lenderscount++;
        lendersinvestamount[msg.sender]=lendersinvestamount[msg.sender].add(msg.value.sub(extramoney));
        emit LogLenderInvestment(msg.sender, msg.value.sub(extramoney), block.timestamp);
    }
      function repay()public onlyBorrower payable {
        require(remainingpayment>0);
        require(msg.value>=remainingpayment);
        assert(repaidamount<returnamount);
        remainingpayment--;
        lastrepaymentdate=block.timestamp;
         uint extramoney=0;
        if(msg.value>repaymentinstallment){
            extramoney=msg.value.sub(repaymentinstallment);
            assert(repaymentinstallment==msg.value.sub(extramoney));
            assert(extramoney<=msg.value);
            payable (msg.sender).transfer(extramoney);
            emit LogBorrowerChangeReturned(msg.sender,extramoney, block.timestamp);
            emit LogBorrowerRepaymentInstallment(msg.sender,msg.value.sub(extramoney) ,block.timestamp);
            repaidamount=repaidamount.add(msg.value.sub(extramoney));
            if(repaidamount==returnamount){
                emit  LogBorrowerRepaymentFinished(msg.sender,block.timestamp);
                state=State.interestReturns;
                emit LogCreditStateChanged(state, block.timestamp);
            }
        }
        
    }
    function withdraw()public IsActive onlyBorrower canWithdraw isNotFraud{
        state=State.repayment;
        emit LogCreditStateChanged(state, block.timestamp);
        emit  LogBorrowerWithdrawal(msg.sender,address(this).balance ,block.timestamp);
        payable (borrower).transfer(address(this).balance);
    }
    function requeatInterest()public IsActive onlylender CanAskForinterset{
        uint lenderreturnamount=lendersinvestamount[msg.sender].mul(returnamount.div(lenderscount).div(lendersinvestamount[msg.sender]));
        assert(address(this).balance>=lenderreturnamount);
        payable(msg.sender).transfer(lenderreturnamount);
        emit LogLenderWithdrawal(msg.sender, lenderreturnamount, block.timestamp);
        if(address(this).balance==0)
        active=false;
        emit LogCreditStateActiveChanged(active, block.timestamp);
        state=State.expired;
        emit LogCreditStateChanged(state, block.timestamp);
    }

    function getCreditInfo()public view returns ( address , bytes memory,uint,uint,uint,uint,uint,uint,State, bool ,uint ) {
    return (
        borrower,
        description,
        requestamount,
        requestpayment,
        repaymentinstallment,
        remainingpayment,
        interest,
        returnamount,
        state,
        active,
        address(this).balance
    );

 }
    function revokevote()public IsActive isRevokable onlylender{
     require(revokevoters[msg.sender]==false);
     revokeVotes++;
     revokevoters[msg.sender]==true;
     emit LogLenderVoteForRevoking(msg.sender, block.timestamp);
     if(lenderscount==revokeVotes){
        revoke();
     }
    }
    function revoke()internal{
        state=State.revoked;
        emit LogCreditStateChanged(state, block.timestamp);
    }
    function refund()public IsActive onlylender isrevoked{
        assert(address(this).balance>=lendersinvestamount[msg.sender]);
        payable (msg.sender).transfer(lendersinvestamount[msg.sender]);
        emit LogLenderRefunded(msg.sender, lendersinvestamount[msg.sender], block.timestamp);
        if (address(this).balance==0){
            active=false;
            emit LogCreditStateActiveChanged(active, block.timestamp);
            state=State.expired;
            emit LogCreditStateChanged(state, block.timestamp);
        }
    }
    function fraudvote()public IsActive onlylender{
    require(fraudvaiters[msg.sender]==false);
    fraudvotes++;
    fraudvaiters[msg.sender]==true;
    emit LogLenderVoteForFraud(msg.sender, block.timestamp);
    }

}