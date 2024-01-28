// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface ISVGRenderer {
  function render(uint tokenId, bool _updgraded) external view returns (string memory);
}

contract LandSeaSkyNFT is ERC721, Ownable {
    uint public counter;
    uint public constant MAX_SUPPLY = 2_222;
    mapping (uint => bool) public upgraded;
    mapping (address => bool) public minted;

    error InvalidTokenId(uint tokenId);
    error MaxSupplyReached();
    error UpgradesClosed();
    error AlreadyUpgraded();
    error OneMintPerAddress();

    ISVGRenderer svgRenderer;

    constructor(address _svgRenderer) ERC721("Land, Sea, and Sky", "LSS") Ownable(msg.sender) {
      svgRenderer = ISVGRenderer(_svgRenderer);
    }

    function mintFor(address _recipient) public onlyOwner {
      if(counter >= MAX_SUPPLY) {
        revert MaxSupplyReached();
      }
      if(minted[_recipient]) {
        revert OneMintPerAddress();
      }
      counter++;
      _safeMint(_recipient, counter);
    }

    function _baseURI() internal pure override returns (string memory) {
      return "data:application/json;base64,";
    }

    function tokenURI(uint _tokenId) public view override returns (string memory) {
      if(_tokenId > counter) {
        revert InvalidTokenId(_tokenId); // Don't forget to add the error above!
      }

      string memory json = Base64.encode(
        bytes(
          string(
            abi.encodePacked(
              '{"name": "Land, Sea, and Sky #: ', 
              Strings.toString(_tokenId), 
              '", "description": "Land, Sea, and Sky is a collection of generative art pieces stored entirely onchain.", "image": "data:image/svg+xml;base64,',
              Base64.encode(bytes(svgRenderer.render(_tokenId, upgraded[_tokenId]))),
              '"}'
            )
          )
        )
      );

      return string(abi.encodePacked(_baseURI(), json));
    }

    function upgradeToken(uint _tokenId) public onlyOwner {
      if(counter >= MAX_SUPPLY) {
        revert UpgradesClosed();
      }
      if(upgraded[_tokenId]) {
        revert AlreadyUpgraded();
      }
      upgraded[_tokenId] = true;
    }
}
