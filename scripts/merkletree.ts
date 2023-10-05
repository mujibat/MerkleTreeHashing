
const { MerkleTree } = require('merkletreejs');
const keccak256 = require('keccak256');

async function main() {
  

    let whiteListedAddresses = [
        "0xEB7A41D324ee4859E3cbFAd4b3820B82FCCe6658",
        "0x637CcDeBB20f849C0AA1654DEe62B552a058EA87",
        "0x2e504C9c22089cE75a600fF113e891d2c2D53d57",
        "0x235aAB1caE3D5dfD293aeaEC2CA4C6d0aABabdB2",
        "0xaEAA20f015E2711EfC318C9CC9Afb1b7096FFC9e",
        "0xBb3ecC8cFA0CE4C0fA2a7Fe875fB88A62420973a",
        "0xAEB9219D416D28f2EADB0A6C414E2776Fd9CD879"
    ]

     
    const leafNodes = whiteListedAddresses.map(addr => keccak256(addr)); 

   
    const merkleTree = new MerkleTree(leafNodes, keccak256, { sortPairs: true});

    
    const rootHash = merkleTree.getHexRoot();

    
    const claimingAddress = leafNodes[2];
    const hexProof = merkleTree.getHexProof(claimingAddress);

    console.log(`The proof of the inputed address is: ${hexProof}`);

  
    console.log("Whitelist Merkle Tree", merkleTree.toString());
    console.log("Root Hash: ", rootHash);


  
    console.log(merkleTree.verify(hexProof, claimingAddress, rootHash));

}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });