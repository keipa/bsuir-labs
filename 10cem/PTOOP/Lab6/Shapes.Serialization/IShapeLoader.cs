using System.Collections.Generic;
using System.IO;

namespace Shapes.Serialization
{
    public interface IShapeLoader
    {
        string FileExtension { get; }

        IEnumerable<IShape> Load(Stream stream);

        void Save(Stream stream, IEnumerable<IShape> shapes);
    }
}
