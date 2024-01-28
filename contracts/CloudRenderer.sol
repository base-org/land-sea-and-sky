// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

string constant END = '<defs> <style>.cls-cloud-1{fill: url(#linear-gradient-cloud);}.cls-cloud-1, .cls-cloud-2, .cls-cloud-3, .cls-cloud-4, .cls-cloud-5, .cls-cloud-6, .cls-cloud-7, .cls-cloud-8, .cls-cloud-9{stroke-width: 0px;}.cls-cloud-2{fill: url(#linear-gradient-cloud-2);}.cls-cloud-3{fill: #795b3c;}.cls-cloud-4{fill: #784b2d;}.cls-cloud-5{fill: #592b25;}.cls-cloud-6{fill: #a96d3c;}.cls-cloud-7{fill: #dbc075;}.cls-cloud-8{fill: #b18649;}.cls-cloud-9{fill: #b9ab39;}</style> <linearGradient id="linear-gradient-cloud" x1="65.07" y1="46.38" x2="47.22" y2="102.94" gradientUnits="userSpaceOnUse"> <stop offset="0" stop-color="#a5ddd1"/> <stop offset=".46" stop-color="#3fa0a1"/> <stop offset="1" stop-color="#1b4c5d"/> </linearGradient> <linearGradient id="linear-gradient-cloud-2" x1="117.39" y1="22.37" x2="84.24" y2="80.68" gradientUnits="userSpaceOnUse"> <stop offset="0" stop-color="#f2f2d2"/> <stop offset=".59" stop-color="#68bbb7"/> <stop offset="1" stop-color="#236f7b"/> </linearGradient> </defs> <g> <g> <path class="cls-cloud-7" d="M150.8,48.25c2.08,1.19,5.19,4.28,7.14,5.9.75,1.49,2.3,3.07,3.42,4.35,1.14,4.06,4.44,7.68,4.35,15.53-.09,6.96-4.05,15.29-9.32,19.88-.68.59-2.07,1.72-2.79,2.17-1.69,1.06-3.41,1.56-5.28,2.17l-.62-.62c6.23-1.69,11.83-6.99,14.29-12.89,4.03-9.7,2.98-19.17-3.73-27.33-4.81-5.85-15.67-13.38-23.14-9.16,4.69-13.49-6.27-29.16-20.65-28.26v-1.86c14.23-.59,25.83,12.99,23.45,27.02,4.5-.14,8.97.88,12.89,3.11Z"/> <path class="cls-cloud-9" d="M147.7,97.63l.62.62c-2.52.83-2.64,1.21-2.79,1.24-.53.1-1.28-.08-1.86,0-3.34.46-4.87.22-7.76.31-4.65.14-9.32-.05-13.97,0-24.01.25-48.04-.06-72.05,0-5.38.01-10.78-.21-16.15.31-3.97-.14-7.83-.44-11.8,0-.74.14-1.6-.51-2.17-.62-.17-.03-.37-.18-.93-.31l.93-.93c6.12.67,67.36.03,80.43,0,9.56-.02,37.39.67,41.77.31,1.82-.15,3.98-.45,5.75-.93Z"/> <path class="cls-cloud-4" d="M59.5,3.53c-17.94,5.36-31.16,25.19-22.36,43.17-2.11-1.13-6-2.36-8.38-2.48-.03-.56-.7-.13-.93-.47-.09-.13.72-.1.62-.47,1.74.07,3.28.48,4.97.78.54-.97-4.06-8.8,1.55-21.58,2.91-6.63,8.71-12.71,14.91-16.46-1.5,3.06,4.69-2.42,9.63-2.48Z"/> <g> <path class="cls-cloud-1" d="M53.91,40.49c8.27-.85,12.32,5.29,12.73,12.73-1.4,2.88,1.76-.88,5.28-.93,7.8-.12,7.93,7.81,8.54,8.07,10.47-.24,9.45,9.72,10.25,9.94,1.44-.89,4.97.27,6.21,1.24,4.01,3.13,1.92,10.49,4.81,5.9,1.22.68,3.37.74,4.97,3.57,3.49,6.2-.79,14.3-6.99,16.93l.47.31c-13.07.03-74.31.67-80.43,0-8.27-.9-16.56-7.53-18.94-15.53-1.8-6.03-.69-11.56,4.35-15.53l.62-.16c-.84-13.01,10.05-23.5,22.98-22.83,2.38.12,6.27,1.35,8.38,2.48,1.04.56,2.33,1.44,3.26,2.17,5.52,4.34,4.68,8.3,4.81,2.79.13-5.53,2.45-10.54,8.7-11.18Z"/> <path class="cls-cloud-3" d="M28.44,43.29c.1.37-.71.33-.62.47.23.34.9-.09.93.47-12.93-.68-23.82,9.82-22.98,22.83l-.62.16c-.69-4.11-.31-7.04,1.24-10.87.17-.42.42-.83.62-1.24.91-1.81,3.17-4.87,4.66-6.21,2.22-2,6.4-4.25,9.32-4.97,2.67-.66,4.73-.73,7.45-.62Z"/> <path class="cls-cloud-7" d="M101.73,77.45c-2.9,4.59-.8-2.77-4.81-5.9-1.24-.97-4.77-2.13-6.21-1.24-.79-.21.22-10.17-10.25-9.94-.61-.27-.74-8.19-8.54-8.07v-1.55c5.23-.13,9.28,2.77,9.32,8.23.63.59,8.94-.35,10.25,9.32,4.83-.2,9.25,4.13,9.32,9.01.2.33.76.06.93.16Z"/> <path class="cls-cloud-7" d="M67.57,51.67c-.16,1.15-.89,1.47-.93,1.55-.42-7.45-4.46-13.58-12.73-12.73l-.31-1.24c10.06-.99,14.61,7.75,13.97,12.42Z"/> <path class="cls-cloud-4" d="M53.6,39.25l.31,1.24c-6.25.64-8.56,5.65-8.7,11.18-.87.41-.78-4.56-.62-5.43.69-3.79,5.41-6.63,9.01-6.99Z"/> <path class="cls-cloud-8" d="M71.92,50.74v1.55c-3.52.05-6.68,3.81-5.28.93.04-.08.77-.41.93-1.55,2.15-1.16,2.84-.9,4.35-.93Z"/> </g> <g> <path class="cls-cloud-2" d="M102.98,23.1c1.3,8.17-1.87,2.39,5.9-1.55,1.92-.97,3.43-1.42,5.59-1.55,14.38-.9,25.34,14.77,20.65,28.26,7.47-4.22,18.33,3.31,23.14,9.16,6.7,8.16,7.76,17.63,3.73,27.33-2.45,5.9-8.05,11.2-14.29,12.89-1.77.48-3.93.78-5.75.93-4.38.36-32.21-.33-41.77-.31l-.47-.31c6.2-2.63,10.47-10.73,6.99-16.93-1.6-2.84-3.75-2.89-4.97-3.57-.18-.1-.73.17-.93-.16-.07-4.88-4.48-9.21-9.32-9.01-1.31-9.67-9.62-8.72-10.25-9.32-.04-5.46-4.08-8.36-9.32-8.23-1.51.04-2.2-.23-4.35.93.64-4.68-3.91-13.41-13.97-12.42-3.6.35-8.31,3.2-9.01,6.99-.16.88-.25,5.85.62,5.43-.13,5.51.71,1.55-4.81-2.79-.93-.73-2.22-1.61-3.26-2.17C28.34,28.73,41.56,8.89,59.5,3.53c19.12-5.71,40.98,3.9,43.48,19.56Z"/> <path class="cls-cloud-8" d="M114.47,18.13v1.86c-2.16.13-3.67.58-5.59,1.55.07-1.48-1.32-1.12.31-2.17,1.85-.61,3.28-1.16,5.28-1.24Z"/> <path class="cls-cloud-6" d="M109.19,19.37c-1.63,1.05-.24.7-.31,2.17-7.77,3.94-4.6,9.73-5.9,1.55.65.1,1.3-1.42,1.86-1.86,1.23-.98,2.89-1.38,4.35-1.86Z"/> </g> </g> <g> <path class="cls-cloud-7" d="M88.07,3.22c7.38,3.18,15.32,9.74,16.77,18.01-.56.45-1.21,1.97-1.86,1.86-2.5-15.67-24.36-25.27-43.48-19.56-4.94.06-11.12,5.54-9.63,2.48,11.22-6.79,26.12-8,38.2-2.79Z"/> <g> <path class="cls-cloud-7" d="M19.75,98.25l-.93.93c-3.74-.88-5.84-1.9-9.32-3.42-.52-.96-2.72-2.01-4.04-3.73-1.71-2.24-5.31-6.94-4.66-9.32,2.38,8,10.67,14.63,18.94,15.53Z"/> <path class="cls-cloud-5" d="M121.92,99.81l-1.24.62c-.31-.02-.62.01-.93,0-1.14-.04-2.28.02-3.42,0-20.6-.37-41.22.32-61.8,0-1.16-.02-2.77.13-3.73,0-.06,0-.89-.44-.93-.62,24.01-.06,48.04.25,72.05,0Z"/> </g> </g> </g> </g>';

