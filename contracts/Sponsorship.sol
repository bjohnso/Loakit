pragma solidity >=0.7.0 <0.9.0;

contract Sponsorship {

    Sponsor public sponsor; // sponsor
    uint256 stake; // amount of gwei to stake
    uint scoreRequirement; // pass mark to validate this contract

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
        sponsor.name = sponsorName;
        sponsor.delegate = msg.sender;
    }

    mapping(address => School) public schools;

    function addSchool(string memory name, string[] memory questions, string[] memory answers) public {
        require(
            msg.sender != sponsor.delegate,
            "The sponser may not also be a school."
        );
        require(
            questions.length == answers.length,
            "Every question must have an answer."
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

    function selectSchool(address schoolAddress) public view returns (address selectedSchool) {
        require(
            msg.sender == sponsor.delegate,
            "Only the sponsor may select a school."
        );

        School memory school = schools[schoolAddress];

        if (school.delegate == schoolAddress) {
            school.selected = true;
            selectedSchool = school.delegate;
        }

        return selectedSchool;
    }
}