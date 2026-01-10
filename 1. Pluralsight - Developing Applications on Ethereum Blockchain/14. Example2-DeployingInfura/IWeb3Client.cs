using Nethereum.RPC.Eth.DTOs;
using System.Numerics;

namespace InfuraDeploy;

public interface IWeb3Client
{
    Task<BigInteger> GetBalance();
    Task<BigInteger> ReturnGasEstimate(Contract contract);
    Task<TransactionReceipt> Deploy(Contract contract, BigInteger gasEstimate);
    Task<BigInteger[]> GetVotes(Contract contract);
    Task Vote(Contract contract, string option);
    Task<BigInteger> GetNonce(Contract contract);
}
