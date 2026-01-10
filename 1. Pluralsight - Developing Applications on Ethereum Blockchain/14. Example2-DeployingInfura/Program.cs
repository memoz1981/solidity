using InfuraDeploy;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

var conf = new ConfigurationBuilder()
            .AddUserSecrets<Program>()  // Load secrets
            .Build();
// Setup DI
var services = new ServiceCollection();
var configuration = conf.GetSection("Configurations").Get<Configuration>(); 

services.AddSingleton(configuration);
services.AddSingleton<IWeb3Client, Web3Client>();
services.AddSingleton<IContractReader, ContractReader>();

var provider = services.BuildServiceProvider();

// Resolve service
var client = provider.GetRequiredService<IWeb3Client>();
var balance = await client.GetBalance();

var contractReader = provider.GetRequiredService<IContractReader>();
var contract = await contractReader.Read();

Console.WriteLine(balance);

//var gasEstimate = await client.ReturnGasEstimate(contract);

//Console.WriteLine(gasEstimate);

//var transactionReceipt = await client.Deploy(contract, gasEstimate);

//Console.WriteLine(transactionReceipt);

var votes = await client.GetVotes(contract);

Console.WriteLine(string.Join(',', votes));

var option = "coffee";

await client.Vote(contract, option);

var nonce = await client.GetNonce(contract);
Console.WriteLine(nonce);

