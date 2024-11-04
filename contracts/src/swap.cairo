use contracts::erc20::{
    erc20, IERC20Dispatcher, IERC20SafeDispatcher, IERC20DispatcherTrait, IERC20SafeDispatcherTrait 
};
use starknet::ContractAddress;


#[starknet::interface] 
trait ISwap<T>{
    fn swap(ref self: T, first_token: ContractAddress, second_token: ContractAddress, amount: u256 ) -> bool;
    fn get_mtnTokenBalance(self: @T, mtnToken: ContractAddress ) -> u256;
    fn get_artTokenBalance(self: @T, artToken: ContractAddress ) -> u256;
}

#[starknet::contract]
pub mod swap {
    use contracts::erc20::{
        erc20, IERC20Dispatcher, IERC20SafeDispatcher, IERC20DispatcherTrait, IERC20SafeDispatcherTrait 
    };
    use starknet::ContractAddress;
    use starknet::storage::{
        StoragePointerReadAccess, StoragePointerWriteAccess, StoragePathEntry, Map
    };

    #[storage]
    struct Storage {
        poolBalance: Map<ContractAddress, u256>, 
        mtnToken: ContractAddress,
        artToken: ContractAddress,
    }  

    const TOKEN_TOTAL_RESERVE_LIMIT: u256 = 2000;
    


    
    mod Errors {
    }

    #[abi(embed_v0)]
    impl swapImpl of super::ISwap<ContractState> {
        fn swap(ref self: ContractState, first_token: ContractAddress, second_token: ContractAddress, amount: u256 ) -> bool {
            let second_token_instance = IERC20Dispatcher {contract_address : second_token };
            

            let mtnToken = self.mtnToken.read();
            let artToken = self.artToken.read();

            self.poolBalance.entry(mtnToken).write(2000);
            self.poolBalance.entry(artToken).write(2000);
            assert(amount < TOKEN_TOTAL_RESERVE_LIMIT, 'Pls try a lesser value');

            true
        }

        fn get_mtnTokenBalance(self: @ContractState, mtnToken: ContractAddress ) -> u256 {
            self.poolBalance.entry(mtnToken).read()
        }

        fn get_artTokenBalance(self: @ContractState, artToken: ContractAddress ) -> u256 {
            self.poolBalance.entry(artToken).read()
        }


    }
}