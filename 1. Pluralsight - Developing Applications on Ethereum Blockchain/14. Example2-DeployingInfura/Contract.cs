namespace InfuraDeploy;

public class Contract
{
    public Contract(string abi, string byteCode)
    {
        Abi = abi;
        ByteCode = byteCode;
    }

    public string Abi {  get; set; }
    public string ByteCode { get; set; }
}
