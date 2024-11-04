"use client";
import { useState } from "react";
import { useConnect } from "@starknet-react/core";
import Close from "public/svg/Close";
import GenericModal from "../internal/util/GenericModal";
import Image from "next/image";
import img from "../../twitter-image.png"
import { CiSearch } from "react-icons/ci";
import { FaChevronDown } from "react-icons/fa6";
export const AddTokenModal = () => {
  const { connector } = useConnect();
  const [tokenAddress, setTokenAddress] = useState("");
  const [symbol, setSymbol] = useState("");
  const [decimals, setDecimals] = useState("");
  const [name, setName] = useState("");

  function handleAddToken() {
    const fetchAddToken = async () => {
      try {
        const decimalFloat = parseFloat(decimals);
        //@ts-ignore
        const walletProvider = connector?._wallet;
        const asset = {
          type: "ERC20",
          options: {
            address: tokenAddress,
            symbol,
            decimalFloat,
            name,
          },
        };

        const resp = await walletProvider.request({
          type: "wallet_watchAsset",
          params: asset,
        });
        console.log(resp);
      } catch (err) {
        console.log(err);
      } finally {
        setDecimals("");
        setName("");
        setSymbol("");
        setTokenAddress("");
      }
    };
    fetchAddToken();
  }

  return (
    <GenericModal popoverId="add-token-popover" style={`bg-transparent w-full`}>
      <div className="gird h-svh place-content-center">
        <div className="mx-auto h-fit max-h-[600px] w-[95vw] max-w-[30rem] overflow-scroll rounded-[24px] bg-[--background] px-6 py-8 text-[--headings] shadow-popover-shadow md:p-8">
          <div className="mb-8 flex justify-between">
            <h3 className="text-l text-[--headings]">Add Token</h3>

            <button
              // @ts-ignore
              popovertarget="add-token-popover"
            >
              <Close />
            </button>
          </div>

          <form action="" className="flex flex-col items-start gap-4">
           
            <div className="relative w-full">
            <CiSearch className="absolute text-white top-3 left-1 text-[1.7rem]"/>
            <input type="text"  className="w-full border rounded-xl outline-none border-gray-600 bg-inherit text-white px-8 py-4" placeholder="search for tokens" />
          </div>
            <div className="flex justify-start hover:border-white cursor-pointer gap-5 w-full items-center">
              <Image src={img} alt="token" className="rounded-full w-10 h-10 border-2"/>
              <div className="text-left">
                <h4 className="text-lg capitalize">starkNet</h4>
                <span className="text-gray-600 uppercase text-base">strk</span>
              </div>
            </div>
            <div className="flex justify-start hover:border-white cursor-pointer gap-5 w-full items-center">
              <Image src={img} alt="token" className="rounded-full w-10 h-10 border-2"/>
              <div className="text-left">
                <h4 className="text-lg capitalize">starkNet</h4>
                <span className="text-gray-600 uppercase text-base">strk</span>
              </div>
            </div>
            <div className="flex justify-start hover:border-white cursor-pointer gap-5 w-full items-center">
              <Image src={img} alt="token" className="rounded-full w-10 h-10 border-2"/>
              <div className="text-left">
                <h4 className="text-lg capitalize">starkNet</h4>
                <span className="text-gray-600 uppercase text-base">strk</span>
              </div>
            </div>
            <div className="flex justify-start hover:border-white cursor-pointer gap-5 w-full items-center">
              <Image src={img} alt="token" className="rounded-full w-10 h-10 border-2"/>
              <div className="text-left">
                <h4 className="text-lg capitalize">starkNet</h4>
                <span className="text-gray-600 uppercase text-base">strk</span>
              </div>
            </div>
          </form>
        </div>
      </div>
    </GenericModal>
  );
};

const AddTokenButton = ({
  text = "Add Token",
  className = "h-12 w-[50%] max-w-[12rem] rounded-[12px] border-[2px] border-solid border-[--add-token-border] bg-background-primary-light text-accent-secondary transition-all duration-300 hover:rounded-[30px]",
}: {
  text?: string;
  className?: string;
}) => {
  return (
    <>
      <button
        aria-haspopup="dialog"
        // @ts-ignore
        popovertarget="add-token-popover"
        className={className}
      >
        {text} <FaChevronDown/>
      </button>
      <AddTokenModal />
    </>
  );
};

export default AddTokenButton;
