using System.Collections.Generic;
using System.IO;

namespace Shapes.Serialization
{
    public class ShapeLoaderAdapter : IShapeLoader
    {
        private readonly IShapeLoader loader_;
        private readonly IStreamWrapper wrapper_;

        public ShapeLoaderAdapter(IShapeLoader loader, IStreamWrapper wrapper)
        {
            loader_ = loader;
            wrapper_ = wrapper;
        }

        public string FileExtension => "dat";

        public IEnumerable<IShape> Load(Stream stream)
        {
            using (var unwrappedStream = wrapper_.Unwrap(stream))
            {
                return loader_.Load(unwrappedStream);
            }
        }

        public void Save(Stream stream, IEnumerable<IShape> shapes)
        {
            using (var wrappedStream = wrapper_.Wrap(stream))
            {
                loader_.Save(wrappedStream, shapes);
            }
        }
    }
}