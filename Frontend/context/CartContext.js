"use client"
import { createContext, useContext, useState } from "react";

// Create the cart context
const CartContext = createContext();

// Custom hook to access cart context
export const useCart = () => useContext(CartContext);

// Context provider
export const CartProvider = ({ children }) => {
  const [cartItems, setCartItems] = useState([]);

  // Add an item to the cart
  const addToCart = (product) => {
    setCartItems((prevCart) => {
      // Check if the item already exists in the cart
      const existingItem = prevCart.find((item) => item.id === product.id);
      if (existingItem) {
        // Increase the quantity
        return prevCart.map((item) =>
          item.id === product.id
            ? { ...item, quantity: item.quantity + 1 }
            : item
        );
      } else {
        // Add new item to the cart
        return [...prevCart, { ...product, quantity: 1 }];
      }
    });
  };

  // Remove an item from the cart
  const removeFromCart = (productId) => {
    setCartItems((prevCart) =>
      prevCart.filter((item) => item.id !== productId)
    );
  };

  // Clear the cart
  const clearCart = () => setCartItems([]);

  return (
    <CartContext.Provider
      value={{ cartItems, addToCart, removeFromCart, clearCart }}
    >
      {children}
    </CartContext.Provider>
  );
};