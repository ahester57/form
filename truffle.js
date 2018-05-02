module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
	development: {
		host: "localhost",
		port: 42024,
//		gas: 6698276,
		network_id: "*"
	},
	rinkeby: {
		host: "localhost",
		port: 8545,
		from: "0x0",
		network_id: 4,
		gas: 4612389
	}
  }
};
