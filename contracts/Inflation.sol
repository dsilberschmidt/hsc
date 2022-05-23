// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract Inflation is ChainlinkClient {
    using Chainlink for Chainlink.Request;

    uint256 public inflation;

    address private oracle;
    bytes32 private jobId;
    uint256 private fee;

    /**
     * Network: Kovan
     * Oracle: 0x17A8182DBF79427801573A3D75d42eB9B1215DEF
     * Job ID: 3bec3d8931614e9aac2eb4a57daaf5ef
     * Fee: 0.05 LINK
     */

    constructor() {
        setPublicChainlinkToken();
        oracle = 0x17A8182DBF79427801573A3D75d42eB9B1215DEF;
        jobId = "3bec3d8931614e9aac2eb4a57daaf5ef";
        fee = 0.05 * 10 ** 18;

        //oracle = 0x74EcC8Bdeb76F2C6760eD2dc8A46ca5e581fA656;
        //jobId = "ca98366cc7314957b8c012c72f05aeeb";
        //fee = 0.1 * 10 ** 18;
    }

    function requestInflationData() public returns(bytes32 requestId) {

        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);

        request.add("get", "https://data.nasdaq.com/api/v3/datasets/RATEINF/INFLATION_USA/data.json?start_date=2020-01-01&api_key=GYBUGS41xf-9zH8fAuyu");

        request.add("path", "dataset_data,data,0,1");

        // Multiply the result by 1000000000000000000 to remove decimals
        int timesAmount = 10**18;
        request.addInt("multiply", timesAmount);

        // Sends the request
        return sendChainlinkRequestTo(oracle, request, fee);
    }

    /**
     * Receive the response in the form of uint256
     */
    function fulfill(bytes32 _requestId, uint256 _inflation) public recordChainlinkFulfillment(_requestId)
    {
        inflation = _inflation;
    }

    // function withdrawLink() external {} - Implement a withdraw function to avoid locking your LINK in the contract
}
