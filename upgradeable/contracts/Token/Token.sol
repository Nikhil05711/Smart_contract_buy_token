//SPDX-License-Identifier: MIT
import "./utils/Ownable.sol";
import "./ERC20.sol";
import "./utils/Initializable.sol";

pragma solidity ^0.8.13;

contract Token is Ownable, ERC20 {
    uint256 public _totalSupply;

    constructor() ERC20("COIN", "CN", 9) {
        _totalSupply = 100000000 * (10**9);
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



309014849853ratn0000418https://www.koinbazar.com/transfer-history