require("@nomicfoundation/hardhat-toolbox");

require('@primitivefi/hardhat-dodoc');

/** @type import('hardhat/config').HardhatUserConfig */

const networks = process.env.NODE_ENV === 'stage' ? {
  stage: {
    url: 'https://sanrchain-node-stage.santiment.net',
    accounts: [process.env.OWNER_PRIVATE_KEY]
  }
} : undefined

module.exports = {
  solidity: {
    version: "0.8.23",
    settings: {
      optimizer: {
        enabled: true,
        runs: 1000 //4294967295 //2//00//28949//max
      }
    }
  },
  networks
};
