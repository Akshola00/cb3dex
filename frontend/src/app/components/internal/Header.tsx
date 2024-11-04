"use client";
import { useEffect, useRef } from "react";
import { useAccount } from "@starknet-react/core";
import AddressBar from "../lib/AddressBar";
import ConnectButton from "../lib/Connect";
import useTheme from "@/app/components/internal/hooks/useTheme";
import MenuButton from "./MenuButton";
import { CiSearch } from "react-icons/ci";

const Header = () => {
  const { address } = useAccount();
  const { theme, changeTheme } = useTheme();
  const lastYRef = useRef(0);

  useEffect(() => {
    const nav = document.getElementById("nav");
    const handleScroll = () => {
      const difference = window.scrollY - lastYRef.current;
      if (Math.abs(difference) > 50) {
        if (difference > 0) {
          nav?.setAttribute("data-header", "scroll-hide");
        } else {
          nav?.setAttribute("data-header", "scroll-show");
        }
        lastYRef.current = window.scrollY;
      }
    };
    window.addEventListener("scroll", handleScroll);

    return () => {
      window.removeEventListener("scroll", handleScroll);
    };
  }, []);

  return (
    <div
      onFocusCapture={(e) =>
        e.currentTarget.setAttribute("data-header", "scroll-show")
      }
      id="nav"
      className="fixed z-[9999] w-full px-2 pt-4 transition-all duration-500 md:px-8 md:pt-8"
    >
      <header className="rounded-[12px] md:rounded-[32px">
        <div className="">
        <div className="mx-auto flex h-16 max-w-[--header-max-w] items-center justify-between px-4 md:h-28 md:px-8">
        
            <div className="text-white text-xl">
              cb3dex
            </div>
    
         <div className="relative md:block hidden">
            <CiSearch className="absolute text-white top-2 left-1 text-[1.7rem]"/>
            <input type="text"  className=" text-white text-[1.4rem] outline-none border pl-8 py-2 rounded-lg bg-inherit" placeholder="search for tokens" />
          </div>
         <div className="relative">
            {address ? (
              <div className="flex items-center gap-4">
                <AddressBar />
                <MenuButton />
              </div>
            ) : (
              <ConnectButton className="border bg-[#EC796B33]/10 border-[#EC796B33]/100 text-[#EC796B33]/100 px-6 py-2 rounded-xl" />
            )}
          </div>
            
     
        </div>
        <div className="relative md:hidden w-full">
            <CiSearch className="absolute text-white top-2 left-1 text-[1.7rem]"/>
            <input type="text"  className=" w-4/5 mx-auto text-white text-[1.4rem] outline-none border pl-8 py-2 rounded-lg bg-inherit" placeholder="search for tokens" />
          </div>
        </div>
        
      </header>
    </div>
  );
};

export default Header;
