
import Navbar from "../components/Navbar"
import Hero from "../components/Hero"


export default function Home() {
  return (
    <div>
      <Navbar />
      <main className="container mx-auto pt-24 px-4 pb-16">
      <Hero/>
      </main>
    </div>
  )
}
