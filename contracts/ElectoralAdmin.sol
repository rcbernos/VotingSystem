// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ElectoralAdmin{
    // intended features is to set votes and voteCount
    address electoralAdmin = msg.sender;
    address candidateContract;
    address voterIDContract;
    bool votingIsOpen;

    function setCandidateContract(address cc) public {
        require(msg.sender == electoralAdmin, "Must be contract owner to set");
        candidateContract = cc;
    }

    function setVoterIDContract(address vid) public {
        require(msg.sender == electoralAdmin, "Must be contract owner to set");
        voterIDContract = vid;
    }

    function resetVotes () public {
        //reset Votes in VoterID
    }

    function resetVoteCount() public {
        //reset VoteCount in Candidate
    }

    function openVoting() public {
        //allows users to vote through VoterID contract
    }

    function closeVoting() public {
        // prevents any additional changes to votes and VoteCount
    }
    function countVotes() public {
        // counts the votes for each candidate
    }
}