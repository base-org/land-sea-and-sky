// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

string constant START = '<g transform="translate(0,0)"> <defs> <style>.cls-sky-1{fill: url(#linear-gradient-sky); stroke-width: 0px;}</style> <linearGradient id="linear-gradient-sky" x1="511.76" y1="10.19" x2="512.24" y2="865.99" gradientTransform="translate(63.89) scale(.88)" gradientUnits="userSpaceOnUse">';
string constant END = '</linearGradient> </defs> <path class="cls-sky-1" d="M1024,0v768.9H0V0h1024Z"/> </g>';
uint constant OFFSET1 = 2;
uint constant OFFSET2 = 24;
uint constant OFFSET3 = 58;
uint constant OFFSET4 = 80;
string constant COLOR1 = "#c391b4";
string constant COLOR2 = "#ce9f9b";
string constant COLOR3 = "#dfd061";
string constant COLOR4 = "#e3f9f7";

contract SkyRenderer {
  function render(uint _tokenId) public pure returns (string memory) {
    return string(
      abi.encodePacked(
        START,
        _buildStop(OFFSET1, COLOR1, _tokenId, 1),
        _buildStop(OFFSET2, COLOR2, _tokenId, 2),
        _buildStop(OFFSET3, COLOR3, _tokenId, 3),
        _buildStop(OFFSET4, COLOR4, _tokenId, 4),
        END
      )
    );
  }

  function _buildStop(
      uint _offset,
      string memory _color,
      uint _tokenId,
      uint _stopNumber
    ) internal pure returns (string memory) {
    return string(
      abi.encodePacked(
        '<stop offset="',
        _buildOffsetValue(_offset, _tokenId, _stopNumber),
        '" stop-color="',
        _color,
        '"/>'
      )
    );
  }

  function _buildOffsetValue(
      uint _offset,
      uint _tokenId,
      uint _stopNumber
    ) internal pure returns (string memory) {
    bytes32 hash = keccak256(abi.encodePacked(_offset, _tokenId, _stopNumber));
    uint rand = uint(hash);
    uint change = rand % 20; // Produces a number between 0 and 19
    uint newOffset = _offset + change;
    if(newOffset >= 10) {
      return string(
        abi.encodePacked(
          '.',
          Strings.toString(newOffset)
        )
      );
    } else {
        return string(
        abi.encodePacked(
          '.',
          '0', // 9 is .09, not .9
          Strings.toString(newOffset)
        )
      );
    }
  }
}
