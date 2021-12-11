//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract MarriageContract {
    string public name = "MarriageCertificate";
    uint256 public cCount = 0;

    struct Cert {
        uint256 id;
        string certHash;
        string title;
        address author;
    }

    mapping(uint256 => Cert) public certs;

    event certUploadedEvent(
        uint256 id,
        string chash,
        string title,
        address uploader
    );

    constructor() {}

    function certUpload(string memory _hash, string memory _title) public {
        require(bytes(_hash).length > 0, "Cert Hash is not received");

        certs[cCount] = Cert(cCount, _hash, _title, msg.sender);
        cCount++;

        emit certUploadedEvent(cCount, _hash, _title, msg.sender);
    }
}
