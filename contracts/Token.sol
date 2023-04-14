// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";//enables functions that help you burn your tokens
import "@openzeppelin/contracts/access/Ownable.sol";//helps enable owner check functions
import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; //helps to creates token within you're contract ;


//import the above imports
contract AOTTokens is ERC20,ERC20Burnable,Ownable {
    uint public tokenPrice;
    uint public maxSupply;

    constructor() ERC20("AOTTokens","AOTT"){
        tokenPrice=200000000000000000; //0.2 ether, we write it in wei 
        maxSupply=150000000000000000000; //max of 150 tokens, followed by 18 zeros, because we mention it in the smallest divisible unit, 

    }

    function mint(uint _amount) public payable{
        //! asking to create more token

        //* check if the amount you want to mint crosses the total amount of supply
        require(_amount+totalSupply()<=maxSupply,"you've crossed the max supply limit");

        require(msg.value*10**decimals()/_amount>=tokenPrice,"Pay Ether according to Token Price");//is the avarage cost of each token greater the token price;

        _mint(msg.sender, _amount); //Inbuilt by erc20;

    }

    function withdrawEther() public onlyOwner { //onlyOwner is inbuilt by importing Ownable contract
        payable(owner()).transfer(address(this).balance); //owner() is a inbuilt function that gives the address of the owner of the contract
    }

    function returnState() public view returns(uint _myBalance, uint _maxSupply, uint _totalSupply, uint _tokenPrice ){
        //returns balance of person opening the page, max supply of tokens, total supply in circulation, price of the token set
        return (balanceOf(msg.sender), maxSupply, totalSupply(), tokenPrice);
    }

}