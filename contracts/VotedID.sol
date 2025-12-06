// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract VoterID{
    address electoralAdmin = msg.sender;
    address adminContract;
    address candidateContract;
    uint votes;

    function setCandidateContract(address cc) public {
        require(msg.sender == electoralAdmin, "Must be contract owner to set");
        candidateContract = cc;
    }

    function setElectoralAdminContract(address ea) public {
        require(msg.sender == electoralAdmin, "must be contract owner to set");
        adminContract = ea;
    }


    function decreaseVote() public {
        votes -= 1;
    }
}