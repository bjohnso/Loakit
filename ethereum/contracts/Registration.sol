pragma solidity >=0.7.0 <0.9.0;
import "./LoaLib.sol";

contract Registration {

    LoaLib.School public school;

    mapping(address => LoaLib.Learner) public learners;

    constructor(string memory schoolName) {
        require(
            bytes(schoolName).length > 0,
            "School must have a name"
        );

        string[] memory questions;
        string[] memory answers;

        school = LoaLib.School({
        name: schoolName,
        delegate: msg.sender,
        syllabus: LoaLib.Syllabus({
        questions: questions,
        answers: answers
        }),
        sponsor: address(0x0),
        score: 0
        });
    }

    function setSchoolSyllabus(string[] memory questions, string[] memory answers) public {
        require(
            school.delegate != address(0x0),
            "A school must exist before a syllabus can be created."
        );
        require(
            questions.length == answers.length,
            "Every question must have an answer."
        );

        school.syllabus = LoaLib.Syllabus({
        questions: questions,
        answers: answers
        });
    }

    function addLearner(string memory name) public {
        require(
            msg.sender != school.delegate,
            "The school may not also be a learner."
        );
        require(
            bytes(name).length > 0,
            "The learner must have a name."
        );
        require(
            learners[msg.sender].learner == address(0x0),
            "A learner can not be added more than once."
        );

        learners[msg.sender] = LoaLib.Learner({
        name: name,
        school: school.delegate,
        learner: msg.sender,
        score: 0
        });
    }
}