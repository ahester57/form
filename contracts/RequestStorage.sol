pragma solidity ^0.4.23;

import {ResourceTypes} from "./ResourceTypes.sol";


contract RequestStorage {

	struct Request {
		address request_id;
		address device_id;
		ResourceTypes.ResourceRanges resource_ranges;
		uint256 received_timestamp;
		uint256 authorized_timestamp;	
		bool isHandledByEdge;
		address prev_request_id;
		bool isAccepted;
	}

	// map device address to request.
	//mapping
	// Actually, we need a db like storage which we can query 
	// and filter. I'll look into this.
	uint256 num_requests;

	constructor() public {
		num_requests = 0;
	}

}
