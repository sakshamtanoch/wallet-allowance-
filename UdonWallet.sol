// SPDX-License-Identifier:MIT

pragma solidity ^0.8.11;


 
 
 contract ALLOWANCE {

   event AllowanceInfo( address indexed _forwho, address indexed _fromwhom, uint _oldAmount, uint _newAmount );

   address public owner;
   
   mapping (address => uint256) public allowance;
    
    function addAllowance( address payable _to_who , uint _amount ) payable public {
    

   require (owner == msg.sender, " u are not the owner");

   emit AllowanceInfo (_to_who, msg.sender, allowance[_to_who], _amount);
  
  allowance[_to_who] = _amount;
  
  }
 
 function AllowanceBalance( ) public view returns(uint)
 
 {
 
    return allowance[msg.sender];
 }

}





  contract Udon is ALLOWANCE {

 event MoneySpent( address indexed _Beneficiary, address indexed _payer, uint256 _GoneAmount);

 constructor (){
 
 owner = msg.sender;
 
 }

  function sendFunds() public payable {} 

  function getbalance() public view returns(uint256) {

  return address(this).balance;  

  }

 function withdrawFunds( address payable _to , uint _amount) public payable  {
   
   require (owner == msg.sender || allowance[msg.sender] >= _amount, "either you are not the owner or the funds are too high");

   require ( _amount <= address(this).balance, "you dont have any funds in smart contract");

   emit MoneySpent( _to ,msg.sender, _amount);

   _to.transfer(_amount);

  if (msg.sender == owner) {

     AllowanceBalance();

  }

  else {

  allowance[msg.sender] -= _amount;

   AllowanceBalance();

  }

 }

}