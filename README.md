### IoT Device Registration

#### This is a Dapp which registers IoT devices.

It uses MetaMask to interface with the blockchain.

Using MetaMask, import the account you are using with geth.

First, you will need to have the contract deployed on your blockchain.
Make sure the ports are right in your truffle.js.

Run ```truffle deploy```.

Now we will build the Dapp itself. Run ```npm install``` to get the necessary packages.

Now, once you have imported your account into MetaMask, run ```npm start```.

A new browser window will open to localhost:3000, open the dev console to see what's going on.
Submitting will open a MetaMask popup. Click confirm to send the transaction and register the device.
