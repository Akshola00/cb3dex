use contracts::erc20::{
    erc20, IERC20Dispatcher, IERC20SafeDispatcher, IERC20DispatcherTrait, IERC20SafeDispatcherTrait 
};
use starknet::ContractAddress;


#[starknet::interface] 
trait ISwap<T>{
    fn swap(ref self: T, first_token: ContractAddress, second_token: ContractAddress ) -> bool;
}

#[starknet::contract]
pub mod swap {
    use starknet::ContractAddress;
    #[storage]
    struct Storage {

    }  
    mod Errors {
        pub const APPROVE_FROM_ZERO: felt252 = 'ERC20: approve from 0';
        pub const APPROVE_TO_ZERO: felt252 = 'ERC20: approve to 0';
        pub const TRANSFER_FROM_ZERO: felt252 = 'ERC20: transfer from 0';
        pub const TRANSFER_TO_ZERO: felt252 = 'ERC20: transfer to 0';
        pub const BURN_FROM_ZERO: felt252 = 'ERC20: burn from 0';
        pub const MINT_TO_ZERO: felt252 = 'ERC20: mint to 0';
    }

    #[abi(embed_v0)]
    impl swapImpl of super::ISwap<ContractState> {
        fn swap(ref self: ContractState, first_token: ContractAddress, second_token: ContractAddress ) -> bool {
            true
        }
    }


    #[generate_trait]
    impl InternalImpl of InternalTrait {


    }

}