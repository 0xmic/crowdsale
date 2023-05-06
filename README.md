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

![Crowdsale](./public/crowdsale.png)
