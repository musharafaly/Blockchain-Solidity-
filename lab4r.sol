// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleVoting {
    
    // Enum to represent the voting options
    enum VoteOption { NOT_VOTED, YES, NO }

    // Variable to store the current vote
    VoteOption vote;
    
    // Constructor to initialize the vote to NOT_VOTED
    constructor() {
        vote = VoteOption.NOT_VOTED;
    }
    
    // Function to cast a "Yes" vote
    function voteYes() external {
        vote = VoteOption.YES;
    }

    // Function to cast a "No" vote
    function voteNo() external {
        vote = VoteOption.NO;
    }

    // Function to get the current vote status as a string
    function getCurrentVote() external view returns (string memory) {
        if (vote == VoteOption.YES) {
            return "Yes";
        } else if (vote == VoteOption.NO) {
            return "No";
        } else {
            return "Not Voted";
        }
    }
}
