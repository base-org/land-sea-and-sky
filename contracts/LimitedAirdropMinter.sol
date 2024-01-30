// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LimitedAirdropMinter is ERC721, Ownable {
    uint public counter;
    uint public maxSupply;
    string public nameString;
    string public description;
    string public tokenArtIPFSId;

    mapping (address => bool) public minted;

    error InvalidTokenId(uint tokenId);
    error MaxSupplyReached();
    error UpgradesClosed();
    error AlreadyUpgraded();
    error OneMintPerAddress();

    constructor(
      address _backendMinterAddress,
      uint _maxSupply,
      string memory _nameString,
      string memory _symbol,
      string memory _tokenArtIPFSId,
      string memory _description
      ) ERC721(_nameString, _symbol) Ownable(_backendMinterAddress) {
      maxSupply = _maxSupply;
      nameString = _nameString;
      description = _description;
      tokenArtIPFSId = _tokenArtIPFSId;
    }

    function mintFor(address _recipient) public onlyOwner {
      if(counter >= maxSupply) {
        revert MaxSupplyReached();
      }
      if(minted[_recipient]) {
        revert OneMintPerAddress();
      }
      minted[_recipient] = true;
      counter++;
      _safeMint(_recipient, counter);
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
              '" #: ', 
              Strings.toString(_tokenId), 
              '", "description": "", "image": "ipfs://',
              tokenArtIPFSId,
              '"}'
            )
          )
        )
      );

      return string(abi.encodePacked(_baseURI(), json));
    }
}
