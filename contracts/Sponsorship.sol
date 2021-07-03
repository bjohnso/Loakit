pragma solidity >=0.7.0 <0.9.0;

contract Sponsorship {

    Sponsor public sponsor; // sponsor
    uint256 public balance; // amount of wei staked in this contract
    uint public scoreRequirement; // pass mark to validate this contract
    uint256 public minimumStake = 10000000000000000; // minimum stake for this contract
    address public selectedSchool;

    struct Sponsor {
        string name; // sponsor name
        address delegate; // entity delegated to
    }

    struct Syllabus {
        string[] questions; // questions to assess learners
        string[] answers; // answers to assessment
    }

    struct School {
        string name; // school name
        Syllabus syllabus; // school syllabus
        address delegate; // entity delegated to
        bool selected; // is selected by the sponsor
    }

    struct Learner {
        bool agreed; // has agreed to promise
        uint score; // learner score
    }

    constructor(string memory sponsorName) {
        require(
            bytes(sponsorName).length > 0,
            "Sponsor must have a name"
        );
        sponsor.name = sponsorName;
        sponsor.delegate = msg.sender;
    }

    mapping(address => School) public schools;

    function stakeReward(uint score) public payable {
        require(
            msg.sender == sponsor.delegate,
            "Only the sponsor may stake a reward."
        );
        require(
            scoreRequirement == 0,
            "A reward can not be staked more than once."
        );
        require(
            msg.value >= minimumStake,
            "A stake can not be less than 0.01 eth."
        );
        require(
            score > 0,
            "A score can not be 0."
        );

        balance += msg.value;
        scoreRequirement = score;
    }


    function addSchool(string memory name, string[] memory questions, string[] memory answers) public {
        require(
            msg.sender != sponsor.delegate,
            "The sponsor may not also be a school."
        );
        require(
            questions.length == answers.length,
            "Every question must have an answer."
        );
        require(
            scoreRequirement > 0,
            "A score requirement must be specified before a school can be added."
        );
        require(
            balance >= minimumStake,
            "A stake of at least 0.01 ether must be set before a school can be selected."
        );

        Syllabus memory syllabus = Syllabus({
        questions: questions,
        answers: answers
        });

        schools[msg.sender] = School({
        name: name,
        syllabus: syllabus,
        delegate: msg.sender,
        selected: false
        });
    }

    function selectSchool(address schoolAddress) public returns (address selected) {
        require(
            msg.sender == sponsor.delegate,
            "Only the sponsor may select a school."
        );
        require(
            selectedSchool == address(0x0),
            "A school can not be selected when one is already selected."
        );
        require(
            schools[schoolAddress].delegate == schoolAddress,
            "A school address must exist."
        );
        require(
            scoreRequirement > 0,
            "A score requirement must be specified before a school can be selected."
        );
        require(
            balance > minimumStake,
            "A stake of at least 0.01 ether must be set before a school can be selected."
        );

        School memory school = schools[schoolAddress];

        if (school.delegate == schoolAddress) {
            school.selected = true;
            selected = school.delegate;
            selectedSchool = selected;
        }

        return selected;
    }
}