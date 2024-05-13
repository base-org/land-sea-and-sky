import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { SignerWithAddress } from "@nomicfoundation/hardhat-ethers/signers";
import { Contract } from "ethers";

describe("Test", function () {
  let owner: SignerWithAddress;
  let signer0: SignerWithAddress;
  let signer1: SignerWithAddress;

  async function fixture() {
    console.log("beforeEach");
    const [theOwner, zero, one, two, three, four] = await ethers.getSigners();
    owner = await ethers.getSigner(theOwner.address);
    signer0 = await ethers.getSigner(zero.address);
    signer1 = await ethers.getSigner(one.address);

    const SoulboundSignatureMint = await ethers.getContractFactory(
      "SoulboundSignatureMint"
    );
    const soulboundSignatureMint = await SoulboundSignatureMint.deploy(
        "Meet Base DevRel", // Name
        "MBD", // Symbol
        "QmRsQCyTEALYnHvBupEcs2ofzeeswDEEGNt9uoBL7wHnKQ", // IPFS Hash
        "Thanks for connecting with us!", // Description
    );

    console.log("Owner address: ", owner.address);
    console.log("Signer0 address: ", signer0.address);
    console.log("Signer1 address: ", signer1.address);

    return {
      soulboundSignatureMint,
      owner,
      signer0,
      signer1,
    };
  }

  describe("Mint", function () {
    it("Should validate the signed message", async function () {
      const { soulboundSignatureMint } = await loadFixture(fixture);

      const signedMessage =
        "0x89eb2aa354661d2439aca605a7c7dea1f59141961f0378ed7fafb9c503d06e404e771513cab14139656644d201f823b2dfe5fda643f28897455568b56b31a4d81c";
      
      expect(await soulboundSignatureMint.mintTo("0xac5b774D7a700AcDb528048B6052bc1549cd73B9", signedMessage)).to.not.be.reverted;
    });
  });
});
