pragma solidity >=0.5.2;
pragma experimental ABIEncoderV2;

contract Lands {
    struct Landreg {
        uint256 id;
        uint256 area;
        string city;
        string state;
        uint256 landPrice;
        uint256 propertyPID;
        uint256 physicalSurveyNumber;
        string ipfsHash;
        string document;
    }

    struct Buyer {
        address id;
        string name;
        uint256 age;
        string city;
        string ntnNumber;
        string cnicNumber;
        string document;
        string email;
    }

    struct Seller {
        address id;
        string name;
        uint256 age;
        string ntnNumber;
        string cnicNumber;
        string landsOwned;
        string document;
    }

    struct LandInspector {
        uint256 id;
        string name;
        uint256 age;
        string designation;
    }

    struct LandRequest {
        uint256 reqId;
        address sellerId;
        address buyerId;
        uint256 landId;
        // bool requestStatus;
        // bool requested;
    }

    //key value pairs
    mapping(uint256 => Landreg) public lands;
    mapping(uint256 => LandInspector) public InspectorMapping;
    mapping(address => Seller) public SellerMapping;
    mapping(address => Buyer) public BuyerMapping;
    mapping(uint256 => LandRequest) public RequestsMapping;

    mapping(address => bool) public RegisteredAddressMapping;
    mapping(address => bool) public RegisteredSellerMapping;
    mapping(address => bool) public RegisteredBuyerMapping;
    mapping(address => bool) public SellerVerification;
    mapping(address => bool) public SellerRejection;
    mapping(address => bool) public BuyerVerification;
    mapping(address => bool) public BuyerRejection;
    mapping(uint256 => bool) public LandVerification;
    mapping(uint256 => address) public LandOwner;
    mapping(uint256 => bool) public RequestStatus;
    mapping(uint256 => bool) public RequestedLands;
    mapping(uint256 => bool) public PaymentReceived;

    address public Land_Inspector;
    address[] public sellers;
    address[] public buyers;

    uint256 public landsCount;
    uint256 public inspectorsCount;
    uint256 public sellersCount;
    uint256 public buyersCount;
    uint256 public requestsCount;

    event Registration(address _registrationId);
    event AddingLand(uint256 indexed _landId);
    event Landrequested(address _sellerId);
    event requestApproved(address _buyerId);
    event Verified(address _id);
    event Rejected(address _id);

    constructor() public {
        Land_Inspector = msg.sender;
        addLandInspector("Inspector 1", 45, "Tehsil Manager");
    }

    function addLandInspector(
        string memory _name,
        uint256 _age,
        string memory _designation
    ) private {
        inspectorsCount++;
        InspectorMapping[inspectorsCount] = LandInspector(
            inspectorsCount,
            _name,
            _age,
            _designation
        );
    }

    function getLandsCount() public view returns (uint256) {
        return landsCount;
    }

    function getBuyersCount() public view returns (uint256) {
        return buyersCount;
    }

    function getSellersCount() public view returns (uint256) {
        return sellersCount;
    }

    function getRequestsCount() public view returns (uint256) {
        return requestsCount;
    }

    function getArea(uint256 i) public view returns (uint256) {
        return lands[i].area;
    }

    function getCity(uint256 i) public view returns (string memory) {
        return lands[i].city;
    }

    function getState(uint256 i) public view returns (string memory) {
        return lands[i].state;
    }

    // function getStatus(uint i) public view returns (bool) {
    //     return lands[i].verificationStatus;
    // }
    function getPrice(uint256 i) public view returns (uint256) {
        return lands[i].landPrice;
    }

    function getPID(uint256 i) public view returns (uint256) {
        return lands[i].propertyPID;
    }

    function getSurveyNumber(uint256 i) public view returns (uint256) {
        return lands[i].physicalSurveyNumber;
    }

    function getImage(uint256 i) public view returns (string memory) {
        return lands[i].ipfsHash;
    }

    function getDocument(uint256 i) public view returns (string memory) {
        return lands[i].document;
    }

    function getLandOwner(uint256 id) public view returns (address) {
        return LandOwner[id];
    }

    function verifySeller(address _sellerId) public {
        require(isLandInspector(msg.sender));

        SellerVerification[_sellerId] = true;
        emit Verified(_sellerId);
    }

    function rejectSeller(address _sellerId) public {
        require(isLandInspector(msg.sender));

        SellerRejection[_sellerId] = true;
        emit Rejected(_sellerId);
    }

    function verifyBuyer(address _buyerId) public {
        require(isLandInspector(msg.sender));

        BuyerVerification[_buyerId] = true;
        emit Verified(_buyerId);
    }

    function rejectBuyer(address _buyerId) public {
        require(isLandInspector(msg.sender));

        BuyerRejection[_buyerId] = true;
        emit Rejected(_buyerId);
    }

    function verifyLand(uint256 _landId) public {
        require(isLandInspector(msg.sender));

        LandVerification[_landId] = true;
    }

    function isLandVerified(uint256 _id) public view returns (bool) {
        if (LandVerification[_id]) {
            return true;
        }
    }

    function isVerified(address _id) public view returns (bool) {
        if (SellerVerification[_id] || BuyerVerification[_id]) {
            return true;
        }
    }

    function isRejected(address _id) public view returns (bool) {
        if (SellerRejection[_id] || BuyerRejection[_id]) {
            return true;
        }
    }

    function isSeller(address _id) public view returns (bool) {
        if (RegisteredSellerMapping[_id]) {
            return true;
        }
    }

    function isLandInspector(address _id) public view returns (bool) {
        if (Land_Inspector == _id) {
            return true;
        } else {
            return false;
        }
    }

    function isBuyer(address _id) public view returns (bool) {
        if (RegisteredBuyerMapping[_id]) {
            return true;
        }
    }

    function isRegistered(address _id) public view returns (bool) {
        if (RegisteredAddressMapping[_id]) {
            return true;
        }
    }

    function addLand(
        uint256 _area,
        string memory _city,
        string memory _state,
        uint256 landPrice,
        uint256 _propertyPID,
        uint256 _surveyNum,
        string memory _ipfsHash,
        string memory _document
    ) public {
        require((isSeller(msg.sender)) && (isVerified(msg.sender)));
        landsCount++;
        lands[landsCount] = Landreg(
            landsCount,
            _area,
            _city,
            _state,
            landPrice,
            _propertyPID,
            _surveyNum,
            _ipfsHash,
            _document
        );
        LandOwner[landsCount] = msg.sender;
        // emit AddingLand(landsCount);
    }

    //registration of seller
    function registerSeller(
        string memory _name,
        uint256 _age,
        string memory _ntnNumber,
        string memory _cnicNumber,
        string memory _landsOwned,
        string memory _document
    ) public {
        //require that Seller is not already registered
        require(!RegisteredAddressMapping[msg.sender]);

        RegisteredAddressMapping[msg.sender] = true;
        RegisteredSellerMapping[msg.sender] = true;
        sellersCount++;
        SellerMapping[msg.sender] = Seller(
            msg.sender,
            _name,
            _age,
            _ntnNumber,
            _cnicNumber,
            _landsOwned,
            _document
        );
        sellers.push(msg.sender);
        emit Registration(msg.sender);
    }

    function updateSeller(
        string memory _name,
        uint256 _age,
        string memory _ntnNumber,
        string memory _cnicNumber,
        string memory _landsOwned
    ) public {
        //require that Seller is already registered
        require(
            RegisteredAddressMapping[msg.sender] &&
                (SellerMapping[msg.sender].id == msg.sender)
        );

        SellerMapping[msg.sender].name = _name;
        SellerMapping[msg.sender].age = _age;
        SellerMapping[msg.sender].ntnNumber = _ntnNumber;
        SellerMapping[msg.sender].cnicNumber = _cnicNumber;
        SellerMapping[msg.sender].landsOwned = _landsOwned;
    }

    function getSeller() public view returns (address[] memory) {
        return (sellers);
    }

    function getSellerDetails(address i)
        public
        view
        returns (
            string memory,
            uint256,
            string memory,
            string memory,
            string memory,
            string memory
        )
    {
        return (
            SellerMapping[i].name,
            SellerMapping[i].age,
            SellerMapping[i].ntnNumber,
            SellerMapping[i].cnicNumber,
            SellerMapping[i].landsOwned,
            SellerMapping[i].document
        );
    }

    function registerBuyer(
        string memory _name,
        uint256 _age,
        string memory _city,
        string memory _ntnNumber,
        string memory _cnicNumber,
        string memory _document,
        string memory _email
    ) public {
        //require that Buyer is not already registered
        require(!RegisteredAddressMapping[msg.sender]);

        RegisteredAddressMapping[msg.sender] = true;
        RegisteredBuyerMapping[msg.sender] = true;
        buyersCount++;
        BuyerMapping[msg.sender] = Buyer(
            msg.sender,
            _name,
            _age,
            _city,
            _ntnNumber,
            _cnicNumber,
            _document,
            _email
        );
        buyers.push(msg.sender);

        emit Registration(msg.sender);
    }

    function updateBuyer(
        string memory _name,
        uint256 _age,
        string memory _city,
        string memory _ntnNumber,
        string memory _email,
        string memory _cnicNumber
    ) public {
        //require that Buyer is already registered
        require(
            RegisteredAddressMapping[msg.sender] &&
                (BuyerMapping[msg.sender].id == msg.sender)
        );

        BuyerMapping[msg.sender].name = _name;
        BuyerMapping[msg.sender].age = _age;
        BuyerMapping[msg.sender].city = _city;
        BuyerMapping[msg.sender].ntnNumber = _ntnNumber;
        BuyerMapping[msg.sender].email = _email;
        BuyerMapping[msg.sender].cnicNumber = _cnicNumber;
    }

    function getBuyer() public view returns (address[] memory) {
        return (buyers);
    }

    function getBuyerDetails(address i)
        public
        view
        returns (
            string memory,
            string memory,
            string memory,
            string memory,
            string memory,
            uint256,
            string memory
        )
    {
        return (
            BuyerMapping[i].name,
            BuyerMapping[i].city,
            BuyerMapping[i].cnicNumber,
            BuyerMapping[i].document,
            BuyerMapping[i].email,
            BuyerMapping[i].age,
            BuyerMapping[i].ntnNumber
        );
    }

    function requestLand(address _sellerId, uint256 _landId) public {
        require(isBuyer(msg.sender) && isVerified(msg.sender));

        requestsCount++;
        RequestsMapping[requestsCount] = LandRequest(
            requestsCount,
            _sellerId,
            msg.sender,
            _landId
        );
        RequestStatus[requestsCount] = false;
        RequestedLands[requestsCount] = true;

        emit Landrequested(_sellerId);
    }

    function getRequestDetails(uint256 i)
        public
        view
        returns (
            address,
            address,
            uint256,
            bool
        )
    {
        return (
            RequestsMapping[i].sellerId,
            RequestsMapping[i].buyerId,
            RequestsMapping[i].landId,
            RequestStatus[i]
        );
    }

    function isRequested(uint256 _id) public view returns (bool) {
        if (RequestedLands[_id]) {
            return true;
        }
    }

    function isApproved(uint256 _id) public view returns (bool) {
        if (RequestStatus[_id]) {
            return true;
        }
    }

    function approveRequest(uint256 _reqId) public {
        require((isSeller(msg.sender)) && (isVerified(msg.sender)));

        RequestStatus[_reqId] = true;
    }

    function LandOwnershipTransfer(uint256 _landId, address _newOwner) public {
        require(isLandInspector(msg.sender));

        LandOwner[_landId] = _newOwner;
    }

    function isPaid(uint256 _landId) public view returns (bool) {
        if (PaymentReceived[_landId]) {
            return true;
        }
    }

    function payment(address payable _receiver, uint256 _landId)
        public
        payable
    {
        PaymentReceived[_landId] = true;
        _receiver.transfer(msg.value);
    }
}
