pragma solidity >=0.4.2;

contract Election {
    // Model a Candidate

    string public candidate;

    struct Candidate {
        uint id;
        string name;
        string category;
        uint voteCount;
    }

    // // Store accounts that have voted
    // mapping(address => mapping(string => bool)) public voters;
    mapping(address => bool) public voters;
    // // Store Candidates
    // // Fetch Candidate
    mapping(uint => Candidate) public candidates;
    // // Store Candidates Count
    uint public candidatesCount;

    // // voted event
    event votedEvent (
        uint indexed _candidateId
    );

    constructor() public  {
        addCandidate("Gayathri V","MLA");
        addCandidate("Mrinal M","MLA");
        addCandidate("Nachappan S K","MLA");
        addCandidate("Manasa Kashyap","MLA");
    }

    function addCandidate (string memory _name,string memory _position) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, _position, 0);
    }

    function concat(string memory _base, string memory _value) internal returns (string memory) {
        bytes memory _baseBytes = bytes(_base);
        bytes memory _valueBytes = bytes(_value);

        string memory _tmpValue = new string(_baseBytes.length + _valueBytes.length);
        bytes memory _newValue = bytes(_tmpValue);

        uint i;
        uint j;

        for(i=0; i<_baseBytes.length; i++) {
            _newValue[j++] = _baseBytes[i];
        }

        for(i=0; i<_valueBytes.length; i++) {
            _newValue[j++] = _valueBytes[i];
        }

        return string(_newValue);
    }

    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);
        // .concat(_category)]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        // voters[string(abi.encodePacked(msg.sender)).concat(_category)] = true;
        voters[msg.sender] = true;
        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}

// vote for many posns
// hide no of votes till end of reflection (put timer and close)
// 