# Alpha (ALPHA) Crowdsale
This project demonstrates a basic ERC-20 token crowdsale using a Crowdsale smart contract. It includes a smart contract for the ERC-20 token and the Crowdsale contract that manages the token sale. The front-end allows users to interact with the Crowdsale contract, buy tokens using Ether, and check their token balances. Test files and scripts for deployment are included.

## Stack
Technologies Used:
* JavaScript
* React
* Solidity
* Bootstrap

Libraries Used:
* [React-Bootstrap](https://react-bootstrap.github.io/)

Testing Libraries:
* [React Testing Library](https://testing-library.com/docs/react-testing-library/intro/)
* [Jest](https://jestjs.io/)
* [Chai](https://www.chaijs.com/)

Dev Tools:
* [Hardhat](https://hardhat.org/)
* [dotenv](https://www.npmjs.com/package/dotenv)

## Local Testing
To test the Crowdsale locally, run the following:
```shell
npx hardhat node

npx hardhat --network localhost scripts/1_deploy_token.js

npx hardhat --network localhost scripts/2_deploy_crowdsale.js

npm run start
```

## Deployment
The Crowdsale has been deployed on the Sepolia and Mumbai test networks and is configured to sell an ERC-20 token, Alpha Token (ALPHA). Users can buy ALPHA tokens using Ether at a specified price set by the contract owner. The Crowdsale contract also has a maximum token limit that can be sold during the crowdsale. The contract owner can finalize the crowdsale, which transfers unsold tokens and Ether raised back to the owner.

![Crowdsale](./public/crowdsale.png)
