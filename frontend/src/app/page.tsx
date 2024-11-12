"use client";

import Header from "./components/internal/Header";
import { useAccount } from "@starknet-react/core";
import swapImg from "../app/swapImg1.webp";
import Image from "next/image";
import TabButtonInterface from "./components/swap/tabButton";

export default function Home() {
  const { isConnected, isDisconnected } = useAccount();

  return (
    <main className="relative flex min-h-svh flex-col justify-between bg-main-bg">
      <Header />
      {/* HERO --> */}
      <section className="pt-[8rem] md:pt-[clamp(200px,25vh,650px)]">
        <div className="mx-auto flex max-w-[600px] flex-col p-4 text-center md:max-w-[850px] md:py-8">
          <h1 className="text-2xl text-[--headings] md:text-3xl">
            Swap token anytime, at your convenience.
          </h1>
        </div>
        {isDisconnected && (
          <div className="mx-auto flex items-center justify-center">
            {" "}
            <Image className="w-[35rem]" src={swapImg} alt="swap image" />
          </div>
        )}
      </section>

      <div className="w-full">{isConnected && <TabButtonInterface />}</div>
    </main>
  );
}
