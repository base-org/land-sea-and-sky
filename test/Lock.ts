import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { SignerWithAddress } from "@nomicfoundation/hardhat-ethers/signers";
import { Contract } from "ethers";

describe("Test", function () {
  let owner: SignerWithAddress;
  let signer0: SignerWithAddress;
  let signer1: SignerWithAddress;
  
  let seaRenderer: any;
  let skyRenderer: any;
  let landRenderer: any;
  let sunRenderer1: any;
  let sunRenderer2: any;
  let sunRenderer3: any;
  let cloudRenderer: any;
  let whaleRenderer: any;
  let svgRenderer: any;
  let landSeaSky: any;

  async function fixture() {
    console.log("beforeEach");
    const [theOwner, zero, one, two, three, four] = await ethers.getSigners();
    owner = await ethers.getSigner(theOwner.address);
    signer0 = await ethers.getSigner(zero.address);
    signer1 = await ethers.getSigner(one.address);
    
    const SeaRenderer = await ethers.getContractFactory("SeaRenderer");
    seaRenderer = await SeaRenderer.deploy();

    const SkyRenderer = await ethers.getContractFactory("SkyRenderer");
    skyRenderer = await SkyRenderer.deploy();

    const LandRenderer = await ethers.getContractFactory("LandRenderer");
    landRenderer = await LandRenderer.deploy();

    const SunRenderer1 = await ethers.getContractFactory("SunRenderer1");
    sunRenderer1 = await SunRenderer1.deploy();

    const SunRenderer2 = await ethers.getContractFactory("SunRenderer2");
    sunRenderer2 = await SunRenderer2.deploy();

    const SunRenderer3 = await ethers.getContractFactory("SunRenderer3");
    sunRenderer3 = await SunRenderer3.deploy();

    const CloudRenderer = await ethers.getContractFactory("CloudRenderer");
    cloudRenderer = await CloudRenderer.deploy();

    const WhaleRenderer = await ethers.getContractFactory("WhaleRenderer");
    whaleRenderer = await WhaleRenderer.deploy();

    console.log(await seaRenderer.getAddress());

    const SVGRenderer = await ethers.getContractFactory("SVGRenderer");
    svgRenderer = await SVGRenderer.deploy(
      await seaRenderer.getAddress(),
      await skyRenderer.getAddress(),
      await landRenderer.getAddress(),
      await sunRenderer1.getAddress(),
      await sunRenderer2.getAddress(),
      await sunRenderer3.getAddress(),
      await cloudRenderer.getAddress(),
      await whaleRenderer.getAddress()
    );

    const LandSeaSkyNFT = await ethers.getContractFactory("LandSeaSkyNFT");
    landSeaSky = await LandSeaSkyNFT.deploy(await svgRenderer.getAddress());
    console.log("done setup");

    return {
      landSeaSky,
      svgRenderer,
      seaRenderer,
      skyRenderer,
      landRenderer,
      sunRenderer1,
      sunRenderer2,
      sunRenderer3,
      cloudRenderer,
      whaleRenderer,
      owner,
      signer0,
      signer1,
    };
  }

  describe("Mint", function () {
    it("LandSeaSky should mint and upgrade", async function () {
      const { landSeaSky } = await loadFixture(fixture);

      await landSeaSky.mint();
      await landSeaSky.mint();
      await landSeaSky.mint();

      await landSeaSky.upgradeToken(2);

      const uri = await landSeaSky.tokenURI(2);

      // Save URI to file on disk
      const fs = require('fs');

      fs.writeFile("tokenURI.txt", uri, function(err: any) {
          if(err) {
              return console.log(err);
          }

          console.log("The file was saved!");
      });

    });
  });

});
