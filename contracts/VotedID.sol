// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract VoterID{
    address Owner;
    uint votes;

    function decreaseVote() public {
        votes -= 1;
    }
}