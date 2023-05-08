// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require('hardhat')

const config = require('../src/config.json')

async function main() {
  // Fetch accounts from the wallet
  const accounts = await hre.ethers.getSigners()

  // Fetch the network
  const { chainId } = await hre.ethers.provider.getNetwork()
  console.log(`Using chainId: ${chainId}\n`)

  // Fetch the deployed crowdsale
  const crowdsale = await hre.ethers.getContractAt('Crowdsale', config[chainId].crowdsale.address)
  console.log(`Crowdsale fetched: ${crowdsale.address}\n`)

  // Set the deployer address
  const deployer = accounts[0]
  console.log(`Deployer address: ${deployer.address}\n`)

  // Array of addresses to be added to the whitelist
  const addressesToWhitelist = [
    // List addresses as comma separated strings: ['0x000000','0x000000']
    deployer.address,
    accounts[1].address
  ]

  // Add addresses to the whitelist
  for (const address of addressesToWhitelist) {
    await crowdsale.connect(deployer).whitelistUser(address)
    console.log(`Added address to whitelist: ${address}\n`)
  }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error)
  process.exitCode = 1
})
