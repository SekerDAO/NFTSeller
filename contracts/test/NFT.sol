// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;


    constructor() ERC721("TEST NFT", "TNFT") {}

    function mint() public {
        uint256 newNFT = _tokenIds.current();
        _safeMint(msg.sender, newNFT);
        _tokenIds.increment();
    }

    function totalSupply() public view returns (uint256) {
        return _tokenIds.current();
    }
}