contract CloudRenderer {

  function render(uint _tokenId) public pure returns (string memory) {
    uint rand = uint(keccak256(abi.encodePacked(_tokenId+7)));
    uint cloudCount = rand % 8; // Produces a number between 0 and 7

    bytes[] memory clouds = new bytes[](cloudCount);
    for(uint i = 0; i < cloudCount; i++) {
      clouds[i] = abi.encodePacked(renderCloud(_tokenId, i));
    }

    bytes memory encodedClouds;
    for(uint i = 0; i < cloudCount; i++) {
      encodedClouds = abi.encodePacked(encodedClouds, clouds[i]);
    }

    return string(
      encodedClouds
    );
  }

  function renderCloud(uint _tokenId, uint _cloudNumber) public pure returns (string memory) {
    bytes32 hash1 = keccak256(abi.encodePacked(_tokenId, _cloudNumber));
    uint rand1 = uint(hash1);
    bytes32 hash2 = keccak256(abi.encodePacked(_tokenId+1, _cloudNumber, rand1));
    uint rand2 = uint(hash2);
    return string(
      abi.encodePacked(
        '<g transform="translate(',
        _buildOffset(-200, 1025, rand1),
        ',',
        _buildOffset(-100, 512, rand2),
        ')">',
        END
      )
    );
  }

  function _buildOffset(int _min, int _max, uint _rand) internal pure returns (string memory) {
    uint change = _rand % uint(_max - _min); 
    int newOffset = _min + int(change);
    if(newOffset >= 0) {
      return string(abi.encodePacked(Strings.toString(uint(newOffset))));
    } else {
      return string(abi.encodePacked("-", Strings.toString(uint(newOffset*-1))));
    }
  }
}
