import React, { Component } from 'react'
import DeviceRegContract from '../build/contracts/DeviceReg.json'
import getWeb3 from './utils/getWeb3'

import './css/oswald.css'
import './css/open-sans.css'
import './css/pure-min.css'
import './App.css'

class App extends Component {
  constructor(props) {
    super(props)

    // Pending: after submit, before TX reciept
    // Completed: registration done
    this.state = {
      pending: 0,
      completed: 0,
      web3: null,
      deviceId: '',
      deviceClass: '',      // 0, 1, 2
      devicePriority: '',   // (100-140]
      deviceCategory: '',
      deviceMAC: ''
    }
  }

  // Do in the beginning
  componentWillMount() {
    // Get network provider and web3 instance.
    // See utils/getWeb3 for more info.

    getWeb3
    .then(results => {
      this.setState({
        web3: results.web3
      })

    })
    .catch(() => {
      console.log('Error finding web3.')
    })
  }

  componentDidMount() {
	 document.title = "Register Device";
  }

  handleId = (event) => {
    this.setState({deviceId: event.target.value});
  }

  // Update state with last name on change
  handleClass = (event) => {
  	this.setState({deviceClass: event.target.value});
  }

  // Update state with last name on change
  handlePriority = (event) => {
    this.setState({devicePriority: event.target.value});
  }

  // Update state with email on change
  handleCategory = (event) => {
    this.setState({deviceCategory: event.target.value});
  }

  // Update state with email on change
  handleMAC = (event) => {
    this.setState({deviceMAC: event.target.value});
  }

  // Handle submit button
  handleSubmit = (event) => {
    // Confirm they have the right info
    if (confirm("Confirm Registration?\n\nName: " + 
        this.state.deviceId + 
        this.state.deviceClass + 
        this.state.devicePriority + 
        this.state.deviceCategory + 
        this.state.MAC )) {

      console.log("Confirmed Registration");
    } else {
      console.log("Denied Registration");
      return;
    }
    
    // Instanstiate Contract
    const contract = require('truffle-contract')
    const register = contract(DeviceRegContract)
    register.setProvider(this.state.web3.currentProvider)
    this.forceUpdate();

    console.log("boutta connect");
    console.log(DeviceRegContract);

    // Get accounts.
    this.state.web3.eth.getAccounts((error, accounts) => {
      console.log(accounts);
      // Get contract instance
      register.deployed().then((instance) => {
        const registerInstance = instance
        // Check if theyre already registered
        registerInstance.isRegistered(this.state.deviceId)
        .then((result) => {
          console.error(result);
          if (result) {
            // they are registered 
            registerInstance.getDeviceInfo(this.state.deviceId)
            .then((user) => {
              console.error(user);
              const deviceInfo = user;
              // Update state with registered info
              this.setState({deviceId: deviceInfo[0],
                              deviceClass: deviceInfo[1],
                              devicePriority: deviceInfo[2],
                              deviceCategory: deviceInfo[3],
                              deviceMAC: deviceInfo[4] });
            });
            alert("You are already registered!");
            // Take them to the completed page
            this.setState({pending: 0});
            this.setState({completed: 1});
            this.forceUpdate();
            return true;

          } else {
            // they are not registered
            this.setState({pending: 1});
            this.setState({completed: 0});
            return false;
          }
        // Here we register them
        }).then((result) => {
          if (!result) {

            // Register the user
            registerInstance.registerDevice(
              this.state.deviceId, 
              this.state.deviceClass, 
              this.state.devicePriority,
              [this.state.deviceCategory],
              [],
              [],
              this.state.deviceMAC,
              {from: accounts[0],
	      gas: 2000000}
            )
            .then((result) => {
             // wait for txt:wait
              this.state.web3.eth.getTransactionReceipt(result['tx'],
                (result) => {
                  // After waiting callback
                  if (result !== 'undefined') {
                    this.setState({completed: 1});
                    console.error(result);
                  } else {
                    this.setState({pending: 0});
                    console.error("TX failed")
                    console.error("result");
                    alert ("Transaction Failed");
                    this.forceUpdate();
                  }

                });
            })
            .catch((error) => {
              // Error, take them to Register page
              this.setState({pending: 0});
              this.setState({completed: 0});
              console.error(error);
              console.error("rejected");
              this.forceUpdate();
            });
            return;
          } else {
            // they are already registered 
            // take them to the completed page
            this.setState({pending: 0});
            this.setState({completed: 1});
            this.forceUpdate();
            return;
          } 
        });
      });


    });
    event.preventDefault();
  }

  render() {
    // Completed page. Display infO
    if (this.state.completed) {
      document.title = "Register Page";
      return (
        <div className="App">
          <nav className="navbar pure-menu pure-menu-horizontal">
              <a href="#" className="pure-menu-heading pure-menu-link">Register</a>
          </nav>

          <main className="container">
            <div className="pure-g">
              <div className="pure-u-1-1">
                <h2>You Are Registered</h2>
                <h3>Device Info</h3>
                <h4>Id</h4>
                <p>{this.state.deviceId}</p>
                <h4>Class</h4>
                <p>{this.state.deviceClass.toString(10)}</p>
                <h4>Priority</h4>
                <p>{this.state.devicePriority.toString(10)}</p>
                <h4>Category</h4>
                <p>{this.state.deviceCategory.toString(10)}</p>
                <h4>MAC Address</h4>
                <p>{this.state.deviceMAC}</p>
              </div>
            </div>
          </main>
        </div>
      );
    }
    // 'Home' page
    if (!this.state.pending) {
      return (
        <div className="App">
          <nav className="navbar pure-menu pure-menu-horizontal">
              <a href="#" className="pure-menu-heading pure-menu-link">Register</a>
          </nav>

          <main className="container">
            <div className="pure-g">
              <div className="pure-u-1-1">
                <h2>Register your device here</h2>
          <h3>Test 1, 2</h3>
          <form onSubmit={this.handleSubmit}>
          <label>
            Device ID :
            <input type="text" id="dId" placeholder="0x1234..."  	
            onChange={this.handleId}/>
          </label><br/><br/>
          <label>
            Device Class :
            <input type="text" id="dClass" placeholder="0, 1, or 2"   
            onChange={this.handleClass}/>
          </label><br/><br/>
          <label>
            Device devicePriority :
            <input type="text" id="dPriority" placeholder="101 - 140"   
            onChange={this.handlePriority}/>
          </label><br/><br/>
          <label>
            Device deviceCategory :
            <input type="text" id="dCategory" placeholder="categoryi?"   
            onChange={this.handleCategory}/>
          </label><br/><br/>
          <label>
            Device deviceMAC :
            <input type="text" id="dMAC" placeholder="MA:CA:DD:RE:SS"   
            onChange={this.handleMAC}/>
          </label><br/><br/>
          <input type="submit" value="Register"/>
          </form>
              </div>
            </div>
          </main>
        </div>
      );
    } else {
      ///Loading page
      return (
        <div className="App">
          <nav className="navbar pure-menu pure-menu-horizontal">
              <a href="#" className="pure-menu-heading pure-menu-link">Register</a>
          </nav>

          <main className="container">
            <div className="pure-g">
              <div className="pure-u-1-1">
                <h2>Waiting for confirmation...</h2>
                <p>Check MetaMask</p>
              </div>
            </div>
          </main>
        </div>
      );
    }
  }
}

export default App
