using System.IO;

namespace Shapes.Serialization.ThirdParty
{
    public interface IHash
    {
        int ByteLength { get; }

        byte[] Compute(Stream stream);
    }
}
