// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract VoterID{
    address electoralAdmin = msg.sender;
    address adminContract;
    address candidateContract;
    uint votes;

    function setCandidateContract() public {

    }

    function setElectoralAdminContract() public {
        
    }


    function decreaseVote() public {
        votes -= 1;
    }
}