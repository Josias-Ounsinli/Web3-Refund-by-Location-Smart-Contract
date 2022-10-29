// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <0.9.0;
// import "../../openzeppelin-contracts/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract refundByLocation {

    // create events to send to app
    event CompletedEvent (address employeeaddress);

    event FailedEvent (address employeeaddress);

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
        Employee employees;
        Employer employer;
    }

    // Recorded employers
    mapping(address => Employer) public employers;
    uint public Employercount;

    // Recorded employees
    mapping(address => Employee) public employees;
    mapping (uint => address) public employee_mapping;
    uint public Employeecount;

    // Recorded contract
    mapping(address => contract_info) public contracts;
    uint public Contractcount;

    //Employer functions
    function addEmployer (string memory _name , address user_address) private {
        Employercount ++;
        employers[user_address] = Employer(Employercount, _name, user_address);
    }

    function  initialize_employers(address[] memory a) public {
        for (uint add=0 ; add < a.length; add++){
            addEmployer(string.concat("Employer " , Strings.toString(add)) , a[add]);
            }
        // addEmployee("Employee 1" , a[1]);
    }
    // Employee functions
    function addEmployee (string memory _name , address user_address) private {
        Employeecount ++;
        employees[user_address] = Employee(Employeecount, _name, user_address);
    }

    function  initialize_employees(address[] memory a) public{
        // addEmployer("Employer 1" , a[0]);
         for (uint add=0 ; add < a.length; add++){
            addEmployee(string.concat("Employee " , Strings.toString(add)) , a[add]);
            }
    }


    // Contract info creation function
    function Create_contract_data( uint[2] memory minimum_points, uint[2] memory maximum_points, uint duration, string memory employee_name , address employee_address, address employer_address) public{
        if (! (employees[employee_address].id > 0)){
            addEmployee(employee_name, employee_address);
            employee_mapping[Employeecount] = employee_address;
         }
        Contractcount++;
        contracts[employee_address] = contract_info(Contractcount, minimum_points[0] , minimum_points[1] ,maximum_points[0] , maximum_points [1], block.timestamp ,duration , 0 ,true , false ,employees[employee_address],employers[employer_address]);
    }

    // Location function
    function get_location( uint  longitude, uint  latitude) public  returns (bool){
        
        contract_info memory found_contract = contracts[msg.sender];
        if (found_contract.id > 0){
        if ( found_contract.completed != true){
            uint duration = (block.timestamp - found_contract.starting_time) / 60 ;
            if (duration < found_contract.duration){ 
                found_contract.gathered_location_count = found_contract.gathered_location_count + 1;
                if (! (found_contract.min_long <= longitude && found_contract.max_long >= longitude && found_contract.min_lat <= latitude && found_contract.max_lat >= latitude) ){
                    found_contract.contract_truth = false;
                }
            }else if ( duration >=found_contract.duration){
                check_completion(found_contract);
               
            }
        }
            return true;
            }else{
                return false;
            }
    }

    // check completion
    function check_completion(contract_info memory found_contract) private{
        uint minimum_check = found_contract.duration * 3 / 4 ;
        if (found_contract.contract_truth && minimum_check <= found_contract.gathered_location_count){
                    found_contract.completed = true;
                    emit CompletedEvent(found_contract.employees.public_address);
                }
                else{
                    found_contract.completed = false;
                    emit FailedEvent(found_contract.employees.public_address);
                }
    }

}