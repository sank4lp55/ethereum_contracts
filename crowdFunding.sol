// SPDX-License-Identifier: MIT
pragma solidity >0.5.0 < 0.9.0;

contract CrowdFunding{
    mapping(address=>uint) public contributors;
    address public manager;
    uint public minContri;
    uint public deadline;
    uint public target;
    uint public raisedAmount;
    uint public noOfContributers;

    constructor(uint _target,uint _deadline){
        target=_target;
        deadline=block.timestamp+_deadline;
        minContri=100 wei;
        manager=msg.sender;

    }

    function sendEth() public payable{
        require(block.timestamp<deadline,"DeadLIne has passed");
        require(msg.value>=minContri,"Mini contri is not met");

        if(contributors[msg.sender]==0){
            noOfContributers++;
        }
        raisedAmount+=msg.value;
        contributors[msg.sender]+=msg.value;


         
    }

    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }

    function refund() public{
        require(block.timestamp>deadline && raisedAmount<target,"You are not eligible for refund");
        

    }
}


