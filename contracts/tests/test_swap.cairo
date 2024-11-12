use snforge_std::{declare, ContractClassTrait, DeclareResultTrait, start_cheat_caller_address, stop_cheat_caller_address };
use contracts::erc20::{
    erc20, IERC20Dispatcher, IERC20SafeDispatcher, IERC20DispatcherTrait, IERC20SafeDispatcherTrait
};
use contracts::swap::{
    swap, ISwapDispatcher, ISwapSafeDispatcher, ISwapDispatcherTrait, ISwapSafeDispatcherTrait
};

use starknet::ContractAddress;
pub mod Utils{
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
    let deployed_swap_contract_address: ContractAddress = deploy_util("swap", swap_calldata);

    // getting an instance of the swap contract
    let swapContract_instance = ISwapDispatcher {contract_address: deployed_swap_contract_address };

    // getting an instance of the mtntoken contract
    let mtnToken_instance = IERC20Dispatcher {contract_address: deployed_mtn_contract_address };

    // getting an instance of the arttoken contract
    let artToken_instance = IERC20Dispatcher {contract_address: deployed_art_contract_address };

    // getting an instance of the arttoken contract
    let artToken_instance = IERC20Dispatcher {contract_address: deployed_art_contract_address };


    start_cheat_caller_address(deployed_art_contract_address, owner.try_into().unwrap());
    artToken_instance.transfer(deployed_swap_contract_address, 2000);
    stop_cheat_caller_address(deployed_art_contract_address);

    start_cheat_caller_address(deployed_mtn_contract_address, owner.try_into().unwrap());
    mtnToken_instance.transfer(deployed_swap_contract_address, 2000);
    stop_cheat_caller_address(deployed_mtn_contract_address);

    // using the instance of the swap contract
    let get_mtnTokenBalance = swapContract_instance.get_mtnTokenBalance(deployed_mtn_contract_address);
    let get_artTokenBalance = swapContract_instance.get_artTokenBalance(deployed_art_contract_address);

    assert!(get_mtnTokenBalance == 2000, "not equal o");
    assert!(get_artTokenBalance == 2000, "not equal o");

}
