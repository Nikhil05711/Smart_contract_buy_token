//SPDX-License-Identifier: MIT
import "./utils/OwnableUpgradeable.sol";
import "./ERC20Upgradeable.sol";

pragma solidity ^0.8.13;

contract Token is OwnableUpgradeable, ERC20Upgradeable {
    uint256 public _totalSupply;

    // constructor() ERC20Upgradeable("COIN", "CN", 9) {
    //     _totalSupply = 100000000 * (10**9);
    //     _mint(owner(), _totalSupply);
    // }

    function __Token_init(uint256 totalSupply_) internal onlyInitializing {
        __Token_init_unchained(totalSupply_);
    }

    function __Token_init_unchained(uint256 totalSupply_)
        internal
        onlyInitializing
    {
        _totalSupply = totalSupply_;
        _mint(owner(), _totalSupply);
    }

    function balance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    function transferPrice(
        address from,
        address to,
        uint256 amount
    ) public {
        _transfer(from, to, amount);
    }

    function mint(address account, uint256 amount) public {
        _mint(account, amount);
    }

    function burn(address account, uint256 amount) public {
        _burn(account, amount);
    }
}
