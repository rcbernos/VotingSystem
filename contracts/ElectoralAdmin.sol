// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ElectoralAdmin{
    // intended features is to set votes and voteCount
    address electoralAdmin = msg.sender;
    address candidateContract;
    address voterIDContract;

    function setCandidateContract(address cc) public {
        require(msg.sender == electoralAdmin, "Must be contract owner to set");
        candidateContract = cc;
    }

    function setVoterIDContract(address vid) public {
        require(msg.sender == electoralAdmin, "Must be contract owner to set");
        voterIDContract = vid;
    }

    function instantiateVoterID()public{

    }
    function instantiateCandidate()public{

    }
    function setVotes () public {

    }
}