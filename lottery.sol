// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
    contract Lottery{

        address public manager;
        address payable[] public players;


        constructor(){
            manager=msg.sender;
        }

        function alreadyEntered() view private returns(bool){
            for(uint i=0;i<players.length;i++){
                if(msg.sender==players[i])
                return true;
            }
            return false;
        }

        function enter() payable public{
            require(msg.sender!=manager,"Manager cant enter");
            require(alreadyEntered()==false,"Player already entered");
            require(msg.value>=0.1 ether,"Minimum amount must be payed ");
            players.push(payable(msg.sender)); 
        } 

        function random() view private returns(uint){
            return uint(sha256(abi.encodePacked(block.difficulty,block.number,players)));
        }

        function pickWinner() public{
            require(msg.sender==manager,"Only manager can pick the winner !");
            uint index=random()%players.length;
            address contactAddress=address(this);
            players[index].transfer(contactAddress.balance);
            players=new address payable[](0);
        }

        function getPLayers() view public returns(address payable[] memory){
            return players;
        }

    }

