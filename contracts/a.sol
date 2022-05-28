//SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;
import "./Token/utils/SafeMath.sol";
import "./Token/utils/Ownable.sol";
import "./Token/Token.sol";

contract smartContract is Ownable {
    using SafeMath for uint256;
    address public AdminAddress;
    Token public Coin;
    uint256 investerID;
    bool public initialized;

    mapping(address => mapping(uint256 => purchaseInfo)) public buyInfo;
    mapping(address => uint256[]) getIDByAddress;
    mapping(uint256 => uint256) public burningAmount;
    mapping(uint256 => uint256) public amountAfterBurning;
    mapping(uint256 => uint256) public ownerSurplusToAdmin;

    struct purchaseInfo {
        uint256 ID;
        uint256 buyTime;
        uint256 purchaseToken;
        uint256 burnToken;
        uint256 userGets;
        uint256 ownerSurplus;
        uint256 BNBchargedByAdmin;
    }

    modifier onlyAdmin() {
        require(AdminAddress == _msgSender(), "Error: caller is not the Admin");
        _;
    }

    event buyTokenDetailsAddresses(
        address user,
        address AdminAddress,
        address owner
    );

    event buyTokenDetails(
        uint256 amount,
        uint256 burningAmount,
        uint256 amountAfterBurning,
        uint256 ownerSurplus,
        uint256 BNBchargedByAdmin
    );

    function initialize(
        Token _Coin,
        address _adminAddress,
        uint256 amount
    ) public onlyOwner {
        require(initialized != true, "Already Initialized");
        Coin = Token(_Coin);
        AdminAddress = address(_adminAddress);
        Coin.transferPrice(owner(), _adminAddress, amount);
        initialized = true;
    }

    function setAdminAddress(address _admin) public onlyOwner {
        AdminAddress = _admin;
    }

    function totalInvesters() public view returns (uint256) {
        return investerID;
    }

    function getIdsOfUser(address user) public view returns (uint256[] memory) {
        return getIDByAddress[user];
    }

    function buyToken(uint256 amount, address user) public payable {
        require(msg.sender == AdminAddress, "Only Admin can make transaction");
        require(
            Coin.balance(AdminAddress) > amount,
            "Error: Admin does not have enough balance"
        );
        unchecked {
            investerID++;
        }
        uint256 id = investerID;
        burningAmount[id] = (1 * amount) / 100;
        amountAfterBurning[id] = amount.sub(burningAmount[id]);
        Coin.transferPrice(AdminAddress, user, amountAfterBurning[id]);

        buyInfo[user][id].ID = investerID;
        buyInfo[user][id].buyTime = block.timestamp;
        buyInfo[user][id].purchaseToken = amount;
        buyInfo[user][id].burnToken = burningAmount[id];
        buyInfo[user][id].userGets = amountAfterBurning[id];
        ownerSurplusToAdmin[id] = amountAfterBurning[id].div(2);
        require(
            Coin.balance(owner()) > ownerSurplusToAdmin[id],
            "Error: Owner does not have enough balance"
        );
        buyInfo[user][id].ownerSurplus = ownerSurplusToAdmin[id];
        Coin.transferPrice(owner(), AdminAddress, ownerSurplusToAdmin[id]);
        msg.value == (1 * ownerSurplusToAdmin[id]).div(1000000000);
        payable(owner()).transfer(msg.value);
        buyInfo[user][id].BNBchargedByAdmin = msg.value;
        emit buyTokenDetailsAddresses(user, AdminAddress, owner());
        emit buyTokenDetails(
            amount,
            burningAmount[id],
            amountAfterBurning[id],
            ownerSurplusToAdmin[id],
            msg.value
        );
    }

    event swapTokenBNB(address user, uint256 ownerInitiative, uint256 BNB);
}
