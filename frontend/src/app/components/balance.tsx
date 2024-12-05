import React from "react";

import { useAccount, useContractRead, useNetwork } from "@starknet-react/core";

import { swapAddress } from "./contract-address/contract-address";
import { abi } from "./abi/abi";

const Balance = () => {
  const { address: user } = useAccount();
  const { data, error } = useContractRead({
    abi: [
      {
        name: "StudentRegistryImpl",
        type: "impl",
        interface_name: "cairo_bootcamp_3::student_registry::IStudentRegistry",
      },
      {
        name: "core::bool",
        type: "enum",
        variants: [
          {
            name: "False",
            type: "()",
          },
          {
            name: "True",
            type: "()",
          },
        ],
      },
      {
        name: "cairo_bootcamp_3::student_struct::Student",
        type: "struct",
        members: [
          {
            name: "fname",
            type: "core::felt252",
          },
          {
            name: "lname",
            type: "core::felt252",
          },
          {
            name: "phone_number",
            type: "core::felt252",
          },
          {
            name: "age",
            type: "core::integer::u8",
          },
          {
            name: "is_active",
            type: "core::bool",
          },
        ],
      },
      {
        name: "core::array::Span::<cairo_bootcamp_3::student_struct::Student>",
        type: "struct",
        members: [
          {
            name: "snapshot",
            type: "@core::array::Array::<cairo_bootcamp_3::student_struct::Student>",
          },
        ],
      },
      {
        name: "cairo_bootcamp_3::student_registry::IStudentRegistry",
        type: "interface",
        items: [
          {
            name: "add_student",
            type: "function",
            inputs: [
              {
                name: "_fname",
                type: "core::felt252",
              },
              {
                name: "_lname",
                type: "core::felt252",
              },
              {
                name: "_phone_number",
                type: "core::felt252",
              },
              {
                name: "_age",
                type: "core::integer::u8",
              },
              {
                name: "_is_active",
                type: "core::bool",
              },
            ],
            outputs: [
              {
                type: "core::bool",
              },
            ],
            state_mutability: "external",
          },
          {
            name: "get_student",
            type: "function",
            inputs: [
              {
                name: "index",
                type: "core::integer::u64",
              },
            ],
            outputs: [
              {
                type: "(core::felt252, core::felt252, core::felt252, core::integer::u8, core::bool)",
              },
            ],
            state_mutability: "view",
          },
          {
            name: "get_all_students",
            type: "function",
            inputs: [],
            outputs: [
              {
                type: "core::array::Span::<cairo_bootcamp_3::student_struct::Student>",
              },
            ],
            state_mutability: "view",
          },
          {
            name: "update_student",
            type: "function",
            inputs: [
              {
                name: "_index",
                type: "core::integer::u64",
              },
              {
                name: "_fname",
                type: "core::felt252",
              },
              {
                name: "_lname",
                type: "core::felt252",
              },
              {
                name: "_phone_number",
                type: "core::felt252",
              },
              {
                name: "_age",
                type: "core::integer::u8",
              },
            ],
            outputs: [
              {
                type: "core::bool",
              },
            ],
            state_mutability: "external",
          },
          {
            name: "delete_student",
            type: "function",
            inputs: [
              {
                name: "_index",
                type: "core::integer::u64",
              },
            ],
            outputs: [
              {
                type: "core::bool",
              },
            ],
            state_mutability: "external",
          },
        ],
      },
      {
        name: "constructor",
        type: "constructor",
        inputs: [
          {
            name: "_admin",
            type: "core::starknet::contract_address::ContractAddress",
          },
        ],
      },
      {
        kind: "enum",
        name: "cairo_bootcamp_3::student_registry::StudentRegistry::Event",
        type: "event",
        variants: [],
      },
    ] as const,
    functionName: "get_all_students",
    address:
      "0x03efd6a3549a0ea66468ba7f87d177bf2f18cb19ae7bba907f14f5897b9d9ed2",
    args: [],
  });

  const india = () => {
    if (data) {
      console.log(data);
    } else {
      console.log("No data available");
    }
  };

  return (
    <div onClick={india} className="bg-blue-300 p-4">
      india will be great again Lorem ipsum dolor sit amet consectetur
      adipisicing elit. Eos distinctio ab, et expedita nihil porro ea. Eos sunt
      perferendis eum suscipit error officiis. Est incidunt mollitia iusto
      aliquid asperiores dicta.
    </div>
  );
};

export default Balance;
