// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract WeekDays {

    // Enum to represent days of the week
    enum Day { Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday }
 Day currentDay;

    constructor() {
        currentDay = Day.Monday;
    }
    // Individual setter functions for each day

        function setMonday() external {
        currentDay = Day.Monday;
    }

    function setTuesday() external {
        currentDay = Day.Tuesday;
    }

    function setWednesday() external {
        currentDay = Day.Wednesday;
    }

    function setThursday() external {
        currentDay = Day.Thursday;
    }

    function setFriday() external {
        currentDay = Day.Friday;
    }

    function setSaturday() external {
        currentDay = Day.Saturday;
    }

    function setSunday() external {
        currentDay = Day.Sunday;
    }

    function getCurrentDay() external view returns (string memory) {
        if (currentDay == Day.Monday) {
            return "Monday";
        } else if (currentDay == Day.Tuesday) {
            return "Tuesday";
        } else if (currentDay == Day.Wednesday) {
            return "Wednesday";
        } else if (currentDay == Day.Thursday) {
            return "Thursday";
        } else if (currentDay == Day.Friday) {
            return "Friday";
        } else if (currentDay == Day.Sunday) {
            return "Holiday";
        } else {
            return "Saturday";
        }
    }
}
