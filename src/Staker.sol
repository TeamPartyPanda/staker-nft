// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {ERC4883Composer} from "./ERC4883Composer.sol";
import {IERC4883} from "./IERC4883.sol";
import {ERC4883} from "./ERC4883.sol";
import {Colours} from "./Colours.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {IERC165} from "@openzeppelin/contracts/interfaces/IERC165.sol";
import {IERC721Metadata} from "@openzeppelin/contracts/interfaces/IERC721Metadata.sol";
import {ERC721Holder} from "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";


//   _____ ______   ____  __  _    ___  ____  
//  / ___/|      | /    ||  |/ ]  /  _]|    \ 
// (   \_ |      ||  o  ||  ' /  /  [_ |  D  )
//  \__  ||_|  |_||     ||    \ |    _]|    / 
//  /  \ |  |  |  |  _  ||     \|   [_ |    \ 
//  \    |  |  |  |  |  ||  .  ||     ||  .  \
//   \___|  |__|  |__|__||__|\_||_____||__|\_|
                                           
contract Staker is ERC4883Composer, Colours, ERC721Holder {
    /// ERRORS

    /// EVENTS

    constructor()
        ERC4883Composer("Staker", "STK", 0.00042 ether, 0xeB10511109053787b3ED6cc02d5Cb67A265806cC, 99, 4883)
    {}

    string[] executionLayerClients = ["Besu", "Erigon", "Geth", "Nethermind"];
    string[] consensusLayerClients = ["Lighthouse", "Lodestar", "Nimbus", "Prysm", "Teku"];

    function colourId(uint256 tokenId) public view returns (uint8) {
        if (!_exists(tokenId)) {
            revert NonexistentToken();
        }

        return _generateColourId(tokenId);
    }

    function _generateDescription(uint256 tokenId) internal view virtual override returns (string memory) {
        return string.concat(
            "Staker.  Staker #",
            Strings.toString(tokenId),
            ".  ERC4883 composable NFT.  Staker mascot inspired by Proteus node"
        );
    }

    function _generateAttributes(uint256 tokenId) internal view virtual override returns (string memory) {
        string memory attributes = string.concat(
            '{"trait_type": "Execution Client", "value": "',
            _generateExecutionLayerClient(tokenId),
            '"}, {"trait_type": "Consensus Client", "value": "',
            _generateConsensusLayerClient(tokenId),
            '{"trait_type": "Colour", "value": "',
            _generateColour(tokenId),
            '"}',
            _generateAccessoryAttributes(tokenId),
            _generateBackgroundAttributes(tokenId)
        );

        return string.concat('"attributes": [', attributes, "]");
    }

    function _generateSVG(uint256 tokenId) internal view virtual override returns (string memory) {
        string memory svg = string.concat(
            '<svg id="Staker" width="500" height="500" viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg">',
            _generateBackground(tokenId),
            _generateSVGBody(tokenId),
            _generateAccessories(tokenId),
            "</svg>"
        );

        return svg;
    }

    function _generateSVGBody(uint256 tokenId) internal view virtual override returns (string memory) {
        string memory colourValue = _generateColour(tokenId);

        return string.concat(
            '<g id="Staker-',
            Strings.toString(tokenId),
            '">' "<desc>Staker mascot inspired by Proteus node</desc>"
            '<g stroke="black" stroke-width="12" stroke-linecap="round" stroke-linejoin="round" fill="',
            colourValue,
            '">' '<rect x="91" y="319" width="313" height="98" />' '<rect x="91" y="277" width="313" height="54" />'
            '<rect x="91" y="84" width="313" height="193" />' '<line x1="223" y1="386" x2="364" y2="386" />'
            '<path d="M303 328C303 334.168 297.844 341.367 285.814 347.382C274.143 353.218 257.6 357 239 357C220.4 357 203.857 353.218 192.186 347.382C180.156 341.367 175 334.168 175 328C175 321.832 180.156 314.633 192.186 308.618C203.857 302.782 220.4 299 239 299C257.6 299 274.143 302.782 285.814 308.618C297.844 314.633 303 321.832 303 328Z" />'
            "</g>" '<ellipse cx="188.5" cy="250.5" rx="15.5" ry="14.5" fill="grey"/>'
            '<ellipse cx="302.5" cy="249.5" rx="15.5" ry="14.5" fill="grey"/>' "</g>"
        );
    }

    function _generateColourId(uint256 tokenId) internal view returns (uint8) {
        uint256 id = uint256(keccak256(abi.encodePacked("Colour", address(this), Strings.toString(tokenId))));
        return uint8(id % colours.length);
    }

    function _generateConsensusLayerClientId(uint256 tokenId) internal view returns (uint8) {
        uint256 id =
            uint256(keccak256(abi.encodePacked("Consensus Layer Client", address(this), Strings.toString(tokenId))));
        return uint8(id % consensusLayerClients.length);
    }

    function _generateExecutionLayerClientId(uint256 tokenId) internal view returns (uint8) {
        uint256 id =
            uint256(keccak256(abi.encodePacked("Execution Layer Client", address(this), Strings.toString(tokenId))));
        return uint8(id % executionLayerClients.length);
    }

    function _generateColour(uint256 tokenId) internal view returns (string memory) {
        return colours[_generateColourId(tokenId)];
    }

    function _generateConsensusLayerClient(uint256 tokenId) internal view returns (string memory) {
        return consensusLayerClients[_generateConsensusLayerClientId(tokenId)];
    }

    function _generateExecutionLayerClient(uint256 tokenId) internal view returns (string memory) {
        return executionLayerClients[_generateExecutionLayerClientId(tokenId)];
    }

    function _generateTokenName(uint256 tokenId) internal view virtual override returns (string memory) {
        return string.concat(_generateColour(tokenId), " Staker");
    }
}

//  ______
// < Staker >
//  ------
//         \   ^__^
//          \  (oo)\_______
//             (__)\       )\/\
//                 ||----w |
