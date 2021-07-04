pragma solidity >=0.7.0 <0.9.0;

library LoaLib {
    struct Sponsor {
        string name; // sponsor name
        address delegate; // entity delegated to
    }

    struct School {
        string name; // school name
        address delegate; // entity delegated to
        Syllabus syllabus; // school syllabus
        address sponsor; // address of sponsor
        bool agreed; // has agreed to sponsor promise
        uint score; // school score
    }

    struct Syllabus {
        string[] questions; // questions to assess learners
        string[] answers; // answers to assessment
    }

    struct Learner {
        string name; // learner name
        address school; // address of school
        address learner; // address of learner
        uint score; // learner score
    }
}
