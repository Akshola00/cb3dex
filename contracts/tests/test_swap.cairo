use snforge_std::{
    declare, ContractClassTrait, DeclareResultTrait, start_cheat_caller_address,
    stop_cheat_caller_address
};
use contracts::erc20::{
    erc20, IERC20Dispatcher, IERC20SafeDispatcher, IERC20DispatcherTrait, IERC20SafeDispatcherTrait
};
use contracts::swap::{
    swap, ISwapDispatcher, ISwapSafeDispatcher, ISwapDispatcherTrait, ISwapSafeDispatcherTrait
};

use starknet::ContractAddress;
pub mod Utils {
    use starknet::ContractAddress;
    use core::traits::TryInto;

    pub fn zero() -> ContractAddress {
        0x0000000000000000000000000000000000000000.try_into().unwrap()
    }

    pub fn owner() -> ContractAddress {
        'owner'.try_into().unwrap()
    }

    pub fn account1() -> ContractAddress {
        'account1'.try_into().unwrap()
    }
}

// Deploys the given contract and returns the corresponding contract address
fn deploy_util(contract_name: ByteArray, constructor_calldata: Array<felt252>) -> ContractAddress {
    let contract = declare(contract_name).unwrap().contract_class();
    let (contract_address, _) = contract.deploy(@constructor_calldata).unwrap();
    contract_address
}

#[test]
fn all_contracts_deployed_successfully_and_thier_defaults() {
    let owner: ContractAddress = Utils::owner().into();

    // deploying arttoken
    let mut art_calldata: Array<felt252> = array![];
    owner.serialize(ref art_calldata);
    'artToken'.serialize(ref art_calldata);
    18.serialize(ref art_calldata);
    2000.serialize(ref art_calldata);
    'ART'.serialize(ref art_calldata);
    let deployed_art_contract_address: ContractAddress = deploy_util("erc20", art_calldata);

    // deploying mtntoken
    let mut mtn_calldata: Array<felt252> = array![];
    owner.serialize(ref mtn_calldata);
    'mtnToken'.serialize(ref mtn_calldata);
    18.serialize(ref mtn_calldata);
    2000.serialize(ref mtn_calldata);
    'MTN'.serialize(ref mtn_calldata);
    let deployed_mtn_contract_address: ContractAddress = deploy_util("erc20", mtn_calldata);

    // deploying swap contract
    let mut swap_calldata: Array<felt252> = array![];
    deployed_mtn_contract_address.serialize(ref swap_calldata);
    deployed_art_contract_address.serialize(ref swap_calldata);
    owner.serialize(ref swap_calldata);
    let deployed_swap_contract_address: ContractAddress = deploy_util("swap", swap_calldata);

    // getting an instance of the swap contract
    let swapContract_instance = ISwapDispatcher {
        contract_address: deployed_swap_contract_address
    };

    // getting an instance of the mtntoken contract
    let mtnToken_instance = IERC20Dispatcher { contract_address: deployed_mtn_contract_address };

    // getting an instance of the arttoken contract
    let artToken_instance = IERC20Dispatcher { contract_address: deployed_art_contract_address };

    // getting an instance of the arttoken contract
    let artToken_instance = IERC20Dispatcher { contract_address: deployed_art_contract_address };

    // sending 2k art tokens to our swap contract
    start_cheat_caller_address(deployed_art_contract_address, owner.try_into().unwrap());
    artToken_instance.transfer(deployed_swap_contract_address, 2000);
    stop_cheat_caller_address(deployed_art_contract_address);

    // sending 2k mtn tokens to our swap contract
    start_cheat_caller_address(deployed_mtn_contract_address, owner.try_into().unwrap());
    mtnToken_instance.transfer(deployed_swap_contract_address, 2000);
    stop_cheat_caller_address(deployed_mtn_contract_address);

    // using the instance of the swap contract
    let get_mtnTokenBalance = swapContract_instance
        .get_mtnTokenBalance(deployed_mtn_contract_address);
    let get_artTokenBalance = swapContract_instance
        .get_artTokenBalance(deployed_art_contract_address);

    assert!(get_mtnTokenBalance == 2000, "not equal o");
    assert!(get_artTokenBalance == 2000, "not equal o");
}

