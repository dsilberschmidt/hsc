// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";

contract InflationEA is ChainlinkClient, ConfirmedOwner {
    using Chainlink for Chainlink.Request;
    uint256 private constant ORACLE_PAYMENT =
        ((1 * LINK_DIVISIBILITY) / 100) * 5;
    uint256 public accumulatedInflation;
    string constant jobId = "fc2ecbc2f58f45c4868d3959850df8c3";
    string public startDate = "2004-01-01";

    event RequestValue(bytes32 indexed requestId, uint256 indexed value);

    constructor() ConfirmedOwner(msg.sender) {
        // KOVAN
        setChainlinkToken(0xa36085F69e2889c224210F603D836748e7dC0088);
        setChainlinkOracle(0xf71775b3640D7034466e0321E35c5CFB78fd212F);
    }

    function requestValue() public returns (bytes32 requestId) {  // originalmente  onlyOwner
        string memory s1 = '{"id": 0, "data": { "start_date": "' ;
        string memory s2 = '"}}' ;
        string memory s3 = string.concat(s1, startDate, s2) ;
        Chainlink.Request memory req = buildChainlinkRequest(
            stringToBytes32(jobId),
            address(this),
            this.fulfillValue.selector
        );
        req.add("post", "https://evening-forest-80004.herokuapp.com");
        req.add(
            "requestData",
            //'{"id": 0, "data": { "start_date": "2004-01-01"}}'
            s3
        );
        req.add("path", "data,result");
        req.addInt("multiply", 1000); // converts float 1.4914820114715215 into integer 1491
        return sendChainlinkRequest(req, ORACLE_PAYMENT);
    }

    function fulfillValue(bytes32 _requestId, uint256 _accumulatedInflation) public recordChainlinkFulfillment(_requestId) {
        emit RequestValue(_requestId, _accumulatedInflation);
        accumulatedInflation = _accumulatedInflation;
    }

    function storeStartDate (string memory _startDate) public {
         startDate = _startDate;
    }

    //function showStartDate() public view returns (string){
    //    return startDate;
    //}

    function stringToBytes32(string memory source) private pure returns (bytes32 result)     {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
        assembly {
            // solhint-disable-line no-inline-assembly
            result := mload(add(source, 32))
        }
    }
}
