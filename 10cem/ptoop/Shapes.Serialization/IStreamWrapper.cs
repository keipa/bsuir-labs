using System.IO;

namespace Shapes.Serialization
{
    public interface IStreamWrapper
    {
        Stream Wrap(Stream stream);

        Stream Unwrap(Stream stream);
    }
}
