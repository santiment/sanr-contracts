const {ethers} = require("hardhat");

async function main() {
    const forwarderAddress = process.env.FORWARDER_ADDRESS || '0x985999389f85E5eA4425ac7379b1F7D56e694785'

    const [deployer] = await ethers.getSigners();
    console.log('Deploying contracts with the account: ' + deployer.address);

    const Prices = await ethers.getContractFactory('Prices');
    const prices = await Prices.deploy();
    console.log("Prices: ", prices.target);

    const Predictions = await ethers.getContractFactory('Predictions');
    const predictions = await Predictions.deploy(
        'Predictions',
        'SAP',
        'https://doc.sanr-api.santiment.net',
        prices.target,
        forwarderAddress
    );
    console.log("Predictions: ", predictions.target);

    const ERC20ForCompetitions = await ethers.getContractFactory('ERC20ForCompetitions');
    const erc20ForCompetitions = await ERC20ForCompetitions.deploy(
        'ERC20 Competition Reward',
        'TCR',
        forwarderAddress
    );
    console.log("ERC20ForCompetitions: ", erc20ForCompetitions.target);

    const Competitions = await ethers.getContractFactory('Rewarding');
    const competitions = await Competitions.deploy(
        erc20ForCompetitions.target,
        predictions.target,
    );
    console.log("Competitions: ", competitions.target);

    const Signals = await ethers.getContractFactory('Signals');
    const signals = await Signals.deploy(
        'Signals',
        'SAP',
        'https://doc.sanr-api.santiment.net',
        forwarderAddress
    );
    console.log("Signals: ", signals.target);

    const Subscriptions = await ethers.getContractFactory('SanrSharesV1');
    const subscriptions = await Subscriptions.deploy();
    console.log("Subscriptions: ", subscriptions.target);
}

main()
    .then(() => process.exit())
    .catch(error => {
        console.error(error);
        process.exit(1);
    })
