import React from "react";
import Image from "next/image";
import ngn from "../../../../public/assets/ngn.png";
import down_arr from "../../../../public/assets/down-arr.svg";

const BuyContent: React.FC = () => {
  return (
    <div className="mx-auto mb-7 min-h-[400px] w-11/12 text-white sm:w-4/5 lg:w-1/2">
      <div className="relative w-full rounded-2xl border border-gray-600 bg-inherit p-5 text-white shadow-2xl">
        <div className="flex items-center justify-between">
          <p>you're buying</p>
          <button className="flex items-center justify-between rounded-2xl bg-slate-500 p-1">
            <Image className="w-6" src={ngn} alt="image of countries" />
            <Image className="w-6" src={down_arr} alt="down arr" />
          </button>
        </div>

        <div className="flex flex-col items-center justify-center pb-5 pt-20 text-center">
          <h1 className="text-3xl">$100</h1>
          <div className="mt-3 flex items-center justify-center space-x-1 p-1">
            <Image className="w-6" src={ngn} alt="image" />
            <span>10000.0000</span>
            <Image className="w-6" src={down_arr} alt="image" />
          </div>

          <div className="flex">
            <span className="mx-3 mt-8 cursor-pointer rounded-2xl bg-slate-500 px-2.5 py-1.5 text-lg font-semibold">
              $100
            </span>
            <span className="mx-3 mt-8 cursor-pointer rounded-2xl bg-slate-500 px-2.5 py-1.5 text-lg font-semibold">
              $300
            </span>
            <span className="mx-3 mt-8 cursor-pointer rounded-2xl bg-slate-500 px-2.5 py-1.5 text-lg font-semibold">
              $1000
            </span>
          </div>
        </div>
      </div>
      <button className="mt-5 w-full rounded-xl border border-[#EC796B33]/100 bg-[#EC796B33]/10 px-6 py-2 capitalize text-[#EC796B33]/100">
        Buy
      </button>
    </div>
  );
};

export default BuyContent;
