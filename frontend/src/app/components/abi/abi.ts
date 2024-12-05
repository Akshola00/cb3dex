export const abi = [
  // abi : [
    {
      "name": "swapImpl",
      "type": "impl",
      "interface_name": "contracts::swap::ISwap"
    },
    {
      "name": "core::integer::u256",
      "type": "struct",
      "members": [
        {
          "name": "low",
          "type": "core::integer::u128"
        },
        {
          "name": "high",
          "type": "core::integer::u128"
        }
      ]
    },
    {
      "name": "core::bool",
      "type": "enum",
      "variants": [
        {
          "name": "False",
          "type": "()"
        },
        {
          "name": "True",
          "type": "()"
        }
      ]
    },
    {
      "name": "contracts::swap::ISwap",
      "type": "interface",
      "items": [
        {
          "name": "swap",
          "type": "function",
          "inputs": [
            {
              "name": "first_token",
              "type": "core::starknet::contract_address::ContractAddress"
            },
            {
              "name": "second_token",
              "type": "core::starknet::contract_address::ContractAddress"
            },
            {
              "name": "amount",
              "type": "core::integer::u256"
            }
          ],
          "outputs": [
            {
              "type": "core::bool"
            }
          ],
          "state_mutability": "external"
        },
        {
          "name": "get_mtnTokenBalance",
          "type": "function",
          "inputs": [
            {
              "name": "mtnToken",
              "type": "core::starknet::contract_address::ContractAddress"
            }
          ],
          "outputs": [
            {
              "type": "core::integer::u256"
            }
          ],
          "state_mutability": "view"
        },
        {
          "name": "get_AmountResultToken",
          "type": "function",
          "inputs": [
            {
              "name": "amount",
              "type": "core::integer::u256"
            },
            {
              "name": "first_token",
              "type": "core::starknet::contract_address::ContractAddress"
            },
            {
              "name": "second_token",
              "type": "core::starknet::contract_address::ContractAddress"
            }
          ],
          "outputs": [
            {
              "type": "core::integer::u256"
            }
          ],
          "state_mutability": "view"
        },
        {
          "name": "get_artTokenBalance",
          "type": "function",
          "inputs": [
            {
              "name": "artToken",
              "type": "core::starknet::contract_address::ContractAddress"
            }
          ],
          "outputs": [
            {
              "type": "core::integer::u256"
            }
          ],
          "state_mutability": "view"
        }
      ]
    },
    {
      "name": "constructor",
      "type": "constructor",
      "inputs": [
        {
          "name": "mtnToken",
          "type": "core::starknet::contract_address::ContractAddress"
        },
        {
          "name": "artToken",
          "type": "core::starknet::contract_address::ContractAddress"
        },
        {
          "name": "owner",
          "type": "core::starknet::contract_address::ContractAddress"
        }
      ]
    },
    {
      "kind": "struct",
      "name": "contracts::swap::swap::SwapSuccessful",
      "type": "event",
      "members": [
        {
          "kind": "key",
          "name": "caller",
          "type": "core::starknet::contract_address::ContractAddress"
        },
        {
          "kind": "key",
          "name": "token_in",
          "type": "core::starknet::contract_address::ContractAddress"
        },
        {
          "kind": "key",
          "name": "token_out",
          "type": "core::starknet::contract_address::ContractAddress"
        },
        {
          "kind": "data",
          "name": "amount_in",
          "type": "core::integer::u256"
        },
        {
          "kind": "data",
          "name": "amount_out",
          "type": "core::integer::u256"
        }
      ]
    },
    {
      "kind": "struct",
      "name": "contracts::swap::swap::SwapFailed",
      "type": "event",
      "members": [
        {
          "kind": "data",
          "name": "caller",
          "type": "core::starknet::contract_address::ContractAddress"
        },
        {
          "kind": "data",
          "name": "token_in",
          "type": "core::starknet::contract_address::ContractAddress"
        },
        {
          "kind": "data",
          "name": "token_out",
          "type": "core::starknet::contract_address::ContractAddress"
        },
        {
          "kind": "data",
          "name": "amount",
          "type": "core::integer::u256"
        },
        {
          "kind": "data",
          "name": "reason",
          "type": "core::felt252"
        }
      ]
    },
    {
      "kind": "struct",
      "name": "contracts::swap::swap::PoolUpdated",
      "type": "event",
      "members": [
        {
          "kind": "key",
          "name": "token_in",
          "type": "core::starknet::contract_address::ContractAddress"
        },
        {
          "kind": "key",
          "name": "token_out",
          "type": "core::starknet::contract_address::ContractAddress"
        },
        {
          "kind": "data",
          "name": "new_balance_token_in",
          "type": "core::integer::u256"
        },
        {
          "kind": "data",
          "name": "new_balance_token_out",
          "type": "core::integer::u256"
        }
      ]
    },
    {
      "kind": "enum",
      "name": "contracts::swap::swap::Event",
      "type": "event",
      "variants": [
        {
          "kind": "nested",
          "name": "SwapSuccessful",
          "type": "contracts::swap::swap::SwapSuccessful"
        },
        {
          "kind": "nested",
          "name": "SwapFailed",
          "type": "contracts::swap::swap::SwapFailed"
        },
        {
          "kind": "nested",
          "name": "PoolUpdated",
          "type": "contracts::swap::swap::PoolUpdated"
        }
      ]
    }
  ] as const;