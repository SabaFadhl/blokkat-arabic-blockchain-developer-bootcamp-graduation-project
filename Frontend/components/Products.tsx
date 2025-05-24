"use client"
import { useState } from "react";

export default function Products() {
  // Initialize products data
  const [products] = useState([
    {
      id: 1,
      name: "Premium Wireless Headphones",
      image: "/img/headphones.jpg",
      cryptoPrice: 0.15,
      fiatPrice: 249.99,
    },
    {
      id: 2,
      name: "Smart Watch Pro",
      image: "/img/smartwatch.jpg",
      cryptoPrice: 0.12,
      fiatPrice: 199.99,
    },
    {
      id: 3,
      name: "Drone X Pro",
      image: "/img/drone.jpg",
      cryptoPrice: 0.3,
      fiatPrice: 499.99,
    },
    {
      id: 4,
      name: "VR Headset Elite",
      image: "/img/vr-headset.jpg",
      cryptoPrice: 0.18,
      fiatPrice: 299.99,
    },
    {
      id: 5,
      name: "Mechanical Keyboard",
      image: "/img/keyboard.jpg",
      cryptoPrice: 0.06,
      fiatPrice: 99.99,
    },
    {
      id: 6,
      name: "Portable SSD 1TB",
      image: "/img/ssd.jpg",
      cryptoPrice: 0.09,
      fiatPrice: 149.99,
    },
  ]);

  return (
    <div className="flex flex-col md:flex-row gap-8">
      {/* Products Grid */}
      <div className="flex-1">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {/* Loop through products */}
          {products.map((product) => (
            <div
              key={product.id}
              className="bg-white rounded-lg overflow-hidden shadow-sm hover:shadow-md transition-shadow duration-300"
            >
              {/* Product Image */}
              <div className="h-64 overflow-hidden">
                <img
                  src={product.image}
                  alt={product.name}
                  className="product w-full h-full object-cover object-top transition-transform duration-300 hover:scale-105"
                />
              </div>

              {/* Product Details */}
              <div className="p-4">
                <h3 className="text-lg font-medium text-gray-800 mb-2">
                  {product.name}
                </h3>
                <div className="flex flex-col mb-4">
                  <div className="flex items-center">
                    <i className="fab fa-ethereum text-indigo-600 mr-1"></i>
                    <span className="font-semibold text-indigo-600">
                      {product.cryptoPrice} ETH
                    </span>
                  </div>
                  <span className="text-sm text-gray-500">
                    ${product.fiatPrice}
                  </span>
                </div>
                <button className="w-full py-2 bg-indigo-600 text-white rounded-lg cursor-pointer hover:bg-indigo-700 transition-colors">
                  Add to Cart
                </button>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}