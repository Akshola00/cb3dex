import React, { useState } from "react";
import { FaRotate } from "react-icons/fa6";
import AddTokenButton from "../../components/lib/AddToken";
import BuyContent from "./buy";
import SwapContent from "./swap";

type TabType = "swap" | "buy";

interface TabButtonProps {
  tab: TabType;
  label: string;
  isActive: boolean;
  onClick: (tab: TabType) => void;
}

const TabButton: React.FC<TabButtonProps> = ({
  tab,
  isActive,
  onClick,
  label,
}) => (
  <button
    onClick={() => onClick(tab)}
    className={`rounded-lg px-6 py-2 text-sm font-medium transition-colors focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50 ${
      isActive
        ? "border border-[#EC796B33]/100 bg-[#EC796B33]/10 text-[#EC796B33]/100"
        : "bg-gray-800 text-gray-400 hover:bg-gray-700"
    }`}
  >
    {label}
  </button>
);

const TabButtonInterface: React.FC = () => {
  const [activeTab, setIsActiveTab] = useState<TabType>("swap");

  const handleTabChange = (tab: TabType) => {
    setIsActiveTab(tab);
  };

  return (
    <div className="pt-15 relative p-5">
      <div className="mb-10 flex justify-center space-x-4">
        <TabButton
          tab="swap"
          label="Swap"
          isActive={activeTab === "swap"}
          onClick={handleTabChange}
        />
        <TabButton
          tab="buy"
          label="Buy"
          isActive={activeTab === "buy"}
          onClick={handleTabChange}
        />
      </div>

      {activeTab === "swap" ? <SwapContent /> : <BuyContent />}
    </div>
  );
};

export default TabButtonInterface;
