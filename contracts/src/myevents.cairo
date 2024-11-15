use starknet::ContractAddress;

#[event]
#[derive(Drop, starknet::Event)]
pub enum Event {
    SwapSuccessful: SwapSuccessful,
    SwapFailed: SwapFailed,
    PoolUpdated: PoolUpdated,
}

#[derive(Drop, starknet::Event)]
pub struct SwapSuccessful {
    #[key]
    pub caller: ContractAddress,
    #[key]
    pub token_in: ContractAddress,
    #[key]
    pub token_out: ContractAddress,
    pub amount_in: u256,
    pub amount_out: u256,
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
pub struct PoolUpdated {
    #[key]
    pub token_in: ContractAddress,
    #[key]
    pub token_out: ContractAddress,
    new_balance_token_in: u256,
    new_balance_token_out: u256,
}
