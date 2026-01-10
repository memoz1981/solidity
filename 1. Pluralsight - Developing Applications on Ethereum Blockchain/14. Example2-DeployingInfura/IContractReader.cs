namespace InfuraDeploy;

public interface IContractReader
{
    Task<Contract> Read(); 
}

public class ContractReader : IContractReader
{
    public async Task<Contract> Read()
    {
        var abi = await File.ReadAllTextAsync("Voter_sol_Voter.abi");
        var byteCode = await File.ReadAllTextAsync("Voter_sol_Voter.bin");
        
        if (!byteCode.StartsWith("0x")) 
            byteCode = $"0x{byteCode.Trim()}";

        return new Contract(abi, byteCode); 
    }
}
