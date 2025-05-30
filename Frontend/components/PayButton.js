import { useReadContract, useAccount, useBalance } from "wagmi";
import { CONTRACT_ABI, CONTRACT_ADDRESS } from "@/lib/constants";

export default function PayButton({ cartItems }) {
  // Calculate the total USD amount
  const totalUsdAmount = cartItems.reduce(
    (sum, item) => sum + item.fiatPrice * item.quantity,
    0
  );

  // Use `BigInt` instead of ethers.BigNumber
  const { data, isError, isLoading, refetch } = useReadContract({
    address: CONTRACT_ADDRESS,
    abi: CONTRACT_ABI,
    functionName: "convertUsdToEth",
    args: [BigInt(Math.floor(totalUsdAmount))], // 👈 no ethers here
    watch: false,
  });
const { address } = useAccount(); // Get the connected wallet address

// Get account balance (in wei)
  const { data: balanceData } = useBalance({
    address,
    watch: true,
  });
const handlePayClick = async () => {
  try {
   
    const result = await refetch();

      const paymentAmountEth = Number(result.data) / 1e18;
      const balanceEth = balanceData ? Number(balanceData.value) / 1e18 : 0;
    console.log(result)
      alert(
        `🧾 Payment Amount: ${paymentAmountEth.toFixed(12)} ETH\n💰 Your Balance: ${balanceEth.toFixed(12)} ETH`
      );
  } catch (error) {
    console.error("Error reading contract:", error);
   alert('❌ Failed to fetch payment details');
  }
};
  
  return (
    <button
      className="w-full py-3 bg-indigo-600 text-white font-medium rounded-lg hover:bg-indigo-700 disabled:opacity-50"
      disabled={cartItems.length === 0 || isLoading}
      onClick={handlePayClick}
    >
      {isLoading ? "Processing..." : "Pay"}
    </button>
  );
}