import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
    
  const SeaRenderer = await deploy("SeaRenderer", {
    from: deployer,
  });

  await hre.run("verify:verify", {
    address: SeaRenderer.address,
    constructorArguments: [],
    contract: "contracts/SeaRenderer.sol:SeaRenderer"
  });

  const SkyRenderer = await deploy("SkyRenderer", {
    from: deployer,
  });

  await hre.run("verify:verify", {
    address: SkyRenderer.address,
    constructorArguments: [],
    contract: "contracts/SkyRenderer.sol:SkyRenderer"
  });

  const LandRenderer = await deploy("LandRenderer", {
    from: deployer,
  });

  await hre.run("verify:verify", {
    address: LandRenderer.address,
    constructorArguments: [],
    contract: "contracts/LandRenderer.sol:LandRenderer"
  });

  const SunRenderer1 = await deploy("SunRenderer1", {
    from: deployer,
  });

  await hre.run("verify:verify", {
    address: SunRenderer1.address,
    constructorArguments: [],
    contract: "contracts/SunRenderer1.sol:SunRenderer1"
  });

  const SunRenderer2 = await deploy("SunRenderer2", {
    from: deployer,
  });

  const SunRenderer3 = await deploy("SunRenderer3", {
    from: deployer,
  });

  const CloudRenderer = await deploy("CloudRenderer", {
    from: deployer,
  });

  const WhaleRenderer = await deploy("WhaleRenderer", {
    from: deployer,
  });

  const SVGRenderer = await deploy("SVGRenderer", {
    from: deployer,
    args: [
      SeaRenderer.address,
      SkyRenderer.address,
      LandRenderer.address,
      SunRenderer1.address,
      SunRenderer2.address,
      SunRenderer3.address,
      CloudRenderer.address,
      WhaleRenderer.address
    ]
  });

  const LandSeaSkyNFT = await deploy("LandSeaSkyNFT", {
    from: deployer,
    args: [SVGRenderer.address]
  });

  await hre.run("verify:verify", {
    address: LandSeaSkyNFT.address,
    constructorArguments: [
      SVGRenderer.address
    ],
    contract: "contracts/LandSeaSkyNFT.sol:LandSeaSkyNFT"
  });
};
export default func;
