import Header from "./components/internal/Header";
import { FaRotate } from "react-icons/fa6";
import AddTokenButton, { AddTokenModal } from "./components/lib/AddToken";
export default function Home() {
  return (
    <main className="flex min-h-svh flex-col justify-between bg-main-bg">
      <Header />
      {/* HERO --> */}
      <section className="pt-[8rem] md:pt-[clamp(200px,25vh,650px)]">
        <div className="mx-auto flex max-w-[600px] flex-col p-4 text-center md:max-w-[850px] md:py-8">
          <h1 className="text-2xl text-[--headings] md:text-3xl">
          Swap token anytime, 
          at your convenience.
          </h1>
        </div>
      </section>

      {/* <-- END */}

      <section className="w-11/12 sm:w-4/5 lg:w-1/2 mx-auto mb-7">
      <div className="w-full relative grid gap-4">
     <div className="absolute top-1/2 bottom-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 border rounded-full h-16 bg-[#151536] w-16 grid place-content-center text-white text-4xl">
     <FaRotate/>
     </div>
     <div className="border border-gray-600 shadow-2xl h-44 flex flex-col p-7 rounded-2xl justify-between text-white">
      
        <div className="flex justify-between text-4xl capitalize">
          <h2>sell</h2>
          <h2>$0</h2>
        </div>
        <div className="flex justify-between">
        <input type="number" defaultValue="0" id="sell"  className=" md:w-fit text-4xl w-20 sm:w-36 bg-inherit px-2 py-1" />
          <AddTokenButton className="border rounded-3xl px-6 flex items-center gap-3"  text={"select a token"}/>
        </div>
      </div>
      <div className="border border-gray-600 shadow-2xl h-44 flex flex-col p-7 rounded-2xl justify-between text-white">
        <div className="flex justify-between text-4xl capitalize">
          <h2>buy</h2>
        </div>
        <div className="flex justify-between ">
        <input type="number" defaultValue="0" id="buy"  className=" md:w-fit text-4xl w-20 sm:w-36 bg-inherit p-2 py-1" />
          <AddTokenButton className="border rounded-3xl px-6 flex items-center gap-3"  text={"select a token"}/>
        </div>
      </div>
    
     </div>
     <button className="border bg-[#EC796B33]/10 border-[#EC796B33]/100 text-[#EC796B33]/100 px-6 py-2 rounded-xl w-full capitalize mt-5" > get started</button>
      </section>

      
    </main>
  );
}
