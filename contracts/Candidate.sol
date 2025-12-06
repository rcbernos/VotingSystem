// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Candidate {
    address electoralAdmin = msg.sender;
    address adminContract;
    address voterIDContract;
    uint voteCount;

    function setElectoralAdminContract(address ea) public {
        require(msg.sender == electoralAdmin, "Must be contract owner to set");
        adminContract = ea;
    }

    function setVoterIDContract(address vid) public {
        require(msg.sender == electoralAdmin, "Must be contract owner to set");
        voterIDContract = vid;
    }



}