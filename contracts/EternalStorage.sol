pragma solidity 0.4.24;

import "./Ownable.sol";


contract EternalStorage is Ownable {
	
	/**** Storage Types ****/
	mapping(bytes32 => bytes32[])	private keyListStorage;
	mapping(bytes32 => uint256) 	private uintStorage;
	mapping(bytes32 => string)	 	private stringStorage;
	mapping(bytes32 => address) 	private addressStorage;
	mapping(bytes32 => bytes)   	private bytesStorage;
	mapping(bytes32 => bool)    	private boolStorage;
	mapping(bytes32 => int256)    	private intStorage;

    /**** Get Methods ***********/

    function getKeyList(bytes32 _key) external view returns (bytes32[]) {
    	return keyListStorage[_key];
    }

    /// @param _key The key for the record
    function getAddress(bytes32 _key) external view returns (address) {
        return addressStorage[_key];
    }

    /// @param _key The key for the record
    function getUint(bytes32 _key) external view returns (uint) {
        return uintStorage[_key];
    }

    /// @param _key The key for the record
    function getString(bytes32 _key) external view returns (string) {
        return stringStorage[_key];
    }

    /// @param _key The key for the record
    function getBytes(bytes32 _key) external view returns (bytes) {
        return bytesStorage[_key];
    }

    /// @param _key The key for the record
    function getBool(bytes32 _key) external view returns (bool) {
        return boolStorage[_key];
    }

    /// @param _key The key for the record
    function getInt(bytes32 _key) external view returns (int) {
        return intStorage[_key];
	}

    /**** Set Methods ***********/

    /// @param _key The key for the record
    function setAddress(bytes32 _key, address _value)  external {
    	//setAddress(keccack256(abi.encodePacked("contract.address", this.address)), this.address);
        addressStorage[_key] = _value;
    }

    /// @param _key The key for the record
    function setUint(bytes32 _key, uint _value)  external {
        uintStorage[_key] = _value;
    }

    /// @param _key The key for the record
    function setString(bytes32 _key, string _value)  external {
        stringStorage[_key] = _value;
    }

    /// @param _key The key for the record
    function setBytes(bytes32 _key, bytes _value)  external {
        bytesStorage[_key] = _value;
    }
    
    /// @param _key The key for the record
    function setBool(bytes32 _key, bool _value)  external {
        boolStorage[_key] = _value;
    }
    
    /// @param _key The key for the record
    function setInt(bytes32 _key, int _value)  external {
        intStorage[_key] = _value;
	}

	/**** Delete Methods ***********/
    
    /// @param _key The key for the record
    function deleteAddress(bytes32 _key)  external {
        delete addressStorage[_key];
    }

    /// @param _key The key for the record
    function deleteUint(bytes32 _key)  external {
        delete uintStorage[_key];
    }

    /// @param _key The key for the record
    function deleteString(bytes32 _key)  external {
        delete stringStorage[_key];
    }

    /// @param _key The key for the record
    function deleteBytes(bytes32 _key)  external {
        delete bytesStorage[_key];
    }
    
    /// @param _key The key for the record
    function deleteBool(bytes32 _key)  external {
        delete boolStorage[_key];
    }
    
    /// @param _key The key for the record
    function deleteInt(bytes32 _key)  external {
        delete intStorage[_key];
	}

}
