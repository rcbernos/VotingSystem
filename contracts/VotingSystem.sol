// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
contract electoralAdmin{
    bool votingIsOpen;
    address public owner;
    Candidate public candidateContract;
    Voter public voterContract;

    constructor() {
        owner = msg.sender;
        votingIsOpen = false;
    }

    function setVoter(address voterAddress) public onlyOwner(){
        voterContract = Voter(voterAddress);
    }

    function setCandidate(address candidateAddress) public onlyOwner(){
        candidateContract = Candidate(candidateAddress);
    }

    modifier onlyOwner() {
        require(owner==msg.sender, "Only Admin can make changes!");
        _;
    }

    function addCandidate(string memory newCandidate) private onlyOwner() {
        candidateContract.addCandidate(newCandidate);
    }

    function assignElectoralAdmin (address new_admin) public onlyOwner() {
        owner = new_admin;
    }

    function openVoting() public onlyOwner() {
        votingIsOpen = true;
    }

    function closeVoting() public onlyOwner() {
        // prevents any additional changes to votes and VoteCount
        votingIsOpen = false;
    }

    struct Results {
        string candidate;
        uint vote_count;
    }

    function countVotes() private view returns (Results[] memory results){
        // counts the votes for each candidate
        // in this case, its already counted 
        // TODO: remove later?
        // TODO: I essentiallyd did another iteration that just converts the resutls into a single type, kinda redundant
        // but i don't see much use for this function anyways, since candidate keeps track of the votes.
        (string[] memory candidates, uint[] memory vote_counts) = candidateContract.getResults();
        results = new Results[](candidates.length);

        for (uint256 i = 0; i < candidates.length; i++) {
            results[i] = Results({
                candidate: candidates[i],
                vote_count: vote_counts[i]
            });
        }

    }

    function winnerList () public view returns (string[] memory winning_candidates, uint winning_count){
        Results[] memory results = countVotes();
        winning_count = 0;
        uint winner_count = 0;
        for (uint256 i = 0; i < results.length; i++) {
            if (results[i].vote_count > winning_count) {
                winning_count = results[i].vote_count;
                winner_count = 1;
            }
            else if (results[i].vote_count == winning_count) {
                winner_count += 1;
            }
        }

        // small optimization instead of creating a new dynamic array every iteration.
        winning_candidates = new string[](winner_count);
        uint j = 0;
        for (uint256 i = 0; i < results.length; i++) {
            if (results[i].vote_count == winning_count) {
                winning_candidates[j] = results[i].candidate;
                j += 1;
            }
        }

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

    function resetVoteCount() public onlyAdmin() {
        // UNTESTED CODE
        // Unsure how delete interacts with mappings.
        for (uint256 i = 0; i < candidateList.length; i++) {
            delete votes[candidateList[i]];
        }
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
            uint total_count = 0;
            for (uint256 j = 0; j < votes[candidateList[i]].length; j++) {
                total_count += votes[candidateList[i]][j].weight;
            }
            results[i] = total_count;
        }
        return (candidateList, results);
    }
}
contract Voter {
    bool votingIsOpen;
    address private adminAddress;
    address[] private voters;
    Candidate public candidateContract;
    electoralAdmin public adminContract;

    constructor(address _adminContract) {
        adminContract = electoralAdmin(_adminContract);
        adminAddress = _adminContract;
    }

    mapping(address => uint) private voteWeight;

    function isRegistered(address _voter) public view returns (bool) {
        for (uint i = 0; i < voters.length; i++) {
            if (voters[i] == _voter) {
                return true; // match found
            }
        }
        return false;
    }

    function registerVoter(address _voter, uint _weight) public {
        // set the voting weight for this voter
        require(!isRegistered(_voter), "Voter is already registered!");
        voteWeight[_voter] = _weight;   
        voters.push(_voter);
    }

    function setCandidate(address _candidateContract) public {
        require(msg.sender==adminAddress, "Only the Electoral Admin can set the candidate contract");
        candidateContract = Candidate(_candidateContract);
    }

    //add way to store addresses in a VoterID subcontract or mapping
    function sendVote (string memory _candidate) public {
        require(votingIsOpen, "Voting is closed");
        require(voteWeight[msg.sender] > 0, "No votes left");
        // calls receiveVote() in candidate
        candidateContract.receiveVote(_candidate, msg.sender, voteWeight[msg.sender]);
        // sets voteweight to 0
        voteWeight[msg.sender] = 0;
    }

    function setVotes (uint _newVoteWeight) public {
        require(msg.sender==adminAddress, "Only the Electoral Admin can set the vote weights");
        for (uint i = 0; i < voters.length; i++) {
            voteWeight[voters[i]] = _newVoteWeight;
        }
    }

    function delegateVote (address _delegater, address _delegatee) public {
        // passing of voting rights
        require(msg.sender == _delegater, "Only the delegater can delegate their vote");
        require(voteWeight[_delegater] > 0, "Delegater has no votes");
        voteWeight[_delegatee] += voteWeight[_delegater];
        voteWeight[_delegater] = 0;
    }
    function openVoting() public {
        require(msg.sender == adminAddress, "Only admin can open voting");
        votingIsOpen = true;
    }

    function closeVoting() public {
        require(msg.sender == adminAddress, "Only admin can close voting");
        votingIsOpen = false;
    }
}