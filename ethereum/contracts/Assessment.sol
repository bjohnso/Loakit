pragma solidity >=0.7.0 <0.9.0;

contract Assessment {

    LoaLib.Sponsor public sponsor;
    LoaLib.School public school;

    constructor(LoaLib.School school) {
        require(
            bytes(school.name).length > 0,
            "School must have a name."
        );
        require(
            school.delegate != address(0x0),
            "School must have an address."
        );
        require(
            school.syllabus.questions.length > 0,
            "School must have a syllabus."
        );
        require(
        school.syllabus.questions.length == school.syllabus.answers.length,
        "School syllabus must be complete."
        );
    }




}
