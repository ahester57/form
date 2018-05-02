const Web3 = require('web3');
const web3 = new Web3();
const WalletProvider = require('truffle-wallet-provider');
const Wallet = require('ethereumjs-wallet');

/*
var pk = new
Buffer("privatekeyW/O0x",
'hex');
var wallet = Wallet.fromPrivateKey(pk);
var provider = new WalletProvider(wallet,
"https://rinkeby.infura.io");
*/

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
	development: {
		host: "localhost",
		port: 42014,
//		gas: 6698276,
		network_id: "*"
	}
  }
};
