use snforge_std::{declare, ContractClassTrait, DeclareResultTrait};
use contracts::erc20::{
    erc20, IERC20Dispatcher, IERC20SafeDispatcher, IERC20DispatcherTrait, IERC20SafeDispatcherTrait
};
use contracts::src::swap{swap,ISwapDispatcher, ISwapSafeDispatcher, ISwapDispatcherTrait, ISwapSafeDispatcherTrait};

pub mod Utils {
    use starknet::ContractAddress;
    use core::traits::TryInto;

    pub fn zero() -> ContractAddress {
        0x0000000000000000000000000000000000000000.try_into().unwrap()
    }

    pub fn owner -> ContractAddress {
        'owner'.try_into().unwrap()
    }

    pub fn account1() -> ContractAddress {
        'account1'.try_into().unwrap()
    }

}

fn deploy_util(contract_name: ByteArray, constructor_calldata: Array<felt252>) -> ContractAddress {
    let contract = declare(contract_name).unwrap().contract_class();
    let (contract_address, _) = contract.deploy(@constructor_calldata).unwrap();
    contract_address
}

#[test]
fn all_contracts_deployed_successfully_and_thier_defaults () {
    // deploying swap contract
    let mut swap_calldata: Array<felt252> = array![];
    let deployed_swap_contract_address: ContractAddress = deploy_util("swap", swap_calldata);

    // deploying mtntoken
    let mut swap_calldata: Array<felt252> = array![];
    let deployed_swap_contract_address: ContractAddress = deploy_util("swap", swap_calldata);

    // getting an instance onf the contract
    let swap_instance = ISwapDispatcher {contract_address: deployed_swap_contract_address };

    // using the instance
    swap_instance.get_mtnTokenBalance()




}