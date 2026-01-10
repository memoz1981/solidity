using Nethereum.ABI.FunctionEncoding.Attributes;
using Nethereum.Contracts;

namespace InfuraDeploy; 

[Function("vote")]
public class VoteFunctionMessage : FunctionMessage
{
    [Parameter("string", "optionName", 1)]
    public string OptionName { get; set; }
}
