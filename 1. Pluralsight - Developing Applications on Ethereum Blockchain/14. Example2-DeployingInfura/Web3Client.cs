using Nethereum.ABI.Model;
using Nethereum.Contracts.Standards.ENS.ReverseRegistrar.ContractDefinition;
using Nethereum.Hex.HexTypes;
using Nethereum.RPC.Eth.DTOs;
using Nethereum.Web3;
using Nethereum.Web3.Accounts;
using System.Numerics;

namespace InfuraDeploy;

public class Web3Client : IWeb3Client
{
    private readonly Configuration _configuration;

    public Web3Client(Configuration configuration)
    {
        _configuration = configuration;
    }

    public async Task<BigInteger> GetBalance()
    {
        var chainId = _configuration.ChainId;
        var privateKey = _configuration.PrivateKey;
        var url = _configuration.Url;
        var account = new Account(privateKey, chainId);
        var web3 = new Web3(account, url);

        var balance = await web3.Eth.GetBalance.SendRequestAsync(account.Address);

        return balance.Value; 
    }

    public async Task<BigInteger> ReturnGasEstimate(Contract contract)
    {
        var chainId = _configuration.ChainId;
        var privateKey = _configuration.PrivateKey;
        var url = _configuration.Url;
        var account = new Account(privateKey, chainId);
        var web3 = new Web3(account, url);

        var constructorParams = new object[] { new string[] { "coffee", "tea" } };

        var gasEstimate = await web3.Eth.DeployContract.EstimateGasAsync(
                contract.Abi, contract.ByteCode, account.Address, constructorParams);

        return gasEstimate.Value; 
    }

    public async Task<TransactionReceipt> Deploy(Contract contract, BigInteger gasEstimate)
    {
        var chainId = _configuration.ChainId;
        var privateKey = _configuration.PrivateKey;
        var url = _configuration.Url;
        var account = new Account(privateKey, chainId);
        var web3 = new Web3(account, url);

        var constructorParams = new object[] { new string[] { "coffee", "tea" } };

        // Deploy contract and wait for receipt
        var receipt = await web3.Eth.DeployContract.SendRequestAndWaitForReceiptAsync(
            abi: contract.Abi,
            contractByteCode: contract.ByteCode, 
            from: account.Address, 
            gas: new HexBigInteger(gasEstimate),
            receiptRequestCancellationToken: null,
            values: constructorParams);

        return receipt; 
    }

    public async Task<BigInteger[]> GetVotes(Contract contract)
    {
        var chainId = _configuration.ChainId;
        var privateKey = _configuration.PrivateKey;
        var url = _configuration.Url;
        var account = new Account(privateKey, chainId);
        var web3 = new Web3(account, url);

        var deployedContract = web3.Eth.GetContract(contract.Abi, _configuration.ContractAddress);

        var getVotesFunction = deployedContract.GetFunction("getVotes");

        var result = await getVotesFunction.CallAsync<List<BigInteger>>();
        
        return result.ToArray(); 
    }

    public async Task Vote(Contract contract, string optionName)
    {
        var chainId = _configuration.ChainId;
        var privateKey = _configuration.PrivateKey;
        var url = _configuration.Url;
        var account = new Account(privateKey, chainId);
        var web3 = new Web3(account, url);

        var deployedContract = web3.Eth.GetContract(contract.Abi, _configuration.ContractAddress);

        var getVotesFunction = deployedContract.GetFunction("vote");

        //var gas = await getVotesFunction.EstimateGasAsync(account.Address, null, null, optionName);

        // Send transaction
        //var receipt = await getVotesFunction.SendTransactionAndWaitForReceiptAsync(
        //    account.Address,
        //    new HexBigInteger(300000),
        //    null, // value in ETH, if any
        //    null, // cancellation token
        //    optionName
        //);

        var voteMessage = new VoteFunctionMessage
        {
            OptionName = "coffee",
            FromAddress = account.Address,
            Gas = 300000
        };

        var handler = web3.Eth.GetContractTransactionHandler<VoteFunctionMessage>();
        var receipt = await handler.SendRequestAndWaitForReceiptAsync(_configuration.ContractAddress, voteMessage);
    }

    public async Task<BigInteger> GetNonce(Contract contract)
    {
        var chainId = _configuration.ChainId;
        var privateKey = _configuration.PrivateKey;
        var url = _configuration.Url;
        var account = new Account(privateKey, chainId);
        var web3 = new Web3(account, url);

        var nonce = await web3.Eth.Transactions.GetTransactionCount.SendRequestAsync(_configuration.AccountAddress); 

        return nonce;
    }
}
