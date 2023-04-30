const { expect } = require('chai')
const { ethers } = require('hardhat')

const tokens = (n) => {
  return ethers.utils.parseEther(n.toString())
}

describe('Crowdsale', () => {
  let crowdsale

  beforeEach(async () => {
    const Crowdsale = await ethers.getContractFactory('Crowdsale')
    crowdsale = await Crowdsale.deploy()
  })

  describe('Deployment', async () => {
    it('has correct name', async () => {
      expect(await crowdsale.name()).to.eq('Crowdsale')
    })
  })
})