#[test]
fn swap_successfully() {
    let owner: ContractAddress = Utils::owner().into();
    let account1: ContractAddress = Utils::account1().into();

    // deploying arttoken
    let mut art_calldata: Array<felt252> = array![];
    owner.serialize(ref art_calldata);
    'artToken'.serialize(ref art_calldata);
    18.serialize(ref art_calldata);
    2000.serialize(ref art_calldata);
    'ART'.serialize(ref art_calldata);
    let deployed_art_contract_address: ContractAddress = deploy_util("erc20", art_calldata);

    // deploying mtntoken
    let mut mtn_calldata: Array<felt252> = array![];
    owner.serialize(ref mtn_calldata);
    'mtnToken'.serialize(ref mtn_calldata);
    18.serialize(ref mtn_calldata);
    2100.serialize(ref mtn_calldata);
    'MTN'.serialize(ref mtn_calldata);
    let deployed_mtn_contract_address: ContractAddress = deploy_util("erc20", mtn_calldata);

    // deploying swap contract
    let mut swap_calldata: Array<felt252> = array![];
    deployed_mtn_contract_address.serialize(ref swap_calldata);
    deployed_art_contract_address.serialize(ref swap_calldata);
    owner.serialize(ref swap_calldata);
    let deployed_swap_contract_address: ContractAddress = deploy_util("swap", swap_calldata);

    // getting an instance of the swap contract
    let swapContract_instance = ISwapDispatcher {
        contract_address: deployed_swap_contract_address
    };

    // getting an instance of the mtntoken contract
    let mtnToken_instance = IERC20Dispatcher { contract_address: deployed_mtn_contract_address };

    // getting an instance of the arttoken contract
    let artToken_instance = IERC20Dispatcher { contract_address: deployed_art_contract_address };

    // getting an instance of the arttoken contract
    let artToken_instance = IERC20Dispatcher { contract_address: deployed_art_contract_address };

    // sending 2k art tokens to our swap contract
    start_cheat_caller_address(deployed_art_contract_address, owner.try_into().unwrap());
    artToken_instance.transfer(deployed_swap_contract_address, 2000);
    stop_cheat_caller_address(deployed_art_contract_address);

    // sending 2k mtn tokens to our swap contract
    start_cheat_caller_address(deployed_mtn_contract_address, owner.try_into().unwrap());
    mtnToken_instance.transfer(deployed_swap_contract_address, 2000);
    stop_cheat_caller_address(deployed_mtn_contract_address);

    // sending 100 mtn tokens to account 1 for test purposes, since he wants to swap
    start_cheat_caller_address(deployed_mtn_contract_address, owner.try_into().unwrap());
    mtnToken_instance.transfer(account1, 100);
    stop_cheat_caller_address(deployed_mtn_contract_address);

    // approve the dex contract for the tokens you want to swap
    start_cheat_caller_address(deployed_mtn_contract_address, account1.try_into().unwrap());
    mtnToken_instance.increase_allowance(deployed_swap_contract_address, 100);
    stop_cheat_caller_address(deployed_mtn_contract_address);
  

    // using the instance of the swap contract
    let get_mtnTokenBalance = swapContract_instance
        .get_mtnTokenBalance(deployed_mtn_contract_address);
    let get_artTokenBalance = swapContract_instance
        .get_artTokenBalance(deployed_art_contract_address);

    assert!(get_mtnTokenBalance == 2000, "not equal o");
    assert!(get_artTokenBalance == 2000, "not equal o");

    // calling the swap function
    // using account1: a user address to call this function
    start_cheat_caller_address(deployed_swap_contract_address, account1.try_into().unwrap());
    // calling the swap function with the users address (the user would like to swap 2mtn toknes to
    // art tokens)
    swapContract_instance.swap(deployed_mtn_contract_address, deployed_art_contract_address, 10);
    stop_cheat_caller_address(deployed_swap_contract_address);
}
