import Header from "./components/internal/Header";
import Exchange from "./components/internal/Exchange";
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
        <Exchange/>
      </section>

      
    </main>
  );
}
