using System.Collections.Generic;
using System.IO;
using System.Runtime.Serialization;

namespace Shapes.Serialization
{
    public class ShapeLoader : IShapeLoader
    {
        private readonly NetDataContractSerializer serializer_ = new NetDataContractSerializer();

        public string FileExtension => "xml";

        public IEnumerable<IShape> Load(Stream stream)
        {
            return serializer_.Deserialize(stream) as IEnumerable<IShape> ?? new IShape[0];
        }

        public void Save(Stream stream, IEnumerable<IShape> shapes)
        {
            serializer_.Serialize(stream, shapes);
        }
    } 
}
