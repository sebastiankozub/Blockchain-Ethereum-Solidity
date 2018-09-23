pragma solidity "0.4.24";
pragma experimental ABIEncoderV2;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol"; 


contract LegoCertificationStore is Ownable {
    
    using SafeMath for uint256;

    event NewCertificate(uint certificateId, string name, string number, 
        string theme, string subtheme, string descritpion, string bricksJsonData, uint dna);

    uint public dnaDigits = 16;
    uint public dnaModulus = 10 ** dnaDigits;
    // uint public cooldownTime = 1 days;

    struct LegoCertificate {
        string name;
        string number;
        string theme;
        string subtheme;
        string descritpion;
        string bricksJsonData;
        uint dna;
    }

    LegoCertificate[] public certificates;

    mapping (uint => address) public certificateToOwner;
    mapping (address => uint) public ownerCertificateCount;

    function createRandomZombie(string _name, 
        string _number,
        string _theme,
        string _subtheme,
        string _descritpion,
        string _bricksJsonData, string[] _bricks, string[] _registers) public {
        //require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name, _descritpion, _bricksJsonData);
        //randDna = randDna - randDna % 100;
        _createCertificate(_name, _number, _theme, _subtheme, _descritpion, _bricksJsonData, randDna);
    }

    function _createCertificate(string _name, 
        string _number,
        string _theme,
        string _subtheme,
        string _descritpion,
        string _bricksJsonData,
        uint _dna) internal {
        uint id = certificates.push(
            LegoCertificate(_name, _number, _theme, _subtheme, _descritpion, _bricksJsonData, _dna)) - 1;
        certificateToOwner[id] = msg.sender;
        ownerCertificateCount[msg.sender]++;
        emit NewCertificate(id, _name, _number, _theme, _subtheme, _descritpion, _bricksJsonData, _dna);
    }
    
    function _generateRandomDna(string _str1, string _str2, string _str3) private view returns (uint) {
        uint rand1 = uint(keccak256(_str1));
        uint rand2 = uint(keccak256(_str2));
        uint rand3 = uint(keccak256(_str3));
        return (rand1 + rand2 - rand3) % dnaModulus;
    }

}