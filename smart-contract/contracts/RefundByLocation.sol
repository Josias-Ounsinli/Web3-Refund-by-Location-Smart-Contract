// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

contract refundByLocation {

    // Employer
    struct Employer {
        uint id;
        string name;
        address public_address;
    }

    // Employees
     struct Employee {
        uint id;
        string name;
        address public_address;
    }
    
    Employee[] public employees;

    //contract agreements (boundaries, durations, checkers for completion)
    struct contract_info{
        uint id;
        uint min_lat;
        uint max_lat;
        uint min_long;
        uint max_long;
        uint starting_time;
        uint duration;
        uint gathered_location_count;
        bool contract_truth;
        bool completed;
        Employee employee;
        Employer employer;
    }

    // Recorded employers

    // Recorded employees

    //Employer functions

    // Employee functions

    // Contract info creation function

    // Location function

    // check completion
}