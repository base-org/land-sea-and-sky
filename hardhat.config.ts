import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "hardhat-deploy";
import "hardhat-contract-sizer";

require('dotenv').config();

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.20",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  namedAccounts: {
    deployer: {
      default: 0,
    },
  },
  etherscan: {
    apiKey: {
      "base-sepolia": process.env.ETHERSCAN_API_KEY as string,
      "base": process.env.ETHERSCAN_API_KEY as string,
    },
    customChains: [
      {
        network: "base-goerli",
        chainId: 84531,
        urls: {
          // Basescan by Etherscan
          apiURL: "https://api-goerli.basescan.org/api",
          browserURL: "https://goerli.basescan.org"
        }
      },
      {
        network: "base-sepolia",
        chainId: 84532,
        urls: {
          // Basescan by Etherscan
          apiURL: "https://api-sepolia.basescan.org/api",
          browserURL: "https://sepolia.basescan.org"
        }
      },
      {
        network: "base",
        chainId: 8453,
        urls: {
          // Basescan by Etherscan
          apiURL: "https://api.basescan.org/api",
          browserURL: "https://basescan.org"
        }
      }
    ]
  },
  networks: {
    'base-goerli': {
      url: 'https://goerli.base.org',
      accounts: [process.env.COINBASE_WALLET_KEY as string]
    },
    'base-sepolia': {
      url: 'https://sepolia.base.org',
      accounts: [process.env.COINBASE_WALLET_KEY as string]
    },
    'base': {
      url: 'https://mainnet.base.org',
      accounts: [process.env.COINBASE_WALLET_KEY as string]
    },
    goerli: {
      url: process.env.COINBASE_NODE_GOERLI_ADDRESS || "",
      accounts: [process.env.COINBASE_WALLET_KEY as string]
    }
  },
};

export default config;
