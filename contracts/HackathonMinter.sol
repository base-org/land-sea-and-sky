// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

// Airdrop the NFT to the supplied address
// Only allowlisted addresses can mint

contract HackathonMinter is ERC721, Ownable {
    using EnumerableSet for EnumerableSet.AddressSet;

    EnumerableSet.AddressSet private allowed;

    uint public counter;
    string public nameString;
    string public description;
    string public tokenArtIPFSId;

    mapping(address => bool) public minted;

    error InvalidTokenId(uint tokenId);
    error OneMintPerAddress();
    error NotAllowed();
    error SoulboundToken();

    constructor(
        string memory _nameString,
        string memory _symbol,
        string memory _tokenArtIPFSId,
        string memory _description
    ) ERC721(_nameString, _symbol) Ownable(msg.sender) {
        nameString = _nameString;
        description = _description;
        tokenArtIPFSId = _tokenArtIPFSId;

        allowed.add(msg.sender);
    }

    function mintFor(address _recipient) public allowedOnly {
        if (minted[_recipient]) {
            revert OneMintPerAddress();
        }
        minted[_recipient] = true;
        counter++;
        _safeMint(_recipient, counter);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(
        uint _tokenId
    ) public view override returns (string memory) {
        if (_tokenId > counter) {
            revert InvalidTokenId(_tokenId);
        }

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        nameString,
                        " #: ",
                        Strings.toString(_tokenId),
                        '","description": "',
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
    function _update(
        address to,
        uint256 tokenId,
        address auth
    ) internal override(ERC721) returns (address) {
        address from = _ownerOf(tokenId);
        if (from != address(0) && to != address(0)) {
            revert SoulboundToken();
        }

        return super._update(to, tokenId, auth);
    }

    function addAllowed(address _address) public allowedOnly {
        allowed.add(_address);
    }

    function removeAllowed(address _address) public allowedOnly {
        allowed.remove(_address);
    }

    modifier allowedOnly() {
        if (!allowed.contains(msg.sender)) {
            revert NotAllowed();
        }
        _;
    }
}
