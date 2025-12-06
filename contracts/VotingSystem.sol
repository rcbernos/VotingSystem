// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
contract electoralAdmin{
    bool votingIsOpen;

    function assignElectoralAdmin () public {
        // reassigns the Electoral Admin
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

    function winnerList () public {
        // show list of winners
    }
    
}

contract Candidate {
    //add an object to store candidates
    function addCandidate () public {
        // adds a candidate in the Candidate object and sets voteCount to 0
    }

    function resetVoteCount() public {
        //reset VoteCount in all Candidate entities/structs
    }
    
    function receiveVote() public {
        // add 1 voteCount to the candidate
    }
}
contract VoterID {
    //add way to store addresses in a VoterID subcontract or mapping
    function sendVote () public {
        // decrease 1 vote to the voter
        // calls receiveVote() in candidate
    }

    function resetVotes () public {
        //reset Votes in all addresses in VoterID
    }

    function delegateVote () public {
        // passing of voting rights
    }
}