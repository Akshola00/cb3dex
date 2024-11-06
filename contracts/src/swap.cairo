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
        StoragePointerReadAccess, StoragePointerWriteAccess, StoragePathEntry, Map
    };
    use starknet::get_caller_address;

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

    const TOKEN_TOTAL_RESERVE_LIMIT: u256 = 2000;

    mod Errors {
        const INVALID_TOKEN: felt252 = 'Invalid token address';
        const INSUFFICIENT_BALANCE: felt252 = 'Insufficient balance';
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

            let second_token_instance = IERC20Dispatcher { contract_address: second_token };
            let first_token_instance = IERC20Dispatcher { contract_address: first_token };

            //Validation
            assert(!self.is_zero_address(first_token), Errors::ZERO_ADDRESS);
            assert(!self.is_zero_address(second_token), Errors::ZERO_ADDRESS);
            assert(first_token != second_token, Errors::SAME_TOKEN);
            assert(amount > 0, Errors::ZERO_AMOUNT);
            assert(amount < TOKEN_TOTAL_RESERVE_LIMIT, Errors::EXCEEDS_RESERVE_LIMIT);

            let mtnToken = self.mtnToken.read();
            let artToken = self.artToken.read();
            assert(
                (first_token == mtnToken && second_token == artToken)
                    || (first_token == artToken && second_token == mtnToken),
                Errors::INVALID_TOKEN
            );

            self.poolBalance.entry(mtnToken).write(2000);
            self.poolBalance.entry(artToken).write(2000);

            let mtntokenpoolbal = self.poolBalance.entry(mtnToken).read();
            let arttokenpoolbal = self.poolBalance.entry(artToken).read();

            let result_token = (mtntokenpoolbal * arttokenpoolbal) / (mtntokenpoolbal + amount)
                - arttokenpoolbal;

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
