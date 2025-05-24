
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faSearch } from '@fortawesome/free-solid-svg-icons'

export default function Navbar() {
  return (
    <header className="fixed top-0 left-0 right-0 h-16 bg-white shadow-sm z-50">
      <div
        className="container mx-auto px-4 h-full flex items-center justify-between"
      >
        {/* <!-- Logo --> */}
        <div className="flex items-center">
          <h1 className="text-2xl font-bold text-indigo-600">Blokkat Shop</h1>
        </div>

        {/* <!-- Search --> */}
        <div className="hidden md:block w-2/5">
          <div className="relative">
            <input
              type="text"
              placeholder="Search for products..."
              className="w-full py-2 pl-10 pr-4 text-sm border-none rounded-full bg-gray-100 focus:outline-none focus:ring-2 focus:ring-indigo-500"
            />
            <FontAwesomeIcon
              icon={faSearch}
              className=" absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400"
            />
          </div>
        </div>

        {/* <!-- Navigation --> */}
        <div className="flex items-center space-x-4">
          
            <w3m-button/>
            <w3m-network-button/>
             <div className="relative cursor-pointer">
            <FontAwesomeIcon
              icon="shopping-cart"
              className=" text-gray-700 text-xl text-indigo-600"
            />
            <span
              v-if="cartItems.length > 0"
              className="absolute -top-2 -right-2 text-[10px] h-5 w-5 flex items-center justify-center bg-red-500 text-white text-2xs rounded-full"
            >
              6
              {/* {{ cartItems.length }} */}
            </span>
          </div>

  
        </div>
      </div>
    </header>
  )
}
