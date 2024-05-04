// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract SoulboundSignatureMint is ERC721, Ownable {
    uint public counter;
    string public nameString;
    string public description;
    string public tokenArtIPFSId;

    error InvalidTokenId(uint tokenId);
    error SoulboundToken();
    error InvalidSignature();

    constructor(
      string memory _nameString,
      string memory _symbol,
      string memory _tokenArtIPFSId,
      string memory _description
      ) ERC721(_nameString, _symbol) Ownable(msg.sender) {
      nameString = _nameString;
      description = _description;
      tokenArtIPFSId = _tokenArtIPFSId;
    }

    function mintTo(address _recipient, bytes memory _signature) public {
      if(!validateSignature(_recipient, _signature)) {
        revert InvalidSignature();
      }

      counter++;
      _safeMint(msg.sender, counter);
    }

    function validateSignature(address _recipient, bytes memory _signature) public view returns (bool) {
      bytes32 messageHash = keccak256(abi.encodePacked(_recipient));
      bytes32 ethSignedMessageHash = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", messageHash.length, messageHash));
      address signer = ECDSA.recover(ethSignedMessageHash, _signature);
      return signer == owner();
    }

    function _baseURI() internal pure override returns (string memory) {
      return "data:application/json;base64,";
    }

    function tokenURI(uint _tokenId) public view override returns (string memory) {
      if(_tokenId > counter) {
        revert InvalidTokenId(_tokenId);
      }

      string memory json = Base64.encode(
        bytes(
          string(
            abi.encodePacked(
              '{"name": "',
              nameString,
              ' #: ', 
              Strings.toString(_tokenId), 
              '","description": "',
              description,
              '", "image": "ipfs://',
              tokenArtIPFSId,
              '"}'
            )
          )
        )
      );

      return string(abi.encodePacked(_baseURI(), json));
    }

    /**
     * Disallow transfers (Soulbound NFT)
     */
    /**
     * @dev Internal function to handle token transfers.
     * Restricts the transfer of Soulbound tokens.
     */
    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721)
        returns (address)
    {
        address from = _ownerOf(tokenId);
        if (from != address(0) && to != address(0)) {
            revert SoulboundToken();
        }

        return super._update(to, tokenId, auth);
    }
}
