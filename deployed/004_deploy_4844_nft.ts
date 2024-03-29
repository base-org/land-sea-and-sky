import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
    
  const argumentValues = [
    1710979200,
    "EIP-4844 is Based",
    "$4844",
    "QmPLdLhPipZ5Lb5XQcmmGCtdVqE1nr8jmZKnT3cSJULRFL",
    "Cheaper, faster transactions make the world go round. Lower gas fees are a critical step towards a new internet and a new economy. Base is for everyone.",
  ];
    
  const SoulboundFreeTimedMint = await deploy("EIP4844IsBasedNft", {
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
