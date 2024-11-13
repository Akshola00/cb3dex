use contracts::erc20::{
    erc20, IERC20Dispatcher, IERC20SafeDispatcher, IERC20DispatcherTrait, IERC20SafeDispatcherTrait
};
use starknet::ContractAddress;
use core::zeroable::Zeroable;

#[starknet::interface]
trait ISwap<T> {
    fn swap(
        ref self: T, first_token: ContractAddress, second_token: ContractAddress, amount: u256
    ) -> bool;
    fn get_mtnTokenBalance(self: @T, mtnToken: ContractAddress) -> u256;
    fn get_artTokenBalance(self: @T, artToken: ContractAddress) -> u256;
}

#[starknet::contract]
pub mod swap {
    use contracts::erc20::{
        erc20, IERC20Dispatcher, IERC20SafeDispatcher, IERC20DispatcherTrait,
        IERC20SafeDispatcherTrait
    };
    use starknet::ContractAddress;
    use starknet::storage::{
        StoragePointerReadAccess, StoragePointerWriteAccess, StoragePathEntry, Map, StorageMapReadAccess, StorageMapWriteAccess
    };
    

    use starknet::{get_caller_address, get_contract_address};

    #[storage]
    struct Storage {
        poolBalance: Map<ContractAddress, u256>,
        mtnToken: ContractAddress,
        artToken: ContractAddress,
        owner: ContractAddress,
    }

    #[derive(Drop, starknet::Event)]
    struct SwapSuccessful {
        caller: ContractAddress,
        token_in: ContractAddress,
        token_out: ContractAddress,
        amount_in: u256,
        amount_out: u256,
        timestamp: u256,
    }

    #[derive(Drop, starknet::Event)]
    struct SwapFailed {
        caller: ContractAddress,
        token_in: ContractAddress,
        token_out: ContractAddress,
        amount: u256,
        reason: felt252,
    }

    #[derive(Drop, starknet::Event)]
    struct PoolUpdated {
        token: ContractAddress,
        new_balance: u256,
    }

    #[constructor]
    fn constructor(ref self: ContractState, mtnToken: ContractAddress, artToken: ContractAddress, owner: ContractAddress) {
        self.poolBalance.entry(mtnToken).write(2000);
        self.poolBalance.entry(artToken).write(2000);
        self.owner.write(owner);
    }

    const TOKEN_TOTAL_RESERVE_LIMIT: u256 = 2000;

    mod Errors {
        const INVALID_TOKEN: felt252 = 'Invalid token address';
        const INSUFFICIENT_BALANCE: felt252 = 'Insufficient balance';
        const INSUFFICIENT_TOKEN: felt252 = 'Insufficient token';
        const EXCEEDS_RESERVE_LIMIT: felt252 = 'Exceeds reserve limit';
        const ZERO_ADDRESS: felt252 = 'Zero address not allowed';
        const ZERO_AMOUNT: felt252 = 'Amount cannot be zero';
        const SAME_TOKEN: felt252 = 'Cannot swap same token';
        const TRANSFER_FAILED: felt252 = 'Token transfer failed';
        const UNAUTHORIZED: felt252 = 'Unauthorized';
    }

    #[abi(embed_v0)]
    impl swapImpl of super::ISwap<ContractState> {
        fn swap(
            ref self: ContractState,
            first_token: ContractAddress,
            second_token: ContractAddress,
            amount: u256
        ) -> bool {
            let caller = get_caller_address();
            let my_contract_address = get_contract_address();

            let second_token_instance = IERC20Dispatcher { contract_address: second_token };
            let first_token_instance = IERC20Dispatcher { contract_address: first_token };

            //Validation
            assert(!self.is_zero_address(first_token), Errors::ZERO_ADDRESS);
            assert(!self.is_zero_address(second_token), Errors::ZERO_ADDRESS);
            assert(first_token != second_token, Errors::SAME_TOKEN);
            assert(amount > 0, Errors::ZERO_AMOUNT);
            assert(amount < TOKEN_TOTAL_RESERVE_LIMIT, Errors::EXCEEDS_RESERVE_LIMIT);


            let firsttokenpoolbal = self.poolBalance.entry(first_token).read();
            let secondtokenpoolbal = self.poolBalance.entry(second_token).read();

            let result_token = (secondtokenpoolbal * amount) / (firsttokenpoolbal + amount);

            // Check DEX Contract Token Balance for Swap Execution
            let contract_second_token_balance = second_token_instance.balance_of(my_contract_address);
            assert(contract_second_token_balance.try_into().unwrap() > result_token, Errors::INSUFFICIENT_TOKEN);


            first_token_instance
                .transfer_from(caller, my_contract_address, amount.try_into().unwrap());
            second_token_instance.transfer(caller, result_token.try_into().unwrap());

            true
        }

        fn get_mtnTokenBalance(self: @ContractState, mtnToken: ContractAddress) -> u256 {
            self.poolBalance.entry(mtnToken).read()
        }

        fn get_artTokenBalance(self: @ContractState, artToken: ContractAddress) -> u256 {
            self.poolBalance.entry(artToken).read()
        }
    }

    #[generate_trait]
    impl Private of PrivateTrait {
        fn only_owner(self: @ContractState) {
            let caller = get_caller_address();
            let owner = self.owner.read();
            assert(caller == owner, Errors::UNAUTHORIZED);
        }

        fn is_zero_address(self: @ContractState, account: ContractAddress) -> bool {
            account.is_zero()
        }
    }
}
