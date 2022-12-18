// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Seller is Ownable {
    uint256 public totalMint = 3000;
    uint256 public price = 0.15 ether;
    uint256 public minted;
    address public NFT;
    address public issuer;

    constructor(address _NFT, address _issuer) {
        NFT = _NFT;
        issuer = _issuer;
        //_transferOwnership(address(0x181e1ff49CAe7f7c419688FcB9e69aF2f93311da));
    }

    function mint(uint256 _amount) public payable {
        require(
            minted <= totalMint,
            "minting has reached its max"
        );
        require(msg.value == price * _amount, "Incorrect eth amount");
        for (uint256 i; i <= _amount - 1; i++) {
            IERC721(NFT).transferFrom(issuer, msg.sender, minted);
            minted++;
        }
    }

    function updateTotalMint(uint256 _newSupply) public onlyOwner {
        require(_newSupply > minted, "new supply less than already minted");
        totalMint = _newSupply;
    }

    function updatePrice(uint256 _newPrice) public onlyOwner {
        price = _newPrice;
    }

    // Withdraw
    function withdraw(address payable withdrawAddress)
        external
        payable
        onlyOwner
    {
        require(
            withdrawAddress != address(0),
            "Withdraw address cannot be zero"
        );
        require(address(this).balance >= 0, "Not enough eth");
        (bool sent, ) = withdrawAddress.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }
}
