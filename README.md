# Land Registry - Using Smart Contracts in Blockchain

In this project I will be implementing the Land Record Management using the Blockchain Technology. I will be using public blockchain (Ethereum Blockchain) which has been used in many solutions in many years that make it mature and secure for the land record management. The front-end will be developed using the REACT framework and in the Backend NODE will be used which will allow me to connect the app with the blockchain to safely store the information to the Ethereum blockchain.

There will be two parties (users / actors) involved in the process of the registration of the land. One is the government official who is the key actor for the registrations, verification and/or transfer of the lands and the second is the land owner itself who is responsible for providing the information to the government official.

In this way we can minimize the workload of the land department which involves different workflows to be completed before the land is registered or the land ownership is provided to the user. In the current workflow of land registration a user has to submit the required documents to the gain Fard Issuance and pay a certain amount of fee for the process of the application, after that a deed writer / lawyer is hired and finally all the information is sent to the registrar office to issue land ownership to the user.

## Instructions

- 1. **Install Node** (NODE will be used as the backend of the application)

- 2. **Install Truffle Suite** (Ganache - It will allow us to create a local / dev blockchain using the Ethereum Network)

- 3. **Install Metamask** (Browser extension work as wallet to store our assets and help us interact with the blockchain from the browser)

- 4. Once you install all of the above required, clone the repository ```
git clone https://github.com/mamoon-rasheed/blockchian-land-app.git ```

- 5. Open gananche app and let it load 

- 6. Open the project in your code editor, navigate to ***truffle-config.js*** and change settings according to your ganache properties

- 7. Open the terminal and install the dependencies required for the app by typing ``` npm install ```  on the terminal
- 8. Once dependencies are installed it's time to migrate the contracts to truffle by typing ``` truffle migrate ``` in the terminal
- 9. Now run the app by typing ``` npm start ```
