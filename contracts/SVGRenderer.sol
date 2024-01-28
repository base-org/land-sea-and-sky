// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

interface ISVGPartRenderer {
  function render() external pure returns (string memory);
  function render(uint _tokenId) external pure returns (string memory);
}

contract SVGRenderer {

  ISVGPartRenderer public seaRenderer;
  ISVGPartRenderer public skyRenderer;
  ISVGPartRenderer public landRenderer;
  ISVGPartRenderer public sunRenderer1;
  ISVGPartRenderer public sunRenderer2;
  ISVGPartRenderer public sunRenderer3;
  ISVGPartRenderer public cloudRenderer;
  ISVGPartRenderer public whaleRenderer;

  constructor(
    address _seaRenderer,
    address _skyRenderer,
    address _landRenderer,
    address _sunRenderer1,
    address _sunRenderer2,
    address _sunRenderer3,
    address _cloudRenderer,
    address _whaleRenderer
    ) {
    seaRenderer = ISVGPartRenderer(_seaRenderer);
    skyRenderer = ISVGPartRenderer(_skyRenderer);
    landRenderer = ISVGPartRenderer(_landRenderer);
    sunRenderer1 = ISVGPartRenderer(_sunRenderer1);
    sunRenderer2 = ISVGPartRenderer(_sunRenderer2);
    sunRenderer3 = ISVGPartRenderer(_sunRenderer3);
    cloudRenderer = ISVGPartRenderer(_cloudRenderer);
    whaleRenderer = ISVGPartRenderer(_whaleRenderer);
  }

  function render(uint _tokenId, bool _upgraded) public view returns (string memory) {
    // console.log("upgraded", _upgraded);
    return string(
      abi.encodePacked(
        "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1024 1024'>",
        skyRenderer.render(_tokenId),
        pickSunRenderer(_tokenId).render(),
        cloudRenderer.render(_tokenId),
        landRenderer.render(_tokenId),
        seaRenderer.render(),
        renderWhaleIfUpgraded(_upgraded),
        "</svg>"
      )
    );
  }

  function renderWhaleIfUpgraded(bool _upgraded) public view returns (string memory) {
    if(_upgraded) {
      return whaleRenderer.render();
    } else {
      return "";
    }
  }

  function pickSunRenderer(uint _tokenId) public view returns (ISVGPartRenderer) {
    bytes32 hash = keccak256(abi.encodePacked(_tokenId));
    uint rand = uint(hash);
    uint sun = rand % 3;
    if(sun == 0) {
      return sunRenderer1;
    } else if(sun == 1) {
      return sunRenderer2;
    } else {
      return sunRenderer3;
    }
  }
}
