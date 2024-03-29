import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
    
  const argumentValues = [
    1710734399, // Timestamp to Close
    "Base @ ETHGlobal London", // Name
    "B@EGL24", // Symbol
    "QmSodRZ7ocSFtsNFu7SaxqKoZUb8oZxWeNotkLbmohtv1p", // IPFS Hash
    "", // Description
  ];
    
  const SoulboundFreeTimedMint = await deploy("Base@ETHGlobalLondon", {
    contract: "SoulboundFreeTimedMint",
    from: deployer,
    args: argumentValues,
  });

  await hre.run("verify:verify", {
    address: SoulboundFreeTimedMint.address,
    constructorArguments: argumentValues,
    contract: "contracts/SoulboundFreeTimedMint.sol:SoulboundFreeTimedMint",
  });
};
export default func;
