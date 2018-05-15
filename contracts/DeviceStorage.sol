pragma solidity ^0.4.23;
pragma experimental ABIEncoderV2;

import {ResourceTypes} from "./ResourceTypes.sol";
import {Ownable} from "./Ownable.sol";


/// @title Device Info Storage
contract DeviceStorage is Ownable {
    /*
    * @author Austin Hester
    * @dev Built to be used by other contracts
    */

    // Represents an IoT device
    struct Device {
        // device address/ id
        address device_id;
        uint16 network_port;
        bool legacy_device;
        // priority [1-4]
        uint8 priority;
        uint256 balance;
        uint256 trust_level;
        // Requests
        string request_type;
        ResourceTypes.ResourceRanges resource_ranges;
        string MAC;
        bool isRegistered;
        bool isBlocked;
        // Past requests
        address prev_request_id;
    }

    mapping(address => Device) private mDevices;

    uint256 private num_devices; 

    // Solidity 0.4.23 has an issue with inheritence
    // and multiple contsructors
    // using old-style contsructor here for now
    constructor() public {
    	require(msg.sender != address(0));
        num_devices = 0;
        assert(num_devices == 0);
    }

    // Get the Device object, cannot get through web3 as of now
    // Can only be used in contracts.
    // Cannot use struct as return values. -Apr 18
    /// @return {Device} object 
    function getDeviceObject(
        address _of
    ) internal view returns (Device) {
        require(_of != address(0));
        Device memory d = mDevices[_of];
        return d;
    } 

    //
    /// @param _address device address or id
    /// @param _class iot device class
    /// @param _priority iot device priority
    /// @param _categories device categories, could be multiple
    /// @param _req_types device request types, could be multiple
    /// @param _pastBehaviors device past, usually empty
    /// @param _MAC MAC address of device
    function makeDeviceObject(
        address _device_id,
        uint8 _priority,
        string _MAC
    ) internal pure returns (Device) {
        require(_device_id != address(0));
        require(_priority > 0);
        require(_priority <= 4);
        require(!strcmp(_MAC, ""));
         // May have to do even more checks 
        Device memory newDevice = Device(
            _device_id,
            _priority,
            _MAC,
            true
        );
        return newDevice;
    }

    // Add a request/ behavior to the device's storage
    /// @param _address address 
    /// @param _behavior a graded request
    function addBehavior(
        address _address, 
        string _behavior
    ) internal {
        //require(msg.sender != address(0));
        //require(mDevices[_address].isRegistered);
        //require(strcmp(mDevices[_address].device_id, _address));

        Device storage device = mDevices[_address];
        //uint256 oldN = device.num_pastBehaviors;
        //device.pastBehaviors[oldN] = _behavior;
        //device.num_pastBehaviors += 1;
        //mDevices[_address] = device;

        //assert(mDevices[_address].num_pastBehaviors == oldN + 1);
        //assert(strcmp(mDevices[_address].pastBehaviors[oldN], _behavior));
    }

    // Store the Device object
    /// @param _device object 
    function storeDevice(
        Device _device
    ) internal {
        require(msg.sender != address(0));
        require(!mDevices[_device.device_id].isRegistered);

        uint256 oldN = num_devices;
    	mDevices[_device.device_id] = _device;
        num_devices += 1;  

        assert(num_devices == oldN + 1);
        assert(mDevices[_device.device_id].isRegistered);
    }

    // Store the Device object
    /// @param _device object 
    function updateDevice(
        Device _device
    ) internal onlyOwner {
        require(msg.sender != address(0));
        //require(!mDevices[_device.device_id].isRegistered);

        uint256 oldN = num_devices;
        mDevices[_device.device_id] = _device;
        //num_devices += 1;  

        assert(num_devices == oldN);
        assert(mDevices[_device.device_id].isRegistered);
    }

    /// @param a string 
    /// @param b string 
    /// @return boolean 
    function strcmp(
        string a,
        string b
    ) internal pure returns (bool) {
        return (keccak256(a) == keccak256(b));
    }

}
