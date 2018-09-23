pragma solidity "0.4.24";

import "./zombiehelper.sol";


contract ZombieAttack is ZombieHelper {

    uint public randNonce = 0;
    uint public attackVictoryProbability = 70;

    function attack(uint _zombieId, uint _targetId) external onlyOwnerOf(_zombieId) {
        Zombie storage myZombie = zombies[_zombieId];
        Zombie storage enemyZombie = zombies[_targetId];
        uint rand = randMod(100);
        if (rand <= attackVictoryProbability) {
            myZombie.winCount++;
            myZombie.level++;
            enemyZombie.lossCount++;
            feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");
        } else {
            myZombie.lossCount++;
            enemyZombie.winCount++;
            _triggerCooldown(myZombie);
        }
    }
    
    function randMod(uint _modulus) internal returns(uint) {
        randNonce++;    
        return uint(keccak256(now, msg.sender, randNonce)) % _modulus;
    }
}
