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

    // used mapping to do O(1) checks for candidates instead of iterating through the list
    mapping(string => bool) private candidates;
    string[] private candidateList;

    struct Vote {
        address voter;
        uint weight;
    }

    mapping(string => Vote[]) private votes;

    address private adminContract;

    constructor(address _adminContract) {
        adminContract = _adminContract;
    }

    modifier onlyAdmin() {
        require(msg.sender == adminContract, "Only Electoral Admin can make changes!");
        _;
    }

    function addCandidate (string memory newCandidate) public onlyAdmin() {
        require(candidates[newCandidate] == false, "Candidate already exists!");
        candidates[newCandidate] = true;
        candidateList.push(newCandidate);
    }

    function resetVoteCount() public {
        // TODO:
    }

    function receiveVote(string memory _candidate, address _voter, uint _weight) public {
        Vote memory new_vote = Vote({
            voter: _voter,
            weight: _weight
        });

        require(candidates[_candidate] == true, "Candidate does not exist!");

        votes[_candidate].push(new_vote);
    }


    function getResults() public view onlyAdmin() returns (string[] memory, uint[] memory results) {
        results = new uint[](candidateList.length);
        for (uint256 i = 0; i < candidateList.length; i++) {
            results[i] = votes[candidateList[i]].length;
        }
        return (candidateList, results);
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