// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFT is ERC721, Ownable {

    uint256 private tokenId;

    constructor()
        ERC721("MyNFT", "MNFT")
        Ownable(msg.sender)
    {
    }

    // Mint NFT using IPFS metadata URI
    function mintNFT(string memory tokenURI)
        public
        onlyOwner
        returns (uint256)
    {
        tokenId++;

        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);

        return tokenId;
    }
}
