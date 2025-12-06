// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract VotingSystem{
    //add way to store addresses in a VoterID subcontract or mapping
    //add an object to store candidates

    bool votingIsOpen;

    function assignElectoralAdmin () public {
        // reassigns the Electoral Admin
    }

    function delegateVote () public {
        // passing of voting rights
    }

    function addCandidate () public {
        // adds a candidate in the Candidate object and sets voteCount to 0
    }

    function resetVotes () public {
        //reset Votes in all addresses in VoterID
    }

    function resetVoteCount() public {
        //reset VoteCount in all Candidate entities/structs
    }

    function openVoting() public {
        //allows voters to vote 
    }

    function closeVoting() public {
        // prevents any additional changes to votes and VoteCount
    }
    function countVotes() public {
        // counts the votes for each candidate
    }

    function voteCandidate() public {
        //select which candidate to vote and increase their vote by one. 
        // Make sure the address has a voterID that matches to it and
        // also has at least one vote
        // also decrease votes in VoterID for the respective address
    }
    
}