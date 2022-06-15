// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @notice Simple ERC1155 token which cannot be transferred or burned.
contract SBT is ERC1155, Ownable {
    ///@dev mapping to check if account already has this token
    mapping(address => bool) public isTokenHolderMap;

    ///@notice Constructor - set url for token metadata
    constructor() ERC1155("") {}

    ///@notice if URI not set in constructor, use this function to set it
    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    ///@notice function to mint the token to the account
    ///@param account - address to mint the token to
    ///@param id - id of the token to mint
    function mint(address account, uint256 id) public {
        require(
            isTokenHolderMap[account] == false,
            "You already own this token"
        );
        isTokenHolderMap[account] = true;
        _mint(account, id, 1, "");
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public pure override {
        revert("Token is not transferable");
    }

    /**
     * @dev See {IERC1155-safeBatchTransferFrom}.
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public override {
        revert("Token is not transferable");
    }
}
