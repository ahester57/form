pragma solidity ^0.4.23;
pragma experimental ABIEncoderV2;

import {ResourceTypes} from "./ResourceTypes.sol";


/// @title Device Info Storage
contract DeviceStorage {
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

    mapping(string => Device) private mDevices;

    uint256 private num_devices; 

    // Solidity 0.4.23 has an issue with inheritence
    // and multiple contsructors
    // using old-style contsructor here for now
    constructor() public {
    	require(msg.sender != 0x0);
        num_devices = 0;
        assert(num_devices == 0);
    }

    // Get the Device object, cannot get through web3 as of now
    // Can only be used in contracts.
    // Cannot use struct as return values. -Apr 18
    /// @return {Device} object 
    function getDeviceObject(
        string _of
    ) internal view returns (Device) {
        require(!strcmp(_of, ""));
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
        string _address,
        uint8 _class,
        uint8 _priority,
        uint8[] _categories,
        uint8[] _req_types,
        string[] _pastBehaviors, 
        string _MAC
    ) internal pure returns (Device) {
        require(!strcmp(_address, ""));
        require(_class >= 0);
        require(_class < 3);
        require(_priority > 100);
        require(_priority <= 140);
        require(_categories.length > 0);
        require(_categories.length < 256);
//        require(_req_types.length > 0);
        require(_req_types.length < 256);
        require(_pastBehaviors.length >= 0);
        require(!strcmp(_MAC, ""));
         // May have to do even more checks 
        Device memory newDevice = Device(
            _address,
            _class,
            _priority,
            _categories,
            uint8(_categories.length),
            _req_types,
            uint8(_req_types.length),
            _pastBehaviors,
            _pastBehaviors.length,
            _MAC,
            true
        );
        return newDevice;
    }

    // Add a request/ behavior to the device's storage
    /// @param _address address 
    /// @param _behavior a graded request
    function addBehavior(
        string _address, 
        string _behavior
    ) internal {
        require(msg.sender != 0x0);
        require(mDevices[_address].isRegistered);
        require(strcmp(mDevices[_address]._address, _address));

        Device storage device = mDevices[_address];
        uint256 oldN = device.num_pastBehaviors;
        device.pastBehaviors[oldN] = _behavior;
        device.num_pastBehaviors += 1;
        mDevices[_address] = device;

        assert(mDevices[_address].num_pastBehaviors == oldN + 1);
        assert(strcmp(mDevices[_address].pastBehaviors[oldN], _behavior));
    }

    // Store the Device object
    /// @param _device object 
    function storeDevice(
        Device _device
    ) internal {
        require(msg.sender != 0x0);
        require(!mDevices[_device._address].isRegistered);

        uint256 oldN = num_devices;
    	mDevices[_device._address] = _device;
        num_devices += 1;  

        assert(num_devices == oldN + 1);
        assert(mDevices[_device._address].isRegistered);
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
